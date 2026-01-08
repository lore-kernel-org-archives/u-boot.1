Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679ACD185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E12841B1;
	Thu,  8 Jan 2026 14:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b7bmSFU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F2683B8A; Thu,  8 Jan 2026 12:17:35 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A0684113
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b73161849e1so550257366b.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 03:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767871048; x=1768475848;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mNv5xVUvIuzs9TkGexX1tWFnpzgx6UMM+8rhDwJWbYU=;
 b=b7bmSFU6uCpfheZ6GtU/oQamxTiP6oD3IpUaNEY6NIl+m9q/3kh07KozCPsdo7Sik8
 CUmWxi0czTS6/7pxnC+ORyoybc+Hp3hN8Z50YJwdVU6MhdGdB1mzpmVdYv5axcx2Yu9Q
 Y21I7tseCUKPnYEKeTrCVjPvC1NswwHk/ZsLO/UNFRxzW+nZJ7dO9oLvyj3LuPMrQcO8
 /eNQUu41X2SbONKmWYW0PEuaBRg6gZubL/+1qMzjTPWjTkTBRV+P6xjnkM7SO4HoW5E7
 oEI1xabT+rfWghP8tHgdoDA2J9HEu70I+vaT+Mra8b+vUKosBuBUUzPjgnbWZFdRT1rZ
 E2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871048; x=1768475848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mNv5xVUvIuzs9TkGexX1tWFnpzgx6UMM+8rhDwJWbYU=;
 b=Zz2ZAAx5dEe8aBCzmNoSklIIixDMEtzn/RXL7gaB5Jcb4pyffQnp2h22DyjYnEpfah
 PwhgxzMn0EHX2btSsWuVUxkQqXmcSQtyAmP3hStO3+CYE2JaRYdLgcUrOWQkGpIcj3qE
 uMYLaumXNE0qYwkzpVqK1aFjf4OcrYxV8j1iPmOg6I0mdszDqnKL4karT76HZUHJcl0c
 N63zm1yhAKXyjBD3FSs9jSr3TSYz5xuhE2elcd0heH5J/WgVEPBN0QsLzeXdJcjGOs16
 m5P4baaXN16nLOsmxJxD/zLq4GnikZ6AzSm9rYQP6OyopeIx0jdd/5mr2FKWcV0rtfVG
 U+eQ==
X-Gm-Message-State: AOJu0Yw4NzTjUsVvd/t553nO6ISxv9OHSLSYQlAVkVayC4WFeXjKt1fz
 66PPmWwzwOeQwL51bwbHpw0kxWUp0JYVJecQ0KUQtk34ZJgKIE3KxDMIuGdtxspAuh4=
X-Gm-Gg: AY/fxX78iF1N8FGgmXcJ2a+vOSdhpz4Nrddn1GF9mo7M3q/eAWiH1JCvxIryMtNKxpC
 jYaxQaF0DZOv4X++UmJBXk8khHfnn2EFcRlwaSjA0i6Loqfby7S8l8OJd3JzTvdNvv6kbrYEJT2
 aJZYw5K3bOohxGYl1i4ennfElxXhTtSpKYG1n5spA/4M18alWY8GWXpTkSQ65AbzVaqPcajmh2i
 Od3De8Ou8m2KPnCC2Rv2DGmE4omwY+6vnWXU38YAqze+JoSLaM6yutu4M6/rHNcn4MvhAjuzckn
 6UPUgkSXPL9sCxqc3i377JDO5/nbDYVX6cMD2qDynrTBcq3CcIhWXcrAAH9eRriw6gHVb0q4hDa
 oEg5LKeT4Jk1D4n+/1wWAlU0DcB6ZYJOvGW15aOySNvHDuopf13dX6QB93UcIVArWLBF9VECuB4
 PSok9Srm3I
X-Google-Smtp-Source: AGHT+IF4QwFvECEdamew6JvGxKAplOMEYw/MyutTcqMmHDwpxcm9QF2VEBHGL6Z0W8JgK4BqNvWiMg==
X-Received: by 2002:a17:907:7fa5:b0:b83:95c8:15d0 with SMTP id
 a640c23a62f3a-b84453eb335mr494978566b.52.1767871047970; 
 Thu, 08 Jan 2026 03:17:27 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a5641casm824979066b.64.2026.01.08.03.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 03:17:27 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 08 Jan 2026 12:16:29 +0100
Subject: [PATCH v2 3/6] dm: core: Support multiple drivers with same
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-topic-musb-probing-v2026-01-v2-3-2a47c6e0e73a@baylibre.com>
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
In-Reply-To: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3742; i=msp@baylibre.com;
 h=from:subject:message-id; bh=tbgVUqSDEqqsmJ80BhW07lwxwUXQSOc6zhXg53Q/DZc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz4SXpbq+eyT/TUXFi4nVNuwm2ugnD523cvebO47J1QH
 +t/xnxTRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzE+APDP6XSIhOLnJdfhcwr
 ZW+56pbYc8x5wDNZ9IbL73klDbmFrowMU5r23vu79OOr4/c0mmyZLif7iT5SvtpuGF7fdpQ5b9d
 +dgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:16 +0100
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
simplifications where done as well.

This is required for ti-musb-host and ti-musb-peripheral which both
match on the same device but differ based on the dr_mode DT property.
Depending on this property, the driver is either UCLASS_USB or
UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
function and returning -ENODEV the other driver can probe instead.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/lists.c | 65 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 9d1ca38212ee7f53b8894f964f096611c8ec20a5..3d9f9bc93954efdd624dddb1833f3a855c3c28de 100644
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
+					log_debug("   - Skipping device pre-relocation\n");
+					return 0;
+				}
+			}
+
+			ret = device_bind_with_driver_data(parent, entry, name,
+							   id ? id->data : 0, node,
+							   &dev);
+			if (!drv && ret == -ENODEV) {
+				log_debug("   - Driver '%s' refuses to bind\n", entry->name);
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

