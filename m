Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0213C5DF6A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77C348137E;
	Sat, 15 Aug 2026 13:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pO6Rn4WWT9ox; Sat, 15 Aug 2026 13:01:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5AA48128A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786798897;
	bh=LGFBDDNEyf4wpzY0FZqm6IHiNJWUZdn5L9YA/UX6z1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vbJOsxtG7Xhl3H6/uxpG4kmZm8JW5Jjuw9M+D4hl6yG0uDkBe2kj7dtwiZemXu67c
	 AOKugWy5TcQfK1BfA6Qn/cg0TpH+doVQmbrtKZHIikbx2Z7L77N1n/se2RH2bqqA0o
	 Xo6IxBqt3LYK5dSYLCb9fnb0SVytooXJHzXvmAp2Sq9K1XqsoKJKPoSlK889x57EVE
	 D0ziHzkzoCJTp6VD85IFugkVqHJX6rvKYtyaBxwVc+3vT4AfC8KpI6cHVlDfUAiosW
	 nWEr/h1JnL/OG19mXQBmLg77V2+/65C4W3EqOgymTJ5m5NxAI3RWiSN2acIQJFgpoa
	 Df9vcrFlmi3kA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5AA48128A;
	Sat, 15 Aug 2026 13:01:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F1C6333B
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E39A181367
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZdEvJ6UqiyXJ for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 05:48:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9163381364
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9163381364
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=p7oywapQ
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9163381364
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:59 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7f0167e59a3so1140642a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786772938; x=1787377738;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LGFBDDNEyf4wpzY0FZqm6IHiNJWUZdn5L9YA/UX6z1o=;
 b=p7oywapQWnmipzihktk0RhH6xVShXV2MW92qNs1oX4NV9o71zuQ5iAg54ykpBCFwFr
 KCwmyup3cWfzJcIun9Mcvn5XTQl3+7ifKn33spcn0IqAuJhQ6+j9JyHA8qhSuBCtdwjB
 pzt7A3ZvxoZ523ciBsrUIYWObKvWDNoVlHCD3LjBHeTINzd4oj/q8nkSZJtKT885sf2r
 YSzMjhybwOKiaL+ROa07duvilge2EeS0fevHfEcrW6qcVuxOm4EoyrEAsm3T0Hso0Dd1
 LqRtPmoVBKgLs+Rv5tcbCLG89B4SPiV0/JDRGPI6/hTcnuZyLiUbYmnD03nsbfCeoFVl
 I2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786772938; x=1787377738;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LGFBDDNEyf4wpzY0FZqm6IHiNJWUZdn5L9YA/UX6z1o=;
 b=g5/jNgG7XMURDJwNIv7aWPe9HWqOBfEuYopfqGZLSya8Q0fCpnPVOgMy9HP2EVK6Wj
 PnIvTbqUVVj4NOcdG6CEGU473zUOEyqE3xsfvLdLIE3lWkNL/ufNKkS/Qwes0VLY+gZV
 fE/74BM1R5m8ULzQOGuzCH8ERk2geJvCSsc3VgiWk5d/rKU2xcmqNRhPcpuWt0Imibs8
 UGo+Su0/rkeAj9Kkn+eN4lsKd8t1uez8bUniPO1YMcoOwL545YZJTCGA3cSCKGCeO8Q4
 cbw3wIfAIADTA7WHmpM2hyAu5m1lxnB1hqD2UHvc1ueQ8mpLSIcgQ6R+SMp/E7kweNwr
 225A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLEmrEOAEoAMmZY8C/bzDopx1yUEVosjmHrrBhCLZ6qZYwXy/EOapdSaOkRiocahxgGFVi1Nk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyW8Fx3+YNbxGg8X8TUoDV+XBHJXseiVoM0p7hDBA40XOGPxSq/
 ZxxRcGGi7XMKcQ1id7h905Q7Uj9yJsD2vslffcSmj1LeG5R3qc4ps0C6
X-Gm-Gg: AR+sD13vBM1m7Ql2/LKEOBpyDSCJQQMgTE+K1z6aaHHpNDO/+aYRwcuOBDKT6mhS/V3
 NLqTWavfkcctXyUnsg+5qwJ+CwdkgokYKiPOEjx4r21mrNBKIUiWV4L95s/qLmrR3ttf9+O/BBQ
 PQIQhQvQjmojG60U71pobEKcNmieKlQSjLikPzxngM/eMo8LYIolBKeDpeKp4P5FIHQjy1RbScn
 rG8oejFRKlcRa0piuyXvMsFesVqLnJS3wPvHgWYZtcpXIjjqhNIfjEW0hc881+7hBBPSYnyxrt6
 GJhvczyNijH1vWcmpAjJdwimQVIi2QkieBI+AColzJj5+1HPuTXypXP4DaLIYofV++1YY3AyBmi
 RVrGrq3iCnWkDS+tcP8yFyQjps8gJxNe6k+ZtwLp1Oa9etbdz53z5524TGSR1QDV9SuHF5x+Y6O
 Gj1iDolhuHkejz3NjamLKXeNfxH9ZftwpwlnLaEo2x1jGiqhJNZYe0+HLi8bBNfOfesLjGGuhHG
 Rp5y/zlijfYxQFaJr5eKu9EAASc7B61JQpBEqDqFmPlyGDO2aXma6tV/7SM2rA3qk0M5Upm3fQ1
 Qkd4XenFLF0d6ohR0u1WdhBeiSsDoGUv6SxK+iTUhWaoRgV0WrYCpXhfZ+eMOa55zjh8p1LQO+S
 d6k4YVx8RAb9DCAG8
X-Received: by 2002:a05:6830:3913:b0:7e9:e094:db97 with SMTP id
 46e09a7af769-7f3de37a607mr11583708a34.1.1786772938228; 
 Fri, 14 Aug 2026 22:48:58 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282a6sm2780166a34.18.2026.08.14.22.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:48:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 23:48:16 -0600
Subject: [PATCH v8 09/15] boot: image: add FIT decrypt-to-buffer helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-ce-series-v2-v8-9-fe9212431a94@gmail.com>
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
payload is already in writable RAM and has a payload hash. The encrypted
data is no longer needed after hash verification, and this avoids a
full-size allocation for encrypted payloads loaded into DRAM.

When normal image verification is disabled, verify the payload hash
before overwriting the ciphertext. A repeated load then fails the hash
check before AES sees the plaintext. Keep using the allocating path for
hashless payloads so their ciphertext remains reusable, and leave signed
FIT metadata unchanged.

On host builds, make both decrypt helpers return -ENOSYS instead of
reporting success without producing output.

Add sandbox coverage for out-of-place and in-place AES-256 decrypt and
malformed key, IV and size inputs.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v5 -> v6:
  - Keep signed FIT metadata unchanged after in-place decryption
  - Require a payload hash for in-place decryption and verify it when
    normal verification is disabled, so repeated loads fail before AES
    processes plaintext  (suggested by Simon Glass)
  - Return -ENOSYS from the allocating host decrypt stub
    (suggested by Simon Glass)
  - Preserve the existing fit_image_decrypt_data() declaration wrapping

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
 boot/image-cipher.c         | 47 ++++++++++++++++++-----
 boot/image-fit.c            | 66 +++++++++++++++++++++++++++++---
 include/image.h             | 39 +++++++++++++++++++
 include/u-boot/aes.h        | 27 ++++++++++----
 lib/Makefile                |  2 +-
 lib/aes/aes-decrypt.c       | 91 +++++++++++++++++++++++++++++++++++++--------
 test/lib/Makefile           |  3 ++
 test/lib/test_aes_decrypt.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 325 insertions(+), 39 deletions(-)

diff --git a/boot/image-cipher.c b/boot/image-cipher.c
index 9d389f26cea..e7ef72987cc 100644
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
@@ -115,7 +119,7 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 						 &info->size_unciphered);
 	if (ret) {
 		printf("Can't get size of unciphered data\n");
-		return -1;
+		return ret;
 	}
 
 	/*
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
index 86ebf58680d..24ce9c83c7c 100644
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
+	val = fdt_getprop(fit, noffset, FIT_DATA_SIZE_UNCIPHERED_PROP, &len);
 	if (!val)
 		return -ENOENT;
+	if (len != sizeof(*val))
+		return -EINVAL;
 
 	*data_size = (size_t)fdt32_to_cpu(*val);
 
@@ -1550,8 +1553,33 @@ int fit_all_image_verify(const void *fit)
 	return 1;
 }
 
+#ifndef USE_HOSTCC
+static bool fit_image_has_hash(const void *fit, int image_noffset)
+{
+	int noffset;
+
+	fdt_for_each_subnode(noffset, fit, image_noffset) {
+		const char *name = fit_get_name(fit, noffset, NULL);
+
+		if (!strncmp(name, FIT_HASH_NODENAME,
+			     strlen(FIT_HASH_NODENAME)))
+			return true;
+	}
+
+	return false;
+}
+
+static bool fit_range_in_writable_ram(const void *data, size_t size)
+{
+	ulong start = map_to_sysmem(data);
+
+	return start >= gd->ram_base && start <= gd->ram_top &&
+	       size <= gd->ram_top - start;
+}
+#endif
+
 static int fit_image_uncipher(const void *fit, int image_noffset,
-			      void **data, size_t *size)
+			      bool verified, void **data, size_t *size)
 {
 	int cipher_noffset, ret;
 	void *dst;
@@ -1562,15 +1590,40 @@ static int fit_image_uncipher(const void *fit, int image_noffset,
 	if (cipher_noffset < 0)
 		return 0;
 
+#ifndef USE_HOSTCC
+	if (!tools_build()) {
+		/*
+		 * Avoid a full-size allocation when the FIT payload is already
+		 * in writable DRAM. Require a payload hash so an unverified
+		 * repeated attempt detects the consumed ciphertext before
+		 * decrypting it again.
+		 */
+		if (fit_range_in_writable_ram(*data, *size) &&
+		    fit_image_has_hash(fit, image_noffset)) {
+			if (!verified && !fit_image_verify(fit, image_noffset)) {
+				ret = -EACCES;
+				goto out;
+			}
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
 
@@ -2299,7 +2352,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	/* Decrypt data before uncompress/move */
 	if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
 		puts("   Decrypting Data ... ");
-		if (fit_image_uncipher(fit, noffset, &buf, &size)) {
+		if (fit_image_uncipher(fit, noffset, images->verify,
+				       &buf, &size)) {
 			puts("Error\n");
 			return -EACCES;
 		}
diff --git a/include/image.h b/include/image.h
index b7086528e47..fb1fce6e3b2 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1179,6 +1179,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_DATA_POSITION_PROP	"data-position"
 #define FIT_DATA_OFFSET_PROP	"data-offset"
 #define FIT_DATA_SIZE_PROP	"data-size"
+#define FIT_DATA_SIZE_UNCIPHERED_PROP	"data-size-unciphered"
 #define FIT_TIMESTAMP_PROP	"timestamp"
 #define FIT_DESC_PROP		"description"
 #define FIT_ARCH_PROP		"arch"
@@ -1873,11 +1874,45 @@ int fit_image_check_sig(const void *fit, int noffset, const void *data,
 			size_t size, const void *key_blob, int required_keynode,
 			char **err_msgp);
 
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
 int fit_image_decrypt_data(const void *fit,
 			   int image_noffset, int cipher_noffset,
 			   const void *data, size_t size,
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
+ *
+ * If @data and @data_unciphered are the same buffer, successful decryption
+ * overwrites the encrypted payload.
+ *
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
@@ -1994,6 +2029,10 @@ struct cipher_algo {
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
index 777c48a5728..77ea3c9cfeb 100644
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
index 741102a4723..8a9b5f01efb 100644
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
+	return -ENOSYS;
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

