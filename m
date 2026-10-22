Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12943606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vAapMBhI;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OOyoMCNa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VMx80oRo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1163812B3;
	Thu, 22 Oct 2026 10:41:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dp8RAZk54fo1; Thu, 22 Oct 2026 10:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 228A98128D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792665668;
	b=Wta0KQ3MMq/1n2FzNKC0EsTJAARsJSynaolPg3IwVnCIGynsClIChScoV8cDFKom5pFo
	 Lek/jCYhf4AyxAWPbUpGOXiOAaf2vA5Hc7nUS5kQZuOFpMu7ZodPv7NkD612DtvSh7AvY
	 EXvVvRQLL/lEsRYwqgkUJ2zKU2yiUIMUBBaRHORghlPEk5AV18EAmAZrlzicc5V5PrNL0
	 69bgSyHySlRW2Q0C1YEgVx/oV9Kt3GEKHwXu3wI8+tA0h1CxrAaT79fpMdrGj0cMoyXpR
	 j/5t8IV6BfqLkRakVRYizDoFADVk6e+Jgot3X22BHGydYCE2cKm9LW1jAO3sKkQG9wQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792665668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J+0N8/XlU+ZZXL7iouVUJL6FiC6h62J0Uvvp5nJok6Q=;
	b=m8DdJShvfIKaoKjtKeRPIiCFXi7VcZTJuGMRKJbBlAv+iMJWJgEir9kLtmDNlYLqNqda
	 tZTMkWIqeWbC0es4Jex8WcdfbwP9JqwLERWUE2wNBpksJQ+sqWsMcwUNu3eG1yaE2rmVy
	 vrBH8SZe6rs5rgMFli+IR6p41AOKT2mQZ1g1umLFbxC7jggs8a5bX2o2cOD2TrT9ACR1O
	 ehDRcX31th3sagxBdtcOufEttQXDW5nlrPDnSb5aNR5D0FD/lpAaFppD1FTZvEfXBvE+b
	 aZPDhpsYcGpLbRsfHfwFlczrxq/GNMRiUt5HsAKz30jDIVnPLaXJg+0aaOukVYQcUhA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OOyoMCNa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VMx80oRo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792665668;
	bh=J+0N8/XlU+ZZXL7iouVUJL6FiC6h62J0Uvvp5nJok6Q=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vAapMBhIO4wb78CBG6RsLG0RZlvKkKEAsGKXlmiZSKY3njJRUNTfKU7W/CoyKHNqk
	 mrZB3vWlXLZRd7/1IDtHq2ZuXy+xfW37/eOPB2pLLAX4JJ7kh5cqhS+x3fJuMnXX6J
	 nTHuqyVSOpCZoyayFj5cvDDIyKWmysGQBSdZL0+9vOHXxgwpBHknu7RfY8BKi1/JLl
	 g/+Wdo2fZ4F/ByZNm6ACuIbBqpp2qDRFLlk2jgajbyS5/bQe9CCMwYyvPswFH/nEE1
	 Gx5uLJDfV7mQu/PhzpQOJ1rtskYK1OVp9vat0Jq2yuXRnHPN+1cN96xZzLxYnlLtEH
	 +H9bVO+f+2ZXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 228A98128D;
	Thu, 22 Oct 2026 10:41:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A906D356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99DFB8128D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sMfWUzCGX5Ek for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:41:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA81781172
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792665665;
 b=JIeaaWURJlvfjYwPzt8x1eYJ1mS/GrdGbcRWitprahD3MejOwAXYhxBnZzhvQ4p3ynD5
 LEK7SX+6k5vhz/AEm/rhDU1+9aJ5UqtR06ukGYfVQX/21FnOgzUfjmfMmPxF/rDCp2mI4
 KoM91VRTkbHUEih2QH0/kC4JSXSIMb7mqtjy1MQzn9d0s8kPOD4LRsBfMbtJ7kHK+QzaI
 OG9XlO7ETZwk8mTmD3ffMMUU+GrtTWZhT5Hi2DWWiXDbt2hnctODMhRUdEOxkEkHUPRnP
 dz017TKlL8Di0bHRT8lCSuRSsaCZICJOIJCKAeNKI3O8R2DfHVcBIjq1/JvUPYC02PQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792665665;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=J+0N8/XlU+ZZXL7iouVUJL6FiC6h62J0Uvvp5nJok6Q=;
 b=k9O2OhszYChz98G14JVibdzuaxD06RZxU2Co0oWlvR9LX8oXJiLde79kIFPxsOqaS4ur
 9IdsuCKl+Tx/wzHq6m99kJF/XNpjgZ/6xrU1Ndrh7U7C7bsoHMipdOui7E91Q7vcemYeQ
 +KInrhN6BER6OIyKLxVmKhxOIStHya+5tn6LKLYm5mO4vxmaylTD3k2MHjGNQRQaf7yh6
 J2WFvCy6Ate0x3KdfhVBtv15u26x78uV9rIzzP5a0CNeAl8wPvYobv2Iya7CfbtyGzsHA
 QYcuAcUuwrXs7LC/8c4JeSxSUPcy0fJb+OdmnaqHMylAAp9I7wiWQWYFJCDIrz/mE4w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OOyoMCNa; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VMx80oRo; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=OOyoMCNa; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VMx80oRo
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA81781172
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:41:02 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MAclCl4089494
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=J+0N8/XlU+ZZXL7iouVUJL
 6FiC6h62J0Uvvp5nJok6Q=; b=OOyoMCNag+bJZBkfrJApDFy6xbxzESJpQAZWJ7
 AhFvlVRsD9hlgo9WGvLLTW1X1baXX25p9G/zeZ9sSLyw/cuaEhMVQ6k9M705or0n
 d4Wjp5nQYxUFalcY+EELQalZ6zduyVOTc96/DkxMQ+VA1Kf16G9rIo3dWxBdFvkg
 Rx+w7KEKB4oSlrK+BVdqFEjPUCKuhKowgHLmZ1BUUyaeUR9kFuDtv7D4DAbHBrfp
 WtGf9h6NcQJ5s19acE/SwP0AGLXyJ+uU02wzEjH9X7/zCrDTQF/kQ43vTcesU1fb
 slD+x/bGKjj2RdZEy5l96YLxB96ctHuBctTlbHfuaAs2pZTQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ca4aq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:41:01 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9179a556c43so37545786d6.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792665661; x=1793270461;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J+0N8/XlU+ZZXL7iouVUJL6FiC6h62J0Uvvp5nJok6Q=;
 b=VMx80oRo49kmPO0et8xHD3+IvIPxl1vGsaGCoI6SVbRu8fIz/S93io1jsi9LCjMuFu
 5YC6yv6x+Rh75tlrtPebsNuaQxbruTL8loVqo8ar0m5T+4YFU9Z83h4v9ZrSSXQkDrTk
 CiIu0cgdDtmlHumbLbRqbQJA8sCPGpebrHOvgsSRPSnwR74Hry2XqE0MmA3lQt17rInl
 /ybMNtIKS2QiEOdQEIfQSIV9yet06cH7zO9Ku0Tx6NR9H5qTjWOwvWDbt8Z6HnY4mvrt
 cOc9bEvdC9ZXMh60wpPVvjiZuR30ACZUnobtYVJXi4RUMTCVVDgf6E/IdrEuDLRiF+8G
 h2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792665661; x=1793270461;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J+0N8/XlU+ZZXL7iouVUJL6FiC6h62J0Uvvp5nJok6Q=;
 b=ouoG7R0UhkpzVw4MfLcJf4ADH0UR36NcRdxwyWvLRwPix+BnCZaUBNApF/XqOKJMkr
 NHIVHDqcnvv1Rsp464+Dn+JzYmlhdda1G5+7yFrx5iGUQDPPHiNcte9bqG4AUp9SBWyB
 gfZ7dmUjn3Tv/7RjuXX/d9inIkOdoYJ1AAFw1VIKYRdkhaaJtrEBO0tlKjce3LG6po8n
 3/vSSeM0ABtJcr39uoS8O2TeMMhe14ApaTHlGVQAkFV5JonP5hUmbhOkcqdYZZGuIDzP
 7uY6lTL7Yr/wYf0+xFtNchPwEAE0RDUsJk+AoUG3J0FpxTrfXO1R1hkN8PKpNwJDQ48M
 sGkg==
X-Gm-Message-State: AFq9FYIeNnBgic5lFmrEjyKXKUEPRsPGrT2Kd/aFPbZJWTVN/JJ7Fdr3
 mG5xtEbfUyAr3Hh2p560oyX3Ft5aisHWCAi/O+ijK2ikbiEIbaZ7/3d2i6pm0VvrRomxZEWNXOv
 sdkb3il8pHdxgJ2Sp592dDNua+fNHMeQ+fn+bj0Ri1sozHl1qkCRZJeSJuux8ydSflyI1J1w=
X-Gm-Gg: AYBFou3hjNdU3b4KKaUZafgJLxiGTgjuSDzwabcO8AH/YgRL6YTCviXGVwnxGSshU1T
 EUOz5djT0MzV11ntVra4UgyXHKGA/8pm4TEInlLbMVUF/HJXEe8t+FPvlG77KMekstRklRHXC9d
 YN5TbznFVBAaRgLMqgZyI7wlH8EBTLX14KaYgc+aOViY7Xz+0Ns/TN+jbOQsn0po+z36EAR4i84
 HG2PB7ImaQDOaZQ4RDaZuMO/tf3jskHN/P7ctn++0OOQTRFr8Azo7OBMw79TgD3JF0Wg2kAIiGK
 vwq0srIytcFj/pNq4YmmJpGEY7ZkhJec3RsYBc8yTLyKV36kkQBBKhWiaOkXDuwXgJ2t0Ne3Fhh
 zlaAo66JMEokB+o7xMo2bw/iBTRXBOPepWn0PmsGq2jUQ
X-Received: by 2002:a05:620a:8004:b0:93c:5b11:d44c with SMTP id
 af79cd13be357-93f57e45bdamr803333385a.1.1792665660443; 
 Thu, 22 Oct 2026 03:41:00 -0700 (PDT)
X-Received: by 2002:a05:620a:8004:b0:93c:5b11:d44c with SMTP id
 af79cd13be357-93f57e45bdamr803330685a.1.1792665659837; 
 Thu, 22 Oct 2026 03:40:59 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a5e4bc2sm91343766b.76.2026.10.22.03.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:40:59 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 12:40:54 +0200
Subject: [PATCH v3] arm64: add SHA-512 acceleration with the ARMv8.2 Crypto
 Extensions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-upstream-sha512_ce_b4-v3-1-26b3ec2e9eba@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Pwc6CMBCEX8X0bHG7VARPvocxppRFVmNLWiAYw
 7tL9fKf/uPs7jcz+xaRAlMUx81bBJo4sneryLcbYTvjbiS5WbVAwEIBohz7OAQyTxk7s1d4tXS
 ttczb0qJqKlOQFivbB2p5/vqeLz8dx/pOdkhm6aI2kWQdjLNdGjXk5p2jeUi7juPgw+tbalLJI
 +VrQAUK4QBVVuUlloVUkm8+ZL43jsfHqfWja9I7GXuRYif8C6+43gNkCqoSQP9PL8vyAbchVtA
 dAQAA
X-Change-ID: 20261022-upstream-sha512_ce_b4-3f8c21d9a6e4
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Marc Zyngier <maz@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MiBTYWx0ZWRfX3XuKlCHVkwVx
 S4H50PuwugXslPJVq0jBAzBfqCOSkC5kAQg94coYpi4v3OJjKWb3roTNPiYHbp7VjHxwRaW/5fY
 cl5/aSO08JTj4GI3qLyn+wnBPYqCv10=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ad9e83d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cr0OooRFNUmU3AxfKvAA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iflFvRjW7NnHu9gXTRoyKMtwq85AnA2L
X-Proofpoint-ORIG-GUID: iflFvRjW7NnHu9gXTRoyKMtwq85AnA2L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MiBTYWx0ZWRfXwtWFU1WbHR/k
 GWIk6+JUfp+sR/0gsxVl1DOwwve3LrClaDUo21qrL/D0hxec6EuP/V8QdiEEBZ2nv4YRRb/CTet
 RVDK2Bb17nJHSbNbeTm3TTmZ+6j4s7vJqAPQEc/vlAr0ge4s+BAdliFekMPZicE98v6nZrlOhY1
 38NhSXsOJ1Qtitv7ssyl1Hpq3vClu86Aji2cb3WLwVHN/1h0RozE8tyjGE7HGbjRGj9yGOZzGC7
 pn3eflTyfpXRdF7T6k09AtHJk9aKvN6XBwDYgoB7eUJHOJNsCPLJczO2goRxOfULOa+hPEeRVz5
 fUUfCNUj3D/uHkWU0uY8h9Y4oCHJVgan8Hc1yjchZOGQ6tdN7+iGuU2zH1lFsdRq5wiEy/kCcEu
 Cc4LDUsZ1etyFlxTDVMlbed3CXTf4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220042
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the SHA-512 (and SHA-384) block function on the SHA512H, SHA512H2,
SHA512SU0 and SHA512SU1 instructions of the ARMv8.2 Crypto Extensions,
next to the existing SHA-1 and SHA-256 ones. Hashing is the dominant cost
of verifying large images (FIT, AVB hash descriptors over 64 MiB boot
images), and SHA-512 is the algorithm of choice for new signing keys.

These instructions are optional: ID_AA64ISAR0_EL1.SHA2 is 0b0010 when
they are implemented and 0b0001 for SHA-256 only (Cortex-A55/A76/A78 and
Neoverse N1 have only SHA-256; Cortex-A710/X2, Neoverse V1/N2 and newer
have both). The glue therefore reads the register and falls back to the
generic C implementation, which is exported as sha512_block_fn_generic()
with sha512_block_fn() as its weak alias. The same binary thus runs on
any ARMv8 CPU, including VMs whose capabilities vary, so the option
defaults to y like ARMV8_CE_SHA256. The assembler is given
".arch armv8.2-a+sha3" and emits the instructions natively (binutils >=
2.29); no .inst encodings are needed.

It plugs into lib/sha512.c, the legacy hashing library, which is also
what mbedTLS uses with MBEDTLS_LIB_HASHING_ALT. Configurations that hash
with mbedTLS's own implementation (MBEDTLS_LIB_CRYPTO, SHA512_MBEDTLS)
are not affected and cannot enable the option.

The transform is the one from the Linux kernel (arch/arm64/crypto/
sha512-ce-core.S) by Ard Biesheuvel.

Tested on QEMU virt with legacy hashing: with -cpu cortex-a710 "hash
sha512" of a 32 MiB buffer and of a file match the host digests and the
CE transform is used; with -cpu cortex-a76 the same digests come from
the generic fallback.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v3:
- Select the implementation at run time from ID_AA64ISAR0_EL1.SHA2 and
  fall back to the generic C code on CPUs without the SHA-512
  instructions (Marc Zyngier), so one binary runs everywhere; the
  option now defaults to y like ARMV8_CE_SHA256 (Tom Rini).
- Export the generic block function as sha512_block_fn_generic() with
  sha512_block_fn() as its weak alias, drop the "mov" before "ret" and
  the .inst encodings: binutils >= 2.29 assembles the instructions with
  ".arch armv8.2-a+sha3" (Ard Biesheuvel).
- Drop "default n" from Kconfig and the missing newline (Michal Simek).
- Rebased on next: the option excludes SHA512_MBEDTLS configurations,
  which hash with mbedTLS's own code; it covers legacy hashing and
  MBEDTLS_LIB_HASHING_ALT.
- Link to v2: https://patch.msgid.link/20240212104500.1098004-1-igor.opaniuk@foundries.io

Changes in v2:
- Address the review of v1 (Kconfig and commit message).
- Link to v1: https://patch.msgid.link/20240210120709.938286-1-igor.opaniuk@foundries.io
---
 arch/arm/cpu/armv8/Kconfig          |  10 ++
 arch/arm/cpu/armv8/Makefile         |   1 +
 arch/arm/cpu/armv8/sha512_ce_core.S | 191 ++++++++++++++++++++++++++++++++++++
 arch/arm/cpu/armv8/sha512_ce_glue.c |  35 +++++++
 arch/arm/include/asm/system.h       |   2 +
 include/u-boot/sha512.h             |  13 +++
 lib/sha512.c                        |  14 ++-
 7 files changed, 264 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
index 7e4e3bdd66c..bcc850b1bf5 100644
--- a/arch/arm/cpu/armv8/Kconfig
+++ b/arch/arm/cpu/armv8/Kconfig
@@ -220,6 +220,16 @@ config ARMV8_CE_SHA256
 	bool "SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
 	default y if SHA256
 
+config ARMV8_CE_SHA512
+	bool "SHA-512 digest algorithm (ARMv8 Crypto Extensions)"
+	depends on SHA512 && !SHA512_MBEDTLS
+	default y
+	help
+	  Use the SHA512H, SHA512H2, SHA512SU0 and SHA512SU1 instructions of
+	  the ARMv8.2 Crypto Extensions for SHA-384 and SHA-512. They are
+	  optional (ID_AA64ISAR0_EL1.SHA2 == 0b0010); on a CPU without them
+	  the generic C implementation is used.
+
 endif
 
 endif
diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index dd0191a12fa..8b236c71501 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -46,5 +46,6 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
 obj-$(CONFIG_XEN) += xen/
 obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
 obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
+obj-$(CONFIG_ARMV8_CE_SHA512) += sha512_ce_glue.o sha512_ce_core.o
 
 obj-$(CONFIG_SYSINFO_SMBIOS) += sysinfo.o
diff --git a/arch/arm/cpu/armv8/sha512_ce_core.S b/arch/arm/cpu/armv8/sha512_ce_core.S
new file mode 100644
index 00000000000..de928f2cbd0
--- /dev/null
+++ b/arch/arm/cpu/armv8/sha512_ce_core.S
@@ -0,0 +1,191 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * sha512-ce-core.S - core SHA-384/SHA-512 transform using v8 Crypto
+ * Extensions
+ *
+ * Copyright (C) 2018 Linaro Ltd <ard.biesheuvel@linaro.org>
+ */
+
+ #include <config.h>
+ #include <linux/linkage.h>
+ #include <asm/system.h>
+ #include <asm/macro.h>
+
+	.arch		armv8.2-a+sha3
+
+	.macro		adr_l, dst, sym
+	adrp		\dst, \sym
+	add		\dst, \dst, :lo12:\sym
+	.endm
+
+	/*
+	 * The SHA-512 round constants
+	 */
+	.section	".rodata", "a"
+	.align		4
+.Lsha512_rcon:
+	.quad		0x428a2f98d728ae22, 0x7137449123ef65cd
+	.quad		0xb5c0fbcfec4d3b2f, 0xe9b5dba58189dbbc
+	.quad		0x3956c25bf348b538, 0x59f111f1b605d019
+	.quad		0x923f82a4af194f9b, 0xab1c5ed5da6d8118
+	.quad		0xd807aa98a3030242, 0x12835b0145706fbe
+	.quad		0x243185be4ee4b28c, 0x550c7dc3d5ffb4e2
+	.quad		0x72be5d74f27b896f, 0x80deb1fe3b1696b1
+	.quad		0x9bdc06a725c71235, 0xc19bf174cf692694
+	.quad		0xe49b69c19ef14ad2, 0xefbe4786384f25e3
+	.quad		0x0fc19dc68b8cd5b5, 0x240ca1cc77ac9c65
+	.quad		0x2de92c6f592b0275, 0x4a7484aa6ea6e483
+	.quad		0x5cb0a9dcbd41fbd4, 0x76f988da831153b5
+	.quad		0x983e5152ee66dfab, 0xa831c66d2db43210
+	.quad		0xb00327c898fb213f, 0xbf597fc7beef0ee4
+	.quad		0xc6e00bf33da88fc2, 0xd5a79147930aa725
+	.quad		0x06ca6351e003826f, 0x142929670a0e6e70
+	.quad		0x27b70a8546d22ffc, 0x2e1b21385c26c926
+	.quad		0x4d2c6dfc5ac42aed, 0x53380d139d95b3df
+	.quad		0x650a73548baf63de, 0x766a0abb3c77b2a8
+	.quad		0x81c2c92e47edaee6, 0x92722c851482353b
+	.quad		0xa2bfe8a14cf10364, 0xa81a664bbc423001
+	.quad		0xc24b8b70d0f89791, 0xc76c51a30654be30
+	.quad		0xd192e819d6ef5218, 0xd69906245565a910
+	.quad		0xf40e35855771202a, 0x106aa07032bbd1b8
+	.quad		0x19a4c116b8d2d0c8, 0x1e376c085141ab53
+	.quad		0x2748774cdf8eeb99, 0x34b0bcb5e19b48a8
+	.quad		0x391c0cb3c5c95a63, 0x4ed8aa4ae3418acb
+	.quad		0x5b9cca4f7763e373, 0x682e6ff3d6b2b8a3
+	.quad		0x748f82ee5defb2fc, 0x78a5636f43172f60
+	.quad		0x84c87814a1f0ab72, 0x8cc702081a6439ec
+	.quad		0x90befffa23631e28, 0xa4506cebde82bde9
+	.quad		0xbef9a3f7b2c67915, 0xc67178f2e372532b
+	.quad		0xca273eceea26619c, 0xd186b8c721c0c207
+	.quad		0xeada7dd6cde0eb1e, 0xf57d4f7fee6ed178
+	.quad		0x06f067aa72176fba, 0x0a637dc5a2c898a6
+	.quad		0x113f9804bef90dae, 0x1b710b35131c471b
+	.quad		0x28db77f523047d84, 0x32caab7b40c72493
+	.quad		0x3c9ebe0a15c9bebc, 0x431d67c49c100d4c
+	.quad		0x4cc5d4becb3e42b6, 0x597f299cfc657e2a
+	.quad		0x5fcb6fab3ad6faec, 0x6c44198c4a475817
+
+	.macro		dround, i0, i1, i2, i3, i4, rc0, rc1, in0, in1, in2, in3, in4
+	.ifnb		\rc1
+	ld1		{v\rc1\().2d}, [x4], #16
+	.endif
+	add		v5.2d, v\rc0\().2d, v\in0\().2d
+	ext		v6.16b, v\i2\().16b, v\i3\().16b, #8
+	ext		v5.16b, v5.16b, v5.16b, #8
+	ext		v7.16b, v\i1\().16b, v\i2\().16b, #8
+	add		v\i3\().2d, v\i3\().2d, v5.2d
+	.ifnb		\in1
+	ext		v5.16b, v\in3\().16b, v\in4\().16b, #8
+	sha512su0	v\in0\().2d, v\in1\().2d
+	.endif
+	sha512h		q\i3, q6, v7.2d
+	.ifnb		\in1
+	sha512su1	v\in0\().2d, v\in2\().2d, v5.2d
+	.endif
+	add		v\i4\().2d, v\i1\().2d, v\i3\().2d
+	sha512h2	q\i3, q\i1, v\i0\().2d
+	.endm
+
+	/*
+	 * void sha512_ce_transform(u64 state[8], u8 const *src, u32 blocks)
+	 *
+	 * The caller must have checked that the CPU implements the SHA512
+	 * instructions (ID_AA64ISAR0_EL1.SHA2 >= 0b0010).
+	 */
+	.text
+ENTRY(sha512_ce_transform)
+	/* load state */
+	ld1		{v8.2d-v11.2d}, [x0]
+
+	/* load first 4 round constants */
+	adr_l		x3, .Lsha512_rcon
+	ld1		{v20.2d-v23.2d}, [x3], #64
+
+	/* load input */
+0:	ld1		{v12.2d-v15.2d}, [x1], #64
+	ld1		{v16.2d-v19.2d}, [x1], #64
+	sub		w2, w2, #1
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	rev64		v12.16b, v12.16b
+	rev64		v13.16b, v13.16b
+	rev64		v14.16b, v14.16b
+	rev64		v15.16b, v15.16b
+	rev64		v16.16b, v16.16b
+	rev64		v17.16b, v17.16b
+	rev64		v18.16b, v18.16b
+	rev64		v19.16b, v19.16b
+#endif
+	mov		x4, x3				// rc pointer
+
+	mov		v0.16b, v8.16b
+	mov		v1.16b, v9.16b
+	mov		v2.16b, v10.16b
+	mov		v3.16b, v11.16b
+
+	// v0  ab  cd  --  ef  gh  ab
+	// v1  cd  --  ef  gh  ab  cd
+	// v2  ef  gh  ab  cd  --  ef
+	// v3  gh  ab  cd  --  ef  gh
+	// v4  --  ef  gh  ab  cd  --
+
+	dround		0, 1, 2, 3, 4, 20, 24, 12, 13, 19, 16, 17
+	dround		3, 0, 4, 2, 1, 21, 25, 13, 14, 12, 17, 18
+	dround		2, 3, 1, 4, 0, 22, 26, 14, 15, 13, 18, 19
+	dround		4, 2, 0, 1, 3, 23, 27, 15, 16, 14, 19, 12
+	dround		1, 4, 3, 0, 2, 24, 28, 16, 17, 15, 12, 13
+
+	dround		0, 1, 2, 3, 4, 25, 29, 17, 18, 16, 13, 14
+	dround		3, 0, 4, 2, 1, 26, 30, 18, 19, 17, 14, 15
+	dround		2, 3, 1, 4, 0, 27, 31, 19, 12, 18, 15, 16
+	dround		4, 2, 0, 1, 3, 28, 24, 12, 13, 19, 16, 17
+	dround		1, 4, 3, 0, 2, 29, 25, 13, 14, 12, 17, 18
+
+	dround		0, 1, 2, 3, 4, 30, 26, 14, 15, 13, 18, 19
+	dround		3, 0, 4, 2, 1, 31, 27, 15, 16, 14, 19, 12
+	dround		2, 3, 1, 4, 0, 24, 28, 16, 17, 15, 12, 13
+	dround		4, 2, 0, 1, 3, 25, 29, 17, 18, 16, 13, 14
+	dround		1, 4, 3, 0, 2, 26, 30, 18, 19, 17, 14, 15
+
+	dround		0, 1, 2, 3, 4, 27, 31, 19, 12, 18, 15, 16
+	dround		3, 0, 4, 2, 1, 28, 24, 12, 13, 19, 16, 17
+	dround		2, 3, 1, 4, 0, 29, 25, 13, 14, 12, 17, 18
+	dround		4, 2, 0, 1, 3, 30, 26, 14, 15, 13, 18, 19
+	dround		1, 4, 3, 0, 2, 31, 27, 15, 16, 14, 19, 12
+
+	dround		0, 1, 2, 3, 4, 24, 28, 16, 17, 15, 12, 13
+	dround		3, 0, 4, 2, 1, 25, 29, 17, 18, 16, 13, 14
+	dround		2, 3, 1, 4, 0, 26, 30, 18, 19, 17, 14, 15
+	dround		4, 2, 0, 1, 3, 27, 31, 19, 12, 18, 15, 16
+	dround		1, 4, 3, 0, 2, 28, 24, 12, 13, 19, 16, 17
+
+	dround		0, 1, 2, 3, 4, 29, 25, 13, 14, 12, 17, 18
+	dround		3, 0, 4, 2, 1, 30, 26, 14, 15, 13, 18, 19
+	dround		2, 3, 1, 4, 0, 31, 27, 15, 16, 14, 19, 12
+	dround		4, 2, 0, 1, 3, 24, 28, 16, 17, 15, 12, 13
+	dround		1, 4, 3, 0, 2, 25, 29, 17, 18, 16, 13, 14
+
+	dround		0, 1, 2, 3, 4, 26, 30, 18, 19, 17, 14, 15
+	dround		3, 0, 4, 2, 1, 27, 31, 19, 12, 18, 15, 16
+	dround		2, 3, 1, 4, 0, 28, 24, 12
+	dround		4, 2, 0, 1, 3, 29, 25, 13
+	dround		1, 4, 3, 0, 2, 30, 26, 14
+
+	dround		0, 1, 2, 3, 4, 31, 27, 15
+	dround		3, 0, 4, 2, 1, 24,   , 16
+	dround		2, 3, 1, 4, 0, 25,   , 17
+	dround		4, 2, 0, 1, 3, 26,   , 18
+	dround		1, 4, 3, 0, 2, 27,   , 19
+
+	/* update state */
+	add		v8.2d, v8.2d, v0.2d
+	add		v9.2d, v9.2d, v1.2d
+	add		v10.2d, v10.2d, v2.2d
+	add		v11.2d, v11.2d, v3.2d
+
+	/* handled all input blocks? */
+	cbnz		w2, 0b
+
+	/* store new state */
+	st1		{v8.2d-v11.2d}, [x0]
+	ret
+ENDPROC(sha512_ce_transform)
diff --git a/arch/arm/cpu/armv8/sha512_ce_glue.c b/arch/arm/cpu/armv8/sha512_ce_glue.c
new file mode 100644
index 00000000000..b549c02ed30
--- /dev/null
+++ b/arch/arm/cpu/armv8/sha512_ce_glue.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sha512_ce_glue.c - SHA-512 secure hash using ARMv8 Crypto Extensions
+ */
+
+#include <asm/system.h>
+#include <u-boot/sha512.h>
+
+extern void sha512_ce_transform(u64 state[SHA512_SUM_LEN / 8], const u8 *src,
+				u32 blocks);
+
+/*
+ * The SHA512H, SHA512H2, SHA512SU0 and SHA512SU1 instructions are an
+ * optional part of the ARMv8.2 Crypto Extensions: ID_AA64ISAR0_EL1.SHA2
+ * is 0b0010 when they are implemented, 0b0001 for SHA256 only.
+ */
+static bool sha512_ce_supported(void)
+{
+	u64 isar0;
+
+	asm volatile("mrs %0, id_aa64isar0_el1" : "=r" (isar0));
+
+	return (isar0 & ID_AA64ISAR0_EL1_SHA2) >= ID_AA64ISAR0_EL1_SHA2_SHA512;
+}
+
+void sha512_block_fn(sha512_context *ctx, const uint8_t *src, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	if (sha512_ce_supported())
+		sha512_ce_transform(ctx->state, src, blocks);
+	else
+		sha512_block_fn_generic(ctx, src, blocks);
+}
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 5ed6833c155..b5fe60b6971 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -87,6 +87,8 @@
 #define HCR_EL2_AMO_EL2		(1 <<  5) /* Route SErrors to EL2             */
 
 #define ID_AA64ISAR0_EL1_RNDR	(0xFUL << 60) /* RNDR random registers */
+#define ID_AA64ISAR0_EL1_SHA2	(0xFUL << 12) /* SHA256/SHA512 instructions */
+#define ID_AA64ISAR0_EL1_SHA2_SHA512	(0x2UL << 12) /* SHA512* implemented */
 /*
  * ID_AA64ISAR1_EL1 bits definitions
  */
diff --git a/include/u-boot/sha512.h b/include/u-boot/sha512.h
index 92660d93357..f5757bce544 100644
--- a/include/u-boot/sha512.h
+++ b/include/u-boot/sha512.h
@@ -26,6 +26,19 @@ typedef struct {
 	uint64_t count[2];
 	uint8_t buf[SHA512_BLOCK_SIZE];
 } sha512_context;
+
+/**
+ * sha512_block_fn() - run the SHA-512 compression over whole input blocks
+ * @ctx:	hash context whose state is updated
+ * @src:	input data, @blocks * SHA512_BLOCK_SIZE bytes
+ * @blocks:	number of 128-byte blocks to process
+ *
+ * Weak alias of sha512_block_fn_generic(), overridden by an accelerated
+ * implementation (ARMV8_CE_SHA512) which may fall back to the generic one.
+ */
+void sha512_block_fn(sha512_context *ctx, const uint8_t *src, int blocks);
+void sha512_block_fn_generic(sha512_context *ctx, const uint8_t *src,
+			     int blocks);
 #endif
 
 extern const uint8_t sha512_der_prefix[];
diff --git a/lib/sha512.c b/lib/sha512.c
index 0e75c1a943b..461b68307ca 100644
--- a/lib/sha512.c
+++ b/lib/sha512.c
@@ -187,8 +187,8 @@ sha512_transform(uint64_t *state, const uint8_t *input)
 	a = b = c = d = e = f = g = h = t1 = t2 = 0;
 }
 
-static void sha512_block_fn(sha512_context *sst, const uint8_t *src,
-				    int blocks)
+void sha512_block_fn_generic(sha512_context *sst, const uint8_t *src,
+			     int blocks)
 {
 	while (blocks--) {
 		sha512_transform(sst->state, src);
@@ -196,6 +196,16 @@ static void sha512_block_fn(sha512_context *sst, const uint8_t *src,
 	}
 }
 
+#ifdef USE_HOSTCC
+void sha512_block_fn(sha512_context *sst, const uint8_t *src, int blocks)
+{
+	sha512_block_fn_generic(sst, src, blocks);
+}
+#else
+__weak __alias(sha512_block_fn_generic)
+void sha512_block_fn(sha512_context *sst, const uint8_t *src, int blocks);
+#endif
+
 static void sha512_base_do_update(sha512_context *sctx,
 					const uint8_t *data,
 					unsigned int len)

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261022-upstream-sha512_ce_b4-3f8c21d9a6e4

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

