Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75BAC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 23:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E47287F77;
	Tue, 27 Feb 2024 00:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wr25/+ff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6170E87F6B; Tue, 27 Feb 2024 00:08:46 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14BF87F6D
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 00:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b6e=KE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708988914; bh=LeviqRLdy0AHiFels+vv/SnQRkBDui4Y5RQQ70SOFlg=;
 b=wr25/+ffmBGlpnapZMLdWaVK3vq2c7lFAsFiIzDtbsu1XiDYWyX9e+gM0d7F7k9aSSGHBFj7q
 UD5zhbOMJidZ+tsW8DHOfVjKAWBS4BssSMU2VywCj5xteh6mERI+bUVUqAnS/wrx5tnmfiFiReV
 UajS8+yzwXzWwgAgsS/23VhrupV7LzVj4thkRD9aOY7AaxQ/GFng9tkYBl5fmY3C2TD0BNRXS5C
 taJAaw5a7sUmyl6SNtqBdrfNrNY4uxCU0JtIz5En0xLycE92+LC3JW/hMrOIA738EMeE0HhMfKs
 bgJVV3PNNWmjbaYHWW8Z+4p3onQ47f/DaNQD2pBGYtDg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 2/4] rockchip: board: Prepare for use of DM_USB_GADGET with
 DWC2_OTG
Date: Mon, 26 Feb 2024 23:08:14 +0000
Message-ID: <20240226230822.2430391-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226230822.2430391-1-jonas@kwiboo.se>
References: <20240226230822.2430391-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65dd19f181fb330034973f0c
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

The board_usb_init() and board_usb_cleanup() functions is always
included when USB_GADGET and USB_GADGET_DWC2_OTG is enabled.

Prepare for a change to use DM_USB_GADGET with DWC2_OTG by adding an
extra ifdef condition. The extra separate ifdef for USB_GADGET prepare
for next patch that adds a g_dnl_bind_fixup() function.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/board.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index dea5805c4665..f84ff542aea9 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -220,7 +220,8 @@ void enable_caches(void)
 }
 #endif
 
-#if defined(CONFIG_USB_GADGET) && defined(CONFIG_USB_GADGET_DWC2_OTG)
+#if IS_ENABLED(CONFIG_USB_GADGET)
+#if IS_ENABLED(CONFIG_USB_GADGET_DWC2_OTG) && !IS_ENABLED(CONFIG_DM_USB_GADGET)
 #include <usb.h>
 #include <linux/usb/otg.h>
 #include <usb/dwc2_udc.h>
@@ -296,6 +297,7 @@ int board_usb_cleanup(int index, enum usb_init_type init)
 	return 0;
 }
 #endif /* CONFIG_USB_GADGET_DWC2_OTG */
+#endif /* CONFIG_USB_GADGET */
 
 #if IS_ENABLED(CONFIG_FASTBOOT)
 int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
-- 
2.43.0

