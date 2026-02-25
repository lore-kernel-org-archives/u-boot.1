Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD03FD3773
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3944184119;
	Wed, 25 Feb 2026 17:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QVG23Wgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54F384127; Wed, 25 Feb 2026 17:22:10 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F96184194
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4833115090dso67263275e9.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1772036342; x=1772641142;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1HZgE5igLhgG1kbZ9E0XuxbdbhDf2N+jj2WjzZAc+g=;
 b=QVG23WgqLGMuY+NiM1W/Q6tWbOLxtpz/1TdT/BHFh4Fn/Ick1HN6AslYL78PdwFCZ+
 f69s+RwWvxZj5shDEr8JsypSe4/8/VnDqczZBDS8XNIJelOf/IEEGLJm4TLt0I/ZI39T
 xdMxmlJWPi4Tkq16rff5aVijrmrl1KUFYhcHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036342; x=1772641142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c1HZgE5igLhgG1kbZ9E0XuxbdbhDf2N+jj2WjzZAc+g=;
 b=hoIDDqrbCbE7f5csP265AaovxXkS7mmsYDuOTSEtDwyin2Ie3jKXkkm4s8JsI8FlvC
 Z82lcPUmoJ2VD5CriR4ZE6tWv09ybCzTBIQXo5xYaRLoFZbpiz65HhxRC5hr5QS7IQNo
 FYXh2dpMitseRT//uZHqc85SgOGWigZSAWLdvUk32Lg4FnIxgqJSuG+/eYpEnFukcqdB
 TbOMk7RfRohR64t+CYQifEHJmA4PxAi5U2d3HshQiFTjE2l6NpDIbEoTRj8V3md12/AP
 mYSjqKpKeyVY/NGkAh2AgbKGttQVzLuZK+Gka4oTWyLpEkwkacuFsvmBVLIFqi+8E8sb
 nPWQ==
X-Gm-Message-State: AOJu0Yz4hYL7oFacTD5ovuplyudFQFWA59iCc+kxeJc1l1S9BqC2BfCB
 6U8O2t+50Bah6T+jYly2yK06R3X8dHWenC3ksvoJsexcriC1LG73d3O57Dqlbds68Q5MWo9dEoh
 gW6/T
X-Gm-Gg: ATEYQzzpCCTAQj9hEYUNKh5BNZem9e5/NiHbvf60UtVbqEanmYRzmYy13BAlu5Pfjve
 mX9P0WsR0mBS6/hxZ4bRkSQTfD3x/kxhWsUtqUKEABA3aKLq/PXC0xGcW0Mi1Cb0oIo9CUmiSvJ
 UCS6elzyAuFf1vSPMRN0pAIE3jgmCV/hjL6L239o6+zwHhbwUoCWo6jywya2X1tO0QN1cgOYK88
 hPYsvYcGFeWNn5g0Dzaa1OaEXVG5/ZU00q+F45F/+29jkHXbPoV+iGudjyCXQ7DX5uACLyYtt/T
 T6BrhHADDLnTYig99/0mnZ+nIKW6/FFI3OKQCxlNJ57yarg2sKSM8XgXhZT52L1sIbkLdxZBvCM
 xdGrtir/FvoN1VLOueCQ8bvHOEj2E393UEdQMJfn54pdgfE6x3SGyekdfiEFY5/Vph96c41XsjY
 0a+wmbEBVLOF/b6mt2nDDLzJhX3UIUu+DfTXPozbMDdJdUV2bU1yp9QzNMfu8UEK8UZ4wifOPea
 Y+v/ehhgJcHmWFWrdF/F7ykjm7UBy22ToEwB6h9HVRN5I7e
X-Received: by 2002:a05:600c:45cc:b0:477:7a53:f493 with SMTP id
 5b1f17b1804b1-483a95f554amr271793225e9.23.1772036342463; 
 Wed, 25 Feb 2026 08:19:02 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm186562265e9.1.2026.02.25.08.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:19:01 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <simon.glass@canonical.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/9] test: dm: spi: add testcase for spi_set_wordlen()
Date: Wed, 25 Feb 2026 17:16:55 +0100
Message-ID: <20260225161851.2475274-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a unit test to verify that the SPI word length configuration is
correctly handled by the SPI uclass and successfully passed down to
the sandbox driver.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add Reviewed-by tag of Simon Glass

 test/dm/spi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/test/dm/spi.c b/test/dm/spi.c
index 249a9238fedc..a89ba06274fc 100644
--- a/test/dm/spi.c
+++ b/test/dm/spi.c
@@ -170,6 +170,22 @@ static int dm_test_spi_claim_bus(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_spi_claim_bus, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+static int dm_test_spi_set_wordlen(struct unit_test_state *uts)
+{
+	struct spi_slave *slave;
+	struct udevice *bus;
+	const int busnum = 0, cs = 0;
+
+	ut_assertok(spi_get_bus_and_cs(busnum, cs, &bus, &slave));
+	ut_assertok(spi_set_wordlen(slave, 8));
+	ut_asserteq(8, sandbox_spi_get_wordlen(slave->dev));
+	ut_assertok(spi_set_wordlen(slave, 9));
+	ut_asserteq(9, sandbox_spi_get_wordlen(slave->dev));
+
+	return 0;
+}
+DM_TEST(dm_test_spi_set_wordlen, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* Test that sandbox SPI works correctly */
 static int dm_test_spi_xfer(struct unit_test_state *uts)
 {
-- 
2.43.0

