Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7709BE6B240
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 10:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A752588DEA;
	Fri,  1 Nov 2024 11:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LQGFe/Gd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA15888DEA; Fri,  1 Nov 2024 11:35:41 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA7A88A4C
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 11:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb59652cb9so17782691fa.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730457338; x=1731062138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fBLzhfOsmeubrBeuFWFCFq0Ce7gEQt/2ou+mJrJnFE=;
 b=LQGFe/Gdto8aWbq803efWu81wj+xhCJfFi2zbntpmeD9MGddiFvai8DTG//GN3lOsM
 vo9Wyy9eKtTSMq/Qr+eHQJFshnv2y9Hn3H+iekgGiOwepp8T7aFN6WSXpJ2JeuVBXaks
 92rcsQmZd59NoSXBD2XbQhDHdIt6Jg/M5LiH3V2KQBCWKwjpMCLPsuaBxGuBCYEL4/eA
 0vG4n/m71/23vMmQZbENzyZqQ7uMCWIdihGihJKCfUZGMRFA1PlQQBTj4GGehua2wn13
 8TDxiDn2B8djbibmtS+zjAMrusJe/3SdFJwN8vY1coXYyk6EyiQP07rREfDzWSgU/bDR
 vRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730457338; x=1731062138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fBLzhfOsmeubrBeuFWFCFq0Ce7gEQt/2ou+mJrJnFE=;
 b=L7Khn/9RnE2/SOnm2bbCXP3+UMwFQmnCFIuHjQ+Phudo1UOjXTfDD5DacHpSORLy1Z
 ZnYpq6hy+4KO0vtCNddInUz+NwGtdIMr8d7ofaf62h69D+mpJa9LcIeKhyCKioa9JYNG
 P8GrbISrqCU2XqjWj9x7PpDdOrTfrgIgpIpd5tG4WIPjOBjy6GfVCnSY8srS0aP7iZUA
 YehZgfqBoYxEy2+n0MsFi0yAf9b2UKjPUiY3ORxbv0ixzDgFnf2rsVEWnI8RoNhsuZPn
 y999ONP3BtvRhuhSx5Nt3dC+fw74t+DKu9VQkj5Rni5+W1AdlwfuSUyGgLSBou9OHf+y
 M/Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ1RlTLo8qoi+qPlFUW7hoaPMUk4/Nc1RNVZgJKM+pRrfhCB1ZLVIdb/KolXCXvNG45RwcGfs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0JcUCawBZjqPH/gP89+c6+DvzXC5Ln8nR+Q97pny9k81B9JSl
 aCPjjjKlB7BQZsNy1/JwjSPBmVnH6CJ/QG1ScZuacjYijB01orSx
X-Google-Smtp-Source: AGHT+IHBp91fgeHq9tzWpBTSbDh4ADm+Dfz7JxaiqfLVm2JmjSeAsVSnd2xS45z5ogGFPh8/u0ruvA==
X-Received: by 2002:a2e:b88e:0:b0:2fb:5bd1:c288 with SMTP id
 38308e7fff4ca-2fdecd62f84mr37984041fa.43.1730457338146; 
 Fri, 01 Nov 2024 03:35:38 -0700 (PDT)
Received: from wpc.yadro.com (host-95-152-63-138.dsl.sura.ru. [95.152.63.138])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef5d7400sm5163051fa.45.2024.11.01.03.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 03:35:37 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, Wang Jie <dave.wang@rock-chips.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 3/3] usb: tcpm: fix toggling in host (SRC) mode
Date: Fri,  1 Nov 2024 13:34:52 +0300
Message-ID: <20241101103501.21432-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101103501.21432-1-bigunclemax@gmail.com>
References: <20241101103501.21432-1-bigunclemax@gmail.com>
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

From: Maksim Kiselev <bigunclemax@gmail.com>

PU\PD resistors on CC lines must be configured before running the TCPM
state machine.

Also, when the Type-C port acts as a host (SRC), the VBUS sould be enabled
only after the toggling has been completed. And we have to wait for
the corresponding IRQ to finish the toggling process. But this doesn't
happen because we exit from tcpm_poll_event() if VBUS != OK.

So, Let's check for VBUS state only when the port acts as a host (SRC)
to solve this problem.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/usb/tcpm/tcpm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 0aee57cb2f4..c9f8dbdc795 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -2122,6 +2122,12 @@ static void tcpm_init(struct udevice *dev)
 	else
 		port->vbus_vsafe0v = true;
 
+	if (port->self_powered)
+		tcpm_set_cc(dev, TYPEC_CC_OPEN);
+	else
+		tcpm_set_cc(dev, tcpm_default_state(port) == SNK_UNATTACHED ?
+				TYPEC_CC_RD : tcpm_rp_cc(port));
+
 	tcpm_set_state(dev, tcpm_default_state(port), 0);
 
 	if (drvops->get_cc(dev, &cc1, &cc2) == 0)
@@ -2234,7 +2240,7 @@ static void tcpm_poll_event(struct udevice *dev)
 	const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
 	struct tcpm_port *port = dev_get_uclass_plat(dev);
 
-	if (!drvops->get_vbus(dev))
+	if (!drvops->get_vbus(dev) && (tcpm_default_state(port) == SNK_UNATTACHED))
 		return;
 
 	while (port->poll_event_cnt < TCPM_POLL_EVENT_TIME_OUT) {
-- 
2.45.2

