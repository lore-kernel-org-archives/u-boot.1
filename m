Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEA8CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 10:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05E696083F;
	Thu,  8 Oct 2026 10:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3P_O_ALUD-71; Thu,  8 Oct 2026 10:32:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 49FDE60811
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791455530;
	b=p75bavlnzGw7rlZhvNi8SJJcDTXbZ1Y69vvCn/X4HLp3nPOrGkGmG/BMZuC3TrlPip0v
	 xYNZ/BhAHVcy6s+XsRPpK547TkkHN+rX8pE2mhNPYIILnSzGvIjYdRMVISoVFSaaL01la
	 2CK608+WYOxtiZB86FXNdo01oVIZIXfsqA36TWkLqRg0t66yCIR0gqBvLAA9oYWGrpmmK
	 +2+potww6B544GW0s+ddKWagkiVrsodZ76qEMKJ4Om7VxoO5ajdLyDqosWmxMi3tQ2V8x
	 69KvKY70x2LJIKGt9msWaNp97wGDhY/JSNxSFuPpk68ZOQlfS+iqQI3/J+vbBxP99QA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791455530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BA2CWi1kaUrXJtNmeLieOQuUwB7xBIw4Z7TuAofSSkc=;
	b=AFnZuPgYTCZvMLT++KsRdYe5xhSF5ElEdw2qbzT+lhNAImQSaOQyTx2J1gDPEZDJExib
	 jAV+njU/ezpnGUWMP2Pd9T0W7zEinTVY5alYLJBOr5Gt8AGCwk/3xttSWya9lTKWGCbh5
	 vmYhW7yyM45Xrf+STa8hsvCl/BkS9rEvTvmhoHB5Ri9dNJhdUAMRDOecaT2VhaG/tDFUO
	 GGApgMwTkw6RI6uxuXgV0R0qDmjyA6eK+03nyYKVyf3A7XGl86Rm8cCrzcPLlm4VlA8ND
	 4RLLdVK5Is9NUdmOOtgQ6zaNZeSlBhsGxl4chkDAzHrlTIeujQxkxZefbPx2oCXl/5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SisqavZR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LKcGUVk8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791455530;
	bh=BA2CWi1kaUrXJtNmeLieOQuUwB7xBIw4Z7TuAofSSkc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m4R4NLcPWxkIFgWra1TRGiFexCsSUQGGQN8/glci0QIMKE1LL9qChNwm29zpgYouu
	 9ZZkQquxQpcygE1tFWzp3yliTP8b9JMS9VNKyCzXEGvTT1gnCPxB7SQpkJR23e+qSr
	 /nEinZdeCq7HJBgjgvyLa4lhownlXHqq7PGkd4ZsZZrnxDUCJ9Ugi7FcsnGQT2ExmA
	 4YCs8zxzf2QSQ+EKMqmrH4TSSK4a4usx5bVZra+yhdpo2KttKk8pQjdBgy0NYp2VAe
	 j/zJhLcOhJ2c7rd+OUkUlQapOMC2vQG4ezlIDxt1RMUwFkqoFwevEpoy+Cmzu4sBby
	 HnWhsbNunMd0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49FDE60811;
	Thu,  8 Oct 2026 10:32:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A651E22F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C517606C5
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PubDJVDbIP0R for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 10:32:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CBB7E607FA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791455527;
 b=OvPgWC6D6UyZm1DZkhxHwe4TH1X86JBKPpTv8fIkDdA6Zpe31zcUzTlyRnp8BGtpvqYS
 6lPvH7WUDlHvJVX8CLMwNTJWzhw8JfMVQH/Va4fCryf1gkKpLTCD6kOmx6pSNiKmU1Mj2
 qsqzF/49dGzJXTE1kqSyhecrY3AtpEXvl8vGKFiXXjnZLAEfDyHhdmziAHt2npNKbN2lW
 bk/cnxUmw+ljF7m8t2fYfJuWekDi26RKJcWQVqaQVcP6zj7AWezvPk1daigd3xhbSuZw4
 Nz91vBwbIli5wKrte2O2uLNTv6Cg+zIDDNsoiIquxnCymeH1zJsqqtymw/diXatu9yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791455527;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=BA2CWi1kaUrXJtNmeLieOQuUwB7xBIw4Z7TuAofSSkc=;
 b=rg+0y6QpukmFsCXnjB+iL+qUfmkkLP8Y4F0E40LwIFoWj4aD/pUYMowHy89MnDKqFfv+
 YFI+xCNiyRWLmwu06o4XXEUoERHJP9ERe1SrWWh1qjisNzPlj9+ynzTUdrdIKM7r4UHe/
 gXmwzu3WQg02DCwbbbtT0tqxyNQK04Cj2WSze7A6vwtj/woP4t9/QHdVx+30gJyguk3xb
 xvs+mwt+jgs0QVyMA10f3n6LDt+pvqIREhA6InzalkuY7h+woqqGAI9Yb4t/EeqjoWZFl
 WcHXzHPoUXovay95zS51dcGxK6TbaSDlOOPNjhqSAQff4HjdII2J14aduP+rspJ1zwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=SisqavZR; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LKcGUVk8; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=SisqavZR; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LKcGUVk8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBB7E607FA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:07 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K4Eg2189850
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 10:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BA2CWi1kaUr
 XJtNmeLieOQuUwB7xBIw4Z7TuAofSSkc=; b=SisqavZRvMF/3NJnxslyUDzcMWy
 +SiJm65UbNoMfN3ZMqCEPvTWhhqblAabgsESsYZRczeIVJP4BNF3Kn7XeEUj22Kt
 QqW+U/4JeEB5NYhGv18lKAgpHCJWjZtj0n7bVBap0qXwKYigEXuH01kn71cwcrMr
 9wGhCX2MOyO9HB82WrB8bireWhCUCArkMHSUdfMylvPor/hRWwGbagWBMa2k6erE
 /oPKXIqI4xpGn+2GU2khzsjzgtN/EFIoubM8O56MgYp8a66YRe7EB+ZtI45+LeJt
 NNHmRnK6GE+3A7bem8FYlKEwLSuAb7dQSPbFC+rSHj6Lx61cJm4LoCkqUYg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3aeej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 10:32:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35158d674e1so7865231eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 03:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791455526; x=1792060326;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BA2CWi1kaUrXJtNmeLieOQuUwB7xBIw4Z7TuAofSSkc=;
 b=LKcGUVk8/D66TkOkClkso/NwzHMPuhdgERXvBtEgw51dsAPKjjb3M31R5bTeQkfxlq
 d2/zOBe2uRWFhbirFYsSymXUYZERoQAyoUvFUBn1lWCDLZcpuQbquM4uNiASFZMlC43L
 BBpblRNhjfz1CmUfzRoPHwo0IIa9ppykaze7uIBikSVdi5mcq2rd+zEbgXyGQkmQz48a
 R9PS1QkfrqhDQbX1+xWJTzh/WfF+eCr+Nd6kxfvjGfs/F6d4CaqoOmZYvvngP7Z8/IHR
 iwhI8e1wEbP4O5gr75iq66p/3FflBmIc3zF2gC9rPrydP3nP+SBpdaNGIsDXYs1D3riZ
 Vjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791455526; x=1792060326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BA2CWi1kaUrXJtNmeLieOQuUwB7xBIw4Z7TuAofSSkc=;
 b=wReuhw/rnBpPuVYEzTlVr1SsNAx63TrtzN/fFkuZiz90gUxuybWkwh0Vu6DJoTsGLz
 BgdIzoJkmuBYqE3Un2DRMaH5rHsZB3WlNusRiF9EPWkHBs3vTF2X9V/1OXx9VEEGJIGB
 LeXgbg8V1HEnqaK95WExmH41EZ2xpqdGgjO3Wsn2oe4aqjuQyM1ge7VVCnXopSbJzH8w
 ni6ZZvD/wzaiHdY9BpMj2s20fIr4LsCKKG4zKlAD+hmcg43sFYgBkjJMZLcbXDZx3w3g
 KgEFpXZolMm9u+cN1QcbmoIJRGi5+NNPLwH3jWe5DSLqlRqBnxkTrxLqxGPO/k2NIndm
 AnpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwj4iJbGVewWYQH/hPNw2BYM+8LWa6TL8q9j2bZYDHoG39+spiJjPsURTMwnrMBl8+E3n1X0Js=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nSGleXO2Y2BPbpoHKVaza/YiMRjFoJBJACQ/CjYZ4OPgVoMx9t
 6Hf+hpmRvH9azDMzumh9276g/oIPIsT/UHrZtI/RcxXUxFwiWotmC7/+qbVGt+j77UE2ntjLqas
 mVNWRX+/xgQrUrtt+EGbFqyV2mmCizX2j/8ptKMv6jIv3KlGVMwhSW1Ye+EpyyTTK1tXnYM0=
X-Gm-Gg: AYBFou2An9FB57ybrUWwJR4DbmEzqpx6miKv+ElmDC4t8D3o8mU56OiEFtQHcPfsRoC
 ioKrrBqxpqYCWHh7zDMkDL0w5VR8qbvikcdO5uYdpaSf5bmL32doCGP/X2632Fb8epU1fH1EiI/
 SeaduL7j1miGZCNbbg0o5p9HhXjJMFEMW3ct3BAULDp9Sfvm1XMv29ChanT0nMely/ayjXnu+Hf
 D5lOTMRK8wsg1nVGB9mHHj70GglgZ0yyXCWukwiRSRET/Bm/JgqTMtQl0ZM/U5bsxCHMvFoGvyk
 +bxgwQfgorjFkC2hB0Jqusaj0a++OxUU4h3jB0uXOjGZ2nBSp+OzE8MKwBCWIcf32C7V60AUouC
 aYG/XM56XMV35tGdRctdjbNPqy19eP0hdzZ0sLKpL3GEvF7cDHa7pJDTbATKgo/dimq24Wn1o1y
 dv037huaAts3/NDrNI6BU=
X-Received: by 2002:a05:7022:7f04:b0:15c:705f:b981 with SMTP id
 a92af1059eb24-16208809900mr6099890c88.32.1791455526169; 
 Thu, 08 Oct 2026 03:32:06 -0700 (PDT)
X-Received: by 2002:a05:7022:7f04:b0:15c:705f:b981 with SMTP id
 a92af1059eb24-16208809900mr6099855c88.32.1791455525515; 
 Thu, 08 Oct 2026 03:32:05 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16352800ed6sm10045156c88.9.2026.10.08.03.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 03:32:05 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, nathbappai@gmail.com,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 quic_timple@quicinc.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND v1 1/2] configs: qcom_defconfig: Enable
 CONFIG_SKIP_EARLY_DM
Date: Thu,  8 Oct 2026 16:01:45 +0530
Message-Id: <20261008103146.706211-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008103146.706211-1-aswin.murugan@oss.qualcomm.com>
References: <20261008103146.706211-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ac77126 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=0qtIWHj19sAmir4OP2QA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0MSBTYWx0ZWRfX8UwpVmC6RYvJ
 m/as8uqK5h86NPrzHJOf4lv2SnA79YtlSkE4del46OqUtOful/0xzj2W06y0SQXo1EN7tkuMLbs
 ZHGns3rNAlMegBIP+nbP+MfXcBecHkU=
X-Proofpoint-GUID: 7brdhCB-X6JIvR_2RmcL6gcDD1pqNAl_
X-Proofpoint-ORIG-GUID: 7brdhCB-X6JIvR_2RmcL6gcDD1pqNAl_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0MSBTYWx0ZWRfX0TZnXnH9llV6
 fYgCqSpsdTljSx3GCnpdOwGnPmKmjCl+K7/U/53UpmI7/euBQkQjGtI2QPKhYMacqWtz2KS3cc5
 FZfH4sUhnz8yQbdm1IzTWNyMa+F/g6p+7XptReFqVni4jLgNaiicAc1WGplZwj8gJeel/v4tdhD
 W78Ub6EZWQJiz1QX39D48X9aY8nV5yRRarQ/whNUyiwwCBZdmWILYmKzxMcxfqPyszhOIdVEyDT
 a9DIvaa1d/EBmMhW/PvJF25IsWH+DGALBjkm4RxxL3Kvtzp9qC594Pj/E/+hAR+UZrG2qQMFIWh
 jx1Fa+6xsV2hFgYzaFG63P2cSztxj2rpkS6s89rnFoWkoxhKi9uqHhocVlIlgw48m6o3YHHRBvu
 qhXelKl8XxqAaX2gr+YoGVw6bTIB9KNmdtbobspwXh9n6UDeNyRgBdBzLpzoKd1QdBZaHqxyQiy
 lxgEByxlV599D7KLvCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080041
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable CONFIG_SKIP_EARLY_DM to skip device model initialization during
pre-relocation phase, improving boot time by around 50% by deferring
device probing until after relocation.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 7d4a2b589aa..4713ced0939 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SKIP_EARLY_DM=y
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
 CONFIG_ARCH_SNAPDRAGON=y
-- 
2.34.1

