Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A86E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 23:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D175F88E78;
	Sat,  7 Dec 2024 00:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="oVkS0H+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC1F88E00; Sat,  7 Dec 2024 00:05:50 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 by phobos.denx.de (Postfix) with ESMTP id 34CB088D72
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 00:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1733526342;
 bh=d22WiQmm6xP9A9SSjfFus87LYErCxtAPlyV7pZnbA20=;
 h=From:To:CC:Subject:Date:From;
 b=oVkS0H+pbeY1BnU08RgXv9M21xyA8/38fT/lfeXyTYaPrm5EntQpfyPoF1a/Y9YCT
 Fv5U2GSTMnW0szQbolb1bfSvhd9qr3fDlWXwKevpxmvHUr79AEC3QmoEPgk/nrAn0S
 GdEsppCz7o5s7XnxWpaMa5bRTTN4tVPHyxjYt+spDTm4RTcA1UYgOGMe5e/9WrLUiv
 qC8j5NdwxCzNSOlrc2C1QNX+NGo1D09zSHTIKqLhMts7VvQcpMV0UTDt6p6Z/cQiLR
 /Bl1v4jCSJmQNEYg7dJ6QU6apEWVKdQoYStWvy4k5zKWHz3WFs+I/SU2QV/NehHKhS
 wmexP48mqsaRg==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, NXP i.MX U-Boot
 Team <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V6 0/4] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
Date: Sat, 7 Dec 2024 00:04:16 +0100
Message-ID: <20241206230420.54704-1-cniedermaier@dh-electronics.com>
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
  lib: hashtable: Prevent recursive calling of callback functions
  board: dhelectronics: Sync env variable dh_som_serial_number with SN

 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi         |   2 +
 board/dhelectronics/common/dh_common.c        | 166 +++++++++++++++++-
 board/dhelectronics/common/dh_common.h        |  79 ++++++++-
 board/dhelectronics/dh_imx6/dh_imx6.c         |   4 +-
 .../dh_imx8mp/imx8mp_dhcom_pdk2.c             |  75 +++++++-
 configs/dhsom.config                          |   1 +
 lib/hashtable.c                               |  27 ++-
 7 files changed, 341 insertions(+), 13 deletions(-)

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

