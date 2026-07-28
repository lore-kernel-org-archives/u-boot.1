Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3A7C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5835160A8A;
	Wed, 29 Jul 2026 04:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gE0BvBOVweH5; Wed, 29 Jul 2026 04:55:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 63F44607E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300942;
	bh=anL8dCf1pJN0E4ieBeE26RQ+8fbqGghGUFn46NQ/BmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x1RuaxPHdG3VuVCsN/p6BPCD00Girh3n0487dVM5xzjylrdtaZ7YERpyP5qAAoLib
	 adPmrj6BbLpvPhyNRzuN2xDsbH9ONEkCYhd6HaEpsB3f32e1TPhy2jc/zGiu3h0Uij
	 AMyGHTLodIDrolGKe/aac0Twbr7LuQHGEs6g/5doCXeICO4v9AQx3PNqMuBkb1c16d
	 Ue8njIlcW6R1FFPwmomERxdNz4N9TmZZwzASyv0kvdLznPMW+/PEw79OCXK0FLBUXZ
	 BhJg8bCZaci/OnUlfpl59MDaVGx1orEaw1fXLQO6aiw1WbJgFTglLnSCeanuYaOESQ
	 SO4qgpbjA2dLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63F44607E3;
	Wed, 29 Jul 2026 04:55:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EDA0B4BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFA11409BB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fj3uravrDWFX for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:44:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D89AE4096A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D89AE4096A
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D89AE4096A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:05 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6aa9606ddadso127330eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785260645; x=1785865445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=anL8dCf1pJN0E4ieBeE26RQ+8fbqGghGUFn46NQ/BmM=;
 b=LHIpjvsNgrgpkAo4vWsaCV21raVLqcH6ShsKKkB1BFce2qHOLxvrGCvTaWRNAkmujL
 p4pcs9D9aFJJLeMfEsAHVhTDkkZEFPVdOxzq5uu6WmihSVB/V/x2drRugVDtlJ9/KO/Z
 LxPENo9kEJLkJ5/rTZRWnwXhVeO9jRj4tvOUJi/V+Ws0xFBsvXmwrUEceWSsuYmddFwS
 IMWViQdAaG7RbR3TyoO0zA1ba53CRfvSUfoiS2KjjAOpIcKINZZ2xRLm127mr7j76fNW
 i7fbPKB4YrBgYrajCNLcyqqgJ0hqu4ZGlA36Tk1/WJHIBSnJ0p4b/5UbphM/4OC3q/vK
 G1cQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWTbhh15Efaz6+wG6g6HL0blviL5PycGsjenz4sM6+f+1IbyHF5a0kJxk4ToqVghaTQNMPRXo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwE9oJ1hnQofDqN0ZV30RZjBR7yvMJeqQW4ckdqCGfeKkWF89vl
 YDemgOsezboAfzmYgGSTcpybtfAdujv5EEfYxDRPjQiGQXnFqmjmsbnC
X-Gm-Gg: AR+sD138IR3Apy5Ay/rLtWQlyk3LNxxxZJPwlRJ01KrJNHbT2hV/rU42W/jkP3EFZWX
 1Z0YQOMSOOmhyIFaUaVLIHVO4qn1M3cTpl7xrfzSLh6lFk7yA/41y8LPWemsOj4j0IlwV14qJfV
 k0dQWuYML7pUMx/w1mJQpWk2wUVDg3jrRgOFByq2K5nVc2lX2zhy7Tj4axZhNdSWhEczF0QnlUZ
 4R6of70vhdWk1NP/uyh+cxIWE7pxZSX7HbTlr2hSWUmZtFYyHz4y/xgN7PFlmHKtXMSkKwp0+bl
 GaifC8hX47rD3sa2UnEEKmPIOwIX9na5MZbwDClmUlVgQtvVVat8/9iyGlctZLLQ3U/Du4a3Ky2
 kI6OFJCN7mbqR1Pu07CBeilep3y6cA40A2FWuDoDi7hymyOZTBY5ms0XAkMJ6tcgOZw2mxyVAs8
 biuNy9hiir0W7d7qnKHQMZAkdb3f0RNfNkQ72vlL0PRyWMr5SULVrzWPyf9PExlA9OverJZLNCi
 TF4Vn4RfmEeZ9bw/dlcjIVBk+6IUPr4i8yfSp7oQjsMOZ3vGOBNGyG8
X-Received: by 2002:a05:6820:4b02:b0:6aa:c3f3:fbb0 with SMTP id
 006d021491bc7-6ac96a9e244mr1769883eaf.32.1785260644360; 
 Tue, 28 Jul 2026 10:44:04 -0700 (PDT)
Received: from [127.0.1.1] (71-218-31-69.hlrn.qwest.net. [71.218.31.69])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d94389dsm271103a34.21.2026.07.28.10.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:44:03 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 28 Jul 2026 11:41:48 -0600
Subject: [PATCH v6 05/13] crypto: aes: fix software key-size handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-submit-ce-series-v2-v6-5-80c1f7daffa5@gmail.com>
References: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
In-Reply-To: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
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
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785260645; x=1785865445;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=anL8dCf1pJN0E4ieBeE26RQ+8fbqGghGUFn46NQ/BmM=;
 b=J/VOMIi7K69cz6ySgHiDycmw6XQaqUVqYGKy3Zu8UD/H6kpdp7xJV04Wia6GTPs67v
 gHJSgr8Av3ZK2jHLbTq1EYqtaSAVl3Q1Z2RjUoLoc+c4ddpdRS/uh81t3R4tHy5sQpmV
 y2VVYYkb6+rkmRgGgdc3mo4iY1GdWZwkv7B5l+CcJ6euhArAR3/A2mcKxKR0/bIRTqI7
 Y7ULGWRo7a0r4WL+QRy8HA0Oeh8SO/T1Aw9ceG15Ohs/fInt8tpq7A1DYqHZOErK/Hbc
 Qku2dNNL8xUn0BDP5jNEoyVaFneczSDSjibMQOW5706oxI4F7oPHGyZahoneeCmACOKj
 WKHw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=J/VOMIi7
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The AES uclass API expresses key sizes in bits, while the common software
AES primitives take key lengths in bytes. The software provider passes the
uclass value through unchanged, so AES-192 and AES-256 select the AES-128
round count and key schedule shape. Key expansion also copies the bit count
as a byte count for every key size.

Validate the uclass key size, convert it to bytes once and retain that byte
length for the software operations. Correct the primitive API documentation
and add NIST ECB and CBC vectors for AES-128, AES-192 and AES-256.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v5 -> v6:
  - Drop stale AES-128 wording from the generic primitive docs
    (suggested by Simon Glass)
  - Return -EINVAL when no software key has been selected
    (suggested by Simon Glass)

Changes v3 -> v4:
  - New patch
---
 drivers/crypto/aes/aes-sw.c |  45 ++++++++++++------
 include/uboot_aes.h         |  24 +++++-----
 test/dm/aes.c               | 109 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/aes/aes-sw.c b/drivers/crypto/aes/aes-sw.c
index a65200fb79b..4ec9484c608 100644
--- a/drivers/crypto/aes/aes-sw.c
+++ b/drivers/crypto/aes/aes-sw.c
@@ -12,15 +12,25 @@ struct sw_aes_priv {
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
-		return 1;
+		return -EINVAL;
 	}
 
 	if (priv->key_expanded)
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
index 592b7dbee43..e463d5b0c42 100644
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
- * aes_encrypt() - Encrypt single block of data with AES 128
+ * aes_encrypt() - Encrypt a single block of data with AES
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
- * aes_decrypt() - Decrypt single block of data with AES 128
+ * aes_decrypt() - Decrypt a single block of data with AES
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
index 702e4db2b35..c58a5e257f5 100644
--- a/test/dm/aes.c
+++ b/test/dm/aes.c
@@ -29,6 +29,8 @@ static int dm_test_aes(struct unit_test_state *uts)
 	u8 test_output[AES_BLOCK_LENGTH];
 
 	ut_assertok(uclass_first_device_err(UCLASS_AES, &dev));
+	ut_asserteq(-EINVAL,
+		    dm_aes_ecb_encrypt(dev, test_input, test_output, 1));
 
 	/* software AES exposes 2 key slots */
 	ut_asserteq(2, dm_aes_get_available_key_slots(dev));
@@ -55,3 +57,110 @@ static int dm_test_aes(struct unit_test_state *uts)
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

