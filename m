Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ED8C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10EF84B9A;
	Mon, 13 Jul 2026 15:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A4uoWX5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB49084A4F; Mon, 13 Jul 2026 08:43:51 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C1E584A4B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so1446923a34.1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925028; x=1784529828; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/lJNAL5POB5n6xDbVkf8AHgAaCOeGVrED/Phnc0IVLQ=;
 b=A4uoWX5DZ6m3Eu8EGTN0Af5TXu6cGSpfw1dg26kX0dVduedzVAQYs72lWN4x48Qe30
 cchfqO7IumwoMOI2MVSCvUglciO2RLsflj3zYaEb4Vwvetqfvle2hNEH13KHeUCnKQZY
 GVnvV2rzC6N2flpwJC9TDjLEkNLGeBSMXJV4XuU0yEcWBSkhi6Ht4gp05qbKspA/BuUb
 Gz6xwwo3pnmHjBAIzvn9virk1IrtjY7Am5FNFthk2hJPKYKGSMFHffL4bU8Vtprd53pO
 u909l4cIXSlZ4fugPpHJaFQuqxMKzDIXvNJW7NKcgCPjueYeTMEtdUGagJD5H2+xIit9
 HZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925028; x=1784529828;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/lJNAL5POB5n6xDbVkf8AHgAaCOeGVrED/Phnc0IVLQ=;
 b=fPe6RMmsCiHbE6v1pA9r7vNtY2h+dkzJqFCrLdCG2S59p2EHxatzXQ9dfx3dN9Q5xK
 b33r+Ge4yA+Q+MD8r3tKMie5PdSZ4KUIRusGvuM5brNPF1mAOcZ67OU6Tek62goXWc5U
 urT60AkZs83u+ZbL1lk1WSG/gXPglRwegyG0SUXbQfM7VgwYURmYaTcPDH+FaBFVAJNy
 J2kN43Mc/LEU6iuCYGA2ZdSTx8YxnV6yl02n3CMzQ6fdhhQhhhEkDjvyk7zjURIGyBjt
 gYHmY41c5DsIGHFvX+P1c2+HC8PXTJ00T6noVdMh254BxH8j1EOXhp0CmnMnSCAGPLQ+
 bgzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8ZgIu1jLbafkF3ZE+gvZvl8jWEh8a5hxbJdmX9hXxoGqaNXrLhTNPzhz81A8ZtuEDjasK93g=@lists.denx.de
X-Gm-Message-State: AOJu0YzKaIF2Czt2/pPK/PC4+kmRYmXa6Sx1VwVDyiDnKPRLH+rT8nqO
 3Ami0h1jatoRd3nD9onavYl7BuWzLUWlegIar+kYGAl4Y74753bPTEOn
X-Gm-Gg: AfdE7cnGMMipn7VR9vK2cXkgTMYk9nyWaUOGnsnzFODqXMDg+C/i6RSWcoMgS9kDQri
 ALCGLJ1d3AlaaFh4UvWhEhQdoIFCEleyDOlpnXQAXibJ1OrL5Br0eFd13k7QfR09BkvB4anRHnW
 QoP9+z4F/9DRNwOEWi8IdcKSlLdLeFecF58MURE/jMJSgLQTkWzWqntSldQmPpjivHPCYFt4IhA
 ZjE4WXSIYwtabJW025c/oAZ2b/77cko8mB6aEQaeYf+0WHA+y8hmT2D87KVRNG+S22tRTmu3ukg
 AYTAHFeqJo9db5AS3mB78r5g1CpLuwVRsmZhc72T6yQ9fpyMS7HfKODqYr/a4dT+12DGVkMMMSZ
 qrmhao9Xmuvw0UdVLkKzHycgPuvmXPz793gsUGCsX3+dX4sUgD4PabkAgJ+8sAv0yUbvHHqX77z
 JnBGfM//Tm7ujw6qjuSQnXbTs6kpmvOBfsKNzNRw04C0dy7jCmBmIJK6YOs3owWifZuZEmd0Hvd
 vrZSUu8vz38wBl5hv9AUGUk29rUdBKSa0K0nDE5zZV5E9cyuYJxsthjjJWojHBE
X-Received: by 2002:a05:6830:43a6:b0:7e9:eaec:f348 with SMTP id
 46e09a7af769-7ec097617e0mr5417023a34.20.1783925027792; 
 Sun, 12 Jul 2026 23:43:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:43:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 13 Jul 2026 00:43:04 -0600
Subject: [PATCH v4 07/14] crypto: aes: add software-key provider dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-submit-ce-series-v2-v4-7-ff7edc705b8a@gmail.com>
References: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
In-Reply-To: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
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
 Heiko Stuebner <heiko@sntech.de>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:20:59 +0200
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

