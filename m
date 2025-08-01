Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E36C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 12:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6BF883AB5;
	Fri,  1 Aug 2025 14:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="bL0pf6is";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A9983A89; Fri,  1 Aug 2025 14:39:30 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67EC83A47
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 14:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=301ae58c2=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1754051968; x=1785587968;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gOlnQCvjLwKOxWkSE0AuDpMgBqm0PlhEJXa3dHKT5o0=;
 b=bL0pf6isCLy1T48F4840dEiqF4NJ/7zpAHaUEy8zHfTCIJ847QtTYZk9
 80Y9VmoVhUtWkhttRTCp4eVX8qLEByx+FWoCwG19SiPisTTDzeWBiYanx
 f60qjH/3CTGxo/57ScWeCt5n+WKJ9MrvuKjuFCuwN38ZOrI9q7mGu1IJM
 k6INWyINlRTF/G8Cqw94mHSmclwrtOBbbal1QdGGj9LI3Rocq7LZZQUWc
 u7Wq4Fe1xymKrDe8R2uFKXjg7hJmxmAkS/ZgJk12ZSLWP2lQO5tJAa27s
 XvDiXh0zLHJFpMvX95sz9RKoWyLrHPJ7WDtiA4Xgjyf5Bkp+eDGQEd2n/ Q==;
X-CSE-ConnectionGUID: shIRiUSSTtOu5z34fSbi5g==
X-CSE-MsgGUID: MI9HE0LQQ8imi/4lWFt77w==
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="212121937"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Aug 2025 05:33:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 1 Aug 2025 05:33:00 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 1 Aug 2025 05:32:59 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 5/6] board: microchip: mpfs_icicle: enable new driver configs
Date: Fri, 1 Aug 2025 13:36:25 +0100
Message-ID: <20250801123626.1972658-6-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
References: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 01 Aug 2025 14:41:57 +0200
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

Enable the MPFS mailbox and system controller drivers for use with the
Icicle kit. These functions are crucial for the board setup functions
that run in the Icicle board file - mpfs_icicle.c.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 board/microchip/mpfs_icicle/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/microchip/mpfs_icicle/Kconfig b/board/microchip/mpfs_icicle/Kconfig
index 6e8c479e955..760dffc488b 100644
--- a/board/microchip/mpfs_icicle/Kconfig
+++ b/board/microchip/mpfs_icicle/Kconfig
@@ -59,5 +59,9 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply MTD_SPI_NAND
 	imply CMD_MTD
 	imply CMD_MTDPARTS
+	imply DM_MAILBOX
+	imply MPFS_MBOX
+	imply MISC
+	imply MPFS_SYSCONTROLLER
 
 endif
-- 
2.43.0

