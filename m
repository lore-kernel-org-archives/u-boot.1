Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF095CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FBE380772;
	Fri, 16 Oct 2026 06:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zereq1wshIZw; Fri, 16 Oct 2026 06:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3869C8055F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792132418;
	b=Kf1HLcRhaIajVjxbOiLQiV6Ij1QA8QtLdNX6sjmdesfEGhRee7OP3uN0eF0Z86f7KpV5
	 D4Gav+fqZQVD3/RgbUA3NiGdi7BS/NwyuRjYD7hqqw9OgpqsGaZwjEXN6lcn/8JmPJYHH
	 3GcbkTCRNOq9D8IoVnTLM5aJTa++YL24Ki/3jAp/At2xSQkPquuKWd098QjKyCNMVW9iw
	 lViYpCbxlTjTkwxiQBgwvzD8mTWeifCRzoJ4DAKWJ/GwLkwRtgrb4ghm3yxCUd6WfOI6I
	 vkxiHoibSm83MxrJSyNejgefifhp7nrOeI5q1R65ucD+NC5F+KMK8o80DUww1nGyp6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792132418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VaT9UnwHGzYvVhkAniXbKhwm6csIoemcAB0GZcJGDx0=;
	b=PorJ+NWdjzOCanaz5cqpq7BduZyCtoBGlyXb2qSuD7tLv8yjAYrSUZrN6+6FvIP817P1
	 /934iCrxsASOKVR/R2nbfp7Poxg1ORzrF0nHSox9FsRKOMG7QnVPNXsS/KEfyv/QJ6W8E
	 07OfAI/J0qgj0AGsOLPXYcrkE05aZj/Q16PV/IjQpB1cF2Idc0Ggb5Jy22bnPbzzHLFnt
	 d+UL4paFiZd07obHA0IY1Pq+KLyqoq2OfpvnqqqkngL+1dH8v/YiTCYkDA7Fw5v/zqeb4
	 rRaJUppEyNBEkaI5K2tKgDFfCLawoOhLF9T2A/DuqL3ttYYOYSuTilXyQ2u8oiPaS5Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792132418;
	bh=VaT9UnwHGzYvVhkAniXbKhwm6csIoemcAB0GZcJGDx0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R6bu8YrvpFy4X8HsquHxV0M4fNuC4zd6bpui9wG7oR1sfaWKLMoVcHf734xYRJH13
	 wbjSHuZfPdXE8TWrQWkP5IEKv0VYVCyX/lb1x7C40hKXqfjMes3OM/Zv9O6mkvOr3f
	 /RvvczTb046FMsLfvtAKob3hqHOnuQbpY4SjCvXXZepOPkN4a6YruyJ36hkBpUmHM+
	 BZbag9eFcKvzYnfu/s3r+iL1YwyLSz4DL99HwS7T78ieLzYz8gFKdfn3Jh3ikCxzi0
	 97LdFKu4pUqzqmJW8yQmrcdFArm8OEifEpRFQDqbypfbW5SWe98yxBmlhuZIMUwl0y
	 VmkEwrdHDeOXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3869C8055F;
	Fri, 16 Oct 2026 06:33:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 86B6879D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7824B60AB7
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FYoGbUmP-nNd for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:33:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0B3160A8D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792132415;
 b=N5P27TJxqL1qvv0k2plud4G5dNJ5lSXm7lIMu2Lc0A9btouaeoRm592W6elFQ/CW+DwZ
 LHrStXKIcx/bX07OSQkwHi4lVOFYzTmFl4s4kGsyWMCL2ljt/3zuW3LbjD59pctN6DamQ
 YtLVQjUpkXIEUIIvyqQnSRy0IaHjIcvTfl9Y1B8G0gzAkxMNCAIUwomlggy8VCUSaW2Cu
 1qbjyFUyPRCLTgC49uv+pTKBJ7b3fTnjwSZnNrckSJaT2NcNrR/s1khMz8PyuP8JqI/1t
 jBifmy4Y9wJciqGMDKhdxrXve49erFZyuamEY1WokPa3kvQ2nAYcrrMPQyR7aDsennw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792132415;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VaT9UnwHGzYvVhkAniXbKhwm6csIoemcAB0GZcJGDx0=;
 b=SbaMcYE4nAEOJkEXtpYCYSYqNynVvahyGNXBJqcIrfgKcVA0DSlwIIZyqx3+dr2qLYT8
 52/dS5GrDmBmZ8TTXvUfqqbLpVOuI2POiC+zZARqS6XZoO6alK8TtPbUBUn9QG4ONc467
 hUTjfXr3T3V40uZkWDM7gjebfvyoxk25Gh7nIv+30ZQRMRmXc/pIP+MLl2eEfDpTEhjtR
 J1jVM/qr3ZZygPerOTDjCYr3x0sPNhjExLjplvUGYWmYEh6pk6HQBqcjFvJ3haNxz/mJo
 WmIshbE9KvqpNGzZxNVvmqaL+C+zFnGkNRbyNKZh/8fiMlJQnLrdvkxRT+x0tGvfDIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=WG4iGZkl; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iIq1sp7u; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=WG4iGZkl; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iIq1sp7u
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0B3160A8D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:33:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G6IG6l4126415
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=VaT9UnwHGzYvVhkAniXbKh
 wm6csIoemcAB0GZcJGDx0=; b=WG4iGZklHZd4WKrbPZMxVgXmBj6+ckBtm3yDKq
 LwOqqxWtjcJbV69FWZhrLPLjiHm1xtOPtfIvm2Lg6DcRgf/B6E4bMn8kvHPuR9Gg
 yoOOBaSoOJvcFFeVPOrT+Ec/sSAit4sSX7OfyFfL/18vDIO5PO3/kYmnxYGJcUaA
 bNy+rD2I4nmtSl0GyWVkhTGxEd/suqhUXzCl6ZuiuBZ5N9OOksl2MIPKdwXMTiM3
 kw+jMsrMg4r/QS4zZbh4TSKwZwVivZ5tTft7K4SO7xShTxTlkHlmYu0qIm4J9zma
 sUbKucw906PA57wS8qjF2sKa3cT4M5Wuf6LGWjrnhwfhu83A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m33ad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:33:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3580c07911eso15893706eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 23:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792132412; x=1792737212;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VaT9UnwHGzYvVhkAniXbKhwm6csIoemcAB0GZcJGDx0=;
 b=iIq1sp7utBJVwWwUx76vq5OUZXJ2DQxBbIyWhdAff2OuPj3xxc7TTSjsln3X7atMvK
 AqgggnSIOWsvPKfNv80FPdDl1rogr6uFT3eOzgQmvF8UYlTt2rHz8BI3uvL7UeZOsBMw
 kILVMEcWFx5Ji0c/4o1hlOSMD0WO9PIj6XIeEC75qDGnnQJPP2+V5zJpx/U9Jj+F2wD4
 AhrJeCRYUBZBwqcmbL0d2KvPzPgrL2Icjv+0tNH2ZKGu+rRFoEn5Fq9V6UWy0nsmU8zQ
 KNvzzn+RWxTQID8NITQe3+JCA06uj4GyhEVmci6ojg7yNWpPdQCom7lRksN727z3rIYa
 kW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132412; x=1792737212;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VaT9UnwHGzYvVhkAniXbKhwm6csIoemcAB0GZcJGDx0=;
 b=qXHOgmSoUtJbWeyPAAC8rIa3Sj+uc6PXwDf06++1bn9w5bitIgeK4JodeQrpCIlrMM
 +jQb22pO1otIP5zBjkJtQhigTugUNd8kTwrwuD3ygrbaVgCMKRr8MI+bjXfKVAhERjOP
 s9bXHJQkrzxVXBNASDsUAb+rOzujdlyxCLB9LEgyn7qaMk7IRNpj6SrG2E2aBXOfPnvv
 D5lpNBdnFxuNcIR3AqJ6jws56eSZzROgD41gyxj95+gjhyi3nP5HoFYK//ydxmdyd+ZE
 6TjxdqFZbdxZVjTB/8MDNFwQ6gswqnNSPFBYr5JWsTe422Xbrg5wU6zg/eK5z+B0Qp8t
 1l3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyqEA+Zdt+PpVN1O1BP+7/3l5cSXfoqu5MyzDAcNIFqgHia5RaYEP8vgc5/creP6sxfS6Lt/8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK2GzQoNA0m6BpvBnHUOjgSdc26yOLULQjTy3BpxjRBwQEcp2qy
 +zOMYyv+B4dc7LhUCAB+v6Npv/vM6luYVcNKHpXdMWf/Sw35YFXRu9N7du5iVoUhH1M0ek+YqoT
 8EisCoExgfbfAEBDSQ+0jckhec8w+yGRHSOubdC+7BmVB7qrQlyFciuSctjlJLcpsOT85X0Y=
X-Gm-Gg: AYBFou3exG659F+ZJbQz+pxBmiCyRBCst2pz9HGS4oW7q6QRKGBG5vgyFAwpLL+oYjV
 fBcpL1N1IJtRqzP5vo4P48vCuEa0o8oABALA2q/rJhDKHRRGPR4DbKm14kj5VCm3jr86ytI6phs
 sG2UZ7VD15GaBVt4Ld7BoNIwq43RmiXXXB7ScVM5vqPkmekk9te/9lb2VM+a7lbxYrjp151C+N/
 d+AivXYzIrOOZhvF8hYX0WXNoe7TQAKMB45fQy17MPO/OCLUcHNapGdO4xcPoyYiHt/pOwERs2O
 YW/t5JUp9bfsKiRAdoKvM9T5ef7Oqo9RscyWV1ugX36LBF+03blx/Xx7ZxutqRLt4AEbQDWd1/7
 b4yo0vdqAWG5Y+m9MnSfib9e1oJ06ydJgxTXqVNHDe0u9QiK7lxzdg1zs7yx9Uh4ZuAsxHi985T
 l+SL5T1GbEFGSLPaKMCEG8EOmg6yqtS2S72SfWqjI=
X-Received: by 2002:a05:7300:103:b0:35d:d9a9:e455 with SMTP id
 5a478bee46e88-35dd9a9e6eemr10937968eec.21.1792132411884; 
 Thu, 15 Oct 2026 23:33:31 -0700 (PDT)
X-Received: by 2002:a05:7300:103:b0:35d:d9a9:e455 with SMTP id
 5a478bee46e88-35dd9a9e6eemr10937924eec.21.1792132411143; 
 Thu, 15 Oct 2026 23:33:31 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm4281457eec.0.2026.10.15.23.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:33:30 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 12:03:26 +0530
Subject: [PATCH v3] clk: qcom: sa8775p: Add QUPv3 wrapper 3 SPI clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-sa8775p-qup3-spi-clk-v3-1-7b9867dbf65c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADXF0WoC/4XNzQ6CMBAE4FcxPbukP1LAk+9hPLRl1aoIdgvRE
 N7dgok343GSmW9GRhg8EtuuRhZw8OTbewpqvWLubO4nBF+nzCSXmldyA3YDZMqiyDt49J0C6jy
 42xW046JWwiqFhqV1F/Don4u8P3wy9faCLs7c3Dh7im14LdeDmHv/XwYBAkqsnKwKI7nVu4gUM
 9c2bD4Z5JcRXKjfjEyMrbXSeV0KU9hdS5Q9enNLUvPhpml6A1P/VRQeAQAA
X-Change-ID: 20260924-b4-sa8775p-qup3-spi-clk-6c01d31b33ea
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792132407; l=4640;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=9logGc5q22B16zXwUWmmTEo93v69/OK2WrRSqhL9+aA=;
 b=tgt1l2UQzJlvfEWwQyBZnz5apLCAmVkGkGY4hikp/XU8zkTGeMyJVGuk79CvWPBC0udIyhq2j
 wwKqc35ozI9DcYtHIm98NFPRnF3c4B7TuYKK3LRGIhoBBqAXsEq4TNY
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad1c53d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aBlBvB-F2evWav5k4gIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 0OgwEHSJj-LnbAk7F1mdO0j7Am5-zuXH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyNSBTYWx0ZWRfX4QWAqxmdm1zx
 S3DW7t0TznHsYKpEdQ23hFGctlI6CX7XBTRHRfcnPo3K7PZGGe5i1FP/8197OzEONbZWm7gbqTB
 3e3gGHqLR4U/q6PAZIMFr4pDvICgJiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyNSBTYWx0ZWRfXygZgJ9kBGUtd
 +uiF0ONm+YW9pLL399saQxYSii7qRKsL+oOc2yHjDcedLOex98ctL+34p8aJvESVzXV4XYe+crO
 wOeBn5fq1pQVg1CNh7VTEUEjgPdaZQ2Qpj9yAboxCsHWsRpCHWzRQOCq5Wx4n5WEiAyJX7aU4Ip
 it5o2y58TBKAL2uziiT3ZGfo2GCTtPilA1i4KwnsU/7/3WRzuq62CQFubRzTktCcFdvNZ9PFNld
 YLw61Bnwi66Manr4pTH1M/VZLNaP2dlr3EEgG2Q1TvElByWQkAeImwul6/6I1F2JxkfBxghzFbA
 8cEDkeJsFLzwdAf1m/C/pZpechQOLdvVo+tDnDa/2ASD7xMTHqiGBGy0szYL2JHCXQbqBuXYSiV
 7pryQjXylJdrUXoqNb7oRTaAJSwxBsKXEforASbUbYowHOrFNmK74zj1j2Ka5GNCfdeI6A659QQ
 OpAGGNqL661/e5xfOSQ==
X-Proofpoint-GUID: 0OgwEHSJj-LnbAk7F1mdO0j7Am5-zuXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160025
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

Add the clock RCG, gate bit definitions, and frequency table needed
to enable and configure the SE0 (SPI) serial engine clock on QUPv3
wrapper 3, GCC_QUPV3_WRAP3_S0_CLK. This is required to bring up the
GENI SPI controller on QUPv3 wrapper 3, e.g. for SPI-NOR flash
attached to that wrapper.

Also add the wrapper's M-AHB/S-AHB clock gates, and the QSPI/AGGRE-NOC
gates that are auto-enabled alongside the SE0 clock.

The register offset, gate bits and frequency table are adapted from
the Linux GCC driver added in commit 08c51ceb12f7 ("clk: qcom: add
the GCC driver for sa8775p").

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
Changes in v3:
- Mention the Linux commit the clock data is taken from
- Add Reviewed-by from Balaji
- Link to v2: https://lore.kernel.org/u-boot/20261013-b4-sa8775p-qup3-spi-clk-v2-1-bd6365d81a7b@oss.qualcomm.com
---
 drivers/clk/qcom/clock-sa8775p.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index a7bd6c43004..9ac914802a3 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -18,6 +18,7 @@
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
 #define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
+#define QUPV3_WRAP3_S0_CLK_CMD_RCGR		0xc4154
 
 #define UFS_PHY_AXI_CLK_CMD_RCGR		0x8302c
 #define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x83074
@@ -50,7 +51,27 @@
 #define GCC_QUPV3_WRAP2_S5_CLK_ENA_BIT BIT(9)
 #define GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT BIT(29)
 
+#define GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT BIT(20)
 #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
+#define GCC_QUPV3_WRAP3_QSPI_ENA_BIT BIT(26)
+#define GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT BIT(27)
+#define GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT BIT(28)
+
+/* QUP Wrapper 3 SE0 (SPI) clock frequency table */
+static const struct freq_tbl ftbl_gcc_qupv3_wrap3_s0_clk_src[] = {
+	F(7372800,   CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600,  CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000,  CFG_CLK_SRC_CXO,        1,   0,     0),
+	F(29491200,  CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    75),
+	F(48000000,  CFG_CLK_SRC_GPLL0,      2,   4,    25),
+	F(64000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,  16,    75),
+	F(75000000,  CFG_CLK_SRC_GPLL0_EVEN, 4,   0,     0),
+	F(80000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   4,    15),
+	F(96000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    25),
+	F(100000000, CFG_CLK_SRC_GPLL0,      6,   0,     0),
+	{ }
+};
 
 /* UFS AXI clock frequency table */
 static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
@@ -148,6 +169,12 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap3_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP3_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n,
+				     freq->src, 16);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -190,7 +217,11 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK, 0x4b018, GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT),
 
 	/* QUP Wrapper 3 clocks */
+	GATE_CLK(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, GCC_QUPV3_WRAP3_QSPI_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT),
+	GATE_CLK(GCC_AGGRE_NOC_QUPV3_AXI_CLK, 0x4b000, GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT),
 
 	/* UFS PHY clocks */
 	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0), 0x83018),
@@ -230,6 +261,10 @@ static int sa8775p_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_QSPI_CLK);
+		qcom_gate_clk_en(priv, GCC_AGGRE_NOC_QUPV3_AXI_CLK);
+		break;
 	}
 
 	return qcom_gate_clk_en(priv, clk->id);

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20260924-b4-sa8775p-qup3-spi-clk-6c01d31b33ea

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

