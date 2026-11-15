Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB699606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A7CYfiN4;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CAvbMVcr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dOb8ydTI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A933D60740;
	Sun, 15 Nov 2026 11:05:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPQM6K7MPgTo; Sun, 15 Nov 2026 11:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF4A36064C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794740730;
	b=EqbLdMWJx4yjev7DhV3vw4vCVgUAkZy0JSL979mKaWLZcs08CfQ9/TA1+pV+lCJdkx9v
	 4xiy8ynBFZnljNOSgLhirclrmSZvGywRJvZUnQ6shGGBW4KTMJ0ZodTbOYaI/aH5E4AOH
	 qF5gzQR2UQStT5dKwQCyazIBUARikYNSSpnR6ISq5rdTBr4KNSWYoLVElnZUGGKkdJudo
	 6RWTSaJwNSPMnrOuAA/AlqToKpp0c3mUMPForPzMaOYFJdO0Awf28hReywyuwKg6rhAPH
	 gFEU1XB6/b58kAHToiFea103VMi887e+YJZDxlh3Ah967EW+HrNMElW2WtCTPogaJrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794740730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aHK+0SQw42IXNBaAW/b61Gk2IzV9Z5yzpXqrx3LeTgg=;
	b=VxYLYY/yiIqfe8NmdHohZLpBDkeSAqJiyZK135P9bFUUSaTvE59eW3e9cU3VuvW7xWVK
	 DWKu7ctLZrWd658In4aou+BCfvLuKQD54XvW3C02yu+7/ndPjT+Emhzj3SVEqg+otSfcs
	 yJ2TVOSZY6Pi1s5WhFPL1Z9+FsbLnEhqvFMfLTMF6fKq9KbGocJDkOiCBk3JsHzoczQF4
	 Hp4rOlfEgU9up2pj9TeE9kFzMFORXlJueFJiIl/A6wdYCZuOF3LyFgQAttXC/q7Mu1Vu5
	 my9+v5dToPZQ1kypxY7AD3hygzZFdG8Uj/xnhLjkUCngODo0kDvwapohVsBf4GEpB5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794740730;
	bh=aHK+0SQw42IXNBaAW/b61Gk2IzV9Z5yzpXqrx3LeTgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A7CYfiN4PWn7V41MgXBuMh8zk6owcZvXgzXm3OJEuztuWBgcid1GHE37wY19U69MN
	 EdtmkrjRh8BKQR5oaKjWZbNp3vDPiZS+nD9SrIl4GnPtP9vNSv2C44t6mW0mYqTpJp
	 qPGyDRVnSgjXYGQvYmD7Dd/9V4hwGhk6jnzz9SPGT7VfMexaxtgkhXsLVie4muWvlU
	 AF3qAt/Jo85lfe/kwFWhYTVD9PeHcgzdtUTHBn+ubXybTJ5riOO9QQ11vMSyQhrzMv
	 Hc1ewy4cbuj1DP0rKOly9tHRRdAYTCtXS6HwWQUCj6CpjjPRi6fEvwUEBVtQtxvzfP
	 VkaiVjS3P/adQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF4A36064C;
	Sun, 15 Nov 2026 11:05:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 40F7570B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 270EA40098
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PbKP62gRN55T for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:05:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ECC5540079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CAvbMVcr; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dOb8ydTI
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECC5540079
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:25 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7vu5K2205266
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aHK+0SQw42IXNBaAW/b61Gk2IzV9Z5yzpXqrx3LeTgg=; b=CAvbMVcr4iniu8pk
 lj/U0WuAQoqxHqX2wqi9azFtdult5e5Ygd3os9WfLriuegWkKkgWwrWu33RvkaNp
 hEOAtPzPa2oDisJHjtbPLd9DE1q/JBIWwYypcZTvrajINN/R2XZeMKyugoCaF7mU
 YZOkm8gfL5Ha9gBOMM+Gc5wxH6P63JV4mtLvi3OFJla/f70Mbgiuaun6INYobT3U
 WC6L5cmadPVnqBr0KYvx+EaZO/C137ulzJQngjyCugT+Jiw/FLSXrJnMD4eMScYA
 aOt5ujUKUgwgN26oWQpgIiDecTiLdfMME+0vqNYaXj34uJCJ742F+80DOUa/3Y/Q
 ei4pqw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhk22ttn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so3288225eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794740723; x=1795345523;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aHK+0SQw42IXNBaAW/b61Gk2IzV9Z5yzpXqrx3LeTgg=;
 b=dOb8ydTIVQDBdXPifzza8IxR811Vih3unU6+Rr+I8PHUjZ8lq/YcM47+BbQqhvDa2J
 EIIZKdRme6Y6LnVlDyncxcknbq+w3OEAHcnRq/0v67jRtroMPBq0VWkADHivm2xEfw/c
 i30j+SDa0iJ/VahCHGWJoPk59ewr6ZZe8dDCFr3xTnyLCbv4F7mMw2BQgnmdkWsHzpLC
 ZpsuKz8Z5+Y3yWBPI5uMC+ynDuMVn7VSjSXG273+iH8+rhcoOZKqCagX8QkRxQabxwF8
 e4BTlJpL8tfo3KlZc+kYFT6VsXYQPgxac7rhn0DkZ3fJTNaUAm+t/t6CUg5rhwUK6BSh
 VBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794740723; x=1795345523;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aHK+0SQw42IXNBaAW/b61Gk2IzV9Z5yzpXqrx3LeTgg=;
 b=ipZVNaGy4CJ+s6DUIHRnklHDRLnm8pM4rbwVZT9fRe3EvgSFrVpS1IETVVy3TP5SF3
 qjxamlcrOWxirsY+1MBM9nNzzsa0Pauv7eYP883ocfMXv9bgbI2wL5d2KnQ0bHyqPi34
 HeLzq7uZ/UpP/WrNgt3D2SABAsTGgZ05/+aaNQeVcloHMlP/u+B9VrRnCkWaIoz8Ikid
 DpU29zSu5kakLVMdpQvE5tq5jTT3GkFe8Zz07b/rJZH+yhkCdNrNqw/AHZK9e7Xvkflp
 C4ZjKW4HY5i1nxjtSrD6cqVU7rZXkW1MKFKOKSHj1ppeXIeRlJbjCKSEzviBVyk2h/w3
 wCqQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEOGNxeqU8yhcgGtcCfWD17dhe3nRpKnRSF25A9WbTuAVxqakgFpyePfSQVH/Y111jBAFx/2AQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ul9VMHBGwehKdbQjbVZShdEEJlv9DnTGIHdzUoPpdYvO6d0al
 FNgZDhBZF7hF6O1HwAKoFnvkLeJpZxKTihB9uiJ42gsBFty0gKyu0N30zejPLXxDOI8dbrCMG4K
 6nGNkduwp2LTdWAJtiFxceBjfbsGlOcZU9jGrbENQXO4WHsTaXL/TzTqNWdZXwKBsepVf/t0=
X-Gm-Gg: AYBFou3ER1SUWHtRUyRhSMI4Dn/uzUO9LzcUT+1qRUW3apVd7EYYeXp6XodR0RRkRbX
 +ZT+tcwlWmP31LiDak03TF2TQP/F7NhxHA7nK1BzUkrG4KlBAATot7sClFNULz4WvuUtID2lCY1
 yVcbbQEfzKFwAmK482VVO0Sx7j4L68aQKlEyzFv/fbe75EZYwNCdt+EuTS1Sp83y2UKdRsNF+kA
 xorwXPN+Z/rTkTTMDJKQDrTBgjjzsGE946UMOAL4L12yeM78YBqeviSUjWZSixF8Cu2TVC7XiSv
 BlQmhGshUbSPjsdRHaLuNNT9h8wZAzjLsjxfmdYmGGYWXgmrAsiIC0JIkdSJnZ5zMsrmNrMxIKB
 YeAUxhkuA0WCFPoBN96oSBUhOby0ea0xTJ9G34XQZ76JZS/qnH4mO5qpn0QA5gxfGIhxFvyVS+l
 Xxc1u0N/lgHHEfbl8RMeyO+IecFFNfhUFVce4Kw/fX/PLlsjEBJInw/nO9JnMlZ0JVJzrIFevtg
 Qns
X-Received: by 2002:a05:693c:2801:b0:369:d8e1:7bb6 with SMTP id
 5a478bee46e88-37967ed6d47mr6955465eec.25.1794740723044; 
 Sun, 15 Nov 2026 03:05:23 -0800 (PST)
X-Received: by 2002:a05:693c:2801:b0:369:d8e1:7bb6 with SMTP id
 5a478bee46e88-37967ed6d47mr6955422eec.25.1794740722051; 
 Sun, 15 Nov 2026 03:05:22 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm43456454eec.21.2026.11.15.03.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:05:21 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:35:08 +0530
Subject: [PATCH v3 1/6] fastboot: block: Fix NULL check on blk_get_dev() result
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-fb_gpt-v3-1-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
In-Reply-To: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
To: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.u-boot-project.org,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Masson <jmasson@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Francois Berder <fberder@outlook.fr>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794740710; l=1069;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=YY5ifpCp8dfhoA/ZpITXt3tGbIdKaMIxPUEQCRyGVaA=;
 b=4qHR4GPCZO6TqkJecx6dx1yFlJToWWiW/SbquMevVvPrfwb9QvextsCFO6SRBBbgG5KhTKtXK
 KDRv2ZJyjpQCMHMKB4888n18PIf7nCVvsaf++PhyEYWmh9tzo63RMrW
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: qrL4FTpAkYcXG81zKThqgs9v-c0U0mTj
X-Authority-Analysis: v=2.4 cv=QanzLcbv c=1 sm=1 tr=0 ts=6af991f4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=3WdiRz65hKaqbfPnIKYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0MyBTYWx0ZWRfXz9u2X7paQc1T
 bdaayQm5Ga4Ymotzc93brGUAqkpRduloTy4Yf4n3zGO4R0QuygvjlvHKD+ftFjcNYEDfwAlSdFC
 JLYQQ4gaSm7aa/1Tc2iqUa97cVvw3ZDq2zlFc7nd4YequYgz4X2heunv48w0LoiSa6NOSgsVTWl
 yjePjqUE5LZPpfNXoBD2pRYDuGGclIDReXuXwOwEXkekkyh49xJRFfdVXI/Dbhvm2FKFCerZaOg
 VhbAZsc2+OJkxg6vQUs9uXWgHW1jf/c6eRb77HBmJewTEHJEsldaQScBo+pzqTHDJX36hlS211o
 /X9Ecz6jAkOYL15oN2IsI3LYR0zgv18pMIBCP4p+Y1rYgi/Oyc13dsl0jJwHFoArvPb/vHhrqJ4
 ozV9KziHWXSJfYc519sUSdGBfu7HQIYuG9XeqWFCQTKtpuZJsHSq1Ih1i1DoQqHr80mVrGhL/A/
 hFulGXo8c/H5It5nTFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0MyBTYWx0ZWRfX4Rm6Wlj1q6e3
 erhKfAHip67/7rOHpdMgtYqbbrwMkXSdqURC9oM/cOuDomEXbRxsvWscvekLn281D/Bl7sbQLGz
 NqAd3R5RHvtn/sO+ZQ6ogpegk9gP2Co=
X-Proofpoint-GUID: qrL4FTpAkYcXG81zKThqgs9v-c0U0mTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150043
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

fastboot_block_get_part_info() stores the result of blk_get_dev() in
*dev_desc but then tests dev_desc, which is the caller's pointer and
never NULL. If the configured device does not exist, the error is
missed and part_get_info_by_name() is called with a NULL descriptor.

Test *dev_desc instead.

Fixes: 4bf92b541af6 ("fastboot: blk: introduce fastboot block flashing support")
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- New patch, split out of the device selection patch
---
 drivers/fastboot/fb_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 68593244ab9..16b94b8a0b2 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -147,7 +147,7 @@ int fastboot_block_get_part_info(const char *part_name,
 	}
 
 	*dev_desc = blk_get_dev(interface, device);
-	if (!dev_desc) {
+	if (!*dev_desc) {
 		fastboot_fail("no such device", response);
 		return -ENODEV;
 	}

-- 
2.34.1

