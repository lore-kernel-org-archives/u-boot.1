Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7768EC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A4C88A31;
	Mon, 26 Aug 2024 16:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Gfx1tI16";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jPjt/rQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5459188A4B; Mon, 26 Aug 2024 16:39:15 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB82388A30
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 16:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wstbh3zPbz9ss3;
 Mon, 26 Aug 2024 16:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HaGwFdVdlmBl/hVe6ZbMB8XqYddVyjo8/JGj8L3EK0M=;
 b=Gfx1tI16S9a4gQcMzuAHDmYhjnYVurzD99jNAB9jydciLgAxxjL5EUozbD5YzHXXMWJSWP
 T2cWQFhHl4JpB9d/eZQ5+rIveXWqJWQBHWor11glMV9X25ESFPP0DSq74IaCO4TtNLp8Ex
 TNtqOhI5UvNCiEx9Z7kwzF/hOw1YEnwZLEMGOqJ8DvrAwDXXAX8tHRC5w5vdEb4DcAnzcG
 P7jZoTnRjpc2kFO0ELFucbF16v7LIflhrrhGXD/8d/u1wVD9TyuJnXrtkLAqB4YmhRKN9k
 1txSETQDMYbo+nkA3xa9Da37F9z/qRxfWGxdqZhc1mkjkeNz6pc65W1q9Tl6uw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HaGwFdVdlmBl/hVe6ZbMB8XqYddVyjo8/JGj8L3EK0M=;
 b=jPjt/rQIiAL2ilGDXbDo4tWI9XZciVtOAbJkFL2ueOdNYaJu6rm6sj/HqkGWlJCjPwgel0
 yAmLjnTyGfv7zq9FM/M49XBDPjr9yyakjwiT3WyYE+kyrMQT6uW/zEHT4Q9LhSKubGs4cl
 lnQFReI57I4klr9sUwqT/V7zHZ5Hs4pOOSylripGwj1zy1yhSnuVVXQSKQRwV237H0Gxko
 CX8d0HCdFFmq+3WBC1RhMR6MlXpaKqO4mq8NifLY81tZA8BTo30TymNG+bSyS9tazhvKfM
 lSIBrM7eGoHOJGnzlCHaFXDM9pEQnD6ykTGSJSB4fWrVN1OLCG/tWXKeQOPvNA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Zixun LI <admin@hifiphile.com>
Subject: [PATCH 3/6] usb: gadget: Track driver data as part of struct
 usb_gadget
Date: Mon, 26 Aug 2024 16:38:38 +0200
Message-ID: <20240826143851.8020-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 45740ca37d4e31ab4ce
X-MBO-RS-META: yquqxtq5ea79hkwp9hyuahbcqz96qyap
X-Rspamd-Queue-Id: 4Wstbh3zPbz9ss3
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

Move driver data directly into struct usb_gadget {} in preparation for
conversion of struct device to struct udevice * in struct usb_gadget.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Zixun LI <admin@hifiphile.com>
---
 include/linux/usb/gadget.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index d62fba0ca02..a2b8520bc99 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -544,17 +544,18 @@ struct usb_gadget {
 	unsigned			a_alt_hnp_support:1;
 	const char			*name;
 	struct device			dev;
+	void				*driver_data;
 	unsigned			quirk_ep_out_aligned_size:1;
 };
 
 static inline void set_gadget_data(struct usb_gadget *gadget, void *data)
 {
-	gadget->dev.driver_data = data;
+	gadget->driver_data = data;
 }
 
 static inline void *get_gadget_data(struct usb_gadget *gadget)
 {
-	return gadget->dev.driver_data;
+	return gadget->driver_data;
 }
 
 static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
-- 
2.45.2

