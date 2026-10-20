Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5560A2607
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lE8y03HE;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MTc5pXyb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5E3A811BD;
	Tue, 20 Oct 2026 10:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6DRQMZndLKqj; Tue, 20 Oct 2026 10:16:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A23888119E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491396;
	b=LjT8RERUa1Foc+tAhZrnffJXn3KKepEaab2nuPXfEExQ6WNJLItqBEjVMVgohbr3rC8G
	 t8ggMwPYXsiVobuu55VV0jbxG/5ofb3DyOZ6QrcRrqZev5IdkQ3RI8/3X83hng8k0izTR
	 gd9MGMuj9/MwqJYNPa7uIUTWRcmz71DB5/+36gkOd2t/tExcjA3AEmCHmzev4TMQPZylD
	 t96IZGmLr8XdCFShLe2f1KE5ozoLCGlG0tJ3ARgE21LchsPUYvJ8CKrjeRqtjssDGfbk5
	 fgBcjg/277EePJsEB7wc109bCw2IsR058ixurHCeP9kLu7xJ7unlJwxXzo1GCS14p+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VlbYE6l4NkXEOoR2pOGcQ/Xll6k6DNHVBA/N4pReSBI=;
	b=a1mT+erZ3r9cHRr734HX+k5lPWWv5XoMlQRaaOylb5HeURXfGuEcFjlja2efo/hj17XS
	 4mNyxraaAu4XUb8JJSkJmxtlklkzKLqbHeIdNndNqCwbOhpRGsZefygxqi4azc9Udvr+w
	 Cc1ydSYT8DjVDkKf6WSPdv+O+1/0rOOlxRopzgn2fbDNPJF0bagjk4ptv07wz/LX7ygy/
	 CzJU+sC8dwhFRlaNBat/oaCnYDTkLrWmm+/Padd+o8DA+vCl44VwfMlF8pL8Pqna97jUn
	 ORQ39NkrDRoficfbpcqzL3vivXcCV0mNw3uwJuV+Yv2X1362VZbKMdnfja4g+4FXH0g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491396;
	bh=VlbYE6l4NkXEOoR2pOGcQ/Xll6k6DNHVBA/N4pReSBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lE8y03HE+HdeqoVOB25d1IU5BGD8+DpmynytjQEhZe6J/PzVHMcTlUL6+kuwrrQHh
	 v1Bd1ku4H7d205B2L5E6JsxQLFFuD2wf2VGTTNetKfxKWb/C0lJWIa8BNTLV46ewwO
	 t7JojfveDANT8VMbteqMUKwJAGAeI9908Ky3zJ1OwKSe0yFzSoZvYCWk9RvED+6hVC
	 /7wZNKRsqYr84CFtvPt8yJvzSrHrMjGUnSn7bUWPi4FmZeMLJ9VZ2VDz2+/9L0bS3u
	 NCFzMx7f65DJfikzJs6+xvN9g5x7qi6rWYR3g4hKK5+VR6wz1b27hYBLWnPJQiiZFr
	 FpzVI37MC0tXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A23888119E;
	Tue, 20 Oct 2026 10:16:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DD2F1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33DC56083C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XdtqzS3P2igl for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:16:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3808D60825
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491379;
 b=JrDPTo2HlUklNzEJ/mGkSvIcPZlkjaDqoUC49hDB+rtT9HG/zlJTgWt9YX+7RY1Gc/w4
 hNPq2dsyzxOBHJc/JC+Fzv0Ar7NIfoBbFwy0+Ah9gixq5RwVO78f/5YUAJZwtdhHm4Zul
 icAp0HpkIQkasJS+bYJVqpIR3HIdR68p56S9yeocHmo58hEyYWikEiW0Sj3BfN/iBt8i9
 Ts40fNLLqPEGevt5QIPkt89R8v8bEeksJhUTeaNZLusmkxRVJtO0mbKjM0bFGnuUlB23L
 eG7/3hMTiuQPvlme61eo+4YluoRVRVMc+KAHQhkISLy+IcebM02cmh/i5DkCf3sfRdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491379;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=VlbYE6l4NkXEOoR2pOGcQ/Xll6k6DNHVBA/N4pReSBI=;
 b=Mj6tOAsdEKZN7MRQqKylvHZasSwxGQrCskG93P5j2hlodtJG1QvtBHSqDtqIayomxnr5
 KBmIpbKVTqDKmdX3tPsAo6Yp9TPURFAwWaJPVuDq+3sgxORzA/zGZLi1acsGb+yEp0P3V
 RCgbhzqkp1ulJ8kDqjLdyOXOhnHBzCVlNyr2MMx3QJhzwnwWFUK4sG94WvWIUDsiqhEB+
 jC4mA0kN1bq96CiTD+k+0I9dvvC5Tl54bwAd8zXXoeR/NTTKCQ0X4VCK7wZDW7ri06x7x
 DBA2h6dtc8qYOpvSjBxjg176udRlVyJAZPWh8I5ShWLlM5q7p+YO6b4baR7cAzywjPg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MTc5pXyb; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MTc5pXyb
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3808D60825
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:18 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so29055755e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792491377; x=1793096177;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VlbYE6l4NkXEOoR2pOGcQ/Xll6k6DNHVBA/N4pReSBI=;
 b=MTc5pXyb/GSnNAoHxEID7ig4gj7q+w6mi0tuV4RvcfwjvoiIIUO7gWhfXEdfudXpxz
 6to3sjTLYPBK6qzsx2Zbk+24qn/ypBzuJ7bhL4OmP73THb6l03SzzhPBzrxLv3nR0hNP
 +pqJ23FDfP2PYLzdtEabCeznoD8yz8seS4gusRllaGcRubYCbnTasNyjVaU5yc4D2575
 MB983tmgRAPfkTwKVYyWea8WjW8bL8n+Ef0ezaEwjtARsccBzYVZE8xQfIrsaCnRhZ7o
 wnV8flBp2LjGYJzZQ/sMr8An1LeO5/NVBePbp3TItJlyZXhBxt/atAoWuwuH0UB0lWq+
 Cn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491377; x=1793096177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VlbYE6l4NkXEOoR2pOGcQ/Xll6k6DNHVBA/N4pReSBI=;
 b=TR31jNszGqc4GDUHKYoN4llGnCZr32+c7thyMKUV03PRZZc6QIPKSRcegkI+oeL3/+
 ChcmHC/giRjKB+LtDNzyW2pPjWV6h8TJCl9kQfQCzhZMiTJsYBwVA2M82bEpRvsEbBvf
 qz36xHMD4fJzHMTyZmgo9HQKZvMl7qgg7cxbud2I8EXZT8oovxBwqbHHD5yFyiXD2Aoo
 6/OoPtHN4gpp32I++oT2WPZLZ2bKIvdTRGxflkbj9boErwKPMlza+h2B6YhuR0MLp/em
 nGezGHsHrCaV0ERt7GEFfPr07esuwN+gbQtfyf49VYrF42CLpUP9Sy7Z2X/4TByydg/B
 HcWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPleAphrgywFfARX2EIheTwsK+qim32ATMclBjUDIt5hwlr5NcPFZUFTsey4oKLh4onT7m2CY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKvxO3CxZtsgbeLm6RMbGVn3sQPKwTaGVHPqvX5y9V5IGZAQlz5
 YJTeBlib+nEcG2EDKObB4wnV5Es8pGfip5jDmT0s3N5J4Vda/7HaKcy5
X-Gm-Gg: AYBFou2w10tfXTymupGEnUPqeafxpSYKqGKa4k6nSImR5V/QTRSYS2NPaA5CwTVLc3J
 EaxpOPHO1r6JKq2E+9t99Nx8STP1qpNDuhlIugNMr5HluaEbZTvM2Vmh5K2+Zz6hJW38eESwjAQ
 PogeWsjmoVEZpx+ClzSY6XyYieCLgCy3uUXkaY1eePWQtOHhTUwmBog+8M6wGn1EjdWy2a5KG8S
 vio4MrUKNY4KTWZZn8L02cA6NZjqyQqz1f7UbnqFrowTge8t6MHNRaU50TfP0NKHmW5v+wXsV2V
 xAzkFCnzUcFidN9zRzmv7GlzAPuB6c153Ebe40eflfAKXzz1JnOke8DBYQBE+Aich1xyYzWoF9x
 B6HHZmimMY+k/wH3MaQWnCjv495N+oT0af5dLwKmSZtq2FUe0owrVA811cypKfhHQ7ofo/AxJeQ
 RqmFuPsKIxgrEIEuJsWKY76RnFZn7pUt3UBS5mAn6N4mhkVbLusw3VMVaogDYq439qhHBUUgIbQ
 kbk
X-Received: by 2002:a05:600c:1c0e:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4a1d7462e34mr237283745e9.0.1792491376448; 
 Tue, 20 Oct 2026 03:16:16 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm60140505e9.2.2026.10.20.03.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:16:15 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v7 7/9] usb: ehci-vf: request the ID detect gpio through the
 device
Date: Tue, 20 Oct 2026 12:16:06 +0200
Message-ID: <20261020101608.2818265-8-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020101608.2818265-1-mehmet.fide@gmail.com>
References: <20261020101608.2818265-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The ID detect gpio of an OTG port is requested through the flat node,
the result is never checked and the gpio is never freed: a bad gpio
description or a failing read silently leaves the port in device mode,
and every probe after a "usb stop" fails to request the pin again and
reads it only because the failed request left the descriptor pointing
at it.

Request it through the device in the probe and fail the probe on any
error but a missing property, which keeps the port in device mode as
before. Free it in a remove hook and on the failing probe paths, so
that the probe after a "usb stop" can request it again.

The flat tree access was the last user of the global data pointer:
drop it.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v7:
    - new patch, split out of the previous one on Marek's review
    - gpio_request_by_name() and dm_gpio_get_value() are checked; only a
      missing property is tolerated
    - the gpio is requested in the probe and freed in a new remove hook and
      on the failing probe paths, so the probe after a "usb stop" can
      request it again

 drivers/usb/host/ehci-vf.c | 61 +++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 1d7b3bdc285..edf100fc3b8 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <usb.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
@@ -37,8 +36,6 @@
 #define UCMD_RUN_STOP		(1 << 0) /* controller run/stop */
 #define UCMD_RESET			(1 << 1) /* controller reset */
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static const unsigned phy_bases[] = {
 	USB_PHY0_BASE_ADDR,
 	USB_PHY1_BASE_ADDR,
@@ -162,7 +159,6 @@ struct ehci_vf_priv_data {
 static int vf_usb_of_to_plat(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
-	int node = dev_of_offset(dev);
 	fdt_addr_t phy_addr;
 	ofnode phy_node;
 	int i;
@@ -209,18 +205,6 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 		priv->init_type = USB_INIT_HOST;
 	}
 
-	if (priv->dr_mode == USB_DR_MODE_OTG) {
-		gpio_request_by_name_nodev(offset_to_ofnode(node),
-					   "fsl,cdet-gpio", 0, &priv->cdet_gpio,
-					   GPIOD_IS_IN);
-		if (dm_gpio_is_valid(&priv->cdet_gpio)) {
-			if (dm_gpio_get_value(&priv->cdet_gpio))
-				priv->init_type = USB_INIT_DEVICE;
-			else
-				priv->init_type = USB_INIT_HOST;
-		}
-	}
-
 	return 0;
 }
 
@@ -260,12 +244,27 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
+	if (priv->dr_mode == USB_DR_MODE_OTG) {
+		ret = gpio_request_by_name(dev, "fsl,cdet-gpio", 0,
+					   &priv->cdet_gpio, GPIOD_IS_IN);
+		if (ret && ret != -ENOENT)
+			return ret;
+		if (!ret) {
+			ret = dm_gpio_get_value(&priv->cdet_gpio);
+			if (ret < 0)
+				goto err_gpio;
+			priv->init_type = ret ? USB_INIT_DEVICE : USB_INIT_HOST;
+		}
+	}
+
 	ret = ehci_vf_common_init(ehci, priv->portnr);
 	if (ret)
-		return ret;
+		goto err_gpio;
 
-	if (priv->init_type != plat->init_type)
-		return -ENODEV;
+	if (priv->init_type != plat->init_type) {
+		ret = -ENODEV;
+		goto err_gpio;
+	}
 
 	if (priv->init_type == USB_INIT_HOST) {
 		setbits_le32(&ehci->usbmode, CM_HOST);
@@ -279,7 +278,17 @@ static int ehci_usb_probe(struct udevice *dev)
 	hcor = (struct ehci_hcor *)((uint32_t)hccr +
 				HC_LENGTH(ehci_readl(&hccr->cr_capbase)));
 
-	return ehci_register(dev, hccr, hcor, &vf_ehci_ops, 0, priv->init_type);
+	ret = ehci_register(dev, hccr, hcor, &vf_ehci_ops, 0, priv->init_type);
+	if (ret)
+		goto err_gpio;
+
+	return 0;
+
+err_gpio:
+	if (dm_gpio_is_valid(&priv->cdet_gpio))
+		dm_gpio_free(dev, &priv->cdet_gpio);
+
+	return ret;
 }
 
 static const struct udevice_id vf_usb_ids[] = {
@@ -287,12 +296,22 @@ static const struct udevice_id vf_usb_ids[] = {
 	{ }
 };
 
+static int ehci_usb_remove(struct udevice *dev)
+{
+	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
+
+	if (dm_gpio_is_valid(&priv->cdet_gpio))
+		dm_gpio_free(dev, &priv->cdet_gpio);
+
+	return ehci_deregister(dev);
+}
+
 U_BOOT_DRIVER(ehci_vf) = {
 	.name = "ehci_vf",
 	.id = UCLASS_USB,
 	.of_match = vf_usb_ids,
 	.probe = ehci_usb_probe,
-	.remove = ehci_deregister,
+	.remove = ehci_usb_remove,
 	.ops = &ehci_usb_ops,
 	.of_to_plat = vf_usb_of_to_plat,
 	.plat_auto	= sizeof(struct usb_plat),
-- 
2.55.0

