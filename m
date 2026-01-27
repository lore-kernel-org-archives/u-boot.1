Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B831D2D8F9
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 11:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E1B584013;
	Tue, 27 Jan 2026 12:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0QA9A0aI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7358405C; Tue, 27 Jan 2026 12:04:27 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A1B83FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 12:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso56179415e9.2
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769511865; x=1770116665;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sStyDhuURqq6zjHORLeMr/uOSXqD+ZbCvVikX/t5DwM=;
 b=0QA9A0aI83RXduZt1SViiLxjyx8sCvjsmPWGTEM1MvFaQ0ReyBnrgG29nykBtzx8hh
 8ABiAbgirP9f6xD+nBL/S/jc9EE6dRLLfKkx0XKgN8VBVBDXmISevzVVns5WtkXwuLJP
 CU2Gfy8+uIJeWKS2+OUZndu178UROi9JOPaIJRwtsPodb/hCdXpVD4LSUnR1LuzcZcMZ
 h6or6phwV34VZdhx83mu6iJGmDLPjlKjCKPnbwAGDxa6uUg3vPHwEi0k/dr1TbYrMKIE
 weZ4g8/Fq2TSlccEQy5/lWi2U+nPgylhtLE53b2PlA2KV7k3DUR84yn7ooM/QkDJ4CmP
 edZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511865; x=1770116665;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sStyDhuURqq6zjHORLeMr/uOSXqD+ZbCvVikX/t5DwM=;
 b=p9X9coX52boICo3i1a6JrPaZKm9I1r2R2qoVIWWcQuKHk+kCKLGfxo5hxJqaa6jBxk
 01oSo+OX+PHG2g4lFHJRp4k5otpb7Ach0fbsde8JQsh35WgmJVas1iRMVBu//xYS9xPw
 5YryE5XplByG6SWitIS5Ly1qoWv0IR1rShOkANiXZnPhii4qvyxjnRrWaQZnXVc+U4Ig
 /JuwpPLVGXbWr60PCUY7UkAwVWUlwSo5PM6WrZHnAGbn4ucvVzGUPmnbJ7/hzlTve6s0
 vrXgTw9GFm5OgI9V6iuZvT5qhN9xVGYbXrChjFKRhIuHF22ZllD0jrMh0IidgMTEiAwQ
 O5rQ==
X-Gm-Message-State: AOJu0YzQeBWQc0kW5e5JqMY2Ab9p5MxkB6PhNwltoqeeCCUjbYbcp/Yu
 gsMWEPbZi+BJjIJrB80IFCHl8fTXVv9plBOBinmefMI2KXYbNrjc7uorx/Y4buGtk2I=
X-Gm-Gg: AZuq6aKpnDJpyDx3e4nOdB5ww/PXgXcX5qEagx1/ir4VPncmlADvnWHMh0UNghs3Sbm
 vdgYQA0IXjmkUeLcn1nfu3hLTfxuS96IvRdBi18Q7PZ/PN6WV3ir0pHKB5aStrW+dG416UYhXAs
 OCBJOWCgdLDvEh/NQrtA0tQ1RopVYxdoNASYgoWpN0kIlVMJVOUPsDykV87jMQyf75+B0i0pG9L
 61AhGGW0QIamKmXR1LtDdiEskGBUNlJsTF/oZXE8iFUb9AdIZtM2gLjfKiJcDccjcmub6DZJ4dR
 IDfMvnHA2xEbyI95vlP39Jc6pmTk7xye+SgWg9LoUAFq2PPumHQy5s72BxagQSccboyVvRcfQiI
 nc0oTBzR+nGMSo5sbTDmpHTBp3PYJMjfFKY3e9tyK4wdHcgmdIrGCUfR4sYn5FCON5tPQ9YEcP6
 F9NWL785re
X-Received: by 2002:a05:600c:8b31:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-48069c164e5mr18350825e9.3.1769511864960; 
 Tue, 27 Jan 2026 03:04:24 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7413sm50156845e9.3.2026.01.27.03.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:04:24 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 12:03:39 +0100
Subject: [PATCH v4 5/7] test: dm: Add compatible multimatch test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-musb-probing-v2026-01-v4-5-ea3201e0f809@baylibre.com>
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=msp@baylibre.com;
 h=from:subject:message-id; bh=90OSVcJKXUNoXS89psbBEuNKHYSCoetSd1GEzohGVGc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyK2YtExeyPsM2RD/AQ53kjKhwj8UXfR9TmRIhj1Y1Qn
 cf7C5U6SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCKnCxgZ/mi4etq9ua/L9+lY
 J6Nv6ox+eTbNn/2mco+N+N91Od++ychwrUv0r5Gx7Kpvl28etGdfqn9JSarlrv5i1ZPni3pOsS3
 kAgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/sandbox/dts/test.dts |  4 ++++
 test/dm/core.c            | 15 +++++++++++++++
 test/dm/test-driver.c     | 26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index cd53c170171c7b78a1b865577116fbd067798886..b7402d7042a55801f5ce912642233b1b03b691d6 100644
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

