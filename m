Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ADDCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D57883F9;
	Thu,  4 Apr 2024 09:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ef2BIjqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E6C883E6; Thu,  4 Apr 2024 09:51:34 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86DF0883E0
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EB854CE2FAE;
 Thu,  4 Apr 2024 07:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6975EC43394;
 Thu,  4 Apr 2024 07:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217090;
 bh=NOEKuUxwTj8vfzJcRumh+hVKsWvjLEJLf4eDCWJ2aIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ef2BIjqMv9ncw1JvZlHaKYbZ3GU59yOOuzHf+vVlztp3PJs8bBbx2Qa0NzMODBOlC
 Ksyb3Lz2WgOqHDmefzc2o5WfOqt6V0zSPIf4j6MsKE75nroywCiw32wRwcfVjsDtKZ
 xFueuEVQK5306Izl6Wn8WS7pLQxY4Qv6jx7Gqi8BF0vcMxRgabwxTVCE6Oc5+uuaX8
 gcE1c7Y0+OhmeQ1oyAz+AeNUBiS+SR11lQjUJ0RB9B+ebs3psnTFVjF0EbVyrNhR/U
 mL7MZR5nGvZ81Cbd3BNyzRuM7X0xLnE2o0rxWzPxDeB7NmBdxgYjwdmD9Gp3/fkRvz
 wGcOzb7fh7lOw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 15/18] arm: mvebu: turris_omnia: Enable
 poweroff command via sysreset in defconfig
Date: Thu,  4 Apr 2024 09:51:04 +0200
Message-ID: <20240404075107.19636-16-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240404075107.19636-1-kabel@kernel.org>
References: <20240404075107.19636-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Enable support for the poweroff command via sysreset for Turris Omnia.

Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 configs/turris_omnia_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 9d5171c6a8..0df0f3c90b 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -114,6 +115,7 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
 CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.43.2

