Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4304606A31E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fWmq/hNh;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MZt+I1CY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WK1kmWON
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0037811D1;
	Wed, 21 Oct 2026 16:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b3GJNkZDv3hK; Wed, 21 Oct 2026 16:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0896C81164
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599016;
	b=XowzX5VEv9syTTALlCANk0GzFmc62C1O+cvuE+mlnwqWoIi7lqhH4oXAuSjElLhXAF+h
	 mTSztWu+SYIKhGHoVeRLhMDNY8QhcQsMuYXjX1GzXivrjC68Op8G6LdNHOPWb+Ngyx7cL
	 CzE3WGVMkQvqGRj/iMEHiuuqx/CI5ZDknSdQ2ClJ9olEolsTSYo4zBdAic9ltMw2l8GtW
	 m0gYn5DEilTSoVDPZkpcQ1mzZ8SMmQqQuzW/pmNS7z20fh0ir26ghvtvR+6wdlb4svgEx
	 1ScrJbU3Ml4Ecffx5nVcAWLq3IkdhdRqE4GjCSCnMvC+8D6uVYg+DwQxaEDmYh48uLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qQOLW+Pqr7mfnUxgnpe/uTC6n8+oaqDF0dJudUdG5ZA=;
	b=fhUicvyuECAx/zBaZ3u6PBZ1KSm+gjoQa5zQl8736yo/sdn8I7nnS4afHkASeA5XVGl4
	 fPJheIlREy/a1uPmffySEJyGPU0OxZp+cKv5F6EOWzeORtlgQbQwY+c+5vuJNQiQ6dKUc
	 nBqpf1lLz627yGfPd/pH7TBJGLv4MRCjaO555yr1L0BF5JTravh+z5PXBGsn2RfE0jdeJ
	 KjR/67qYQZaS32lHHAWZkyphEYAH0Vkp7ARMA08pfxe4qBnaQsiWHMRTKGhWxfmo+CSIh
	 xGedYJ0nJTihtOwOQrKBiVgSOFY+wb5OPf/4IVEM34vzte3drZy0LA4o4L5cnFg0Blw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599016;
	bh=qQOLW+Pqr7mfnUxgnpe/uTC6n8+oaqDF0dJudUdG5ZA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fWmq/hNhNnhHyYfc+WN/eF7Xbehp4nHMcofFFkgr+izoCheXzd8nrKBwVYyBpqKZU
	 fpNyIPYejeU03J2CjiYNcC0BeahStEX9Yx451pydKd4CpAdJOEV8cs1wzj2XfjHmtA
	 5K5HzSNIqc815JIeLuexpJpCDLWn8qDGn7jD8dhvW3Tu21lyszGv8vYCel20H0o2w3
	 pXbmCRF5PZ8kexhXCiKlaDNSEWKS5kHamVOerCX1HbBYmbs6916oXYOL0aKOkjDqZf
	 IGeop8+o7/v6XBClQq7zXDPO10ZTAR6EkxV/QoXIX8vjVgzxD6GmTpyKV+OOY/cenV
	 F5TFhML2EZoyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0896C81164;
	Wed, 21 Oct 2026 16:10:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E1FF81184
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8A904039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lVgfT_bizREw for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0C89440077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599013;
 b=BtKAnC40opaOiGI1l4axtvL9sFEhNap13AYLYCZsbPHTKIP1+C/HM3mwmo79jtLr9XvV
 pdXWNj0fbUtwbrW42Yn1RAty9j1cx1rSwAahtKh6cKdXBfJ75qXkJkxKmXCwKpvNLazbT
 5t84E68TgDQ84U4vkctbSXV4Bn+5QzU9yWKBHKKIfYfx6a4wsRIrhx+tZ9SM2McqBJ2dv
 evoJcmAjanNz+a2zX0tZVb5GNz8YjLfARek2lSN/XFgiVdA51ee84xIuOOSgwNykMPESJ
 wM29Ysyja5f+u6M0eQJ2i3N1YW4gEcR7iSmnWB8K5u4X4rBDG7rDAsERQ829GC8L3WA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599013;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=qQOLW+Pqr7mfnUxgnpe/uTC6n8+oaqDF0dJudUdG5ZA=;
 b=dfTRcvAK2u30DOjW3cTGZw+MHOo1RiORFDSopV6uIO5vwNXF5nWicPXZpx0E/sU4yi8G
 dkQg86PDG+ut68G8CNHH1aI0MCFlb+AK1wGm2jI8Time0eRWjZWTg9PYF8BEuK7FE1RdI
 KrqeJgrwjMgvaIGOFAnxHusKxesokGmkggdAjeM0HQoUBB82zia0g6wNQA1RlYcooabYd
 MalRROk6yQn0iX1mAyQMhzoN1N3Zb2uPKfPoI1YmUdMaH8oLTzKk2FhGnhw3by+7Ka7Qk
 VKQ96SjlFaNDhl8i+lRUmlDWPIMxSmouU5vtrQHXNx8OZtiLG8PTfYXp3hRXsxsgprA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MZt+I1CY; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WK1kmWON; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MZt+I1CY; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WK1kmWON
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C89440077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:12 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFwlXe1620782
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qQOLW+Pqr7m
 fnUxgnpe/uTC6n8+oaqDF0dJudUdG5ZA=; b=MZt+I1CYzBWUOKTLkgAsWrInkEV
 s5YaiuPWX/Ftml96s+UtOlY010pDTW5BOV6Y2TBDJ66uuDEAL8ZmH1Apm7FyuMEB
 YUtn9ZzXHS9PiN/r8xbdBMuKv7eKTKS4WfXAMhHoiI+CLov2BxEzlPBs/n1vQ5NS
 5jm84KnDrDNIzHxfiWknZ42KvwUzhfc7ip0ZWawufUIZyKAKrl+Y/9YMKuWBc6qi
 +Ma//WdUpYL8FOfMswVvSUarSZWaoJFuNnqY1lXe6ExlJEAmbdXTPp4bLBXlLaDM
 wvfE+B9sgD0YVZ5HeOKicAXb2bRJ+uBaGoTqbrXo7pktWRhPSF4NIewJt7g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajmu6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso3303939eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599009; x=1793203809;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qQOLW+Pqr7mfnUxgnpe/uTC6n8+oaqDF0dJudUdG5ZA=;
 b=WK1kmWONnXGWJ2G8/FmqEYg/yVZAU3YLYdRv/1tJU7vs0tVh2ngOlKEv2ff28viBqS
 Ly16H4swwbeahugBty0gCWJdlYpWipakgsCdkzON5iWAvKAHR63OFjV53igXcvnFea1j
 Rr4jzhN4G0B7aYiwbss55aBlOKejA8RQCvV3cjLmEp0QXnysKX3eJJ+4rlhqi8X8qQ7J
 Pe9ZlD2LVVa6dMt5BTD+G1tVUZ/EODnfD1MaULUzk6t1lS1C0Z2pQ8doZpKFcyoY2w65
 znRHSi3PI9aV2citNZT7Kgla+qRCDnEESRxv/Me2I2sBmgLrca9PPIXJNz/yveB6iRHu
 l00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599009; x=1793203809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qQOLW+Pqr7mfnUxgnpe/uTC6n8+oaqDF0dJudUdG5ZA=;
 b=ljneJJxT8RIFerTMMsqrqT/+TF6DDED6ssQkGnOBKcmNpAmZgT5bWEXbm4/bZ1AJSQ
 qmsL+lfxl88Lpwv9nBoVbV/a3pvtBMYYOeMTS4RvdYk9X7bFiDAtQUkCqEXc0Hcv83Ao
 FDYSpvvUbJc5gchZBwzySegHQUBPTL1LdVpx/JkQJ2ceBTzTiHq5usi9xDIOc+iriH2o
 W8uHIxt5nZMmxAFfp5/uHyAMwqZvFzlKNnSnln/sgqeIPsYqy4L43BlrYNip0G0Lliu5
 hnR7xMjVdMmOSqUjIudFRyzikZvdvAxz77HGOnvpDz/kWgBTtoIz3TBWTLqVfGqVFNf1
 ppzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgC6s0Zq43msCIMSEFfZeXKV2ggf+gZGA+EUQSGG8q0ebeqq5T/15rxLHCP+Dnonrht51u5xo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJoZUmXOAructy7ZpFW7G9SYntqCd+KojxJdXWC9uXqAtR/WCk6
 6s9073863AuQKfV9MufqjweWi4tcqy3iWpPLFRC52k+nlfyniuwXQK7kYlS106TNtaROIc+aqft
 a/e6Mg0X8r5AJqgyC34LkVS/0VKBc7/zv/iPtdKF1oHMPGMRqGoX2mxt7eD4jn7OZpaiMbNo=
X-Gm-Gg: AYBFou3HDk4M8pDvafIo3SlVGzLmXXCACXCi3WoSgzuJqoP1hOKo1fiBuLUFTyEoZaf
 mSPPMt3ixapj37qkildRhmMmHksSyXpWQb16DGHtrCI6WHkhT9cdf87a/dsjW7PQl0dt3BrbbAt
 JcYMEVUqDebzsZmcw3tnkQweME3VQqj69iM0ZaaTIuA36d8UwLcILpgjjeSMEGUy7hVocuMUjg/
 KI0TmGp50ykbcE95L2gpMGoRB/LS6LjcNwq3jJl2tz+GAH5q8Va9iMYkVMywCfrsOCLPi7dEQHt
 XODaL2tC/XhOZ22zKczAJM4N4Y5kwsQsjlIyk0dqBIt9e6om+83JRz7uBbUdYZYB2lHc6TgizdY
 lIHNuDtAI86hvz1A3oi2oDwV/kIXpE8F1b/Xekrn+ogE+9LcWU1NF1HrymaQh2QmSwEFfc19PRB
 sQpO8YW9gqGiZ0GlBeiqE=
X-Received: by 2002:a05:7300:d407:b0:368:6841:c4fa with SMTP id
 5a478bee46e88-3686842160emr577960eec.25.1792599009355; 
 Wed, 21 Oct 2026 09:10:09 -0700 (PDT)
X-Received: by 2002:a05:7300:d407:b0:368:6841:c4fa with SMTP id
 5a478bee46e88-3686842160emr577922eec.25.1792599008670; 
 Wed, 21 Oct 2026 09:10:08 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:10:07 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 06/12] configs: qcom: enable PHY_QCOM_QMP_USB3_LEGACY
Date: Wed, 21 Oct 2026 21:39:10 +0530
Message-Id: <20261021160916.3894471-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX6EYkc3lL+yoY
 WZq3Oiqtc71H6+00t5SP6vqXg/wzZIWf/S5hXaID2zm5nHinQQDWQdFyYrA8OXDhxfLCgN9PQQG
 dhhFuTQvMsjs+ami3DzwQB5QPqg09AMlxXg2dzKzWMx2YmEp1SKN6HbOU9avitMfUBOFPjKgG3H
 V0Z9xnkMnjVCvZfBRxqYG9wb2D1iskW/M1FaAYzzrOBpRa84LhiVNgvXZeXTHohCjqIMSFhK72A
 YtTyM8os3t9J/6IJY3EWq0YcL+5ah0d6uaet9Xh0rEdz4/xFvcqIpcX7Ww0KGnjjTnCVTQLlNi+
 uZZuulV1c3at8ljJOVWnBy3lVl9ysVs5fUbs5X3zY6+xl1hWWb9yqFv1+X9oMT73F5Hjq+AkifP
 Yf4W6xnnLgEdoO98ovifz3C13Oh+N36Ay4fmtmSIkQOvGOg0+ZT8kOXupWH+Mp3koU08+f2/ZGJ
 +KjGGQNrywdKLB5QIjg==
X-Proofpoint-GUID: 8exIYxD2hgoHMa7JXpQhUCcIybQiJNkq
X-Proofpoint-ORIG-GUID: 8exIYxD2hgoHMa7JXpQhUCcIybQiJNkq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX6w9F+79InSTo
 lDhwbNFjTWYBr13lteby+m45F9Etn3z5PVgv++imS9stecyjWXJuMiqaSeVmoO9KQHQaSo0n6cY
 jZhyE/N66Sia/4mQB1LGSb1bmzmDRXs=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad8e3e3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VaS5tULc7ycKRk0ZUFIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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

Enable the QMP USB3 PHY driver in the Qualcomm common defconfig.

This allows USB3 PHY initialization support when the corresponding
platform DT is enabled.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index cc66bf96f51..2655eaece1d 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -115,6 +115,7 @@ CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_PHY=y
 CONFIG_PHY_QCOM_QMP_UFS=y
 CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PHY_QCOM_QMP_USB3_LEGACY=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PHY_QCOM_SNPS_EUSB2=y
 CONFIG_PINCTRL=y
-- 
2.34.1

