Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1194DD7833A
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 17:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F1688D3A;
	Mon,  2 Dec 2024 18:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="FZsJN880";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3746A89377; Mon,  2 Dec 2024 18:31:22 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id 8146789378
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 18:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1733160672;
 bh=qN6fYxtz2uwh3hBv3iDqWrZcSY3Raog0FpLJjjSFuCY=;
 h=From:To:CC:Subject:Date:From;
 b=FZsJN880E4SVOjLd1pw7UYm8a5xIbpsE2wQ+CGYO5GA5fUZa9jpaXmqDdlXVAht7n
 lVNahQBZbDmJVCU0zc8VF/aHmh8TLCx1B+5xELSXmPYUr9CAX8SUhJMzwACJIc8QXk
 2HbAMyOT65xt1EMphbMC1fFyYGQq6DmrN/IeEsAG4SAvj6QKrRTJ3NN7E1VIJ4+Iym
 kwmdiTlMMvvXoFYwN3nz4WQ5JqDMd0kIHHeYM7p35YsaQstMwkLHIyUMFWSe/FdOim
 7Uy73ICHcd+MsAscLw6ejfXCsVE0Zp9mhsxhpjt0gS0XcnFXOiRWMrI6hrGP3+TrZD
 Rsrnof2psEaBA==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, NXP i.MX U-Boot
 Team <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V5 0/4] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
Date: Mon, 2 Dec 2024 18:29:46 +0100
Message-ID: <20241202172950.35460-1-cniedermaier@dh-electronics.com>
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
 .../dh_imx8mp/imx8mp_dhcom_pdk2.c             |  75 +++++++-
 configs/dhsom.config                          |   1 +
 lib/hashtable.c                               |  27 ++-
 6 files changed, 339 insertions(+), 11 deletions(-)

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

