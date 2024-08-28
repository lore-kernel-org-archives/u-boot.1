Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244D2C54E92
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E779F88892;
	Wed, 28 Aug 2024 12:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WWJGqiiU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC2D188B59; Wed, 28 Aug 2024 12:12:33 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5738188AB9
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6DFCDCE1787;
 Wed, 28 Aug 2024 10:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 453CAC4DE1E;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724839448;
 bh=RrRosQ7LQ4UBnRipIUNFLD3i+WHKmXH6jYlumQxEnqE=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=WWJGqiiUDZMMX54uCcrtBbb+itKZO9f3kvdoEXh4DUdTa48BaDHshFFS+uYLoBgPb
 BfNV2bI/YBmmf4Y69OYKFfai/sWYnIYX7y/XgsIuFvcOYjcwtfNBPrJm3aUORklCsJ
 C2Mp5Fa83H9crqZYk7KS2xRvRhqslc0JfxWJ6ej/vcvCVQIOMmzcpu0Ds1j5J4suyj
 97UXZazS3pmkM7DhBt7Lf7Kx4Pg++6ZeNNoSqzm/dGY+swVT4hs8Vm72oBkCuKG7/w
 yMHVFdmP/c7pvugZdN9R+n2qqgDIjDNFEw5g6OCkn0ymvmP3xii3U/MQx1bLGrpJQ6
 0pUWwrrudLezQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDBEC5474B;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Subject: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx boards
Date: Wed, 28 Aug 2024 11:02:08 +0100
Message-Id: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKH1zmYC/x3MQQqEMAxA0atI1gZqUbReRVzETtQsrKVxhoJ4d
 8ss3+L/G5STsMJY3ZD4JypnKGjqCvxOYWOUTzFYY1sz2AbVdznjN+qVmA4JG0a6/M6K3rTDQm5
 1vSMofUy8Sv6/p/l5XprC1/5rAAAA
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Trevor Woerner <twoerner@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724839434; l=4844;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=RrRosQ7LQ4UBnRipIUNFLD3i+WHKmXH6jYlumQxEnqE=;
 b=RkEE7bFcphXifnDlk7P7dBVDdLGEFZaaY1PJNirKbC8raGqqPi0U+GghervSgvSSOE07YDqPW
 Zwe6ZbY2ZmTA6ajy416p882PybaQl5FL+klcvg9+s1JqKJk9t7bME7h
X-Developer-Key: i=Oliver.Gaskell@analog.com; a=ed25519;
 pk=Icq9TxwFJ6FePHS28YbBWMvtZpFWxpPQLhLA9cNvZ/Y=
X-Endpoint-Received: by B4 Relay for Oliver.Gaskell@analog.com/20240821
 with auth_id=197
X-Original-From: Oliver Gaskell <Oliver.Gaskell@analog.com>
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
Reply-To: Oliver.Gaskell@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

ADSP-SC5xx is a series of ARM-based DSPs.
This comprises the armv7 based SC57x, SC58x and SC594 series, and the
armv8 based SC598.

This patch series includes configurations, init code, and minimal DTs
to enable Analog Devices' evaluation boards for these SoCs to boot
through SPL and into U-Boot Proper, as well as devicetree schemas for
the added DTs.

This patch series depends on ("arm: Add Analog Devices SC5xx Machine
Type") (https://lists.denx.de/pipermail/u-boot/2024-April/552043.html)

Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
Oliver Gaskell (20):
      arm: dts: Support SC573-EZKIT
      arm: dts: Support SC584-EZKIT
      arm: dts: Support SC589-MINI
      arm: dts: Support SC589-EZKIT
      arm: dts: Support SC594-SOM-EZKIT
      arm: dts: Support SC594-SOM-EZLITE
      arm: dts: Support SC598-SOM-EZKIT
      arm: dts: Support SC598-SOM-EZLITE
      dt-bindings: arm: Add SC5xx Series binding
      dt-bindings: clock: Add SC5xx clock tree bindings
      dt-bindings: timer: Add SC5xx Timer bindings
      arm: mach-sc5xx: clean up Kconfig
      arm: SC598-SOM-EZKIT initial support
      arm: SC598-SOM-EZLITE initial support
      arm: SC594-SOM-EZKIT initial support
      arm: SC594-SOM-EZLITE initial support
      arm: SC584-EZKIT initial support
      arm: SC589-EZKIT initial support
      arm: SC589-MINI initial support
      arm: SC573-EZKIT initial support

 MAINTAINERS                                        |   7 +
 arch/arm/Kconfig                                   |  14 ++
 arch/arm/dts/Makefile                              |   9 +
 arch/arm/dts/sc573-ezkit.dts                       |  13 ++
 arch/arm/dts/sc57x.dtsi                            |  21 +++
 arch/arm/dts/sc584-ezkit.dts                       |  13 ++
 arch/arm/dts/sc589-ezkit.dts                       |  13 ++
 arch/arm/dts/sc589-mini.dts                        |  13 ++
 arch/arm/dts/sc58x.dtsi                            |  23 +++
 arch/arm/dts/sc594-som-ezkit.dts                   |  13 ++
 arch/arm/dts/sc594-som-ezlite.dts                  |  13 ++
 arch/arm/dts/sc594-som.dtsi                        |  19 +++
 arch/arm/dts/sc598-som-ezkit.dts                   |  13 ++
 arch/arm/dts/sc598-som-ezlite.dts                  |  13 ++
 arch/arm/dts/sc598-som.dtsi                        |  31 ++++
 arch/arm/dts/sc5xx.dtsi                            |  54 ++++++
 arch/arm/mach-sc5xx/Kconfig                        | 134 ++++++++++++---
 arch/arm/mach-sc5xx/Makefile                       |   4 +
 arch/arm/mach-sc5xx/sc57x-spl.c                    |  26 +++
 arch/arm/mach-sc5xx/sc58x-spl.c                    |  26 +++
 arch/arm/mach-sc5xx/sc59x-spl.c                    |  26 +++
 arch/arm/mach-sc5xx/sc59x_64-spl.c                 |  26 +++
 arch/arm/mach-sc5xx/sc59x_64.c                     |  25 +++
 arch/arm/mach-sc5xx/soc.c                          |  44 +++++
 board/adi/sc573-ezkit/Kconfig                      | 160 ++++++++++++++++++
 board/adi/sc573-ezkit/sc573-ezkit.env              |  13 ++
 board/adi/sc584-ezkit/Kconfig                      | 160 ++++++++++++++++++
 board/adi/sc584-ezkit/sc584-ezkit.env              |  13 ++
 board/adi/sc589-ezkit/Kconfig                      | 160 ++++++++++++++++++
 board/adi/sc589-ezkit/sc589-ezkit.env              |  13 ++
 board/adi/sc589-mini/Kconfig                       | 160 ++++++++++++++++++
 board/adi/sc589-mini/sc589-mini.env                |  13 ++
 board/adi/sc594-som-ezkit/Kconfig                  | 181 +++++++++++++++++++++
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env      |  13 ++
 board/adi/sc594-som-ezlite/Kconfig                 | 181 +++++++++++++++++++++
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env    |  13 ++
 board/adi/sc598-som-ezkit/Kconfig                  | 150 +++++++++++++++++
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env      |  13 ++
 board/adi/sc598-som-ezlite/Kconfig                 | 150 +++++++++++++++++
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env    |  13 ++
 doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml    |  46 ++++++
 .../clock/adi,sc5xx-clocks.yaml                    | 112 +++++++++++++
 .../timer/adi,sc5xx-gptimer.yaml                   |  42 +++++
 include/configs/sc573-ezkit.h                      |  18 ++
 include/configs/sc584-ezkit.h                      |  18 ++
 include/configs/sc589.h                            |  19 +++
 include/configs/sc594-som.h                        |  19 +++
 include/configs/sc598-som.h                        |  23 +++
 48 files changed, 2274 insertions(+), 22 deletions(-)
---
base-commit: 34377bc0b0dc446853c7831efaccef8b50c22841
change-id: 20240821-sc5xx-upstreaming-patches-c048ba9f979a

Best regards,
-- 
Oliver Gaskell <Oliver.Gaskell@analog.com>


