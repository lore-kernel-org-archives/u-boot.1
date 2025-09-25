Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5593ACAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0419832AD;
	Thu, 25 Sep 2025 22:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k8AjZxZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D96832AD; Thu, 25 Sep 2025 22:44:24 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE27D83447
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7a7c1ecd433so309771a34.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833060; x=1759437860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=La/hryGtUrgv648CQ6hgojEjxJ8d0GvTniOrEqA3aiw=;
 b=k8AjZxZQ3LDfkmc/rjfUm+EAY3EFTCi7cA5j3gVasrzRyhiuCB/k/8YBj20Xcp93xc
 DHZ7Ea3zMz6Cqu38r4DcIReLb20t133uHZc5S54nfFciraVHTMP0IBl0DMstQcJs+KdM
 EBLTAb2QYvlpOCvh7y3VDsscfIlIS3H667Fmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833060; x=1759437860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=La/hryGtUrgv648CQ6hgojEjxJ8d0GvTniOrEqA3aiw=;
 b=Pm4iRvbXcnEqQTUKKpOt8h/U67XCG+ghNlQkFdve9tjadAYx1N1dRybB2WImvZbfhG
 WmbRNPk9LoExvykbOerDxaj9MP+qgASzDf69lb0/uikipm7DqoQ9kRhSSXb3TX+JJsUe
 4X3Jz7N8hpPRdo5MhbrYIxW6d59826C/Tw4pZpmgqNC9oN4B6TNCd1z45E6NEH+tnsH4
 gTKEKz7b3p3gmj5sg0Uy9Kjp6ZdWo6li10uMI1Ti7mVxczBK22c8N51y2hFL22j0twW0
 Na8CUa8o18Mkklh77wWgPVeth0uu2MX/3H9omz1wxuxMR6cqPYrhdFLmYf7KIOA6kGlT
 bW6A==
X-Gm-Message-State: AOJu0YypK2cQpDo29rFS3pLCyR+t6m+pYyuzpMRNIhIRtmi9e2n38GRq
 RmyiLjJ1jaLFjG+hUvC0TfJmE3z5O+CJKOAh8HN/OnHenLjBw39sMX1kVq6a1As14zLgTXngD4Y
 /vOCZT1A=
X-Gm-Gg: ASbGnct70jzvNqjXqOh5V3Y9bEsSA3indySgvpFbW4Fbb4LELcsibtwkS6YQzb8OfYN
 okus3cPrNDpU5tcK1rj47upyqudgeBHL2iJb4HQYb+/iqtHu/LY0TOnQhiPpzWc+f7RiJbmz6BZ
 WM1+0Qj/LFepS270RdZKtP2mQmYVup14iJOIPa+tXBw2OYJDKCB6WLo73ia6CAlPjusxFxVFF34
 1ODe66KNZag1f7YndryGYzyOVgtHJXteyHuq4m6bz0U6EyeEv3SU1APnWvvWzQDV5or3ZwawGBB
 YXgGnsahTearqPe3wSZ7HogS+yH0rx5ALLgO3u9DuaK1JlFzAuNRh9R2jo80rTbveT2aDWhxW7H
 /t16HoETzU/8A3geXMxB/IU3UP6LcysQtSRZSrw2+jc5AwSusZXe/E7SeWq0=
X-Google-Smtp-Source: AGHT+IFOrMimqtQSywJ/6UAD8UXOAmA9CaWgKRJClD6dajh8wfrz43q8dFba7X/BKGilgZLCAQ+KnA==
X-Received: by 2002:a05:6830:4708:b0:78a:1d62:ff20 with SMTP id
 46e09a7af769-7a04a9ad907mr2823239a34.30.1758833060658; 
 Thu, 25 Sep 2025 13:44:20 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23193d01bsm605790a34.8.2025.09.25.13.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:44:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Subject: [PATCH 4/4] net: Tighten more driver dependencies
Date: Thu, 25 Sep 2025 14:44:14 -0600
Message-ID: <20250925204414.3561033-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925204414.3561033-1-trini@konsulko.com>
References: <20250925204414.3561033-1-trini@konsulko.com>
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

In this case, the mediatek network drivers cannot build outside of
ARCH_MEDIATEK or ARCH_MTMIPS, and so express this requirement in Kconfig
as well. In the case of DWC_ETH_XGMAC / DWC_ETH_XGMAC_SOCFPGA, the file
controlled by the DWC_ETH_XGMAC option references a socfpga-specific
array defined in the file controlled by DWC_ETH_XGMAC_SOCFPGA. Rework
these options in Kconfig to handle this dependency.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com> (reviewer:ARM MEDIATEK)
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
---
 drivers/net/Kconfig         | 5 +++--
 drivers/net/mtk_eth/Kconfig | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 7c13055d606c..b5857317ff8c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -179,7 +179,7 @@ config CALXEDA_XGMAC
 	  machines.
 
 config DWC_ETH_XGMAC
-        bool "Synopsys DWC Ethernet XGMAC device support"
+        bool
 	select PHYLIB
         help
           This driver supports the Synopsys Designware Ethernet XGMAC (10G
@@ -190,7 +190,8 @@ config DWC_ETH_XGMAC_SOCFPGA
 	bool "Synopsys DWC Ethernet XGMAC device support for SOCFPGA"
 	select REGMAP
 	select SYSCON
-	depends on ARCH_SOCFPGA && DWC_ETH_XGMAC
+	select DWC_ETH_XGMAC
+	depends on ARCH_SOCFPGA
 	default y if TARGET_SOCFPGA_AGILEX5
 	help
 	  The Synopsys Designware Ethernet XGMAC IP block with specific
diff --git a/drivers/net/mtk_eth/Kconfig b/drivers/net/mtk_eth/Kconfig
index e8cdf4082371..a2060b8bd01e 100644
--- a/drivers/net/mtk_eth/Kconfig
+++ b/drivers/net/mtk_eth/Kconfig
@@ -1,6 +1,7 @@
 
 config MEDIATEK_ETH
 	bool "MediaTek Ethernet GMAC Driver"
+	depends on ARCH_MEDIATEK || ARCH_MTMIPS
 	select PHYLIB
 	select DM_GPIO
 	select DM_RESET
-- 
2.43.0

