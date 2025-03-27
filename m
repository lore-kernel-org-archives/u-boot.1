Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4626EC3600B
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 02:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 483848144A;
	Fri, 28 Mar 2025 03:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="XznV9uo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5094C806FC; Thu, 27 Mar 2025 15:39:33 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 by phobos.denx.de (Postfix) with ESMTP id CDFFA8003E
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pzimmermann@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1743086360;
 bh=Gz+f8ldq07zPClYOyakbS/3I33vNC19DZ5Q6s3+jUyg=;
 h=From:To:CC:Subject:Date:From;
 b=XznV9uo6gleD2E+psiOaajFbKjRUKBFeIvsnIVWVj6lrSf3nns8bqrAULgeHggD4w
 0adSU06nz89kxRWAvd9Xor3++jOr+tvw/73BTJ+997XHz2kcDb0v68SIYmFyTcGdkE
 ANUWtx1e6uAJDryvqb1vHliL+gJXxxzMN3QuURnH/NDXEGBHB2TqCYArXjZlUvYjUZ
 zHWxDNcsDA3SidCpdIUGGsED3AV9LFUjoAdWVd6h+bl1A05Dbam+egpUlIIEIt9VEv
 XLFuPYTVABquoItqa1e8rhxmPfs+70f/3oSiUtMe1FhenJXmb48j8MKB/LuHsMO6VK
 MAWRgBQx3ZR3Q==
From: Pascal Zimmermann <pzimmermann@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Pascal Zimmermann <pzimmermann@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH 0/2] ARM: stm32: env: Enable scan and start for AB
 schema on STM32MP15 DHSOM
Date: Thu, 27 Mar 2025 15:38:41 +0100
Message-ID: <20250327143843.19358-1-pzimmermann@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 28 Mar 2025 03:20:27 +0100
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

For the STM32MP15 DHSOM, change the default environment so an AB schema
on a device can be detected.

The first patch makes possible to substitute the 'part list' command
inside 'scan_dev_for_boot_part' with a custom board specific
implementation.

The second patch uses the change of the first patch to plug the board
specific code for booting from AB into the standard boot of all boot
targets at the STM32MP15 DHSOM.

The detection works by looking for the partitions with specific lables.
The name of those partitions are in the variables and its defaults:
* dh_ab_partname_primary=rootfs-a
* dh_ab_partname_secondary=rootfs-b

To prevent being hanging at bootcmd, enable "CONFIG_BOOT_RETRY" and
"CONFIG_RESET_TO_RETRY", but the timer will only be activated, if the AB
partitions are detected.

Pascal Zimmermann (2):
  config_distro_bootcmd: make possible to substitute 'part list' in
    distro_bootcmd
  ARM: stm32: env: Enable scan and start for AB schema on STM32MP15
    DHSOM

 configs/stm32mp15_dhsom.config       |  3 +++
 include/config_distro_bootcmd.h      |  7 +++++-
 include/configs/stm32mp15_dh_dhsom.h | 33 ++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

Signed-off-by: Pascal Zimmermann <pzimmermann@dh-electronics.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
Cc: u-boot@lists.denx.de

-- 
2.30.2

