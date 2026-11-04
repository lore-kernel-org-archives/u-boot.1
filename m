Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F741606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jvs3UOu/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QHW8/bTK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PB/BhQgA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 220D480F58;
	Wed,  4 Nov 2026 13:31:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id toh8het9nd38; Wed,  4 Nov 2026 13:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5361180F5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793799080;
	b=Rg7/wovyDAcUWJ9ioKM/U4Tawa9pbth9MSAQGPzpHfZ963ywbwmF8dkMbzNVHsR9akVT
	 U8b2L4ZUhBl2eb8gQ8ywNK2qp/7qskewXdE3JpUDMRFWDOUWfLM4jycYS6CL+pQw4vFhK
	 HZvAg4Pm2wxhYmaAgw5yt8FqD+7xD3c8HANgPNhW0kuAZLIzb1NzwFPon8BregkmE5PXo
	 3QOXrHia6LAT7LQKxCo9se49DeyZrnBJysCx5y4C392pSQdCOaENAGXwwJTYHo9a2b+WA
	 ofPnIZvLYWziqikqOMGXPOwIWmSbn2gPqM+fuwFvbIaJwpVXng2Fgkd4t2bxXfe8CIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793799080;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ovu0sdxHDf84rymhudcLdLCWtYKmczHLPgfA9J7MlSk=;
	b=F2umBjp1UmKjs5ODI8I1CB4ydfP0roX69PbgUms2i4DqKw6CqHXe3tX8RM6/9om0gkVw
	 y3dRYSFFcB7F3zIrfe/2skDqP8JlNlgC4YM1zg1kaM6ulXGEYYq8LJAvZWfsQ1aMUt199
	 6TgwcTDRcC0Pvbq59NKcTX7GcIb+KDQ8oO65SMJ4MS4uQuKdAGLcy/PTAQZrPNn0jJvdf
	 LMMEtiQ8yqDI6YR+ogBsclFzW948BpXmFrrwW1EBWweW1D2lkCL/rHkOx5Rba+rs8+wcd
	 JqbK1In8xNFMeaG7Gs3wdsguUiqnvsvPLNdzVopRSLG52OpEL7gYUSzYL3Rtajp6EtA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793799080;
	bh=Ovu0sdxHDf84rymhudcLdLCWtYKmczHLPgfA9J7MlSk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jvs3UOu/EuHhGrOq3grJYPJI+TAFZDUo+xUOWQKWGYR9f9x33u6jdezstzylYZtzG
	 fsoh0oKsOa/MnKzn31N1qhUzO3qnpusuhtIRoveA7C2WTDUwM+7Zdl4VEsjRKOgEal
	 m/NP9lrjUVwVUMuZhWGufnXIa1t+hH2yAbkVWC/qLdwV39ZWk6WcW7828Xv76pUu4T
	 GkrCdz8FPW6AJQSyEsk2WiWRXysnBre2PBc5zEds0f1ZxKf2iGCxzcmG7+hrCe7od5
	 8zarqlXXrtQnYyBs6LTWwLRTGFb2kHwVZRPdz+QfY6mlStXLLF4FXlKRGgJYm6gfeg
	 b4OD2+yfnitAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5361180F5C;
	Wed,  4 Nov 2026 13:31:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E2D59C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6028B40566
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:50:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uH_gIVdmSZQo for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:50:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B505C40740
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785839;
 b=AEKNTtxYj6X4qtsnc2Sx/hbL342wsswcJ8xgvnFSBUsx8FtiuCbGh5CR1E6sZKQs45zB
 G+5HP+D0c824mO/4gk11EIHetZG+DFqW8aQnm3ohyL2TKx7gkJxKnAk/F/G7Mrq92HlwK
 pZ7U+LKa4aViVijlZUFB5KFN6SRaexh7vp942f1HWdvIWBPfhSKDEadyEubDBngzTVllU
 EtCTzvfwi8DBecRpLhKmoUhhT4gICrstceUPlQUihzat8fknqjlS2I6v3fQ3xlh6jfAA4
 ex9D9Xm1FuXevppwO1sWl+NYBUYgU/TVUMazPp/aGR+AcJ5LwAxHNzqDlbARODMyXPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785839;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Ovu0sdxHDf84rymhudcLdLCWtYKmczHLPgfA9J7MlSk=;
 b=gd0UBXPwEJRRIwmGxp5v9XJ2UpnQGbUPBApcsLp/UuwU4lyzsjveIfIczzcpfVm5h8qI
 kzR97ULPLBbrwKEa3V44Xx7wSEWA8bpT2eJ6zRsrf8hHNmZNpDHrR2QomezmD4A3/vRMk
 Sm0aBI+8v+X2aEbY5SUnaKhNLBWBbEEt9/vF0oudzn1y/52Qy3Kci5brVfyy4yD08u5s3
 JYGL0S7CqBoPu3F9fNqohsvsCt7PquZF6em+vQIknDyKEDxxXMusu79qGUDMSr/Pjse3s
 ZbuhZaBzZIRmrfeFYMsOt71SlF91t6+1x+B5X69mK1BhSpR/OcE3IFGHEyOti1OdNsQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="QHW8/bTK"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="PB/BhQgA"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=deepak.g10@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=QHW8/bTK; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PB/BhQgA
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B505C40740
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:50:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A48KnMh175533
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 09:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Ovu0sdxHDf84rymhudcLdL
 CWtYKmczHLPgfA9J7MlSk=; b=QHW8/bTKr0NUVVSQLO2K3vt1P+pNOpH+KfcFl6
 2ut9rm3cMiCoNrg6EcCWMOuj5f6/16zcsYbwWFj65Qhk/ueCU05TzV7PRcrlxi9l
 6yMUX3I0CKpdhE1aXNRs6pph6QRHmXPRLUgCY6h4JRcCmpI+r7gaUSFcbWUxoCj/
 +++xMctaa8pRCNIiI8PVHngIE/1OG+aGJlDDqemEq0xjknd5NPJMqCqsiOeOeokW
 xm1O0NyzuxZgK8vxOjpLPcUuXcCp3SzQIWhYfG5yVcSPW/IkoMPIcoCLRrntpUYW
 ge5zJqFPAU95wLfcRmL82oasbZGwjI7jM29L6oM41KoC83wg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqmjbucw8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 09:50:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so700517eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793785836; x=1794390636;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ovu0sdxHDf84rymhudcLdLCWtYKmczHLPgfA9J7MlSk=;
 b=PB/BhQgAPlAJ+/lmUIlfrmeS+o15tzS0avl+UD6alSftaV1YNX+TGvnvQgjR7lLkl1
 +YieQDE1J31AaEKXIxruFdCMikTVq8eYI67rC9n/NkyMPUA4o5QEp1pH8KKVCHmf2FH/
 PvRHDYc22DPG2MCEVikuZBVkrkq0kqKB1nD4XWgvJ76oDLJFuu/KtX+sjA21mdnCtf3Q
 PXSbgXf57qNXipA2AsjU4CWVq9VDLn52ES1Omj60GclixlrOQ4hkxfG4OFhwrEDMlh7P
 Py5ER0zA0Rc9ZnGANSam6ElojKR8FQc38GzGxOHH41Con+jMPpHQEYX5SNqyzq+mA8a3
 R3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785836; x=1794390636;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ovu0sdxHDf84rymhudcLdLCWtYKmczHLPgfA9J7MlSk=;
 b=mZzGeKODjMHl00W8GB62aBu3Xph85VKmV8/3PIpPiAzQ3nZ8/AsT4LPwx7Gh7t5nFR
 N18OZ5vxV2EK8QgIPx/4T8IUPF8C3RUfh8CLLfBXl4rFUsPLVnsXWqLEOCebWqxAEeaT
 RoPl5B9CWLWWnoIuGM3C+QASoU5FkVOiLLiPPx7GQqEDRu+iYFZLoKWxrp5Mu+0jd+KG
 QE8AzfZtF4azVV4Qmhlx5RDkXpxPy/2ifyFTKhmDx/IlpWJ7MMcYLjOnWbc0arLtYO/m
 gUjlhZbes4aJ0aeVHQD7imXKvgZXTeq8sCPaxjOQe6v6RRdlYwyUapy+s6d8fTwBOhjy
 oaFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMIgpF4Id5q8eM1tVKPHti5bPkm+8mxjOnL8A1D9cMxRQYyeh0QTJ/2TI3XYn3ceGjf6huBdw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9N4tMmo9r6IMTMcdbIgR32UiOWImBTjShKChrBtglQVlck6ps/
 TQmkETYGQqYTRNu60baxNhlbs67nLcynI68RW25Z7l1LPOjE7WHxbqknN3exlXPdXow3QwufQan
 NJyXrd+IBbqHmBBOKkGR5jEZtdbRaGnVWShzHTKwAWtvxbCWQkMpNBCWVpfrQh/8CKIBeCt8=
X-Gm-Gg: AYBFou0dZmKgv2Jv2lakph3u8NNcBCcGT9RaZqiiRYx6q5tnaURFRwTMk6HwsnrvUvr
 CRi5EDoToru1uUX1RZ/xNZxK5hku9ik9R9S7I3pcvPidgvTKBB0i5oGMPjRHjMk+ODOeVEX2ixB
 mjODKMiREuJC4xOcQUjtrhJ1oqmDcN/UB9brWojmTktmIsuHNg9EWRHK9K2yKsBptpMda4ibFsw
 /VT4zlJ80HS5KJfpR/VD45+5Co5bNpHX9G9YCqOunwRkHqOm2p+Uyvr8HwhdktevycPQKamNFbx
 7OQYgN20BK/t4KSp8YhJQZpO4u2ljAzmRqMyRCjdItVoLVQXyXYxtMZV3Z58hd4uN6a8xkDOAYO
 rgrxni3fPJBdO7zmkLyu6hMnbpqTgenGUQ/FXHEkKNVIpV1bq4vQs6a0VJWf5Rg09DCfb1Q9yks
 4H9ItXlDatAqH7FCFbsqIWamPb9M21oeE4OYdiX7KM9Fcs2vkV6kp39tNWmnFB
X-Received: by 2002:a05:693c:4159:20b0:351:29c8:643 with SMTP id
 5a478bee46e88-36a423a8b7fmr25867212eec.18.1793785835698; 
 Wed, 04 Nov 2026 01:50:35 -0800 (PST)
X-Received: by 2002:a05:693c:4159:20b0:351:29c8:643 with SMTP id
 5a478bee46e88-36a423a8b7fmr25867175eec.18.1793785835069; 
 Wed, 04 Nov 2026 01:50:35 -0800 (PST)
Received: from hu-gde-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3784f78sm7278404eec.2.2026.11.04.01.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:50:34 -0800 (PST)
From: Deepak G <deepak.g10@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:20:12 +0530
Subject: [PATCH] gpio: qcom_spmi: Add pmm8654au GPIO subtype support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-gpio-qcom_spmi-v1-1-2e430ec0843d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANP/6moC/y2NUQqDMBAFryL73YAxRUyvUorY+KoraGJWS0G8e
 1Pr58C8eRsJIkPolm0U8WZhPyXQl4xc30wdFLeJqciLUuvcqC6wV7PzYy1hZGUt2sqYKxpbURq
 FiBd/juD98WdZnwPc8qucRsS8pqfl1Pb9C78u3pyHAAAA
X-Change-ID: 20261103-gpio-qcom_spmi-99ed8334ea98
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Petr Hodina <petr.hodina@protonmail.com>, Deepak G <gde@qti.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Deepak G <deepak.g10@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793785831; l=2008;
 i=deepak.g10@oss.qualcomm.com; s=20261103; h=from:subject:message-id;
 bh=TwPVi47kx2UaxSYdzFHuTxl635ovBklYnT3DwbWpmVc=;
 b=M2nr/OsW/DArEK29YbIK6+xmjqU9pz2Q076Xd4pUdbkS/fxhaHGwQi1hdnEvJL532ndAx2Bxn
 oLDepU6EM1dBqrmSrat9LTpkCIYUMgWdvCfhPf28lu6h+caVYxg/ICN
X-Developer-Key: i=deepak.g10@oss.qualcomm.com; a=ed25519;
 pk=qW/kHLFcYM9A+uLJhUohoPh1HfCPpcsriYKwqHRw70k=
X-Proofpoint-GUID: SAbX6w7_MU1pyf8YmQc5Vo-ucZYS69UI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzOSBTYWx0ZWRfX2siTsvWKQ/g2
 wvKXB8nKV/6L/EQPndoajw1MhhvO3GmDr7kt8blxwKD9AOIR0Ds4rok/7SbkPAXFANCP/TChHC1
 Jh18mUbdM7uvBHdPvwHZwGRBYbyIJ+/NQnC+Mfdb+BtH+8kdjk+CwkYy36lRFeJb8diyCbYlmA/
 W1lXWkcWobgfkWvduuWsU+W9GkM109O60kfWJLBaST83LEcRSKSo86xXculAd0gzEC6+x4j7RoK
 HciWz4QClNHZEsiePJmDAfDLueLI6CAcmjIgc2DZaen2TIVG6d8fDefEXtxTPgg6bJwEuq98Obz
 hQ9RIuTQS0ZRFGBPa+HvAo1k+BbjTDdMeF8yhNeYmaikSLQO5UB1nRKnjTiS2QQndXDt5bzRtoe
 0pcdEJhTHeUGKdGZxBNdjrLvaSIm7cpjIFgGcjWEFBPB26bTihIqOSa0upT7Z4astyBJDjbQAqv
 5MvxKYkl6sqdfLC/+fQ==
X-Proofpoint-ORIG-GUID: SAbX6w7_MU1pyf8YmQc5Vo-ucZYS69UI
X-Authority-Analysis: v=2.4 cv=NMhAaE6g c=1 sm=1 tr=0 ts=6aeaffec cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=zhe6ROHuory88SUTMQAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzOSBTYWx0ZWRfX0CCXM7bU3hHP
 x7R6a8zyaM8fDyZ4F2SplI/WqOb/iTWpdv6jFYHAXZmEWKStQ/aNc99W4IITYg5hfpFsberPhS7
 UeJ75tLDPFqNQJ8kV1w6Be+XsBQW444=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040039
X-Mailman-Approved-At: Wed, 04 Nov 2026 13:31:11 +0000
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

Add the LV_VIN2_CLK (0x14) and MV_VIN3_CLK (0x15) GPIO subtypes,
which are handled the same as the existing LV_VIN2 and MV_VIN3
subtypes, and register the "qcom,pmm8654au-gpio" compatible string
so the pmm8654au PMIC's GPIO controller is probed correctly.

Taken from linux commit: bfdccbe92e6d ("pinctrl: qcom: spmi-gpio: add support for {LV_VIN2, MV_VIN3}_CLK subtypes")

Signed-off-by: Deepak G <deepak.g10@oss.qualcomm.com>
---
 drivers/gpio/qcom_spmi_gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index d06b9a4b513..8cb9aa0a205 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -42,6 +42,8 @@
 #define PMIC_GPIO_SUBTYPE_GPIO_MV		0x11
 #define PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2		0x12
 #define PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3		0x13
+#define PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2_CLK	0x14
+#define PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3_CLK	0x15
 
 #define PMIC_MPP_REG_RT_STS			0x10
 #define PMIC_MPP_REG_RT_STS_VAL_MASK		0x1
@@ -398,11 +400,13 @@ static int spmi_pmic_gpio_populate(struct qcom_spmi_pmic_gpio_data *plat,
 		pad->lv_mv_type = true;
 		break;
 	case PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2:
+	case PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2_CLK:
 		pad->num_sources = 2;
 		pad->have_buffer = true;
 		pad->lv_mv_type = true;
 		break;
 	case PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3:
+	case PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3_CLK:
 		pad->num_sources = 3;
 		pad->have_buffer = true;
 		pad->lv_mv_type = true;
@@ -757,6 +761,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
 	{ .compatible = "qcom,pm8350c-gpio" },
 	{ .compatible = "qcom,pmk8350-gpio" },
 	{ .compatible = "qcom,pmk8550-gpio" },
+	{ .compatible = "qcom,pmm8654au-gpio" },
 	{ .compatible = "qcom,pmr735d-gpio" },
 	{ }
 };

---
base-commit: b8668aa4114e445d020fcb68a223b7f0af74c1a9
change-id: 20261103-gpio-qcom_spmi-99ed8334ea98

Best regards,
--  
Deepak G <deepak.g10@oss.qualcomm.com>

