Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120EEC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 20:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93BBB83B0E;
	Fri,  1 Aug 2025 22:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jbgHcOl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD1A83B34; Fri,  1 Aug 2025 22:36:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net
 [IPv6:2a02:6ea0:d71e::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6384E83B0D
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 22:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754080390; bh=gnjPfI+I/tIp4362dnDNyn9VdPccrQcDlXyXqEKnLko=;
 b=jbgHcOl35FzP0JKWzlCoLtDUZiHx+FhaLVl+MrvVH9l/DZ38+9EJoZBsb5H3ctIlNmAETzuwN
 2HfqwUckvDk1Ooe9X1S6q0KLXubpR9srd6TrYZLL5qSL6pSOfbsmYJs1HGmcXk5UsiZDKE/ZsnU
 I9GR285W3rCKSMG1sqzU+MI1DPUZY04mzLi3OOm8IqjnoTPSIeHNjF6v+nCRspemIXsnwjVvKVc
 TdTVK1rcz0id5M45oplqcjBpQ9ecwn6cJ4ZBKvfCWXjVZcfdTPuSDlu1sQPJazMhBH7GXoOR1cE
 srMayYtzpYGy2vX5oGuOCVRSS70GDYyLnYTtLzflZrOw==
X-Forward-Email-ID: 688d248303c11ad40176087c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
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
Subject: [PATCH v3 2/8] rockchip: Add default USB_GADGET_PRODUCT_NUM for RK3576
Date: Fri,  1 Aug 2025 20:32:38 +0000
Message-ID: <20250801203255.2590535-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801203255.2590535-1-jonas@kwiboo.se>
References: <20250801203255.2590535-1-jonas@kwiboo.se>
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
v3: Collect r-b tag
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
2.50.1

