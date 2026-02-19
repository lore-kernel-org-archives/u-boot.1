Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE68AE9A057
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D68683DF3;
	Thu, 19 Feb 2026 18:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="olDn/XRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34DD183DCB; Thu, 19 Feb 2026 18:52:06 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BF3783CEE
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso14030785e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771523523; x=1772128323;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCHtgDZvfTFI4kdVn/tCFXNLzJyuLrLIYxBP/bv67wk=;
 b=olDn/XRnMh5Dcafc94NcxP0cOEd96EpuDmq+zv1KQp6JsZucMVdF7KNL2Za0N0/CpU
 fpdf1WhX/gfFEUiN/0Zxn7W6MBfEQDTcf4yt8aFRz6RbCepNaXZQwKcspSfHug5IdldI
 BCjtkMXM7rdkSPAeBGPn25Onftipryg/Wu810=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523523; x=1772128323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RCHtgDZvfTFI4kdVn/tCFXNLzJyuLrLIYxBP/bv67wk=;
 b=amxiiCLaIvgsN0xa8MkKDMWb0ulWLkrwjQrfpQGwFXF7xtUQac8s3cM2pqQO3BW1rs
 ABwtX8qYVbna4pq+c21yheo+z2m8LJesuYtlqlEwK+qMSjUW8GFcvCxVEsHGBHnagJ7G
 p1g55yyqxOirTOXZc0+h1gWBs/SEx1erDB1obP/5ZfadM1ys86A4Z4hGsk5YrKvJWDkl
 jFfFrgBXS0A3Ll10NDJAYVKNBtBW17gUQttjA2Dfrg77bWhL56sA3nLY7K/d2GATD0WW
 f7VHDfJFkT03W5k/xmqq3z99LotPx5cbwt5jCectQ99VbpCUlNhp0Ly8cl2tAnuv15Eb
 4jBA==
X-Gm-Message-State: AOJu0YwjFri8Cq35tQeksK/G3ak1NFX/PnOawhZUMStSg6hffIKiaaEl
 b5ajiNnsFuSnOoydBpdzdx7FOKIJmxMUGF/S/Ni4ZRzIRMbFI1xEhSaHbqrZiCLf42+5waPOivI
 arzqM
X-Gm-Gg: AZuq6aJ5P2Be8LzxsJ+zlNeiAVefSbdZllJO7jDT/BvPKGwKh2LcUj43yOZo0SmNzXe
 WdqSfRtWXsBaFV7o4h+K6T7e213oeeg4QWUeio19pm3bhpSIqoDV4NHU7CXuUkFsghqz0B67Vww
 jzEp+b2AUzH0XcvDjr0dEdjcCMZTkTreNUfLwBrRgd7fJXgCt7Ef973QINXit3Mh5nyQrvhxdkF
 cnSyBg8Sp9S+vXz4PGYLf0ASX2MUA6qZuvocwYciZbDjZuPyHlGiOlk+fQXOc1+JdIGiBXKQpxA
 xqd/m86nOctqQClJFQ9wdDUQWa36aN8Yon+DDcUx7BbhEzFn7ZT1rQppHdhBOOWmRy7xDx1RP+/
 YNtCu6u4aENGT4gifMxVE/+PPsIkAgIkbQ9ehC3B1yOsPFeB8Lq2Axju4v5uXcdELD4QqOIS9jL
 bHbyR6AzrmP0LEncn5eIknCEdpJ6e6OnkNgO4tRQ2qA+obmO7KGKfpD6nsgyxU1hzOgebAQFMrD
 jG/+v3hXzBx0Y7HXgaVl+U7gZMioPrRNBXiMPtcBwIDqzwZopsjvDO1vXQxUVDWcWxcBVrAEVET
 4UeGZ+eBFfKpBvM6gxqpzitZ
X-Received: by 2002:a05:600c:698c:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-48379b932b7mr339624495e9.3.1771523523473; 
 Thu, 19 Feb 2026 09:52:03 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm35485005e9.2.2026.02.19.09.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:52:03 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/8] test: dm: spi: add testcase for spi_set_wordlen()
Date: Thu, 19 Feb 2026 18:51:15 +0100
Message-ID: <20260219175130.2839234-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
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

