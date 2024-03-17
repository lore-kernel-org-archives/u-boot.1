Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6070C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 14:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D8687EDF;
	Sun, 17 Mar 2024 15:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sGPu62gA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B58887D06; Sun, 17 Mar 2024 15:54:55 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AEEC87D7C
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 15:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4EDA5CE0922;
 Sun, 17 Mar 2024 14:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B836C43399;
 Sun, 17 Mar 2024 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710687289;
 bh=guYFFkwoi5nrMtCwr4mxXFtCimym0iwxXVwrtBJ9+IA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=sGPu62gAkzpTMZ89dAqFTYMLDn43NfgdSUQZjObkHUCs4VSv4p+p1wiLB93p68RQ5
 SJ42/SQ8phciHvyasr4xTW5psfhNrQGEJJI8/6eF0Y6HhYzoc0NDLPr07c2Nj3RM4p
 RbaWix3yqWwXN10lV3sAIH+XF2F4KobLAX+hqXDD1ohcibF1YGShoTYlSOBLjCvU30
 tFmbhfCw3jYuhvW8g4Ypm7O5c7KOW7aCbqsLFYpoWUbNU6+UMfsn4Wa2FUFT5BdgPz
 YxLoh/axgknYmllERezVKUXSTlEEfWIUEHWaZOUykuOsJ/7z01Mjp5Q/Mj6kJvSRFr
 K1TqfNOjbqzoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F8C54E69;
 Sun, 17 Mar 2024 14:54:49 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sun, 17 Mar 2024 15:54:49 +0100
Subject: [PATCH 3/4] configs: apple: Enable CMD_SELECT_FONT and FONT_16X32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-apple_config-v1-3-1b862bc140a9@jannau.net>
References: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
In-Reply-To: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=j@jannau.net;
 h=from:subject:message-id; bh=efBW9m/mjVxxFme0pO4/bQ8IJkWzsIngZn6mrb/lwgQ=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtTvLBa9V3Zy/5YRKpim0BLYFKu5dt/mlUa7W09O/PYy1
 uirjV13RykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIn072NkWPd/T50ry6QpsfP9
 2V/1+XGtZ2DkUK6blTe1XG3nIrm+IkaG2b3TFs+/wPRGSjPE2dz0ddCCOLMLnbLTqo7m6twLU1X
 mAAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

Apple devices have high DPI displays so the larger fonts are preferable
for improved readability. This does not yet change the used font based
on the display's pixel density so the standard 8x16 font is still used
by default.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 configs/apple_m1_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
index 31d966f0ab..c30aec7c55 100644
--- a/configs/apple_m1_defconfig
+++ b/configs/apple_m1_defconfig
@@ -9,6 +9,7 @@ CONFIG_SYS_PBSIZE=276
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_LATE_INIT=y
+CONFIG_CMD_SELECT_FONT=y
 # CONFIG_NET is not set
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_APPLE_SPI_KEYB=y
@@ -19,6 +20,7 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_PCI=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_VIDEO_FONT_16X32=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y

-- 
2.44.0

