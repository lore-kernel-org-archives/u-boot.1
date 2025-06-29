Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BF0C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 10:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BBD182E27;
	Sun, 29 Jun 2025 12:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PLeaPnh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E1382B34; Sun, 29 Jun 2025 12:57:42 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B5082B20
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 12:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-555024588a8so1209498e87.0
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194658; x=1751799458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IdiX5wW8KpqUP5qpFYBpJKNvtds5bLh8E3f9Ov1cFQ=;
 b=PLeaPnh9Cyplf+mpaF5E9jfaRQ6qvyKGradoZpNfQf197d5CAWZFuavSeqnjvbbzC0
 wzLu0HXrCduX5c3oC9RamczbNl0y+ldLgr7Hjijmim++Zb8/dm4b2itWo9mHIlkyXHeg
 rVoaHzUzCHTSXKAHbdJ7cjHZq2NaoS38tY5D6MEbBCVkEStp68vusGuvJOC6acvaEag3
 WJMh4NaiDb0ZeBsYplu24ww4u/F/JUuU8o3wi5akstOv2kCv4274xrlKrhRw1OCHoW9W
 0DfW975rEVctKirr3DLTObW67vS8Eu9bn7XFYQCYlAO9E+b5TJmSNQJ6HGA5uBLXgYUv
 tBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194658; x=1751799458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IdiX5wW8KpqUP5qpFYBpJKNvtds5bLh8E3f9Ov1cFQ=;
 b=G8T5YLk3P/p3PTnVRtU1k1mFYBh4WfXFTBjKOyidsURfvvG0HU0VhRsnav+2E+LNne
 7MnemjUz6I+MYIyxW3iqqkw+ig2VIyH23zgQQRKxjpqFzgQe/anDI7ooGNGAsu61MVjW
 laKZDyyQmnHMAmzZ6yH6IMe3mQDmr3eJcLTYKdb5w7M2dFrcpc3r2h4jVUrooxHWhCip
 RiZGhnfpEFLjWE5HJzeLyxPYCiNJfpRSTEZrQZGyujNAHGbrFz0KvjXzYodAcaGOs+EX
 uADSltvVriAB8nRq3CXnUp2oXV6Q2KsfEngATZQXpw/bNi+UD3VY+heN78q5fiCJTvw9
 PcpA==
X-Gm-Message-State: AOJu0YxoAFaaHwnrqBst1Nkh3exiW9gxojPacUy56WjKDDzclNbuAUA5
 ISeLTujt8QgJnz4nXKMPntZ/5DQaDQ51NTa61xUTKue9ldt0QAHVyX/C
X-Gm-Gg: ASbGncsTENJejyS4O3ZfirN443nvZ1YasdCJLQ/TIsPfDKYNEbVf1Jf6zy56KZUd962
 hyNIeZq2777ZoN4TdNz+Onr0mZTvYI2Iu3vc87tTt+djsHL2E/zRv5YvX1GAimSGcp0mN/s/HUf
 cmGui6j1R/OBxlhzrQXKlQ1cQb3z+/jrsxYO0QO+VXcJLukoI6DiGL6595cTl+3BussdkwrkmMo
 ZwtpIjZHftdWkML94IlMzX+2POd5kja2pyKesYUBIl/1WHJpaLg5YPhhKRvJw2ucyx45JOtcFRf
 kl2azq67pZcIuxQAp9fzXkYl1wRm2zEhOgfrCSv76KeFsTKItX4BDA==
X-Google-Smtp-Source: AGHT+IGVb3+njUOkYny0cFH1dIWsM1C1qfWsjMOdqdnTOvoYmCwXp50vIw7gHe/3waeZPCpY+ivtCA==
X-Received: by 2002:a05:6512:4004:b0:553:522f:61b6 with SMTP id
 2adb3069b0e04-5550b9e5b46mr3448623e87.33.1751194657828; 
 Sun, 29 Jun 2025 03:57:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24d32esm1092514e87.69.2025.06.29.03.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 03:57:37 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heiko Schocher <hs@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ion Agorria <ion@agorria.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wang Jie <dave.wang@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/4] crypto: aes: Add software AES DM driver
Date: Sun, 29 Jun 2025 13:57:09 +0300
Message-ID: <20250629105711.24687-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250629105711.24687-1-clamor95@gmail.com>
References: <20250629105711.24687-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

This adds AES crypto engine using the AES Uclass implemented in software,
serves as example implementation and for uclass tests.

Those implementing HW AES crypto engine drivers can use this as basis and
replace software parts with the HW specifics of their device.

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 drivers/crypto/aes/Kconfig  |   7 ++
 drivers/crypto/aes/Makefile |   1 +
 drivers/crypto/aes/aes-sw.c | 167 ++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/crypto/aes/aes-sw.c

diff --git a/drivers/crypto/aes/Kconfig b/drivers/crypto/aes/Kconfig
index 661dad64a6c..7e1b1b2875d 100644
--- a/drivers/crypto/aes/Kconfig
+++ b/drivers/crypto/aes/Kconfig
@@ -3,3 +3,10 @@ config DM_AES
 	depends on DM
 	help
 	  If you want to use driver model for AES crypto operations, say Y.
+
+config AES_SOFTWARE
+	bool "Enable driver for AES in software"
+	depends on DM_AES && AES
+	help
+	  Enable driver for AES crypto operations in software. Uses U-Boot
+	  AES library.
diff --git a/drivers/crypto/aes/Makefile b/drivers/crypto/aes/Makefile
index 2f409fca1eb..d38a2e1526d 100644
--- a/drivers/crypto/aes/Makefile
+++ b/drivers/crypto/aes/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_$(PHASE_)DM_AES) += aes-uclass.o
+obj-$(CONFIG_$(PHASE_)AES_SOFTWARE) += aes-sw.o
diff --git a/drivers/crypto/aes/aes-sw.c b/drivers/crypto/aes/aes-sw.c
new file mode 100644
index 00000000000..a65200fb79b
--- /dev/null
+++ b/drivers/crypto/aes/aes-sw.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <config.h>
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <uboot_aes.h>
+
+#define SW_KEY_SLOTS 2
+
+struct sw_aes_priv {
+	u8 key_slots[SW_KEY_SLOTS][AES256_KEY_LENGTH];
+	u8 key_schedule[AES256_EXPAND_KEY_LENGTH];
+	u8 selected_slot;
+	u32 selected_key_size;
+	bool key_expanded;
+};
+
+static int prepare_aes(struct sw_aes_priv *priv)
+{
+	if (!priv->selected_key_size) {
+		log_debug("%s: AES key size not set, setup a slot first\n", __func__);
+		return 1;
+	}
+
+	if (priv->key_expanded)
+		return 0;
+
+	priv->key_expanded = 1;
+
+	aes_expand_key(priv->key_slots[priv->selected_slot], priv->selected_key_size,
+		       priv->key_schedule);
+
+	return 0;
+}
+
+static int sw_aes_ops_available_key_slots(struct udevice *dev)
+{
+	return SW_KEY_SLOTS;
+}
+
+static int sw_aes_ops_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
+{
+	struct sw_aes_priv *priv = dev_get_priv(dev);
+
+	if (slot >= SW_KEY_SLOTS)
+		return 1;
+
+	priv->selected_slot = slot;
+	priv->selected_key_size = key_size;
+	priv->key_expanded = 0;
+
+	return 0;
+}
+
+static int sw_aes_ops_set_key_for_key_slot(struct udevice *dev, u32 key_size,
+					   u8 *key, u8 slot)
+{
+	struct sw_aes_priv *priv = dev_get_priv(dev);
+
+	if (slot >= SW_KEY_SLOTS)
+		return 1;
+
+	memcpy(priv->key_slots[slot], key, key_size / 8);
+
+	if (priv->selected_slot == slot)
+		priv->selected_key_size = key_size;
+
+	priv->key_expanded = 0;
+
+	return 0;
+}
+
+static int sw_aes_ops_aes_ecb_encrypt(struct udevice *dev, u8 *src, u8 *dst,
+				      u32 num_aes_blocks)
+{
+	struct sw_aes_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = prepare_aes(priv);
+	if (ret)
+		return ret;
+
+	while (num_aes_blocks > 0) {
+		aes_encrypt(priv->selected_key_size, src, priv->key_schedule, dst);
+		num_aes_blocks -= 1;
+		src += AES_BLOCK_LENGTH;
+		dst += AES_BLOCK_LENGTH;
+	}
+
+	return 0;
+}
+
+static int sw_aes_ops_aes_ecb_decrypt(struct udevice *dev, u8 *src, u8 *dst,
+				      u32 num_aes_blocks)
+{
+	struct sw_aes_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = prepare_aes(priv);
+	if (ret)
+		return ret;
+
+	while (num_aes_blocks > 0) {
+		aes_decrypt(priv->selected_key_size, src, priv->key_schedule, dst);
+		num_aes_blocks -= 1;
+		src += AES_BLOCK_LENGTH;
+		dst += AES_BLOCK_LENGTH;
+	}
+
+	return 0;
+}
+
+static int sw_aes_ops_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src,
+				      u8 *dst, u32 num_aes_blocks)
+{
+	struct sw_aes_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = prepare_aes(priv);
+	if (ret)
+		return ret;
+
+	aes_cbc_encrypt_blocks(priv->selected_key_size, priv->key_schedule, iv,
+			       src, dst, num_aes_blocks);
+
+	return 0;
+}
+
+static int sw_aes_ops_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
+				      u8 *dst, u32 num_aes_blocks)
+{
+	struct sw_aes_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = prepare_aes(priv);
+	if (ret)
+		return ret;
+
+	aes_cbc_decrypt_blocks(priv->selected_key_size, priv->key_schedule,
+			       iv, src, dst, num_aes_blocks);
+
+	return 0;
+}
+
+static const struct aes_ops aes_ops_sw = {
+	.available_key_slots = sw_aes_ops_available_key_slots,
+	.select_key_slot = sw_aes_ops_select_key_slot,
+	.set_key_for_key_slot = sw_aes_ops_set_key_for_key_slot,
+	.aes_ecb_encrypt = sw_aes_ops_aes_ecb_encrypt,
+	.aes_ecb_decrypt = sw_aes_ops_aes_ecb_decrypt,
+	.aes_cbc_encrypt = sw_aes_ops_aes_cbc_encrypt,
+	.aes_cbc_decrypt = sw_aes_ops_aes_cbc_decrypt,
+};
+
+static const struct udevice_id sw_aes_ids[] = {
+	{ .compatible = "software-aes-engine" },
+	{ }
+};
+
+U_BOOT_DRIVER(aes_sw) = {
+	.name = "aes_sw",
+	.id = UCLASS_AES,
+	.of_match = sw_aes_ids,
+	.ops = &aes_ops_sw,
+	.priv_auto = sizeof(struct sw_aes_priv),
+};
-- 
2.48.1

