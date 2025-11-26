Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0206D111A7
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4372C83D13;
	Wed, 26 Nov 2025 23:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="15ewJ2tc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1240383A64; Wed, 26 Nov 2025 21:31:54 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A9383A64
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 21:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso1031755e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764189111; x=1764793911;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mpKjS3M3rM9RKB3wRTEiBn4P5Eu1c+GXMyKW+/dod08=;
 b=15ewJ2tcF3+hdKf+60u0o8Y0+4rTXGzIKXq2XlOAv1XLUipe2JkQK0HK1Yh2kJxWw7
 f5wCE4XGy9BiMQavy+NeDzEbVv+xP5nLYXk4coBGa2FlgicJ5a2QBKBmWEOxYjlvklYE
 rCorOfxHxnyIlEYHtD2m+L7OoLqSqMJM9b0AWRntfbfxrHddcbZlKzllZvRfWH0tdlka
 yIiJAH8agXtLS50EXSLjI+nqj4Bqz6RNGIg7TAQLxBLDX4AgOIHQ/kIL4b6j/2rwdQIX
 lWx+4P2gBs56VhnY0jectoUXIvVgq37JSf7UYJhlzzPqLop6btJjqyAEG0Evrlmfi+Mc
 kMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764189111; x=1764793911;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mpKjS3M3rM9RKB3wRTEiBn4P5Eu1c+GXMyKW+/dod08=;
 b=qBLYpmc/3De1gdUVdpvYIezojKyKIx4Yuf9Q4iSHS4muPmO7l226QZe/1Z2mebhl4g
 +oWdYHcEauSMOoRqzm2UAW5oH3tIu/smkHOC8L93T9BvIRGX6HfJyiPdpWKG7x9sbvjz
 MWZ92ltqZcQ+nGbNRggOzizYsUXlqtCgRplVF1N3LajgPJBLtERFbJLSRfYK8WN9ZNoO
 CpPWtFU6531/F3ye5pfSuEEdd/1N+on0BGeECdeUlAbI/ws8+Oem0+ntU5n6DWfU4XHz
 +dmvf/dplXqsjza/5+epz3PKZVZjOkpBrF1GTk/85YrnIphhqVepqGYIc6Dy0HZrkQQR
 CsmA==
X-Gm-Message-State: AOJu0YxeSLXipOBbj/x8/r5C/WzGr+ZpHAVzoED/NMVyZDJVdxHEZhKI
 5fZnxlHviyMDj7wT7yV+dtKvyBRLpfOJPmFIEM9FX9gzMfmUaEZhqOJy2/+nqT898vk=
X-Gm-Gg: ASbGnctKl0DNOKIHen9gF9fv9kQvX4AkOGZCmUh8uQgi9xLZ7kf3MWDhzY8q6fftEYE
 x/Bu37lr79R37ierTw0wB9GMty47JHZkP6EADZYvXBh36SySxFx6AAlNjy8tKRlPFW2FhVYdzUy
 9hXgsrDcVUvQRFAP/JAalzYJjZJI+cnbTj8JwTm81ajxZwt2YAH4eOUTUzub5fjS563FIOwjcoj
 Gztm63Z1D1S3a5cMQsf/Xug4yp/yomdQZgACIdqKy/1ws6Eg0zQS2tu53V8DtugauRQLAWYKemH
 fLc0bn0i1bUiANqgfPc1+vzzSxbbB7Oh867xWpMjznYnosYrjwpRgNSODIxkKdVdgrr73q5G0xb
 VUXDX0vrecuepbLXB4DRVEaTFGA2T1f3ozaBKo03kuRjzuOMlXqzJG4JtEddVbFGuSeLv9my6N8
 T8p6fpUcQ=
X-Google-Smtp-Source: AGHT+IEr/V9As4h9RinUkxEA9g1JOewsxDqIR+Y4gc0WVEvig+G3rjf980mAS+fC1B7sau+41TjlFg==
X-Received: by 2002:a05:600c:5489:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-477c112400amr185541945e9.26.1764189111469; 
 Wed, 26 Nov 2025 12:31:51 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4790adddb4bsm60143665e9.7.2025.11.26.12.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 12:31:51 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 26 Nov 2025 21:31:07 +0100
Subject: [PATCH 1/4] dm: core: Support multiple drivers with same compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-topic-musb-probing-v2026-01-v1-1-ff8d8c487130@baylibre.com>
References: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
In-Reply-To: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3498; i=msp@baylibre.com;
 h=from:subject:message-id; bh=wBfgyl1xfgpyJReq6elItJyYIlzMB9+0XL3RGJlFxfg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkz15IWfJoppP5HnP8HEVfGVdYp4i0W+0B8W70Nc0fOU0
 nNYDiztKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIm0bmD47zI9JX5f893tMq8v
 nG6+IzPHI/ps36Hvq3MtFF/a7uk6XsjwP74oxe2Uza2rolYck5OC7zGmLZ6fo36n+EMYX9Dl5mx
 XXgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 26 Nov 2025 23:50:13 +0100
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

