Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15F0CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66ADF6066A;
	Mon,  5 Oct 2026 07:04:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PK2r5PC3CCnc; Mon,  5 Oct 2026 07:04:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CB6B960613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183879;
	b=CvnerR5FT/v+puADup6FCcBlKpLFpqtBbSnw96Wf63iReXC1JDOph3vgKRSSQuDcvRI3
	 YZ/r2Ay7s91LwftpaIyPQzCgUObs1W17ZKtRhUONjoorvfdvUdcOE78zNiCmV4G1LmuwS
	 cHQLstcDNdQIfDWhBhJ8nSuC3ec2AtXv1lriHfkp7pVEInHCHxWRXY03EfJ1Xx5euBVa/
	 kD9KmrmJtRNUH6zr8J1yTo4knUrdLd3AbbeRgYTdJ4DYwfU/Jsnx6Lnb35h9+JOmE8yLT
	 5EMXJWhS0np81ns/NGlfYKSCvktSk85e6kuHju5Q+rlDeVajSTj6NS32ODdxUYOkKiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
	b=djFrbx3xbO1wSffgfphkp4pqF4jcXx/wGbniZTRTgYlX3nJT0PohhvKxQiuOc+5iM18R
	 BiLo2pd9XkdrW5WT+5ircEiRkPbB4VIhDsQhmD494bbhLI92QDvYcOtZBJ7aG/e2eAIgq
	 ykaXbsDz4YGUtT7rbSxkfnqSFkW0UTBBwPra0hRcQkq/jg+ZluItJAWRhNpPpnzE39yTj
	 0aQ6IxgJdijEgdnnONfD0rqVl6z8pESZ9NONi5oc9zAsK6C+6iu0VXgtq/tD4j5snk85p
	 LR/imgaKMz9mmKEIkQR4jgBjWAzxRlzqIt9AGCIWm/WZcY3nBg9YEQWbI7QGc1FgxlQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="X90tR/rM";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bcYKsxJ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183879;
	bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z7yWG4vSRciG+iNB6gIt5pKtNjZkYk2MEtq8NIxmx4VW7qDc5NMi9xVFeNhTM8YCa
	 NRnTGDvuwvE+SKlCvfvEjn+ZamuPbMZYzLNrRbE01d8AxQn3Bz4rb28oMTzq7dpXLB
	 W5woHYv23nCHHvvzr+2XyxARlclqq9GyPqWYt+KDr2vbZiBBD5FTI1W4vLqoEo98fU
	 E6cb1n6xb/QjkBM4s6KxaH9IYcczLGWMml8FwXaPNJMqpvte1zzyKUyWx0V1BL6WZZ
	 OADmvhIGPE6QJSCeYvy5RqgRU6Euv713v5/mBOQEVDNV94PgGLbeHmpa6EIednMNtE
	 mtyrhkDl/QeAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB6B960613;
	Mon,  5 Oct 2026 07:04:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BEA234D
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3E9C60606
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ipc1tmQkcm6M for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:03:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 24C01605D0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183783;
 b=Jks+wfowZwdBTXpNpMPmP2I4YJ0rzz0MPKC4f0frHNGPTbp2omMRWdCyDwYW7Ez+AqdQ
 mYhLxmJRDCGbrtCcO7VDwHWE6b5f2DaxNjchtmDTFqdOa55+rCVp03EPIsJf97sGZ4Sz5
 MgAuALACA3/FJPuiqSpxZIlmHGtzeNa9h5R1aD0JQPvXartFW4Z/Vs1D96ABfLcQ/kKgO
 /h9PS4xQTxajyLX6wBlyOMxCzGK9FwugMb7J67zeBo/6zyLiG4hNTJGrLtkp2uxcsISx+
 x//GbztdBHXytSRW39nITw263afq0hdowwzRDpWSTd2pDnCBZsbuX2RLX3ROJMpKtZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183783;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
 b=RS2XUJRpAsQEER19d4puKwR5XtXRYmrh82SXejib9agrxh1tWy5m2OxuBvqYcOuERDH4
 GmriI/0fzkBXXtMDcea3DRbkoigjOfOYVOb2/VqAExODUcKs46zAbeqUN3RSDZc8itreB
 ylgZlob7Jur24tf1hYDMlRa4IzJd2/NRohsSGhv2fUUpxAMzYNpXakTsmJDMffm2fseTy
 O8CQ5GkNKPBKRUwlRXhpdxVCEAI4jrSYoEGkqPsg3r7fLKMyUrcCEhpbkLwRdNXJeQwIH
 Z0hna9FUasvbMiUlSxBVWSOwxme3M15MwDEYVU/VSe5c8UgVs2rr3xFUKqZR0WLtnrQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="X90tR/rM"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bcYKsxJ9; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=X90tR/rM; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bcYKsxJ9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24C01605D0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695102EL470523
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=; b=X90tR/rMo+dUrG8v
 G/aqaKvJqJ1kT4x9ttN0ocb1ttcF95N8iANyRHETLWvrziZJz+qXSeKDahAbTDMz
 lHsqx/2VMhgfhUk8usJvkkuxfjlj0JJhpTzhR+i3ksixz4PU+BOelh8bG3IU+2jx
 e45XlG1azCpKiI9F+QFdsGWdLPb0FFPUgnHp6OfngBeXmTOibrxRfGvkao+ru40G
 njjzFthcsPY48E5xycX201Z5wOin2UR4zVf18QeggjjWr/dRdF36VgxRIfhZ8j90
 KKG9khFTGmqar7+r3T7JJ9ZXPCBxqE2Xe+oiF4RmZgjPktEbq8/ftn4PdXLxSQVo
 sj0S3A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssuctys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:03:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30f1b904861so1780213eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183780; x=1791788580;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
 b=bcYKsxJ9+v2pzE/IVGCT91mhD0Rip7jv4Ldwy/7gUbY/HFVIJtHXcBgC3Aimp0m+hO
 lKh8lgKbnstCz6VwHmedNtP+8nXUpH2C3obCRxcIYhmocTjEzuqxLO2TlzhV2qMcVc/W
 Ral+6Qo3PxVqug6JxTrA8xgvzPgx59tjZAFbvxaWoWIGy2cN+Fcd2CrSrEGPscvfIl7m
 I+XrGCkGvVZg1F2v/4n57i2SClR8s/nZWvHaEpEwV9v2FRNaH9YUdNw6jHO3PDrx1HJt
 yIjP1C/9g1hevJOb1Ag47BJjZ7JJJZiUxPrre81yb/23mVY5rxEIH/dLpJ/xdwoP4NC7
 WM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183780; x=1791788580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
 b=R4+qtsyZt0PiennO1wAdj/FKUg1siqSWNlvfJY3sJaZZ7dWGnma2utKFl1bHhisDwt
 dqeh9F0aY5TvNCUw+FWeDA+POtm3rcmc4YU86boSBKvEbF4b+Ufj/ij1ZOLpls2zNRsP
 o/J354kOY29jQODC7tFRx2wGfolhxRd3PrqbvLHkHXSm56R514Z/zLdmwejlQ8uqMW1H
 q1LWE0JoTAtLcB+PUIrZiqRZZMksEQAuh3B6dm/nerkzKZX1+7uJHex8Ofp9zv6A/VZm
 trkItYR/w4/ZdYmXoeqqrU+vdvC0uT3+llaTVYG2t8fs0W2hKKYiE/c04X8iFYCfYOH6
 KRmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGx7bVAShjXTYB6lDf3tBiu2B2Z5ZnmG9EqlZga4rZBzFQcJK+MwIcpYP2tZDcRczLbZDdd1U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lLw3zV23l9T2cNu5JyVQlauMKsV2DugrM/L6aV1j4k1heYEI8h
 UmLIPMQao+mf9041YhPSnsopyZm396/dDbij4tAvufjqF+S6YyodB83piqaxLyzKVfBUtCtU3qs
 dR9Gbl6xufi38HrXy8eLsXeSU44EBH6DiZ/24r1lQmAvPGS6MOXnnSgAhaXR//DMo1Phcufo=
X-Gm-Gg: AYBFou1o6EufruzQSQ1apc8ixPaUGddqW+Zhv9juIKMelHZ5T6SDd/VShcb1iqxyIFX
 +pgWfb8mgZiIxOc3922e6m5eSyWM4Jo3LECb+TR5ytlJSYKV1AniFhySruZ5OnDFroobE5WogDz
 II65FhQMI6BYgP+JeNhjs3tYLvcwYX+XLJUIjbqf/n3tVFdr7bngOFGOXqPl57S/0VgqBlIFPN/
 T6fIKlZZg3LJpX9qbUgpOAIXeaHilYLcSFancRmi82pYhTetZm+br4d8h8+k/r3Bqlpta8B1PhK
 0VrbVMc5NEV0Aew47wFTo8JER3B6fMB3se3NhgIVMP9YN4Qfwbd3ZKZxm0Du4QbjMKzwhw9VX+2
 gzue8EyupsLN0GS8C/xJrmt8v885DbtGN1k5Po6O+tNLWZlh1H5eWl1J7kGsAUoizs2YpUtHtb+
 ULrctoqsZgG+7CmPnnZWimSlIdOkPg
X-Received: by 2002:a05:693c:87d6:10b0:351:1c52:3869 with SMTP id
 5a478bee46e88-3511c523a80mr7058150eec.41.1791183780112; 
 Mon, 05 Oct 2026 00:03:00 -0700 (PDT)
X-Received: by 2002:a05:693c:87d6:10b0:351:1c52:3869 with SMTP id
 5a478bee46e88-3511c523a80mr7058106eec.41.1791183779558; 
 Mon, 05 Oct 2026 00:02:59 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:02:59 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:19 +0530
Subject: [PATCH RESEND v10 03/15] mach-snapdragon: Add PBL shared data defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-3-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX8gmXE4dpyZST
 +z6YrpwCEkkwWZ4iWi8jzZWSeR6luIz0RjkX9jeqJsV0hE6zkMIrQXlR3OSWFTCqLymcimE4IX3
 Mp/kADIVrQ/Kpy5i2HoFdOsTCtZ0FnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX2EEQVGdnaTIr
 g7Iayyk2r9VkYT0AK6orTIFTR+v3wG22PWfISsIH23axTwJ110JqmE1Eu8fMjFFrBGT+g6sPm6f
 Iwk5JaFpMBe8dIKUYjRNs+cYOtmrPe3eCm2iH7bNUruYy5nTTT6ReET76zRqLmexrg3fhg4gfds
 mT1zZWEL4XeVNobgd56nU4I84bv0eFljGsSlrtnwovAgzxDZYCuN7onItP4rfL0uVLPMS4BiTmU
 RJUW+/fjC8BrZhCpfWiKk/e+1+OH0Lr3oKBLIZW3oL2F5geujZ4lkYV/V2Pf960Kdsi6WX0D+f9
 1gVs391UodKxbcFUWSq7wn3Cc2YSyzi7njr7v2G5TRgCMzbFDeHfbYJ7gvpSfEHPK7y074uuyg6
 GNo96pN/XK4b8LT1sPPdJfmIu4SVoudhWt/PFx/3VaXGcvJP5VeV6omYeEatWROItnhZdL1Qb9F
 i2kpu6y91HmcbcNg/dQ==
X-Proofpoint-GUID: EHV8h2Z1FkzMzwNyhdwLJw_Jxj4XtB16
X-Proofpoint-ORIG-GUID: EHV8h2Z1FkzMzwNyhdwLJw_Jxj4XtB16
X-Authority-Analysis: v=2.4 cv=FryQbGrq c=1 sm=1 tr=0 ts=6ac34ba5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=17UMeyZtP49W_7ZR7MkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

Add structure and enum definitions to be able to parse the information
that is passed from PBL. This will be used to identify the boot medium.

Since the PBL shared data defines are private, move spl_boot_device() from
board_spl.c to pbl-shared-data.c to parse the shared data and identify the
boot medium

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile          |   1 +
 arch/arm/mach-snapdragon/board_spl.c       |   9 +--
 arch/arm/mach-snapdragon/pbl-shared-data.c | 125 +++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 2360b7c658e..4f2f35cb9de 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -7,6 +7,7 @@ obj-y += mem_map.o
 
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-y += board_spl.o
+obj-y += pbl-shared-data.o
 else
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index d69f3e8aafe..41d8789a002 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -7,6 +7,7 @@
 
 #include <hang.h>
 #include <spl.h>
+#include <soc/qcom/smem.h>
 
 /* in SPL, we always use internal DT */
 int board_fdt_blob_setup(void **fdtp)
@@ -20,11 +21,3 @@ __weak void reset_cpu(void)
 	printf("reset_cpu called, going to hang()\n");
 	hang();
 }
-
-u32 spl_boot_device(void)
-{
-	/* TODO: check boot reason to support UFS and sdcard */
-	u32 boot_device = BOOT_DEVICE_DFU;
-
-	return boot_device;
-}
diff --git a/arch/arm/mach-snapdragon/pbl-shared-data.c b/arch/arm/mach-snapdragon/pbl-shared-data.c
new file mode 100644
index 00000000000..b9dce22c417
--- /dev/null
+++ b/arch/arm/mach-snapdragon/pbl-shared-data.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/system.h>
+#include <spl.h>
+
+enum pbl_shared_data_param_id {
+	PSD_ID_PBL_FW_VERSION			= 0x0,	/* PBL firmware version */
+	PSD_ID_PBL_PATCH_VERSION		= 0x1,	/* Patch version */
+	PSD_ID_RMB_MBOX_BASE_ADDR		= 0x2,	/* Not used */
+	PSD_ID_CPU_BOOT_SPEED_HZ		= 0x3,	/* CPU boot speed (Hz) */
+	PSD_ID_BOOT_MEDIA_TYPE			= 0x4,	/* Boot media type */
+	PSD_ID_IS_EDL_MODE			= 0x5,	/* Emergency Download mode */
+	PSD_ID_DEV_PROG_ELF_ENTRY_ADDR		= 0x6,	/* Not used */
+	PSD_ID_XBL_CONFIG_ELF_ENTRY_ADDR	= 0x7,	/* Not used */
+	PSD_ID_XBL_SC_EXT_ELF_ENTRY_ADDR	= 0x8,	/* Not used */
+	PSD_ID_PBL_TIMESTAMPS_BUFFER_ADDR	= 0x9,	/* PBL logs address */
+	PSD_ID_PBL_TIMESTAMPS_BUFFER_SIZE	= 0xa,	/* PBL log size */
+	PSD_ID_PBL_DEBUG_SHARED_INFO_ADDR	= 0xb,	/* Debug info address */
+	PSD_ID_PBL_DEBUG_SHARED_INFO_SIZE	= 0xc,	/* Debug info size */
+	PSD_ID_TME_CPU_PBL_ROM_BYPASS_FUSE	= 0xd,	/* Secure boot status */
+	PSD_ID_XBL_SC_DEBUG_LOG_ADDR		= 0xe,	/* XBL SC debug log address */
+	PSD_ID_XBL_SC_DEBUG_LOG_SIZE		= 0xf,	/* XBL SC debug log size */
+	PSD_ID_CURRENT_IMAGE_SET		= 0x10,	/* Booted image set */
+	PSD_ID_MEDIA_DATA_INFO_ADDR		= 0x11,	/* Media info pointer */
+	PSD_ID_MEDIA_DATA_INFO_SIZE		= 0x12,	/* Media info size */
+	PBL_SHARED_DATA_PARAM_MAX,
+};
+
+enum pbl_boot_flash_type {
+	PSD_NO_FLASH		= 0,
+	PSD_NOR_FLASH		= 1,
+	PSD_NAND_FLASH		= 2,
+	PSD_ONENAND_FLASH	= 3,
+	PSD_SDC_FLASH		= 4,
+	PSD_MMC_FLASH		= 5,
+	PSD_SPI_FLASH		= 6,
+	PSD_PCIE_FLASH		= 7,
+	PSD_UFS_FLASH		= 8,
+	PSD_RSVD_1_FLASH	= 9,
+	PSD_USB_FLASH		= 10,
+	PSD_SPI_NAND_FLASH	= 11,
+	PSD_SPI_FLASH_GPT	= 12,
+};
+
+enum pbl_shared_data_version {
+	PSD_VERSION_1		= 0x00010000, // IPQ 5332, 9574
+	PSD_VERSION_2		= 0x00020000, // IPQ 5210, 5424, 5610, 9650
+};
+
+struct pbl_shared_data_entry {
+	u32 param_id;
+	ulong value;
+	bool valid;
+};
+
+struct pbl_shared_data {
+	u32 version;
+	u32 num_of_entries;
+	struct pbl_shared_data_entry entry[PBL_SHARED_DATA_PARAM_MAX];
+};
+
+static struct pbl_shared_data g_psd __section(".data");
+
+void save_boot_params(ulong r0, ulong r1, ulong r2, ulong r3)
+{
+	unsigned long sctlr;
+	struct pbl_shared_data *psd;
+
+	sctlr = get_sctlr();
+	set_sctlr(sctlr & ~(CR_M));	/* Disable MMU */
+
+	psd = (struct pbl_shared_data *)r0;
+
+	if (!psd || psd->num_of_entries < PBL_SHARED_DATA_PARAM_MAX ||
+	     psd->version != PSD_VERSION_2)
+		goto out;
+
+	memcpy(&g_psd, psd, sizeof(g_psd));
+
+out:
+	save_boot_params_ret();
+}
+
+u32 __weak spl_boot_device(void)
+{
+	struct pbl_shared_data *psd = &g_psd;
+
+#ifdef DEBUG
+	for (int i  = 0; psd && i < psd->num_of_entries; i++) {
+		printf("entry[0x%x] = %d 0x%08x %d\n", i,
+		       psd->entry[i].param_id, psd->entry[i].value,
+		       psd->entry[i].valid);
+	}
+#endif
+	if (psd->version != PSD_VERSION_2) {
+		pr_err("Unknown PBL shared data version\n");
+		goto out;
+	}
+
+	if (psd->entry[PSD_ID_IS_EDL_MODE].valid &&
+	    psd->entry[PSD_ID_IS_EDL_MODE].value) {
+		printf("Selected boot device: DFU\n");
+		return BOOT_DEVICE_DFU;
+	}
+
+	if (psd->entry[PSD_ID_BOOT_MEDIA_TYPE].valid) {
+		switch (psd->entry[PSD_ID_BOOT_MEDIA_TYPE].value) {
+		case PSD_MMC_FLASH:
+			printf("Selected boot device: MMC\n");
+			return BOOT_DEVICE_MMC1;
+		case PSD_NOR_FLASH:
+			printf("Selected boot device: NOR\n");
+			return BOOT_DEVICE_NOR;
+		case PSD_NAND_FLASH:
+			printf("Selected boot device: NAND\n");
+			return BOOT_DEVICE_NAND;
+		case PSD_UFS_FLASH:
+			printf("Selected boot device: UFS\n");
+			return BOOT_DEVICE_UFS;
+		}
+	}
+
+out:
+	pr_err("No boot device configured\n");
+	return BOOT_DEVICE_NONE;
+}

-- 
2.34.1

