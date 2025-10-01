Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E44CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 13:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 954F883622;
	Wed,  1 Oct 2025 15:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMskucDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239D7800B1; Wed,  1 Oct 2025 15:21:27 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE9883335
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 15:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b07e3a77b72so205515466b.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759324885; x=1759929685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xJ25pFc0SDzRPngGsgKDY5l3KmIw9EOG4qkfORYT2g=;
 b=IMskucDjYLEBhfFL3/xIpIE5ZhhB3a3UgNowYhznSrPM2LdC13loDvDC5ss+6FEWL7
 828xfowDd+KNg97BAzu/bEFEkEqsPQ4F9M8VbBQg1iQWr5e9Wkpw3HOCoun954yiQVhe
 PS1fL+tc7esIvWHmFg5/IbPsXoz1efNp1PINT+/oVU5KZUdNo6jpJu2wfWXvsGk36gyV
 lljEthCxRCgSSFvw/hi2ifbSEUf7WHdLXt8s0k2JDjS32EdUw9c1nXAntnPYVgMI1BzI
 LjxcbbBan88MimOJ8NThM/kyH4VQoCBdSOM7AV4ryxeK609BVsZgppKemBpbldJK+dSM
 mQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759324885; x=1759929685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xJ25pFc0SDzRPngGsgKDY5l3KmIw9EOG4qkfORYT2g=;
 b=tQ3ac12Ok382wJkkY7gH13/Sk3iTpxlzrENyFqyvB8bMrhtu7JTNxJVRzy4Gw8Ps9c
 UJknK1JseJF4VkkN6+ncof+BpDrSdOr8Itp80dD+h+CNF8v38f0fQZuBJL1opJxjshwY
 fs1MxB7yZi2gUkknE4zn/itVUkfpCC0qyHROOMaCqKUup+OhBM7mPNztQHRozdAMhslN
 tG5HK9huI0/OV7TMB7UIJ0c4/nANlu+q6K7TuBRQhOkl0cled5E/FIEMSyJIuIDcV3TZ
 YHFJKcj6YJoP2MUZwTbMAELDin+edmmalGUI1Aj+eWYqI4VU0NlAwoAfHSTTi30ynJpp
 86vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdnEQ7wSNN9n28L9YCxRiXca9jPBKKipU0HesTpmPX/GCRRp1ocArMSbDtRjtl1VhSn/DP1Gg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7JOZdDBWfSzNqZD/4umnCHSr25N6vsliEgM/XRFj8b/AQBzRW
 p6pZwkR5434BN9gQBrri/kXs7HCbVmnaK8FS96cW8jRUoGi9bLVHrO35
X-Gm-Gg: ASbGncuDyJ5HLnyEfzmCArJyrUOdUbEMNWIbUzAWmQxFB7pL9xwKogMyGPDo9lmTISv
 R6djOfPqlWjGgYvu+oolxKQYsJPSY3IS3jn2VRN2XSbuE4dOaSRae/es9sotxTQVO7/63d/4ON/
 8k7bQzYaHBEH42m79OijvglVcK9pEAk3V1iaQvQb2MiDf3UtTSwW18mtZczx/6FvRf3p0nS+40S
 lEkdWcUWTUHIx7w8DF3hHW10u3+w1fIxa3m2v1sfqaM5A5Ki5MOAMxB+JJ9YCk2yQs+gcd14RYz
 cTxgeevfwGEdB94pYgnMsE8ATBn/XjRWP15gSODkXpdo1AdS5FUTovIJJM/GoFme/MIEijt+BWo
 X0ZxeUvdJ8Si1JK85alh/iVaWONI9smsqhJj7Vw+UyqVaAgVLVezMDGv5GjLYNmNGVIQ87fjLLy
 c73dDQnituYfBhegQnqwwmAZJh34rrcWxKamgzH8zlNa9H2Iq4O8cW3pYwTUMngQ==
X-Google-Smtp-Source: AGHT+IF3KyTFGSBHa9vxav8jeu5dOEBeUwUI8xmu/Elma2n9YcfQIc6vu/huypCUl/w9V/oIaV7hag==
X-Received: by 2002:a17:906:c155:b0:b07:e258:4629 with SMTP id
 a640c23a62f3a-b4138d53c0cmr1050021766b.16.1759324884426; 
 Wed, 01 Oct 2025 06:21:24 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b401d3d4124sm566956766b.75.2025.10.01.06.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 06:21:24 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 4/4] configs: toradex-smarc-imx8mp: enable USB Gadget OS
 Descriptors for fastboot
Date: Wed,  1 Oct 2025 15:21:07 +0200
Message-ID: <20251001132111.1490516-5-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
References: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

USB OS Descriptors are used to install and configure the device without
requiring any user interaction on OS which support them (e.g. Windows).
Enable them in order to improve the user experience when fastboot is used.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/toradex-smarc-imx8mp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index f8a984f1e6b7..311ceaae4363 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -178,5 +178,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_HEXDUMP=y
-- 
2.43.0

