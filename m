Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476FBD111A7
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8412883FD6;
	Wed, 26 Nov 2025 23:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uuk2Zw4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134FA83AA9; Wed, 26 Nov 2025 21:31:55 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD7D839D9
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 21:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b32900c8bso161216f8f.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764189112; x=1764793912;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=chxytI03mFjueu6/FFpWHWHz1dBGwXEIshhQsaDzdAg=;
 b=Uuk2Zw4oION1RkXad7gkS26+tfIRqpo4P5JWMr/dN9CJQ74GjmgHvtkg5g+mRFJ9KI
 LuLR8qcmnFVWfJTD/URL7AzK7Ye3J0aMb45l3GPfxeWSPZUeZ28lwSgOmln2HzwNijJv
 cndku7cUDUkdYOC5UDJD8cCPrfSzKGjrrFJYwowOcKG3heRZw5N+6aVo4ZWocGo16sF7
 I7HVPSDl8POtTs1Fn6TvrqB2iUfpNvR8600vrm21TQJSrk2tng7eLZ/KCe2Ri2/Y3MRd
 rzeC5GXDsslCGR4v23snCA4T0xRhCOsA6B0G/5MLIzSkOg08gAT9cEbkUTW2dVAZ0IQE
 1b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764189112; x=1764793912;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=chxytI03mFjueu6/FFpWHWHz1dBGwXEIshhQsaDzdAg=;
 b=oZ70TOrfN6IqiklzNrcjM9E52U4m5Z/HCIMbvMKNBoze2F09FjB5TPfT/VrkexRA7I
 Ef3PZAUA+7XLDcXi5Sc38r1dQweO38qz3CwCK+cuU1mINPOROa2JR8H1bqPJyHGturxn
 Lyer9U5Lo8oFdPd6/jCwVeSKOaUWRuMnMVjez8XrVXz7sAKQlMkNFQoLxaz8daeE/8i+
 TCm9bJHU9CwHSvjKXcBenRGO8M1Dt1welVwHhZiFr3SsanPgDqjRohIK2U4LVxrUGybl
 v2Pxf2IpnZDoLZjv52OxB8cGRmui8PUHB2mNsQk84wY1qdtAFUFFWVLdofQnVCmUrxVj
 WI8Q==
X-Gm-Message-State: AOJu0YxxldSQ1JALyHalcH/L3TgXuNy9Ktsmwjm+zkatY7O2GfbpjXAo
 9UFeAq2I9zJ7Z0D8wAsAjt+Z7FGtvLO8Sj8uEgGERZi7gci7Yzrk8mNvZCA0UJac56Y=
X-Gm-Gg: ASbGncv1xrvcdmuqn5jA7x7mSw+ojIRq23nxNR0K2dwvyYVxisZMud+yxGAIjVEuGEP
 ZdBG4kRqT/VZqGwinmwQpCaI9E9tawe1ufSiOxq1KMROz1//ljB1nXAexF9hcj5zbw2l4lxHEJj
 DMywHDPR5sRbVYCg+VQJBblaLsYBQgBEpyQls+HaIIv6bOkDQB1kbyTZTcj74s8bMOtFZ5aVDa1
 XIi5di7pDQ80L1+Pwp/mss46mfxifHgF/y2RPMftD/psZ2mlOZK28Uwt1nT6iSNp8u442qB6UJe
 czkOVZbdTEvU3uU9mzUzQKyIDd2vd1ONY3CqNVA9O6LUuqlnW7hKg0uEQH+itBI3F2y45XVuHqu
 fJcXmxCRfUIEpfqaO+XeNUzTdBXoaOJsIWE+UDeXMcX9gxKSkiiw3jhYgp8Lg5ZnawCdfEs/6n0
 XGsS7c/VE9eQI9qKn+gA==
X-Google-Smtp-Source: AGHT+IElGSSo87y2vMKkczM5Eh4ZW283nLbnLljg54DqD05FvBjFD8OxW5NJ3kGYRP+f7P+CtipYHw==
X-Received: by 2002:a05:6000:22c9:b0:42b:2eb3:c910 with SMTP id
 ffacd0b85a97d-42cc1cd9466mr21316753f8f.3.1764189112506; 
 Wed, 26 Nov 2025 12:31:52 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cb7ec454csm40781600f8f.0.2025.11.26.12.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 12:31:52 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 26 Nov 2025 21:31:08 +0100
Subject: [PATCH 2/4] test: dm: Add compatible multimatch test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-topic-musb-probing-v2026-01-v1-2-ff8d8c487130@baylibre.com>
References: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
In-Reply-To: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2661; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4GVrBPElNgHZ+EB9C2l188FcTWbFJvRyOMdGRhih1Jk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkz15GVeVZ+N81NOvWUImrB4Y5ZZS/Bh763/utm4sk+uK
 1j5Nje0o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACaydhfDX6Hbdlv5wg/85tae
 Jt2yZH9ygKbIymbTlOCW01qsVxr1/jD8D+s7df3D6viw493PLTXWyukUK0qsv/fHpdty4aq9rYu
 38QEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 26 Nov 2025 23:50:13 +0100
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

