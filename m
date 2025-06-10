Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA90C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 05:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9DD382AE9;
	Tue, 10 Jun 2025 07:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="Br1OcdRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9906680E9A; Tue, 10 Jun 2025 07:39:24 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B022780E9A
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 07:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=+eXgT/IoMwV/x/yUd7kYhIUHELBKpeJBmZhLecN3A/8=;
 b=Br1OcdRXtoFK8F/m74Rd/XG5P4A9ABFYvd8skuzHM9U4SYE3EO7cCgbupIXSmTvTaVtxz4ApctK4Ew/dZOvPPjd+ABrUT6ONpXhgELY3OadFG9QLtSV5ujRVCJKUVAQMCL3XBTgpPKVN+AAfv7rPhtsF+UORF6KPzlyGTEcplpI=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPA
 ; Tue, 10 Jun 2025 07:39:19 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/2] sunxi: Add NetCube Systems Kumquat support and fix
 nvmem MAC handling
Date: Tue, 10 Jun 2025 07:38:53 +0200
Message-Id: <20250610053856.1873969-1-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
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

Changes in v2:
  - Renamed the defconfig to match "maker-model" style
  - Use the default env offset and size
  - Disable redundant env to have U-Boot and env fit into first MB of
    SPI-Flash
  - Remove unused config options (SPI_BOOT, CMD_RTC, SPI_FLASH_BAR,
    USB_ETHER_...)
  - Update mtdparts layout to reflect new environment layout

This series adds a defconfig for the NetCube Systems Kumquat and fixes
and issue with setup_environment ignoring the mac-address loaded using
nvmem-cells

Note: This series is based on U-Boot's `next` branch because it depends
on the `sun8i-v3s-netcube-kumquat.dts` device tree, which was recently
synced from upstream Linux and is not yet available in `master`.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
Lukas Schmid (2):
  sunxi: setup_environment: do not generate a MAC address when one is
    set using nvmem-cells
  configs: add support for NetCube Systems Kumquat

 board/sunxi/board.c               | 15 ++++++++++-
 configs/netcube_kumquat_defconfig | 45 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 configs/netcube_kumquat_defconfig

-- 
2.39.5


