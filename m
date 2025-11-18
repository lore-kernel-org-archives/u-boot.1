Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E845CED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45D183E0B;
	Tue, 18 Nov 2025 14:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dLXA7y00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F7483CE8; Tue, 18 Nov 2025 11:42:26 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC9383CF3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b73545723ebso957814966b.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462544; x=1764067344;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mpKjS3M3rM9RKB3wRTEiBn4P5Eu1c+GXMyKW+/dod08=;
 b=dLXA7y00jg8wvGmb///2iewh3uROJbjTMK5jQZidWpr5NlaEuQi0UE+Bi4/dIDg0tx
 NGT9Nv4z6C2dxzGGmrXLmf+91WQkvwv3L/K7f95SrSMyseGTaTNItMD4aRiQGWapsPE9
 +ahlY2A26bYYa9Qhb+MLQe0yBgPW+xjjlJhSFrkYwjaQVRcIjYhspMdUKbKRhy/eFPfC
 TXt2jlO9iPmMFA5OESnTgoMS2keITRPOe3kNupK+qpcPW7w0oqhcOnNEB5XTcmMBhuI0
 z9TLKcgO4Uh2l5bhbH/HccZV7im8UnABKhs9sQGj078TXoKNs+adR7OUxaDrIuI9eNze
 jGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462544; x=1764067344;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mpKjS3M3rM9RKB3wRTEiBn4P5Eu1c+GXMyKW+/dod08=;
 b=vhlwllwtzwHrSia1xxvDc1vFDFPB19HKDyQ56Lp5FqnRZpIBmSNi1L7RRpVDTYs692
 9nJe/dOwThCsQxSZygqun2A+VFbcRoWQCriwOzmZR4ckeao3cJVrYH3xAYgUa0SSXIJi
 Y9rHj454+gxuOZcEpN7AOzQDbGr6DawvHLGO4X6IdCesJJ74qwuNiOwbF9igpmD0bJuJ
 sZpbLgoUXDFTcTomJ2mY48ksDvNqDncnmLaBez3ndEYXF+KtVaBGV9KfHrhLO3yFKeLC
 FM9B4IFDGGmi0YcyQopfH9M6f8dudlhh5uHa2ioO1kW+jT6pF1u+h+gDTk2PMOHQpA9+
 M5cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7t91tnQJ0Vw6wIYv9p5MSK1RPkZAya/txFxVIvbucrLMh7Ns8sO+/flEv+Q/7yk8kydiTRiQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0TNB/s0rz9EjGbCDu3/bmbWdg1czZpWFIxYWAubqQT60qR55C
 JkWdVmFRKApbYpfVJT+JVaWgI7wEZ/E9mlv42ugsDGiTU7xm1HIaDyxYYXBetTWCnPQ=
X-Gm-Gg: ASbGnctNdxLG7CaXS8jRCiPb0tyqn1EQ36uG+fOE8If1mzR12MSOmMvswy4JzpHN43e
 9zIiT+Ay6576edozG7yRZKGDlIs4Y8YJotIaLHjTlZCLLOwHoaYBOiEcmdRr6FN9oy78QoqT3hZ
 aaFtJyjCTgJOs3bFntXo7/B5Jr0/35yt4m64qOJkThCcdbP2AtLuYuEIV+1q2voiGlWpOrtuR/f
 Lo7gWkFXQQLlR92238Ge/DPNh7SOm+K8wt/2dEWUwIEB6cuTW2RzeGd06A9PcFYZyv+tneWSJJY
 2bAfGKckIIpqZjVD/wOyAq3aOimKtzXvd1RWpgJvaBNH3Ud5PKTZQF8qkN4n4vDwzPRTblOmm2j
 XCxzFU4ooB3/59QRVIe5CNEE+8y6xo9m/Km8aaTFta17qHK2RL9Z04LVGa8CFRBuNS86/grnSny
 P2hDAOizI=
X-Google-Smtp-Source: AGHT+IHuGNHoqv/FDX4NFc7uT9T6TCBTKmg5OvXLG7dC+dm+i9wKGVYCeK9lS+sGgfetatl6d2Cm9Q==
X-Received: by 2002:a17:907:6d08:b0:b72:aa52:6034 with SMTP id
 a640c23a62f3a-b73678969c0mr1528015666b.21.1763462543562; 
 Tue, 18 Nov 2025 02:42:23 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fa80e3fsm1342668266b.2.2025.11.18.02.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:22 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:28 +0100
Subject: [PATCH 08/15] dm: core: Support multiple drivers with same compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3498; i=msp@baylibre.com;
 h=from:subject:message-id; bh=wBfgyl1xfgpyJReq6elItJyYIlzMB9+0XL3RGJlFxfg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZ38hULv1UfsGQI5vORs5zqLfWinb93vB0Xsic3FS1i
 IKARM6OUhYGMS4GWTFFls7E0LT/8juPJS9athlmDisTyBAGLk4BmEjkfYbf7PnXbq/P9fM4czzh
 3LI05eeV4uUvDVeEiZc62P8O2aoQzPBPNdfMjPdt1taLd/ISPH8pFkdwTe+4rOUTuECzrMQ5q4Y
 bAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

Currently once a driver matched the compatible string of a device, other
drivers are ignored. If the first matching driver returns -ENODEV, no
other possibly matching drivers are iterated with that compatible of the
device. Instead the next compatible in the list of compatibles is
selected, assuming only one driver matches one compatible at a time.

To be able to use the bind function to return -ENODEV and continue
matching other drivers with the same compatible, move the for loop a bit
to continue the for loop after -ENODEV was returned.

This is required for ti-musb-host and ti-musb-peripheral which both
match on the same device but differ based on the dr_mode DT property.
Depending on this property, the driver is either UCLASS_USB or
UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
function and returning -ENODEV the other driver can probe instead.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/lists.c | 62 +++++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index c7be504b6fc69ec2870a6766eed35cb9eba46a97..144e31286b3bb53a90b4f8bb0d3fba6e25a47f9e 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -237,8 +237,9 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 		log_debug("   - attempt to match compatible string '%s'\n",
 			  compat);
 
-		id = NULL;
 		for (entry = driver; entry != driver + n_ents; entry++) {
+			id = NULL;
+
 			if (drv) {
 				if (drv != entry)
 					continue;
@@ -247,39 +248,40 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 			}
 			ret = driver_check_compatible(entry->of_match, &id,
 						      compat);
-			if (!ret)
-				break;
+			if (ret)
+				continue;
+			if (pre_reloc_only) {
+				if (!ofnode_pre_reloc(node) &&
+				    !(entry->flags & DM_FLAG_PRE_RELOC)) {
+					log_debug("Skipping device pre-relocation\n");
+					return 0;
+				}
+			}
+
+			if (entry->of_match)
+				log_debug("   - found match at driver '%s' for '%s'\n",
+					  entry->name, id->compatible);
+			ret = device_bind_with_driver_data(parent, entry, name,
+							   id ? id->data : 0, node,
+							   &dev);
+			if (ret == -ENODEV) {
+				log_debug("Driver '%s' refuses to bind\n", entry->name);
+				continue;
+			}
+			if (ret) {
+				dm_warn("Error binding driver '%s': %d\n", entry->name,
+					ret);
+				return log_msg_ret("bind", ret);
+			}
+
+			found = true;
+			if (devp)
+				*devp = dev;
+			break;
 		}
 		if (entry == driver + n_ents)
 			continue;
 
-		if (pre_reloc_only) {
-			if (!ofnode_pre_reloc(node) &&
-			    !(entry->flags & DM_FLAG_PRE_RELOC)) {
-				log_debug("Skipping device pre-relocation\n");
-				return 0;
-			}
-		}
-
-		if (entry->of_match)
-			log_debug("   - found match at driver '%s' for '%s'\n",
-				  entry->name, id->compatible);
-		ret = device_bind_with_driver_data(parent, entry, name,
-						   id ? id->data : 0, node,
-						   &dev);
-		if (ret == -ENODEV) {
-			log_debug("Driver '%s' refuses to bind\n", entry->name);
-			continue;
-		}
-		if (ret) {
-			dm_warn("Error binding driver '%s': %d\n", entry->name,
-				ret);
-			return log_msg_ret("bind", ret);
-		} else {
-			found = true;
-			if (devp)
-				*devp = dev;
-		}
 		break;
 	}
 

-- 
2.51.0

