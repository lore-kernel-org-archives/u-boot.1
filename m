Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91957C54E58
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 02:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6929587E89;
	Tue, 26 Mar 2024 03:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="1c4jMPK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0873287E89; Tue, 26 Mar 2024 03:25:35 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D00A987F17
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 03:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-609fd5fbe50so56456197b3.0
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 19:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1711419929; x=1712024729;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8iJ889ASKNIcx2vrtOLD1iJWwCdRMHCTAyJlcNDfEow=;
 b=1c4jMPK7k1po6S1fwir1PTop4FKu5GUgdXaa/3XUYEO1SNL7PzIYxGZ4CMcNGf1b0C
 bcTOofptDb4LHzuaP4HPeU+rzB9O7ipIv2/ZhMR1BFtMMrRFbzmyT+x0/Hyr3fhCWwh3
 vSIoxeQ1Wk0kn3aNpC+iqtk4C8CEx/XDuer1WsUcbinBFSukVUoggmrVQ2grpAhhykDm
 pq7j0Z2IXNe+XHL55KdKetGwz5QMTqwNggAxVRbqp0GmLSxSk3EXxScGlPR53zW9Bred
 PPOetLCvAK+uZJDiSOFidbaP4q0PA/0wkJ2HmrVxPqG+qKtCUwPXoPO3YMsOMePCC5P7
 cstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711419929; x=1712024729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8iJ889ASKNIcx2vrtOLD1iJWwCdRMHCTAyJlcNDfEow=;
 b=P5ku7iKiy08IyqBpJFQ/XHdyQrrQnbt/Hh6pSQbYmJoSUMvINKAb5qJC4h3QHrMxIn
 38LxqAFBpSLmdrbDMz8RlITj47WSlyWPIPRNXkpkq1iqu3K+1LGlpwHcWIVTVwVR/0/J
 bzouu4vyOXuf163WPdjcoo3nCqqMxZ5iiKtn2etdblQubGplOI1uQWTHkXXWubCvNBWY
 NlwYvJoHQX1lcPU4oFeeKyGfPynLcc3u6TCC/lTk17kUo7I4+P0Akw3uYLbjLLW7NhrE
 CPuwODRWJH7LXilctu15/3Qd6YH0oY/6uIwLaTy92WPOXNVv2UCXqNQ5XMjxvIWHypCg
 jcVw==
X-Gm-Message-State: AOJu0Yy0+u5Mb8rfqNxxPfxpcY+ofqbVX1QbMCg9eq9E/maKvDOd1eKH
 H0TPaWEc12kYK8ITnw22Qw5rWv97TwsxDwm8WrhzWI4b6tuTJ+ww48y05DQYjwrHqlus3nyjx4c
 =
X-Google-Smtp-Source: AGHT+IFD7COWHrM41ZMafI1Ybd2wcF1YvxH4RWkhB6LkqsW8ZQFXIkolhMjbreywwxzoedjxeff6Ag==
X-Received: by 2002:a81:71c4:0:b0:60a:5716:8a02 with SMTP id
 m187-20020a8171c4000000b0060a57168a02mr1608506ywc.12.1711419929549; 
 Mon, 25 Mar 2024 19:25:29 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 j188-20020a0dc7c5000000b0060a03c196cdsm1267095ywd.63.2024.03.25.19.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 19:25:29 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sean Anderson <sean.anderson@seco.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: sdhci: Fix potential ADMA descriptor table overflow
Date: Mon, 25 Mar 2024 22:22:37 -0400
Message-ID: <20240326022325.1785-1-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
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

From: Ian Roberts <ian.roberts@timesys.com>

Change ADMA_TABLE_NO_ENTRIES to round the division up to fully
contain CONFIG_SYS_MMC_MAX_BLK_COUNT, fixing potential buffer overflow
of the ADMA descriptor table.

sdhci_prepare_adma_table() expecitily states it does _not_ check for
overflow as the descriptor table size is dependent on
CONFIG_SYS_MMC_MAX_BLK_COUNT. However, the ADMA_TABLE_NO_ENTRIES
calculation does not round up the divison, so with the current u-boot
 defaults:
max_mmc_transfer = (CONFIG_SYS_MMC_MAX_BLK_COUNT * MMC_MAX_BLOCK_LEN) =
65535 * 512 = 33553920 bytes.
ADMA_TABLE_NO_ENTRIES = max_mmc_transfer / ADMA_MAX_LEN =
33553920 / 65532, which does not divide cleanly.
actual_max_transfer = ADMA_TABLE_NO_ENTRIES * ADMA_MAX_LEN = 512 *
65532 = 33552384, which is smaller than max_mmc_transfer.
This can cause sdhci_prepare_adma_table() to write one extra
descriptor, overflowing the table when a transaction larger than
actual_max_transfer is issued.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>

---


---
 include/sdhci.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/sdhci.h b/include/sdhci.h
index a1b74e3bd7..fbc0f0391c 100644
--- a/include/sdhci.h
+++ b/include/sdhci.h
@@ -11,6 +11,7 @@
 
 #include <linux/bitops.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <asm/io.h>
 #include <mmc.h>
 #include <asm/gpio.h>
@@ -299,8 +300,8 @@ struct sdhci_ops {
 #else
 #define ADMA_DESC_LEN	8
 #endif
-#define ADMA_TABLE_NO_ENTRIES (CONFIG_SYS_MMC_MAX_BLK_COUNT * \
-			       MMC_MAX_BLOCK_LEN) / ADMA_MAX_LEN
+#define ADMA_TABLE_NO_ENTRIES DIV_ROUND_UP(CONFIG_SYS_MMC_MAX_BLK_COUNT * \
+			      MMC_MAX_BLOCK_LEN, ADMA_MAX_LEN)
 
 #define ADMA_TABLE_SZ (ADMA_TABLE_NO_ENTRIES * ADMA_DESC_LEN)
 
-- 
2.43.2

