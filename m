Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1CFC021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E49810FC;
	Wed, 26 Feb 2025 12:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EoJjTxVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15530810E6; Wed, 26 Feb 2025 12:54:15 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1146980F3F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abec8c122e4so376646166b.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570852; x=1741175652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMhdtM327ooK5viJyIY6jHtXWGqIuUu7oIxiQIS6YIw=;
 b=EoJjTxVu9ZbcVLxAHNK4ugsYsZitsE6bG5woiGCy7+iFk2K6cO8fWANLPheynMMH0g
 Ra9beBXqW1xv1xNoZLf4sX9W340rm66n3SVN1WD+NtNmWIcwpjP5eAo82uEOhzwmcLuA
 f9mHkOIKQFPp72AHnPkq1t9eF6iR4ffUHJow+g7tj0vsHEG1GB4jyytpRj01l4aWJp6q
 JffjN8gB+T7pvcnKaRP7pXVIojyTiXfRbanLTUxljzqE1I0XVQG1jpyPv9vRsO3y/TS+
 NPlC3WBkVlkuXMXL0cKNsMZkqiL4pqFnk8X2Y3Z1yBWi2qPovyNMAqkpcX9tbfzx3bM1
 asKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570852; x=1741175652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMhdtM327ooK5viJyIY6jHtXWGqIuUu7oIxiQIS6YIw=;
 b=v+7X6uS5moXaYaL4z0vfX0uqJb8p57lgQeVfr3KnsUr7/SgQOmQqjUWsXqIRDNIdMf
 1avMelyrb2dLgImuja3Gad/rYZCAeV8IyhjPygWTvf6lK4re7BEftLIs38XpoFhBoXVh
 G7+OBeI8eHh3QXkDHij063L60/sQsQPOl5uSTbZU4haOfsXf1Qb51v+qr9GnWoF4i1Z+
 3XMlagBdryAUa/BLYmI8EkChH3x9yFOFCK4f9PKJOB8ah0kNNEQYjE0CMb3ChZBvGUDK
 xWAbPZGbaGM25Ldw8BLRNBPCPNPoMUSyVOtzYGmbz4VeiY8gi6UmGlElAsrrFNLV5O5i
 CnCg==
X-Gm-Message-State: AOJu0Yw1joPUZL1mVD76VlaoJ7ROovqTx5+DoKTy22OlEYjxDhbfO4sm
 wY26Wonrr+eydLJdMebE99z+IjwkVE+Kr7GrcDcNo4I3CCIHoYVG
X-Gm-Gg: ASbGncvnuV/fszbQnM4uPf/mhkS7E+b07tUfTj0pP38IG3hJokb96Da+RmAxQyBcSd+
 ZA6j8rePA8GotzopoSnMHiC+ktpcRh8ORu4rj3+O2VZiwu/dpDmMLKig+xCr9Ai5AhV2be5y2S7
 F4jJbLbw0KX5SMsZufCgMPrebTQWPKAMSOeXJ6yqM0p7NoHOE/CGbdVD3DaRWvhW9ZycFaRqvXd
 1GT6/guEr/Haf/D+ZVeGwNL/YuyZH2YAodsJeP8Cm5LXT+4uV+7bZBo9BlgqjUr7epcLcSsYR51
 inwti4Umnd9uuuGSZw==
X-Google-Smtp-Source: AGHT+IErWs7n4wvdd8uPEHCDu1VLf6vfVfWEAjNoVcJhPSn48XURV+okKhwyFBrcZXRGmQMO/w2wrg==
X-Received: by 2002:a17:906:6185:b0:aa6:832b:8d76 with SMTP id
 a640c23a62f3a-abeeecf50f0mr327126466b.12.1740570852278; 
 Wed, 26 Feb 2025 03:54:12 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:11 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 05/12] video: tegra20: dsi: check for panels among child
 nodes
Date: Wed, 26 Feb 2025 13:53:31 +0200
Message-ID: <20250226115338.42832-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115338.42832-1-clamor95@gmail.com>
References: <20250226115338.42832-1-clamor95@gmail.com>
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

