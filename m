Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381ACC54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 07:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE2887F72;
	Mon,  4 Mar 2024 08:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vnr0Izbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B39C38752B; Mon,  4 Mar 2024 08:04:36 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02FEF87F86
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 08:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e2774bdc7so1783519f8f.0
 for <u-boot@lists.denx.de>; Sun, 03 Mar 2024 23:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709535873; x=1710140673; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AwgvDN2NhfxhFl7uUAk9VyhpvKRScbwGY9nc/7nulb0=;
 b=Vnr0IzbnMWjjRBlWGWYev6johf0BuXpXVCeqYZBbEboBejCP2Xgov0wADEglRV84oN
 9UfdP/0xe5pWAruF5qhsq4gE3LVz+lSIx1ZWhFIShR6FwVdem67e3zZYLgH0yUFppDZy
 uxiL9E6rsMQ4+6zyCrCwpNaUBnEpsAXCtZ20oxtf/sAGAkz/9hoAADgYoEXbbB/JjvkV
 9zklgDadKXul/wdCo2CStfqI1nSFciK5Beh4d/rOmsV1aKDFYflr7T+W4++LTL+iG0ex
 u4zGDL6aXYPJ28L2vKj1Lf0s+H+m1H7ok+opxgLkhskdTcFIsb2YL56U74/Yp+qu4b6P
 s0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709535873; x=1710140673;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AwgvDN2NhfxhFl7uUAk9VyhpvKRScbwGY9nc/7nulb0=;
 b=aqs8cr02UF+1t21QJCx0Yie4cEhp+5hYHXDlty8ldALk8sfFvrZ9qsMsmZTGoDaNP8
 qRwevC+EYv7qPUQ9fihJCVTEckpKdZSvEsUdLPGip96FxGLY/8Ggv4jhBnUySAI4845K
 bdpKTbpf9H4bc5xHxbv6fnjbmzz9WpJ7YXOeWCDGF4ENgaknRU3R0j8AI844ElyW0axM
 zGpXVf6D01WpD2hEb5hcb7s279duiSamswZ5u0W6dK2wCYQgB31+ppEP5I9WZca1J071
 wtYc1UXUelAZvTrOgiizTyImjGkKBvXOklbnKxcjBwr1hcRcJGrnhBLV3ZwhJCN+modp
 n67g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs+dH8NtZW7/G3zPyFMPkevSKtqanGRZauw3tzyoownhmRogINcjF0BHOPcuKCd178xQU+3M8qZ3umKl1J0ylQKXctig==
X-Gm-Message-State: AOJu0Yy7lvyver5mKPKgLruWTLt1TgNOOU4xJD/wQZhkToRprdaLwB6A
 FIJFtX3X4WS1tIzw5cWm+gfvyK22OF+luoyl8SEbuK9kpPDhmXlqseBUkD1pKYQ=
X-Google-Smtp-Source: AGHT+IFA8XEBCfDJNHEEp3l1PCPuw8FcyjhLiEae/hW01uS1Od/WXUqIWJYlwAwQrKznRxr2cKeLow==
X-Received: by 2002:adf:9d93:0:b0:33d:9232:5aed with SMTP id
 p19-20020adf9d93000000b0033d92325aedmr5752943wre.52.1709535873528; 
 Sun, 03 Mar 2024 23:04:33 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 b11-20020a5d634b000000b0033d6fe3f6absm11233105wrw.62.2024.03.03.23.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:04:33 -0800 (PST)
Date: Mon, 4 Mar 2024 10:04:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Bin Meng <bmeng@tinylab.org>, Linus Walleij <linus.walleij@linaro.org>,
 Fabio Estevam <festevam@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/2] arm64: Enable CONFIG_64BIT for static analysis
Message-ID: <6a7328b8-eb22-4ad6-a1d6-eaecd2f8a067@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb3255b-5ed7-443b-8a02-6e998126d417@moroto.mountain>
X-Mailer: git-send-email haha only kidding
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

In the Makefile there is a line that says this:

    # the checker needs the correct machine size
    CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)

Set CONFIG_64BIT for ARM64 so that we pass -m64 to the static checkers
instead of -m32.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: split the patch into two patches

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fde85dc0d537..76d6a8cc6886 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -6,6 +6,7 @@ config SYS_ARCH
 
 config ARM64
 	bool
+	select 64BIT
 	select PHYS_64BIT
 	select SYS_CACHE_SHIFT_6
 	imply SPL_SEPARATE_BSS
-- 
2.43.0

