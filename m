Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F3DD1D879
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C0688902;
	Tue, 15 Oct 2024 17:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="D11UrMwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10DED889B8; Tue, 15 Oct 2024 17:27:27 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295FF88A47
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1729006039;
 bh=g121keW5Ll0NboPdBwdeAtdDyrTn+Ytm6LMiUP0iR+0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D11UrMwvxa47f3BaceNRWQdYaDwCGGIlrVlTlB3DxvYTpBvAj0oIQCJBSNDouYXZM
 /0aHWJlpjEiWr5yHBdVUgoGnFd8neo9cMIv/CmKiOLqukwXfb8mkAHuESIpxcRD7O0
 RcZVZ/dAjYxfdRHG/R1uoVcPne2EfO+3Gc7VDEpMXygMpg0uJK39dU7dXrJtkuTT4W
 flDBZ9gtP+CzOxaEVnojJhEJPqiFAK45OX9txYsea26Ng48c185UMQLpoAj19e7EOi
 NFSS1oe8to7qFvwpGEqNKw/MmzK/smxBTP6eAkwQe81u7hX9o+iaD3ebmsOpvdi1qi
 +KQTx84n5ZJ0w==
Received: from jupiter.universe (dyndsl-091-248-191-104.ewe-ip-backbone.de
 [91.248.191.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A0C9F17E362C;
 Tue, 15 Oct 2024 17:27:19 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 2238D4800FE; Tue, 15 Oct 2024 17:27:19 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v7 5/6] rockchip: rock5b-rk3588: Enable USB-C PD support
Date: Tue, 15 Oct 2024 17:26:47 +0200
Message-ID: <20241015152719.88678-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015152719.88678-1-sebastian.reichel@collabora.com>
References: <20241015152719.88678-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
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

Now that all code has been prepared update the default configuration to
make use of it.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Tested-by: Soeren Moch <smoch@web.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 configs/rock5b-rk3588_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index dd360d5ad58a..6bea782e2ee8 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -24,6 +24,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -103,3 +104,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
+CONFIG_TYPEC_TCPM=y
+CONFIG_TYPEC_FUSB302=y
+CONFIG_CMD_TCPM=y
-- 
2.45.2

