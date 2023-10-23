Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042E7C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 15:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6AE28791C;
	Mon, 23 Oct 2023 17:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CtflHEaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD0D8791C; Mon, 23 Oct 2023 17:23:44 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24AFC8790B
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 17:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [100.94.55.57] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 6591B660708F;
 Mon, 23 Oct 2023 16:23:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1698074621;
 bh=qyjACINnqUbHMAMi8hqoTwr1azuHJ3O8dbHcNWdxblw=;
 h=Date:From:Subject:To:Cc:From;
 b=CtflHEaHC5tdnEEy3a2v8OcRKVlzY/Pm/FO4FrDDlTIGm/Ob/xgyPkV2o6/HxG37I
 9fyQ87FHHfVmraUGlD9giuT7KlvVJLT7Sc+OtN4UUV3cQYve4GiUmEMmyfjq/dR2i9
 ymzngEMtvkcUB8gvicVniuBxwOltEXlqzwLtCnmTzWIdOZEaxn6ld1zafJDyQ2m4s1
 gSwG7cdZAd2gM7sc1lAJ+bdcg5FDMOYm03i0MyqbzwjfzMmQzwrrWN5LVvZ7+tYc6k
 FMt7Z/ZRJwyp/WNpqUX9fl1U6GFOT9zK/nMHC/SbDCJEwjaeYstoLQfI5ruLFzF0+R
 0Gemqc5ARJUNg==
Message-ID: <93ffc8a3-5e32-4509-83e8-031c70b0ac30@collabora.com>
Date: Mon, 23 Oct 2023 18:23:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PULL] u-boot-at91-2024.01-b
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Please pull tag u-boot-at91-2024.01-b , the second set of at91 features 
for 2024.01 cycle.

This feature set a new board named Conclusive KSTR sama5d27 with some 
small prerequisites patches.

Thanks,
Eugen


The following changes since commit 9a3a58396b78b1f9d0c14580dc03f81d29207dd2:

   Merge https://source.denx.de/u-boot/custodians/u-boot-marvell 
(2023-10-20 12:54:33 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-at91.git 
tags/u-boot-at91-2024.01-b

for you to fetch changes up to 27347893f02d4457b80357a38c194a726a43533a:

   board: Add support for Conclusive KSTR-SAMA5D27 (2023-10-23 17:07:06 
+0300)

----------------------------------------------------------------
Second set of u-boot-at91 features for the 2024.01 cycle

----------------------------------------------------------------
Artur Rojek (4):
       common: add prototype & rename populate_serial_number()
       event: add new EVT_SETTINGS_R event
       arm: dts: at91: sama5: Add flexcom4 node
       board: Add support for Conclusive KSTR-SAMA5D27

  arch/arm/dts/Makefile                          |   3 +
  arch/arm/dts/at91-kstr-sama5d27-u-boot.dtsi    |  42 +++++
  arch/arm/dts/at91-kstr-sama5d27.dts            | 127 +++++++++++++
  arch/arm/dts/sama5d2.dtsi                      |  20 +++
  arch/arm/mach-at91/Kconfig                     |  12 ++
  board/conclusive/kstr-sama5d27/Kconfig         |  15 ++
  board/conclusive/kstr-sama5d27/MAINTAINERS     |   9 +
  board/conclusive/kstr-sama5d27/Makefile        |   5 +
  board/conclusive/kstr-sama5d27/kstr-sama5d27.c | 239 
+++++++++++++++++++++++++
  cmd/tlv_eeprom.c                               |  14 +-
  common/board_r.c                               |   1 +
  common/event.c                                 |   1 +
  configs/kstr_sama5d27_defconfig                |  73 ++++++++
  include/configs/kstr-sama5d27.h                |  15 ++
  include/event.h                                |   9 +
  include/init.h                                 |  14 ++
  16 files changed, 586 insertions(+), 13 deletions(-)
  create mode 100644 arch/arm/dts/at91-kstr-sama5d27-u-boot.dtsi
  create mode 100644 arch/arm/dts/at91-kstr-sama5d27.dts
  create mode 100644 board/conclusive/kstr-sama5d27/Kconfig
  create mode 100644 board/conclusive/kstr-sama5d27/MAINTAINERS
  create mode 100644 board/conclusive/kstr-sama5d27/Makefile
  create mode 100644 board/conclusive/kstr-sama5d27/kstr-sama5d27.c
  create mode 100644 configs/kstr_sama5d27_defconfig
  create mode 100644 include/configs/kstr-sama5d27.h
