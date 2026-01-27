Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EA1D2D8F9
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 11:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4308404D;
	Tue, 27 Jan 2026 12:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cs4cdK/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F57E84034; Tue, 27 Jan 2026 12:04:25 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B2D83FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 12:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so28433035e9.3
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769511863; x=1770116663;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=00MyFPXfO0hl8RV6AGM9V19fE30MZ9N3GzZPM51Gbn8=;
 b=cs4cdK/qlf/9rA5qJoHB+CfusedTldckkxGaQ9c9JsuJPVd6KZ/7trYyuo30Zjl73y
 RTcWcqd1RyuyV+BNAG1QwIGrdkqgHuSgW69+d0QDgf4kaGaGwD8A7XFodozP6shWBUIX
 pzb579rKhvyj48RomPqobk3VBOM2GsODQ9BUyeNmxR1TmoKgxKf6sndRXmpDVlI4JJIX
 OjQfxh0FiiDOGsrIagq52/agsqXX3O9eNX6h+RDtYHYhZhG9DXfKSm/orC2u89RcxQ82
 UPni2TYGYXd0sOWBMDtvlcxnhIhUyWMSucZiIr3GIcDYQkPDFNaiEsPCtg+UFe1LSQ1g
 lH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511863; x=1770116663;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=00MyFPXfO0hl8RV6AGM9V19fE30MZ9N3GzZPM51Gbn8=;
 b=EwlB2q1P+1G3ne34ySSKbkGpU+LrZc4muGVENM1MPB0COMPof9clpKYl1/F74zgATr
 RNN7r58enp4j3rRb01wKpkTciQsdijqwZgIOaryNYYyJnLq4yXONJUUXuOrbNtxBIFyJ
 tZ2qhPSYqANaiwswWPk8J8c7pIw21yb2IkMbNqXpfg7U+/+J2K151PVicjof8Dp9QwWi
 fi4d/Fyk2SV/juQWRDLZSI6rs/IJs2BX770TuDchBgFoDebU7gZJHLCcpG9VyuxWOuvs
 muOmcYxL8ohjBVRc9SctKCh0G+UzXJVh+qvBZkqDvyB88+z2xhmV38sz8jZHBt02TcsR
 Nfhw==
X-Gm-Message-State: AOJu0YwST5TAYekKpeEEjcTAwoFca/BNggeAJI9S0wMo3XN9lKuFMZj9
 4mBfw7dDx9+5GkzxfgxdVVW0ETgguGoC6rqudVMc+TxutUl9yOjBtBeJqhFZz14GMGM=
X-Gm-Gg: AZuq6aIl8co3UihKDxGdcSz/1D+1fMkDCVPjLtE5a388AsL328ytXCxw6a0LTu39gNu
 e7rS9P5XVamffZPcRx4UShqrukZcRrPR/PY6MoMoMVUHZCzghu03ELi7/O8cHPU40560S7Q21Yy
 kT6iw2EKriQAORvYVjddMWGt0LldDtECrh3GXmzLF2aDXEmPB+EzsFmqmXoSCqaGWo0N3u5aFmZ
 eBMi3m19QbtwtpRjTu2TuKwt4HMdAj1O3V/Ut6faq9np7ZdMVblMiKxkjewo9Cafz4AU6iSzZuq
 ulXGT4aSm5t+yeyBGwpIwR7iHz+EePEEJGUSH2B3sC5k40RTn3kwFryMyPG7iaFDKlCLp6oAshA
 PNsMZkIwclLQrwnze8PlNzqU51E2SuIIGOp6AwGEVmlIazu0ibDATum35ni+eN+D4QFJNUXhFrh
 r06bTGdTrc8ZmMIR2YJz0=
X-Received: by 2002:a05:600c:4592:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-48069c5b95bmr16093795e9.21.1769511862816; 
 Tue, 27 Jan 2026 03:04:22 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm58177325e9.14.2026.01.27.03.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:04:22 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 12:03:37 +0100
Subject: [PATCH v4 3/7] dm: core: Support multiple drivers with same
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-musb-probing-v2026-01-v4-3-ea3201e0f809@baylibre.com>
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4075; i=msp@baylibre.com;
 h=from:subject:message-id; bh=sDHfBBDag9Dr1ZVtAH+SDHNdChh+gf5H3kmoDbxTmi4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyK2TPdbb0EG0/H8AhaB23+L8RqmK0Vlrr17M+XZ+b6J
 fDVrw3uKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgInctmZk+PiCKXzLLPdvYfy5
 j3el+jk+maSpzek0aQdDedDWhvMn7Rn+Jz/9V1t0wmpm1vpfs66tWHjjs0metfZyX7uw5Rd/HTE
 LYAEA
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

Currently once a driver matched the compatible string of a device, other
drivers are ignored. If the first matching driver returns -ENODEV, no
other possibly matching drivers are iterated with that compatible of the
device. Instead the next compatible in the list of compatibles is
selected, assuming only one driver matches one compatible at a time.

To be able to use the bind function to return -ENODEV and continue
matching other drivers with the same compatible, move the for loop a bit
to continue the for loop after -ENODEV was returned. The loop had to be
adjusted a bit to still support the 'drv' argument properly. Some
simplifications were done as well.

The modification will only add additional loop iterations if -ENODEV is
returned. Otherwise the exit and continue conditions for the loop stay
the same and do not cause any additional iterations and should not
impact performance.

This is required for ti-musb-host and ti-musb-peripheral which both
match on the same device but differ based on the dr_mode DT property.
Depending on this property, the driver is either UCLASS_USB or
UCLASS_USB_GADGET_GENERIC. By checking the DT property in the bind
function and returning -ENODEV the other driver can probe instead.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Acked-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/lists.c | 65 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 9d1ca38212ee7f53b8894f964f096611c8ec20a5..813c3de52b23d78528686a7a8d9ecbe8cab62efd 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -235,50 +235,51 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 		log_debug("   - attempt to match compatible string '%s'\n",
 			  compat);
 
-		id = NULL;
 		for (entry = driver; entry != driver + n_ents; entry++) {
+			/* Search for drivers with matching drv or existing of_match */
 			if (drv) {
 				if (drv != entry)
 					continue;
-				if (!entry->of_match)
-					break;
+			} else if (!entry->of_match) {
+				continue;
 			}
-			ret = driver_check_compatible(entry->of_match, &id,
-						      compat);
-			if (!ret)
-				break;
-		}
-		if (entry == driver + n_ents)
-			continue;
 
-		if (pre_reloc_only) {
-			if (!ofnode_pre_reloc(node) &&
-			    !(entry->flags & DM_FLAG_PRE_RELOC)) {
-				log_debug("Skipping device pre-relocation\n");
-				return 0;
+			id = NULL;
+			if (entry->of_match) {
+				ret = driver_check_compatible(entry->of_match, &id,
+							      compat);
+				if (ret)
+					continue;
+				log_debug("   - found match at driver '%s' for '%s'\n",
+					  entry->name, id->compatible);
+			}
+
+			if (pre_reloc_only) {
+				if (!ofnode_pre_reloc(node) &&
+				    !(entry->flags & DM_FLAG_PRE_RELOC)) {
+					log_debug("Skipping device pre-relocation\n");
+					return 0;
+				}
+			}
+
+			ret = device_bind_with_driver_data(parent, entry, name,
+							   id ? id->data : 0, node,
+							   &dev);
+			if (!drv && ret == -ENODEV) {
+				log_debug("Driver '%s' refuses to bind\n", entry->name);
+				continue;
+			}
+			if (ret) {
+				dm_warn("Error binding driver '%s': %d\n", entry->name,
+					ret);
+				return log_msg_ret("bind", ret);
 			}
-		}
 
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
 			if (devp)
 				*devp = dev;
+
 			return 0;
 		}
-		break;
 	}
 
 	if (ret != -ENODEV)

-- 
2.51.0

