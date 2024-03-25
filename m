Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1629C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 07:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B94686BDB;
	Mon, 25 Mar 2024 08:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qxTBKQsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1009487DC8; Mon, 25 Mar 2024 08:45:48 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12328646E
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 08:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1711352745;
 bh=mdEL5lwlv8StOSyHGJEwGTp4dFxaR4EPXi3cgNioj1I=;
 h=Date:From:Subject:To:Cc:From;
 b=qxTBKQsG9+GFooGEvvC0V5vpDHL2qVBopy8BZ23w6JmRpgkFOPyrEv8Zx2qoGH7Ld
 TzBiAGWK1P1b2Kj90foymmztfriLVO8+3IJFWr0hlbFRGWOr5YvjhOjXdR/rFu7CtF
 EeSH8OrOF30/2IuAmE4Sq93dw3gwE8fLfFw5BxQR/wGl4L+p/bZOcspr9/WopRrkX2
 Jzc88hM55z1wIwLF5VKJ3syNgBl48Sh1bpNdSWiETZc8hpryYkFS/eXkDfUPvXM04a
 6AtkSc/rPbVCYE3ME97T6rJVX/KOFBQUIjnUgxGjEfwb4JgghcXe5ndJ4dyJRCipeK
 QDshc4UTWV8XQ==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id E516D378209C;
 Mon, 25 Mar 2024 07:45:44 +0000 (UTC)
Message-ID: <7f50c6db-6ae9-4c1c-b2bf-71c40b86da12@collabora.com>
Date: Mon, 25 Mar 2024 09:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PULL next] u-boot-at91-2024.07-a
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello Tom,


Please pull tag u-boot-at91-2024.07-a , the first set of at91
features for the next cycle 2024.07 .

This feature set includes a new board named sama7g54 Curiosity.

Thanks,
Eugen

The following changes since commit 20a0ce574d6642e0dfe651467159039fac48cc4f:

  Merge tag 'v2024.04-rc4' into next (2024-03-11 15:27:20 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git tags/u-boot-at91-2024.07-a

for you to fetch changes up to a7ba3bf65db264c02a774a59e8febc2ecb095f68:

  configs: at91: sama7g54_curiosity: Add initial default configs (2024-03-13
13:35:16 +0200)

----------------------------------------------------------------
First set of u-boot-at91 features for the 2024.07 cycle

----------------------------------------------------------------
Mihai Sain (4):
      ARM: dts: at91: sama7g5: Add flexcom 10 node
      ARM: dts: at91: sama7g54_curiosity: Add initial device tree of the board
      board: at91: sama7g54_curiosity: Add initial board support
      configs: at91: sama7g54_curiosity: Add initial default configs

 arch/arm/dts/Makefile                              |   3 +
 arch/arm/dts/at91-sama7g54_curiosity-u-boot.dtsi   |  59 +++++
 arch/arm/dts/at91-sama7g54_curiosity.dts           | 242 +++++++++++++++++++++
 arch/arm/dts/sama7g5.dtsi                          |  24 ++
 arch/arm/mach-at91/Kconfig                         |  10 +
 board/atmel/sama7g54_curiosity/Kconfig             |  15 ++
 board/atmel/sama7g54_curiosity/MAINTAINERS         |   9 +
 board/atmel/sama7g54_curiosity/Makefile            |   7 +
 .../atmel/sama7g54_curiosity/sama7g54_curiosity.c  |  36 +++
 configs/sama7g54_curiosity_mmc_defconfig           | 123 +++++++++++
 configs/sama7g54_curiosity_nandflash_defconfig     | 122 +++++++++++
 configs/sama7g54_curiosity_qspiflash_defconfig     | 122 +++++++++++
 include/configs/sama7g54_curiosity.h               |  17 ++
 13 files changed, 789 insertions(+)
 create mode 100644 arch/arm/dts/at91-sama7g54_curiosity-u-boot.dtsi
 create mode 100644 arch/arm/dts/at91-sama7g54_curiosity.dts
 create mode 100644 board/atmel/sama7g54_curiosity/Kconfig
 create mode 100644 board/atmel/sama7g54_curiosity/MAINTAINERS
 create mode 100644 board/atmel/sama7g54_curiosity/Makefile
 create mode 100644 board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
 create mode 100644 configs/sama7g54_curiosity_mmc_defconfig
 create mode 100644 configs/sama7g54_curiosity_nandflash_defconfig
 create mode 100644 configs/sama7g54_curiosity_qspiflash_defconfig
 create mode 100644 include/configs/sama7g54_curiosity.h
