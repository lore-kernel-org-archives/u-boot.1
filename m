Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3653606A337
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RuWGPzT2;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mwHzfXHu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N6aI5igS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A38CA40817;
	Wed,  4 Nov 2026 16:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yXpFGXLDQq9r; Wed,  4 Nov 2026 16:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7EB1D4088E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793810252;
	b=Yn/byJuAzg7EgLQvijPds/CgtbCizVcfYe6FS5pDO/0/u/I8y+2LDlL0nHWTLj06a2BT
	 AiYx3S92qQXO2o35ghr5zKKnouiFPCq+lm9d33uZ8nryC6lTmTp1jDEBPipaJRLIRsHyq
	 SvOyMjCWPrE3LIYzoUg6iRPcXOkXTvs1n1l1oWgRbQL2vplCnNvY555UsmxQ1dLUkzBzx
	 LfFA7Pw2WhfF0afEQua3mc4HfbLfxzOr4WEatKNoZ2TRXs/1nuLjLbPmy9KG6zWbdH4T8
	 bCCePU8xleXjrO/sD7XRLL1AWQ9M+bune/RSnnAWgO5hezjnODN/gl/zR9OGcfbV1ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1guEzh/75qczeKsCChXCagxy0hhS40nbI/anlMnNskM=;
	b=axpDXcKx58tPgMEgly9ue4lToawW/NJ0l+jXgGvf046t/O/RpsU/3BG6azOF3QXTwuRy
	 sCjMvOyy90/YjnijsLBIdVUok371/JlZ/NX55cEmtKp07cDyY/VPXct+WqTa8i0D1TKQA
	 wZ5yKJ3yxCXnWqtCmayk1bItma5+E9vRTM3OyGS3+hYKdkL48yigeDIyK7AY0wKV/ppVy
	 RojX+9e4XPDuTukuSM0X/fHKMqhqU7iqFGDa35z4TjHPvq9/uJhm6fnse13WiRyi6c540
	 ahd8IbxhkMcw1OGYEmW/DksmtaF5tNqWlfvm9LHieoViFRzVizWETgwFH/Fj69p2LoA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mwHzfXHu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N6aI5igS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810252;
	bh=1guEzh/75qczeKsCChXCagxy0hhS40nbI/anlMnNskM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RuWGPzT2pLUOIfSNdq1V7sZ/7/RfJ0FN7PCKbKaWnUwo0QpUt89KugtC5cZNKtz3L
	 K5zio0Wi4Umx7scYIm1iKxeB3+HzE4waaw+CSEQmh4uM76t7iIK6NzU9DCMk7su02h
	 VeRRabfMbOFGINN0icXGxAl/UftqvkcnCMUZFDymtzQ0mEqMzUrdIC5X9Dip4APuB1
	 gIVo9IOAyGCSzcVqA07zNS4kUB1tpcvMdBhKyZumiCJc6R1TWviQSAuHiOGxQWvNIi
	 n/ZFExgfmnFmJnsm2+C3s6rfuYILLtA7ihQCkebwiYnKNlcXIOvRCcVP1gzidR4ICO
	 A1O+oREnl+tvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EB1D4088E;
	Wed,  4 Nov 2026 16:37:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C456C411
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4961410DB
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QwKdPIYN7hYo for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5293D50055
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793808254;
 b=k0OD2vfuhHwHk3CHfJMEb9TEykSQlcOUAKXPq/BbibrWwJs8C5+MPLKSimIKw6mG2ucV
 4Qb1qNdoCdp6auLu+wNmY1tLTd/vZ2+f6Gv3zRzXnCHxXLX7D8Quc6XVs6SAXDUPMwzt1
 sz5fRq+0MO3iFZuYlNEr45Y1g9IWT7mt2VpZdO1EURSOnnZDz+4+Ur8TsLuzgPfTCw5qn
 kPUBFhDXNNAZiadH+PqbWpe7sD9k2SKyEG8lSNaAPREAPvzOv4g+1H1KF9WX6U+3qLtf8
 RZfFmaXALaZuGXTTKgSm5Yj3+n05kXoPmLwWrvMrGfCQsxAIQQyZIYTEsxwgK9SdCjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793808254;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=1guEzh/75qczeKsCChXCagxy0hhS40nbI/anlMnNskM=;
 b=R32Ab8kKzdmaw3/6XECk961KbT/G8YXZBWuBdyAUr2mMCr5jcWPPtwTzAsCm5tHwNBsq
 9SQU10UUKSmUR01zGu+sVR1urlr6ssfGkfgzz39dWPCL+19jQHiOYrJZYF6w1CW0E1/Yz
 fntZP5ldQvWS3k2Ooqv6T3Itxh528/ihtL3gABelw+r6zMYWqFtor/VoG0DWfeXFk57ud
 YDP0+N9afC0SI9RU04K3hhWEOVaomj9WKzm+EaZ917WmVrg/Gd3LhK6i2Cz4p+z0kqBcj
 rWRnTfwqaLSgG49SnmYky4/DwylbcpKxp+8y9o9Mr25kf5v3w5tGz21Sh9mYQi9bJgw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mwHzfXHu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=N6aI5igS; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mwHzfXHu; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=N6aI5igS
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5293D50055
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FjEjx2244274
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=1guEzh/75qczeKsCChXCagxy0hhS40nbI/a
 nlMnNskM=; b=mwHzfXHuhtfAs8MBIU6Y8Q0P9f3AYvzWMVGn9hv2iBsoKRdmBxo
 DGIUCToXOc+IA1GK56ONI3kPim1E1KSXh/vrrCyB5+rdzTIZq2BETVhCfEjLmW2L
 wfkQ/pnexk9xV1HCXSeYLEghE+s3vmzlyeliijM5nH9WN5pe7f0y8wor8O11jOEy
 rvlNF+QLAbE5Jyk1PNGWn2TN6B67zU01oreiPbPk0oknxJJyBModfUzdftFTcO8g
 uE5WN/WC9bBdyA4JsGDbDWubSLWAu8pYD7HzDVscohinOcX7hjwkuLt3FHLFMQ2p
 bTrnknI2lt/9m81gC3wslQQA59Fw38tImMg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr3pyh4t5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:04:11 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1af203073e0so1526064c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793808251; x=1794413051;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1guEzh/75qczeKsCChXCagxy0hhS40nbI/anlMnNskM=;
 b=N6aI5igSPmAmBJACGpIfSjP9NBRwNXNyytpg6Zhkv0xsbl8cxne7EsfygCR5dLGFRV
 OfcnvKay/GT8dKdmDS+OxFrUsifcoQVQTTUZHxBR6F/MRyDWk0gLqV245avqB73UOgpc
 Vj0Yu+TijSoL8NYHaCT5bgORnn5uPulQKzcfEOPyTbNwcJm/Wg+QKIze94srz8Jx45qp
 YeYtoyhL5y7PVWrEQTLDgTYJDUXUNMqs8hv/ZLdMFVCzSejQnm47bdnWUmcgm/sx8RyJ
 2s31DFJQkbKbGO6qr4Q84tOHoL5tTQ2A+QaZLZOrOvpvcoB5Zf1qBPpJJ7Nk5h++2Cai
 qo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793808251; x=1794413051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1guEzh/75qczeKsCChXCagxy0hhS40nbI/anlMnNskM=;
 b=HVvJCV+qYWVLUNQ1i3g2LqFozg+qef34dRxqLai2WUHA6v1qYEQPinldwgB/2OxZG2
 EB7vm+J7o8D6Xz1dGysULM7jVJarTn9pSOZoXts0ZW/FnWLw+y5CeCX3wY/vzyKVJazy
 uyLj7W/KWLx9VI1qlGXoqNMVYtBHLbXBDYu5wPwD0O94ZAu5EbaQVvFQDu1qMc8k0FpV
 WdVNMWr18FGd9uEhWLuRrEvqXwtlH6m1E753fd7Kj3wT+26GthXskd9WfcmvRxW2PS9J
 P8RimMYUBm9tx0Hd4j8kpJwsLp3GxxHQ6W2NYHK3Wpuz9k84u+JoY6Zv2Ia9XBXolWKg
 jibw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/PbX0vXVqq/R7HPaQa4kdYPxg1DPMc9SM5awPoeV5R4XtUC3xNs6yNsFmtoLdZXzFVQ0RYqo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8gVyEVs06SxKSQ/pd3k3BOmalQsFP90rQQLc88IhhE5SbBRiCF
 42yt/CXrA61fXb2TpLN8aoVs+FdEfaNQYoiiAI7se0Nx5boJ7HcW5iMsvNiWttP17rZ9TjxQGu/
 sA17HpphKT4KYwIk9lLPnNLxmtJn9I78HopxbM3dNvLPnnJNUt/vj06CVVwFtW9oDMd6vbNFQDb
 oMU2o=
X-Gm-Gg: AYBFou0EXlezbkv4+BR6u34GWjfgxvmEfv233LQgb1sz/lhNwVDA5HKCjbMlAqm0qVJ
 BbRP+RnDompoFU1K4zJCXG6Gf5BnLzepQJoU9BH4qRP/20suJA8h0miKl+MiU2wXoVOmhS8id/C
 /fd70blgP5dUPzhdFJ2PnULB//N2vOEyG9c9efPArrN+RUayG1uGXOwzuRhnABoHRqE8AE2cu14
 8oLhh8upJV0FdrRG9oOhVB8ohoWyiqaxbd+eSetmZrsTu6BHmoCrp8ktZL8W0vuma6nZS8KuiXe
 Owv5wA1q458XJTKtSxFfLTpA1oVHeqxDMOhpv1rnJ3VnKm5PY2DeRk/bGX2QsLf09iEavzwCOEo
 e8WObTxjw4PlznO4VyAPXTmvSkiZwHOfVlC5XpYIYsEJRYfMUl1Xw1kJb8as5izd6hpx/O69qay
 VIBwYt7Gac4oR1L+xzLotgH+hJ2zwdGLsOnHbZeKMqpQYUe6iHte81PZCxNLXd0fMrMg==
X-Received: by 2002:a05:701b:42d1:20b0:156:6676:d0e2 with SMTP id
 a92af1059eb24-1ac5cb1aed7mr25660885c88.10.1793808250869; 
 Wed, 04 Nov 2026 08:04:10 -0800 (PST)
X-Received: by 2002:a05:701b:42d1:20b0:156:6676:d0e2 with SMTP id
 a92af1059eb24-1ac5cb1aed7mr25660819c88.10.1793808249991; 
 Wed, 04 Nov 2026 08:04:09 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm10882667c88.15.2026.11.04.08.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:04:09 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 msp@baylibre.com, kr.sowmiya@oss.qualcomm.com,
 abhilash.v@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 vincent.stehle@arm.com, daniel@makrotopia.org, francesco@valla.it,
 anton@binarly.io, aristo.chen@canonical.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 0/6] add Nord Ride chainloaded UFS SPL support- #194
Date: Wed,  4 Nov 2026 21:33:52 +0530
Message-ID: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbmIpcVA c=1 sm=1 tr=0 ts=6aeb577c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=JFY1ujFc9F6PSAxLFn0A:9
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfXyKijAQJNkIHY
 FuFyaohVHhTWjQixTK6op4O/Tfn+bUF5DsuG0J+3cxYJVPAdzXnDJ0dY5/yooGCOUKcJG9OC+gQ
 nXRPxgawNWPdS+kiZqd+JD3qsB8O12XC2V61RlPEi+Lc0vSYJecBllTsgqJZu9xEONXPyZ6+O5z
 wzRYGLJCuNgsf7+eFdLaqmd6KQbcyEDHDcuvdZkRZvvgrauAMXXOZHh+vZnNwCzvjIoo/bYz5gz
 Cc30YV7vfVaIBa3vIaY2coZUzrBaBR6DtQt8lbmKDM5UzY72dEyVSVR+qn35pLaUSsaIIooDGEa
 eyOIghogygg9/Dxsm8qx42bwiqUEkgMHjZpQhZ8xSxY1msUIfZcBI59wI6BmNvfutmVxrFq1Fso
 UnyGB6N07lTCBgcSgkDYLYDIh0469wuzyWogCqHceqa59dBBW6U/ruchTjEQJOql7I+EUo3D5D+
 bgO2x7MBFE+NXJW1q6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfXw6LC9xi0hrHo
 eMD799Md8OY4i0Hajv2Ojc5ykmN/9cCrhk2lnIP3jOjeHGd1fdDqlnclo8P9qsohGJOstbVFGca
 rVT/EcH5KaIGP1+fnaeT6B5N9q73Tco=
X-Proofpoint-ORIG-GUID: yEQMBSofMGAqcu9muO0_QuzPUfHv6gkA
X-Proofpoint-GUID: yEQMBSofMGAqcu9muO0_QuzPUfHv6gkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040063
X-Mailman-Approved-At: Wed, 04 Nov 2026 16:37:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add chainloaded SPL support for the Qualcomm Nord Ride platform.

This series:

Adds Nord-specific SPL entry points for the XBL-to-SPL boot flow.
Supports loading TF-A, OP-TEE, and the U-Boot FIT from the UFS 
uefi_a partition.
Adds the Nord SPL linker configuration with a single-segment ELF 
layout and 4 KiB alignment.
Enables the required SPL device-tree nodes, including UFS, 
UFS PHY, clocks, pinctrl, SMEM, UART, and QUP.
Adds the Nord SPL pinctrl configuration.
Passes the optional FIT TOC FDT address to BL32.
Adds SPL progress messages for FIT image loading and BL31 handoff.

KR Sowmiya (6):
  pinctrl: qcom: add Nord SPL pinctrl option
  board: qualcomm: nord: add chainloaded SPL support
  common: spl: add FIT and BL31 progress messages
  board: qualcomm: nord: pass TOC FDT to BL32
  board: qualcomm: nord: add SPL linker configuration
  Nord: enable MBN generation

 Makefile                                    |   1 +
 arch/arm/mach-snapdragon/fit-handler.c      |  57 +++++++++
 arch/arm/mach-snapdragon/include/mach/spl.h |   5 +
 board/qualcomm/nord/Makefile                |   3 +
 board/qualcomm/nord/spl-nord.c              | 121 ++++++++++++++++++++
 common/spl/spl_atf.c                        |   1 +
 common/spl/spl_fit.c                        |   1 +
 drivers/pinctrl/qcom/Kconfig                |   8 ++
 8 files changed, 197 insertions(+)
 create mode 100644 board/qualcomm/nord/Makefile
 create mode 100644 board/qualcomm/nord/spl-nord.c

-- 
2.43.0

