Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA02ACCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 16:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3D383A28;
	Fri, 31 Oct 2025 17:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xLQ+H/ZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B67D783A3B; Fri, 31 Oct 2025 17:36:23 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA6D83A1B
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 17:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 78A441A17B8;
 Fri, 31 Oct 2025 16:36:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4EC0D60704;
 Fri, 31 Oct 2025 16:36:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 51D7211818025; Fri, 31 Oct 2025 17:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761928579; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=Or3BgJfcb6iS98TDRrbXm5r44KezLXfSfb/Y93kI3vY=;
 b=xLQ+H/ZVSMSNypoGhp5AZ+lAyTvHZB54509qHv9wCf9VNEDKqj34CBGpFoHyVLRPzlBx4k
 1/egAWcFNLNt4zzo6VDieLJlOYMFKsW0qy6k8iwO6V8wpYIOswBGSnOZLal5C7vp3xsVIu
 l7o6Glt/mUDo0NYBmHrhGa8upu2pmnEQ84xyyAy3lROjs/M65lXoMfEhKUttNDAe3eCgjP
 GDwTzuTHEWr5jjgVclFFikv/XcK52pW6n3ONAFStxRGMoEYUfccCMorWhPSzYJQ9R1OutU
 Ouovv7s4yCkQy+Br3wizyDlEdu63FRbS3rtnABKBbcIKPqlW6r9d5cb7cA6iyA==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Subject: [PATCH 0/2] Add support for customizable find_distro_rootpart
Date: Fri, 31 Oct 2025 17:36:02 +0100
Message-Id: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHLlBGkC/x3MQQqAIBBA0avErBOysKSrRIjpWLPJGC2C6O5Jy
 7f4/4GETJhgrB5gvChR3AtkXYHb7L6iIF8MbdMq2XRSBLT5ZDSeUuZoOMZ8WM5Caa2HpVfKyQC
 lPhgD3f95mt/3A+qMwxBpAAAA
X-Change-ID: 20251031-feature_distro_rootpart-58887b655c1f
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 "Bajjuri, Praneeth" <praneeth@ti.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.3
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

Add a customizable find_distro_rootpart command to allow each board to
define its own logic for locating the rootfs partition inside the
config_distro_bootcmd logic.

Convert am335x_evm board to this new find_distro_rootpart customizable
environment variable to locate the rootfs partition dynamically, instead
of finduuid which hardcodes the rootfs partition location (mmc 0:2).

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
Kory Maincent (TI.com) (2):
      distro_bootcmd: Add support for customizable find_distro_rootpart
      include: configs: am335x_evm: Replace findduid with find_distro_rootpart

 configs/am335x_evm_defconfig         |  3 +--
 configs/am335x_evm_spiboot_defconfig |  3 +--
 configs/am335x_hs_evm_defconfig      |  2 +-
 configs/am335x_hs_evm_spi_defconfig  |  1 -
 configs/am335x_hs_evm_uart_defconfig |  3 +--
 doc/develop/distro.rst               | 11 +++++++++++
 include/config_distro_bootcmd.h      | 10 +++++++---
 include/configs/am335x_evm.h         |  4 +++-
 8 files changed, 25 insertions(+), 12 deletions(-)
---
base-commit: 4e4a9de31de2a5f395ee25c59e4026422fbcb27e
change-id: 20251031-feature_distro_rootpart-58887b655c1f

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

