Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B32CD31A2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8662F8394E;
	Wed, 14 Jan 2026 10:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XAo1ff3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68AA2835B3; Wed, 14 Jan 2026 09:34:41 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C64830A0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8710c9cddbso478065366b.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 00:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768379679; x=1768984479;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q1VrYFbRaThT956fhVuaUfI+5oLtLZNQo5/6UrLn7E4=;
 b=XAo1ff3XREdyldhSRWsuWTgWTnnJMQAoXrI5TxdT38lCe6nt0GBXugX9vf6vCqRVIr
 lNyX96xo7V4TqOKnMbCHB0+n7dMAHgc0li9RZv/ZHu++cgqAbh1BVdi1NCOZIW70obaT
 fkvw8brHSaoNnUm1hlbqcjslDJTvc2jMZi25bhxvUeI2e4S4esIaNgHUQaKHb3aWQX8+
 mxDsGd27YAixyNFURmIq9E5LHeb1ZCn7Us0HS3T50oIUc3JnXCfv/83tjmgk27ov7Vyh
 5o6xDLR+th9wuddUDXrGXg1PNoMgOUYAxFk0llpNgHozifhp9m4QfQtc4UP3XhejeIBv
 2NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379679; x=1768984479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q1VrYFbRaThT956fhVuaUfI+5oLtLZNQo5/6UrLn7E4=;
 b=t5ISMwgLFAlcwrV4Z4PkfmD1CM1bgPgXMtDaHnLNfjXpYBTwXyFfaYjcVakPpH2CFk
 se2HeJMuFPu/nwK0UZveNLcAbN+hyhJXRMY4nfDqmQng/4aVTbtJZBhyd8817rcydIVl
 XqU7A961WU1on2XA5HrmxZQ7TtcRptfamzIOviBPemYfSs6iqMla/zpBgPX1vmiTDmoW
 JfAuQsnZmxdRdNkZ3cB7D7jhOnOE3QhU0Pf8ugAl9cBseZCkKvAI1BGn1bOaPF8hzUjS
 qPrFRGGFXh18+Zwv6wDHYiONM1RtEwhHhiM/ho+YI2LCtITDvPwDPecz3oIzerpowhAo
 vmwA==
X-Gm-Message-State: AOJu0YxmYfs9nUm7s/xMFxRcp8E+A18+KelteR1DZ6XP38HpsCp0r36Z
 suhmgB6k1rwxPgvs9LPIbhfwv4AizppUJVt78wJGD1kd6mVhJrwTwNWWfUmO3RP85yQ=
X-Gm-Gg: AY/fxX6uk31bK5prXEvWPR0zJiTs10h24P22JWWNwuFwkusUlQ+1roBjVP1gs7S1s2I
 P3mVwQqTezOa7oK9iIo6Ep7DfcHrsnMg/q8u5GagvauabY8+WQG2+ZAvegmmIL6yVQBsGg2gVek
 bfHQS5sL5iqCNfEs9dfn3hW65VRVmKO7kMxQbofQIJfjxceomZN/OkFV23XN+/EBIUhs4yeopaD
 fOZliElsNAwSmzjUVYvrW1WJe48UjNTC2uDjfrmz6f5FTPYRTT9OlsW+E45LDtccklRXBzit8Xa
 GVAOUZRROCs7k8x2VBmZg6oisp3UP0nXO4vg1RgvUKReBB7Xr6P/A+/ZomT6M3gOAykN/j8/U6O
 C2ifGKKYgDIZlTopXuBvWJ3nMhWy89z1nK4pbQ1nB1e/UQRJl2gG7JK4uD5/a4tQ1LmU2aNamL5
 I9z+uGa5uc
X-Received: by 2002:a17:906:f58a:b0:b86:ef31:b16a with SMTP id
 a640c23a62f3a-b87611399f9mr152241266b.39.1768379678874; 
 Wed, 14 Jan 2026 00:34:38 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b870813a9efsm986908866b.38.2026.01.14.00.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:34:38 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 14 Jan 2026 09:33:51 +0100
Subject: [PATCH v3 4/6] test: dm: Add compatible multimatch test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-topic-musb-probing-v2026-01-v3-4-ebb8d990b9df@baylibre.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
In-Reply-To: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2719; i=msp@baylibre.com;
 h=from:subject:message-id; bh=cn1qKbgg7GTvUKXzxERVt+pG8Z/2SXh+D6C8P9Di3ug=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz0UK5npUYBLsFZXzq1JlaI/plj8J7dUmvFph/vVjZMn
 KOlHGnQUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABOp5mL4K8Wix3hzbWrS0qvL
 bJbY6136mdjc/GTJKrbr52J9dM1TXzIyPJTSXZMd0WNw1Tzi/JmzbUc3Nu2SaXlqa5azZnlshUw
 bHwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 14 Jan 2026 10:17:21 +0100
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

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/sandbox/dts/test.dts |  4 ++++
 test/dm/core.c            | 15 +++++++++++++++
 test/dm/test-driver.c     | 26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

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
index 759de3a5f77f4b64ea577a293586a737e4623f60..d628a6d766fc24f221ffcec3a5dbc6cc060e07bd 100644
--- a/test/dm/test-driver.c
+++ b/test/dm/test-driver.c
@@ -197,3 +197,29 @@ U_BOOT_DRIVER(test_act_dma_vital_clk_drv) = {
 	.unbind	= test_manual_unbind,
 	.flags	= DM_FLAG_VITAL | DM_FLAG_ACTIVE_DMA,
 };
+
+static int test_multimatch_first_bind(struct udevice *dev)
+{
+	dm_testdrv_op_count[DM_TEST_OP_BIND]++;
+
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

