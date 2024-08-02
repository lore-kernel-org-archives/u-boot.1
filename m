Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C425C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 18:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B107C88C2A;
	Fri,  2 Aug 2024 20:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Kv9k3fFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CE888BF2; Fri,  2 Aug 2024 20:00:37 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7310188BF6
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 20:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1722621628;
 bh=tcdwcpppJi/70uatY9Y4GzuwoGY03a5rxe+Y/chCNY4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kv9k3fFmXOTJYc/oYmIJQnBr2yo0yVhwzEosuR44rjvpP9XpSWVxUhylZodf7b4Fs
 awh2K8wZhKR+J3HBH++HTIL8VN1GEEq3qYZ9NjRLI0vIDJ2gUJcYMQzwCFpdPAKm+S
 yrq1YCE5jymt+jvzLCeFY6Qn7TTiQVoVWfgjirEm1Tb4kWtg4adisGriK7RjYuhvoS
 Bj7b4MCke65+k6Td5OTAefA4V7ZtLSNyZ9v+w/3TWBLPtoXMBWfekjLwkb/fUkKd0x
 92SoH5kAyb+y821lNCwNuf6DsX5MhZrWTMnftcKA4AtuXneieGeeWPZNuXLMOPQLfm
 rr8MnE9ajyxEQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id C1DB6378221F;
 Fri,  2 Aug 2024 18:00:28 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id D53D54800F8; Fri, 02 Aug 2024 20:00:27 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 6/7] rockchip: rock5b-rk3588: Enable USB-C PD support
Date: Fri,  2 Aug 2024 19:59:36 +0200
Message-ID: <20240802180027.139193-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802180027.139193-1-sebastian.reichel@collabora.com>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
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

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 configs/rock5b-rk3588_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index fc118cea7bae..f056728d338b 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -23,6 +23,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -102,3 +103,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
+CONFIG_TYPEC_TCPM=y
+CONFIG_TYPEC_FUSB302=y
+CONFIG_MISC_INIT_R=y
+CONFIG_CMD_TCPM=y
-- 
2.43.0

