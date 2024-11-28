Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86493D69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1FB89D03;
	Thu, 28 Nov 2024 15:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="L6BOpBoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4F689D05; Thu, 28 Nov 2024 15:22:19 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 by phobos.denx.de (Postfix) with ESMTP id CF39289CF9
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732803730;
 bh=6Qq5jzXgoRkMEdnwNV4nZaIzT5XHffleUQoy249x0WU=;
 h=From:To:CC:Subject:Date:From;
 b=L6BOpBoN5oSfd4MTVJQ88U9pNFpdUEreAyoBQxFI+AX1UmplFgb1QTOgD1AjQeT/b
 JxXXzeL+MsBEKS1BMz/CuGfZJAyNPNTPWJOdzLGY8FqDXzapHghQF4Z0+JKTzu0foT
 qRvJKMyx73VyC0LHqNCc1wdJWhhtHTBfB1WJyA8FDiOMGl84RPnt35pjGLeIi1ghq9
 toTndHhJQAR6naM73X3VeOlRJEDGyDtjO8iPEB08w6HNOBLZ03v0SuQYmMm4zqJb96
 +7Jz2U7lPb1j1m34GVxt41F0WT2fe6/Vd0TSaQvugKkSQP4/Ta1T+D7Rkxz1TKQ6er
 aecZIdCSRakuA==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, NXP i.MX U-Boot
 Team <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V4 0/4] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
Date: Thu, 28 Nov 2024 15:20:16 +0100
Message-ID: <20241128142020.35386-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
that contains an additional write-lockable page called ID page, which
is populated with a structure containing ethernet MAC addresses, DH
item number and DH serial number.

This patch series prepare the device tree of the DHCOM i.MX8MP for
reading the EEPROM ID page. Add the reading of the content and set the
correspondent environment variable. It also synchronize two serial
number environment variable via callback functions and fixing recursive
calling of them.

To ensure that the environment callback functions work, this patch
series depends on patch [1].

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241120160135.28262-1-cniedermaier@dh-electronics.com/

Christoph Niedermaier (4):
  arm64: dts: imx8mp: Add aliases for the access to the EEPROM ID page
    node
  arm64: imx8mp: Read values from M24C32-D write-lockable page on DHCOM
    i.MX8MP
  board: dhelectronics: Sync env variable dh_som_serial_number with SN
  lib: hashtable: Prevent recursive calling of callback functions

 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi         |   2 +
 board/dhelectronics/common/dh_common.c        | 165 +++++++++++++++++-
 board/dhelectronics/common/dh_common.h        |  79 ++++++++-
 .../dh_imx8mp/imx8mp_dhcom_pdk2.c             |  75 +++++++-
 configs/dhsom.config                          |   1 +
 lib/hashtable.c                               |  27 ++-
 6 files changed, 338 insertions(+), 11 deletions(-)

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
-- 
2.30.2

