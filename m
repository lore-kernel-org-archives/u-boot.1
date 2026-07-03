Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E6FC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 07:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3334F848BF;
	Fri,  3 Jul 2026 09:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LRGyKK9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F86084A85; Fri,  3 Jul 2026 03:50:02 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F07849F0
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 03:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-440df1c768bso12377fac.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 18:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783043398; x=1783648198; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ukob3PwEQrSXxhnR4tfZBbyEaiQvb50Cr9ZML+jwjNA=;
 b=LRGyKK9QGQQKJ8UILaRgWRQz1m1uxl8Czpkjyjz75ko2M35z5ewDsZhjLYJOw7uDQ6
 pZso4oNC8isKVY5dIX2V/LJ9VldcuM+xASgv0/nUGUyXIKfbT6Tg0+tqwRFDT6TuQyv7
 AKR446DPHVWYsNHqZAsxZU3G3MjXPE0WEquCMrQ0q+h7ZRKnhmRPDWIvnKaXqf5S5aBy
 IAc5qucbdJ4P5DiyysIYCG31kFObxoaauMM1OBHBoTkwgUzQ9oO+mmMOEgx78720kLNY
 lRyjg1rZ4qKbJYoRxJyP8xVGlpLmvoA0O2ohJtPUUCF19dUG+aihLflA0G+Eeb9wBeZN
 /ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043398; x=1783648198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ukob3PwEQrSXxhnR4tfZBbyEaiQvb50Cr9ZML+jwjNA=;
 b=ZyUc1Kz6ALAutFzP5EWmzToHoAe8qcmJngagEFqFMBR7jgrXl4NEs+tcO0AGEDY0nJ
 1OmDbDKAkX6wUiEBvxbBMyiggOcBC+APa9rRzhLK2kLbucPzJut6jxy5U0CNs65uA8T7
 VyL+nkOG6PiwOjUYYVFDFanKOqU/wpCJl0DU8WiD+Kwz1ephrr0nmNko9q835Hyrj4El
 nTDR2/Pmb0OrzaXMnnrPPR+KH0ESBuJClja9t7SZCLQo95kaqE3Aj23Z5McPGBDmjK1w
 yslHg12uVy3guVqnlbZ+xcHxP1pn4BD0ZbEaoP36hvi2VJLej5bE9xtTehouI0SR+Ded
 pnQA==
X-Gm-Message-State: AOJu0YzJVGZqXzdrrB867Y38b2/Wx4o2XwsfpN0qxg4NEPqUvCR/h8rR
 eYzEHzXlg1fNBOwfYjF7lOlvRDxY0xkczC1UIXdVWEwQPs683HZGuAc/KKdijCsNObw=
X-Gm-Gg: AfdE7cmylBoL/hdQ3y9TSvF33tNPbVT1ptFH4XgaQh9y9YEXVOYjqDazgW7bzBUjRR7
 2GTooRCmRwMq8/A2bozJuFCSU+WvqYmdtZZcSbCNyEIoI6fAaXLehct/+4kY4HpH67lUPnbPWC7
 YTx6deiPV0kEzaeBk0U3IMl5qO0RvkguvV8Bp96BhYWSDolK3O6orPs+lYz0CUAANyoUyMkIZf+
 jjtuJ434BP9PKj457SHwuMzeJlyTUbtRmpwYMG7w8ARgzUU7pCzzUql2ZhPQeKnqgZI/iD90Il4
 92CUqielj2eWXhqDCXIAAmUJJEMG1KqFoTH5YHFgEAo2AOu9zRn9KqktMwgXW1z1c/5WeamH/Ww
 ur2UJbxlX7jIFHedTdfQWpaF48ebNzcM0/qhpYr991fAfGAzsZZMODeFeVyli+pBOmiN0V5qt/N
 VHjhqVA9kL1nOd2YoH4jha3I8xnlBoF6Jdb71WIzS06YL7Y4uTBCs64BtSwAproGF+6t+aUT9dy
 IC7I2v599O8OzTEvfThCemqO+fmUyItWpwpKfggo98XVhS3UQEAmzhoGGbRBUCFOYZROw==
X-Received: by 2002:a05:6808:144f:b0:491:3ade:8b9e with SMTP id
 5614622812f47-496369f932emr4770994b6e.36.1783043397980; 
 Thu, 02 Jul 2026 18:49:57 -0700 (PDT)
Received: from [127.0.1.1] (97-118-25-163.hlrn.qwest.net. [97.118.25.163])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm2974888b6e.14.2026.07.02.18.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 18:49:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 02 Jul 2026 19:49:48 -0600
Subject: [PATCH v2 03/10] boot: image: add FIT decrypt-to-buffer helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-submit-ce-series-v2-v2-3-ffda5bed58af@gmail.com>
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
To: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ion Agorria <ion@agorria.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Michael Walle <mwalle@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 03 Jul 2026 09:59:22 +0200
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

FIT cipher support currently allocates the output buffer inside the AES
helper. SPL often needs to decrypt directly into a caller-selected
buffer, for example a load buffer or a scratch buffer used before
decompression.

Add a decrypt_to callback to the FIT cipher algorithm and wire it up for
AES. The existing allocating decrypt path becomes a wrapper around the
new helper.

Validate the FIT cipher key length, IV length and unciphered-size
property while preparing decryption, and build lib/aes/ by phase when
FIT_CIPHER is enabled so the target-side decrypt helper is available to
SPL builds.

When DM_AES is enabled, try the first UCLASS_AES provider before using
the software AES fallback in U-Boot proper. If a provider is present,
ask the provider for the software-provided key slot before loading the
FIT key, so hardware-specific reserved or preloaded slot policy stays in
the provider. Return AES device errors to the caller instead of hiding
them with a software fallback after the device has accepted the operation.

For U-Boot proper, use decrypt_to for in-place decryption when the FIT
payload is already in writable RAM. The encrypted data is no longer
needed after hash verification, and this avoids a full-size allocation
for encrypted payloads loaded into DRAM.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Explain FIT cipher validation  (suggested by Simon Glass)
  - Explain phase-keyed lib/aes builds  (suggested by Simon Glass)
  - Return -ENOSYS without decrypt support  (suggested by Simon Glass)
  - Let AES providers choose the software-provided key slot
  - Use decrypt_to for U-Boot proper in-place decrypt
---
 boot/image-cipher.c              |  38 ++++++++++++--
 boot/image-fit.c                 |  33 ++++++++++--
 drivers/crypto/aes/aes-sw.c      |   6 +++
 drivers/crypto/aes/aes-uclass.c  |  15 ++++++
 drivers/crypto/tegra/tegra_aes.c |   7 +++
 include/image.h                  |  39 ++++++++++++--
 include/u-boot/aes.h             |  10 ++++
 include/uboot_aes.h              |  38 ++++++++++++--
 lib/Makefile                     |   2 +-
 lib/aes/aes-decrypt.c            | 108 +++++++++++++++++++++++++++++++++------
 10 files changed, 266 insertions(+), 30 deletions(-)

diff --git a/boot/image-cipher.c b/boot/image-cipher.c
index 9d389f26cea..93b3dd3c637 100644
--- a/boot/image-cipher.c
+++ b/boot/image-cipher.c
@@ -25,6 +25,7 @@ struct cipher_algo cipher_algos[] = {
 #endif
 		.encrypt = image_aes_encrypt,
 		.decrypt = image_aes_decrypt,
+		.decrypt_to = image_aes_decrypt_to,
 		.add_cipher_data = image_aes_add_cipher_data
 	},
 	{
@@ -36,6 +37,7 @@ struct cipher_algo cipher_algos[] = {
 #endif
 		.encrypt = image_aes_encrypt,
 		.decrypt = image_aes_decrypt,
+		.decrypt_to = image_aes_decrypt_to,
 		.add_cipher_data = image_aes_add_cipher_data
 	},
 	{
@@ -47,6 +49,7 @@ struct cipher_algo cipher_algos[] = {
 #endif
 		.encrypt = image_aes_encrypt,
 		.decrypt = image_aes_decrypt,
+		.decrypt_to = image_aes_decrypt_to,
 		.add_cipher_data = image_aes_add_cipher_data
 	}
 };
@@ -70,6 +73,7 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 				   int cipher_noffset)
 {
 	const void *fdt = gd_fdt_blob();
+	int key_len, iv_len;
 	const char *node_name;
 	char node_path[128];
 	int noffset;
@@ -94,7 +98,7 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 		return -1;
 	}
 
-	info->iv = fdt_getprop(fit, cipher_noffset, "iv", NULL);
+	info->iv = fdt_getprop(fit, cipher_noffset, "iv", &iv_len);
 	info->ivname = fdt_getprop(fit, cipher_noffset, "iv-name-hint", NULL);
 
 	if (!info->iv && !info->ivname) {
@@ -136,20 +140,28 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 	}
 
 	/* read key */
-	info->key = fdt_getprop(fdt, noffset, "key", NULL);
+	info->key = fdt_getprop(fdt, noffset, "key", &key_len);
 	if (!info->key) {
 		printf("Can't get key in cipher node '%s'\n", node_path);
 		return -1;
 	}
+	if (key_len != info->cipher->key_len) {
+		printf("Bad key length in cipher node '%s'\n", node_path);
+		return -1;
+	}
 
 	/* read iv */
 	if (!info->iv) {
-		info->iv = fdt_getprop(fdt, noffset, "iv", NULL);
+		info->iv = fdt_getprop(fdt, noffset, "iv", &iv_len);
 		if (!info->iv) {
 			printf("Can't get IV in cipher node '%s'\n", node_path);
 			return -1;
 		}
 	}
+	if (iv_len != info->cipher->iv_len) {
+		printf("Bad IV length for cipher in image '%s'\n", node_name);
+		return -1;
+	}
 
 	return 0;
 }
@@ -173,3 +185,23 @@ int fit_image_decrypt_data(const void *fit,
  out:
 	return ret;
 }
+
+int fit_image_decrypt_data_to(const void *fit,
+			      int image_noffset, int cipher_noffset,
+			      const void *data_ciphered, size_t size_ciphered,
+			      void *data_unciphered, size_t *size_unciphered)
+{
+	struct image_cipher_info info;
+	int ret;
+
+	ret = fit_image_setup_decrypt(&info, fit, image_noffset,
+				      cipher_noffset);
+	if (ret < 0)
+		return ret;
+
+	if (!info.cipher->decrypt_to)
+		return -ENOSYS;
+
+	return info.cipher->decrypt_to(&info, data_ciphered, size_ciphered,
+				       data_unciphered, size_unciphered);
+}
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 044a40e1910..a4192db5eb5 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1030,7 +1030,7 @@ int fit_image_get_data_size(const void *fit, int noffset, int *data_size)
  *
  * @fit: pointer to the FIT image header
  * @noffset: component image node offset
- * @data_size: holds the data-size property
+ * @data_size: holds the data-size-unciphered property
  *
  * returns:
  *     0, on success
@@ -1040,10 +1040,13 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 				       size_t *data_size)
 {
 	const fdt32_t *val;
+	int len;
 
-	val = fdt_getprop(fit, noffset, "data-size-unciphered", NULL);
+	val = fdt_getprop(fit, noffset, "data-size-unciphered", &len);
 	if (!val)
 		return -ENOENT;
+	if (len != sizeof(*val))
+		return -EINVAL;
 
 	*data_size = (size_t)fdt32_to_cpu(*val);
 
@@ -1568,15 +1571,37 @@ static int fit_image_uncipher(const void *fit, int image_noffset,
 	if (cipher_noffset < 0)
 		return 0;
 
+#ifndef USE_HOSTCC
+	if (!tools_build()) {
+		ulong start = map_to_sysmem(*data);
+		ulong end = start + *size;
+
+		/*
+		 * Avoid a full-size allocation when the FIT payload is already
+		 * in writable DRAM. The encrypted bytes are no longer needed
+		 * after hash verification has completed.
+		 */
+		if (end >= start && start >= gd->ram_base && end <= gd->ram_top) {
+			ret = fit_image_decrypt_data_to(fit, image_noffset,
+							cipher_noffset,
+							*data, *size, *data,
+							&size_dst);
+			if (ret != -ENOSYS)
+				goto out;
+		}
+	}
+#endif
+
 	ret = fit_image_decrypt_data(fit, image_noffset, cipher_noffset,
 				     *data, *size, &dst, &size_dst);
 	if (ret)
 		goto out;
 
 	*data = dst;
-	*size = size_dst;
+out:
+	if (!ret)
+		*size = size_dst;
 
- out:
 	return ret;
 }
 
diff --git a/drivers/crypto/aes/aes-sw.c b/drivers/crypto/aes/aes-sw.c
index a65200fb79b..3ce8999663b 100644
--- a/drivers/crypto/aes/aes-sw.c
+++ b/drivers/crypto/aes/aes-sw.c
@@ -39,6 +39,11 @@ static int sw_aes_ops_available_key_slots(struct udevice *dev)
 	return SW_KEY_SLOTS;
 }
 
+static int sw_aes_ops_get_software_key_slot(struct udevice *dev)
+{
+	return 0;
+}
+
 static int sw_aes_ops_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
 {
 	struct sw_aes_priv *priv = dev_get_priv(dev);
@@ -145,6 +150,7 @@ static int sw_aes_ops_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
 
 static const struct aes_ops aes_ops_sw = {
 	.available_key_slots = sw_aes_ops_available_key_slots,
+	.get_software_key_slot = sw_aes_ops_get_software_key_slot,
 	.select_key_slot = sw_aes_ops_select_key_slot,
 	.set_key_for_key_slot = sw_aes_ops_set_key_for_key_slot,
 	.aes_ecb_encrypt = sw_aes_ops_aes_ecb_encrypt,
diff --git a/drivers/crypto/aes/aes-uclass.c b/drivers/crypto/aes/aes-uclass.c
index 5bdd3d736c4..2bfe3dc3fcc 100644
--- a/drivers/crypto/aes/aes-uclass.c
+++ b/drivers/crypto/aes/aes-uclass.c
@@ -23,6 +23,21 @@ int dm_aes_get_available_key_slots(struct udevice *dev)
 	return ops->available_key_slots(dev);
 }
 
+int dm_aes_get_software_key_slot(struct udevice *dev)
+{
+	const struct aes_ops *ops;
+
+	if (!dev)
+		return -ENODEV;
+
+	ops = aes_get_ops(dev);
+
+	if (!ops->get_software_key_slot)
+		return -ENOSYS;
+
+	return ops->get_software_key_slot(dev);
+}
+
 int dm_aes_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
 {
 	const struct aes_ops *ops;
diff --git a/drivers/crypto/tegra/tegra_aes.c b/drivers/crypto/tegra/tegra_aes.c
index 55a4cec525b..348115ac5a7 100644
--- a/drivers/crypto/tegra/tegra_aes.c
+++ b/drivers/crypto/tegra/tegra_aes.c
@@ -321,6 +321,12 @@ static int tegra_aes_ops_available_key_slots(struct udevice *dev)
 	return 4; /* 4 slots in Tegra20 and Tegra30 */
 }
 
+static int tegra_aes_ops_get_software_key_slot(struct udevice *dev)
+{
+	/* Avoid SBK slot 0, which may hold a preloaded key. */
+	return TEGRA_AES_SLOT_SBK + 1;
+}
+
 static int tegra_aes_ops_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
 {
 	struct tegra_aes_priv *priv = dev_get_priv(dev);
@@ -565,6 +571,7 @@ static int tegra_aes_probe(struct udevice *dev)
 
 static const struct aes_ops tegra_aes_ops = {
 	.available_key_slots = tegra_aes_ops_available_key_slots,
+	.get_software_key_slot = tegra_aes_ops_get_software_key_slot,
 	.select_key_slot = tegra_aes_ops_select_key_slot,
 	.set_key_for_key_slot = tegra_aes_ops_set_key_for_key_slot,
 	.aes_ecb_encrypt = tegra_aes_ops_aes_ecb_encrypt,
diff --git a/include/image.h b/include/image.h
index 9c8a746d576..5edbf8fdc33 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1862,11 +1862,40 @@ int fit_image_check_sig(const void *fit, int noffset, const void *data,
 			size_t size, const void *key_blob, int required_keynode,
 			char **err_msgp);
 
-int fit_image_decrypt_data(const void *fit,
-			   int image_noffset, int cipher_noffset,
-			   const void *data, size_t size,
+/**
+ * fit_image_decrypt_data() - Decrypt a FIT image payload
+ *
+ * @fit:		FIT image
+ * @image_noffset:	Offset of the image node to decrypt
+ * @cipher_noffset:	Offset of the cipher node for the image
+ * @data:		Encrypted image payload
+ * @size:		Size of encrypted image payload
+ * @data_unciphered:	Returns allocated decrypted payload
+ * @size_unciphered:	Returns size of decrypted payload
+ * Return: 0 on success, <0 on error
+ */
+int fit_image_decrypt_data(const void *fit, int image_noffset,
+			   int cipher_noffset, const void *data, size_t size,
 			   void **data_unciphered, size_t *size_unciphered);
 
+/**
+ * fit_image_decrypt_data_to() - Decrypt a FIT image payload to a buffer
+ *
+ * @fit:		FIT image
+ * @image_noffset:	Offset of the image node to decrypt
+ * @cipher_noffset:	Offset of the cipher node for the image
+ * @data:		Encrypted image payload
+ * @size:		Size of encrypted image payload
+ * @data_unciphered:	Destination buffer for decrypted payload. The caller
+ *			must provide at least @size bytes.
+ * @size_unciphered:	Returns size of decrypted payload
+ * Return: 0 on success, <0 on error
+ */
+int fit_image_decrypt_data_to(const void *fit,
+			      int image_noffset, int cipher_noffset,
+			      const void *data, size_t size,
+			      void *data_unciphered, size_t *size_unciphered);
+
 /**
  * fit_region_make_list() - Make a list of regions to hash
  *
@@ -1960,6 +1989,10 @@ struct cipher_algo {
 	int (*decrypt)(struct image_cipher_info *info,
 		       const void *cipher, size_t cipher_len,
 		       void **data, size_t *data_len);
+
+	int (*decrypt_to)(struct image_cipher_info *info,
+			  const void *cipher, size_t cipher_len,
+			  void *data, size_t *data_len);
 };
 
 int fit_image_cipher_get_algo(const void *fit, int noffset, char **algo);
diff --git a/include/u-boot/aes.h b/include/u-boot/aes.h
index acbc50b9e6f..6d81af3780d 100644
--- a/include/u-boot/aes.h
+++ b/include/u-boot/aes.h
@@ -34,6 +34,9 @@ int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
 int image_aes_decrypt(struct image_cipher_info *info,
 		      const void *cipher, size_t cipher_len,
 		      void **data, size_t *size);
+int image_aes_decrypt_to(struct image_cipher_info *info,
+			 const void *cipher, size_t cipher_len,
+			 void *data, size_t *size);
 #else
 int image_aes_decrypt(struct image_cipher_info *info,
 		      const void *cipher, size_t cipher_len,
@@ -41,6 +44,13 @@ int image_aes_decrypt(struct image_cipher_info *info,
 {
 	return -ENXIO;
 }
+
+int image_aes_decrypt_to(struct image_cipher_info *info,
+			 const void *cipher, size_t cipher_len,
+			 void *data, size_t *size)
+{
+	return -ENXIO;
+}
 #endif /* IMAGE_ENABLE_DECRYPT */
 
 #endif
diff --git a/include/uboot_aes.h b/include/uboot_aes.h
index 592b7dbee43..73acca93ab9 100644
--- a/include/uboot_aes.h
+++ b/include/uboot_aes.h
@@ -128,11 +128,17 @@ struct udevice;
  * Note that some devices like Tegra AES engine may contain preloaded keys by bootrom,
  * thus in those cases the set_key_for_key_slot() may be skipped.
  *
- * Sequence for a series of AES CBC encryption, one decryption and a CMAC hash example
- * with 128bits key at slot 0 would be as follow:
+ * Generic callers which load a software-provided key should first ask the
+ * driver for a suitable software key slot. This lets hardware drivers avoid
+ * reserved or preloaded slots while keeping the slot policy local to the
+ * provider.
  *
- * set_key_for_key_slot(DEV, 128, KEY, 0);
- * select_key_slot(DEV, 128, 0);
+ * Sequence for a series of AES CBC encryption, one decryption and a CMAC hash
+ * example with a 128-bit software-provided key would be as follows:
+ *
+ * slot = get_software_key_slot(DEV);
+ * set_key_for_key_slot(DEV, 128, KEY, slot);
+ * select_key_slot(DEV, 128, slot);
  * aes_cbc_encrypt(DEV, IV1, SRC1, DST1, LEN1);
  * aes_cbc_encrypt(DEV, IV2, SRC2, DST2, LEN2);
  * aes_cbc_decrypt(DEV, IV3, SRC3, DST3, LEN3);
@@ -146,6 +152,16 @@ struct aes_ops {
 	 */
 	int (*available_key_slots)(struct udevice *dev);
 
+	/**
+	 * get_software_key_slot() - Get a slot for software-provided keys
+	 *
+	 * @dev			The AES udevice
+	 * @return		Key slot to use for a software-provided key,
+	 *			0 or positive on success, negative value on
+	 *			failure
+	 */
+	int (*get_software_key_slot)(struct udevice *dev);
+
 	/**
 	 * select_key_slot() - Selects the AES key slot to use for following operations
 	 *
@@ -229,6 +245,15 @@ struct aes_ops {
  */
 int dm_aes_get_available_key_slots(struct udevice *dev);
 
+/**
+ * dm_aes_get_software_key_slot - Get a slot for software-provided keys
+ *
+ * @dev			The AES udevice
+ * Return:		Key slot to use for a software-provided key,
+ *			0 or positive on success, -ve on failure
+ */
+int dm_aes_get_software_key_slot(struct udevice *dev);
+
 /**
  * dm_aes_select_key_slot - Selects the AES key slot to use for following operations
  *
@@ -316,6 +341,11 @@ static inline int dm_aes_get_available_key_slots(struct udevice *dev)
 	return -ENOSYS;
 }
 
+static inline int dm_aes_get_software_key_slot(struct udevice *dev)
+{
+	return -ENOSYS;
+}
+
 static inline int dm_aes_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
 {
 	return -ENOSYS;
diff --git a/lib/Makefile b/lib/Makefile
index d0ffabc2b47..c69a928e6d8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_ARCH_AT91) += at91/
 obj-$(CONFIG_OPTEE_LIB) += optee/
 
 obj-$(CONFIG_AES) += aes.o
-obj-$(CONFIG_AES) += aes/
 obj-$(CONFIG_$(PHASE_)BINMAN_FDT) += binman.o
 
 obj-$(CONFIG_FW_LOADER) += fw_loader.o
@@ -88,6 +87,7 @@ obj-$(CONFIG_$(PHASE_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
 obj-$(CONFIG_$(PHASE_)ZLIB) += zlib/
 obj-$(CONFIG_$(PHASE_)ZSTD) += zstd/
+obj-$(CONFIG_$(PHASE_)FIT_CIPHER) += aes/
 obj-$(CONFIG_$(PHASE_)GZIP) += gunzip.o
 obj-$(CONFIG_$(PHASE_)LZO) += lzo/
 obj-$(CONFIG_$(PHASE_)LZMA) += lzma/
diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
index 741102a4723..b694474c029 100644
--- a/lib/aes/aes-decrypt.c
+++ b/lib/aes/aes-decrypt.c
@@ -4,37 +4,115 @@
  */
 
 #ifndef USE_HOSTCC
+#include <dm.h>
 #include <malloc.h>
 #endif
 #include <image.h>
 #include <uboot_aes.h>
 
+#ifndef USE_HOSTCC
+static int image_aes_validate_lengths(struct image_cipher_info *info,
+				      size_t cipher_len)
+{
+	if (!cipher_len || cipher_len % AES_BLOCK_LENGTH ||
+	    info->size_unciphered > cipher_len)
+		return -EINVAL;
+
+	return 0;
+}
+#endif
+
+int image_aes_decrypt_to(struct image_cipher_info *info,
+			 const void *cipher, size_t cipher_len,
+			 void *data, size_t *size)
+{
+#ifndef USE_HOSTCC
+	unsigned int aes_blocks, key_len = info->cipher->key_len;
+	int ret;
+
+	ret = image_aes_validate_lengths(info, cipher_len);
+	if (ret)
+		return ret;
+
+	*size = info->size_unciphered;
+
+	if (CONFIG_IS_ENABLED(DM_AES)) {
+		struct udevice *dev;
+
+		ret = uclass_first_device_err(UCLASS_AES, &dev);
+		if (!ret) {
+			u8 slot;
+
+			ret = dm_aes_get_software_key_slot(dev);
+			if (ret < 0)
+				return ret;
+			if (ret > 0xff)
+				return -ERANGE;
+			slot = ret;
+
+			ret = dm_aes_set_key_for_key_slot(dev, key_len * 8,
+							  (u8 *)info->key,
+							  slot);
+			if (ret)
+				return ret;
+
+			ret = dm_aes_select_key_slot(dev, key_len * 8, slot);
+			if (ret)
+				return ret;
+
+			aes_blocks = cipher_len / AES_BLOCK_LENGTH;
+
+			return dm_aes_cbc_decrypt(dev, (u8 *)info->iv,
+						  (u8 *)cipher, data,
+						  aes_blocks);
+		}
+	}
+
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		unsigned char key_exp[AES256_EXPAND_KEY_LENGTH];
+
+		/* First we expand the key. */
+		aes_expand_key((u8 *)info->key, key_len, key_exp);
+
+		/* Calculate the number of AES blocks to decrypt. */
+		aes_blocks = cipher_len / AES_BLOCK_LENGTH;
+
+		aes_cbc_decrypt_blocks(key_len, key_exp, (u8 *)info->iv,
+				       (u8 *)cipher, data, aes_blocks);
+		return 0;
+	}
+
+	return -ENOSYS;
+#endif
+
+	return -ENOSYS;
+}
+
 int image_aes_decrypt(struct image_cipher_info *info,
 		      const void *cipher, size_t cipher_len,
 		      void **data, size_t *size)
 {
-#ifndef USE_HOSTCC
-	unsigned char key_exp[AES256_EXPAND_KEY_LENGTH];
-	unsigned int aes_blocks, key_len = info->cipher->key_len;
+#ifdef USE_HOSTCC
+	return 0;
+#else
+	int ret;
+
+	ret = image_aes_validate_lengths(info, cipher_len);
+	if (ret)
+		return ret;
 
 	*data = malloc(cipher_len);
 	if (!*data) {
 		printf("Can't allocate memory to decrypt\n");
 		return -ENOMEM;
 	}
-	*size = info->size_unciphered;
 
-	memcpy(&key_exp[0], info->key, key_len);
-
-	/* First we expand the key. */
-	aes_expand_key((u8 *)info->key, key_len, key_exp);
-
-	/* Calculate the number of AES blocks to encrypt. */
-	aes_blocks = DIV_ROUND_UP(cipher_len, AES_BLOCK_LENGTH);
+	ret = image_aes_decrypt_to(info, cipher, cipher_len, *data, size);
+	if (ret) {
+		free(*data);
+		*data = NULL;
+	}
 
-	aes_cbc_decrypt_blocks(key_len, key_exp, (u8 *)info->iv,
-			       (u8 *)cipher, *data, aes_blocks);
+	return ret;
 #endif
-
-	return 0;
 }

-- 
2.53.0

