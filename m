Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6754AC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 04:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AFC184659;
	Mon, 20 Jul 2026 06:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tKDqviA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888F8838D7; Mon, 20 Jul 2026 06:14:38 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3CE080433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb6573bd52so5168899a34.3
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 21:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784520874; x=1785125674; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QNCBEqwHzrC/4Fz+eFSxTBW6auUPiaXq+21hCjyx6Yc=;
 b=tKDqviA2ps47hZaJal6vmL2xETUHVdQe9+aVHEbtdFH2kFW8D2SO2OA4z3AJlfCVPY
 Hm8wkWa5NHHoZY3MPgQVLvv7uytHPegwYOz/IBwG1dG2dLDPNj1RJgW9gpjjEU6vi2RC
 zc42c1WKYnsTexH2z6IwDCSrgrIyzYNMSIcLCeSTnqf6ixs0rWTNPqDas7DFoynSWTZ5
 BcyYeb50tqvhLkJMHBK1I9JVuMluVfusO15v6K2hKPGVolscsHstyXTNVuPRVrMcU/7D
 KdBdddH1IwIE7/VFz+uJcTThLlP6OcXZVb5oLXkjZ14I69vyZrMGobVhZn3hjwmWwxCS
 MBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784520874; x=1785125674;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QNCBEqwHzrC/4Fz+eFSxTBW6auUPiaXq+21hCjyx6Yc=;
 b=Qr4VcZhLZ8W9yftFkc7qb3X/685e5OqFR3Nu8cjnig84IA8b5fA/+gJ1GNNrCStq9P
 7qx5cVEo5sv77mHdWajrY3kExz/Njgm2jjduHXV+j7IzYpKNv4fC8XecXfsfT6vul/a5
 IcKQcbeaPWWBdzLGIoNNR17OyTYYVrQs5tEYFNEEdUy27ZQLmqR8B6ea5C0hRU3n9cYK
 WBazq7BLHVcd+IqhBJwX55nUVg4W3KOkGFybDI2uIPnT9It48kTmghPrdUS2DU7NIqbw
 PNkwiDX+144Pwc4Il6cAfyTsPv2s+1KJM0kD5hsWwP8IikxGbmBhT1Rzexb9GmE1OX9B
 7cIw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2VxM1UcTb20Qykw0uhknv8uLbCpnSh8e1EcrtIulGOKFO5UpaK28Q7fZjia2lZOYEs/azDZw=@lists.denx.de
X-Gm-Message-State: AOJu0YyYUtKEmPPNRk+JKUs1SZEb/NIn1e4ESbUhGFp+rVg5VuGPCPGY
 2FugV/b+5IJnOAiY/zHg46LP/V5LuyEPRWjly2KW++DPEVV+CqrHfphr
X-Gm-Gg: AfdE7cnJBmONwEBB49y8RLrQCqTj8cLrFNutBNvL5Z5aA3KzDTI+ccuXDKNL2kW8P40
 o1EDMhjFq/URUWxBpXu08CKUaM/JC0FDgV4iwTYL0fWKx5+X//9qAvTmsyEZDHr57MXPkGABoic
 9wDoUFg09HxOojzGmHrH+l3DZu6vE3nLNK8CaObXhOEzAq5+WpebXFpgrTl6IGYTCJBAzOqKn4/
 bFbQAYexyIqOMCKCJcrTFFWN7LnEUbFZ5E9qv62o46PaZ8sGrHxFZa1I9nIIC4uDc6eT6eusLUo
 rBHxtqT8lisdWvA2ocZnF4W/BsjFaHjVVDXNUjh+MAAqE+XCXaeldDN7HvTNElPWvdAR/M5XNzK
 7krDmRCa0v3Q0opFrQwzNpwZwBtKHpOA0qCx3HoP038wmRzQ0S4biDJYpfVSJYLy1NFAkJLwmMN
 Z/up9l8Q2vvdsnHlDb6uYFmqQ85mJ41dGP7BbFO8QTj+ijp2oMIGsE16SOaOTWDnS9XcdpsDigi
 FmgACXaqHkpGCA5yC0VQo5lWwzCnH4SkOoUgY2e0IptisRy9UGCwwjKaZG5Z7tc
X-Received: by 2002:a05:6830:4c15:b0:7e9:e860:6f1 with SMTP id
 46e09a7af769-7eda4a2af6fmr8100069a34.32.1784520874392; 
 Sun, 19 Jul 2026 21:14:34 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaf94a737sm7159191a34.15.2026.07.19.21.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 21:14:32 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 19 Jul 2026 22:13:52 -0600
Subject: [PATCH v5 08/14] boot: image: add FIT decrypt-to-buffer helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-submit-ce-series-v2-v5-8-3c41f66d4522@gmail.com>
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
SPL builds. Use the DM AES provider helper when enabled, retaining the
software implementation only when no provider supports the operation.

For U-Boot proper, use decrypt_to for in-place decryption when the FIT
payload is already in writable RAM. The encrypted data is no longer
needed after hash verification, and this avoids a full-size allocation
for encrypted payloads loaded into DRAM.

Add sandbox coverage for out-of-place and in-place AES-256 decrypt and
malformed key, IV and size inputs.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - Validate cipher metadata before reading the key length
  - Preserve hard provider failures and fall back only when unsupported
  - Treat -EINVAL as a hard provider error
  - Fix disabled-feature declarations and use the public test prototype
  - Add in-place decrypt and malformed-input tests
  - Simplify the legacy allocating decrypt wrapper

Changes v2 -> v3:
  - Flip the image_aes_decrypt_to() host-tool guard
    (suggested by Simon Glass)
  - Let image_aes_decrypt_to() be the single length-validation path
    (suggested by Simon Glass)
  - Document that AES CBC decrypt providers must support in-place decrypt
    (suggested by Simon Glass)

Changes v1 -> v2:
  - Explain FIT cipher validation  (suggested by Simon Glass)
  - Explain phase-keyed lib/aes builds  (suggested by Simon Glass)
  - Return -ENOSYS without decrypt support  (suggested by Simon Glass)
  - Use decrypt_to for U-Boot proper in-place decrypt
---
 boot/image-cipher.c         | 45 ++++++++++++++++++----
 boot/image-fit.c            | 33 ++++++++++++++--
 include/image.h             | 39 +++++++++++++++++--
 include/u-boot/aes.h        | 27 ++++++++++----
 lib/Makefile                |  2 +-
 lib/aes/aes-decrypt.c       | 91 +++++++++++++++++++++++++++++++++++++--------
 test/lib/Makefile           |  3 ++
 test/lib/test_aes_decrypt.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 290 insertions(+), 39 deletions(-)

diff --git a/boot/image-cipher.c b/boot/image-cipher.c
index 9d389f26cea..9470370a534 100644
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
@@ -165,11 +177,28 @@ int fit_image_decrypt_data(const void *fit,
 	ret = fit_image_setup_decrypt(&info, fit, image_noffset,
 				      cipher_noffset);
 	if (ret < 0)
-		goto out;
+		return ret;
+
+	return info.cipher->decrypt(&info, data_ciphered, size_ciphered,
+				    data_unciphered, size_unciphered);
+}
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
 
-	ret = info.cipher->decrypt(&info, data_ciphered, size_ciphered,
-				   data_unciphered, size_unciphered);
+	if (!info.cipher->decrypt_to)
+		return -ENOSYS;
 
- out:
-	return ret;
+	return info.cipher->decrypt_to(&info, data_ciphered, size_ciphered,
+				       data_unciphered, size_unciphered);
 }
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 9af38ed8d82..6b55316dd37 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1028,7 +1028,7 @@ int fit_image_get_data_size(const void *fit, int noffset, int *data_size)
  *
  * @fit: pointer to the FIT image header
  * @noffset: component image node offset
- * @data_size: holds the data-size property
+ * @data_size: holds the data-size-unciphered property
  *
  * returns:
  *     0, on success
@@ -1038,10 +1038,13 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
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
 
@@ -1562,15 +1565,37 @@ static int fit_image_uncipher(const void *fit, int image_noffset,
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
 
diff --git a/include/image.h b/include/image.h
index 4b3c9c87bf5..5a014def940 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1871,11 +1871,40 @@ int fit_image_check_sig(const void *fit, int noffset, const void *data,
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
@@ -1969,6 +1998,10 @@ struct cipher_algo {
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
index acbc50b9e6f..8fd43f02adc 100644
--- a/include/u-boot/aes.h
+++ b/include/u-boot/aes.h
@@ -16,15 +16,16 @@ int image_aes_encrypt(struct image_cipher_info *info,
 int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
 			      void *fit, int node_noffset);
 #else
-int image_aes_encrypt(struct image_cipher_info *info,
-		      const unsigned char *data, int size,
-		      unsigned char **cipher, int *cipher_len)
+static inline int image_aes_encrypt(struct image_cipher_info *info,
+				    const unsigned char *data, int size,
+				    unsigned char **cipher, int *cipher_len)
 {
 	return -ENXIO;
 }
 
-int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
-			      void *fit, int node_noffset)
+static inline int image_aes_add_cipher_data(struct image_cipher_info *info,
+					    void *keydest, void *fit,
+					    int node_noffset)
 {
 	return -ENXIO;
 }
@@ -34,10 +35,20 @@ int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
 int image_aes_decrypt(struct image_cipher_info *info,
 		      const void *cipher, size_t cipher_len,
 		      void **data, size_t *size);
+int image_aes_decrypt_to(struct image_cipher_info *info,
+			 const void *cipher, size_t cipher_len,
+			 void *data, size_t *size);
 #else
-int image_aes_decrypt(struct image_cipher_info *info,
-		      const void *cipher, size_t cipher_len,
-		      void **data, size_t *size)
+static inline int image_aes_decrypt(struct image_cipher_info *info,
+				    const void *cipher, size_t cipher_len,
+				    void **data, size_t *size)
+{
+	return -ENXIO;
+}
+
+static inline int image_aes_decrypt_to(struct image_cipher_info *info,
+				       const void *cipher, size_t cipher_len,
+				       void *data, size_t *size)
 {
 	return -ENXIO;
 }
diff --git a/lib/Makefile b/lib/Makefile
index 222378a8531..e8ec4660b38 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_ARCH_AT91) += at91/
 obj-$(CONFIG_OPTEE_LIB) += optee/
 
 obj-$(CONFIG_AES) += aes.o
-obj-$(CONFIG_AES) += aes/
 obj-$(CONFIG_$(PHASE_)BINMAN_FDT) += binman.o
 
 obj-$(CONFIG_FW_LOADER) += fw_loader.o
@@ -89,6 +88,7 @@ obj-$(CONFIG_$(PHASE_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
 obj-$(CONFIG_$(PHASE_)ZLIB) += zlib/
 obj-$(CONFIG_$(PHASE_)ZSTD) += zstd/
+obj-$(CONFIG_$(PHASE_)FIT_CIPHER) += aes/
 obj-$(CONFIG_$(PHASE_)GZIP) += gunzip.o
 obj-$(CONFIG_$(PHASE_)LZO) += lzo/
 obj-$(CONFIG_$(PHASE_)LZMA) += lzma/
diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
index 741102a4723..43a5f8742bb 100644
--- a/lib/aes/aes-decrypt.c
+++ b/lib/aes/aes-decrypt.c
@@ -4,37 +4,98 @@
  */
 
 #ifndef USE_HOSTCC
+#include <dm.h>
 #include <malloc.h>
 #endif
 #include <image.h>
 #include <uboot_aes.h>
 
+#ifndef USE_HOSTCC
+static int image_aes_validate(struct image_cipher_info *info,
+			      const void *cipher, size_t cipher_len,
+			      void *data, size_t *size)
+{
+	if (!info || !info->cipher || !info->key || !info->iv || !cipher ||
+	    !data || !size)
+		return -EINVAL;
+	if (info->cipher->iv_len != AES_BLOCK_LENGTH ||
+	    (info->cipher->key_len != AES128_KEY_LENGTH &&
+	     info->cipher->key_len != AES192_KEY_LENGTH &&
+	     info->cipher->key_len != AES256_KEY_LENGTH))
+		return -EINVAL;
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
+#ifdef USE_HOSTCC
+	return -ENOSYS;
+#else
+	unsigned int aes_blocks, key_len;
+	int ret;
+
+	ret = image_aes_validate(info, cipher, cipher_len, data, size);
+	if (ret)
+		return ret;
+	key_len = info->cipher->key_len;
+	aes_blocks = cipher_len / AES_BLOCK_LENGTH;
+
+	if (CONFIG_IS_ENABLED(DM_AES)) {
+		ret = dm_aes_cbc_decrypt_with_key(key_len * 8, (u8 *)info->key,
+						  (u8 *)info->iv, (u8 *)cipher,
+						  data, aes_blocks);
+		if (!ret) {
+			*size = info->size_unciphered;
+			return 0;
+		}
+		if (ret != -ENODEV && ret != -EOPNOTSUPP)
+			return ret;
+	}
+
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		unsigned char key_exp[AES256_EXPAND_KEY_LENGTH];
+
+		/* First we expand the key. */
+		aes_expand_key((u8 *)info->key, key_len, key_exp);
+
+		aes_cbc_decrypt_blocks(key_len, key_exp, (u8 *)info->iv,
+				       (u8 *)cipher, data, aes_blocks);
+		*size = info->size_unciphered;
+		return 0;
+	}
+
+	return -ENOSYS;
+#endif
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
 
 	*data = malloc(cipher_len);
 	if (!*data) {
 		printf("Can't allocate memory to decrypt\n");
 		return -ENOMEM;
 	}
-	*size = info->size_unciphered;
-
-	memcpy(&key_exp[0], info->key, key_len);
-
-	/* First we expand the key. */
-	aes_expand_key((u8 *)info->key, key_len, key_exp);
 
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
diff --git a/test/lib/Makefile b/test/lib/Makefile
index f25383a40e5..721d1470185 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -29,6 +29,9 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
 obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
 obj-$(CONFIG_UT_LIB_RSA) += rsa.o
 obj-$(CONFIG_AES) += test_aes.o
+ifeq ($(CONFIG_FIT_CIPHER)$(CONFIG_DM_AES),yy)
+obj-y += test_aes_decrypt.o
+endif
 obj-$(CONFIG_SHA256) += test_sha256_hmac.o
 obj-$(CONFIG_HKDF_MBEDTLS) += test_sha256_hkdf.o
 obj-$(CONFIG_GETOPT) += getopt.o
diff --git a/test/lib/test_aes_decrypt.c b/test/lib/test_aes_decrypt.c
new file mode 100644
index 00000000000..3b498e23e4b
--- /dev/null
+++ b/test/lib/test_aes_decrypt.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for target-side FIT AES decryption
+ *
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#include <image.h>
+#include <u-boot/aes.h>
+#include <uboot_aes.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int lib_test_image_aes_decrypt(struct unit_test_state *uts)
+{
+	u8 key[AES256_KEY_LENGTH] = { };
+	u8 key_exp[AES256_EXPAND_KEY_LENGTH];
+	u8 iv[AES_BLOCK_LENGTH] = { };
+	u8 plain[2 * AES_BLOCK_LENGTH];
+	u8 cipher[sizeof(plain)];
+	u8 output[sizeof(plain)];
+	struct cipher_algo algo = {
+		.name = "aes256",
+		.key_len = sizeof(key),
+		.iv_len = sizeof(iv),
+	};
+	struct image_cipher_info info = {
+		.cipher = &algo,
+		.key = key,
+		.iv = iv,
+		.size_unciphered = sizeof(plain),
+	};
+	size_t size;
+	int i, ret;
+
+	for (i = 0; i < sizeof(key); i++)
+		key[i] = i;
+	for (i = 0; i < sizeof(iv); i++)
+		iv[i] = 0x80 + i;
+	for (i = 0; i < sizeof(plain); i++)
+		plain[i] = 0x40 + i;
+
+	aes_expand_key(key, sizeof(key), key_exp);
+	aes_cbc_encrypt_blocks(sizeof(key), key_exp, iv, plain, cipher,
+			       ARRAY_SIZE(cipher) / AES_BLOCK_LENGTH);
+
+	size = 0;
+	ut_assertok(image_aes_decrypt_to(&info, cipher, sizeof(cipher), output,
+					 &size));
+	ut_asserteq(sizeof(plain), size);
+	ut_asserteq_mem(plain, output, sizeof(plain));
+
+	memcpy(output, cipher, sizeof(cipher));
+	size = 0;
+	ut_assertok(image_aes_decrypt_to(&info, output, sizeof(output), output,
+					 &size));
+	ut_asserteq(sizeof(plain), size);
+	ut_asserteq_mem(plain, output, sizeof(plain));
+
+	size = 0x55;
+	ret = image_aes_decrypt_to(&info, cipher, sizeof(cipher) - 1, output,
+				   &size);
+	ut_asserteq(-EINVAL, ret);
+	ut_asserteq(0x55, size);
+
+	info.size_unciphered = sizeof(cipher) + 1;
+	ret = image_aes_decrypt_to(&info, cipher, sizeof(cipher), output, &size);
+	ut_asserteq(-EINVAL, ret);
+	info.size_unciphered = sizeof(plain);
+
+	info.key = NULL;
+	ret = image_aes_decrypt_to(&info, cipher, sizeof(cipher), output, &size);
+	ut_asserteq(-EINVAL, ret);
+	info.key = key;
+	info.iv = NULL;
+	ret = image_aes_decrypt_to(&info, cipher, sizeof(cipher), output, &size);
+	ut_asserteq(-EINVAL, ret);
+	info.iv = iv;
+	info.cipher = NULL;
+	ret = image_aes_decrypt_to(&info, cipher, sizeof(cipher), output, &size);
+	ut_asserteq(-EINVAL, ret);
+	ret = image_aes_decrypt_to(NULL, cipher, sizeof(cipher), output, &size);
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+
+LIB_TEST(lib_test_image_aes_decrypt, 0);

-- 
2.53.0

