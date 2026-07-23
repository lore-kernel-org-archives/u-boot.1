Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C170C531CC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 11:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDB1540888;
	Thu, 23 Jul 2026 11:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GjiSsLHbCiAa; Thu, 23 Jul 2026 11:13:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC27840889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784805209;
	bh=f4ovkd9/Q57yo4DHN/5MlyyloDWOb2R855fegTdRAxA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qDLZFSZNkN3waAP9kyITYYNn+EuDRdad80aVLAGl5U6TJ1I4lDcAbo6O4DmOVRnvc
	 6Qmnr++wFIwApzjkWpt7O1B/WcYj1q07q7yznDb0c8gSzh42P3Ra/lcs+bK48SPB3z
	 6GxJw0uNWtTaCQZz/Rnmzgn4NhLbGkgL5nOViq0y8O0ryjrc0XRppEHaC1olZ/7Ji/
	 yKiVpnfZnqsDwWvORGetjKWXC68eEsAGXVKAKxIm1TkgKppZyuVJwg8aQRBanNHciB
	 maL0n85Ppil4MrlxsHmWLQ31RvDC/asiX2X5FtdAnL5E0SBbrN1LOrJdARIjCSAyzk
	 Wh4zaV8fPk6vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC27840889;
	Thu, 23 Jul 2026 11:13:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69485786
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EBC740026
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IC0jIk--u0J7 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 11:13:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D0D3A403B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0D3A403B6
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0D3A403B6
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:13:24 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso2865435e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 04:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784805202; x=1785410002;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f4ovkd9/Q57yo4DHN/5MlyyloDWOb2R855fegTdRAxA=;
 b=aUmuJfauWt4j0KAIA2TUJ9LOmxM4GYDzuhrBbdb3iZx3t6tizcRzow+HzXiHcewrKG
 moVnudJBtgVaZ+9ZMHIM70/lt9vw1jUUKteAs3XFuIkb0DFMYs6Q6AlGlJpVtQPbUOGA
 ZKFOemX/cfP1vzw8vHNTEF+Gz9NF98ig/I9VXDV+NSeLPqbS37o07v5klzJ3MVg1wbG9
 bXuRYI8q+qjjBqWsrXXHCR11HwVktprsAD8Kc07AZE5puZVpc1H6+7Y/GOffW32zLhwZ
 OF2o4Rgdl7rD76zi+u7J+J76huVnziYdBH5JqQ1eUQ1CBi3g7lg9Vp0K8mTn9bx62cdV
 tW9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUyj1qTIz0jBhVNwvfPfpDU+QtPANiuFm2WyyHIo6m04eJhPOYLikQFwwmGjcTHU/3amgojFQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyByiMct6Hs9rb8kDyTUUIz+T37WnbI0Z/IjIdBJeTDESw9dZPN
 kX2a4E1mo6q2lavYlZI6MKUk5cfxwmbAp+d0UW8+CVFAVi31jfQZVYB6TvI7nwiyg1A=
X-Gm-Gg: AR+sD11o3HhOd9PFuoVgA4lr9/lzxAHeRtQ1cA8EY7VJMc+7u8Dem2DTr7QTtxb7KGJ
 KlOTgk0jEVcBHhqxS38WrS3oh9eUJqk/WWwnhAoXx5f8ZdJghI5ey7h9CYyRMH2iFFb//y9JX5E
 eI03ayIafdnFxBJ6ZLRGO8NuVlxru+Q3yvDd86MC2a7M1wXHBybEIWSo18OnamnDObADpmxdjY+
 cKKh7o4nv7Mf060M5WyfGke7KDv3iNKdmgvGajBG8E6wCoXJruVf5f2EoywLXAN1L5QyxedRj8E
 mguQciIr2bEsqdm3cwGR09U/Jd/gXG0TMHJg/0Ozdzvqepmp7B/wykqWRny51DyEzVGgqqeka8S
 kfBWrDyM32boZJcU1d56cmgNSOWYKxBzEAEiPo7B/JaG7pRcsNu506Dq+TBUeEwPipPWblRwiku
 9UbPNLUkxfQwkt5EImCykYq6+h6LotVCE7UAFjL40vXxPZZxOdYbEW94WjgLphFL6dBAg4jh3YO
 yN4vhBEfGCi39A=
X-Received: by 2002:a05:600d:8444:10b0:495:3e81:76fa with SMTP id
 5b1f17b1804b1-49573c9d45cmr21237815e9.15.1784805202001; 
 Thu, 23 Jul 2026 04:13:22 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-87-0-90-136.retail.telecomitalia.it. [87.0.90.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653731b2sm220010595e9.4.2026.07.23.04.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 04:13:21 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 23 Jul 2026 13:13:13 +0200
Subject: [PATCH] clk: mediatek: probe parent providers on demand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-ccaione-upstream-fix-clk-probe-v1-1-6091925d72f3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSwrCUAwAr1KyNlDT0odeRVykMWr8tI+8VoTSu
 xt1OTDMLFDUTQvsqwVcX1ZsHAK2mwrkysNF0U7BQDV1daIGRTgUxTmXyZWfeLY3yuOO2cdekVq
 mlLp2R4khItk1hN/gcPxzmfubyvStwrp+AOWqgKiCAAAA
X-Change-ID: 20260723-ccaione-upstream-fix-clk-probe-24a27764927a
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Sam Shih <sam.shih@mediatek.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784805202; x=1785410002;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f4ovkd9/Q57yo4DHN/5MlyyloDWOb2R855fegTdRAxA=;
 b=SXUQPbrMai/iEDACMA8CEiWkEUhlOwkLu6iQXBoaJJ/OxI6Nk7+snWE1r8zDWr8L/w
 bV+/bajQfqa4y6UlI68yAiqLjcZz637/C9xor0GfvT27lb5YI8Y0p8mjwjXDxZSL2o+0
 0FP4SrTV8fI5XdqQ2M8LdyVQjWrHzQFiATeDG7se5JN9dQmTESrVWsAcf+d22xv7eaLE
 qt6tPEjXSbGOpzIDlqW0mek3H8f4vTqOWppGIPx2ATv8YhlZ4FAhv88mJCcdhyOoZqYY
 LyiPbYC5bwrrwTvb2R4LLWAdqwQqcvTgbnPuVNcJPpzzwiqPil4kTm7NUF+OfZ7wa2/r
 RsXA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=SXUQPbrM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

MediaTek splits its clock controllers into separate DM devices
(apmixedsys, topckgen, infracfg), and a clock in one controller often
has its parent in another. Cross-controller parent lookup goes through a
small provider registry that each controller populates when it probes, so
a provider's registry entry only exists once that provider has probed.

Providers set DM_FLAG_PROBE_AFTER_BIND to be probed early, but that flag
only orders a device against its own bind; it does not guarantee that
every provider peer has been probed before an unrelated early consumer
requests a parent rate.

Concretely, in the SPL boot flow:

  1. The MMC device needs its clock and probes early.
  2. That probes topckgen, which registers itself as a provider.
  3. The MMC source is a topckgen mux whose parent is a PLL in apmixedsys.
  4. apmixedsys has not been probed yet, so its registry slot is NULL.
  5. The parent lookup returns -ENOENT and MMC is configured with an
     invalid source rate.

When a parent type is not registered yet, probe the MediaTek clock
drivers that declare the common provider bind callback. This preserves
the small provider registry while making parent lookup independent of
peer probe order.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 61d718f162d..3d37d190982 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -9,6 +9,7 @@
 #include <clk-uclass.h>
 #include <div64.h>
 #include <dm.h>
+#include <dm/device-internal.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -57,9 +58,35 @@ static enum mtk_clk_tree_type mtk_clk_tree_type_from_parent_flags(u16 flags)
 
 static struct udevice *mtk_clk_tree_get_provider(enum mtk_clk_tree_type type)
 {
+	struct uclass *uc;
+	struct udevice *dev;
+	int ret;
+
 	if (!mtk_clk_tree_type_is_provider(type))
 		return NULL;
 
+	if (!mtk_clk_providers[type]) {
+		ret = uclass_get(UCLASS_CLK, &uc);
+		if (ret)
+			return ERR_PTR(ret);
+
+		/*
+		 * An early consumer can be probed before all provider peers
+		 * marked for automatic probing have been visited.
+		 */
+		uclass_foreach_dev(dev, uc) {
+			if (dev->driver->bind != mtk_common_clk_parent_bind)
+				continue;
+
+			ret = device_probe(dev);
+			if (ret)
+				debug("Failed to probe clock device: %d\n", ret);
+
+			if (mtk_clk_providers[type])
+				break;
+		}
+	}
+
 	return mtk_clk_providers[type] ?: ERR_PTR(-ENOENT);
 }
 

---
base-commit: d0c49353a648e135f269a2953dc9326505ba87de
change-id: 20260723-ccaione-upstream-fix-clk-probe-24a27764927a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

