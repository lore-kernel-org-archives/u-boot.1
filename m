Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F673606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iMYpqfuM;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JtVu+nkX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DcmHFJvc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26F1680FF2;
	Thu, 29 Oct 2026 10:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mfqKj4MRC4_E; Thu, 29 Oct 2026 10:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A00880FE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271486;
	b=UDA9a6dllVtTK0K4vON2FbqmkDXH7qWE8/LePjWtSihu8rV1IAAaibYXad2z9E47/CVG
	 vllKgLgX4/I7WrrDFzEL0RwLFDUMavfLcHvoeUsxd220OfseiM8r5w7V+4ra5vx1/1anv
	 JxafqPRkN7ZMtBinK+nzqFPw4MZQv54TqvFME7T9NgZplCbQykliaNVbrUCFeWQRrawGk
	 csfxbE8PtPOZp2ivscSAisUsvK+kqPXA3WHW7HdfwaH822kLTMOatJLDDd9fMsnpUTN8h
	 HCAOlOrDTmcwxi5MJUel9Cy+ruw7T6vyaS1HG+zbO2tYmna3rhDErLp22aBjOiCUxmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	b=fMuVPsUeVBT4LDIf21uq6SZuAqsiOITNeAraUrt+qiO0JZ7icCWqZKrUpbIU32+SpR9P
	 uwyXrqB+OPGlVJj4WDplJmIK+QlCQDol3g+0huFdr8baFwdEmrC3W2/XHWeh3s6Us0PDG
	 gD13oCm1rHaNgykis/swfSiD775tnqOLbzV4BMy5imhbv25NBAdZlYV3Z5qJpNixO76tY
	 090HEmVQt3e+n8elyfxrzvSxcGFZyP9aABcjvXZeVEmW2sbU34ipsIxbG/mfnKsWlAt+S
	 n+mQBFaAcUAPtJ5hAn1H6/crgdX8L+E7I8pHXdHl6fxL3dm0UqNVsq4VygIgzU6igYw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271486;
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iMYpqfuMVwybfMJ1HTXhwu0SXL9QK2wJ/zs+FUB7CtxskDX+fFd8OnbPDRNEwTvhO
	 feYARC6BA2EC6STL10kN2tgpdGUYH0pdz8U735s8A/CjGA12SGAIbhzVboVwB6HJmv
	 cCk5hrjgmLjuuOdYUzko7gTxLr4N+yfoCu8IZTLNBVKyPkjgG8bZ2rrBHFH3o6oJst
	 MMg0MuYSF81EObtWG9ZVSDvIO/DoPsjgZJIwb6Tw9Lzb/80lhCCM3kbNquUmtBZ6mf
	 aLpM2ZT6QpmBhexThCrFkOUDbrWPAtwWC2Exp33IuSYJ9bg+iKHF+r7P9NzYG7qb0/
	 nfuiBCNAN1vNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A00880FE8;
	Thu, 29 Oct 2026 10:58:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D4A4D22
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6ABAD4032E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZ3CZCRH_XsB for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:57:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A77AF40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271477;
 b=QjFX1uqmfKbNaukbdTaLqyLYbZnlp3Ip0zmEF5Gw85a6MJVSxU8b++h2v8g+R/PT3wmu
 l+8ENNGAkl2jMWHMSvvSAi/tjnCS/EER1XkPv54e7Ajr6ltXvjlQ03WmD1XpGw6uJOL/r
 K5RksLBobFTgBqNCU+OGGgl7JJHg/6/BdBbeoNq7IyDKpVY3Di8hbgznSGiRWJY/6vzDm
 exR7r281eMDiw3rfKlHHozh0pt9UPxKAaBGP/oVfZ2TpDwvFiKjfZtBM4aXNXiin2LUf9
 sjGt1GEAvkCt4aZkWzcg4DpDxauFZgxJ3oJ7TNU5tVo7R1rPcAQrCfCVpW8+sYc+2NA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271477;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=IvvaHM3MwANpeAkChKCWCR8IoXSf6bf8VVrJND4sDQFbN/vsxDzCw390+sU4apJq8Mjj
 ncqTNG6pR3ymH3ayM1Mb23iuXmFbvYrn7TpeXu2tVn4sjzSzNVRw3LNNKBAJut19TdQe1
 O7IK/dus57LVoJ2c6S6tZ8pjw8as3K1664e6Xo79DPqV2qxXxBAeMjnixubBrW7k31ea4
 azMQi2PnGwpNDKyD89mnqjF/ouYgNuacpKgEgHIVNvk32Iu7Ck1dKA37l14y23qU+7+++
 zmIznlfQ5/BLCojfPziNSOb8eZB34OtoUIEU6/tUxMpBKIYJ3ZGnAAatq61f2diy9LQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=JtVu+nkX; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DcmHFJvc; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=JtVu+nkX; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DcmHFJvc
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A77AF40024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vtBV3279782
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8k212rEkKH7
 as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=; b=JtVu+nkXRjlGdXe4CKCrM4DpyKo
 DkxWNMr4jwl7TRwQjs5/6uUiKbMBaL66j7aB0LtGansNDS2v4Gl5WNiEQ4+aetxY
 pjjEfVavWpqvoNJO39tX7WZAlfofTrxdpInZqHRpHLGMjdMmTucDXWgrOFduUpd/
 7Kh4SPRd6yYFP6ANepkUeUd2iosCoc17ywQlunowGeuRza1b0G38tNdCqrm3DZp3
 LSNPz/NXCm+BwDPsp+YvmLy+qKwfwYmpqCyS22MLpy/p/fMeS1JL+AU55W/PMwt5
 QBhPCvz4GcyBxc8tBZ1FUAe0mEgUIm3Trjf+ohCsci/J32s+DfSKEzcjIKQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hks3nan8j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:56 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so2136567c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271476; x=1793876276;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=DcmHFJvcCzJU1/1JuwLBRXwIZOgrUFyqJoyynXzYlOq/QlHBQRCTzCKbJPbyJETXPG
 oPs30OlK8qqKaHuyn3f4KpGCW/42Yv5eUWbCQLiQaVRsecGVSvlWeZgcIR1Q/R8tB0ij
 nryBeWdPOhSQmzHWJ4MS1jjao0pvMymU6NIqng1ryrMKSza5Q5l0WmkAOIqN7q9NlnoD
 UyIuynoAvYVlFMsY2w7DSpiRyq61rWforHejVwzmFzFlmweLQCuOX37dUSBmgBh39OgB
 z6Id1bQJrHntJtNSQNy0wl5uLip3r6HqrN71YcrTqc2hnsF9SEDewgW9Rbf9kC6B8FWw
 wkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271476; x=1793876276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=r4c+R6B80aF3kguDk7j5/tOyU1x+qQxjDDI7HZpUrjab0GK8OWD153HKd9iyxt6t4K
 wBNqN7AO39D6AILWKGbVDU4IdImNCx+8SLPc+enCmKFdbZpSbomaR34cbgqGlb20EA/q
 i2k8GsfozeamkrDBVudUH2Nn2N9m/IVbK3mPYvFQsHAO8SIdADqo6ezbUy3LNWP+s1MV
 pO3DwAGgJ6dw/fFHW8xRRbBV3+pHnivcM4L/R+Vu+HPz2MjZQsWs57Wx+5mjV3za2OGt
 ubP5/VnQ1Eb83HBqlQya1I8xOHuJM5Pbk1PtjFXn4PgNeFj13R/gcHircMu7oePnrsDy
 a9IQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsOCE3KJkRcPs++H9k9BLHCDH83cK426iFbX8zZOVm6hbGJxVL54FvYfaD2aBk+hrQDeSg8Io=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIg+EDt13qZLqsGwsu/FtAPW+eh1OJ0KL5CTjBQyFD7R0sUT/so
 8eECunQCnzM0gOVEoF9rD/ZU3xT/Xexm204y6wPhXw64av+RmRrlBXkh02WXpGvvaey0kfoIyIW
 6n6dG/yvg81EqwoZM2em6WMlkKrthjrXp0KCOhlLnVivKITC6Gww3bYWrmwSQ5yMCLrLpKyM=
X-Gm-Gg: AYBFou232FS/16WqorMpgKTW7XegnTEfXhG/p3sbDcc/a2M5Nt0n6B0tLHzGIN2K80q
 phDIhmBFP7ITh1QoT9ux3415sjoPkCBS2wbyiSc1Ge8METyvDTWOMQcdQgRP/cSU+gERog7q/2C
 0CacScv1qrmCN6pgtPGbCaUkrFMsVmen4ys4bP65MeL+CkI8OLb/SsoqmiYvFaVpiV52tDW5Y0m
 Gxa4t8xFDGuVU3I14z+YYBWZ5VDYOJubFpFEkaG3X4B8vo0foDONDSKiyezoCELNMnpPonV/Lpw
 Kn90e26cKcEDx7AgcxBJq6Zrd26p/KiQE9C1NxHM+1BxtR7AXZ1DI05NRuWSRzpzjzhj+3eY9Yn
 patRKajlF677pHpxGg4n0xCWpAndG0YFYWOiDWuLqeASih6W4CeMLHwuhDiRjGr1Ez9P/bXgvLJ
 RP5OMxLDwi7Q5yznI6ItF9Rw==
X-Received: by 2002:a05:7022:296:20b0:169:3706:d61b with SMTP id
 a92af1059eb24-1a6cbf74472mr6541074c88.16.1793271475764; 
 Thu, 29 Oct 2026 03:57:55 -0700 (PDT)
X-Received: by 2002:a05:7022:296:20b0:169:3706:d61b with SMTP id
 a92af1059eb24-1a6cbf74472mr6541031c88.16.1793271474991; 
 Thu, 29 Oct 2026 03:57:54 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:57:54 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 04/13] clk: qcom: add configurable FSM-voted PLL helper
Date: Thu, 29 Oct 2026 03:57:37 -0700
Message-Id: <20261029105746.3487456-5-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LKrFJsd6v7QJrLZyydBeJ4qaB2BG1ZCB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX/BoR5e3wD3uM
 rMdhd5u1S6GdU56y686BnGWtPmYm20GZzKtHn772hlaRlYZ8g/ccD8KuV+s1NUE7bRJrOUWt8Tu
 ojZ0A0SiqW02krY53MNSBqSNkvtyJXqP73/3Odxyux72iCPGBLdVohIcM7vzOqN6Qd4ornBe4Py
 vZl02XUm4icVO2CBtFbFOQq44rnXzt1dPfnxJ1GwWoqMZuHVG6iBwh1kLPueJY9NcvvtAmSdIek
 0w6POJ1q9O8ZreR6dy6fsg25zM4MGU01MrSzi2ACEvOo9cd6cwc+jQ7rbWAXirSC3XmhEcEUHXj
 cY495EnyLdFKqs2mM0z4wi983tMyaM7HeOhNajZL3HJdJbmDNW7tRqwGWXBVAC8yQjOC+/Piz10
 c1hUWwrxS1xp3yl8lp1uR/zl4UMcvqbwFcQxL0m4fbWFBZVz2yLZC8b1TEdRKkqJUx0T49TZDec
 WO8sXxyfXvmSfwYgPpw==
X-Proofpoint-GUID: LKrFJsd6v7QJrLZyydBeJ4qaB2BG1ZCB
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ae326b4 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=enMxUgKZn3LVR2H3xcYA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX0aGWGacvxg3V
 kIqMwdBwuDhorwxPKwb/OKtvhAK1NWy7x/4nUAktouw0NoFZlrcyIBkrxHAHPFhWHOmINCxOfuL
 Eao9piVVjlmyEj6mVFiXUsBvEF5u2gI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a reusable helper to configure and vote for Alpha PLLs
controlled by the GCC vote FSM. Per-PLL register offsets
support targets with different PLL layouts.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.c | 48 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h | 24 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..30127c1fffe 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -59,6 +59,54 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0)
 		;
 }
 
+#define PLL_MODE_ACTIVE_FLAG	BIT(30)
+#define PLL_MODE_BIAS_COUNT	GENMASK(19, 14)
+#define PLL_MODE_LOCK_COUNT	GENMASK(13, 8)
+#define PLL_MODE_VOTE_FSM_ENA	BIT(20)
+
+#define PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+#define PLL_MODE_LOCK_COUNT_VAL	(0x0 << 8)
+
+#define PLL_LOCK_TIMEOUT_US	200
+
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll)
+{
+	u32 mode = readl(base + pll->mode_reg);
+	unsigned int count;
+
+	if ((mode & PLL_MODE_VOTE_FSM_ENA) &&
+	    (readl(base + pll->ena_vote) & pll->vote_bit) == pll->vote_bit &&
+	    (mode & PLL_MODE_ACTIVE_FLAG))
+		return;
+
+	writel(0, base + pll->mode_reg);
+	writel(pll->user_ctl_u, base + pll->mode_reg + pll->user_ctl_u_offset);
+	writel(pll->config_ctl, base + pll->mode_reg + pll->config_ctl_offset);
+	writel(pll->test_ctl, base + pll->mode_reg + pll->test_ctl_offset);
+	writel(pll->test_ctl_u, base + pll->mode_reg + pll->test_ctl_u_offset);
+	writel(pll->user_ctl, base + pll->mode_reg + pll->user_ctl_offset);
+	writel(pll->l_val, base + pll->mode_reg + pll->l_val_offset);
+	writel(pll->alpha_val, base + pll->mode_reg + pll->alpha_val_offset);
+	writel(pll->alpha_val_u, base + pll->mode_reg + pll->alpha_val_u_offset);
+
+	mode &= ~(PLL_MODE_BIAS_COUNT | PLL_MODE_LOCK_COUNT);
+	mode |= PLL_MODE_BIAS_COUNT_VAL | PLL_MODE_LOCK_COUNT_VAL |
+		PLL_MODE_VOTE_FSM_ENA;
+	writel(mode, base + pll->mode_reg);
+
+	setbits_le32(base + pll->ena_vote, pll->vote_bit);
+
+	for (count = 0; count < PLL_LOCK_TIMEOUT_US; count++) {
+		if (readl(base + pll->mode_reg) & PLL_MODE_ACTIVE_FLAG)
+			return;
+		udelay(1);
+	}
+
+	WARN(count == PLL_LOCK_TIMEOUT_US,
+	     "PLL @ %#llx [%#010x] never locked\n",
+	     base + pll->mode_reg, readl(base + pll->mode_reg));
+}
+
 #define BRANCH_ON_VAL (0)
 #define BRANCH_NOC_FSM_ON_VAL BIT(29)
 #define BRANCH_CHECK_MASK GENMASK(31, 28)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 9899cd28aad..47930ae9d5e 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -36,6 +36,29 @@ struct pll_vote_clk {
 	int vote_bit;
 };
 
+/* Configuration for an FSM-voteable Alpha PLL. */
+struct pll_config {
+	uintptr_t mode_reg;
+	uintptr_t ena_vote;
+	u32 vote_bit;
+	u32 l_val;
+	u32 alpha_val;
+	u32 alpha_val_u;
+	u32 user_ctl;
+	u32 user_ctl_u;
+	u32 config_ctl;
+	u32 test_ctl;
+	u32 test_ctl_u;
+	u32 l_val_offset;
+	u32 alpha_val_offset;
+	u32 alpha_val_u_offset;
+	u32 test_ctl_offset;
+	u32 test_ctl_u_offset;
+	u32 user_ctl_offset;
+	u32 user_ctl_u_offset;
+	u32 config_ctl_offset;
+};
+
 struct vote_clk {
 	uintptr_t cbcr_reg;
 	uintptr_t ena_vote;
@@ -107,6 +130,7 @@ struct msm_clk_priv {
 
 int qcom_cc_bind(struct udevice *parent);
 void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
-- 
2.34.1

