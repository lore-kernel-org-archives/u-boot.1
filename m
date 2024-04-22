Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44012C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B2988333;
	Mon, 22 Apr 2024 08:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dS6tEC+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A254588333; Mon, 22 Apr 2024 08:31:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B70788329
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767456; bh=Uy/Qy4M5LI641pyhvYRjKKRZ+h/xc7qwa3/sPdiroRw=;
 b=dS6tEC+2uV45qEtpDFgOuKYkEna+F44wk/Bf6iS6kXILdGnKU6rvqO0doYiQzs1gVhf2E1xyN
 t1bJJm1AJIQVzFJoD4+vdtwh5a2IKoH+gUXoz0RJS37vd2zboB9yIljdPgJYGOHbAwT56jfHqZn
 wEO78EUmmw2U7j1MheSCUAdSbtry2xapEU2FWf5Ok2vo88mLMDVrGN7OlqWe6JO8iBmQLSJH37N
 FcHy+keHn0qKe26bvVeOPrBTRCuB4hd6Js5zoaUI6JGzWtJ4N+TVv389SYDAzdjzvrwW8xABQcu
 1I6m+G7hDUNtBNl931HcPZkQ4P1ohrmCzufhwpNlR5Ug==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Joshua Riek <jjriek@verizon.net>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 21/28] rockchip: rk3588-turing-rk1: Use dwc3-generic driver
Date: Mon, 22 Apr 2024 06:28:58 +0000
Message-ID: <20240422062936.681359-22-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6626042034ba165ad447441c
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

RK35xx boards are expected to use the dwc3-generic driver and not the
xhci-dwc3 driver.

Remove the USB_XHCI_DWC3 option to ensure that the dwc3-generic driver
is used.

Fixes: 153ac950a599 ("board: rockchip: Add the Turing RK1 SoM")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: No change
v2: Drop change to enable the DWC_AHCI option
---
 configs/turing-rk1-rk3588_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 77aacbc64b6c..5a86c7eacc8d 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -90,7 +90,6 @@ CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_PCI=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
-- 
2.43.2

