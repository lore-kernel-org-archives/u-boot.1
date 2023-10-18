Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFC7CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 22:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD1C86D62;
	Thu, 19 Oct 2023 00:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="oSsl0byo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA4086FBA; Wed, 18 Oct 2023 17:35:34 +0200 (CEST)
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com
 [IPv6:2a00:1098:0:86:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D77A986F40
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 17:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=X9GkPhk9C8Aa2N3G1NsM7VyQb5DMABredZRFYo3I2n4=; b=oSsl0byoKE0ECIisaXfcCP7cwW
 QmACKM78/r11Scak1xiWM6oVwLotiBKrSjCfc8JPdJAfWo5SAY16eivrUOEtarGE/yI7k/1PTtPCz
 7r2UZ6RALvfmmmKmrUyNg38q/vJdM6D9++lMDeqF24y5Mi7mP4wSGJWMVbPgQxQ9N7tgxZ59/5ATK
 CfbK6oPXBps8JNlZWZnIFUGmE3rdG9qVMYN6d27Y8Y16ltvKMZ/CmI2GVl3L6/3BFn8XTm4y9CnuS
 YlASSNgCxGDMTIN7IacQCJFdfxq9yi+iwM7IZvaI3LIB8VIfayDXDCE2iYcLzYXNls1JB96y9PbAI
 ca96mVaA==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1qt8Zz-00FMYB-FA; Wed, 18 Oct 2023 16:35:29 +0100
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: u-boot@lists.denx.de
Cc: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v2 0/2] board: rockchip: add Pine64 QuartzPro64 RK3588 board
Date: Thu, 19 Oct 2023 02:31:58 +1100
Message-ID: <20231017155943.127659-2-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 49
X-Mailman-Approved-At: Thu, 19 Oct 2023 00:08:27 +0200
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
Message-ID: <20231018153158.EMp4mOhvQGAK_by7dbTXdLcCqE1eDTWcXGwhulhETIE@z>

Changes since v1:
* Sync recently added DT from linux-next
* Sync led dt-bindings

Tom Fitzhenry (2):
  dt-bindings: leds: import common led bindings from linux v6.5
  board: rockchip: add Pine64 QuartzPro64 RK3588 board

 arch/arm/dts/Makefile                         |    1 +
 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi   |   12 +
 arch/arm/dts/rk3588-quartzpro64.dts           | 1137 +++++++++++++++++
 arch/arm/mach-rockchip/rk3588/Kconfig         |    8 +
 board/pine64/quartzpro64-rk3588/Kconfig       |   15 +
 board/pine64/quartzpro64-rk3588/MAINTAINERS   |    8 +
 board/pine64/quartzpro64-rk3588/Makefile      |    3 +
 .../quartzpro64-rk3588/quartzpro64-rk3588.c   |   39 +
 configs/quartzpro64-rk3588_defconfig          |   72 ++
 doc/board/rockchip/rockchip.rst               |    1 +
 include/configs/quartzpro64-rk3588.h          |   14 +
 include/dt-bindings/leds/common.h             |    7 +-
 12 files changed, 1316 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-quartzpro64.dts
 create mode 100644 board/pine64/quartzpro64-rk3588/Kconfig
 create mode 100644 board/pine64/quartzpro64-rk3588/MAINTAINERS
 create mode 100644 board/pine64/quartzpro64-rk3588/Makefile
 create mode 100644 board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
 create mode 100644 configs/quartzpro64-rk3588_defconfig
 create mode 100644 include/configs/quartzpro64-rk3588.h

-- 
2.42.0

