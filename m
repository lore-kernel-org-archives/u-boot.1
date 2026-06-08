Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8B1CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 833AA8466E;
	Mon,  8 Jun 2026 11:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHaU4KiP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JR8Sa2Oi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2650C84701; Mon,  8 Jun 2026 11:06:53 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 018E5846B1
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586OtXZ2384526
 for <u-boot@lists.denx.de>; Mon, 8 Jun 2026 09:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3OTyOZEp66OWiNp/bR90apPw8XYcuN1rsi+F+dLgwfQ=; b=dHaU4KiP96KVq2Fe
 +6KSb1ANYtpuJfCiO7YsSnabm2R3S8v99lhStDbueEhkQl1u8wsPf41cOfyoORh9
 eNo4denNE/kcypQLe5Xd7r8/xJo+gWBirEJ66bT7pGiYghlfV/x9nJFiWLPoPH6t
 9KxQ0z0wpYvEGc1RdAJRbIUBJ9BFjrAAW4wYfH8o+Nk6oTEoDr3v6cxlPNnX4W0W
 AyOHSjL+yTHabUozKzgEkv48tXsVYhKBPREZPEB+8DITv8SDl7yVNGknQ72p+E0q
 18MfdJziuknNKtTAtrWkZ0rS5Qo8TtZFq4JNuXKmdkxOyqwLI+QtJSHEB7OO+fAv
 GRenfA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1evek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 09:06:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2befec3fd8fso28547415ad.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 02:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780909608; x=1781514408; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3OTyOZEp66OWiNp/bR90apPw8XYcuN1rsi+F+dLgwfQ=;
 b=JR8Sa2OiruuwYKtdxbttlZa/IjseQ43u7Io6Tja9os3x/lkgq8nL3MfQni+ZRRmkSZ
 8K20nB365iBRdFvMllhXi/GHxpiF31wpLPdVx7DZ6BI11BDWnQyl7e5c5c2FL6rhdLy5
 DE/ZRiAcCyU8UDtscZfsc3GV5tWJRv/j4WrRsxrRWBUIeUtkBFp3pi83RT6ICl6qtVqv
 cFrRHg3mxVQrhDwT3dwvIcnrWuNkRzNcU/KWI8ZvLkL6RHMcucEVd1vgPFoW3wW4BDAv
 qFze8J5Vk7/HxbMisNRvBvW4gqf8wPBOdU8uzUCB3/V+31L5ZIdqzCmR3fNzOb4eRnPR
 cI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909608; x=1781514408;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3OTyOZEp66OWiNp/bR90apPw8XYcuN1rsi+F+dLgwfQ=;
 b=E7hQcuv03trhn3H+3OYTovgghOhczrZcG7gLjgmS5rRnocV+t5+cIM2ZxXOjAjobHM
 iiTXDsfOHDet7muzOSYTx31QHolEPrKnjf1sMZb5uWRJhso+4rGpYIWtNAQIafmdgtSq
 uxKeS8K5dqF0N7zXqwmCOc6vs/nyia4XXXwLa+V3TVwJfs3M3/U76GnqekMtRW8MMcTB
 uLGLRT3k4VX97WW+H5LSoMu7vG6Gb4wE8bqQAKd50mZeKwavHkLcYXtp7VSs84Si37iW
 hykY9L0m6r0Y29a757FyMmp41OkcGXfhGoC0dWnBQkURUouw3Ip1ANKmDSwC1uVVgurv
 Yzsw==
X-Gm-Message-State: AOJu0YwutvyYh6pVv73CoZH140QyA78BAWV2XWced4m7WQz7bg+I5uoL
 zLX5MnWBYvMqUb6a4Mqpe8S78oS1zU7tg8ET/AatDk6LzwiCDnBpD5nRWFRf5oUdQ7eZ+MAv/6c
 ezBNjkIZZTfOpqSulD3w/C/+XHrlMHE+lVFSUvKguUlDPQ83/KS6mqaCm
X-Gm-Gg: Acq92OHcCRozJhHseSfkJcvL5AP/hEUPOG9n6G8cym1uLrJQ3kEB8qvPNklM59kOx09
 hOuSZ38VlqG/djugDsUA08617NRHqpf9b0i+qT7NrVVczQ5UcianRJplQYFE44q0aSRy4Lx7rvX
 MumO3hgVZZ8ovm4mwDovNkrrrcvR0p+v9Lzg+stSFO+yBvJW1AHiKVEJbY2L9CmjzYw1Z43nYR5
 plNbVyUCYQwLBupqT8+VQ69ddeiF4OK9XbhjL5ooDVXuqLpyQReab3TdZjJkAfm1eSvgFsIDfBj
 jTMOvovurS6WMUrZg+0NLP8rDYqIyX4hQv76VBn8wCudJuyh+YuzDkQ6KCVc+B7i4Bsxa5HJPz4
 /AYs30WusEgztWdjm4o8NLY/UmLrIdQrjMArmhd0hWQrbqlEX36JIKdEJJXxRs71ggWyhKTlvzK
 TzgqoSCSnyu7EouPW+sUOTSi69Lj1OV0nzJHl1fE8QJ5KLnn3bq5B1XMA2obC+
X-Received: by 2002:a17:902:da88:b0:2c0:b5c1:8e21 with SMTP id
 d9443c01a7336-2c1e7e4ca11mr167170915ad.16.1780909608404; 
 Mon, 08 Jun 2026 02:06:48 -0700 (PDT)
X-Received: by 2002:a17:902:da88:b0:2c0:b5c1:8e21 with SMTP id
 d9443c01a7336-2c1e7e4ca11mr167170455ad.16.1780909607895; 
 Mon, 08 Jun 2026 02:06:47 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f8679esm169309335ad.21.2026.06.08.02.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:06:47 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 14:36:28 +0530
Subject: [PATCH v2 1/6] arm: snapdragon: Make SYSRESET_PSCI optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-snagboot-v2-1-036bb0343bf7@oss.qualcomm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
In-Reply-To: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780909590; l=934;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=/D0T2TOP3RxinbwqS7OlWvZDXdyouC02XD6EAgTyViI=;
 b=u64h4/wTFVHBRvgHUM6NQyZrCyovkQiJyX9h2ZeLbwUDUpaKqpHsN84wcLEnbNdFLfk6I8LuX
 4XbBqcGKZwgDEFo3o0dypz50ODJwIriZKJ3pd+bF8Dg1MHU6zmEChKV
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX1uJzEKnhTlng
 y9trzvMZEs1xf2u8aXwpNYanZ5SYvyTBpAxATxJIMTO8J0x71rLiVHjTsJ5Vw+pvV2MkqEBtDRQ
 rW26c6SE9gDQHoGGrlw26ZzeKH0JGrpq5N3TC0SW1kJYmL2xrTMWHJSTJ0Ihod+O/YMVAbmJrW8
 pwrpbSiFDX8rNd9uKyKtzUAZh1F2hplPmr2khEGVL8vVnB6YVHFQkXAtdne0rpyvvoDR4ogQWR6
 HaR54ihdm7IfVdaBo7PSDcV/FYd3t8Ox1NPdasclg5OcuwH7t79hSu9c1nyTOLjCJiziPYOFDHV
 mMOKNqYJye9acIp2P8JC5SGo68hS9y5NN60QM/Upu3x3KcZi6OKR5gcEQCGhcjring6A2g23hYk
 EIC2KJ2a+y4LvdWvyzk/qJvqNFpNIiIhyhJat/TAX+gGeUDAC54qz39LP1lX7TkYJP3k2770LFO
 5cYRk8GScXTzsZiSWZw==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a268629 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VnBfpxNZQJvp5ra4Os4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: rZSub-aIlXlLNVpdGJiYX-jQGwxDjF4Z
X-Proofpoint-GUID: rZSub-aIlXlLNVpdGJiYX-jQGwxDjF4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080084
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In snagboot mode, U-Boot is loaded directly by XBL without a prior
bootloader to initialize PSCI firmware. Forcing SYSRESET_PSCI via
'select' causes failures in this scenario. Change to 'imply' to
allow it to be disabled when PSCI is unavailable.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly introduced in v2
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 514bf2000b4..a6d36f39069 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1150,7 +1150,7 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI
+	imply SYSRESET_PSCI
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
 	imply OF_UPSTREAM

-- 
2.34.1

