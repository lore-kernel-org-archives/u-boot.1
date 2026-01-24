Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B254D715C9
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 05:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C089583B03;
	Sat, 24 Jan 2026 06:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="SWyBLhUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF2E839DF; Sat, 24 Jan 2026 06:47:19 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B54CE839DF
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 06:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 74E5310DBFD; Sat, 24 Jan 2026 06:47:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769233635; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Ugtpydgt3BlvMkH1TOgtQoBxTJOSQKZhZQBXMz+3abo=;
 b=SWyBLhUkXyB1a/ixCpSZUO2HQIMLBkd3cKnb/Kr/rqKQnR0Ew6U+QLiPo2R20MS6Dl+F+A
 AH2XFMr4QCFFzZjAYdT+1pKSkGQAD3hWRZ2CHpEq4nKL3GVg89OSRVHfmVEVyBDHa8D99i
 0FfTMx2SCXn521WlJQiREurRnc4rpkewa49teP5QjFGuhqpR0oJ4pqXboNIDSTKXC631ER
 DkF4N+BTN5fqcuEqQIoFEImuMBAZXwkoo9TvP/l4KtJnrRg/vDO1qPJZCCcfgkeyA8zQrT
 UqU3+xKw5BEen7V2taJ7bhHs9CrBABg6TPycvXkicooiiBn/4S0UvjXPvBLK6A==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/2] fastboot: mmc: fix bootloader offset
Date: Sat, 24 Jan 2026 06:47:09 +0100
Message-Id: <20260124054712.7939-1-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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


Not for all SoCs the bootloader start at offset 0x0,
in a hardware partition of an emmc. So we need the possibility to
set the correct offset, where bootloader starts.

Example:

imx8qxp revision C0 emmc Partition layout

| eMMC block / partition | Offset     | Size  | Purpose                        |
| ---------------------- | ---------- | ----- | ------------------------------ |
| /dev/mmcblk0boot0      | 0x0        | 2MB   | imx-boot-container A           |
|                        | 0x00220000 | 128kB | secure boot signature rootfs A |
| /dev/mmcblk0boot1      | 0x0        | 2MB   | imx-boot-container B           |
|                        | 0x00200000 | 8kB   | U-Boot env 0                   |
|                        | 0x00202000 | 8kB   | U-Boot env 1                   |
|                        | 0x00220000 | 128kB | secure boot signature rootfs B |

imx8qxp rev B0 emmc Partition layout

| eMMC block / partition | Offset     | Size  | Purpose                        |
| ---------------------- | ---------- | ----- | ------------------------------ |
| /dev/mmcblk0boot0      | 0x00008000 | 2MB   | imx-boot-container A           |
|                        | 0x00220000 | 128kB | secure boot signature rootfs A |
| /dev/mmcblk0boot1      | 0x0        | 8kB   | U-Boot env 0                   |
|                        | 0x00002000 | 8kB   | U-Boot env 1                   |
|                        | 0x00008000 | 2MB   | imx-boot-container B           |

If we flash now the bootloader image flash.bin on a B0 revision with

uuu FB: flash bootloader flash.bin

we overwrite the environment and board does not boot at all, as offset
is wrong.

To prevent any API change in the above command we propose
the following implementation from this series:

We add a new weak function fb_mmc_get_boot_offset() in drivers/fastboot/fb_block.c
which returns 0 and call this function instead of passing 0 for
the offset where offset is used/passed.

In SoC specific code (currently for IMX8QXP only) we implement this function
that it returns on B0 SoCs the 32k offset and on other SoC revisions the
offset 0.

This is tested on B0 and C0 based boards from siemens.

This patch should have no effect for other SoCs.


Adrian Freihofer (2):
  fastboot: mmc: make boot partition offset configurable
  arch: imx8qxp: Override weak fb_mmc_get_boot_offset function

 arch/arm/mach-imx/imx8/cpu.c | 21 +++++++++++++++++++++
 drivers/fastboot/fb_block.c  | 15 +++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

Azure build (series is in a bunch of siemens patches sending
now to mainline):
https://dev.azure.com/hs0298/hs/_build/results?buildId=202&view=results


-- 
2.20.1

base-commit: 547e4ff610d72169a2a8c72ffe9741046abd1b2e
