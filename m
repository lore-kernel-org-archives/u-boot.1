Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38BEC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 22:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7073D82F6F;
	Sat, 12 Jul 2025 00:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vlUWLqzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA9EE82F6F; Sat, 12 Jul 2025 00:21:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFBA882C7F
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 00:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752272515; bh=4nXAQ96BqOrt7ybXh3IAJYMlKrtQwRZrGaqQacu8AwM=;
 b=vlUWLqzJrtcwQIdkFRXNSHM86TzozRLP7kjz4P6gIu/HagTLphiAA1gszrQlfQVaNggJ4SMdy
 7Gw29GyQ9aFoYSiRHLDPJN/Q6wDdNWIq/AM6bCfqLb60S7L2j1KcenCiqj96Vdup1d/s3S7SBA2
 iVcN+qR1BrEDAQKDjAg3pzc5YD41HdXjmCUdl9P/bfCJFPKivDQMNnms/1kbzKzzWyRrruWtv5J
 m5OtXFM3FkfxQ0gIhLfIPNHmQsV1dSpVnws6RUnMByX6b+B7lF2MVfI3M/zbjFrBL2/BXA5DQ5a
 SPreDkHDCVj1H4lQdbYndRLXnDOh7fzDz2eSNZ8lg+3Q==
X-Forward-Email-ID: 68718e7d26dc7c4d2555fd21
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/6] rockchip: Add default USB_GADGET_PRODUCT_NUM for RK3576
Date: Fri, 11 Jul 2025 22:21:18 +0000
Message-ID: <20250711222132.204344-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711222132.204344-1-jonas@kwiboo.se>
References: <20250711222132.204344-1-jonas@kwiboo.se>
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

Use 0x350e as the default USB Product ID for Rockchip RK3576, same PID
being used by the BootROM when the device is in MASKROM mode.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 drivers/usb/gadget/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 46a83141481f..bab88567ea62 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -86,6 +86,7 @@ config USB_GADGET_PRODUCT_NUM
 	default 0x350a if ROCKCHIP_RK3568
 	default 0x350b if ROCKCHIP_RK3588
 	default 0x350c if ROCKCHIP_RK3528
+	default 0x350e if ROCKCHIP_RK3576
 	default 0x0
 	help
 	  Product ID of the USB device emulated, reported to the host device.
-- 
2.49.0

