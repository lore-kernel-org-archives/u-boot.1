Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F388C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 13:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD1587E66;
	Fri,  9 Feb 2024 14:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCEDE87E6A; Fri,  9 Feb 2024 14:18:27 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D775887E63
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 14:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TWZDK36bqzDyF;
 Fri,  9 Feb 2024 14:18:25 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TWZDJ1SgLzr8d; Fri,  9 Feb 2024 14:18:24 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 09 Feb 2024 14:18:09 +0100
Subject: [PATCH] rockchip: ringneck-px30: put STM32_RST line in input mode
 instead of output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-ringneck-stm32-rst-input-v1-1-fa9d23ac8ebe@theobroma-systems.com>
X-B4-Tracking: v=1; b=H4sIABAmxmUC/x3MwQqDMAyA4VeRnA3Uzjn0VWSHUlMNwyhJHQPx3
 S07fof/P8FImQyG6gSlLxtvUtDUFcQlyEzIUzF451vnXY/KMgvFD1peHx7VMrLsR8YYmjil0L1
 SekLJd6XEv/96fF/XDae4tL5qAAAA
To: Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.12.4
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The STM32_RST line is routed to the ATtiny microcontroller
PA0/RESET/UPDI pin. By driving the PX30 SoC pin as GPIO output high, we
prevent external UPDI to be used for flashing without first putting this
pin as GPIO input, an extra step we could avoid in userspace.

There's an external hardware pull-up strong enough to keep the STM32_RST
state high on ATtiny side but weak enough it can be overridden by
external UPDI. This also means it is safe to use for the STM32 variant,
where STM32_RST line will be in the same state as if output high was
used.

The Q7 standard specifies that MFG_NC1 and MFG_NC2 (used for UPDI for
Ringneck) pins should neither be driven by the carrierboard, nor have
pull-up or pull-down resistors. This means this commit is safe to use
regardless of the carrierboard this module would be connected to
(provided it follows the Q7 standard).

Fixes: 6acdd63e8771 ("rockchip: ringneck-px30: always reset STM32 companion controller on boot")
Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 board/theobroma-systems/ringneck_px30/ringneck-px30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
index ff7e414303d..2ab1e7a12fa 100644
--- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
+++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
@@ -76,9 +76,9 @@ void spl_board_init(void)
 
 	mdelay(1);
 
-	ret = gpio_direction_output(STM32_RST, 1);
+	ret = gpio_direction_input(STM32_RST);
 	if (ret) {
-		debug("Failed to configure STM32_RST as output high\n");
+		debug("Failed to configure STM32_RST as input\n");
 		return;
 	}
 }

---
base-commit: a4650bf65e4b7d3ef04c90ba8031374428e4a682
change-id: 20240209-ringneck-stm32-rst-input-ca1cdfa67ff5

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>

