Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDEBF53D85
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 384E58416C;
	Mon, 16 Mar 2026 19:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="OfeSwfSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5137784118; Mon, 16 Mar 2026 17:50:55 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E1384109
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 17:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso42374335e9.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1773679853; x=1774284653; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M1MWTKuVAsQAHQGdPhGFVNpeuqfiR6w1gPMRXx8f6mE=;
 b=OfeSwfSPsAk71UPhzsEc4/cJU32Pn7GN7XkxgEPaFK9c4CJyEyhDK2aKo5K0uM6D1E
 K6+HmT3oX09xdRTzqVIVB0snse1xRaWRwjxa/hXiePaABp3ZtP6voSrJ4ohwzU63p9T7
 mx9XhwoDBqgEMOS/B6e+YBPkJcEtv1TQ6O6bqfZohpqFEAJTEIXHNOqaWckZVW2O4h2i
 7TKBCli6K5LkoKv4a9HCoaQRuBzUyLVtXonDJOjNfSAcxO+A1wAEzUTkgx3FOOL4YRFM
 Sm3US3YQZ3f2u4LUeuwmiZaDM5sK5Q6fQDDv0K8D5j3hfAB3RH/iTfq8CMHihH4Q763C
 hprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773679853; x=1774284653;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1MWTKuVAsQAHQGdPhGFVNpeuqfiR6w1gPMRXx8f6mE=;
 b=UYQtH78Njw50XaT6qT/xbjMFJKd7+09EAvnpge4i+SnaNGVRwj95q1g3xQLQNSTu+Y
 2eis6s9n+8yP/m6c5y1x3s71p66+Q3oK4NOPqntyRAKt3yzJNj0NhAvgZwKfKpF21ogN
 nN1q5XiVY+D4+lCHXRTr8amU1NbUSXPcIWr7Gaz0RYWTPetqu43lGWSg6Eds3bJmd44z
 lZ37dMqQ8K0ciyRFET9ocu8HIT6oKwLQZX9rxANKZqbxN5vKxQSXDXZ5JSWthGKmH35X
 D9PHvsZ4kRJYNxvEwIeUHLB58uOR6rGyA1nLY8a9Jwcsw92zBCtvmmLjxH6b7EeD7Q3T
 4p8g==
X-Gm-Message-State: AOJu0YySjl24K42ojwjPac9dKbX4K9/VB8kB4lUlHsSounp0WTnSPYTB
 H9P42Ki7R5CH6tsnK4Zj/ZMVOweWYVl5gmVtazcr8eGrbZnP14qcjUvxklb5gywzcXA=
X-Gm-Gg: ATEYQzyWkgrVWX6Hx6Fqw5SUO5vGFTZisaFwDft1g7/cHOTB5H+beQwGLYp1ooyBKcK
 SGR+vOFcPx98GTLQ18OlMqznJDggOSgkSyed9nO5oY6uqOcTAoJHuYcUCuB7ogpY3IobkvDKV2i
 YCYhfyqFWs5JdGTNCyKp1VzHjOGtjy7monBYlqClKD9bRB4bZTbvdXV1DOIWd6mAYl4iBWyHWXz
 K/jxFhGjfYKqKFhtglllbOl1Rns4VYl3C4tXSdxlE8S4eNveDz3YurJrIK20A9m8Zm0U8mNMX0T
 VgNm1pvmrStUmGhYV00ubUqAS4aWtLArpyF2KMYya5WSKdYFPcN/7afTce44PeXt23RyMlIo7OI
 08T9QpqmPNwhb1nHP/dg9a6TvYqGei+YKnPjxlusrUHwfa+X9kCrh7PHACjC3FwH83KjUPL3QvV
 8FV8JZzDdSWod7QMxSQkvpQnu0lwKttob2IsDrpn1w3/w9mbigiMlhkWBvQjVXTOKjc8ZMOuOYQ
 N5O9A==
X-Received: by 2002:a05:600c:1f8e:b0:485:3f58:da1 with SMTP id
 5b1f17b1804b1-485566e936amr259403675e9.9.1773679852562; 
 Mon, 16 Mar 2026 09:50:52 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eaa39cesm7359485e9.10.2026.03.16.09.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 09:50:52 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 16 Mar 2026 20:50:45 +0400
Subject: [PATCH] ufs: rockchip: Make use of controller resets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-rockchip-ufs-reset-v1-1-808eb017459a@flipper.net>
X-B4-Tracking: v=1; b=H4sIAOQ0uGkC/x3MMQqAMAxA0atIZgPWahGvIg5SUxsElURFkN7d4
 viG/19QEiaFvnhB6GblfcswZQE+TttCyHM21FXtKmscyu5XH/nAKygKKZ1om9aHzlCYrIEcHkK
 Bn386jCl9VD2pB2QAAAA=
X-Change-ID: 20260316-rockchip-ufs-reset-345cf81efa31
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=alchark@flipper.net;
 h=from:subject:message-id; bh=GdilNiiHQtJw73mzv+S6rngIJhVzdGmdf/+KUyWtyts=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTuMHl1OtzI7EGvybJFume75zhavHgz++MWBz7HF/unr
 X2t45Iv0DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrqGOsYMXBxCsBUW61hZJjE+ldrW2riobOpYcpl13N4xP2F+0T+59efu7tTObONKZGRoech940
 W0w75shdSvdySG4+/Vjy92OVZvcgcR7Z1HnEmHAA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:05 +0100
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

Assert Rockchip UFS controller resets during initialization and HCE
enable, as it is done by the Linux driver.

This is required to make some UFS chips, such as Foresee FEUDNN064G-C2G0,
work properly.

Note that the resets were already requested in the probe function, just
not used.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/ufs/ufs-rockchip.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
index a13236c7f761..dc4b9b5c86da 100644
--- a/drivers/ufs/ufs-rockchip.c
+++ b/drivers/ufs/ufs-rockchip.c
@@ -19,13 +19,22 @@
 #include "unipro.h"
 #include "ufs-rockchip.h"
 
+static void ufs_rockchip_controller_reset(struct ufs_rockchip_host *host)
+{
+	reset_assert_bulk(&host->rsts);
+	udelay(1);
+	reset_deassert_bulk(&host->rsts);
+}
+
 static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
 					  enum ufs_notify_change_status status)
 {
 	int err = 0;
 
-	if (status != POST_CHANGE)
+	if (status != POST_CHANGE) {
+		ufs_rockchip_controller_reset(dev_get_priv(hba->dev));
 		return 0;
+	}
 
 	ufshcd_dme_reset(hba);
 	ufshcd_dme_enable(hba);
@@ -150,6 +159,8 @@ static int ufs_rockchip_common_init(struct ufs_hba *hba)
 		return err;
 	}
 
+	ufs_rockchip_controller_reset(host);
+
 	err = gpio_request_by_name(dev, "reset-gpios", 0, &host->device_reset,
 				   GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
 	if (err) {

---
base-commit: 841856ed9675b26ec517fdd00b5cc0aef8db508e
change-id: 20260316-rockchip-ufs-reset-345cf81efa31

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>

