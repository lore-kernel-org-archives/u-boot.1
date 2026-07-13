Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE32CC44507
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F2984B87;
	Mon, 13 Jul 2026 15:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eUm+P+IM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B2C184A4F; Mon, 13 Jul 2026 08:43:49 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2904F84A48
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4472500e25fso1328463fac.1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925026; x=1784529826; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=90F51Koe7yFjcx9Q5OaPQdkwZWssxkYpZdxGtD2uZkA=;
 b=eUm+P+IMye74q4iYlSIrg90v8bgkwi4omMAY4FZuiWgovVuhB76gxtjgb+vy2j3XUW
 yODpNGwo6BEMVDu+gGxNPp9sOAaMeVp0oN/d2BIbOCku2I2X2zKIJBWjk5FYZgxqJmJq
 JmQ/vsTGD2LmoAhbQjlWckaj+bPeqJb9WiO64zVI3GNPjyjzwXhrIyEvkfuJJbnIaBFN
 aSAES87zXaV8hU9FsnWXiRXUMC+NhedCrGxl+7UeBMiAysrl4vV3iYnwZxQdQufiQpVF
 PDZPwaWWJwA4zY0uDO+fkxL1nL3cGJfqD6HdnjMUzKG2N7MZn297OPUdb+YAUZvaID2b
 SgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925026; x=1784529826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=90F51Koe7yFjcx9Q5OaPQdkwZWssxkYpZdxGtD2uZkA=;
 b=DdNaxCvAh4mvGP8JWa+hoFOcgTnV4r45E4xddvjg+7xdz8PlzA0QcOtGQLIIpHJT8r
 ljOmoUtkcL2S2v/hYM1GG3gPAZLoyx5e95749nkLfjlDO2HEQz2v6kBYZayU+ux122Dl
 LOLrqv0SLUHqzPzBftppGqYyo6HJP511by6KP3J+D152ofbuNjhnThzNL1604M9t5EDS
 R20E5QdgD/psIUHxrll7RCX5ZiJuyU7HlhFGLOZRWDZqQ679HxG35safDmtf9N1RuuDd
 j6S9k6TeKcncS9KcIUT7P97jGovBvLOkLvpWi1xiEyLkGhteSjSZdnKAYC+yo2bH3qAu
 CPxw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqyum/Frk33xV5l6pV6jeXdpMrWijPQ2p1dxn6Zq1wxifxNqaUHNITCeM8eyWKv+m4/kRx5ozo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/zeB3b0kzWfezEpWzoaE6xJT2YP+L0afrrPF5mqMPNfSvYPUz
 piYlsNvYmRiCUWsrY3xltpY8PJIV8LaDNxVh6wGPJMzflvPw17BsxbhK
X-Gm-Gg: AfdE7ckR6om4dykV8bFGlwevvY+Vc91KgBufPzQH/x3l90l7XijohtFHlV0qt72Sdop
 isl91htapulvwfaI1ihs8b2ygNZkg3iMDoW/DKa8XrNbkslwd9IVjz62vl5Py/D6DYu6GJFxWJn
 8cKQL8QNM+IqeTY6dS9y/sKI91QOMlX9yZKO0Buu5E5mb0//Xn6zDFlc3y/UNFj8To1jEv/4zyE
 UzjX8lT+AvqnPSRa/SoiHgH4trwUe/ePg4YYk78RA8NCaW5/Ru9XXCnUqeRevZgABiqoaLnYgdi
 4/BGNeyhY6BxvGn8QvfwTbXVmNEpfDs6iYjNEUSTJwadStaWAeJefEksTfnmNECCInbZhmh8rHW
 ycg5Ugt3SU6VjSkrGPW9OWNWjafZKyz+Ekri20FJWK2LYMruSCu2glQWaxQcCytos60D2b/J7+d
 I0eRZ6sqD+7X6Dbpm47Yg4a/iAWP0OZWiwCwUhCcnfoPBSu3QrtrYO22fDJ8HWBGiM+2kx+vU7k
 x1bHAzMO4qF/qGBrspv5/n8AcuY3lR6ZAmRBFPj/baLtEH7If00Ej2gKFlBZWV7
X-Received: by 2002:a05:6870:312a:b0:43f:41cc:1e34 with SMTP id
 586e51a60fabf-451f0f4cbf9mr4559658fac.1.1783925025740; 
 Sun, 12 Jul 2026 23:43:45 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:43:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 13 Jul 2026 00:43:03 -0600
Subject: [PATCH v4 06/14] crypto: aes: fix software key-size handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-submit-ce-series-v2-v4-6-ff7edc705b8a@gmail.com>
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

The AES uclass API expresses key sizes in bits, while the common software
AES primitives take key lengths in bytes. The software provider passes the
uclass value through unchanged, so AES-192 and AES-256 select the AES-128
round count and key schedule shape. Key expansion also copies the bit count
as a byte count for every key size.

Validate the uclass key size, convert it to bytes once and retain that byte
length for the software operations. Correct the primitive API documentation
and add NIST ECB and CBC vectors for AES-128, AES-192 and AES-256.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - New patch
---
 drivers/crypto/aes/aes-sw.c |  43 +++++++++++++-----
 include/uboot_aes.h         |  20 ++++-----
 test/dm/aes.c               | 107 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/aes/aes-sw.c b/drivers/crypto/aes/aes-sw.c
index a65200fb79b..6bad343ea7d 100644
--- a/drivers/crypto/aes/aes-sw.c
+++ b/drivers/crypto/aes/aes-sw.c
@@ -12,13 +12,23 @@ struct sw_aes_priv {
 	u8 key_slots[SW_KEY_SLOTS][AES256_KEY_LENGTH];
 	u8 key_schedule[AES256_EXPAND_KEY_LENGTH];
 	u8 selected_slot;
-	u32 selected_key_size;
+	u8 selected_key_len;
 	bool key_expanded;
 };
 
+static int sw_aes_key_len(u32 key_size)
+{
+	if (key_size == AES128_KEY_LENGTH * 8 ||
+	    key_size == AES192_KEY_LENGTH * 8 ||
+	    key_size == AES256_KEY_LENGTH * 8)
+		return key_size / 8;
+
+	return -EINVAL;
+}
+
 static int prepare_aes(struct sw_aes_priv *priv)
 {
-	if (!priv->selected_key_size) {
+	if (!priv->selected_key_len) {
 		log_debug("%s: AES key size not set, setup a slot first\n", __func__);
 		return 1;
 	}
@@ -28,7 +38,8 @@ static int prepare_aes(struct sw_aes_priv *priv)
 
 	priv->key_expanded = 1;
 
-	aes_expand_key(priv->key_slots[priv->selected_slot], priv->selected_key_size,
+	aes_expand_key(priv->key_slots[priv->selected_slot],
+		       priv->selected_key_len,
 		       priv->key_schedule);
 
 	return 0;
@@ -42,12 +53,16 @@ static int sw_aes_ops_available_key_slots(struct udevice *dev)
 static int sw_aes_ops_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
 {
 	struct sw_aes_priv *priv = dev_get_priv(dev);
+	int key_len;
 
 	if (slot >= SW_KEY_SLOTS)
-		return 1;
+		return -EINVAL;
+	key_len = sw_aes_key_len(key_size);
+	if (key_len < 0)
+		return key_len;
 
 	priv->selected_slot = slot;
-	priv->selected_key_size = key_size;
+	priv->selected_key_len = key_len;
 	priv->key_expanded = 0;
 
 	return 0;
@@ -57,14 +72,18 @@ static int sw_aes_ops_set_key_for_key_slot(struct udevice *dev, u32 key_size,
 					   u8 *key, u8 slot)
 {
 	struct sw_aes_priv *priv = dev_get_priv(dev);
+	int key_len;
 
 	if (slot >= SW_KEY_SLOTS)
-		return 1;
+		return -EINVAL;
+	key_len = sw_aes_key_len(key_size);
+	if (key_len < 0)
+		return key_len;
 
-	memcpy(priv->key_slots[slot], key, key_size / 8);
+	memcpy(priv->key_slots[slot], key, key_len);
 
 	if (priv->selected_slot == slot)
-		priv->selected_key_size = key_size;
+		priv->selected_key_len = key_len;
 
 	priv->key_expanded = 0;
 
@@ -82,7 +101,7 @@ static int sw_aes_ops_aes_ecb_encrypt(struct udevice *dev, u8 *src, u8 *dst,
 		return ret;
 
 	while (num_aes_blocks > 0) {
-		aes_encrypt(priv->selected_key_size, src, priv->key_schedule, dst);
+		aes_encrypt(priv->selected_key_len, src, priv->key_schedule, dst);
 		num_aes_blocks -= 1;
 		src += AES_BLOCK_LENGTH;
 		dst += AES_BLOCK_LENGTH;
@@ -102,7 +121,7 @@ static int sw_aes_ops_aes_ecb_decrypt(struct udevice *dev, u8 *src, u8 *dst,
 		return ret;
 
 	while (num_aes_blocks > 0) {
-		aes_decrypt(priv->selected_key_size, src, priv->key_schedule, dst);
+		aes_decrypt(priv->selected_key_len, src, priv->key_schedule, dst);
 		num_aes_blocks -= 1;
 		src += AES_BLOCK_LENGTH;
 		dst += AES_BLOCK_LENGTH;
@@ -121,7 +140,7 @@ static int sw_aes_ops_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src,
 	if (ret)
 		return ret;
 
-	aes_cbc_encrypt_blocks(priv->selected_key_size, priv->key_schedule, iv,
+	aes_cbc_encrypt_blocks(priv->selected_key_len, priv->key_schedule, iv,
 			       src, dst, num_aes_blocks);
 
 	return 0;
@@ -137,7 +156,7 @@ static int sw_aes_ops_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
 	if (ret)
 		return ret;
 
-	aes_cbc_decrypt_blocks(priv->selected_key_size, priv->key_schedule,
+	aes_cbc_decrypt_blocks(priv->selected_key_len, priv->key_schedule,
 			       iv, src, dst, num_aes_blocks);
 
 	return 0;
diff --git a/include/uboot_aes.h b/include/uboot_aes.h
index 592b7dbee43..65a9b382843 100644
--- a/include/uboot_aes.h
+++ b/include/uboot_aes.h
@@ -47,30 +47,30 @@ enum {
  * operations.
  *
  * @key		Key
- * @key_size	Size of the key (in bits)
+ * @key_len	Size of the key in bytes
  * @expkey	Buffer to place expanded key, AES_EXPAND_KEY_LENGTH
  */
-void aes_expand_key(u8 *key, u32 key_size, u8 *expkey);
+void aes_expand_key(u8 *key, u32 key_len, u8 *expkey);
 
 /**
  * aes_encrypt() - Encrypt single block of data with AES 128
  *
- * @key_size	Size of the aes key (in bits)
+ * @key_len	Size of the AES key in bytes
  * @in		Input data
  * @expkey	Expanded key to use for encryption (from aes_expand_key())
  * @out		Output data
  */
-void aes_encrypt(u32 key_size, u8 *in, u8 *expkey, u8 *out);
+void aes_encrypt(u32 key_len, u8 *in, u8 *expkey, u8 *out);
 
 /**
  * aes_decrypt() - Decrypt single block of data with AES 128
  *
- * @key_size	Size of the aes key (in bits)
+ * @key_len	Size of the AES key in bytes
  * @in		Input data
  * @expkey	Expanded key to use for decryption (from aes_expand_key())
  * @out		Output data
  */
-void aes_decrypt(u32 key_size, u8 *in, u8 *expkey, u8 *out);
+void aes_decrypt(u32 key_len, u8 *in, u8 *expkey, u8 *out);
 
 /**
  * Apply chain data to the destination using EOR
@@ -86,27 +86,27 @@ void aes_apply_cbc_chain_data(u8 *cbc_chain_data, u8 *src, u8 *dst);
 /**
  * aes_cbc_encrypt_blocks() - Encrypt multiple blocks of data with AES CBC.
  *
- * @key_size		Size of the aes key (in bits)
+ * @key_len		Size of the AES key in bytes
  * @key_exp		Expanded key to use
  * @iv			Initialization vector
  * @src			Source data to encrypt
  * @dst			Destination buffer
  * @num_aes_blocks	Number of AES blocks to encrypt
  */
-void aes_cbc_encrypt_blocks(u32 key_size, u8 *key_exp, u8 *iv, u8 *src, u8 *dst,
+void aes_cbc_encrypt_blocks(u32 key_len, u8 *key_exp, u8 *iv, u8 *src, u8 *dst,
 			    u32 num_aes_blocks);
 
 /**
  * Decrypt multiple blocks of data with AES CBC.
  *
- * @key_size		Size of the aes key (in bits)
+ * @key_len		Size of the AES key in bytes
  * @key_exp		Expanded key to use
  * @iv			Initialization vector
  * @src			Source data to decrypt
  * @dst			Destination buffer
  * @num_aes_blocks	Number of AES blocks to decrypt
  */
-void aes_cbc_decrypt_blocks(u32 key_size, u8 *key_exp, u8 *iv, u8 *src, u8 *dst,
+void aes_cbc_decrypt_blocks(u32 key_len, u8 *key_exp, u8 *iv, u8 *src, u8 *dst,
 			    u32 num_aes_blocks);
 
 /* An AES block filled with zeros */
diff --git a/test/dm/aes.c b/test/dm/aes.c
index 702e4db2b35..9c85fb1dac9 100644
--- a/test/dm/aes.c
+++ b/test/dm/aes.c
@@ -55,3 +55,110 @@ static int dm_test_aes(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_aes, UTF_SCAN_FDT);
+
+struct aes_test_vector {
+	u32 key_size;
+	u8 key[AES256_KEY_LENGTH];
+	u8 ecb[AES_BLOCK_LENGTH];
+	u8 cbc[AES_BLOCK_LENGTH];
+};
+
+static const u8 aes_test_plaintext[AES_BLOCK_LENGTH] = {
+	0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96,
+	0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a,
+};
+
+static const u8 aes_test_iv[AES_BLOCK_LENGTH] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+};
+
+static const struct aes_test_vector aes_test_vectors[] = {
+	{
+		.key_size = 128,
+		.key = {
+			0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
+			0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c,
+		},
+		.ecb = {
+			0x3a, 0xd7, 0x7b, 0xb4, 0x0d, 0x7a, 0x36, 0x60,
+			0xa8, 0x9e, 0xca, 0xf3, 0x24, 0x66, 0xef, 0x97,
+		},
+		.cbc = {
+			0x76, 0x49, 0xab, 0xac, 0x81, 0x19, 0xb2, 0x46,
+			0xce, 0xe9, 0x8e, 0x9b, 0x12, 0xe9, 0x19, 0x7d,
+		},
+	}, {
+		.key_size = 192,
+		.key = {
+			0x8e, 0x73, 0xb0, 0xf7, 0xda, 0x0e, 0x64, 0x52,
+			0xc8, 0x10, 0xf3, 0x2b, 0x80, 0x90, 0x79, 0xe5,
+			0x62, 0xf8, 0xea, 0xd2, 0x52, 0x2c, 0x6b, 0x7b,
+		},
+		.ecb = {
+			0xbd, 0x33, 0x4f, 0x1d, 0x6e, 0x45, 0xf2, 0x5f,
+			0xf7, 0x12, 0xa2, 0x14, 0x57, 0x1f, 0xa5, 0xcc,
+		},
+		.cbc = {
+			0x4f, 0x02, 0x1d, 0xb2, 0x43, 0xbc, 0x63, 0x3d,
+			0x71, 0x78, 0x18, 0x3a, 0x9f, 0xa0, 0x71, 0xe8,
+		},
+	}, {
+		.key_size = 256,
+		.key = {
+			0x60, 0x3d, 0xeb, 0x10, 0x15, 0xca, 0x71, 0xbe,
+			0x2b, 0x73, 0xae, 0xf0, 0x85, 0x7d, 0x77, 0x81,
+			0x1f, 0x35, 0x2c, 0x07, 0x3b, 0x61, 0x08, 0xd7,
+			0x2d, 0x98, 0x10, 0xa3, 0x09, 0x14, 0xdf, 0xf4,
+		},
+		.ecb = {
+			0xf3, 0xee, 0xd1, 0xbd, 0xb5, 0xd2, 0xa0, 0x3c,
+			0x06, 0x4b, 0x5a, 0x7e, 0x3d, 0xb1, 0x81, 0xf8,
+		},
+		.cbc = {
+			0xf5, 0x8c, 0x4c, 0x04, 0xd6, 0xe5, 0xf1, 0xba,
+			0x77, 0x9e, 0xab, 0xfb, 0x5f, 0x7b, 0xfb, 0xd6,
+		},
+	},
+};
+
+static int dm_test_aes_key_sizes(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 key[AES256_KEY_LENGTH];
+	u8 input[AES_BLOCK_LENGTH];
+	u8 iv[AES_BLOCK_LENGTH];
+	u8 buf[AES_BLOCK_LENGTH];
+	int i, ret;
+
+	ut_assertok(uclass_first_device_err(UCLASS_AES, &dev));
+
+	for (i = 0; i < ARRAY_SIZE(aes_test_vectors); i++) {
+		const struct aes_test_vector *vector = &aes_test_vectors[i];
+
+		memcpy(key, vector->key, vector->key_size / 8);
+		memcpy(input, aes_test_plaintext, sizeof(input));
+		memcpy(iv, aes_test_iv, sizeof(iv));
+		ut_assertok(dm_aes_select_key_slot(dev, vector->key_size, 0));
+		ret = dm_aes_set_key_for_key_slot(dev, vector->key_size, key, 0);
+		ut_assertok(ret);
+
+		ut_assertok(dm_aes_ecb_encrypt(dev, input, buf, 1));
+		ut_asserteq_mem(vector->ecb, buf, sizeof(buf));
+		ut_assertok(dm_aes_ecb_decrypt(dev, buf, buf, 1));
+		ut_asserteq_mem(aes_test_plaintext, buf, sizeof(buf));
+
+		ut_assertok(dm_aes_cbc_encrypt(dev, iv, input, buf, 1));
+		ut_asserteq_mem(vector->cbc, buf, sizeof(buf));
+		ut_assertok(dm_aes_cbc_decrypt(dev, iv, buf, buf, 1));
+		ut_asserteq_mem(aes_test_plaintext, buf, sizeof(buf));
+	}
+
+	ut_asserteq(-EINVAL, dm_aes_select_key_slot(dev, 64, 0));
+	ret = dm_aes_set_key_for_key_slot(dev, 64, key, 0);
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_aes_key_sizes, UTF_SCAN_FDT);

-- 
2.53.0

