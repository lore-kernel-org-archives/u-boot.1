Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCF9C5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46D118146B;
	Thu, 13 Aug 2026 20:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJ47d-CqB1hz; Thu, 13 Aug 2026 20:17:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30C388145A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652271;
	bh=v/ktMIvCp5cvwx+T/Lc9kbY5PyOzlFH10QD0ZD1I78g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ebBuZjBjBKSoWvP6D2dwBeZF2GwOdKA46L8yvOZ+LHkZFDtWH9XDpU9Hy5lqgY6kC
	 n4d9soGPitjFcLruxMzw+moNz22pHZ6IkzM8B/BnjPUnHmUY7qQjPjxs96T+kVgHsA
	 ZIm31pCP9bBK4j+DZIFX2RWpMmW4ATLrLNJCu1yUhM9G32FTY39dDvuwUoW9uolC9M
	 v+b4+4pyJnbPHft3ENal19OgifSXFQrNfxwqHe+cQU5/mEfWtRITDUusZ+gPOtfzYF
	 XD+ktJ23rjkpYi5B1TlCzAZvExLtxaIRYk9+uCtt8vlXM7fN4Jg5m5bMDgSpbh8QK5
	 wimH5XCYP8WkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30C388145A;
	Thu, 13 Aug 2026 20:17:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ADD593DF
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A012B80A66
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Thpw6-1CmeI for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:59:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7B26B80AFB
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B26B80AFB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZocjRlb/
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B26B80AFB
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:20 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7f0167e59a3so261579a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651159; x=1787255959;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v/ktMIvCp5cvwx+T/Lc9kbY5PyOzlFH10QD0ZD1I78g=;
 b=ZocjRlb/qsdQ6UDsyNRdL4SWifEgh7INm0xgXCAjALaFqJb3ZpUARRHLqXhFBh1KDF
 uBYO6XJi9cHtk6m44uSTsnkHC2hlAeO8yCtbREhExrUwr0d0ri1aIzfj84OA7tYamGJm
 2Wqh4bTyfozKoUiWGxY5Vyo/P4mwYRAZhom7sTYPp7YQoag+d59ODyzqswCWyLVR4M8O
 vJaKC5Vy7PDqcBHCAEjE+DppH6/Atztde1Ub8LFbCLg7Bmo01/h2dCb25TpHAQb8nBgu
 Kt1+tVDHK4CtlDtkg+nHk4RnDiLnl06rI0aKunVLyjWN3Z7IVtQMD9kNG8AatuP8K+De
 f/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651159; x=1787255959;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v/ktMIvCp5cvwx+T/Lc9kbY5PyOzlFH10QD0ZD1I78g=;
 b=Gq3eO2tG09yl1RMKVx34FyAPSUVUN2NR/19DdZSz6BFLr5KzLxy80ug9693OyZmtTX
 RbnjbNHqtkAHj0NlQzai7CxM6B8pi5R5938JoSwGy0Q0D+yiYYADlMWzmdaLMw9s0W3W
 MEutD9ioz5GBeKBqthLA08fFiaynkWmNgzzmKi3XzigJLcOyBhIsu/TfmuyPjsqFgyV0
 +Vfvgn6f6OCoKzIsnZ5Xi6see03vpNq8EQOuqI952ILKX9Bnh2zm0bjTmnaKJn2yYmpI
 6AJ8LpkXIL/tCe5DUmWZphJAfR+5xy4YHxxiEhUrNXNv1jpvnnhPw4K/4bj1Lh4N6mel
 BBqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWLxqWtP9iV9BX5olwFC5Qwh2aH9o4QBQzsU7whfohFpoe6Br4aUmcG48dRuHmKQ6RFQW7jf4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyvjOgOMotxLAXzHa9s+U3Pz8UybzW3aCjWIY2f+TRpNYQcInIQ
 tuPOLeNAJjPjzNr0fuwDy3E/oKJTSiAJ/J/5SEA8G0Rha1M3z2kIJf9A
X-Gm-Gg: AR+sD10/bfr0OMV4/idk43CUNxATYs2eqQkCkKgtK7//pzgCBNXYO8YVltfXT87tnfk
 xjzISVdp0vGl0j6LpmkrMZzdX5gMEapfKI23Wr8G2+MGH+PfhF9RQ1TV6wwFcmLUYI1b58hK8id
 ReW4wJ8rX9CTkuGkUpfjU/AfC5cCgyTebITuohPjgga5EH/KbKc114Fr4OjX5Nc6G2olEaXwRsw
 9WagCLM9wW/NQndr2M1zP3eG0sEoC3q3SObwM9rOUovXtS0K//h5TT8XgRcYJtJ0M4iTzsqgkRf
 DV7rje/mu9Z88PVovZHKa4BA4rnG1klWU0XECq98/9C7Wc/tz6EWeb9Yak+NcFR9ZXCUzOXyk/u
 E4q519sLCxUDQfBEhwQMfRYdSDcjlVFaNmw+DgU8iuQRnrDP3xrB8TSCWwWwvziimiMn4TDeUFG
 tYfSZn0cHqP0Yonp2rPwfYpNdet3IJex7YIUnPZjN6j+/F9KLLLJ18EZDn1rH2zpJDvMo4XMiW2
 ii4Bct35WTiaOddchg1H0ii/RwqToj8lpus7LU1W7HUI29158CaZUMCJfLDSbWT+nz33eNVBK1F
 t+ksSUZZoXKCKWkvjQTOrb33i/nKI73Np26W1gzNs7sj8zgsvZM0MQRveYIGHtPOLRBj+FRJU27
 Ss2EDaFhDERKgDdWb
X-Received: by 2002:a05:6820:16aa:b0:6ac:a45e:ff75 with SMTP id
 006d021491bc7-6b0d5fcaca4mr780615eaf.4.1786651159221; 
 Thu, 13 Aug 2026 12:59:19 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c34sm3345507eaf.6.2026.08.13.12.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:59:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 13 Aug 2026 13:58:58 -0600
Subject: [PATCH v7 05/15] lib: rsa: internalize PKCS#1 DigestInfo prefixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-submit-ce-series-v2-v7-5-593fcd8479fd@gmail.com>
References: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
In-Reply-To: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 20:17:42 +0000
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

