Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CBBE7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 21:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D80C780462;
	Fri, 27 Dec 2024 22:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BA1A80422; Fri, 27 Dec 2024 22:23:12 +0100 (CET)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B8C80362
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 22:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje.mihanovic@skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
 by mx.skole.hr (mx.skole.hr) with ESMTP id 72F1B82D9B;
 Fri, 27 Dec 2024 22:23:09 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH 0/2] Initial support for PXA1908 and samsung-coreprimevelte
Date: Fri, 27 Dec 2024 22:22:14 +0100
Message-Id: <20241227-coreprimevelte-v1-0-ac8243eee4e6@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIYab2cC/x3MSwqAMAxF0a1IxhZs0CJuRRxofWrAH6mIUNy7x
 eEZ3BspQAWBmiyS4pYgx55g84z80u8zjIzJxAWXltkZfyhOlQ031gvGena9n4aqHgdK0amY5Pm
 Hbfe+H2SQVylgAAAA
X-Change-ID: 20241226-coreprimevelte-1c26acfb58db
To: Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=Z7nO+aDz1JzPkDqLPKhUVvEglQUG9K0MpeSy3bRCZIo=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOn5UtOOHdxh/IfN8t25nxwKR0q3Xlq5/72j4ll/lQIpv
 vm9L7PYOkpZGMS4GGTFFFly/zte4/0ssnV79jIDmDmsTCBDGLg4BWAi/hWMDF/OPuUPZCl503FM
 VWaJ20s5zifnVW3k9llFPOhdpvqi7jPD/3z1fqsDlcxvFctSXM7aMB38wXW64ER4ZdeXb5t3y/F
 ycgIA
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Mailman-Approved-At: Fri, 27 Dec 2024 22:53:46 +0100
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

Hello,

This series adds initial support for Marvell's PXA1908 ARM64 SoC and
Samsung's Galaxy Core Prime VE LTE, a smartphone based on said SoC.

On this board, U-Boot is used as a secondary bootloader to work around
certain quirks of the factory S-Boot.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Duje Mihanović (2):
      arm: mmp: add initial support for PXA1908 SoC
      board: samsung: add initial support for coreprimevelte board

 MAINTAINERS                                     |   8 ++
 arch/arm/Kconfig                                |  11 +++
 arch/arm/Makefile                               |   1 +
 arch/arm/dts/Makefile                           |   2 +
 arch/arm/dts/pxa1908-samsung-coreprimevelte.dts |  74 +++++++++++++++++
 arch/arm/dts/pxa1908.dtsi                       | 106 ++++++++++++++++++++++++
 arch/arm/mach-mmp/Kconfig                       |  12 +++
 arch/arm/mach-mmp/Makefile                      |   1 +
 arch/arm/mach-mmp/board.c                       |  82 ++++++++++++++++++
 arch/arm/mach-mmp/mmu.c                         |  30 +++++++
 board/samsung/coreprimevelte/Kconfig            |  12 +++
 board/samsung/coreprimevelte/MAINTAINERS        |   6 ++
 configs/coreprimevelte_defconfig                |  20 +++++
 include/configs/pxa1908.h                       |  12 +++
 14 files changed, 377 insertions(+)
---
base-commit: 3391587e3fe22db6c71882f652e13543a4501694
change-id: 20241226-coreprimevelte-1c26acfb58db

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


