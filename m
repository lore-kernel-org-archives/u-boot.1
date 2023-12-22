Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736CAC4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 741278785E;
	Fri, 22 Dec 2023 22:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pi8wD/rb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556E586FB5; Fri, 22 Dec 2023 22:32:20 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB8138785E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ba2dc0f6b7so1684845b6e.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703280735; x=1703885535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWhK9E3F7Z6K8heZtrBrHp5U+k+K1SV72L5UTRpSFQ8=;
 b=Pi8wD/rb/+3GqVoiF3WY8s1ujbX4y4U/Lz7R7s5mXkCmk21Benoxh8j/iu9ii4vFNN
 xbB/giaIorg6LGLPsNKPrSuorgm7Ommu2q01UqONFmRE36vqxzHRsyNmTHOUVvBtI+zJ
 gtAkS5fK812p63d7ij7CswrQlt4zXMUD8gpcZgC1gaQRw2GJkyHZhEfkw8yV3o1VMAZG
 CzgjsgjArl4ph4cEUAhybzACXh9X8Od1o7OjAYFobzEyQ5nlbu06gWXqTkZfSR0chP++
 h7/+/dB2CMLhtFtlnMY7DDsZQAQBD2J+VAXHafAn/EakXSEQAeJsbOwRhdwdkuTO2ix3
 Kbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703280735; x=1703885535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWhK9E3F7Z6K8heZtrBrHp5U+k+K1SV72L5UTRpSFQ8=;
 b=Xw/ut8+Nswv500Utm1iJ/IGaXp8Y7pvnouJ23UOkUXKmF4a11UnrB9HvpOY6TLYa6t
 Y+mojFwKRDJT0SisUTvxH/l1vTV60An4RzMG5mx9UjAmzkR8mWFbkKAjKjf/wnUK7uE3
 JWfeD4rNQu2koU1OAcXHlEso1RB8NhT66XBlStd8qwmcXBHZBgiFdC9YEDEt0iQEjyQ8
 EopJw5D/OFbQBbw5i3uR2rDiRISMa3LxE7g0kAZ+WjsABjwt4kBmiXAErNSQA7wO17Ig
 8hY6acN15n59pG6nHvBqatZ925PsvFgW8n5Cp26vuhm0Zu3lXmp1n0tnysQOTwXCBXOT
 uYfw==
X-Gm-Message-State: AOJu0YyQnPy8HLzl0Q9bj89DZEd6F+htkCSfzx3weD0M25bpTSiRv8so
 1gJIm261WrYklF5Iz2cIP09XWuJ5/70aJUj169r0qCPbNWQ=
X-Google-Smtp-Source: AGHT+IEmRRqLRgJTa83vJ/iawIx/LoY9kmHS7hw9aQEqSvawT0XGC9H60+QEs+7wQ12U0EruTw7apw==
X-Received: by 2002:a05:6808:3023:b0:3ba:1287:f3dd with SMTP id
 ay35-20020a056808302300b003ba1287f3ddmr2214975oib.96.1703280735255; 
 Fri, 22 Dec 2023 13:32:15 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dm6-20020ad44e26000000b0067f6ec98ae9sm1623096qvb.32.2023.12.22.13.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:32:14 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v3 8/9] fdt: update the document and Kconfig description
Date: Fri, 22 Dec 2023 13:31:08 -0800
Message-Id: <20231222213110.660402-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231222213110.660402-1-raymond.mao@linaro.org>
References: <20231222213110.660402-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update the document and Kconfig to describe the behavior of board
specific custom functions when CONFIG_OF_BOARD is defined.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 doc/develop/devicetree/control.rst | 6 +++---
 dts/Kconfig                        | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index cbb65c9b17..e061f4e812 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -104,9 +104,9 @@ in u-boot.bin so you can still just flash u-boot.bin onto your board. If you are
 using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include the device
 tree binary.
 
-If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
-devicetree at runtime, for example if an earlier bootloader stage creates
-it and passes it to U-Boot.
+If CONFIG_OF_BOARD is defined, board-specific routines will provide the
+bloblist and devicetree at runtime, for example if an earlier bootloader stage
+creates it and passes it to U-Boot.
 
 If CONFIG_SANDBOX is defined, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff89..12d61dc748 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -110,8 +110,11 @@ config OF_BOARD
 	default y if SANDBOX || OF_HAS_PRIOR_STAGE
 	help
 	  If this option is enabled, the device tree is provided at runtime by
-	  a custom function called board_fdt_blob_setup(). The board must
-	  implement this function if it wishes to provide special behaviour.
+	  a custom function called board_fdt_blob_setup().
+	  If this option is enabled, bloblist is provided at runtime by a
+	  custom function called board_bloblist_from_boot_arg().
+	  The board must implement these functions if it wishes to provide
+	  special behaviour.
 
 	  With this option, the device tree build by U-Boot may be overridden or
 	  ignored. See OF_HAS_PRIOR_STAGE.
-- 
2.25.1

