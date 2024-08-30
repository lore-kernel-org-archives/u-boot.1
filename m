Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277E3CA0EF9
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82ACF88D92;
	Fri, 30 Aug 2024 11:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RjrCdbMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC57488D8B; Fri, 30 Aug 2024 11:10:09 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF90D88D8F
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009007; x=1727601007;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l+BKzI2OaaB5rBL/cjFGssmNt+qHCATZecWK6IKSsXQ=;
 b=RjrCdbMrZ2dPPPRtBwSaRPOw7p/kqI+VbOeGcrDB9tHDuK2FoxbiBKZTgrduRf7L
 7/fi3vAPSGE3Kk0XzoZEDu/STVon7Ye/qjSbM74Q+5m4dmYRVXuRnsEgmlO7hmmn
 9EtT7bsL2fTma54kaxJi7XEhWFjhFCpZbXdhryETsmc=;
X-AuditID: ac14000a-03e52700000021bc-2a-66d18c6f2f83
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 0C.42.08636.F6C81D66;
 Fri, 30 Aug 2024 11:10:07 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:10:06 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 07/13] board: phytec: phycore_am64x: Add Network/SPI Boot
Date: Fri, 30 Aug 2024 02:09:34 -0700
Message-ID: <20240830090940.2592157-8-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRpKBRze/52Kawa+LBhafdj5mtZg6aTO7
 xdu9newW3e/UHVg8Xh1Yxe5x9s4ORo/+7hZWj+tntjMFsERx2aSk5mSWpRbp2yVwZSx4OZ29
 YCtHxcl9P9gaGOexdzFyckgImEi8btvJBmILCSxhkljUndvFyAVk32eU6N97lxkkwSagJXFn
 y1wwW0QgSWLXk2VgDcwCLhKLb3xgBbGFBTwlrs/5DBZnEVCVeLtzMVg9r4CVxLrJm1khlslL
 zLz0HWwxp4C1xOavD9ghFltJHJ92jg2iXlDi5MwnLBDz5SWat85mhrAlJA6+eMEMUa8gMXvb
 ZEaYmdPOvWaGsEMljmxazTSBUWgWklGzkIyahWTUAkbmVYxCuZnJ2alFmdl6BRmVJanJeimp
 mxhBYS7CwLWDsW+OxyFGJg7GQ4wSHMxKIrwnjp9NE+JNSaysSi3Kjy8qzUktPsQozcGiJM67
 uiM4VUggPbEkNTs1tSC1CCbLxMEp1cBoKC3fzl+6Y9Wqg75LUt/6s34J4ZezzHpwovb9/OCj
 dYfffSk5+PuLU0eF+r5zehzR73s/Kih1lu7/dlvwjrLqfB5Ov7vHvVZ09jsGzjr1o3W+W5qn
 2doNukkcIf0VreckX6zSUHtX+qzn3Q2VDM+HEebWup5a7EV985+9KIvp2XaU7cr5yo1KLMUZ
 iYZazEXFiQBWJaTlYQIAAA==
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

Include the boot logic to boot via Network or from a OSPI/QSPI
NOR flash. Moreover, set all required variables to both boot
methods to the environment.

Note: The phyBOARD-Electra AM64x is not able to load the U-Boot
via Network. However, it's still possible to load the kernel.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am64x/phycore_am64x.env | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index 18f0fa5b4c3..3032b518e0b 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -1,4 +1,6 @@
 #include <env/phytec/k3_mmc.env>
+#include <env/phytec/k3_net.env>
+#include <env/phytec/k3_spi.env>
 
 fdtaddr=0x88000000
 loadaddr=0x82000000
@@ -14,3 +16,9 @@ mmcroot=2
 mmcpart=1
 console=ttyS2,115200n8
 earlycon=ns16550a,mmio32,0x02800000
+
+get_cmd=tftp
+
+spi_fdt_addr=0x700000
+spi_image_addr=0x800000
+spi_ramdisk_addr=0x1e00000
-- 
2.25.1

