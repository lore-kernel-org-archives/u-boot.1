Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B419C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 15:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3525C80DF7;
	Sat, 25 Jan 2025 16:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UO5kBH5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99CA80EB5; Sat, 25 Jan 2025 16:27:59 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5628280C7E
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 16:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hackpascal@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so5644578a91.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737818875; x=1738423675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2btazznWkDTf1F6O574VwiCA72kFYe21np/gM+y5GsM=;
 b=UO5kBH5imuwR8j85TaXeNFyHb5fzqEdI/CQEzCdT4EiVbTpEGHa3fOj/y0vz113kOr
 5c3eyDGOnnXPmlTlYp5BHthjwuPUApJ3ESEcv1bXmTsz67mzkqWvmxZvKU8rVbXhhuS+
 UYEQb0sheFukjLb003URFtfk7FKboaacNkf7WRlxsKydyRNTiovptBTsZSxN02pWLIya
 MA8sCPWEvrC9elSG9biQu6GEWeBCZ5cBKIKEJVnzea5RFljcJvl1T1kf+rvnYgYgsqJh
 5Qg1EdShPfGgFdOfKp6p+9tq/9JCz7snxHy8dxTGBs+3iIUNwCqUSTrLTXVHM3tC6z0Y
 et5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818875; x=1738423675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2btazznWkDTf1F6O574VwiCA72kFYe21np/gM+y5GsM=;
 b=AUJ0AcwThRdjlyNLaKCVhn+no0m2aHtsJ2n8io5nxRWjfVIIbbzViLRRiyxFbRyotd
 qDeet9/EgNm6gXDPuUuQ7Ho15JmQs5SvSn1OVcP/Qp5boqKKqlWAoVm1sCycm+Z0xcsZ
 A9+wELlrEC5ws80ha9bIi70B4uIFY0KyNxgDExwpMda0zcrfBVT/6qIrMMhb4zp2EgvQ
 JJvd+IQjyjibSqr787UXvXs29lm5Kb5feFml0t+hM8j9+JMDJLB3ib1q3b/KhAae1vZY
 BvRYHQDYQ8n3GuhT7lNrRihVJ6i1aHEzFk5dqDIWPJj1dVTrMk6e48iSmChBaT+iDeQl
 ukow==
X-Gm-Message-State: AOJu0YwrDNt+SvScOf2yxd2boY8sWIn0Ok0B592GZgLBBP9xMfM8C6pa
 ZgrHUWAZY2SybMTuat1AuRDFYFOrTIWvOOahb3+DuuXCp6bXH6YVAXaG8so/BXY/Ow==
X-Gm-Gg: ASbGncupqge86avo57NuJS8EbVbPFYvYiC17R3nW7iopucielS4aYD2S7fGR/kYxGnU
 e/tCiNnImG0Aa8C6niUIpDCUwgyHDR0TnuEsm3Av8qe39wvK9xcTNPZQhTXSg/eByvpl26rljLr
 WNuNLJrP6CodWNES0ZuZavyJxmYLuQVGxtpyowhlxebUnXgeCZye7YRviNnYYQVZQzRfDyUC08Z
 Y2T13Y7c6WYVQehhRvaBif4ZUgVG9H5jjo+tVcZjDrJ+SBh2WAUmfO7+Fg8xcN90JteMuph30br
 Lt9EtOtYKVzp54vxnTE=
X-Google-Smtp-Source: AGHT+IEAq/ISl+sbUhMTeK8JbWf5ivj9xGBppthIUBJaEGp9bhmwn2igk9AActvDym5kguXynZm24A==
X-Received: by 2002:a17:90b:5206:b0:2f5:63a:44f9 with SMTP id
 98e67ed59e1d1-2f782d4f189mr43244517a91.23.1737818875427; 
 Sat, 25 Jan 2025 07:27:55 -0800 (PST)
Received: from localhost.localdomain ([171.213.131.18])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f80178e5a7sm3392912a91.2.2025.01.25.07.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 07:27:54 -0800 (PST)
From: Weijie Gao <hackpascal@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <hackpascal@gmail.com>
Subject: [PATCH] miiphy: define mii_devs with LIST_HEAD()
Date: Sat, 25 Jan 2025 23:26:32 +0800
Message-Id: <20250125152632.26665-1-hackpascal@gmail.com>
X-Mailer: git-send-email 2.34.1
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

When enabling net console and console multiplexing, a boot crash was
observed using mtk_eth driver with stdin/stdout set to "serial,nc"
in persistent environment:

> CPU:   MediaTek MT7981
> Model: OpenWrt One
> DRAM:  1 GiB
> Core:  35 devices, 15 uclasses, devicetree: separate
> spi-nand: spi_nand spi_nand@0: Winbond SPI NAND was found.
> spi-nand: spi_nand spi_nand@0: 128 MiB, block size: 128 KiB, page size: 2048, OOB size: 64
> Loading Environment from UBI... SF: Detected w25q128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
> mtd: partition "ubi" extends beyond the end of device "spi-nand0" -- size truncated to 0x7f00000
> Read 126976 bytes from volume ubootenv to 000000007f7bf0c0
> Read 126976 bytes from volume ubootenv2 to 000000007f7de100
> OK
> "Synchronous Abort" handler, esr 0x96000004, far 0xeafffffeea000018
> elr: 0000000041e63cd4 lr : 0000000041e1b844 (reloc)
> elr: 000000007ff9ecd4 lr : 000000007ff56844
> x0 : eafffffeea000018 x1 : 000000007fb552e0
> x2 : 00000000000000fe x3 : 0000000000000000

The cause is that "serial,nc" forced the console subsystem to
initialize the ethernet driver before ethernet subsystem
initialization (console_init_r() is called before initr_net()).

During the mtk_eth driver initialization, mdio_register() will be
called, and miiphy_get_dev_by_name() will then be called.

The miiphy_get_dev_by_name() will check the list "mii_devs" to see
if the passed device name exists. However the mii_devs is defined
without initialization:
> static struct list_head mii_devs;
and the actual initialization is done in the following chain:
initr_net -> eth_initialize -> eth_common_init -> miiphy_init
Since initr_net() hasn't be called, iterating over the mii_devs
will access to physical address 0 (mii_devs.next == NULL) and will
cause the crash.

The fix is to define mii_devs using:
> static LIST_HEAD(mii_devs);

As the "current_mii" is defined as a static variable, it will
always be NULL in board_r stage and initializing it will NULL is
unnecessary. So the entire miiphy_init() can be remove.

Signed-off-by: Weijie Gao <hackpascal@gmail.com>
---
 common/miiphyutil.c | 12 +-----------
 include/miiphy.h    |  2 --
 net/eth_common.c    |  5 -----
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/common/miiphyutil.c b/common/miiphyutil.c
index 9b8744e5d8..6169ea884a 100644
--- a/common/miiphyutil.c
+++ b/common/miiphyutil.c
@@ -30,7 +30,7 @@
 #define debug(fmt, args...)
 #endif /* MII_DEBUG */
 
-static struct list_head mii_devs;
+static LIST_HEAD(mii_devs);
 static struct mii_dev *current_mii;
 
 /*
@@ -55,16 +55,6 @@ struct mii_dev *miiphy_get_dev_by_name(const char *devname)
 	return NULL;
 }
 
-/*****************************************************************************
- *
- * Initialize global data. Need to be called before any other miiphy routine.
- */
-void miiphy_init(void)
-{
-	INIT_LIST_HEAD(&mii_devs);
-	current_mii = NULL;
-}
-
 struct mii_dev *mdio_alloc(void)
 {
 	struct mii_dev *bus;
diff --git a/include/miiphy.h b/include/miiphy.h
index 5abffd8fb6..8e4b58c734 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -33,8 +33,6 @@ int miiphy_is_1000base_x(const char *devname, unsigned char addr);
 int miiphy_link(const char *devname, unsigned char addr);
 #endif
 
-void miiphy_init(void);
-
 int miiphy_set_current_dev(const char *devname);
 const char *miiphy_get_current_dev(void);
 struct mii_dev *mdio_get_current_dev(void);
diff --git a/net/eth_common.c b/net/eth_common.c
index 89b5bb3718..ba57d836b0 100644
--- a/net/eth_common.c
+++ b/net/eth_common.c
@@ -31,11 +31,6 @@ int eth_env_set_enetaddr_by_index(const char *base_name, int index,
 void eth_common_init(void)
 {
 	bootstage_mark(BOOTSTAGE_ID_NET_ETH_START);
-#if CONFIG_IS_ENABLED(ETH)
-#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) || defined(CONFIG_PHYLIB)
-	miiphy_init();
-#endif
-#endif
 }
 
 int eth_mac_skip(int index)
-- 
2.34.1

