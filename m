Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB54C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 17:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A708304A;
	Sun, 20 Jul 2025 19:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="G7Y+pHKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B6783045; Sun, 20 Jul 2025 19:00:57 +0200 (CEST)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA6D83010
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 19:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1753030855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwpEDocfz4q30gj2FbAdY5nmqprb57HsFRosKgSSf/k=;
 b=G7Y+pHKSrFFBQIA/L7Twh+zxDnSsiDdHipa8qPSEMJJPc537cZBFr8E98jZnpeXyVURF3G
 ivkIw1UkIVSkE3mapVnnv6mzaT0It8hJE2wvxJmGnLeWZXrsuO/oZ9BoAaHW4ANNlV/KOS
 w9gR9hdJfxaf1dP6lYs697AXbnFEvdY=
From: Henrik Grimler <henrik@grimler.se>
Date: Sun, 20 Jul 2025 19:00:26 +0200
Subject: [PATCH 1/3] mmc: s5p_sdhci: remove duplicated card detect code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-samsung-mmc-fixes-v1-1-cb705abfa594@grimler.se>
References: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
In-Reply-To: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 u-boot@lists.denx.de, Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=henrik@grimler.se;
 h=from:subject:message-id; bh=F7TRdR7UDHYqBDNqPRlP+A+3JBqZkgzTAjTKzHeLqtM=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBofSC7IJQBZn02bAQfXouzPcE8G3XoxEyGkErNI
 YZnlBfvNYqJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaH0guwAKCRCwB25JC3Fh
 a7N5B/9m8ms18qgdLkqbpFcz4eUedHF6OlJvXVE/G8JxjY3FUHbBnS7tpcIqpSCJGjXzANBJw+I
 AAThZMUXxgeEz/UfsqOwayKCIZltEG1JA6SG1FrnbIMgKSsWxCIVuuoDoWLyA0GcXfi1Z86ND5p
 FTgdrDz6LSJI9S0Og6/XLTEJk9Zlm4stsnKlqfe8heb3GrAGQfc64FrXiJUmClJQ5sVE1zNvQqg
 XNGYabPQSIwx6GWYPvFm4+94sKRowhGoUNe2ADnjOz9qeZn52262Bc4SCOvHy4PXLwbwzrBO0uZ
 62GnLHHLHO4aN7ZbQq0OkLgi2WmBmUFONd1lBvCiwbRUcfBi
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

The common sdhci infrastructure is already parsing the cd-gpios
property, since commit 451931ea7002 ("mmc: sdhci: Read cd-gpio from
devicetree"). The s5p code is therefore duplicated, and also broken
since it assumes that the GPIO value is inverted, while the sdhci code
correctly follows the ACTIVE_LOW/ACTIVE_HIGH flag specified in the
device tree.

This fix was originally authored by Simon Shields:
https://github.com/fourkbomb/u-boot/commit/2eac9dea7903

The change has been tested on exynos4210-i9100, a device similar to
exynos4210-trats.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 drivers/mmc/s5p_sdhci.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mmc/s5p_sdhci.c b/drivers/mmc/s5p_sdhci.c
index 278019f02abbe7ee7f16c48758af3b48449ec078..b2faecefc00f479f53c2c6156da66a8fe46e4529 100644
--- a/drivers/mmc/s5p_sdhci.c
+++ b/drivers/mmc/s5p_sdhci.c
@@ -141,14 +141,6 @@ static int do_sdhci_init(struct sdhci_host *host)
 		}
 	}
 
-	if (dm_gpio_is_valid(&host->cd_gpio)) {
-		ret = dm_gpio_get_value(&host->cd_gpio);
-		if (ret) {
-			debug("no SD card detected (%d)\n", ret);
-			return -ENODEV;
-		}
-	}
-
 	return s5p_sdhci_core_init(host);
 }
 
@@ -183,8 +175,6 @@ static int sdhci_get_config(const void *blob, int node, struct sdhci_host *host)
 
 	gpio_request_by_name_nodev(offset_to_ofnode(node), "pwr-gpios", 0,
 				   &host->pwr_gpio, GPIOD_IS_OUT);
-	gpio_request_by_name_nodev(offset_to_ofnode(node), "cd-gpios", 0,
-				   &host->cd_gpio, GPIOD_IS_IN);
 
 	return 0;
 }

-- 
2.50.1

