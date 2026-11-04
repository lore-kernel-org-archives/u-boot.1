Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABA606EEAB
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0rFnRcpj;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=H5q2EFfs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F23E0606EC;
	Wed,  4 Nov 2026 08:50:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wL7z8Q7kb3YO; Wed,  4 Nov 2026 08:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A8A5606E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782252;
	b=HYD/WUztf1oUIdbzAUm+uHsfpncAN+tWZNOfoOqrYG51q/lkAgOIVf6bFk4SF0t24cns
	 ocn9EwtrnYBmhvoJ3dz1ZsDCDU1TgU0hqdreUwdI+8pGiNNVve4HU2wKWkY/H6Q32x8IS
	 I6AyAOiJHQTsH1uFnyK4VIOe4EJYvviFq5ML6+XvxTw0bswYtFmTpPbt9rgV6yKGtBgFk
	 uLPkpFq4VFLPQdGPL1A4D1MwD1dwOR/sR4tvV9LNxlkwFG6XfjwYGntcNCu5G0VWGV8Fw
	 yzn6z5seBnhB+QIrlforDtT29kpUPQDi6gf4fuCHp6J4GmNisMtY+FoHSjLaQJGvaPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vvn+ox0349MhalDnHMekPVs9ZJ1OSe/wAWDGVs+vwJo=;
	b=b9dUKbyZKJndp8vwxCR+xvpdVIXwkFlv3BoXfDBm8i8uV4kxBIhbVa3Ts4S1TQV/xybc
	 OJzNIZBfUA6nXZZFK3iCRCwBxyARX5Scr7EE7b0W8un5TXJi+F2Uhs173rHo58S/uYmw7
	 5dc0GcGH7qpHU709LDR5upLOGhkUpV60npExLAFLrxJIbAeUDdRzpYXHWppSm1aDU2I2A
	 rXnXbE+OOEaH/7IZsx7X2A0iQ0MuAtoGQbwAfi6ncelhFbR/HB8Khe9cHfbUB8eiPVxtx
	 WbFPDS/OhrolkFtgfcWjYOcOofPtuugIWq2A92IqF8k2jTQvnTW+SNxwupAe+iSediQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=H5q2EFfs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782252;
	bh=vvn+ox0349MhalDnHMekPVs9ZJ1OSe/wAWDGVs+vwJo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0rFnRcpj7BZeD9+pfCUa78J6uxOYl6FFQizL6TK8ae9UcTs+JOFtY2jTcKcmZKHUt
	 ltkrqLRAynxNNCoEoPC7s0CsIP2hxGwaIkI/GeFQAbZgrN8YQStJtGit8DqNgHcYb4
	 9Jn5WNiDb9goAbvMZqDkqN6HSEKFtFkkxRZQIgBNVP1DFU+ESSNajEmV+QqwRnr98e
	 ZRT5pd/drC7YiYy0lDpFSetFOMZ4LZiul9i5UhFAJHA/gJYx4kKkRmLYtzkLln0sOv
	 nYgB+Oul339L2Qzj7p8VDZm7XL0ywe+gmKj09MJL6kRsZGHImtVT461yqX33MU2dMx
	 PH6KQHsyjS65Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A8A5606E1;
	Wed,  4 Nov 2026 08:50:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 11CDC932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0ECFC606E1
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-kan8arGrg4 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BBDD860642
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782250;
 b=SzX16BfMUezpLD3GvLy9O4msBDufLRORl2VkjS/nR5SnYeHfWj9wFYlCvWZzq7ezzg96
 dM2djHR8gEGlpp0JpdR9bBfSRiNTFFj6nt9bdJ5V43z3QvgdC6VxRob2sH45WOxQvTaeu
 2BduUGfs3utqek/t3q5K9QjpzqO+0xnEJDpaugaIXxQu1elA3Aa5Ixxp6t99+L9FA/IsC
 GvJuUFKQLW4EKJKT2Icl0YCI1LNpH/UEZUaC91525wAmaXeoPrA/BNR6yoqyH4koT++pn
 zsm+mkCuui9Ie8kBI/qkw2zcLKwPI8Ld8nHNibJWGgorLqi+lQ5J5x0s6SUyoLvT+vQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782250;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=vvn+ox0349MhalDnHMekPVs9ZJ1OSe/wAWDGVs+vwJo=;
 b=h6Kgax08ZFQOVgiYS5ApUo86YCkjKJHhK4/fCMMAFFZRvWkJb+dC3N9qoZHhqA+UXwtt
 wb6zzNURKyhuNvu9WKU1JsQf9kyV5ZCpDPD2SQz9tCPpVLClJPizhnWm3eub/Iw8Yv4HD
 zPRlb95Fza/irGjGBvKM3vrZoWkPhS3ypEftMcNvgmCuYskHHv67sKyPX9U8CBDFA9Bg4
 s2A8Ckzt5N5Wcz1CyUsvGZFNq3WzDGEBH41S8SALBl3KDSKHiFNayBtFMSJg2gGH+aRBl
 zPsZ8nxVqmq2HjRF4UrvJJzFJ/UgsB3KSD5+7qCGHEgsBlMU35UTj/yvLyumGoAc2mg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=H5q2EFfs; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=H5q2EFfs
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBDD860642
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:50:49 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso1517215e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782247; x=1794387047;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vvn+ox0349MhalDnHMekPVs9ZJ1OSe/wAWDGVs+vwJo=;
 b=H5q2EFfsaOuyyIYkuQH1Nk9k6/XZD6diq3Y2G/GXiGW4OBL7Vr8Nm0VuV7y9lcfRxK
 q6P8RonGAz9XHMZmQJ8ZbcTrueBqrASoqbpLaJJ9JxUuTwiQ7Iicl2ObLRJ8QhMjP/cI
 m0pwVDRyCIQGnsUOwUP2c0Gj4lQm6TrKaz/fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782247; x=1794387047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vvn+ox0349MhalDnHMekPVs9ZJ1OSe/wAWDGVs+vwJo=;
 b=krELLVTa9mwf/iD8dCFpvXT95BXg0HGz1UYNnCpcUwDJ2/KxsOQ6C+hjolFu80i+d9
 4UAz77aXbkNZMjDb+66YLgQnkKsMTl5BL3GOXfPY+KELdrnjKeEdAiq2OvFo9Tc1s3vD
 ETxzuUU1ZNgbul8/5YhEfF2FZIlmgR1IxyjF4QgsNZqwCF/BuZxQ9ZBeoFGjTSTgzZrE
 v3lPjQ7cVbw1rgIlyemUT2R6Jlxcak4y8xcw6rXoO9bN0hAl50rThZGef/ekhjZSOMNU
 drNF0AEcGkss9xlAgoGSrSZ5oPLQoOuHzke3Nj17bIgqMvnMH9o5q1s2P4MCTFgIqpEt
 /D0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2cdHi4gu6p0CsM981+nb/lIGirPBGoVvGpri7Pk/sdZZVUE2k9v/20sSXS2Li+PQkZ6sgm0Y=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8imRlMBGIQUL4zNRGpxiYZp7Dn8rnXfgw2H1+Qtmn5GTyvSRR/
 tcOsb4JJwJ3pvYJKt8dLsbOXY9RA4cJjwr1hMmenD6pMvyZ4614yZSjbVxZV3/0uFqs=
X-Gm-Gg: AYBFou2NEw3RbwEt8LY1sbxXClDhZ/F/T3Yg5kqAINRmcJmqkoSCVmOzw9BbveUs0BK
 k1a/c0Oti5bNUkYWJ53bCJ2XQXyENTU/Y7cPMdGL0JOsqb0Usp9nDjF908kRYm7dNGTYF6fg5Tv
 z0PQuGoxoTBzqrL+4GMt4fM1m86ZfbpRkwD4W51M6l3mDMS9vrCnpSguWMMHD2OnGvAr8pylZlo
 xjzqlLLQGkiGB0m/ly7+xzoCmbmsc9+X/ZnF8HiLfu80rgwoYCgezxm9zNTfbiO6tcUKBDF/M2w
 S/FiXxKog96V2zRvBiGy9O9iypkA8BY6kRZFdwpGkcBOTyYnJpByv38hiz7Y3h3O1NvuckANw6a
 nrhpf0uLowgXEoxCleXD4NEIUziY6smpJ43WDO2GaoLhDx6o2WRGUH2IYC8dJU3XnyB0IvwFFrt
 FPMw4QoYqn8vT0w3EMGIH8kPzWkidrdOLhOsDE0LYUd6N/Z/Vqi50n8w4yMSstwuXrB1pYHjxE6
 yReipIC18UEdxIrG5/6o/SNct9c7b5aEzPB+baDvNGEm+HgKmpqWc0B8GWD4RTw1e5DYQoJHrCy
 CQkBjVytrnhbPcCH/OZyFIEnRvnW68c6swIJ6maXx7rYLbqIloe9mmk9pOt8vjNnoRlrfy5i41L
 7RjVp8WNwSfrwkKoX1AA2JoFEtu0=
X-Received: by 2002:a05:600c:a00b:b0:4a7:b304:253e with SMTP id
 5b1f17b1804b1-4ac1765d8abmr356469295e9.22.1793782247148; 
 Wed, 04 Nov 2026 00:50:47 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:50:46 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 00/33] Add Engicam MicroGEA-STM32MP257D-RMM board support
Date: Wed,  4 Nov 2026 09:49:33 +0100
Message-ID: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the Engicam MicroGEA-STM32MP257D-RMM
board, with its RGB and LVDS displays and the FWU A/B update.

The first patches pick the board devicetrees, merged for Linux v7.4,
from devicetree-rebasing. They can be dropped if dts/upstream is synced
with v7.4-dts first. Then come the fixes, the refactors moving the
STM32MP2 environment and FWU support to the SoC code, and the board
support.

Tested on the board, booting from the SD card and from the eMMC.


Dario Binacchi (33):
  dt-bindings: arm: stm32: support Engicam MicroGEA-STM32MP257D-RMM
    board
  arm64: dts: st: add power-domains to sdmmc1 on stm32mp231
  arm64: dts: st: add power-domains to sdmmc1 on stm32mp251
  arm64: dts: st: add SDMMC2 support on stm32mp25
  arm64: dts: st: add CAN1 support on stm32mp25
  arm64: dts: st: add i2c1 pins for stm32mp25
  arm64: dts: st: add ltdc pins for stm32mp25
  arm64: dts: st: add can1 pins for stm32mp25
  arm64: dts: st: add pwm2/pwm4 pins for stm32mp25
  arm64: dts: st: add sai1 pins for stm32mp25
  arm64: dts: st: add sdmmc2 pins for stm32mp25
  arm64: dts: st: add spi1 pins for stm32mp25
  arm64: dts: st: add usart1 pins for stm32mp25
  arm64: dts: st: support Engicam MicroGEA-STM32MP257 SoM
  arm64: dts: st: support Engicam MicroGEA-STM32MP257D-RMM board
  arm64: dts: st: move Engicam MicroGEA-STM32MP257D-RMM display to an
    overlay
  arm64: dts: st: add Engicam MicroGEA-STM32MP257D-RMM LVDS display
    overlay
  arm: stm32mp: stm32mp2: fix off by one in mmc_get_boot()
  video: stm32: lvds: fix NULL pointer dereference on missing
    data-mapping
  clk: stm32: propagate rate changes to the parent clock
  spi: stm32: ignore the cs-gpios polarity flags
  video: stm32: ltdc: fall back to a panel when no bridge is connected
  arm: stm32mp: stm32mp2: move boot device environment helpers to SoC
    code
  splash: make splash_video_logo_load() available to boards
  arm: stm32mp: move FWU multi-bank support to SoC code
  configs: stm32mp25: move FWU A/B boot environment to common settings
  video: simple_panel: add Ampire AM-1280800W8TZQW-T00H panel
  video: stm32: ltdc: select the pixel clock source on STM32MP25
  boot: extension: allow longer overlay file names
  board: engicam: stm32mp2: add MicroGEA-STM32MP257D-RMM board
  board: engicam: stm32mp2: add splash screen
  board: engicam: stm32mp2: support FWU A/B bank bootup
  board: engicam: stm32mp2: enable simple framebuffer for the splash
    screen

 ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi | 121 +++++++
 arch/arm/mach-stm32mp/Kconfig.25x             |  17 +
 arch/arm/mach-stm32mp/Makefile                |   1 +
 .../arm/mach-stm32mp/fwu.c                    |   0
 arch/arm/mach-stm32mp/stm32mp2/Makefile       |   1 +
 arch/arm/mach-stm32mp/stm32mp2/env.c          |  82 +++++
 board/engicam/stm32mp2/Kconfig                |  12 +
 board/engicam/stm32mp2/MAINTAINERS            |   7 +
 board/engicam/stm32mp2/Makefile               |   7 +
 board/engicam/stm32mp2/microgea-stm32mp2.env  |  23 ++
 board/engicam/stm32mp2/stm32mp2.c             | 277 +++++++++++++++
 board/st/common/Makefile                      |   1 -
 board/st/stm32mp2/stm32mp2.c                  |  71 +---
 common/splash.c                               |   4 +-
 configs/stm32mp25-microgea-rmm_defconfig      | 128 +++++++
 drivers/clk/stm32/clk-stm32-core.c            |   7 +-
 drivers/spi/stm32_spi.c                       |   9 +-
 drivers/video/simple_panel.c                  |  19 +
 drivers/video/stm32/stm32_ltdc.c              |  69 +++-
 drivers/video/stm32/stm32_lvds.c              |   4 +-
 dts/upstream/Bindings/arm/stm32/stm32.yaml    |   7 +
 dts/upstream/src/arm64/st/stm32mp231.dtsi     |   1 +
 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 328 ++++++++++++++++++
 dts/upstream/src/arm64/st/stm32mp251.dtsi     |  17 +
 dts/upstream/src/arm64/st/stm32mp253.dtsi     |  16 +
 .../arm64/st/stm32mp257-engicam-microgea.dtsi |  63 ++++
 ...gea-rmm-overlay-am-1280800w8tzqw-t00h.dtso |  67 ++++
 ...icrogea-rmm-overlay-rk050hr345-ct106a.dtso |  68 ++++
 .../st/stm32mp257d-engicam-microgea-rmm.dts   | 275 +++++++++++++++
 include/configs/stm32mp25_common.h            |  20 ++
 include/configs/stm32mp25_st_common.h         |  15 -
 include/extension_board.h                     |   2 +-
 include/splash.h                              |   9 +
 33 files changed, 1641 insertions(+), 107 deletions(-)
 create mode 100644 arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
 rename board/st/common/stm32mp_fwu.c => arch/arm/mach-stm32mp/fwu.c (100%)
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/env.c
 create mode 100644 board/engicam/stm32mp2/Kconfig
 create mode 100644 board/engicam/stm32mp2/MAINTAINERS
 create mode 100644 board/engicam/stm32mp2/Makefile
 create mode 100644 board/engicam/stm32mp2/microgea-stm32mp2.env
 create mode 100644 board/engicam/stm32mp2/stm32mp2.c
 create mode 100644 configs/stm32mp25-microgea-rmm_defconfig
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257-engicam-microgea.dtsi
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtso
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a.dtso
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts

---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
branch: engicam-microgea-stm32mp257-rmm

-- 
2.43.0

