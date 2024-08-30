Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C7DCA0EDC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 18:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4768088D0F;
	Fri, 30 Aug 2024 20:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="erYjbbrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E53488D2E; Fri, 30 Aug 2024 20:23:37 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C125088D04
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 20:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1725042211;
 bh=/p0nIa9V+Onrv+t1pPYfXsNuedhsWOLhCny7CotvE30=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=erYjbbrwhdaCtbx89hsqMN9KsFbaGSPmEuaE/YPj6vjrP08mq55zmwJFSxP/OYoxp
 9r1gFW6v7ULH7RQwBjImxu6inpSUcp9AJ/uUC4tTimZ6+rJj2ZhFuAXQ43+CsNXpia
 3Km85I6m9w8FfXNPB9PaaaQ8UeTKQ17IZHI4fxqRV2Wu1SeqpHt1vl7kQh+zGE6u0q
 dZuuc0KnCVF0aeHVWkPSPZM2nNGRpEuvrKLfKZScvDpygl8+C4PopU5U4XDXMbWxQN
 zbKpZXHYbo4mX57CmivveVVgPwyXmci2o1W3HNGQa1KfOcqDfPyWnJqYdHcabsJfhK
 0cvBt2EjO9ugw==
Received: from jupiter.universe (dyndsl-091-248-208-243.ewe-ip-backbone.de
 [91.248.208.243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 39EB917E10E0;
 Fri, 30 Aug 2024 20:23:31 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id A37914800FF; Fri, 30 Aug 2024 20:23:30 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 5/6] rockchip: rock5b-rk3588: Enable USB-C PD support
Date: Fri, 30 Aug 2024 20:22:19 +0200
Message-ID: <20240830182330.49528-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830182330.49528-1-sebastian.reichel@collabora.com>
References: <20240830182330.49528-1-sebastian.reichel@collabora.com>
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
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 configs/rock5b-rk3588_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 80a2f2fed586..82c942a52d62 100644
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
@@ -103,3 +104,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
+CONFIG_TYPEC_TCPM=y
+CONFIG_TYPEC_FUSB302=y
+CONFIG_CMD_TCPM=y
-- 
2.45.2

