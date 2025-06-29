Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E605FC7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 10:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06B7382B34;
	Sun, 29 Jun 2025 12:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Um/oFLp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8513F82B20; Sun, 29 Jun 2025 12:57:51 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778B682E8E
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 12:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-32aabfd3813so11425321fa.3
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194657; x=1751799457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkyZIBgKXBhCdH9Jx60YsVGdS8JjUcTbP9uJhSfjq2s=;
 b=Um/oFLp7iuwX8+9Vwxxw1GMkUMCgnEre/v3gaFsQqU2IOGuvI0iNd1qpADne0C8sbD
 FwVnrlnMu9QH8JWqy6Mv9NOy8NY7Y/Sd4U6XG7UieaiUqiqYZ0zz/8xAfIB6wtnIPBoO
 b99Ak861eN585BJDWxVgt6zIIT1fJz16xIsSEF5SQI2xEwVICjdrjHaNQeB3eBCT9jUG
 ZPratiFmKzIasU8oqRMUd7P36wrkcA58p1HFi/FqPmVWqcI7IIwloSHd6IDeTRhhyxmu
 4ZzkUxMCUp8QW+U44S8CDTZrBCOQUdK/E/k46n7GUzDn9+kx/SVgQY8gbxDvW0bzpI7E
 xO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194657; x=1751799457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkyZIBgKXBhCdH9Jx60YsVGdS8JjUcTbP9uJhSfjq2s=;
 b=xSdybVS+yGCQwQiydylBp3fBjEONEhbSJzpfB7MVDMvl/e/XumczCH7krA3vZ9l83G
 0vMUm1xtYXlxfEuiysYCip6ff1shhsU3mH/mDAARmpDp5IQTtfSuq76jq+Ao+jGGowwn
 +YRNGE4a3rbIw5GWO+rVo2maanv134POqYzQ0ZkMmI4N4YAPAjlFrfDdBUjDLkA1aK7J
 YiMOfhpthvXHoo7MP0nw/gAYjtHss6s/prEoakOzzKBi77yOxOaRZ0UgxYC1OAyM4oU6
 nveFQcEsyKzH8RNlwScwhPEsecFoXNPgpX7tn9TD8Ku9Ane2wYuaFbRJGP0GWolVzP18
 RiTw==
X-Gm-Message-State: AOJu0YxQVh43fuuTpd6Hzp05H4tj3d1xkXjOPVsVnn+MD1uD+I9d/n7u
 4EsuYyYqVAVboCA5Jo4UB4jRQpeFO1spT3PINCwKM9ZYMRwlwos4sD2g
X-Gm-Gg: ASbGncu/glQZalflhocgkL30Ofy5hrd5CPCAObPeqMcVesqLouDknq/FL68yM2TieYu
 212udw6HcgdMbhs8o3Qphl1QP7fMhIg5lAiryW74L7CflCI1xS9JgIEoqKRcR4lqmAjs3feXlBo
 2GzV8RwWttkHI16BMUQccB8aI9M7HzNlmUchsJuSuVcMuShV60ZwuetyMuZFTUfdStrL/IL2k50
 2FtBcr54hNYeFyA9j4Y8yO0l9dX4RXIhs3qaakPCnsCjjYCZy3i4pYuzCP6Ai1ZcQOy3NRx4R7U
 iRG3cXAGEM3w1rn72CNwqSCAk5FxBkE65nE0PLIV9UA6xtHSEGqu+w==
X-Google-Smtp-Source: AGHT+IGjGCdJXa4Agqh8VOiEyk4969OgvdCOqEtjtBjpWPrKRVVkqhvpyIWq1FwwyiD8HXLTewg/ZQ==
X-Received: by 2002:a05:6512:3d0f:b0:553:5d00:be84 with SMTP id
 2adb3069b0e04-5550b896837mr2912606e87.34.1751194656364; 
 Sun, 29 Jun 2025 03:57:36 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24d32esm1092514e87.69.2025.06.29.03.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 03:57:35 -0700 (PDT)
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
Subject: [PATCH v1 1/4] dm: crypto: Create AES uclass
Date: Sun, 29 Jun 2025 13:57:08 +0300
Message-ID: <20250629105711.24687-2-clamor95@gmail.com>
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

Create a basic framework for a group of devices that perform AES
cryptographic operations.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/crypto/Kconfig          |   2 +
 drivers/crypto/Makefile         |   1 +
 drivers/crypto/aes/Kconfig      |   5 +
 drivers/crypto/aes/Makefile     |   3 +
 drivers/crypto/aes/aes-uclass.c | 192 ++++++++++++++++++++++++
 include/dm/uclass-id.h          |   1 +
 include/uboot_aes.h             | 251 ++++++++++++++++++++++++++++++++
 7 files changed, 455 insertions(+)
 create mode 100644 drivers/crypto/aes/Kconfig
 create mode 100644 drivers/crypto/aes/Makefile
 create mode 100644 drivers/crypto/aes/aes-uclass.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 8b49997030b..d26f87364f9 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -2,6 +2,8 @@ menu "Hardware crypto devices"
 
 source "drivers/crypto/hash/Kconfig"
 
+source "drivers/crypto/aes/Kconfig"
+
 source "drivers/crypto/fsl/Kconfig"
 
 source "drivers/crypto/aspeed/Kconfig"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index b9105186097..2bd99fc2763 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -4,6 +4,7 @@
 #	http://www.samsung.com
 
 obj-$(CONFIG_EXYNOS_ACE_SHA)	+= ace_sha.o
+obj-y += aes/
 obj-y += rsa_mod_exp/
 obj-y += fsl/
 obj-y += hash/
diff --git a/drivers/crypto/aes/Kconfig b/drivers/crypto/aes/Kconfig
new file mode 100644
index 00000000000..661dad64a6c
--- /dev/null
+++ b/drivers/crypto/aes/Kconfig
@@ -0,0 +1,5 @@
+config DM_AES
+	bool "Enable Driver Model for AES crypto operations"
+	depends on DM
+	help
+	  If you want to use driver model for AES crypto operations, say Y.
diff --git a/drivers/crypto/aes/Makefile b/drivers/crypto/aes/Makefile
new file mode 100644
index 00000000000..2f409fca1eb
--- /dev/null
+++ b/drivers/crypto/aes/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_$(PHASE_)DM_AES) += aes-uclass.o
diff --git a/drivers/crypto/aes/aes-uclass.c b/drivers/crypto/aes/aes-uclass.c
new file mode 100644
index 00000000000..745c6ce57a9
--- /dev/null
+++ b/drivers/crypto/aes/aes-uclass.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define LOG_CATEGORY UCLASS_AES
+
+#include <dm.h>
+#include <malloc.h>
+#include <log.h>
+#include <uboot_aes.h>
+#include <linux/string.h>
+
+int dm_aes_get_available_key_slots(struct udevice *dev)
+{
+	const struct aes_ops *ops;
+
+	if (!dev)
+		return -ENODEV;
+
+	ops = aes_get_ops(dev);
+
+	if (!ops->available_key_slots)
+		return -ENOSYS;
+
+	return ops->available_key_slots(dev);
+}
+
+int dm_aes_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
+{
+	const struct aes_ops *ops;
+
+	if (!dev)
+		return -ENODEV;
+
+	ops = aes_get_ops(dev);
+
+	if (!ops->select_key_slot)
+		return -ENOSYS;
+
+	return ops->select_key_slot(dev, key_size, slot);
+}
+
+int dm_aes_set_key_for_key_slot(struct udevice *dev, u32 key_size, u8 *key, u8 slot)
+{
+	const struct aes_ops *ops;
+
+	if (!dev)
+		return -ENODEV;
+
+	ops = aes_get_ops(dev);
+
+	if (!ops->set_key_for_key_slot)
+		return -ENOSYS;
+
+	return ops->set_key_for_key_slot(dev, key_size, key, slot);
+}
+
+int dm_aes_ecb_encrypt(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks)
+{
+	const struct aes_ops *ops;
+
+	if (!dev)
+		return -ENODEV;
+
+	ops = aes_get_ops(dev);
+
+	if (!ops->aes_ecb_encrypt)
+		return -ENOSYS;
+
+	return ops->aes_ecb_encrypt(dev, src, dst, num_aes_blocks);
+}
+
+int dm_aes_ecb_decrypt(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks)
+{
+	const struct aes_ops *ops;
+
+	if (!dev)
+		return -ENODEV;
+
+	ops = aes_get_ops(dev);
+
+	if (!ops->aes_ecb_decrypt)
+		return -ENOSYS;
+
+	return ops->aes_ecb_decrypt(dev, src, dst, num_aes_blocks);
+}
+
+int dm_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src, u8 *dst, u32 num_aes_blocks)
+{
+	const struct aes_ops *ops;
+
+	if (!dev)
+		return -ENODEV;
+
+	ops = aes_get_ops(dev);
+
+	if (!ops->aes_cbc_encrypt)
+		return -ENOSYS;
+
+	return ops->aes_cbc_encrypt(dev, iv, src, dst, num_aes_blocks);
+}
+
+int dm_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src, u8 *dst, u32 num_aes_blocks)
+{
+	const struct aes_ops *ops;
+
+	if (!dev)
+		return -ENODEV;
+
+	ops = aes_get_ops(dev);
+
+	if (!ops->aes_cbc_decrypt)
+		return -ENOSYS;
+
+	return ops->aes_cbc_decrypt(dev, iv, src, dst, num_aes_blocks);
+}
+
+static void left_shift_vector(u8 *in, u8 *out, int size)
+{
+	int carry = 0;
+	int i;
+
+	for (i = size - 1; i >= 0; i--) {
+		out[i] = (in[i] << 1) | carry;
+		carry = in[i] >> 7;	/* get most significant bit */
+	}
+}
+
+int dm_aes_cmac(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks)
+{
+	const u8 AES_CMAC_CONST_RB = 0x87; /* from RFC 4493, Figure 2.2 */
+	const u32 TMP_BUFFER_LEN = 128;
+	u8 tmp_block[AES128_KEY_LENGTH] = { };
+	u8 k1[AES128_KEY_LENGTH];
+	u8 *tmp_buffer;
+	int ret;
+
+	log_debug("%s: 0x%p -> %p blocks %d\n", __func__, src, dst, num_aes_blocks);
+
+	if (!num_aes_blocks) {
+		log_debug("%s: called with 0 blocks!\n", __func__);
+		return -1;
+	}
+
+	/* Compute K1 constant needed by AES-CMAC calculation */
+	ret = dm_aes_cbc_encrypt(dev, (u8 *)AES_ZERO_BLOCK, (u8 *)AES_ZERO_BLOCK, tmp_block, 1);
+	if (ret)
+		return -1;
+
+	left_shift_vector(tmp_block, k1, AES_BLOCK_LENGTH);
+
+	if ((tmp_block[0] >> 7) != 0) /* get MSB of L */
+		k1[AES128_KEY_LENGTH - 1] ^= AES_CMAC_CONST_RB;
+
+	/* Set what will be the initial IV as zero */
+	memset(tmp_block, 0, AES_BLOCK_LENGTH);
+
+	/* Process all blocks except last by calling engine several times per dma buffer size */
+	if (num_aes_blocks > 1) {
+		tmp_buffer = malloc(AES_BLOCK_LENGTH * min(num_aes_blocks - 1, TMP_BUFFER_LEN));
+		while (num_aes_blocks > 1) {
+			u32 blocks = min(num_aes_blocks - 1, TMP_BUFFER_LEN);
+
+			/* Encrypt the current remaining set of blocks that fits in tmp buffer */
+			ret = dm_aes_cbc_encrypt(dev, tmp_block, src, tmp_buffer, blocks);
+			if (ret)
+				return -1;
+
+			num_aes_blocks -= blocks;
+			src += blocks * AES_BLOCK_LENGTH;
+
+			/* Copy the last encrypted block to tmp_block as IV */
+			memcpy(tmp_block, tmp_buffer + ((blocks - 1) * AES_BLOCK_LENGTH),
+			       AES_BLOCK_LENGTH);
+		}
+		free(tmp_buffer);
+	}
+
+	if (num_aes_blocks != 1) {
+		log_debug("%s: left with %d blocks! must be 1\n", __func__, num_aes_blocks);
+		return -1;
+	}
+
+	/* XOR last IV with K1 */
+	aes_apply_cbc_chain_data(tmp_block, k1, tmp_block);
+
+	/* Encrypt the last src block already with tmp_block as IV and output to dst */
+	return dm_aes_cbc_encrypt(dev, tmp_block, src, dst, 1);
+}
+
+UCLASS_DRIVER(aes) = {
+	.id	= UCLASS_AES,
+	.name	= "aes",
+};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94f..5c0fd6d171b 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -38,6 +38,7 @@ enum uclass_id {
 	/* U-Boot uclasses start here - in alphabetical order */
 	UCLASS_ACPI_PMC,	/* (x86) Power-management controller (PMC) */
 	UCLASS_ADC,		/* Analog-to-digital converter */
+	UCLASS_AES,		/* AES cryptographic engine */
 	UCLASS_AHCI,		/* SATA disk controller */
 	UCLASS_AUDIO_CODEC,	/* Audio codec with control and data path */
 	UCLASS_AXI,		/* AXI bus */
diff --git a/include/uboot_aes.h b/include/uboot_aes.h
index d2583bed992..592b7dbee43 100644
--- a/include/uboot_aes.h
+++ b/include/uboot_aes.h
@@ -7,6 +7,8 @@
 #ifndef _AES_REF_H_
 #define _AES_REF_H_
 
+#include <errno.h>
+
 #ifdef USE_HOSTCC
 /* Define compat stuff for use in fw_* tools. */
 typedef unsigned char u8;
@@ -107,4 +109,253 @@ void aes_cbc_encrypt_blocks(u32 key_size, u8 *key_exp, u8 *iv, u8 *src, u8 *dst,
 void aes_cbc_decrypt_blocks(u32 key_size, u8 *key_exp, u8 *iv, u8 *src, u8 *dst,
 			    u32 num_aes_blocks);
 
+/* An AES block filled with zeros */
+static const u8 AES_ZERO_BLOCK[AES_BLOCK_LENGTH] = { 0 };
+struct udevice;
+
+/**
+ * struct struct aes_ops - Driver model for AES related operations
+ *
+ * The uclass interface is implemented by AES crypto devices which use driver model.
+ *
+ * Some AES crypto devices use key slots to store the key for the encrypt/decrypt
+ * operations, while others may simply pass the key on each operation.
+ *
+ * In case the device does not implement hardware slots, driver can emulate or simply
+ * store one active key slot at 0 in the driver state and pass it on each underlying
+ * hw calls for AES operations.
+ *
+ * Note that some devices like Tegra AES engine may contain preloaded keys by bootrom,
+ * thus in those cases the set_key_for_key_slot() may be skipped.
+ *
+ * Sequence for a series of AES CBC encryption, one decryption and a CMAC hash example
+ * with 128bits key at slot 0 would be as follow:
+ *
+ * set_key_for_key_slot(DEV, 128, KEY, 0);
+ * select_key_slot(DEV, 128, 0);
+ * aes_cbc_encrypt(DEV, IV1, SRC1, DST1, LEN1);
+ * aes_cbc_encrypt(DEV, IV2, SRC2, DST2, LEN2);
+ * aes_cbc_decrypt(DEV, IV3, SRC3, DST3, LEN3);
+ */
+struct aes_ops {
+	/**
+	 * available_key_slots() - How many key slots this AES device has
+	 *
+	 * @dev			The AES udevice
+	 * @return		Available slots to use, 0 for none
+	 */
+	int (*available_key_slots)(struct udevice *dev);
+
+	/**
+	 * select_key_slot() - Selects the AES key slot to use for following operations
+	 *
+	 * @dev			The AES udevice
+	 * @key_size		Size of the aes key (in bits)
+	 * @slot		The key slot to set as selected
+	 * @return		0 on success, negative value on failure
+	 */
+	int (*select_key_slot)(struct udevice *dev, u32 key_size, u8 slot);
+
+	/**
+	 * set_key_for_key_slot() - Sets the AES key to use for specified key slot
+	 *
+	 * @dev			The AES udevice
+	 * @key_size		Size of the aes key (in bits)
+	 * @key			An AES key to set
+	 * @slot		The slot to load the key at
+	 * @return		0 on success, negative value on failure
+	 */
+	int (*set_key_for_key_slot)(struct udevice *dev, u32 key_size, u8 *key,
+				    u8 slot);
+
+	/**
+	 * aes_ecb_encrypt() - Encrypt multiple blocks of data with AES ECB.
+	 *
+	 * @dev			The AES udevice
+	 * @src			Source data of length 'num_aes_blocks' blocks
+	 * @dst			Destination data of length 'num_aes_blocks' blocks
+	 * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
+	 * @return		0 on success, negative value on failure
+	 */
+	int (*aes_ecb_encrypt)(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks);
+
+	/**
+	 * aes_ecb_decrypt() - Decrypt multiple blocks of data with AES ECB.
+	 *
+	 * @dev			The AES udevice
+	 * @src			Source data of length 'num_aes_blocks' blocks
+	 * @dst			Destination data of length 'num_aes_blocks' blocks
+	 * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
+	 * @return		0 on success, negative value on failure
+	 */
+	int (*aes_ecb_decrypt)(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks);
+
+	/**
+	 * aes_cbc_encrypt() - Encrypt multiple blocks of data with AES CBC.
+	 *
+	 * @dev			The AES udevice
+	 * @iv			Initialization vector
+	 * @src			Source data of length 'num_aes_blocks' blocks
+	 * @dst			Destination data of length 'num_aes_blocks' blocks
+	 * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
+	 * @return		0 on success, negative value on failure
+	 */
+	int (*aes_cbc_encrypt)(struct udevice *dev, u8 *iv,
+			       u8 *src, u8 *dst, u32 num_aes_blocks);
+
+	/**
+	 * aes_cbc_decrypt() - Decrypt multiple blocks of data with AES CBC.
+	 *
+	 * @dev			The AES udevice
+	 * @iv			Initialization vector
+	 * @src			Source data of length 'num_aes_blocks' blocks
+	 * @dst			Destination data of length 'num_aes_blocks' blocks
+	 * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
+	 * @return		0 on success, negative value on failure
+	 */
+	int (*aes_cbc_decrypt)(struct udevice *dev, u8 *iv,
+			       u8 *src, u8 *dst, u32 num_aes_blocks);
+};
+
+#define aes_get_ops(dev)	((struct aes_ops *)(dev)->driver->ops)
+
+#if CONFIG_IS_ENABLED(DM_AES)
+
+/**
+ * dm_aes_get_available_key_slots - How many key slots this AES device has
+ *
+ * @dev			The AES udevice
+ * Return:		Available slots to use, 0 for none, -ve on failure
+ */
+int dm_aes_get_available_key_slots(struct udevice *dev);
+
+/**
+ * dm_aes_select_key_slot - Selects the AES key slot to use for following operations
+ *
+ * @dev			The AES udevice
+ * @key_size		Size of the aes key (in bits)
+ * @slot		The key slot to set as selected
+ * Return:		0 on success, -ve on failure
+ */
+int dm_aes_select_key_slot(struct udevice *dev, u32 key_size, u8 slot);
+
+/**
+ * dm_aes_set_key_for_key_slot - Sets the AES key to use for specified key slot
+ *
+ * @dev			The AES udevice
+ * @key_size		Size of the aes key (in bits)
+ * @key			An AES key to set
+ * @slot		The slot to load the key at
+ * Return:		0 on success, negative value on failure
+ */
+int dm_aes_set_key_for_key_slot(struct udevice *dev, u32 key_size, u8 *key, u8 slot);
+
+/**
+ * dm_aes_ecb_encrypt - Encrypt multiple blocks of data with AES ECB.
+ *
+ * @dev			The AES udevice
+ * @src			Source data of length 'num_aes_blocks' blocks
+ * @dst			Destination data of length 'num_aes_blocks' blocks
+ * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
+ * Return:		0 on success, negative value on failure
+ */
+int dm_aes_ecb_encrypt(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks);
+
+/**
+ * dm_aes_ecb_decrypt - Decrypt multiple blocks of data with AES ECB.
+ *
+ * @dev			The AES udevice
+ * @src			Source data of length 'num_aes_blocks' blocks
+ * @dst			Destination data of length 'num_aes_blocks' blocks
+ * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
+ * Return:		0 on success, negative value on failure
+ */
+int dm_aes_ecb_decrypt(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks);
+
+/**
+ * dm_aes_cbc_encrypt - Encrypt multiple blocks of data with AES CBC.
+ *
+ * @dev			The AES udevice
+ * @iv			Initialization vector
+ * @src			Source data of length 'num_aes_blocks' blocks
+ * @dst			Destination data of length 'num_aes_blocks' blocks
+ * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
+ * Return:		0 on success, negative value on failure
+ */
+int dm_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src, u8 *dst, u32 num_aes_blocks);
+
+/**
+ * dm_aes_cbc_decrypt - Decrypt multiple blocks of data with AES CBC.
+ *
+ * @dev			The AES udevice
+ * @iv			Initialization vector
+ * @src			Source data of length 'num_aes_blocks' blocks
+ * @dst			Destination data of length 'num_aes_blocks' blocks
+ * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
+ * Return:		0 on success, negative value on failure
+ */
+int dm_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src, u8 *dst, u32 num_aes_blocks);
+
+/**
+ * dm_aes_cmac - Hashes the input data with AES-CMAC, putting the result into dst.
+ * The key slot must be selected already.
+ *
+ * @dev			The AES udevice
+ * @key_size		Size of the aes key (in bits)
+ * @src			Source data of length 'num_aes_blocks' blocks
+ * @dst			Destination for hash result
+ * @num_aes_blocks	Number of AES blocks to encrypt
+ * Return:		0 on success, negative value on failure.
+ */
+int dm_aes_cmac(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks);
+
+#else
+
+static inline int dm_aes_get_available_key_slots(struct udevice *dev)
+{
+	return -ENOSYS;
+}
+
+static inline int dm_aes_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
+{
+	return -ENOSYS;
+}
+
+static inline int dm_aes_set_key_for_key_slot(struct udevice *dev, u32 key_size, u8 *key,
+					      u8 slot)
+{
+	return -ENOSYS;
+}
+
+static inline int dm_aes_ecb_encrypt(struct udevice *dev, u8 *src, u8 *dst,
+				     u32 num_aes_blocks)
+{
+	return -ENOSYS;
+}
+
+static inline int dm_aes_ecb_decrypt(struct udevice *dev, u8 *src, u8 *dst,
+				     u32 num_aes_blocks)
+{
+	return -ENOSYS;
+}
+
+static inline int dm_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src,
+				     u8 *dst, u32 num_aes_blocks)
+{
+	return -ENOSYS;
+}
+
+static inline int dm_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
+				     u8 *dst, u32 num_aes_blocks)
+{
+	return -ENOSYS;
+}
+
+static inline int dm_aes_cmac(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_DM_AES */
+
 #endif /* _AES_REF_H_ */
-- 
2.48.1

