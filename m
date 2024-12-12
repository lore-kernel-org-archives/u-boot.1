Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62618E77182
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD552802A1;
	Thu, 12 Dec 2024 11:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b+hItcWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D88080214; Thu, 12 Dec 2024 11:21:35 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 408848012C
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so591544a12.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998893; x=1734603693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMhdtM327ooK5viJyIY6jHtXWGqIuUu7oIxiQIS6YIw=;
 b=b+hItcWU1xIb1lgNOm+E3OvJ4mjQasEd9jFg8KtZ6Cf1aoz1kfxm3KT4FimqHbViFv
 lbl47i113OfKi2JH2Ffzsb2NWJtfYiEA7XeXku24jqKQJiPfMc45C76y1RxG57xT8ZlI
 S83n2yaixy2ELFhxC9IdW7RAQJptiwsO4f5zNdrHU8jo76MkgPsPtPZaG7pJNfTjb2pf
 eb+6VQHOs6m499bw9pbgU9AJuzvnRFDOagY9oX06NsQuvdhza/NrR6CE6F6ZLrroRTl6
 Q/S6adI8OJJTs//9mNry0yRpl7ce8OVyQUxSREiDouXM9UNa3oY9o7oMBrOX+8+1ggeq
 jb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998893; x=1734603693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMhdtM327ooK5viJyIY6jHtXWGqIuUu7oIxiQIS6YIw=;
 b=B8PO3fAkqY0rZWRpzpTV1VldNMySK+j1rrfWOKftP5lse1kAO6Rat//JLPYgqi5j6m
 drj7PIz+Nvu7l3TLcZufdDOTHmcu/z4Mu87hNpgNWIB8l3dIzGKG/KIevlekRCltiY4n
 Q5SAFOLhT1FTtaNoQ/+F14APp++2rPtok74fFDzTGUQm2nbHcTIkCrymde1liRe2do1I
 OaYM2urMomqCqXUPH5/cnU9Cmf60GGrjBWLAQI9xhPymTUdeM3lkfYnA4FuYMFaeGDdT
 H7YkHrJvx6e9wgkDalk0HUOgF99cQUnm7V6gUwZNcO0nsgNooBOuHVqRQbMIuTOY86F5
 vxZQ==
X-Gm-Message-State: AOJu0YzmbaUnl4gJao0FpHoIfgVDgcUg2mr19xAeFVj3uS17lJIMEm1y
 eYKi7IncFXfkGku3jFD9Gx4wnCeF2m4CyKmQKCk8UQc1RqP6O3WJ
X-Gm-Gg: ASbGncu9vz3Xw7utY4nvUp3nO2CZ0gdz9cCdD6vgnOhiGZ7+5F2hiYFhHMThdVUEqg+
 xPcRvqifOI+Cu0ICBLkiyE8rHn7UfEO46O0A7L5ildt9/4F58cmCQiopQI7Il3EZQ90h6Cy34hL
 s38VlEZ/omJrg4I7TPctQUSClsNQB8Q7o0s6YmnYsspdUoe4HUTce7iN5FkT2+rjlbrXpR1lGTd
 fHaP3s1tUziPT8M87Frfd86pP4eObX/HL1qCavieEbjiW0H
X-Google-Smtp-Source: AGHT+IHgp73Fj5kYtW0dDqsxdBNboKccZShwJ7YRnhW7nASBnLXwBhwBZOV9R7xTCrc8bwmZRceusw==
X-Received: by 2002:a17:906:3d22:b0:aa6:6fa5:65b0 with SMTP id
 a640c23a62f3a-aa6c1ce7602mr300762666b.44.1733998892667; 
 Thu, 12 Dec 2024 02:21:32 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:32 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 05/12] video: tegra20: dsi: check for panels among child
 nodes
Date: Thu, 12 Dec 2024 12:21:12 +0200
Message-ID: <20241212102119.6466-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212102119.6466-1-clamor95@gmail.com>
References: <20241212102119.6466-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Switch to Linux-like approach of DSI panel binding as a DSI
controllers child node.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 6327266dd22..53db5a25d40 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -973,10 +973,22 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 		debug("%s: Cannot get avdd-dsi-csi-supply: error %d\n",
 		      __func__, ret);
 
-	ret = uclass_get_device_by_phandle(UCLASS_PANEL, dev,
-					   "panel", &priv->panel);
+	/* Check all DSI children */
+	device_foreach_child(priv->panel, dev) {
+		if (device_get_uclass_id(priv->panel) == UCLASS_PANEL)
+			break;
+	}
+
+	/* if loop exits without panel device return error */
+	if (device_get_uclass_id(priv->panel) != UCLASS_PANEL) {
+		log_debug("%s: panel not found, ret %d\n", __func__, ret);
+		return -EINVAL;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_PANEL, dev_ofnode(priv->panel),
+					  &priv->panel);
 	if (ret) {
-		printf("%s: Cannot get panel: error %d\n", __func__, ret);
+		log_debug("%s: Cannot get panel: error %d\n", __func__, ret);
 		return log_ret(ret);
 	}
 
@@ -1036,6 +1048,7 @@ U_BOOT_DRIVER(tegra_dsi) = {
 	.id		= UCLASS_PANEL,
 	.of_match	= tegra_dsi_bridge_ids,
 	.ops		= &tegra_dsi_bridge_ops,
+	.bind		= dm_scan_fdt_dev,
 	.probe		= tegra_dsi_bridge_probe,
 	.plat_auto	= sizeof(struct tegra_dc_plat),
 	.priv_auto	= sizeof(struct tegra_dsi_priv),
-- 
2.43.0

