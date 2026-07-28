Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83621C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 380328108B;
	Wed, 29 Jul 2026 04:55:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TSgglkmk_HTU; Wed, 29 Jul 2026 04:55:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 107EE810CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300949;
	bh=t2MZfSbLF4u/OiBbDKrOMPL6L8HL50M3ulL8Ub9xWMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xIsUNXl5h2PmZygqrBgq5TOgDj/HGBaEyJ1PU0OJQt/BkXxq6xnaKGEk4FpkSEs/R
	 jd6Jf1zxMacLn9rJPM7d8H7oPPOiAyMMadbGAftSggPB1NpQp2BEJsgzh0PU68ocIz
	 JwFDQi01G0d08T8I/LTd4eN9ZEBzvcEeIxC1gwj/S8y0gDiRQ8GaFi0fKVs6L8nHoH
	 9siQz1K7OlA8VX0hcagQYYzivtUIWG1Zd9DSfTmgFeXsW+KgV7M8vU69WVH20Zudku
	 t71L1Gk4rCSV+qmNVwrbwq7dXanyuQC0/Qv+twKOBtsN22QeVqd3d3bG3Le/uUC0pr
	 vKSxnS555xSVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 107EE810CE;
	Wed, 29 Jul 2026 04:55:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B8FDC490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB43881421
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PuSUdSwLu3eY for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:44:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1FA10812B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FA10812B3
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FA10812B3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:14 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7ec3b429a3aso107805a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785260654; x=1785865454;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t2MZfSbLF4u/OiBbDKrOMPL6L8HL50M3ulL8Ub9xWMo=;
 b=m3QnyOkQOLZwmlwOGWaBMzx4DRE33d9B2PbS+QqULTH/sLqqhU8dPznp2KyAamsaVY
 R5gc92jLC7w45ev58hZ4ya70RmQNvdmbHLht3SSb3S36oIDsPRBtMzOtrVipH40DFVsK
 OAUkU8xIqnL9e8WhuLDQGiNLpJB1co0L0MIlr2jG2mgG50l0/8kA+HjQopUBnfRSDk0H
 lg7Wge+VwVhP/A4k2MxbtqJgNNB/ZQimwF1eD++l1b3Z2ADASRSELbcWMjICk/F6t87N
 eX2OHkNCKmSDWCiTLFYZoT1YNVXQv8QqS+XxR2N2/C5TygE8SdcEWVoF5/qQ19cf25kV
 2/9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS/hRatZHnPiv3NmWhfr8Xvo7ZZ3zpQxykf9wYo+juL3IIJ1LBQV+mvVvo989EdpZ5PgYI78U=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz0AdBZVwumws2nn8ZOC7zmaeefJVJPvWLkXdf9sjBVdEIwW6RB
 mU5+WoJcHesZihTh3uULAKrVwKkZ8pHY0Gb8XiobRpf4v3CX+uZNWLzU
X-Gm-Gg: AR+sD12rXgmLGyWGspjEcM4FeEQvFJRO2ufJcO2BYaInK2DqoNyfJXltns8cJiEHyIw
 hxLpE56Opqq2kJDNA+NiIY9P7iLtDUfBPOwNaf1tYQ9hHyU3CXhxGNGCJ3/4u1wghy4zUX9Ghi0
 FC/poIVelxJ2Pa5bkWpJtrTmuxnwTB2FMglateUMd4KEtq4Boypr55kwCRc28dFeLKuhUx4d8UW
 nctvpPTpMC2Pf2uGxmFp28u4m87fPHiGCldLq2JQ6FudwSsMcHF10McWhEjGTEd8zC8xrn+Gcso
 jk95i741gGy7+BBJysFpvErNczpQOYis7JQzZViEz8ngDU8Rs0JNxjX9t/iKb9VI3cDJ7PjMa2w
 1kwHhcmlm3VnTZuXpsIHOArCzGCulY2H2tvaBHWM7yG/fyRQbFHQKaoR6p/qgwbJ/hsUKezNuNL
 9qF8w98rA71PUFnw8VIX4bywmvUHhSRVZG1RQGYdeOGmd6KZy0d4pJ4vg4/DvyRJ515FQJhYJc8
 AgtEYfY5m12K3buoXz3iIPXeRt++eUtqWnhTuE9anjyH6Ud/s9YWclN
X-Received: by 2002:a05:6830:8389:b0:7e9:b537:1032 with SMTP id
 46e09a7af769-7efff2ea4d4mr1722010a34.31.1785260653761; 
 Tue, 28 Jul 2026 10:44:13 -0700 (PDT)
Received: from [127.0.1.1] (71-218-31-69.hlrn.qwest.net. [71.218.31.69])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d94389dsm271103a34.21.2026.07.28.10.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:44:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 28 Jul 2026 11:41:53 -0600
Subject: [PATCH v6 10/13] lib: ecdsa: support additional curve sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-submit-ce-series-v2-v6-10-80c1f7daffa5@gmail.com>
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
 d=gmail.com; s=20251104; t=1785260654; x=1785865454;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t2MZfSbLF4u/OiBbDKrOMPL6L8HL50M3ulL8Ub9xWMo=;
 b=PAzPmkG18LdgFB1vbtuvt24ATX7WUoX1xBmeIkEEghxhlPbnpt2mYGy7xpfAlMc8oS
 Vst07uX/coQ6X1zuRBXFjPI6sXvuG1tyZ04fR/BxsYZbolqZKSC4aXqiBmTSunLb4aRR
 ZjGccfgXKO9C53hGK7KoWCzjZciJJg1CxkccW0f4L9hOQvrrlUdlJrILZdZ8N+RwJiL8
 7R4i+BkorSSiYVV7QVbhQH3pmS1kKrM+aP8HoJe2VYLbhrFUzifO89sY5eTd6nzceg3w
 Ti61HDIGkGi0ZTR5P3vpKSZqBhilWXqJKvPTmXMYw06kf5M/KCMeGOM+QGMBKghY1sGw
 6ZUA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PAzPmkG1
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

U-Boot's ECDSA FIT code is tied closely to prime256v1 and secp384r1.
Hardware verifiers may support a wider set of curves, and FIT public key
properties need to preserve the fixed coordinate width of those curves.

Add common curve-size handling for secp224r1, prime256v1, secp384r1 and
secp521r1. Use fixed-width big-endian byte arrays when writing libcrypto
BIGNUM values into the control FDT so non-32-bit-aligned coordinates such
as secp521r1 are encoded correctly. RSA key sizes are already multiples
of 32 bits, so their generated byte encoding is unchanged.

Register the corresponding host and target ECDSA algorithm names and
clean up the libcrypto signing context so raw signatures are owned and
freed consistently on error paths. Exercise all four curves in the host
FIT signing test.

SPL ECDSA verification uses UCLASS_ECDSA, so make SPL_ECDSA_VERIFY
depend on SPL_DM. Keep fdt_add_bignum() in the libfdt error namespace so
RSA and ECDSA callers continue to handle FDT growth and other errors
consistently.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - Exercise secp224r1, prime256v1, secp384r1 and secp521r1 signing

Changes v1 -> v2:
  - Explain the RSA impact of fdt_add_bignum()  (suggested by Simon Glass)
  - Document ECDSA public key byte-array widths  (suggested by Simon Glass)
  - Document ecdsa_curve_size()  (suggested by Simon Glass)
  - Keep fdt_add_bignum() errors in libfdt space
    (suggested by Simon Glass)
  - Explain the SPL_DM dependency  (suggested by Simon Glass)
---
 doc/mkimage.1                   |   3 +
 doc/usage/fit/signature.rst     |   9 ++-
 include/u-boot/ecdsa.h          |  22 +++++++
 include/u-boot/fdt-libcrypto.h  |   6 +-
 lib/ecdsa/Kconfig               |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c     | 141 +++++++++++++++++++++++++---------------
 lib/ecdsa/ecdsa-verify.c        |  39 +++++------
 lib/fdt-libcrypto.c             |  60 ++++-------------
 test/py/tests/test_fit_ecdsa.py |  18 +++--
 tools/image-sig-host.c          |   7 ++
 10 files changed, 174 insertions(+), 133 deletions(-)

diff --git a/doc/mkimage.1 b/doc/mkimage.1
index 9a2d07cee75..b6ba88dd314 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -459,7 +459,10 @@ lb.
 rsa2048
 rsa3072
 rsa4096
+ecdsa224
 ecdsa256
+ecdsa384
+secp521r1
 .TE
 .RE
 .
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index da08cc75c3a..a6aacd691d3 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -132,13 +132,16 @@ rsa,n0-inverse
 For ECDSA the following are mandatory:
 
 ecdsa,curve
-    Name of ECDSA curve (e.g. "prime256v1")
+    Name of ECDSA curve, such as "secp224r1", "prime256v1",
+    "secp384r1", or "secp521r1"
 
 ecdsa,x-point
-    Public key X coordinate as a big-endian multi-word integer
+    Public key X coordinate as a fixed-width big-endian byte array. The width
+    is the curve size rounded up to whole bytes.
 
 ecdsa,y-point
-    Public key Y coordinate as a big-endian multi-word integer
+    Public key Y coordinate as a fixed-width big-endian byte array. The width
+    is the curve size rounded up to whole bytes.
 
 These parameters can be added to a binary device tree using parameter -K of the
 mkimage command::
diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
index f0ac0f327e9..3d70b138026 100644
--- a/include/u-boot/ecdsa.h
+++ b/include/u-boot/ecdsa.h
@@ -8,6 +8,7 @@
 
 #include <errno.h>
 #include <image.h>
+#include <string.h>
 
 /**
  * crypto_algo API impementation for ECDSA;
@@ -64,8 +65,29 @@ int ecdsa_verify(struct image_sign_info *info,
 		 uint8_t *sig, uint sig_len);
 /** @} */
 
+#define ECDSA224_BYTES	(224 / 8)
 #define ECDSA256_BYTES	(256 / 8)
 #define ECDSA384_BYTES	(384 / 8)
 #define ECDSA521_BYTES	((521 + 7) / 8)
 
+/**
+ * ecdsa_curve_size() - Get the size in bits for a named ECDSA curve
+ *
+ * @curve_name: OpenSSL short name for the curve
+ * Return: curve size in bits, or 0 if @curve_name is not supported
+ */
+static inline unsigned int ecdsa_curve_size(const char *curve_name)
+{
+	if (!strcmp(curve_name, "secp224r1"))
+		return 224;
+	else if (!strcmp(curve_name, "prime256v1"))
+		return 256;
+	else if (!strcmp(curve_name, "secp384r1"))
+		return 384;
+	else if (!strcmp(curve_name, "secp521r1"))
+		return 521;
+
+	return 0;
+}
+
 #endif
diff --git a/include/u-boot/fdt-libcrypto.h b/include/u-boot/fdt-libcrypto.h
index b15d8a1eaf4..3164f2891aa 100644
--- a/include/u-boot/fdt-libcrypto.h
+++ b/include/u-boot/fdt-libcrypto.h
@@ -12,16 +12,16 @@
 /**
  * fdt_add_bignum() - Write a libcrypto BIGNUM as an FDT property
  *
- * Convert a libcrypto BIGNUM * into a big endian array of integers.
+ * Convert a libcrypto BIGNUM * into a fixed-width big endian byte array.
  *
  * @blob:	FDT blob to modify
  * @noffset:	Offset of the FDT node
  * @prop_name:	What to call the property in the FDT
  * @num:	pointer to a libcrypto big number
  * @num_bits:	How big is 'num' in bits?
- * Return: 0 if all good all working, -ve on horror
+ * Return: 0 on success, negative libfdt error on failure
  */
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
-		   BIGNUM *num, int num_bits);
+		   const BIGNUM *num, int num_bits);
 
 #endif /* _FDT_LIBCRYPTO_H */
diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
index ca13b6bfa1f..f0c56278fb6 100644
--- a/lib/ecdsa/Kconfig
+++ b/lib/ecdsa/Kconfig
@@ -17,7 +17,7 @@ config ECDSA_VERIFY
 
 config SPL_ECDSA_VERIFY
 	bool "Enable ECDSA verification support in SPL"
-	depends on SPL
+	depends on SPL && SPL_DM
 	help
 	  Allow ECDSA signatures to be recognized and verified in SPL.
 
diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..378d53ea242 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -31,7 +31,7 @@ struct signer {
 	EVP_PKEY *evp_key;	/* Pointer to EVP_PKEY object */
 	EC_KEY *ecdsa_key;	/* Pointer to EC_KEY object */
 	void *hash;		/* Pointer to hash used for verification */
-	void *signature;	/* Pointer to output signature. Do not free()!*/
+	void *signature;	/* Pointer to raw signature buffer */
 };
 
 struct ecdsa_public_key {
@@ -50,11 +50,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->curve_name)
 		return -ENOMSG;
 
-	if (!strcmp(key->curve_name, "prime256v1"))
-		key->size_bits = 256;
-	else if (!strcmp(key->curve_name, "secp384r1"))
-		key->size_bits = 384;
-	else
+	key->size_bits = ecdsa_curve_size(key->curve_name);
+	if (!key->size_bits)
 		return -EINVAL;
 
 	key->x = fdt_getprop(fdt, node, "ecdsa,x-point", &x_len);
@@ -63,7 +60,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != key->size_bits / 8 || y_len != key->size_bits / 8)
+	if (x_len != (key->size_bits + 7) / 8 ||
+	    y_len != (key->size_bits + 7) / 8)
 		return -EINVAL;
 
 	return 0;
@@ -85,18 +83,12 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return ret;
 	}
 
-	if (!strcmp(pubkey.curve_name, "prime256v1")) {
-		nid = NID_X9_62_prime256v1;
-	} else if (!strcmp(pubkey.curve_name, "secp384r1")) {
-		nid = NID_secp384r1;
-	} else {
+	nid = OBJ_sn2nid(pubkey.curve_name);
+	if (nid == NID_undef) {
 		fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.curve_name);
 		return -EINVAL;
 	}
 
-	fprintf(stderr, "Loading ECDSA key: curve=%s, bits=%d\n", pubkey.curve_name,
-		pubkey.size_bits);
-
 	ec_key = EC_KEY_new_by_curve_name(nid);
 	if (!ec_key) {
 		fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n", pubkey.curve_name);
@@ -111,7 +103,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return -ENOMEM;
 	}
 
-	len = pubkey.size_bits / 8;
+	len = (pubkey.size_bits + 7) / 8;
 
 	uint8_t buf[1 + len * 2];
 
@@ -133,14 +125,13 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return -EINVAL;
 	}
 
-	fprintf(stderr, "Successfully loaded ECDSA key from FDT node %d\n", node);
 	EC_POINT_free(point);
 	ctx->ecdsa_key = ec_key;
 
 	return 0;
 }
 
-static int alloc_ctx(struct signer *ctx, const struct image_sign_info *info)
+static int init_ctx(struct signer *ctx)
 {
 	memset(ctx, 0, sizeof(*ctx));
 
@@ -149,11 +140,21 @@ static int alloc_ctx(struct signer *ctx, const struct image_sign_info *info)
 		return -1;
 	}
 
+	return 0;
+}
+
+static int alloc_sig_ctx(struct signer *ctx, const struct image_sign_info *info)
+{
 	ctx->hash = malloc(info->checksum->checksum_len);
 	ctx->signature = malloc(info->crypto->key_len * 2);
 
-	if (!ctx->hash || !ctx->signature)
+	if (!ctx->hash || !ctx->signature) {
+		free(ctx->hash);
+		free(ctx->signature);
+		ctx->hash = NULL;
+		ctx->signature = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -166,8 +167,8 @@ static void free_ctx(struct signer *ctx)
 	if (ctx->evp_key)
 		EVP_PKEY_free(ctx->evp_key);
 
-	if (ctx->hash)
-		free(ctx->hash);
+	free(ctx->hash);
+	free(ctx->signature);
 }
 
 /*
@@ -203,7 +204,12 @@ static ECDSA_SIG *ecdsa_sig_from_raw(void *buf, size_t order)
 	s_buf = (uintptr_t)buf + point_bytes;
 	r = BN_bin2bn(buf, point_bytes, NULL);
 	s = BN_bin2bn((void *)s_buf, point_bytes, NULL);
-	ECDSA_SIG_set0(sig, r, s);
+	if (!r || !s || !ECDSA_SIG_set0(sig, r, s)) {
+		BN_free(r);
+		BN_free(s);
+		ECDSA_SIG_free(sig);
+		return NULL;
+	}
 
 	return sig;
 }
@@ -271,10 +277,6 @@ static int load_key_from_fdt(struct signer *ctx, const struct image_sign_info *i
 	if (!fdt)
 		return -EINVAL;
 
-	ret = alloc_ctx(ctx, info);
-	if (ret)
-		return ret;
-
 	sig_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (sig_node < 0) {
 		fprintf(stderr, "No /signature node found\n");
@@ -331,7 +333,9 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 	int key_len_bytes, ret;
 	char kname[1024];
 
-	memset(ctx, 0, sizeof(*ctx));
+	ret = init_ctx(ctx);
+	if (ret)
+		return ret;
 
 	if (info->fdt_blob) {
 		return load_key_from_fdt(ctx, info);
@@ -345,10 +349,6 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 		return -EINVAL;
 	}
 
-	ret = alloc_ctx(ctx, info);
-	if (ret)
-		return ret;
-
 	ret = read_key(ctx, kname);
 	if (ret)
 		return ret;
@@ -368,11 +368,18 @@ static int do_sign(struct signer *ctx, struct image_sign_info *info,
 {
 	const struct checksum_algo *algo = info->checksum;
 	ECDSA_SIG *sig;
+	int ret;
+
+	ret = algo->calculate(algo->name, region, region_count, ctx->hash);
+	if (ret)
+		return ret;
 
-	algo->calculate(algo->name, region, region_count, ctx->hash);
 	sig = ECDSA_do_sign(ctx->hash, algo->checksum_len, ctx->ecdsa_key);
+	if (!sig)
+		return -EIO;
 
 	ecdsa_sig_encode_raw(ctx->signature, sig, info->crypto->key_len);
+	ECDSA_SIG_free(sig);
 
 	return 0;
 }
@@ -389,10 +396,16 @@ static int ecdsa_check_signature(struct signer *ctx, struct image_sign_info *inf
 	okay = ECDSA_do_verify(ctx->hash, info->checksum->checksum_len,
 			       sig, ctx->ecdsa_key);
 	if (!okay)
-		fprintf(stderr, "WARNING: Signature is fake news!\n");
+		fprintf(stderr, "WARNING: ECDSA signature verification failed\n");
+	else if (okay < 0)
+		fprintf(stderr, "ERROR: ECDSA signature verification failed\n");
 
 	ECDSA_SIG_free(sig);
-	return !okay;
+
+	if (okay == 1)
+		return 0;
+
+	return okay < 0 ? -EIO : -EPERM;
 }
 
 static int do_verify(struct signer *ctx, struct image_sign_info *info,
@@ -400,6 +413,7 @@ static int do_verify(struct signer *ctx, struct image_sign_info *info,
 		     uint8_t *raw_sig, uint sig_len)
 {
 	const struct checksum_algo *algo = info->checksum;
+	int ret;
 
 	if (sig_len != info->crypto->key_len * 2) {
 		fprintf(stderr, "Signature has wrong length\n");
@@ -407,7 +421,9 @@ static int do_verify(struct signer *ctx, struct image_sign_info *info,
 	}
 
 	memcpy(ctx->signature, raw_sig, sig_len);
-	algo->calculate(algo->name, region, region_count, ctx->hash);
+	ret = algo->calculate(algo->name, region, region_count, ctx->hash);
+	if (ret)
+		return ret;
 
 	return ecdsa_check_signature(ctx, info);
 }
@@ -420,11 +436,16 @@ int ecdsa_sign(struct image_sign_info *info, const struct image_region region[],
 
 	ret = prepare_ctx(&ctx, info);
 	if (ret >= 0) {
-		do_sign(&ctx, info, region, region_count);
-		*sigp = ctx.signature;
-		*sig_len = info->crypto->key_len * 2;
-
-		ret = ecdsa_check_signature(&ctx, info);
+		ret = alloc_sig_ctx(&ctx, info);
+		if (!ret)
+			ret = do_sign(&ctx, info, region, region_count);
+		if (!ret)
+			ret = ecdsa_check_signature(&ctx, info);
+		if (!ret) {
+			*sigp = ctx.signature;
+			*sig_len = info->crypto->key_len * 2;
+			ctx.signature = NULL;
+		}
 	}
 
 	free_ctx(&ctx);
@@ -439,8 +460,12 @@ int ecdsa_verify(struct image_sign_info *info,
 	int ret;
 
 	ret = prepare_ctx(&ctx, info);
-	if (ret >= 0)
-		ret = do_verify(&ctx, info, region, region_count, sig, sig_len);
+	if (ret >= 0) {
+		ret = alloc_sig_ctx(&ctx, info);
+		if (!ret)
+			ret = do_verify(&ctx, info, region, region_count,
+					sig, sig_len);
+	}
 
 	free_ctx(&ctx);
 	return ret;
@@ -453,7 +478,7 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 	const char *curve_name;
 	const EC_GROUP *group;
 	const EC_POINT *point;
-	BIGNUM *x, *y;
+	BIGNUM *x = NULL, *y = NULL;
 
 	signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (signature_node == -FDT_ERR_NOTFOUND) {
@@ -491,42 +516,54 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 	group = EC_KEY_get0_group(ctx->ecdsa_key);
 	key_bits = EC_GROUP_order_bits(group);
 	curve_name = OBJ_nid2sn(EC_GROUP_get_curve_name(group));
-	/* Let 'x' and 'y' memory leak by not BN_free()'ing them. */
 	x = BN_new();
 	y = BN_new();
+	if (!x || !y) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	point = EC_KEY_get0_public_key(ctx->ecdsa_key);
-	EC_POINT_get_affine_coordinates(group, point, x, y, NULL);
+	if (!EC_POINT_get_affine_coordinates(group, point, x, y, NULL)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fdt_setprop_string(fdt, key_node, FIT_KEY_HINT,
 				 info->keyname);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_setprop_string(fdt, key_node, "ecdsa,curve", curve_name);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_add_bignum(fdt, key_node, "ecdsa,x-point", x, key_bits);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_add_bignum(fdt, key_node, "ecdsa,y-point", y, key_bits);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_setprop_string(fdt, key_node, FIT_ALGO_PROP,
 				 info->name);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	if (info->require_keys) {
 		ret = fdt_setprop_string(fdt, key_node, FIT_KEY_REQUIRED,
 					 info->require_keys);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
-	return key_node;
+	ret = key_node;
+
+out:
+	BN_free(x);
+	BN_free(y);
+	return ret;
 }
 
 int ecdsa_add_verify_data(struct image_sign_info *info, void *fdt)
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 629b662cf6c..8570d35028f 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -12,22 +12,6 @@
 #include <dm/uclass.h>
 #include <u-boot/ecdsa.h>
 
-/*
- * Derive size of an ECDSA key from the curve name
- *
- * While it's possible to extract the key size by using string manipulation,
- * use a list of known curves for the time being.
- */
-static int ecdsa_key_size(const char *curve_name)
-{
-	if (!strcmp(curve_name, "prime256v1"))
-		return 256;
-	else if (!strcmp(curve_name, "secp384r1"))
-		return 384;
-
-	return 0;
-}
-
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
 	int x_len, y_len;
@@ -38,9 +22,9 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 		return -ENOMSG;
 	}
 
-	key->size_bits = ecdsa_key_size(key->curve_name);
+	key->size_bits = ecdsa_curve_size(key->curve_name);
 	if (key->size_bits == 0) {
-		debug("Unknown ECDSA curve '%s'", key->curve_name);
+		debug("Unknown ECDSA curve '%s'\n", key->curve_name);
 		return -EINVAL;
 	}
 
@@ -50,9 +34,10 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != (key->size_bits / 8) || y_len != (key->size_bits / 8)) {
-		printf("%s: node=%d, curve@%p x@%p+%i y@%p+%i\n", __func__,
-		       node, key->curve_name, key->x, x_len, key->y, y_len);
+	if (x_len != (key->size_bits + 7) / 8 ||
+	    y_len != (key->size_bits + 7) / 8) {
+		debug("%s: node=%d, curve@%p x@%p+%i y@%p+%i\n", __func__,
+		      node, key->curve_name, key->x, x_len, key->y, y_len);
 		return -EINVAL;
 	}
 
@@ -123,6 +108,12 @@ int ecdsa_verify(struct image_sign_info *info,
 	return ecdsa_verify_hash(dev, info, hash, sig, sig_len);
 }
 
+U_BOOT_CRYPTO_ALGO(ecdsa224) = {
+	.name = "ecdsa224",
+	.key_len = ECDSA224_BYTES,
+	.verify = ecdsa_verify,
+};
+
 U_BOOT_CRYPTO_ALGO(ecdsa256) = {
 	.name = "ecdsa256",
 	.key_len = ECDSA256_BYTES,
@@ -135,6 +126,12 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
 	.verify = ecdsa_verify,
 };
 
+U_BOOT_CRYPTO_ALGO(secp521r1) = {
+	.name = "secp521r1",
+	.key_len = ECDSA521_BYTES,
+	.verify = ecdsa_verify,
+};
+
 /*
  * uclass definition for ECDSA API
  *
diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
index ecb0344c8f6..8c5a7282ce9 100644
--- a/lib/fdt-libcrypto.c
+++ b/lib/fdt-libcrypto.c
@@ -5,68 +5,34 @@
  */
 
 #include <libfdt.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <u-boot/fdt-libcrypto.h>
 
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
-		   BIGNUM *num, int num_bits)
+		   const BIGNUM *num, int num_bits)
 {
-	int nwords = num_bits / 32;
-	int size;
-	uint32_t *buf, *ptr;
-	BIGNUM *tmp, *big2, *big32, *big2_32;
-	BN_CTX *ctx;
+	int size = (num_bits + 7) / 8;
+	unsigned char *buf;
 	int ret;
 
-	tmp = BN_new();
-	big2 = BN_new();
-	big32 = BN_new();
-	big2_32 = BN_new();
+	if (size <= 0)
+		return -FDT_ERR_BADVALUE;
 
-	/*
-	 * Note: This code assumes that all of the above succeed, or all fail.
-	 * In practice memory allocations generally do not fail (unless the
-	 * process is killed), so it does not seem worth handling each of these
-	 * as a separate case. Technicaly this could leak memory on failure,
-	 * but a) it won't happen in practice, and b) it doesn't matter as we
-	 * will immediately exit with a failure code.
-	 */
-	if (!tmp || !big2 || !big32 || !big2_32) {
-		fprintf(stderr, "Out of memory (bignum)\n");
-		return -ENOMEM;
-	}
-	ctx = BN_CTX_new();
-	if (!ctx) {
-		fprintf(stderr, "Out of memory (bignum context)\n");
-		return -ENOMEM;
-	}
-	BN_set_word(big2, 2L);
-	BN_set_word(big32, 32L);
-	BN_exp(big2_32, big2, big32, ctx); /* B = 2^32 */
-
-	size = nwords * sizeof(uint32_t);
 	buf = malloc(size);
 	if (!buf) {
 		fprintf(stderr, "Out of memory (%d bytes)\n", size);
-		return -ENOMEM;
+		return -FDT_ERR_NOSPACE;
 	}
 
-	/* Write out modulus as big endian array of integers */
-	for (ptr = buf + nwords - 1; ptr >= buf; ptr--) {
-		BN_mod(tmp, num, big2_32, ctx); /* n = N mod B */
-		*ptr = cpu_to_fdt32(BN_get_word(tmp));
-		BN_rshift(num, num, 32); /*  N = N/B */
+	if (BN_bn2binpad(num, buf, size) != size) {
+		free(buf);
+		return -FDT_ERR_BADVALUE;
 	}
 
-	/*
-	 * We try signing with successively increasing size values, so this
-	 * might fail several times
-	 */
+	/* Callers may retry with a larger FDT if the property does not fit. */
 	ret = fdt_setprop(blob, noffset, prop_name, buf, size);
 	free(buf);
-	BN_free(tmp);
-	BN_free(big2);
-	BN_free(big32);
-	BN_free(big2_32);
 
-	return ret ? -FDT_ERR_NOSPACE : 0;
+	return ret;
 }
diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecdsa.py
index 3e816d68eb6..ae26169b9bd 100644
--- a/test/py/tests/test_fit_ecdsa.py
+++ b/test/py/tests/test_fit_ecdsa.py
@@ -50,9 +50,9 @@ class SignableFitImage(object):
 
         return self.signable_nodes
 
-    def change_signature_algo_to_ecdsa(self):
+    def change_signature_algo_to_ecdsa(self, algo):
         for image in self.signable_nodes:
-            self.__fdt_set(f'{image}/signature', algo='sha256,ecdsa256')
+            self.__fdt_set(f'{image}/signature', algo=f'sha256,{algo}')
 
     def sign(self, mkimage, key_file):
         utils.run_and_log(self.ubman, [mkimage, '-F', self.fit, f'-G{key_file}'])
@@ -71,10 +71,16 @@ class SignableFitImage(object):
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('fdtget')
 @pytest.mark.requiredtool('fdtput')
-def test_fit_ecdsa(ubman):
+@pytest.mark.parametrize('curve, algo', (
+    ('secp224r1', 'ecdsa224'),
+    ('prime256v1', 'ecdsa256'),
+    ('secp384r1', 'ecdsa384'),
+    ('secp521r1', 'secp521r1'),
+))
+def test_fit_ecdsa(ubman, curve, algo):
     """ Test that signatures generated by mkimage are legible. """
     def generate_ecdsa_key():
-        return ECC.generate(curve='prime256v1')
+        return ECC.generate(curve=curve)
 
     def assemble_fit_image(dest_fit, its, destdir):
         dtc_args = f'-I dts -O dtb -i {destdir}'
@@ -86,7 +92,7 @@ def test_fit_ecdsa(ubman):
 
     mkimage = ubman.config.build_dir + '/tools/mkimage'
     datadir = ubman.config.source_dir + '/test/py/tests/vboot/'
-    tempdir = os.path.join(ubman.config.result_dir, 'ecdsa')
+    tempdir = os.path.join(ubman.config.result_dir, f'ecdsa-{curve}')
     os.makedirs(tempdir, exist_ok=True)
     key_file = f'{tempdir}/ecdsa-test-key.pem'
     fit_file = f'{tempdir}/test.fit'
@@ -109,6 +115,6 @@ def test_fit_ecdsa(ubman):
     if len(nodes) == 0:
         raise ValueError('FIT image has no "/image" nodes with "signature"')
 
-    fit.change_signature_algo_to_ecdsa()
+    fit.change_signature_algo_to_ecdsa(algo)
     fit.sign(mkimage, key_file)
     fit.check_signatures(key)
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index 5285263c616..aeca83bd440 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -69,6 +69,13 @@ struct crypto_algo crypto_algos[] = {
 		.add_verify_data = rsa_add_verify_data,
 		.verify = rsa_verify,
 	},
+	{
+		.name = "ecdsa224",
+		.key_len = ECDSA224_BYTES,
+		.sign = ecdsa_sign,
+		.add_verify_data = ecdsa_add_verify_data,
+		.verify = ecdsa_verify,
+	},
 	{
 		.name = "ecdsa256",
 		.key_len = ECDSA256_BYTES,

-- 
2.53.0

