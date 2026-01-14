Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE19AD31A2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E25958389A;
	Wed, 14 Jan 2026 10:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hLZWlHJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E5E183942; Wed, 14 Jan 2026 09:34:40 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E112835B3
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64d0d41404cso13900463a12.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 00:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768379678; x=1768984478;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=THR4WwpWtL04KrFs4vkRCy4C4fIDph96UkQj6T6QsNs=;
 b=hLZWlHJ1Li3pz5OP2TXJvB+/X68vW9sALKVS763dHTQj1RGg7EBomxuQpTmT8IuP/b
 q/fHsefSr6BhU4sAKOSyI4u7Q/uGLb0EuDqHZLVbD9C2dsnHrXCSWO8fNXkChlSMAuJJ
 ShDkH4cMvAq0xtQLtiI5rBh7/esMzFh9e3wFzpYEVhrf4Ibt9fXO/c7OFBc465OBzf6t
 fGCdCZhfjkqz8LJtpfBJKwm8Q6RJU/V7qdcpoy6MKEz5Hv86hjveqGivOLqU1c8dIwJh
 KWbOZIslZ8QC72/ad2isWvbQR1cYpGW8vnFTKBjFNnLteqpZmGZwkXCNlnS4l3CeS6HI
 pzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379678; x=1768984478;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=THR4WwpWtL04KrFs4vkRCy4C4fIDph96UkQj6T6QsNs=;
 b=pNnzo6OZWFas6li1VMAilZqY3vFU6CvC32dcslgeNvQ9I/Nmbl6cUuAWI4YXd7UWEk
 FiAo8GjGd6uQVIhxdkAZVj65KvVXP8z+wWmbtSIZYwRuwCoKKnHzZgRne14SgHgA0bc4
 zCWZIFY8gyHkecGMKEek4mQPM2zBrReDk4YNhSRkdaLWAfLWTL5TV9Tp7bKku9HoQB5q
 w8E5YaAd3xR0YZEs5ZTEwsETu5uwYaei9M0bnZTgoU7c6Tv05/xfNMoACU22B5+bx3VF
 JUt2PmWnZG+OUrrieMSjaGnsRBB5z+Ar5gMMF1dFoG50y0GNIa2GMi6u9UWmL0TuSUL+
 AqIw==
X-Gm-Message-State: AOJu0Yz57P+1LwnnL3D2MjA/I6BZ2UM05Kb6Bl7l3UyVOw02tM3hW5jR
 Fet+hJAJz1EyYTuQxQgRpw5OaC0iqxy5yU8lp2KNQuFQ1njFPIPt1T1PpLN0168ZMXs=
X-Gm-Gg: AY/fxX5tm8MYOpSTyHzdBXXL6ClPDsRg3R3+GHm50Gv7yXRb5rr37qawE4K2mj3xWy4
 8jwYtAZHMqkdjRjEMUOZeW1EWUiTmWDPTF4i4xivFr7FLxfL/tWFHf693G5VMqJ1tdOyym9Ne8c
 +F1Oc81QfpqmzizwTGsW/z3tfZTl+oB7gyWdVqSKr46Lxv/knRvjykUYuyU7omM/dqwEshPpM42
 lfZxxgq3Z9OSMl68CS8NHSiZwKYqPfe4oU4Ho32bRUh0fuvNVluGjTPaD+w1t/4xvTjEoSMHWW1
 MZiqh+8jChHyJ1Tt8EVKNtUjQrj2PM669fXsJQK0FzommGryPRl8dkECBRBX2/wjYjm2DMoy4Mm
 fu7/j6vVqT8YRTKSH0d5erp1fGa/QOb5YXUwssDVx1jCE8j1lLuzbtQtJyuRSPktbBJIsnoxLE4
 iYR2Bi+qvrRTMceSYmoOU=
X-Received: by 2002:a17:907:3f1a:b0:b87:156d:519 with SMTP id
 a640c23a62f3a-b876783d9b6mr97433266b.56.1768379677622; 
 Wed, 14 Jan 2026 00:34:37 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b870889ac26sm1013507566b.28.2026.01.14.00.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:34:37 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 14 Jan 2026 09:33:50 +0100
Subject: [PATCH v3 3/6] dm: core: Support multiple drivers with same
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-topic-musb-probing-v2026-01-v3-3-ebb8d990b9df@baylibre.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
In-Reply-To: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4032; i=msp@baylibre.com;
 h=from:subject:message-id; bh=CYeNe6qWwyxMvLe01flzYTdxxbKwuyKbGxF30DcZ/vw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz0UFYZ8fdVz656FWsfrtFfs8RkjWXAoelR8iIVdj0vn
 JmCW291lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwETYyhkZXl5qO2CS2HZ727LY
 eNN/YpO/dYaL3qp8trP+yOKv5zat4WX4Z1XmHu/1WkUiUGDC3O1r/ymrGRuv/Llj/d7Wb9pMew5
 aMgMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 14 Jan 2026 10:17:21 +0100
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

The modification will only add additional loop iterations if -ENODEV is
returned. Otherwise the exit and continue conditions for the loop stay
the same and do not cause any additional iterations and should not
impact performance.

This is required for ti-musb-host and ti-musb-peripheral which both
match on the same device but differ based on the dr_mode DT property.
Depending on this property, the driver is either UCLASS_USB or
UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
function and returning -ENODEV the other driver can probe instead.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
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

