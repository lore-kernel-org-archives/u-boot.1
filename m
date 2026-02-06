Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06939EE6B5E
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 20:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A9F83BC4;
	Fri,  6 Feb 2026 21:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="M79TWTQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB8F83B8F; Fri,  6 Feb 2026 21:55:46 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AA683642
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 21:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=FR7pvI812XD8H0hJNRt/M2m3JG2GltUUudEcEeRs/Y4=; b=M79TWTQePm0XFTCS+UmxEQiRuZ
 pbUPEEHVz7YHMixvfaAKlDhaVxK/0xjs2mIrVHE7NEquNJwJFB4fQ5T1yiDu9Z1rCzycQXCk0Pm7k
 qxnbyA4LWgjDDgZa9jbBFsdO3mgSqyjs1rWShYn1ubdygprbj9mvGWv6xLQ/5eb+qQL4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35962
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1voSrc-0001FX-3z; Fri, 06 Feb 2026 15:55:41 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: hvilleneuve@dimonoff.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com
Cc: u-boot@lists.denx.de,
	hugo@hugovil.com
Date: Fri,  6 Feb 2026 15:55:23 -0500
Message-ID: <20260206205537.2906980-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH 0/6] Conversion of imx8mn-var-som/imx8mn-var-som-symphony to
 OF_UPSTREAM and fixes/improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series is for the migration of imx8mn-var-som-symphony board, as
well as imx8mn-var-som SOM to OF_UPSTREAM.

It also brings a few cleanups and enhancements, so that it will be easier in the
future to add more boards using this SOM.

I have succesfully tested the changes on a Variscite symphony carrier board with
a VAR-SOM-MX8M-NANO having the EC configuration option.

Thank you.

Hugo Villeneuve (6):
  arm: dts: imx8mn-var-som: Move SOM-specific nodes to SOM u-boot.dtsi
  arm: dts: imx8mn-var-som: add som-eeprom alias to SOM u-boot dtsi
  arm: dts: imx8mn-var-som-symphony: migrate to OF_UPSTREAM
  board: imx8mn_var_som: let clock system enable UART clock
  board: imx8mn-var-som: remove unneeded header files
  board: imx8mn-var-som: compile SPL-only stuff only in SPL build

 arch/arm/dts/Makefile                         |   1 -
 .../dts/imx8mn-var-som-symphony-u-boot.dtsi   |  63 +-
 arch/arm/dts/imx8mn-var-som-symphony.dts      | 236 --------
 ...u-boot.dtsi => imx8mn-var-som-u-boot.dtsi} |  45 +-
 arch/arm/dts/imx8mn-var-som.dtsi              | 564 ------------------
 arch/arm/mach-imx/imx8m/Kconfig               |   1 +
 board/variscite/imx8mn_var_som/Makefile       |   4 +-
 .../variscite/imx8mn_var_som/imx8mn_var_som.c |   4 -
 board/variscite/imx8mn_var_som/spl.c          |  12 -
 configs/imx8mn_var_som_defconfig              |   2 +-
 10 files changed, 19 insertions(+), 913 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mn-var-som-symphony.dts
 copy arch/arm/dts/{imx8mn-var-som-symphony-u-boot.dtsi => imx8mn-var-som-u-boot.dtsi} (75%)
 delete mode 100644 arch/arm/dts/imx8mn-var-som.dtsi


base-commit: e5e75ea8c7b8e6d9ce1ca8ec7a25fa8b3f6029a9
-- 
2.47.3

