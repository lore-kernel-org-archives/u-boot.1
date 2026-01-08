Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987B7D185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E57918418A;
	Thu,  8 Jan 2026 14:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="146iLVSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA6884127; Thu,  8 Jan 2026 12:17:31 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6ED383B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65089cebdb4so3149840a12.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 03:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767871049; x=1768475849;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=chxytI03mFjueu6/FFpWHWHz1dBGwXEIshhQsaDzdAg=;
 b=146iLVSbk5SC+AiYi5qszvfP5CS9tz29bw3Ytq0sQm+dTlb+v0RnLgocufS92XYH1O
 eri0MWXAhVQjBERfRmckUWZbB//weGMCugfrQ6/RnocTNIRinSE3r7qkUGx3qqha5WwG
 v7wLa7/1TyJv+zXzHMu+byGuhuP5AClC3sKU293sATGNfMJJ0tigswGZ+yQBY+IEX6MK
 jyh3++QQ7PgASJ/F+mw+9A63e0/XCg6Idtc1uvu/J5gGoQB4ftHZsWvxEjv1iQFdA27e
 GClhqylVOUTu6htcNF2AynReZGcacWebcV/ffEuaMFWyfMgLbauGnEn6cgZhEeNEfL78
 uFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871049; x=1768475849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=chxytI03mFjueu6/FFpWHWHz1dBGwXEIshhQsaDzdAg=;
 b=FCNKyVX3gNjD/4ozX87qIcx7YR90Dgq7p+IifuJbTX0M8ULNeyfm6IcQx62Z6QjszM
 MQnp/DoyB/4Lwn4/WNMOtTgL5Da7Gp5dlw7Vc1QPwTyAlxGx8D6pG9pvGozogk6qS3gZ
 2XD2LwswDqC+05B66cmIE+LtRgIoLLYJcufqcYHm++DfL7u5Oim7VcjVN+xljLxliI5E
 2By/meUAuzOkhFmlzwM11ZuDndBlhGHCEK+0duOhyuBFQ+TFCRhouimYimSicJqA6OPq
 Mr9RQnE8+HGQCvbfvT5wTx+6s1qL64Iw0Bemt2L+mhsWD8YMyCcTvUfgIZF2u/81E3WT
 apoQ==
X-Gm-Message-State: AOJu0Yzc/D5kAj8jCFMrmZAB4ZbTclheqr31SLS45kK2B/7JWxUTmbBV
 SccbI3yPjlO8zlB4LuAsmzHk/qQ5t/EM5kDu4PGFhrUNc21Rt4+JQi7BT2YXEFOB0Xo=
X-Gm-Gg: AY/fxX6P+OsuszchTMBNJ2v7PuyzZNuz1RfxzANYb4BeCknZoQWB06nMSqE2DAHDpQg
 hAlrv+/+Hf4IYYYOiOF7/rqTQ6wilqQTZ8NndOmfchWArYitSH4Pzm1gcd9AWLKqySAb1fxLHm3
 7kq4iqYiBMTu2cVAVh03eYTFGHuYgvsV52NbquDmzuzQaJn2kwSq2T3MX3mmfjS7Q9dC22GBb85
 MMLM/CinHxS2zQq3yk4WeFJfRo6dxKJOyB/3msb1eTTdk7kiX5dHEaLkj45CsORgr7E5MsyWXLf
 Ah7xCyEH8iQLmCDunJeND/PDd5uYvSzEzytqnH7uOHofRAPEDKvfcebEAXxsy1Oc1JA91IDGOUB
 rj0h9ofqWMbBGqxONQ0apSiuBJJOAEFNGBRQ5R67vAyaL6yVLlIYOF8P28PHQwFCYinrQVOfbZu
 h/kh4xLUSB
X-Google-Smtp-Source: AGHT+IGL/eovsI1f2QeZ+VydUFYVIsnnhkplQR1rAPn9rJLoUzu/VbvmTZkJDUn/uADOevW1iWMuaA==
X-Received: by 2002:a17:907:7f93:b0:b7d:22b1:2145 with SMTP id
 a640c23a62f3a-b84451e7a91mr471397266b.23.1767871048976; 
 Thu, 08 Jan 2026 03:17:28 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a233ef3sm794231166b.1.2026.01.08.03.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 03:17:28 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 08 Jan 2026 12:16:30 +0100
Subject: [PATCH v2 4/6] test: dm: Add compatible multimatch test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-topic-musb-probing-v2026-01-v2-4-2a47c6e0e73a@baylibre.com>
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
In-Reply-To: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2661; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4GVrBPElNgHZ+EB9C2l188FcTWbFJvRyOMdGRhih1Jk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz4SSbtFsdteA1uWTwItFj1tKLvC/9V6YTTn6c6z60wz
 1MN3bmoo4SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACai7sfIMOvki5xz2T9Sj6tZ
 nw2sZo4V/CKd6fXcYm35vNitna3mVxh+NKfrNs95eOj4/Y4VdaUTxefMFVtnwM63bu6hDwoqxXE
 cAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:16 +0100
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

Add a test for binding of multiple drivers with the same compatible. If
one of the drivers returns -ENODEV the other one needs to be bound.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/sandbox/dts/test.dts |  4 ++++
 test/dm/core.c            | 15 +++++++++++++++
 test/dm/test-driver.c     | 25 +++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index a2c739a2044c728a96b5f4acbf439a42d7e12fb5..9cc854ffe80e994e34010e299029a7f1756697e0 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -457,6 +457,10 @@
 		mux-control-names = "mux0";
 	};
 
+	multimatch-test {
+		compatible = "sandbox,multimatch-test";
+	};
+
 	phy_provider0: gen_phy@0 {
 		compatible = "sandbox,phy";
 		#phy-cells = <1>;
diff --git a/test/dm/core.c b/test/dm/core.c
index 53693f4f7ed7c7265218e4154ebf81a044a3a431..78ee14af228ab20a6639bb076260296adaea2c92 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -1410,3 +1410,18 @@ static int dm_test_try_first_device(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_try_first_device, 0);
+
+/* Test that all drivers are iterated when bind returns -ENODEV */
+static int dm_test_multimatch(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	ut_assertok(uclass_find_device_by_name(UCLASS_TEST, "multimatch-test",
+					       &dev));
+	ut_assertnonnull(dev);
+	ut_asserteq_str("test_multimatch_second", dev->driver->name);
+	ut_asserteq(2, dm_testdrv_op_count[DM_TEST_OP_BIND]);
+
+	return 0;
+}
+DM_TEST(dm_test_multimatch, UTF_SCAN_FDT);
diff --git a/test/dm/test-driver.c b/test/dm/test-driver.c
index 759de3a5f77f4b64ea577a293586a737e4623f60..bf953d7814df6a0e6efd6c2a3960a925a3fbe5a7 100644
--- a/test/dm/test-driver.c
+++ b/test/dm/test-driver.c
@@ -197,3 +197,28 @@ U_BOOT_DRIVER(test_act_dma_vital_clk_drv) = {
 	.unbind	= test_manual_unbind,
 	.flags	= DM_FLAG_VITAL | DM_FLAG_ACTIVE_DMA,
 };
+
+static int test_multimatch_first_bind(struct udevice *dev)
+{
+	dm_testdrv_op_count[DM_TEST_OP_BIND]++;
+	return -ENODEV;
+}
+
+static const struct udevice_id test_multimatch_ids[] = {
+	{ .compatible = "sandbox,multimatch-test" },
+	{ }
+};
+
+U_BOOT_DRIVER(test_multimatch_first) = {
+	.name	= "test_multimatch_first",
+	.id	= UCLASS_TEST,
+	.of_match = test_multimatch_ids,
+	.bind	= test_multimatch_first_bind,
+};
+
+U_BOOT_DRIVER(test_multimatch_second) = {
+	.name	= "test_multimatch_second",
+	.id	= UCLASS_TEST,
+	.of_match = test_multimatch_ids,
+	.bind	= test_manual_bind,
+};

-- 
2.51.0

