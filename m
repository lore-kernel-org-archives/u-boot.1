Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEB9CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 12:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D6198123F;
	Fri,  9 Oct 2026 12:28:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9zM30RCyrLX; Fri,  9 Oct 2026 12:28:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9C6BD81255
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548897;
	b=S/bCdkn5sgoPUDrvpEVNKxGuA0/ekO7U8Kfftz5qIzK//hAgU6EzX5kzZywxpS2XdkMj
	 7MtBQAnC+yUBErvb2zwhG8mU26MPOFZj2Qc83A9+3VcNSx/Ev9r5HlpyoQhxj6Zd92mE+
	 L3068OMzCDxlG9+OMKBQ16WdJBzWUfqYSw+FQvShuXUPoQozyfRUHRL9RI7yBYd55PedP
	 mjJfr8WF4nQKfiAjHhZJSeHatGfZBATq513i1vo/n5fscoQIqVbycj9j0XSatxZsGrEtG
	 A0hAIi621WTnJO1oMoGbPjP/HMB+HC/DEeTapNmsVS84BWs+VgynKZw4KqoCyCHC3KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zX0eTiC8/v3MHwt0aUjbKLX/G+MBEO5uvaU5vGkZH8k=;
	b=MqbGWlErtke4GLowkgt/XK0d5SIeOOKPIuXhbAtK4fU725kbuo+QIdodP/pUJIBVnRKy
	 QTsx8o/KpKkrIHzAMKn+Pqb53P4BUMC9WhVU0964kJ2K4zR2XdU+LfWFOgfwDMyFl45kr
	 sCR5fbVPQF2kncZPpKe3C/mTrAuqBJkEBXquyYZic0QhrNgJtlpsGaekhitNmIIlGoHFn
	 nnAX6vdsel9l5bxTXmCWCR24Bditwade/li7N62RDv9SSoE0vbQtwqZ97cZ8IHShWBgYL
	 H8q9bSsJZHgld9B7IBGnS4ruy9Q1IRXuW9CN5RJXwSaGqKwV9zzxEaU/ecIn8WmIpLA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791548897;
	bh=zX0eTiC8/v3MHwt0aUjbKLX/G+MBEO5uvaU5vGkZH8k=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dIi8fUW4tj7a8JgKlM4sA6ytLpdMnPnvqUx4tE+kruciwAkb8PYJTIAGYHco/kiAc
	 doyvYiLOwuPxwwm77hM0AJPt3216/SsPW1JCj2sMKzhwgLmxz5Zx3qDDmQEbnKISZl
	 u3o1FAkeg91ePOpydH/ugP41K0snVBo7iGbh7ZNAlSsz4HV1HMRDLVv0v83Q0MJKCy
	 3Dh1b+U7MafSnTXZsskHVd0kr5lxLWJ+mGphP01zEfum4k4ka3OEGKDxWL5t3j7DZh
	 wFVAucADCQj6GuLi40HzMXdXOYSNCOTLpxFrEGGWonipXHMVNuzA2SDiHhmDCUvhbK
	 dYl2gRxpmGh1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C6BD81255;
	Fri,  9 Oct 2026 12:28:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92DF975
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90D1640098
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:28:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0l571sgpD7e for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:28:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 90A7240061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548895;
 b=qA7Fa5F3W2hqFVR5CJ2mqioMYhEPkgHks2imLwvBdmiqv9bu6yVGvO4sgGF8fatVDhCq
 tfagnRnZk7Ll57dqK8mj94kBY+T2w/AEgKpLVP2fGepuQFpgHGZV8MYsWMdD0sCQ28BKZ
 QwALBEoVrE8xVJkFHiflori5RKaypG0nvnFgQyC+Ie4qQ15X8fVv7Mx6sjQh8V5VXsNTz
 zWeRL7Dbkhkgyjn8vAC+pMweJZKFw1UQoYiXRzbHe389CLLFsT+PQ46toua6iVAVS7YMT
 iq2UMgyErmNYDCGUjDC1nUYmSWeX0d8buQVlK3V7zPy60eXdDfuuw845m2mJtnfzC9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548895;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=zX0eTiC8/v3MHwt0aUjbKLX/G+MBEO5uvaU5vGkZH8k=;
 b=KJT6vOWbQ/6P95J6cqHN+v95LUeVrHTqDUXx3ED2Vucd/ApgAOk0jQBqTZT/lCocTsxU
 Xgy2mCQiSRaPMtaIHazonnPacUlhiMW8c2/ySQhGaHshciN6dAad3lkF9GaL1JRTZvazM
 p0QPAvShEJgRyDm/Ssn6Tu+ddhNAhLHYfIVrgUjEkq8iywI0tqqaLflbfIL5O8kwECtDw
 tdvO87EDhly4BGdXNvTUey6xTZEflUoWP2zQDpY6u5jAxlz0t99arH35N4I0F/fW3AJZm
 TH4lvfJpTwJ2VQ/k7+jKd5QgD+buplkTZxXr9aFu/lbT6Ey20/y3iBkkFQI0mrR6KZQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Lhnoq5++; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GhgPHKlx; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lhnoq5++; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GhgPHKlx
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90A7240061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:28:15 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KImF1746837
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 12:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zX0eTiC8/v3
 MHwt0aUjbKLX/G+MBEO5uvaU5vGkZH8k=; b=Lhnoq5++fcLJ7TxhMOzc+F9/NRq
 GCzfjd9yMOzPIqFjevo8ZHsEiHJ8tvZrLTJAOUDJuM4aVLT4+mM/Z8GcEEdzLzE/
 w0Kqh2tMphFGWpla55F/j8zZ21C1L9oPjczldH6JJ+eXYqrJjT9vrcnPzW6Decmb
 /78/K6TPfEhHM6jeyVzc4P2v2UqQLarVBWIadL2fX4pVgnzeLH3ttOCLDZaMxDe9
 F+6NKqRmoirQqasq3rEyrgRVRW3EqQ8ZXxtf94ldosoi33teNlJKTzkXZWXTIIUS
 WngbUDbUXXeFOkBQDv1k0VAAX9ojiFgTRn53EEtnlk1t1n4eo4UUabUQ7Ng==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvbtdj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:28:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d5dbso1306543a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791548893; x=1792153693;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zX0eTiC8/v3MHwt0aUjbKLX/G+MBEO5uvaU5vGkZH8k=;
 b=GhgPHKlxlgkF+FWWvsFXmbjR7QZc3gnjSuEcdhrnGOuD4UsvqyHQp5URn5D6+vLFzQ
 lVZyQHGucQ8IAcHEMMDE3UT4JN2OMDYH+mmVMp4C3Lc7SV6BQHTKD/0SaOoFqKGyNr4H
 PNQ9NLK+ZA7rpWmhzl+auNmk7nWWjDnADs4vEjT5YTepgp9HU5AgpJYBCby27Pgq7qfG
 Hn4TBFGHzQWjlUMFzt4AF5mGKOj6IhbvOsOze4pJlqWMf/zQLmefv/4Yg2QnsY9zh17H
 3i2sURRShrJRx1VPm9a1INV44cKh4zsYRIgQPED+RYEWI5Kz/hpwu55a+njZWVFrPf2k
 DUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791548893; x=1792153693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zX0eTiC8/v3MHwt0aUjbKLX/G+MBEO5uvaU5vGkZH8k=;
 b=CF5dFpkwWLxcHNQE2oD+zFSevV3YePzmfFCVAXKKFllkui8mQGiiNWjRKXzIJI8lgM
 tyZ+8PYRMy1J6XBgJMWuMoMuD4pcBz7Swmw1/UrXXo6yQsTQVWb2LgEUx5CXeK5dAOX2
 zULUtn4beeupWbFgmY+Ntx89fL6iBSOx5ubS0YI033xXbe1t+KRAWZsVlaKiht/9Yicr
 f4Za9FXOby0I0oX4TU10dcXMQj7WGzMPPgwtwoFFq8Ph+Cj87JXP9Nu8Mwaadq/fUhkC
 xMn22js8n92/xNNQix6c7TItBdjPzagpzMkI0ry9W7ib9YmW1F62uXkveYXd343WNwFi
 rRMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfgYwN6bk+duazVQOFHtX4f2uaSxFSK1ZGj/9z5/uKfQS/bzcpNK5ppjxxUUVOAlGQWwcpcZ8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLOPNWR8nlsh5j1AkLZLZFtiOH350Gf89nENRxV8IGHUWZUMeMO
 lHqbaP4D7RUGvZPxuBgO3Q4H2kFFVqHpcD9rc2YNDuxlmmk10krB1DWamefOeeh1MOEMeVj5I4W
 aDY81MHDqshVU3/ryg20oOlK9s+TSnV5UdYOTkR0USpqFoHjBf3w10VCtfy7YoHy8bFfcH3A=
X-Gm-Gg: AYBFou2lgFGJpnMspoyS4JEjVCy/YhIUKNvdl/g3gNBK2aPkYr865Hlkn2W0tKEhLGT
 5P69A8LK7mVWMgXB2o0aEhD7yc3sRDTmzPF9nTF2fLxaAQh9+JVFHI8wnSGtYCNi3XMZmv2RQuB
 8UYtma1g7UplxKgTllypTRpUTXMPrH6RHNRXO4VcoVO0d8GJg8mBiTzWbEcXaT+b0SGhbTd39ge
 eGR37x+mbUrCX7ZoSc97Jqk2u3yiOfd4z3BiiQ4Cw0SCpi1QISuF5kkjMOnbPUJ6qe8L+/AV4MD
 zGQe7ICCQ6SSN/YAg263w/UnsZW8tyytanXnKQikJbfqikVOre0tdzGHKxQszxGP0LoYS5ExUC6
 nnCT3ZfJr9nFNDFKEjss4FIHE7JUHEX8bsf6asx1XUrO3JsKPmAlO8lCl4WfTnUBuYCVcPOjOcp
 4PM0wdjZVdfJmD/IlUiBk=
X-Received: by 2002:a17:90b:4fcb:b0:3a6:dc2f:f07f with SMTP id
 98e67ed59e1d1-3ab3a609f14mr1645387a91.10.1791548892959; 
 Fri, 09 Oct 2026 05:28:12 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcb:b0:3a6:dc2f:f07f with SMTP id
 98e67ed59e1d1-3ab3a609f14mr1645366a91.10.1791548892492; 
 Fri, 09 Oct 2026 05:28:12 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371b2f2bsm3399497a91.15.2026.10.09.05.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:28:12 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, badhrinath.s@oss.qualcomm.com,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 xerikasxx@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v7 4/4] configs: Add defconfig for ipq9650 RDP488
Date: Fri,  9 Oct 2026 17:57:36 +0530
Message-Id: <20261009122736.1185878-5-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com>
References: <20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wL38oqjbqJLsgm6vKjM1AYo8KsY_MPp2
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8ddde cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=UuI9o3pZbsgdCeA7RPUA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OSBTYWx0ZWRfX3LKkSLkckQFs
 GtP2LYu4EFupyw3N6iGObiNbDP+Zph+FvidmLv6QPxVQdYYt8V9tkO9oMnfDKlBW5GWyL7M0KmO
 0W7zq/VitxbxffhTEsqWRgR9+HGU4KtZKiiBlAsPT2pZXZIxPAFW1AGLJWscVLtixguWyz5XOqg
 XuIzQyadxWVl9xScWEafRWuRxBIoALIXCiWaP6j9XcKlh0sv9/QuL8iSQFDyg2ae1XNp9n3glo0
 ScRmdyGg3TlJOJd2swKfSqFSMGEnJWSTAauALZZWotd4EByyPr0X9BckQskaVKGn8Q+fM1aHwSu
 NnmhbDOw4qpbwG1zeJ4RyIBHvuwl82fcL5c/UHKCwVwon05ioSP2nnfsOe23v1CJZ1rwcy7ycZK
 DZWeENeoayCGA0Em6QvhU2vOn6g5LT7vJPJc85zaxiGQmLhM1UfHAGubvJ7PeduJ/+ijzISek8f
 ePBkRYep6oADHahlI+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OSBTYWx0ZWRfXwwiUlADN+7LZ
 fviuCe+ySlAmMi6pkBe5dDKFJtATaQEiJgSbyrc85tz7PmoAuHtORyQLijXv7976iEtZuQhj0lK
 1RCdKxtfgyYPUMpiXT3f+63J3BusLAQ=
X-Proofpoint-GUID: wL38oqjbqJLsgm6vKjM1AYo8KsY_MPp2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090049
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

Add default configuration for the IPQ9650 RDP488 board with eMMC boot
support.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 configs/qcom_ipq.config            | 36 ++++++++++++++++++++++++++++++
 configs/qcom_ipq9650_mmc_defconfig | 18 +++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 configs/qcom_ipq.config
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig

diff --git a/configs/qcom_ipq.config b/configs/qcom_ipq.config
new file mode 100644
index 000000000000..e649b07cdb2b
--- /dev/null
+++ b/configs/qcom_ipq.config
@@ -0,0 +1,36 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_USE_PREBOOT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_PART=y
+CONFIG_OF_LIVE=y
+CONFIG_CLK=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_QCOM=y
+CONFIG_RGMII=y
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+
diff --git a/configs/qcom_ipq9650_mmc_defconfig b/configs/qcom_ipq9650_mmc_defconfig
new file mode 100644
index 000000000000..9438f4844d37
--- /dev/null
+++ b/configs/qcom_ipq9650_mmc_defconfig
@@ -0,0 +1,18 @@
+#include "qcom_ipq.config"
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_TEXT_BASE=0x8a280000
+CONFIG_NR_DRAM_BANKS=24
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9650-rdp488"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_SYS_PBSIZE=1024
+CONFIG_CLK_QCOM_IPQ9650=y
+CONFIG_CMD_MMC=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PINCTRL_QCOM_IPQ9650=y
+CONFIG_SYS_MALLOC_LEN=0xC0000
+
-- 
2.34.1

