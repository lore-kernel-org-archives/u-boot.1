Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0871BD31A2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A503783678;
	Wed, 14 Jan 2026 10:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QAKJHkmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B30830A0; Wed, 14 Jan 2026 09:34:39 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9998388D
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b8765b80a52so62477766b.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 00:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768379676; x=1768984476;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gw+CAZ/iuOhMlYXp5Aj+BPplk1t/yP+u7WKddiyoVOk=;
 b=QAKJHkmWNR7isMz/YXTRWxhqfELJPxBerqYgdNEEkQRPtXYH9EPDj01GnDcyKVqCLR
 +OkY19Wwmyl2Ez+JEnVx3k5YZsmI3kBN7mEKGu/PQWH+rCgOz+KZj2Ooak54EmLXcaiW
 uqFEtTC3WW0oxQUJhvpCU0TbWE55Bv3wq7Pve7vIdeFqUbfkqyGHmA0JtTJDaZ0D+rAH
 ZM66633PDoqkB9xo6tjJuc6hLt2MR0VRbtIbHeNJoHOcKNxjN3N86OB7tqwhaoibKSMB
 nawZfASuxqTzl1vH0MmwJ1vTiOuGMUk22pl86KWgN1FyAoV2CGnT78NSmjo7w9eW6JUD
 jesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379676; x=1768984476;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gw+CAZ/iuOhMlYXp5Aj+BPplk1t/yP+u7WKddiyoVOk=;
 b=EoSfetTyhh49806uusAqgfydZ2J/3OryLNFXTiqs46WxsefuTjhf7P5nyw5Ic8zJIL
 PLTVJzeRLUgRBjPAVOT6NjS+IB1GkbxWk5+4ByQ8GtL3lTfLTM19bRAkk7QNjl1N9rFc
 /jjAGXeJOpGMG7CICSg+zKmgwX/3xYE6ehWR25RO4eNq0GoxKBSwqYUpRlB/TvaWMXrs
 GdOuE+2gVhAbdop3gzDb3DqiSqi7YsytzkktCoqx7OuvwH3GBnDbWdZUg56Y/PEY+Viv
 f+fpjXl7WjZlZHHxH2SyNrepJiVio95ImOhKjBdR+8eyxnuhs5Iiaqj58T5mgCRsI9EZ
 hCdg==
X-Gm-Message-State: AOJu0YwVGIyUqD/dBADADDexo2pH68aeMvJVRQCaRXRC2UqUqfwn2Jty
 LjDseOmlAZUoenOWGpVFQwK85Dcm9EGFiqL0tCz6p5IPifayFVeM7YbjwPxdjTxoMXo=
X-Gm-Gg: AY/fxX6qOyHyl907ZjzLN5rA9crg7xkN/cvJT9QcGx0zaozA3ObvGt3LuBcbx5PGs1X
 KsfwNEc3VZBjpOkPl7CKXstcXaMwiJC59U/jcyMpEKIdQ8hrDrFYcp2QHK8P4TJGEHnjmlQZ6tk
 TaB+7ORmyrJCZsoeY52rM44luM5fiOv6IvhdozUDQMLV8nZ8pFoUSPCD1ztg3AyfX74zMxgoX6X
 6qy8sOESEuKjFXJhZHNTg/VLg47g0woyFzJBXRDvF7hVZreb+xHLCRZ8BK21gBVuy8NBfFWnBYM
 iQAP9Eif3MdZxSwD6AQLuNpEDaUdRdqNAAoAXFCHRye0I8pYn0Mjch4qCcKxqaNY7ChKqqea46R
 WxK88/H4AeXtxqXYdFyrZr2COeNNV26GyV7j3b4E9lMKOTCg6XMwkGNEbUFArXPXBNMg6JjYaWo
 PvWRY5whbn
X-Received: by 2002:a17:907:6d0c:b0:b87:6:3727 with SMTP id
 a640c23a62f3a-b87677e278fmr99866966b.48.1768379676427; 
 Wed, 14 Jan 2026 00:34:36 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4cfe76sm2412446966b.40.2026.01.14.00.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:34:36 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 14 Jan 2026 09:33:49 +0100
Subject: [PATCH v3 2/6] dm: core: lists_bind_fdt: Replace found variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-topic-musb-probing-v2026-01-v3-2-ebb8d990b9df@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=msp@baylibre.com;
 h=from:subject:message-id; bh=KNm5GPlrk5Ge65D10UDrEydfLPhS241rh6+Y3H5QNgk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz0UAYfRfaYlZue3yvZYbz89AMO46Miqnyst6e7fnzcu
 3TD076OjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIBA9Ghtfn9rM1fwxOdezM
 0EhqK53JnFC5x+fPmkVBf7yFp/O3f2L4n/oy98HieRlJXMtnv51quWJh7IKHd5p/KbZf3sAusmO
 BPz8A
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

'found' is only used at the end of the function to print a debug
message. No need to maintain a variable if we can just return 0
immediately when a driver was bound successfully.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/lists.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 52ba6c7bfa007b660b854de62c97ad3c1761f1a5..9d1ca38212ee7f53b8894f964f096611c8ec20a5 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -204,7 +204,6 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 	const struct udevice_id *id;
 	struct driver *entry;
 	struct udevice *dev;
-	bool found = false;
 	const char *name, *compat_list, *compat;
 	int compat_length, i;
 	int ret = 0;
@@ -275,14 +274,14 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 				ret);
 			return log_msg_ret("bind", ret);
 		} else {
-			found = true;
 			if (devp)
 				*devp = dev;
+			return 0;
 		}
 		break;
 	}
 
-	if (!found && ret != -ENODEV)
+	if (ret != -ENODEV)
 		log_debug("No match for node '%s'\n", name);
 
 	return 0;

-- 
2.51.0

