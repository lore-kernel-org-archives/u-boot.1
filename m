Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43740C48260
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A691787E9B;
	Sat, 17 Feb 2024 01:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XKumDlic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3281987EA6; Sat, 17 Feb 2024 01:26:40 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F6F87E94
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708129434; bh=+rRZBzsLGqE0/e43S7sVmy+WERVum4DQ0ogNeCg6XPQ=;
 b=XKumDlick+Zdwr2zGXmdkI9xaKSx7aHmRlSOIN8XKzEJHnItXOF+cAbEe2eBdGfEfm9n4/jUQ
 cQKSGMFqtsgUqCMgQLJdNBMsorKeTrflpw17YSbbcEjNQ1UCK6eAcQQmv3EXALRTgf7W83z/2NA
 I6bIXnpmAzmBMWG2wHXGlmutkliBg1GNyIJLIKrpMaElty+66HS2/vNbb1aWGCcSiHeQKyJgfhJ
 brnkIENXb0prbBg2wNpBcsbJ5aG3GVohKI+Ig99Qq0gcDXsVFeMQiFtiXWwII+jaYLflF4LriHt
 TBTrnqfJE0FkGgC9EhUxUJGGfutvAtvUJn5r5P1mY5KA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 09/15] gpio: rockchip: Use gpio alias id as gpio bank id
Date: Sat, 17 Feb 2024 00:22:35 +0000
Message-ID: <20240217002304.2141064-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217002304.2141064-1-jonas@kwiboo.se>
References: <20240217002304.2141064-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65cffc98bb96cee8b5411f21
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

The U-Boot driver try to base the gpio bank id on the gpio-ranges prop
and fall back to base the bank id on the node name. However, the linux
driver try to base the bank id on the gpio alias id and fall back on
node order.

This can cause issues when SoC DT is synced from linux and gpioX@ nodes
has been renamed to gpio@ and gpio-ranges or a SoC specific alias has
not been assigned.

Try to use the gpio alias id as first fallback when a gpio-ranges prop
is missing to ease sync of updated SoC DT. Keep the current fallback on
node name as a third fallback to not affect any existing unsynced DT.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- No change
---
 drivers/gpio/rk_gpio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
index 4a6ae554bf78..24fedd456353 100644
--- a/drivers/gpio/rk_gpio.c
+++ b/drivers/gpio/rk_gpio.c
@@ -201,8 +201,11 @@ static int rockchip_gpio_probe(struct udevice *dev)
 		priv->bank = args.args[1] / ROCKCHIP_GPIOS_PER_BANK;
 	} else {
 		uc_priv->gpio_count = ROCKCHIP_GPIOS_PER_BANK;
-		end = strrchr(dev->name, '@');
-		priv->bank = trailing_strtoln(dev->name, end);
+		ret = dev_read_alias_seq(dev, &priv->bank);
+		if (ret) {
+			end = strrchr(dev->name, '@');
+			priv->bank = trailing_strtoln(dev->name, end);
+		}
 	}
 
 	priv->name[0] = 'A' + priv->bank;
-- 
2.43.0

