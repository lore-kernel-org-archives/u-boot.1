Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D504C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C5488566;
	Mon, 10 Jun 2024 15:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="dAQblR6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 218878852A; Mon, 10 Jun 2024 15:34:17 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B30B88557
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026451; x=1720618451;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H8bvOPw2qRwpV7flqsosW/E04UghxQqp6ar/+aVaJS4=;
 b=dAQblR6H1DJxLaXb13wNOEdoRmSKq+NrP3ImoZAuZmq6cR554+tCzf9BZHiRkj6r
 uy9YyPO5Nz0IJKio6p9pmiou55KGWWwhSSBZP6XA5zUkfTRBgE9TBKpnvLacJmE7
 Qp/E4gXWgTumHBVGDnJvrbNqN2JDlSjZWkbeABRSRoQ=;
X-AuditID: ac14000a-03e52700000021bc-f0-666700d395df
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 29.7D.08636.3D007666;
 Mon, 10 Jun 2024 15:34:11 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:11 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 12/13] doc: board: phytec: phycore-am6: Use mtd commands
Date: Mon, 10 Jun 2024 15:33:51 +0200
Message-ID: <20240610133352.2473414-13-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWyRpKBR/cyQ3qawY7/IhYfGjezWUydtJnd
 4u3eTnaLd337mSy636k7sHq8OrCK3ePsnR2MHv3dLawefy6+Yw1gieKySUnNySxLLdK3S+DK
 +HW7m7XgJ19F673D7A2M83i6GDk5JARMJHb/amDsYuTiEBJYwiSxadtWKOcxo8SePcuZQKrY
 BNQl7mz4xgpiiwgESfRe+sQIYjMLeEhs/bsBLC4MZF9qmgJUz8HBIqAqMXG/DEiYV8BK4s/E
 X2wQy+QlZl76zg5icwLFf6zZC9YqJGApsejTGhaIekGJkzOfsECMl5do3jqbGcKWkDj44gUz
 RL28xItLy1lgZk4795oZwg6V2PplO9MERqFZSEbNQjJqFpJRCxiZVzEK5WYmZ6cWZWbrFWRU
 lqQm66WkbmIEBbwIA9cOxr45HocYmTgYDzFKcDArifAKZSSnCfGmJFZWpRblxxeV5qQWH2KU
 5mBREudd3RGcKiSQnliSmp2aWpBaBJNl4uCUamCM8ZhdszbyX4MZ1++syJaiyPvmsw25yvnd
 O4TWLHlecqE1OvXGotRDVxfE6sV+3/zwJOcpnxavcLVYj0v6T+fem1wj9OGc2e6w1DdX1Cyt
 jm6bXa+m0LJT+dOkloxmhay3zZPd/+zsn2cnznBR9C//C3/5J8zp2RfEC4+X5Hj8S7OpcTv6
 qkiJpTgj0VCLuag4EQA7jVDfZgIAAA==
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

Update Flash to SPI NOR chapter for use with mtd commands.
This is more convenient as we do not have to remember any
offsets in the SPI.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 doc/board/phytec/phycore-am62x.rst | 8 ++++----
 doc/board/phytec/phycore-am64x.rst | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index f8870657be0..a615d01474e 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -110,13 +110,13 @@ tiboot3.bin, tispl.bin and u-boot.img are stored on the uSD card.
 
 .. code-block:: bash
 
-  sf probe
+  mtd list
   fatload mmc 1 ${loadaddr} tiboot3.bin
-  sf update $loadaddr 0x0 $filesize
+  mtd write ospi.tiboot3 ${loadaddr} 0 ${filesize}
   fatload mmc 1 ${loadaddr} tispl.bin
-  sf update $loadaddr 0x80000 $filesize
+  mtd write ospi.tispl ${loadaddr} 0 ${filesize}
   fatload mmc 1 ${loadaddr} u-boot.img
-  sf update $loadaddr 0x280000 $filesize
+  mtd write ospi.u-boot ${loadaddr} 0 ${filesize}
 
 
 Boot Modes
diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
index a27ad01027b..189da179534 100644
--- a/doc/board/phytec/phycore-am64x.rst
+++ b/doc/board/phytec/phycore-am64x.rst
@@ -111,13 +111,13 @@ tiboot3.bin, tispl.bin and u-boot.img are stored on the uSD card.
 
 .. code-block:: bash
 
-  sf probe
+  mtd list
   fatload mmc 1 ${loadaddr} tiboot3.bin
-  sf update $loadaddr 0x0 $filesize
+  mtd write ospi.tiboot3 ${loadaddr} 0 ${filesize}
   fatload mmc 1 ${loadaddr} tispl.bin
-  sf update $loadaddr 0x80000 $filesize
+  mtd write ospi.tispl ${loadaddr} 0 ${filesize}
   fatload mmc 1 ${loadaddr} u-boot.img
-  sf update $loadaddr 0x280000 $filesize
+  mtd write ospi.u-boot ${loadaddr} 0 ${filesize}
 
 
 Boot Modes
-- 
2.34.1

