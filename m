Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246B8CCD187
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 05:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B08809A5;
	Tue, 14 Oct 2025 07:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XGMjpl5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB3608206E; Tue, 14 Oct 2025 07:20:43 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47ACC807B1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-28a5b8b12a1so44110685ad.0
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 22:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760419240; x=1761024040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OCPKp6V1dRMoSh9h9mgFapdW3eLNLcAsJLCf96iYRaI=;
 b=XGMjpl5oDFaXVyDLyrDdkxLQwq4We11XGu4kAyvCQtCNq8GCfBTOgH3d+zVrMqjBcW
 dR00yMYEQXxKXYrjcXH16wFaP7CGntWyZEPjMUdVf5bgA+SGTrjpoqrA473WQQZUTaA6
 gKV6V0FN5sJE5VSvt+BkmXf2Mg/4/d44HJ11VWT3/l+g5WLrZm1T1JUW3cOgSkjjCEXj
 KrrRlYfogVTdRsNnzcyB/DYiT4TBXb/tcY4yFnoVWPSvHjew2rGvWMUHiqe5tvcnacS2
 wdt59X/iu8f/spB8OU2NPrXNXJJu6RNdNvFyKvydXRC5YCV1VAM20GiXdP0JFInKBlYk
 O+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760419240; x=1761024040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OCPKp6V1dRMoSh9h9mgFapdW3eLNLcAsJLCf96iYRaI=;
 b=A0RBrTo3TX4syXMOL7IX1SEM5s9ru2RICLiRAQbd991+bVSL++3ejZyU+pd0LWZ8oX
 +oQcO+pdUYNBOy6RxNa2eV6CERIBXkoRbpDWX/kknVNfbJMwfGKbBuiSV/PQNKf9MBHM
 t60VXEYky1Q43NkynGwV31ZckIJfRcsrUzoVx3Jx8nO77Eu5SeazZxQvATc3hqjYO2LL
 ZBk/9DXb/sPyEt9dySdTlHyGnb3wpWOEcfq/YTBDqFRpObMH5bymcQX/s2mmlccmaphA
 kbjfIdzyOwO0oIiF7GbWC8z56c40fqSQlCaRDe/epE9eXr6dcjQhQq48/KlAEYFgpSyE
 mtdQ==
X-Gm-Message-State: AOJu0YzIoNKdjszYQQAwX/OuZBiu33I5/AG5CFqz1kE+xvkkYu6oScL9
 5XAjcvh6v0vP1e/tUjGVLvmz5aIeVGASWJD8geKb379JC9NPL8uJgJhs
X-Gm-Gg: ASbGncu09QXzhOKJrQkF7BsQGoLUxssixG8c8qUKnNZ7yieGxH57vti8GDb0mltO7V2
 k89NVtkVIJy0dNmwq0rILnlPQJEzjTZkLl9+HePHl+zYYaoD9xuoT83e0qPNfjd5it3kHr4CcZ4
 K8yl0FaV7fhCRIgI0Gkkl5biV9l2A7ueP/CzCF4M8RgLKAnh+XJU9UBmmZE6XUtar//z2LWFRoS
 pamfO6AAh8n9FKU/UE3Alr/FtIIpxXiQ70XifPFjAyDsG2UUVRIjLUXuVoW4YPO9zH3cCf/Eqto
 f1BcZN2aI+CjWg3SY4UYlwQBI89L+Vn/vKwX7Kldi0KLE7rqwzu/6plKP7IOpaXIqP/D97/HAfY
 o1T/knmP1/uwFX87jrQu9t1zsseHvxO7kF03jqzdwd82KX+V50ULS
X-Google-Smtp-Source: AGHT+IF+Ug4CQrF5i0zQUkmY8RyQEE3z2Dms97xK5UAYJfFYVKNdGGZ7UXgwZmQhkeU78/h/3pmeFQ==
X-Received: by 2002:a17:903:1b44:b0:279:a5bb:54e2 with SMTP id
 d9443c01a7336-29027379a7dmr283873845ad.20.1760419239595; 
 Mon, 13 Oct 2025 22:20:39 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:402:b3a0:218b:9154:d891:e95f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f35e62sm151464465ad.88.2025.10.13.22.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 22:20:39 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] net: designware: fix bitbang init error
Date: Tue, 14 Oct 2025 13:20:05 +0800
Message-Id: <20251014052005.307902-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

The Synchronous Abort and reset errors occurred due
to incorrect parameter passing during initialization.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/net/designware.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 2fd92cf16bb..132a9afa2a6 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -125,6 +125,14 @@ static int dw_mdio_reset(struct mii_dev *bus)
 
 	return __dw_mdio_reset(dev);
 }
+
+static int dw_bb_mdio_reset(struct mii_dev *bus)
+{
+	struct dw_eth_dev *priv = bus->priv;
+
+	return __dw_mdio_reset(priv->dev);
+}
+
 #endif
 
 #if IS_ENABLED(CONFIG_DM_MDIO)
@@ -348,7 +356,7 @@ static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 	bus->read = dw_bb_miiphy_read;
 	bus->write = dw_bb_miiphy_write;
 #if CONFIG_IS_ENABLED(DM_GPIO)
-	bus->reset = dw_mdio_reset;
+	bus->reset = dw_bb_mdio_reset;
 #endif
 	bus->priv = dwpriv;
 
-- 
2.34.1

