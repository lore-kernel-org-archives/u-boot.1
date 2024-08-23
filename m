Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FFDC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B8E88C4A;
	Fri, 23 Aug 2024 15:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GpMQovna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21B488C70; Fri, 23 Aug 2024 15:50:16 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A97D88C90
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so15104705e9.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421014; x=1725025814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rapHq8mT0Fevrq/9JxTGXRXySaMIV1ZV1VBfbr90Q3k=;
 b=GpMQovnaZ+W/+EG3QtKwuC1h5pLn/93M4HEYMRXgYqo6yGS0spf2Rb2iKqto9bZg6y
 Z1BtOPiwVEmEGmmh/fh8C+ciEDHENlO+kNZV0iLfIy65ZPLrqq9QfNFIExnc18q9B2WK
 b5iQET+SQIEx4cyqU+7SfcXgP5Z/xhgd6+y7GNZACPDcxnzPiqtV2hKen1UBX69M8ZoP
 5Vj5FopOqu2DN9ghf1vygwkRu168eyq4dbuhZaC0Bl/2O9PQBLy8Mo7eqJrtXoNpFFtO
 Tg4nt6GeZ+CrCQ4S3V+v9LkaAUhD/aHGBBT5jDg/8ct/tQg4CZeDq5lXtukvR6E62psh
 qTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421014; x=1725025814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rapHq8mT0Fevrq/9JxTGXRXySaMIV1ZV1VBfbr90Q3k=;
 b=psrNOf9DTwh0Swho2zOrHrXj1KRq1BIs51K4ewiHxd3pP3vdWc1osdfgqgWIlEgN1d
 0SmFdS51FXna4Lk41GhrQM9VwL+QUY2DJBsQDwXH0k1GItWlulGw3iHb9S9LDrA04XpF
 xjOrwa50gmJLUpXBzyvBkIQzeIdA72NpkTLwzNd1CWyHi9YU5UkVitj/oq7MNphuZpQ7
 3R/lWysZqYFWd00xy53DA+wWaDh6Wt777bYfcetJy/EHOL+7LyoC02U1+5ZgQW9nAMPO
 lH1uodG6tpAgbe4UEMRROVucWtgI1Ykk5ii27qldb8ITEnSCgjzjNxCRqvqkzW0wzesu
 7lVw==
X-Gm-Message-State: AOJu0Yxo4xAkHqXo/Wh6uiNHCt9JX0ONo1o7tDIKVkFcSb6gJmZT5X3t
 /Imw34GSVOCGAOh9KApf0IVu3e1gCuaLmCw/BK79HbRRb6V0SNrKSnwaz4O3GTi/wOszJnTgpLB
 wRuexSnvI
X-Google-Smtp-Source: AGHT+IGGWeq5tFcYGiEzkFHFTCa/e4grJwTltEywjGY7fSFyvWR5CfQ8NFizp8zSEjiMGVPz5CMw1w==
X-Received: by 2002:a5d:6d06:0:b0:367:8fc3:a25b with SMTP id
 ffacd0b85a97d-373118e551emr1627876f8f.42.1724421013698; 
 Fri, 23 Aug 2024 06:50:13 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:13 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v9 33/37] Kconfig: fix undefined symbols (g_dnl*) when
 NET_LWIP is default enabled
Date: Fri, 23 Aug 2024 15:48:37 +0200
Message-Id: <49c9454c4ee803376d59233a712ba04df98b9ec5.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

Fix for link errors on am62px_evm_a53and other platforms when NET_LWIP
is enabled:

 common/dfu.c:34:(.text.run_usb_dnl_gadget+0x68): undefined reference to `g_dnl_clear_detach
 [...]
 common/spl/spl_dfu.c:29:(.text.spl_dfu_cmd+0xb0): undefined reference to `run_usb_dnl_gadget'

- DFU_OVER_USB compiles common/dfu.c which calls g_dnl_clear_detach()
which is implemented in drivers/usb/gadget/g_dnl.c which needs
USB_GADGET_DOWNLOAD
- SPL_DFU compiles common/spl/spl_dfu.c which calls run_usb_dnl_gadget()
which is implemented in common/dfu.c which needs DFU_OVER_USB

Therefore add these dependencies to Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/dfu/Kconfig        | 1 +
 drivers/usb/gadget/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index d034b501360..7de629f103a 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -8,6 +8,7 @@ config DFU_OVER_USB
 	bool
 	select HASH
 	depends on USB_GADGET
+	depends on USB_GADGET_DOWNLOAD
 
 config DFU_OVER_TFTP
 	bool
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 03fe3bca197..ce9364c3172 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -324,6 +324,7 @@ config SPL_DFU
 	select SPL_HASH
 	select SPL_DFU_NO_RESET
 	depends on SPL_RAM_SUPPORT
+	depends on DFU_OVER_USB
 	help
 	  This feature enables the DFU (Device Firmware Upgrade) in SPL with
 	  RAM memory device support. The ROM code will load and execute
-- 
2.40.1

