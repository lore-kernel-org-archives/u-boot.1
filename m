Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F4BCD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 05:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B913384683;
	Mon, 18 May 2026 07:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IHlGMwM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 007C284688; Mon, 18 May 2026 07:57:58 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6F6839D9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de
 [46.114.109.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 118A541795; 
 Mon, 18 May 2026 05:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779083875;
 bh=hHE00v2eyN70rDAqdfUddg4aqAHr8N8KYCgruEHMiSg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=IHlGMwM4tXmBk0al33ptMWbWHvuVShqaFjNV1PeBlfkSxpvxkbdc/jXTnGejqKgZe
 LNhODKWo8y6DOs6GU899yDuwPgHaz+pvpT4aMiubcbaTt4z7Bj7Crs+DzgLetb2tg2
 oOXalpaO4U1hl2dTq6egfbvekCJ9KFZV60TaaX9VlxFav+uhcmN3N+Vo4m3qBDUIAb
 yYoB/6rVXg/h00xjbuKWsVfnPXnb0hVLmGs4d2/CIDvRxKMRWGL240ZpW5mmmRgz14
 giR+VNtlskzIqOyp1obpY29Dl5k7uQAIC/a4VwiCAw/tEjISOoesiO5XdOANqPvGwl
 KOv0w0MB5e75hPkX8BbzPeSIoCo9LcrpsuUlscwIRE7oC6oc42nDYcHMOXt/m10GWY
 PSEaFnoQA15SsSIBcJrgBE6ixcKKZXVLZHC7wHsMBmn0VzDsjwHHBtXuxlOeDHjko0
 312SDlnfBg2H+2W7gFMFXSZeLBAFCeXIv3uUR1lRANkXPjiNQU8zu3Xt8L8QTKCQUD
 cSOczoDmAij8MTjJGPUmJ235wcPaL4Xw3gVZVPb/cKUvb6DwnZa/FiXfciLpKbVUk2
 Xvnoy+ae/kRZ5y46AiHO8A/tpw1QyvhxVDGqzE797SFgxOH3o5VGAJWNWynJBQUTTK
 E33A9/6tfHnurRs3dn+rzU1o=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 6/9] test: Probe RTC early in dm_test_host()
Date: Mon, 18 May 2026 07:57:25 +0200
Message-ID: <20260518055728.178507-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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

The ext4 driver probes and reads the RTC which allocates memory.

Ensure that the device is already probed and read once in dm_test_hook()
to avoid false positives.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/dm/host.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/test/dm/host.c b/test/dm/host.c
index f577377da6a..32a9818248a 100644
--- a/test/dm/host.c
+++ b/test/dm/host.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <fs.h>
 #include <os.h>
+#include <rtc.h>
 #include <sandbox_host.h>
 #include <asm/test.h>
 #include <dm/device-internal.h>
@@ -26,6 +27,18 @@ static int dm_test_host(struct unit_test_state *uts)
 	ulong mem_start;
 	loff_t actwrite;
 
+	/*
+	 * Probing and first read from the RTC allocates memory.
+	 * Do it before the measurement.
+	 */
+	if (CONFIG_IS_ENABLED(DM_RTC)) {
+		struct rtc_time tm;
+
+		uclass_first_device(UCLASS_RTC, &dev);
+		if (dev)
+			dm_rtc_get(dev, &tm);
+	}
+
 	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_HOST, &dev));
 	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_PARTITION, &part));
 
-- 
2.53.0

