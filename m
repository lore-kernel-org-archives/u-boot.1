Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A227C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DEF840709;
	Sat, 15 Aug 2026 13:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zM5sVKySI5T9; Sat, 15 Aug 2026 13:01:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08CED405B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786798890;
	bh=0k3BP7El9pEIfpX9VgsqtKwKaAveIqwyKMcTvTNVG08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PsAvBlbJQuoYKbnKJl8sXClSatGb73iCvOu1zCARTZ8RO3Cy4TDz6uMkOXw1U0nEi
	 mW3qODawTDB/jD90oxcBeobcaaKibCvbQAANwkxyG4SsmIhSYVpSJcGz6Wm5TOcOKT
	 YKiEVlCoe+NpRmIM4JHT3RD9G2Bl00RS4owlWt704p2sz/2WiN9hoMGVxBO5AI1YQW
	 gnviLWZc52MHBhjasVQaJFPBrUpUIeGnOZhkPHU7il81Mf0jDip1OwWecgjO7SC5CH
	 sdYZPWZXGmXvHHd6FudSoz0APq9OcX9MdfIVlxCf5KrU6nnwyUYB4uAQA8rLFnzvei
	 eX0TCGaZI6vVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08CED405B1;
	Sat, 15 Aug 2026 13:01:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 02E2B194
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD5D34005A
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ARiiSkpNG5x for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 05:48:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DF5C440026
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF5C440026
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Fn0b3aKn
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF5C440026
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:50 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6ae88f4e4f4so925815eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786772930; x=1787377730;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0k3BP7El9pEIfpX9VgsqtKwKaAveIqwyKMcTvTNVG08=;
 b=Fn0b3aKnWo4DgYk5IihtPvJLO5mpHHgl/t5y/a4NBb1cExYUx1A9cu2Jm4dgtobi2o
 Oy2OjPPnpwWRQm8wAfjrYU8T/hSzEkv6le5GczBsvorDAx4ri6WVN7Cuy56BekyiFtr/
 7U01yChrnbI8z6Mupw2rVddNm5j2Obv8xG/MHEHEAlml5szfLfzH+zzX5wDRZKEW7moR
 /ELLUvD/PCfIlGVxd4PTTPPafgsMO5xY4SOAr9Ke1os8nfYPr2GBRPyg21sf7rJLwifC
 H0TVR9u5o4JmjvKzg52BE8IjWO3oz1LT+YzeVa+uh8QNToUBWR2ceQqbIbx6+IN2yfyB
 EyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786772930; x=1787377730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0k3BP7El9pEIfpX9VgsqtKwKaAveIqwyKMcTvTNVG08=;
 b=UoroD81JHNZzRpN2H0xNXdu6LY2Us8ybgFobEucxiNNlmGYrasCI6V3JwWA/nwIKc6
 7CgB7hlF+wq8i7mo6ar5RIUgyRqv9/+qeieO6oJOLlSILVaWfMZLg9SHL3m4/uAfn1gt
 J0Hm9S7bZp3Gkan4L/0LURt2lwD+jGF0yMA2YagSyXDjbPMvBo+YK+CsotN1e6sqNtba
 Yqk/Q99PR00UhSWaOoDbG5ZTSp1RTYplK/xCnr1nRd72siUKsVPAzp9QD9W0yFYPfrvZ
 99zbVG9/lSZQcn0GEkKG3WT+lPO9iU8sq5SHLPfx0wsiEV7BI2A7N6TglUJw+9jA1L0l
 Cu5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkDbD41Q7tXHaiYzh2qLrgngI3/fcpWBSaGpUDrxAGs4R9I5EQr4lIYyeqEmGaaijd8A07PeU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzp9ps8dfdc5fGKaM0BF8IwWabxOSYL+Z47rsV7gmiaLs84C+Ok
 BUOqLraSnDMfZVJiVne/OlTNZFv8InjnrluegaNJo2i68H2aAnLsDhON
X-Gm-Gg: AR+sD13oGFHZcwTOnMlqSDKVxL8KGiE7v1wIl/e8l1AQ15WqEVwXTrgZBJkUHkI+y9S
 piZ0Rq9KTVXBuT4pLP1i5WObWEAQlEyNKYfYQH+eWOnE5CJvcbnfgZ6mE1Zyt7OaFYw11Dh2dpY
 j9YV+a4nmUDsPAlUxHbCRZIL5ivpodGtOdpQZjjB0WadzAsP450gnZMk9vcXf33KswCSntrsPte
 5UH6o6S+LKKATB/Lzy5n2T1YY08AIEO07kO0XONYPT4vfRpRE0nw2zZDAEhQrWatndMnd/cYbR8
 vIBuh3gR1/f4bUuEJK1GOfIGOuW6HyfNrWUQ3NUaXGB8p8KqfDq2qc8o5uu8q7otDrU9QOgZ+J3
 7bmbkVQFmGBexBOi7novJ8Y66kQR00Kil12OWIundvKEYW7eDfrTqS+0kPGmM1Jqo5TZcFOkQ7o
 fQdOv3mE2aNj6UpBXOCSPiAi+YSCHtK7UXNPMLoaPhV/uf1vCiIUB4LUiH3dsDZMu8Mr/SXdbWh
 0idy9h8Z4A8gSaJG8ABCMz0/os4FP7FQ+aMeXT46hBR935pa9R+R5JT2TaZ2WxFxL8f7rK3h0QR
 W1bjw+e+6YiDKZ0+BerVkik1pi20ieo+hqMJTlR1FA86kgnQpdLIs3OWtx7UBkoXTVV4eNPNM3Z
 p5YKYsnAiDl+o5NReF/F5Gg==
X-Received: by 2002:a4a:e911:0:b0:6a3:94bc:bdb9 with SMTP id
 006d021491bc7-6b0d6885394mr9541574eaf.25.1786772929519; 
 Fri, 14 Aug 2026 22:48:49 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282a6sm2780166a34.18.2026.08.14.22.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:48:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 23:48:12 -0600
Subject: [PATCH v8 05/15] lib: rsa: internalize PKCS#1 DigestInfo prefixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-ce-series-v2-v8-5-fe9212431a94@gmail.com>
References: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
In-Reply-To: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
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
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 15 Aug 2026 13:01:17 +0000
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

The checksum algorithm table is shared by RSA and ECDSA, but its DER
prefix fields are used only by RSA PKCS#1 v1.5 padding verification.
Keeping those prefixes in the software hash implementations also ties
signature metadata to a particular hash backend and duplicates it between
the legacy and MbedTLS shims.

Keep the SHA-1, SHA-256, SHA-384 and SHA-512 DigestInfo prefixes in the RSA
verifier instead. Select the prefix by checksum name when checking PKCS#1
v1.5 padding, include every algorithm in host tools and only configured
algorithms in target builds, and reject padding which is too short for the
required eight-byte padding string.

Remove the DER fields from the generic checksum descriptor and remove the
now-unneeded constants from the hash implementations. ECDSA-only and
hardware-hash-only builds then carry no RSA-specific DigestInfo data.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - New patch
---
 boot/image-sig.c        |  8 ------
 include/image.h         |  2 --
 include/u-boot/sha1.h   |  3 ---
 include/u-boot/sha256.h |  3 ---
 include/u-boot/sha512.h |  6 -----
 lib/mbedtls/sha1.c      |  5 ----
 lib/mbedtls/sha256.c    |  6 -----
 lib/mbedtls/sha512.c    | 12 ---------
 lib/rsa/rsa-verify.c    | 67 ++++++++++++++++++++++++++++++++++++++++++++++---
 lib/sha1.c              |  5 ----
 lib/sha256.c            |  6 -----
 lib/sha512.c            | 12 ---------
 tools/image-sig-host.c  |  8 ------
 13 files changed, 63 insertions(+), 80 deletions(-)

diff --git a/boot/image-sig.c b/boot/image-sig.c
index 4eab017bc2d..80a9c4325bd 100644
--- a/boot/image-sig.c
+++ b/boot/image-sig.c
@@ -18,8 +18,6 @@ struct checksum_algo checksum_algos[] = {
 	{
 		.name = "sha1",
 		.checksum_len = SHA1_SUM_LEN,
-		.der_len = SHA1_DER_LEN,
-		.der_prefix = sha1_der_prefix,
 		.calculate = hash_calculate,
 	},
 #endif
@@ -27,8 +25,6 @@ struct checksum_algo checksum_algos[] = {
 	{
 		.name = "sha256",
 		.checksum_len = SHA256_SUM_LEN,
-		.der_len = SHA256_DER_LEN,
-		.der_prefix = sha256_der_prefix,
 		.calculate = hash_calculate,
 	},
 #endif
@@ -36,8 +32,6 @@ struct checksum_algo checksum_algos[] = {
 	{
 		.name = "sha384",
 		.checksum_len = SHA384_SUM_LEN,
-		.der_len = SHA384_DER_LEN,
-		.der_prefix = sha384_der_prefix,
 		.calculate = hash_calculate,
 	},
 #endif
@@ -45,8 +39,6 @@ struct checksum_algo checksum_algos[] = {
 	{
 		.name = "sha512",
 		.checksum_len = SHA512_SUM_LEN,
-		.der_len = SHA512_DER_LEN,
-		.der_prefix = sha512_der_prefix,
 		.calculate = hash_calculate,
 	},
 #endif
diff --git a/include/image.h b/include/image.h
index 6edcb1995bf..b7086528e47 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1660,8 +1660,6 @@ struct image_region {
 struct checksum_algo {
 	const char *name;
 	const int checksum_len;
-	const int der_len;
-	const uint8_t *der_prefix;
 #if IMAGE_ENABLE_SIGN
 	const EVP_MD *(*calculate_sign)(void);
 #endif
diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
index c2d62e9cf0f..7a167130dae 100644
--- a/include/u-boot/sha1.h
+++ b/include/u-boot/sha1.h
@@ -28,7 +28,6 @@ extern "C" {
 
 #define SHA1_SUM_POS	-0x20
 #define SHA1_SUM_LEN	20
-#define SHA1_DER_LEN	15
 
 #define SHA1_DEF_CHUNK_SZ 0x10000
 
@@ -36,8 +35,6 @@ extern "C" {
 #define K_OPAD_VAL 0x5C
 #define K_PAD_LEN 64
 
-extern const uint8_t sha1_der_prefix[];
-
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
 typedef mbedtls_sha1_context sha1_context;
 #else
diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 2d86508332e..4137b0c5851 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -13,9 +13,6 @@
 
 #define SHA224_SUM_LEN	28
 #define SHA256_SUM_LEN	32
-#define SHA256_DER_LEN	19
-
-extern const uint8_t sha256_der_prefix[];
 
 /* Reset watchdog each time we process this many bytes */
 #define CHUNKSZ_SHA256	(64 * 1024)
diff --git a/include/u-boot/sha512.h b/include/u-boot/sha512.h
index 92660d93357..d186238d856 100644
--- a/include/u-boot/sha512.h
+++ b/include/u-boot/sha512.h
@@ -9,9 +9,7 @@
 #endif
 
 #define SHA384_SUM_LEN          48
-#define SHA384_DER_LEN          19
 #define SHA512_SUM_LEN          64
-#define SHA512_DER_LEN          19
 #define SHA512_BLOCK_SIZE       128
 
 #define CHUNKSZ_SHA384	(16 * 1024)
@@ -28,8 +26,6 @@ typedef struct {
 } sha512_context;
 #endif
 
-extern const uint8_t sha512_der_prefix[];
-
 void sha512_starts(sha512_context * ctx);
 void sha512_update(sha512_context *ctx, const uint8_t *input, uint32_t length);
 void sha512_finish(sha512_context * ctx, uint8_t digest[SHA512_SUM_LEN]);
@@ -37,8 +33,6 @@ void sha512_finish(sha512_context * ctx, uint8_t digest[SHA512_SUM_LEN]);
 void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz);
 
-extern const uint8_t sha384_der_prefix[];
-
 void sha384_starts(sha512_context * ctx);
 void sha384_update(sha512_context *ctx, const uint8_t *input, uint32_t length);
 void sha384_finish(sha512_context * ctx, uint8_t digest[SHA384_SUM_LEN]);
diff --git a/lib/mbedtls/sha1.c b/lib/mbedtls/sha1.c
index 2aee5037795..3dbec314e11 100644
--- a/lib/mbedtls/sha1.c
+++ b/lib/mbedtls/sha1.c
@@ -11,11 +11,6 @@
 #include <string.h>
 #include <u-boot/sha1.h>
 
-const u8 sha1_der_prefix[SHA1_DER_LEN] = {
-	0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e,
-	0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14
-};
-
 void sha1_starts(sha1_context *ctx)
 {
 	mbedtls_sha1_init(ctx);
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 59edcb517df..d4b97a1c16d 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -16,12 +16,6 @@
 #include <mbedtls/hkdf.h>
 #endif
 
-const u8 sha256_der_prefix[SHA256_DER_LEN] = {
-	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
-	0x00, 0x04, 0x20
-};
-
 void sha256_starts(sha256_context *ctx)
 {
 	mbedtls_sha256_init(ctx);
diff --git a/lib/mbedtls/sha512.c b/lib/mbedtls/sha512.c
index 5615248cb91..308edcbd635 100644
--- a/lib/mbedtls/sha512.c
+++ b/lib/mbedtls/sha512.c
@@ -11,18 +11,6 @@
 #include <compiler.h>
 #include <u-boot/sha512.h>
 
-const u8 sha384_der_prefix[SHA384_DER_LEN] = {
-	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02, 0x05,
-	0x00, 0x04, 0x30
-};
-
-const u8 sha512_der_prefix[SHA512_DER_LEN] = {
-	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03, 0x05,
-	0x00, 0x04, 0x40
-};
-
 void sha384_starts(sha512_context *ctx)
 {
 	mbedtls_sha512_init(ctx);
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 3169c3a6dd1..5b70c971c31 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -25,6 +25,56 @@
 /* Default public exponent for backward compatibility */
 #define RSA_DEFAULT_PUBEXP	65537
 
+static const unsigned char rsa_sha1_der_prefix[] = {
+	0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e,
+	0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14
+};
+
+static const unsigned char rsa_sha256_der_prefix[] = {
+	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
+	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
+	0x00, 0x04, 0x20
+};
+
+static const unsigned char rsa_sha384_der_prefix[] = {
+	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
+	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02, 0x05,
+	0x00, 0x04, 0x30
+};
+
+static const unsigned char rsa_sha512_der_prefix[] = {
+	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
+	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03, 0x05,
+	0x00, 0x04, 0x40
+};
+
+static int rsa_get_digest_info(const char *name,
+			       const unsigned char **der_prefix)
+{
+	if ((tools_build() || CONFIG_IS_ENABLED(SHA1)) &&
+	    !strcmp(name, "sha1")) {
+		*der_prefix = rsa_sha1_der_prefix;
+		return sizeof(rsa_sha1_der_prefix);
+	}
+	if ((tools_build() || CONFIG_IS_ENABLED(SHA256)) &&
+	    !strcmp(name, "sha256")) {
+		*der_prefix = rsa_sha256_der_prefix;
+		return sizeof(rsa_sha256_der_prefix);
+	}
+	if ((tools_build() || CONFIG_IS_ENABLED(SHA384)) &&
+	    !strcmp(name, "sha384")) {
+		*der_prefix = rsa_sha384_der_prefix;
+		return sizeof(rsa_sha384_der_prefix);
+	}
+	if ((tools_build() || CONFIG_IS_ENABLED(SHA512)) &&
+	    !strcmp(name, "sha512")) {
+		*der_prefix = rsa_sha512_der_prefix;
+		return sizeof(rsa_sha512_der_prefix);
+	}
+
+	return -EINVAL;
+}
+
 /**
  * rsa_verify_padding() - Verify RSA message padding is valid
  *
@@ -33,28 +83,37 @@
  *
  * @msg:	Padded message
  * @pad_len:	Number of expected padding bytes
- * @algo:	Checksum algo structure having information on DER encoding etc.
+ * @algo:	Checksum algorithm used to select the DigestInfo prefix
  * Return: 0 on success, != 0 on failure
  */
 static int rsa_verify_padding(const uint8_t *msg, const int pad_len,
-			      struct checksum_algo *algo)
+			      const struct checksum_algo *algo)
 {
+	const unsigned char *der_prefix;
+	int der_len;
 	int ff_len;
 	int ret;
 
+	der_len = rsa_get_digest_info(algo->name, &der_prefix);
+	if (der_len < 0)
+		return der_len;
+
+	ff_len = pad_len - der_len - 3;
+	if (ff_len < 8)
+		return -EINVAL;
+
 	/* first byte must be 0x00 */
 	ret = *msg++;
 	/* second byte must be 0x01 */
 	ret |= *msg++ ^ 0x01;
 	/* next ff_len bytes must be 0xff */
-	ff_len = pad_len - algo->der_len - 3;
 	ret |= *msg ^ 0xff;
 	ret |= memcmp(msg, msg+1, ff_len-1);
 	msg += ff_len;
 	/* next byte must be 0x00 */
 	ret |= *msg++;
 	/* next der_len bytes must match der_prefix */
-	ret |= memcmp(msg, algo->der_prefix, algo->der_len);
+	ret |= memcmp(msg, der_prefix, der_len);
 
 	return ret;
 }
diff --git a/lib/sha1.c b/lib/sha1.c
index be502c6126b..4f35850b384 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -24,11 +24,6 @@
 
 #include <linux/compiler_attributes.h>
 
-const uint8_t sha1_der_prefix[SHA1_DER_LEN] = {
-	0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e,
-	0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14
-};
-
 /*
  * 32-bit integer manipulation macros (big endian)
  */
diff --git a/lib/sha256.c b/lib/sha256.c
index c2e77c854b9..b99f8105c8d 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -13,12 +13,6 @@
 
 #include <linux/compiler_attributes.h>
 
-const uint8_t sha256_der_prefix[SHA256_DER_LEN] = {
-	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
-	0x00, 0x04, 0x20
-};
-
 /*
  * 32-bit integer manipulation macros (big endian)
  */
diff --git a/lib/sha512.c b/lib/sha512.c
index 0e75c1a943b..06d9b5564f9 100644
--- a/lib/sha512.c
+++ b/lib/sha512.c
@@ -16,18 +16,6 @@
 #include <compiler.h>
 #include <u-boot/sha512.h>
 
-const uint8_t sha384_der_prefix[SHA384_DER_LEN] = {
-	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02, 0x05,
-	0x00, 0x04, 0x30
-};
-
-const uint8_t sha512_der_prefix[SHA512_DER_LEN] = {
-	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03, 0x05,
-	0x00, 0x04, 0x40
-};
-
 #define SHA384_H0	0xcbbb9d5dc1059ed8ULL
 #define SHA384_H1	0x629a292a367cd507ULL
 #define SHA384_H2	0x9159015a3070dd17ULL
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index 5285263c616..758f14337ed 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -16,32 +16,24 @@ struct checksum_algo checksum_algos[] = {
 	{
 		.name = "sha1",
 		.checksum_len = SHA1_SUM_LEN,
-		.der_len = SHA1_DER_LEN,
-		.der_prefix = sha1_der_prefix,
 		.calculate_sign = EVP_sha1,
 		.calculate = hash_calculate,
 	},
 	{
 		.name = "sha256",
 		.checksum_len = SHA256_SUM_LEN,
-		.der_len = SHA256_DER_LEN,
-		.der_prefix = sha256_der_prefix,
 		.calculate_sign = EVP_sha256,
 		.calculate = hash_calculate,
 	},
 	{
 		.name = "sha384",
 		.checksum_len = SHA384_SUM_LEN,
-		.der_len = SHA384_DER_LEN,
-		.der_prefix = sha384_der_prefix,
 		.calculate_sign = EVP_sha384,
 		.calculate = hash_calculate,
 	},
 	{
 		.name = "sha512",
 		.checksum_len = SHA512_SUM_LEN,
-		.der_len = SHA512_DER_LEN,
-		.der_prefix = sha512_der_prefix,
 		.calculate_sign = EVP_sha512,
 		.calculate = hash_calculate,
 	},

-- 
2.53.0

