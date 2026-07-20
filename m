Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FF4C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 04:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D339484A30;
	Mon, 20 Jul 2026 06:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hj+ROnMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E07838D7; Mon, 20 Jul 2026 06:14:34 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0F680433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7eb68bdf53aso3821505a34.3
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 21:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784520870; x=1785125670; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/lJNAL5POB5n6xDbVkf8AHgAaCOeGVrED/Phnc0IVLQ=;
 b=hj+ROnMnszkCBimPyPffWGrq8WHArcWdahWPgi9ZAi9EnKILkffvRMPlnu4I94kV2j
 5z16mOMwEfuX4CALo3Aw34Mw4zu8ShUw2eZprOnt5z1yDcS9CVVwbEtWW5EDgeanO9tm
 jRR7pgQ6UoJW3Zycw5pz35do/qvStJuCXKMzOSdhmexlSOrTl7sj3l4X9brcVtjfzpMX
 PByhljIGERVI+CfBscV5UF1P54mEBUWkx5NVqfHDW5e9PxrwpDSgmXx2Ps3D8gWEup7N
 YnJWKP6J1zjZoO451vScg4A6t4fpuesdZzft34dA6DNiwTRo4mWdjD736/PxjsuynKoE
 e/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784520870; x=1785125670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/lJNAL5POB5n6xDbVkf8AHgAaCOeGVrED/Phnc0IVLQ=;
 b=ISMx6LTx1Gyw6dIOzcb+vwZtF7Nyx4ldlIFQqEcUWUf8EPMEll7LAHmfLY1fHPTskH
 8axV8zjaomHlSsPcxZgt0Z63+taAePdWZn2MAd7TR3yfHt0fv0g7L0XPx5MXLDmBpp+1
 bAWeMFx++ACiVZh3Tk//K3mb/54pYUIcIwa/bQzCdZI7d9EHd61k07dZOrH8QTmToy8k
 BLc2c7gYBns57lwfLSieOoP+ht/CLAnfRizUBnKTzgHGSxehMjyIZw3aPtpW0MRuc8uP
 IvbHCrgmMOFzHbD2SGnQaX4pGynDjJEuAa946bZBT+xKw1VzZfLo2HjmsR3AR8EOaivx
 deDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5a639sVrnBShKzU6dmnrstGDk+5m9hbjMueTWQjukQjdDM8gEcUHudAG2Fdu0pePR6W3tCcM=@lists.denx.de
X-Gm-Message-State: AOJu0YxAOpgeIVqvk9yCYxDQzIC/iRpv9cc9XHua9yQveO97JJy7n+7w
 9yO5Z7STDACKX8BO2kZkTbFPfpa3t+oxSIEXp9uBn3fW71IHNbLtAJ40
X-Gm-Gg: AfdE7ck0neP+/8Ynmnj34juchJf9HkYs3+yxilZT4LwqxJ5lTW8ueCPof9xbakfLroA
 Aox9YOgCXspczhknBMxM1nsVPWitqmMHaPjmdQuGYw0lHsqxI89vUaWxYfu84/fqoEz+KGGz6/j
 ku+vKvM55YffxGkv3HaFCjGulFq6pzh1xIFpx9Hutf8CTMa+ImMoDf6iUzZnKtpxhEDadkOd0yh
 VamZQYYGFGqykob9Rz8x3LnLClep7Rg628LFiSYa5ENakI3SNMnERvXOtryQgDCDoinmn6KihSa
 SrvZdYAYxhtEIT/LaMN50wevV6bCGoQ3TGsuTkydY4ADxtB+hCK07yd1hEl761TNdl8s/FDdae7
 6K/JMSr/S+DwTU7RJDb/ln37qG70KnH1ATwOsBB1IdNWu/BQ5y4NWF1hi2e+15qy5SlaxtowL1p
 FicwF9YXyKa3HnP03aP56EILT34WLhjoXOYBMUVT7fj1tHH47XpY+Jfbg6D59hYg01X3wBmkrL4
 AuNgVTwPEe1QyOhipS1DsVU3RmUaUZ630QrT9rep7o7cYLTtkz5gg==
X-Received: by 2002:a05:6830:448c:b0:7e9:cc39:2ef0 with SMTP id
 46e09a7af769-7eda08e0908mr6570177a34.18.1784520870171; 
 Sun, 19 Jul 2026 21:14:30 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaf94a737sm7159191a34.15.2026.07.19.21.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 21:14:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 19 Jul 2026 22:13:51 -0600
Subject: [PATCH v5 07/14] crypto: aes: add software-key provider dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-submit-ce-series-v2-v5-7-3c41f66d4522@gmail.com>
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
In-Reply-To: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 20 Jul 2026 06:33:25 +0200
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

Generic callers which supply an AES key need a provider-owned slot policy,
since hardware may reserve or preload particular key slots. Selecting only
UCLASS_AES device zero also prevents a later provider from handling an
operation unsupported by the first device.

Add a callback through which each provider exposes a slot for
software-provided keys. Add a CBC decrypt helper which probes providers in
order, continuing only when a provider explicitly reports an unsupported
operation and preserving hard probe, setup and decrypt failures.

Use slot zero for the software provider and avoid Tegra's preloaded SBK
slot. Add sandbox coverage for provider fallback and hard-error
propagation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - New patch
---
 drivers/crypto/aes/aes-sw.c      |   6 ++
 drivers/crypto/aes/aes-uclass.c  |  73 +++++++++++++++++++
 drivers/crypto/tegra/tegra_aes.c |   7 ++
 include/uboot_aes.h              |  66 +++++++++++++++--
 test/dm/aes.c                    | 149 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 297 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/aes/aes-sw.c b/drivers/crypto/aes/aes-sw.c
index 6bad343ea7d..fe06fd2d5ba 100644
--- a/drivers/crypto/aes/aes-sw.c
+++ b/drivers/crypto/aes/aes-sw.c
@@ -50,6 +50,11 @@ static int sw_aes_ops_available_key_slots(struct udevice *dev)
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
@@ -164,6 +169,7 @@ static int sw_aes_ops_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
 
 static const struct aes_ops aes_ops_sw = {
 	.available_key_slots = sw_aes_ops_available_key_slots,
+	.get_software_key_slot = sw_aes_ops_get_software_key_slot,
 	.select_key_slot = sw_aes_ops_select_key_slot,
 	.set_key_for_key_slot = sw_aes_ops_set_key_for_key_slot,
 	.aes_ecb_encrypt = sw_aes_ops_aes_ecb_encrypt,
diff --git a/drivers/crypto/aes/aes-uclass.c b/drivers/crypto/aes/aes-uclass.c
index 5bdd3d736c4..ec1ea075367 100644
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
@@ -113,6 +128,64 @@ int dm_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src, u8 *dst, u32 num_ae
 	return ops->aes_cbc_decrypt(dev, iv, src, dst, num_aes_blocks);
 }
 
+static bool aes_op_unsupported(int ret)
+{
+	return ret == -ENOSYS || ret == -EOPNOTSUPP;
+}
+
+int dm_aes_cbc_decrypt_with_key(u32 key_size, u8 *key, u8 *iv, u8 *src,
+				u8 *dst, u32 num_aes_blocks)
+{
+	struct udevice *dev;
+	int first_probe_err = 0;
+	bool found = false;
+	int ret;
+
+	for (ret = uclass_first_device_check(UCLASS_AES, &dev); dev;
+	     ret = uclass_next_device_check(&dev)) {
+		u8 slot;
+
+		found = true;
+		if (ret) {
+			if (!first_probe_err)
+				first_probe_err = ret;
+			continue;
+		}
+
+		ret = dm_aes_get_software_key_slot(dev);
+		if (aes_op_unsupported(ret))
+			continue;
+		if (ret < 0)
+			return ret;
+		if (ret > U8_MAX)
+			return -ERANGE;
+		slot = ret;
+
+		ret = dm_aes_set_key_for_key_slot(dev, key_size, key, slot);
+		if (aes_op_unsupported(ret))
+			continue;
+		if (ret)
+			return ret;
+
+		ret = dm_aes_select_key_slot(dev, key_size, slot);
+		if (aes_op_unsupported(ret))
+			continue;
+		if (ret)
+			return ret;
+
+		ret = dm_aes_cbc_decrypt(dev, iv, src, dst, num_aes_blocks);
+		if (!ret)
+			return 0;
+		if (!aes_op_unsupported(ret))
+			return ret;
+	}
+
+	if (first_probe_err)
+		return first_probe_err;
+
+	return found ? -EOPNOTSUPP : -ENODEV;
+}
+
 static void left_shift_vector(u8 *in, u8 *out, int size)
 {
 	int carry = 0;
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
diff --git a/include/uboot_aes.h b/include/uboot_aes.h
index 65a9b382843..a2c35aa30ce 100644
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
@@ -210,6 +226,7 @@ struct aes_ops {
 	 * @iv			Initialization vector
 	 * @src			Source data of length 'num_aes_blocks' blocks
 	 * @dst			Destination data of length 'num_aes_blocks' blocks
+	 *			Must support dst == src for in-place decrypt
 	 * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
 	 * @return		0 on success, negative value on failure
 	 */
@@ -229,6 +246,15 @@ struct aes_ops {
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
@@ -291,11 +317,31 @@ int dm_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src, u8 *dst, u32 num_ae
  * @iv			Initialization vector
  * @src			Source data of length 'num_aes_blocks' blocks
  * @dst			Destination data of length 'num_aes_blocks' blocks
+ *			Must support dst == src for in-place decrypt
  * @num_aes_blocks	Number of AES blocks to encrypt/decrypt
  * Return:		0 on success, negative value on failure
  */
 int dm_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src, u8 *dst, u32 num_aes_blocks);
 
+/**
+ * dm_aes_cbc_decrypt_with_key() - Decrypt using a software-provided key
+ *
+ * Probe AES providers in order and use the first one which accepts the key
+ * and CBC operation. Hard failures from an accepting provider are returned
+ * without trying another provider.
+ *
+ * @key_size: AES key size in bits
+ * @key: AES key
+ * @iv: Initialization vector
+ * @src: Ciphertext input
+ * @dst: Plaintext output, which may be the same buffer as @src
+ * @num_aes_blocks: Number of AES blocks to decrypt
+ * Return: 0 on success, -ENODEV if there are no providers, -EOPNOTSUPP if no
+ * provider supports the operation, or another error from a provider
+ */
+int dm_aes_cbc_decrypt_with_key(u32 key_size, u8 *key, u8 *iv, u8 *src,
+				u8 *dst, u32 num_aes_blocks);
+
 /**
  * dm_aes_cmac - Hashes the input data with AES-CMAC, putting the result into dst.
  * The key slot must be selected already.
@@ -316,6 +362,11 @@ static inline int dm_aes_get_available_key_slots(struct udevice *dev)
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
@@ -351,6 +402,13 @@ static inline int dm_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
 	return -ENOSYS;
 }
 
+static inline int dm_aes_cbc_decrypt_with_key(u32 key_size, u8 *key, u8 *iv,
+					      u8 *src, u8 *dst,
+					      u32 num_aes_blocks)
+{
+	return -ENOSYS;
+}
+
 static inline int dm_aes_cmac(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks)
 {
 	return -ENOSYS;
diff --git a/test/dm/aes.c b/test/dm/aes.c
index 9c85fb1dac9..9f4ce42ab2a 100644
--- a/test/dm/aes.c
+++ b/test/dm/aes.c
@@ -6,7 +6,10 @@
  */
 
 #include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/root.h>
 #include <dm/test.h>
+#include <dm/uclass-internal.h>
 #include <uboot_aes.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -162,3 +165,149 @@ static int dm_test_aes_key_sizes(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_aes_key_sizes, UTF_SCAN_FDT);
+
+static int unsupported_calls;
+static int success_calls;
+static int hard_error_calls;
+
+static int aes_test_get_slot(struct udevice *dev)
+{
+	return 0;
+}
+
+static int aes_test_set_key(struct udevice *dev, u32 key_size, u8 *key,
+			    u8 slot)
+{
+	return 0;
+}
+
+static int aes_test_select_key(struct udevice *dev, u32 key_size, u8 slot)
+{
+	return 0;
+}
+
+static int aes_test_unsupported_slot(struct udevice *dev)
+{
+	unsupported_calls++;
+
+	return -ENOSYS;
+}
+
+static int aes_test_success_decrypt(struct udevice *dev, u8 *iv, u8 *src,
+				    u8 *dst, u32 num_aes_blocks)
+{
+	success_calls++;
+	memcpy(dst, src, num_aes_blocks * AES_BLOCK_LENGTH);
+
+	return 0;
+}
+
+static int aes_test_hard_error_decrypt(struct udevice *dev, u8 *iv, u8 *src,
+				       u8 *dst, u32 num_aes_blocks)
+{
+	hard_error_calls++;
+
+	return -EINVAL;
+}
+
+static const struct aes_ops aes_test_unsupported_ops = {
+	.get_software_key_slot = aes_test_unsupported_slot,
+};
+
+static const struct aes_ops aes_test_success_ops = {
+	.get_software_key_slot = aes_test_get_slot,
+	.set_key_for_key_slot = aes_test_set_key,
+	.select_key_slot = aes_test_select_key,
+	.aes_cbc_decrypt = aes_test_success_decrypt,
+};
+
+static const struct aes_ops aes_test_hard_error_ops = {
+	.get_software_key_slot = aes_test_get_slot,
+	.set_key_for_key_slot = aes_test_set_key,
+	.select_key_slot = aes_test_select_key,
+	.aes_cbc_decrypt = aes_test_hard_error_decrypt,
+};
+
+U_BOOT_DRIVER(aes_test_unsupported_drv) = {
+	.name = "aes_test_unsupported",
+	.id = UCLASS_AES,
+	.ops = &aes_test_unsupported_ops,
+};
+
+U_BOOT_DRIVER(aes_test_success_drv) = {
+	.name = "aes_test_success",
+	.id = UCLASS_AES,
+	.ops = &aes_test_success_ops,
+};
+
+U_BOOT_DRIVER(aes_test_hard_error_drv) = {
+	.name = "aes_test_hard_error",
+	.id = UCLASS_AES,
+	.ops = &aes_test_hard_error_ops,
+};
+
+static int aes_test_unbind_all(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	for (;;) {
+		ret = uclass_find_first_device(UCLASS_AES, &dev);
+		if (ret || !dev)
+			return ret;
+		if (device_active(dev)) {
+			ret = device_remove(dev, DM_REMOVE_NORMAL);
+			if (ret)
+				return ret;
+		}
+		ret = device_unbind(dev);
+		if (ret)
+			return ret;
+	}
+}
+
+static int aes_test_bind(const struct driver *drv, const char *name)
+{
+	struct udevice *dev;
+
+	return device_bind(dm_root(), drv, name, 0, ofnode_null(), &dev);
+}
+
+static int dm_test_aes_provider_selection(struct unit_test_state *uts)
+{
+	u8 key[AES128_KEY_LENGTH] = { };
+	u8 iv[AES_BLOCK_LENGTH] = { };
+	u8 src[AES_BLOCK_LENGTH] = { 0x5a };
+	u8 dst[AES_BLOCK_LENGTH] = { };
+	int ret;
+
+	ut_assertok(aes_test_unbind_all());
+	ut_assertok(aes_test_bind(DM_DRIVER_GET(aes_test_unsupported_drv),
+				  "aes-unsupported"));
+	ut_assertok(aes_test_bind(DM_DRIVER_GET(aes_test_success_drv),
+				  "aes-success"));
+
+	unsupported_calls = 0;
+	success_calls = 0;
+	ut_assertok(dm_aes_cbc_decrypt_with_key(128, key, iv, src, dst, 1));
+	ut_asserteq(1, unsupported_calls);
+	ut_asserteq(1, success_calls);
+	ut_asserteq_mem(src, dst, sizeof(src));
+
+	ut_assertok(aes_test_unbind_all());
+	ut_assertok(aes_test_bind(DM_DRIVER_GET(aes_test_hard_error_drv),
+				  "aes-hard-error"));
+	ut_assertok(aes_test_bind(DM_DRIVER_GET(aes_test_success_drv),
+				  "aes-success"));
+
+	hard_error_calls = 0;
+	success_calls = 0;
+	ret = dm_aes_cbc_decrypt_with_key(128, key, iv, src, dst, 1);
+	ut_asserteq(-EINVAL, ret);
+	ut_asserteq(1, hard_error_calls);
+	ut_asserteq(0, success_calls);
+
+	return 0;
+}
+
+DM_TEST(dm_test_aes_provider_selection, UTF_SCAN_FDT);

-- 
2.53.0

