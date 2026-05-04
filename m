Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA71FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82436846D2;
	Mon,  4 May 2026 22:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="jcz6yStK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D08B846CE; Mon,  4 May 2026 22:30:21 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3975A846A0
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1777926618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g/PbHEN15yvlL9SfbqXXRnw4HC6Yf/r4UqY+TAZBcJ8=;
 b=jcz6yStKmi6BUKDO4drZhTk0y3gQDRPdp9I0zvVcxc7NxRGn5Y2wy57odPSJkN8tkCARhd
 D4E0W7aGkyfQ0IhCUcqvX6zjjSo/OWmLaeqIYYb8hMIuj8OF4cWQVcenvJCZTWhJ9GakIp
 AZp2RDvnW43Z8kMQ633YwKm9qYf8vp8=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id a6cd2641
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 4 May 2026 20:30:18 +0000 (UTC)
Message-ID: <52347f0a-49e8-46d7-987c-73bb9c2add95@kernel-space.org>
Date: Mon, 4 May 2026 22:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, it
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: alison.wang@freescale.com, Kuan-Wei Chiu <visitorckw@gmail.com>
From: Angelo Dureghello <angelo@kernel-space.org>
Subject: [PULL] Please pull u-boot-coldfire/master
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

The following changes since commit bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sunxi (2026-05-01 08:12:31 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-coldfire.git master

for you to fetch changes up to 44684aabc2983cabab7056cf5840a04c97c42b1f:

  m68k: set proper u-boot image size for initial boot (2026-05-04 22:19:49 +0200)

----------------------------------------------------------------
Angelo Dureghello (9):
      m68k: dts: mcf5441x: add mmc device for mcf5441x
      m68k: dts: stmark2: enable esdhc
      board: stmark2: add sd boot command
      board: stmark2: remove old garbage
      mmc: Kconfig: allows m68k to use esdhc imx driver
      configs: stmark2: add support for mmc
      configs: stmark2: add bdinfo command
      m68k: mcf5441x: create stub to use imx drivers
      m68k: set proper u-boot image size for initial boot

 arch/m68k/Kconfig                           |  1 +
 arch/m68k/cpu/mcf5445x/start.S              |  3 +--
 arch/m68k/dts/mcf5441x.dtsi                 |  8 ++++++++
 arch/m68k/dts/stmark2.dts                   |  4 ++++
 arch/m68k/include/asm/arch-mcf5445x/clock.h | 19 +++++++++++++++++++
 arch/m68k/lib/Makefile                      |  1 +
 arch/m68k/lib/clock.c                       | 23 +++++++++++++++++++++++
 configs/stmark2_defconfig                   | 19 +++++++++++++------
 drivers/mmc/Kconfig                         |  2 +-
 include/configs/stmark2.h                   |  6 ++++--
 10 files changed, 75 insertions(+), 11 deletions(-)
 create mode 100644 arch/m68k/include/asm/arch-mcf5445x/clock.h
 create mode 100644 arch/m68k/lib/clock.c
