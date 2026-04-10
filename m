Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2981F44863
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A7384206;
	Fri, 10 Apr 2026 15:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="05p8R9xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A0F8419E; Fri, 10 Apr 2026 15:33:00 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F7B4841CD
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso21985375e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827978; x=1776432778;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mqD8wg/o3aOjH74OKLk9h8N1R36H89YNGYkFQoWJ5kI=;
 b=05p8R9xc19+anPNzxks+vR7Sggn0LnP+EVBwC3u75466bP/83ThXUe7t+j6wmpHV+a
 z0e/J9MjE7JQiMhLun7CxxlcNYLmPwPvQ1t8ANW9XOquJW8tYEPCaNnoZEmv/ZcceeYN
 pLprCTMuAGEYe/WbDIDMfWeRRp/0agO8sWBfjX8wnU+dX8OnjbGA8cMRfZQsXDpBc68/
 JgiRcJu9w8Jx0ojVTvSCl5IOujcVwCLNWPV1Nv2z5tLWQVuKx/zUAuMAlsKN93WQVEU7
 D26047eM8PDkBx4Of0VpDnH7MFr9V3CwqbxMlXqscigZpzE7hLDlLPhFoN6nFIxTxqKz
 jX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827978; x=1776432778;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mqD8wg/o3aOjH74OKLk9h8N1R36H89YNGYkFQoWJ5kI=;
 b=J4Vh5souBEPDBI1qTAI51mh5nmnMhASOk4vDCFHJ3TVmHy4l9TM3zRbQ1X9KtD5oxM
 LxXvKuy6M34c6Ag6/Xs/lKcvmglAWiBCfAaBoBo4Xdsk9RbM/RM5ba/IlB5SmFzPOJxt
 6BYj315tM0DIUN5ylhURPCE7FHNOn3HxOzBCNdpAfUNRJ6WaCFcjZor/dySkE4AeeIws
 MgQ58cZd2CCIVnwf6d5c2b2cQCPzNYtT1xE6QI9xADRjZ6VwzCvAtr/wxE8wQZQKD9f8
 fNGM35D/tfkWbIVCu0FH2IqcN5urXb0/E95lPcVGYyHQ6OtYKFkxXu5PZc29kZsmux87
 RwXg==
X-Gm-Message-State: AOJu0YysgVCSbLOeP2bNszjhlrfGQjP8RqpfhwmJrLHPJyKNYN1pOOOx
 QuFtbXtVYPHm65yzan2817D9kuisS6a+DWlz8keC5dnVxPAGXj1vPn/cPm5WBUPye0c=
X-Gm-Gg: AeBDievfmpKw4UCN8C38DK5CygJ5YjqdAOB4CdmRvuaQ2lt3g26qh65vNZXj+9ncLbg
 naYxEgx6DpYekIO21wKmI0Oz5EcND3VxlDBI/jdpjffnQs0SQvT2RbN4c1kMTsAOei7kORRf53L
 pxKftOB/QhUGkfzYp7xKeVwRL5BD1wn05wRgzTsZQo1woR6cr4Z+eVt+jRV6dBYt2pWN97OF+Tx
 w2t1vB9KKme+KWQOF0szYuqe67kQJc/RDqEO8K/nfqndfsEFQf5dSE98bWXMqbaZNTLgdc05161
 ZmzgOpKUE3jSSwyh7Q+HNrjjjC8XnUXXNfa85hX51rdO0g9p5iypIZZnFVF/IpZdbiFmitDAIKs
 CJIKpAxh90MO5rUKBbZ+8vpfanpxc963UHv/OJ/s4Hb5pdgYREqiU+Aow6pDuy6/h0vIAOM+pbG
 RK8BKraZXRBmsL80DDyLzj
X-Received: by 2002:a05:600c:8717:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-488d6816f5amr42633475e9.3.1775827977936; 
 Fri, 10 Apr 2026 06:32:57 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d6839981sm20076115e9.21.2026.04.10.06.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:32:57 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 15:31:46 +0200
Subject: [PATCH v5 06/12] am33xx: Avoid hard failure on USB probe issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-6-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=msp@baylibre.com;
 h=from:subject:message-id; bh=a9mNtkme71PbyJwqoxXU2jtKAgHiQS6mJbF3mtWckVE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbv+9c0RMxbNNX1kiOObo60uORR6TgKzdZ9vv/zeSsz
 8uKTTjTUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABNpCGP4ZyIYl31g9WYLoT8T
 5qjMnKrwfcWSlLOrk/eaH/9UorXjDx8jw5/1iWFiSoE72AytZ3+dWfOFIT2inn2q+w//K3F/ts/
 35AIA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Currently if USB fails to probe, U-Boot does not reach the console.

This patch does not fail if USB fails to probe making it easier to debug
in case of issues.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 4e9ad8935e3b5020c4ed1d022ae4846a2dc9486f..90b341303c7309dc21b34cc01020db997f53c8f3 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -266,12 +266,17 @@ int arch_misc_init(void)
 	struct udevice *dev;
 	int ret;
 
+	/*
+	 * Trigger probe of the UCLASS_MISC device which is a USB wrapper driver
+	 * ti-musb-wrapper that handles all usb host and gadget devices.
+	 */
 	ret = uclass_first_device_err(UCLASS_MISC, &dev);
 	if (ret)
-		return ret;
+		printf("Failed probing USB %d, continue without USB\n", ret);
 
 #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
-	usb_ether_init();
+	if (!ret)
+		usb_ether_init();
 #endif
 
 	return 0;

-- 
2.53.0

