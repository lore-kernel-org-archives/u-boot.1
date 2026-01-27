Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA935D340BC
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE0884198;
	Tue, 27 Jan 2026 17:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T4rpLCX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED1428418E; Tue, 27 Jan 2026 17:51:16 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5256D84178
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so4386658f8f.1
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769532674; x=1770137474;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m+eYQmjHT7WxUdO3a+o4Hqo3neUT8WLQCVpK0McPJro=;
 b=T4rpLCX19135xPUxISBJA/PmLP/dY3mn7ODyp4RsyyL4LvYdqebBx2WPki1tmwP6W/
 d06smJkVuAvYS3LEy/0pDKaXTZYoXYRM30R7EbRbhQi5pm+De5Te4WuqzOh6A6s86oTw
 hzbKYOKekoWq3zcybf60S/PbxGo9oMQMakLPO8exnvVfEE/ZBBB2Pnpv9/ZpxqAncAI6
 rAM1Xk6svloJoUAf2g+91iMPNFpDuhedO6KzZY8pMMYtC+RuFVR0aRPoE1LkpWJnzbpD
 +iKgBseyZvaX+hcQU5iDCpcVE6PDTDzHUtaJEA6ulEcgMK7Tn8Vd8fc8dy0I9TrDt6R9
 ER8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532674; x=1770137474;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m+eYQmjHT7WxUdO3a+o4Hqo3neUT8WLQCVpK0McPJro=;
 b=MZmW5WNK/6MNzH7kIHMzzzaeC57DqkNt9vAwFhKu6yxRkFv1XQBcmLZ1skzXP2P7Cg
 7fj+owlP48NG/MiNfDRq6iW1CEV/6LUXE92Wr3S+o7YDsoiKzQbu/kix88sjOOGwGY1H
 LTK10iGx3akh0LOHiuqi4CyJk0jPVwR3bnz/0A0UvAqwAErMaieLE7ddfXS62JIF8HV7
 0Ixy/Zt2LXR+fn2SUAy8JzrTYNMUwPMB5D1V9EhRff8dP7UCfWx1S618oIM/tJQ0nZLz
 tQAXyts04R2dqUo0t9Sevxgy+uO/xDyCnIuoGTyrkfNEJCyFcB+R9hGqODfWensGhxnF
 gF/A==
X-Gm-Message-State: AOJu0YwD1dvwLsfZ5DiTMJtaC43TyDVuxNw6IyG2ektFtIemtkNF9RY3
 qWC4+jPllQQhNpWC4olvqYtP3nfI7vtpUyMcX4qpzx8aG3TNrsdbt6nH2dkUGUHLc7I=
X-Gm-Gg: AZuq6aLdrG+dXJx53Lk4qjlk0iOecTvgFsjDN1YsZzVhEg9JnHw3gsIk2ZZsWS99XYs
 k5Lue7oObOz/XZ9qYrPcH8upCqaeT2RcuR6Uqx7y3YMIOT9woDgiOdR9PAFXIcPBD4a+kW4oqHk
 vjto5sm4oPokkZQeh00CInTUkGfY031oF8x03UJgaEwx3NWVY4YR38dlcZ5pD0PfxRcxgIwrZtP
 8yu53pDuV4VtV7SH8USOuG0Xtq+aSi9PewZZe8wL9Tb+9rbKGpJTDd1geQ3eifQgS55mPsP7X0i
 QWG8/XyPVKrt2JU4ptKD36J1gIXx4bG2+e0uXPEIJJGxEQQQZlsIHKwlOQ056Fj83qNq7r8BShj
 xjAznmoSRKX0qGaCP+YDgmFIVNkdiaqKly+tC8LHjfVFaP1ibeI63G+K5CXQkJ3aQDwxwnMcQ2J
 TDB2w8VtMn
X-Received: by 2002:a5d:5f56:0:b0:42b:2dfd:5350 with SMTP id
 ffacd0b85a97d-435dd1d92a1mr3272175f8f.56.1769532673672; 
 Tue, 27 Jan 2026 08:51:13 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354d43sm9824f8f.43.2026.01.27.08.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:51:13 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 17:48:20 +0100
Subject: [PATCH v4 06/10] am33xx: Avoid hard failure on USB probe issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-am33-evm-oftree-v2026-01-v4-6-0dadb0710ce7@baylibre.com>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=msp@baylibre.com;
 h=from:subject:message-id; bh=aALfAHc1GZdv6yEnUOoea7sPCPCfOFyT8G0rOEdSfY8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyKN5eZQhdFeHQ8sw1k6/jM2zmD97aRr5/dQXW1bjZtp
 p/2O591lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwEQOzmBkmB8+w6E0WP4r5860
 36bhm9yiP9z+vKPjZZJ50fWip8eWvWX4XzCzc/mXRXtFJiRJq0Z85vogkcTfuXnpPW2DLTOfvTj
 eygUA
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
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
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
2.51.0

