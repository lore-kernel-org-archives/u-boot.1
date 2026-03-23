Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88491F483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E554C84246;
	Mon, 23 Mar 2026 20:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qogBYzuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA093842D2; Mon, 23 Mar 2026 20:53:16 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947E984088
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40429b1d8baso1496679fac.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295588; x=1774900388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rLYC8BDCfv1z6GR6pLGZniMySwluO0SJYEgoaHIbzA0=;
 b=qogBYzuW/2axX6uUp8k+5vnGTIOLpBF/BWLguyX4nTFF08fKcCX4TGTg9Q+uMvrqQo
 WM6+s9s3jLeWyoMw9dTsIS2zBV7SeFUuRtHEwVfgm6NQMnb5fTLEq4R3YFjKHBVYjKwK
 gWDf6eMMEXb+HHzi5O+pPtgZXI4WfUA3/a9rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295588; x=1774900388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rLYC8BDCfv1z6GR6pLGZniMySwluO0SJYEgoaHIbzA0=;
 b=N/dlbHwkvkzsqDt72QC7XvHXFV9QhXDwx3UsQwHj2YsbVFrSHD/amyBhQ5uZhWLa8m
 CuVuePRnipYwXoDYcs0/i3Ekev8bavMMPe9nKuL8rJZVRqPp3F2JY6NZwU0nofapLmpR
 PwlOQxfMRUXMsCqphmsOpZwTK9rYGEuKlaPuvC7gccKGEH2ET/dhO3CNlcHHTR85IG1x
 JOxOYS9WMj8a/WfsEp+Yv49ipV6wJBYserB5cu5caYLupbPzDWVzxpcmfqwZA8le3zR4
 uBy5+sqxxxhYsOMqMq006mta4kWgp1DCbJDNYq5oBzPfWvGP6nQzO2abfSTTyLhZka1o
 c3iQ==
X-Gm-Message-State: AOJu0Yw9TpgM2SGjDi6mTb7vV266dhvDogCL/aYq+Y2kUtLqMdXbalra
 gffU47tkCcexDkRw1IgbcEsCipLkvXAa8uSXIcjKeAV966edPiSmjWV+xuovKeZQsUYOOTwQuQR
 bgPA8lV4=
X-Gm-Gg: ATEYQzxzJBqd5t30UupLBcUrgVi7xcMBJ04PHTADO4J7WpvV+mKTWwKYOsDg7YVhE32
 idhxp/wTT5XuOg1pXChFOnHtJUKiFKy8pcrWnSeXxMpq4yGVPjNwtvlKy5EybbPaU29WTL9yAsd
 5r6YLclVVk0HgaBCg8+ys8WGUSMppw/gA5EBj7Pj75bEnvai8yrQkZjIzm6rRV5QqOjtuzxYkj7
 z0PPyLKK6QmnOJaN/X+XICE7tRDNE0REKlPUl5Hi0MPo5sKoYvlTXCMQPSIpUo5WZ1lpgkPBOH6
 jPdi1P9bekfvX56NWM+MNXe/92tDG23O9rz+vhU3ZExvmyQ2eVHJUIXQl897hsq6O24F0XpK2zX
 zwUxhcUlTAsyX7Fg+7e5XaAXxIJxdfj3PTLkqLQ4fMusW994K5zpn1u+l1R6aCmBycho/yvg9CT
 KE/kOogx2WD/k4sifLlaJDqCl2QLjBTD4hAyAY2Y8T4fzJ942neV4M63tx1GJoN/+nmeSnFIrHZ
 JKlszsbKMKiJkohrZrVH4y8RHR8ko2h8gITB0Ugw9PXeWGwbDo=
X-Received: by 2002:a05:6871:8909:b0:3d3:fc6d:b5ee with SMTP id
 586e51a60fabf-41c1122c235mr8913251fac.40.1774295588168; 
 Mon, 23 Mar 2026 12:53:08 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14dd0a6bsm10654279fac.13.2026.03.23.12.53.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:53:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] serial: omap: Fix "unused" warnings with SERIAL_PRESENT=n and
 OF_REAL=y
Date: Mon, 23 Mar 2026 13:53:06 -0600
Message-ID: <20260323195306.2363609-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The definition of our ID table (and of_to_plat function) is guarded with
OF_REAL however the U_BOOT_DRIVER that would in turn use the table is
guarded with SERIAL_PRESENT. To avoid a potential warning we must also
guard both with SERIAL_PRESENT.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/serial/serial_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/serial_omap.c b/drivers/serial/serial_omap.c
index 224d9cbf29d7..8289336e08dc 100644
--- a/drivers/serial/serial_omap.c
+++ b/drivers/serial/serial_omap.c
@@ -104,7 +104,7 @@ DEBUG_UART_FUNCS
 
 #if CONFIG_IS_ENABLED(DM_SERIAL)
 
-#if CONFIG_IS_ENABLED(OF_REAL)
+#if CONFIG_IS_ENABLED(OF_REAL) && CONFIG_IS_ENABLED(SERIAL_PRESENT)
 static int omap_serial_of_to_plat(struct udevice *dev)
 {
 	struct ns16550_plat *plat = dev_get_plat(dev);
-- 
2.43.0

