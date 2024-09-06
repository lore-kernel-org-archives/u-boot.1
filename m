Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF441CE7B05
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9202D88D04;
	Fri,  6 Sep 2024 14:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZoDwgqZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D00C88D10; Fri,  6 Sep 2024 14:35:28 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F8388D45
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374ca7a10d4so1257985f8f.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626123; x=1726230923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rapHq8mT0Fevrq/9JxTGXRXySaMIV1ZV1VBfbr90Q3k=;
 b=ZoDwgqZVNo70MB6tB+j6BY+Q6i6ZOmGgTsK+g5CtqdHGUN/cX38/lGco2nszEYlqJ+
 QGLYiPxeM/YttlnkL+gfNXQXwFcxzXy8P9t4UxfKrmQ7aJ8caQQLWrmuUzIPKj6pL3LU
 blfIdWR/M06CJRUZrGjBNiKQLQd0nSGcqsDPArCUviVUlcp0WcBirUDpZPpy+J8Wkkrt
 0vt6zxbccqHeKCgNB1MyVKWgXHnZM7IgAQfPTMnWwr6zuD8a5HIqzWNbe1FkzegevkQE
 mEMszqtd2AePSUUX7SxbWW/bLgWe5zrQ2LSByLALcSWiXzxNympOuJ+p6J8pTEw9hryy
 t1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626123; x=1726230923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rapHq8mT0Fevrq/9JxTGXRXySaMIV1ZV1VBfbr90Q3k=;
 b=Sa5bh+45fm9YisuryUS8anAs1rPi/3W2BA3mmBjvRt9Bl65jaXk3lG2kJM463oEHvv
 FWO1BegbkS+TKhgHCHTHcxddTCPBf5ayZk/9GjkAbuiM9BfNSTScytYmFHP0FRDMZHGi
 KZzK2SmA5sr4oUggAwHucvATKOrEnc3oGTaQNwv/waGNhnzk0ThA74MBOZETs/UBJNP+
 XNiKrlVT+F1eAvMDIIIDm0AkoBPHYz74ccmGWdgG3aChB9hqsGVnn7h1vsD1EQ8Dsknf
 WdMm0a2+SDo+RcH1wTzyqa6lO+uR/6C2LpOYLqW8pn+iWlLlv82WmkiieoYqTsUVgrqC
 HHyQ==
X-Gm-Message-State: AOJu0Yzt5SXIEL5m779JxtOuWm0UKbmbK+QG102hL7zLrgnVztZhCcKk
 9iov8E8gfRX82vW9G6oe5rnSQ+J2yx/dZWmiw8f2aFAs9ra0Uo44m+0iY6DKp30mu1uYtOmydiQ
 mgAaTjVeQ
X-Google-Smtp-Source: AGHT+IEMtEGnIZKMQlOJlVBdAcYCSiQzGqcBbuYPYL7b/wAROVEKuQwjAhoLra82rnmpV2bmnq4Cng==
X-Received: by 2002:adf:a155:0:b0:374:cb17:c62f with SMTP id
 ffacd0b85a97d-374cb17c6b4mr11172386f8f.11.1725626123543; 
 Fri, 06 Sep 2024 05:35:23 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:23 -0700 (PDT)
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
 Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v10 21/25] Kconfig: fix undefined symbols (g_dnl*) when
 NET_LWIP is default enabled
Date: Fri,  6 Sep 2024 14:33:37 +0200
Message-Id: <9462e25d33d93c670a882e6ee329ca7e6668d7ab.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

