Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5141AC61DDE
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 09:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C2DE83DCB;
	Sat, 21 Feb 2026 10:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SR2k81vH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36FA383E61; Sat, 21 Feb 2026 10:43:06 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529F683D0F
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 10:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48374014a77so29355535e9.3
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 01:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771666983; x=1772271783;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/L2uEpNTbQuctgMgYus4x+1Tt+OICDGut2oOlePUus=;
 b=SR2k81vHcQGrb3hnBnBFro0jtnpesdsEUMRWJZZ0qsmP2S6YahgbLLXp7H6sxWYllK
 Cdyj10GAWf2RBUMVGmcg0HQl1lNJa11ukWuD26j+QnW9FB1AlctR4L1EJWyr7C25mC6h
 UgYQ1joB6mt40XcXdXRXl7aUoFVBaaBdbIoO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771666983; x=1772271783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c/L2uEpNTbQuctgMgYus4x+1Tt+OICDGut2oOlePUus=;
 b=Pf7hEbTV0BNGnLGnFfDv4cxbrUIeTivkYQ19gvk6jSGI6j2a1gv+iiwxlv6B7MEOR2
 GY4u5cgnW1seeNWrkaMR+mFwzpiWi1eXSl3k95xa564OsGGPfwiS1D8z/2OiQZcclytQ
 LLHoczoEvSHh+C4PPhazi8Fc5lgd0XcWthXp+LqSWPkM6ui0dVTk9R+yTEB08wbnKzA5
 K201aS/bMmsFKMO7urbL+3MiwxfmuMm2zuc3eYF35eY8hK+GL3X7kSk5MXkA54fSmTSQ
 QPlkPxddFhP/w03XaFP6Bf9Ca+Djvn5GNgli+BVCp929Cgf+aiXxgQw5fpGr66tnbknA
 Q6LA==
X-Gm-Message-State: AOJu0YxVCAbpKuGgJea3bWtdLm92o3GrSeyNWgBN8bxuVAsUC7CZ7Rqf
 CEZ0u2ZaWj6j0m7zVqbqNMlEsWL1XFVHowFU27TIi1q5N4szYWExJeJbPWrv2dz4A6jHdD6yPAg
 AhnSf
X-Gm-Gg: AZuq6aKPFMc76bHC3MBRZMc6LDbS2WfeOWLx2uF44ahh9N9swBjZqOpDLXo/QnTacIJ
 lNzTHu90WlqTUl/Qu2EB9mERfBNfbf+HOg/eTtwFX3ny+ZjeeDU5lTLHCzw+fYHIvXLs54QR+/1
 50gaMrOFVaX4edPm8waPullgF2QLwMERDvZbVyoeFDOU3t9Pr3fF4RuVud9D+wXM2gopkAxw9ue
 1C9XXX4v1avQBRBAvusRpCw9BAcosmaqge5hPqq0vvXpTjQBr7Syk4GyFIhoVPyzRMY0/bHVHwU
 6lrh7YFxQNzO3uZxEm1W2DzPJCdjV9PQSlqExCKG3yAynn7DeSg1xFIBSTFNI5ndJYSlqwYnt5A
 223tN2ShhxXL1etuOq10ASbJ3Y+Md0S4ne8KzZa20HIdZkwKbIJkaFKkMnF2QQD60Gdrn7PDZfc
 T2yfSXDSYWqLBvx/b+ET4EIcomSeo1TbfILX7qMOPUsNFP853ppoAC3bQy3+JwbyvnCbs2vaNpE
 sQoHZwrxmvQt0NgPOIDfLIC5r9j1fRTLgCQ1OqK8VUDpon2TZ6OSzuxxJocnXwE8Lfvc/scKbLv
 wOlXpxYUGqKjghFQQaeUhMc8
X-Received: by 2002:a05:600c:470f:b0:482:eec4:758 with SMTP id
 5b1f17b1804b1-483a95eaa50mr31280085e9.26.1771666983310; 
 Sat, 21 Feb 2026 01:43:03 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42f3968sm42694225e9.19.2026.02.21.01.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 01:43:02 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/8] test: dm: spi: add testcase for spi_set_wordlen()
Date: Sat, 21 Feb 2026 10:42:18 +0100
Message-ID: <20260221094252.3103034-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
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
---

(no changes since v1)

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

