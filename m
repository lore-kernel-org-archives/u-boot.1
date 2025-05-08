Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CDFC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E7E8269F;
	Thu,  8 May 2025 23:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="DRrGEqcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086CF8283E; Thu,  8 May 2025 23:23:33 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEDDB82162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739409; x=1746998609;
 bh=H7+Vijz6XjPh84FcIBqYDsB0Fga+WiLmKMY1BlEJFEM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=DRrGEqcWWqmHUzuoty8DlHnOuZtoWFHigTyfaXVdS9TndU39w8UVk16iXe4S6sEed
 mxN6EG1JJSbyQcffq+pZ9jbIpEKlRnJlefcgiHQdjeMbWG3jRh2AkgtfA1+0c8ucnU
 XIKrAiWy1VHRgneEl3aa9wfXOBEk1WOgJGB/2aG2KPD7F7r2kOs7+3Ii+aUDVTSZbl
 /v+/qvebX/V2GLF8MJIUyI6GD1lcncT2ji+zv6JBnswdtNhRLn0ta7tUlpHUKdAwww
 NsvfWDGE5XzAZ0qjsVfTiDaZJBU9bVgvGQenGlyM5yecQZx3xBNaj/CWg36Jl4f+jq
 aIGfWeqHiteJQ==
Date: Thu, 08 May 2025 21:23:24 +0000
To: u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>
Subject: [PATCH 00/10] add STM32H747 discovery board
Message-ID: <20250508212058.640483-1-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 5404a0cbedbd57190a3f18ceb1e8a21169b98d4b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

These patch series adds support for the STM32H747 discovery
board from STMicroelectronics.

Johannes Krottmayer (10):
  arm: mach-stm32: stm32h7: add initial lowlevel early function
  arm: mach-stm32: stm32h7: add initial Makefile
  arm: mach-stm32: stm32h7: add STM32H747-DISCO board
  arm: mach-stm32: add stm32h7 subdirectory
  board: st: add STM32H747 discovery board
  configs: add STM32H747 discovery board
  include: configs: add STM32H747 discovery board
  arm: dts: add STM32H747 discovery board
  dts: upstream: arm: st: add STM32H747 discovery board
  dts: upstream: arm: st: stm32h7-pinctrl: change pins for USART1

 arch/arm/dts/stm32h747i-disco-u-boot.dtsi    | 101 ++++++++++++++++
 arch/arm/mach-stm32/Makefile                 |   2 +
 arch/arm/mach-stm32/stm32h7/Kconfig          |   5 +
 arch/arm/mach-stm32/stm32h7/Makefile         |   6 +
 arch/arm/mach-stm32/stm32h7/lowlevel.S       |  45 ++++++++
 board/st/stm32h747-disco/Kconfig             |  15 +++
 board/st/stm32h747-disco/MAINTAINERS         |   8 ++
 board/st/stm32h747-disco/Makefile            |  10 ++
 board/st/stm32h747-disco/stm32h747-disco.c   |  43 +++++++
 configs/stm32h747-disco_defconfig            |  35 ++++++
 dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi |   4 +-
 dts/upstream/src/arm/st/stm32h747i-disco.dts | 115 +++++++++++++++++++
 include/configs/stm32h747-disco.h            |  37 ++++++
 13 files changed, 424 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/stm32h747i-disco-u-boot.dtsi
 create mode 100644 arch/arm/mach-stm32/stm32h7/Makefile
 create mode 100644 arch/arm/mach-stm32/stm32h7/lowlevel.S
 create mode 100644 board/st/stm32h747-disco/Kconfig
 create mode 100644 board/st/stm32h747-disco/MAINTAINERS
 create mode 100644 board/st/stm32h747-disco/Makefile
 create mode 100644 board/st/stm32h747-disco/stm32h747-disco.c
 create mode 100644 configs/stm32h747-disco_defconfig
 create mode 100644 dts/upstream/src/arm/st/stm32h747i-disco.dts
 create mode 100644 include/configs/stm32h747-disco.h

--=20
2.39.5


