Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D52CFA374B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 14:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB4B88425A;
	Fri,  2 Jan 2026 15:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SI88u79o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F3084248; Fri,  2 Jan 2026 15:47:26 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597EF84248
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 15:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ED2FF41965
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767365240;
 bh=JnaDYBxAOL7Ni3vlunTq2q7tJElZjhw8iEeQsFbkXo8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SI88u79oevBO7qV0udGwxm4W3k3SGwDgjMhLkVUVV261XgjPTj9oKnv7tyFX7faTO
 3Qmvrk5kLzAzesMsSCyAQTEWbI1XdWuIiYiCB0lXDGCt4FKaHwrbWVvdIuaE9aNBVD
 kL1GJXbhcTbGV6uojyZGcLEMWs++vKSPIQAULvJQ4V5PwpBkpXDoSg3X5xptMgCV7/
 QOZy6PvrF90+OVlacNG9rBAdqu410ETDOrEh88imgui83MKcEzu2jye9IO8VP0CYax
 TimbqR7hdtcbfkessYwuq3WJnDYYqHtK+de6mb7Jh5v6hokRiOxM/WBmMoqfJLLg1+
 335oE1wWC8x3xlCZKgtJgBmG+gxlV1d1ib92nOvtbP+6mytrZ2Tv7n+3u1u5dKEAb/
 0BUjdAEdJx7i3NCtUo9sN5tKixbNC+6LgtSU+utvYs/BD4HU/zem0F914yqquUBd82
 h0XWvHpOMTUtbmfcG/5d6+TYzkoj1KYFdqjoHCnkuJq4fY9XVn0mYMBKPzmRaWB0bS
 ideawxdiiNk2m8vrW0eDiJ3MQ/M907yiqG3exriCzUP+F/6am4Bk1UTvJXa+AJAj6L
 kWhyHaZ7lKa9OQXuWzmSial6/8tzEO4aLRTV77yaTShW81gaEVBrrEVw0d5cRdvqDH
 VfQHFK12Yjzwb48rHcvA7LnQ=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47a97b785bdso84178705e9.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 06:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767365240; x=1767970040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnaDYBxAOL7Ni3vlunTq2q7tJElZjhw8iEeQsFbkXo8=;
 b=Ol6qKiO4U3m4HeBUECn4lx09kFr1i+3ZTFlNhDacWPl6XX1vYRMNoIEGvbWAc81sWd
 mT/iHqyUJvIvOA/b8zin/oFWTndmTFRt79tJzkevfKtusOKCuIOrVJXpX5oESOgSrslm
 25dxR64zNP/9X7RXGNF8lVdGesz32hyk94TnHYorJEH/mt+QNNxnvImFksNY1ASRirSf
 QF+IQyFS87vIzH/ucGYdZT5THBOjExo7nAah0+x/AqTPW4/GE1Fq6IJhsCzQ2nhoxTmY
 Zt+g2e/Uv9nupM8YXfkU50lrEDr7t4Tck7oHjONEo3D2hXkA+W4d2YKfbmxB6MriZHzy
 VfUw==
X-Gm-Message-State: AOJu0YzotMIFruc0xUO2qQKHV601a8i0X9BslZVkhMS+d7DCwu4hpLfr
 Rj+dXf7cIE8Z6HrZSQsqX4Abe1roQJkDOP/mqz7kGNJ+/sk4YYa3eCgJoXGXUMGOtq+ml7aYLu7
 j0YDVwhAOa9y3dCDdDQobPxElHsmqVzpUlC5Y7j1NlXw3DAOPJwGTv+cp2fS19Tz/P3yjNNQ=
X-Gm-Gg: AY/fxX7Z8O0NcGgI7ELxLR2zqxZ/v7Ij2aysscwXD1MKYyb9QFvG26Bl5ZmGqJmhHyQ
 4VWYMNE6CL9dMhQfx2R/ARYZ9IeSkc3LKjriOD/MhIrkD5HYDHsnoMjNw8CJjXW5iVPszIr9rdt
 owqWOVW1MNv5mud+3Na6YMW386FpUXZ4R8WMRcsne3Xxz+/KMJEk45hoWBM3WLovH9tIVL0u2na
 yvH7VA3YHOe8KQtG2kEI6jFRhp7UW81/qRGldoBs2tfi+aWsI4w4/ngUDNqxdOuwN+OrFjR9TkQ
 dAN4icU6RJ54EbLmQ4CE86lxMABH1h/Y5BqvxA3MCAFWhatopLLeMpL+fuHXAv3yoaOuu2dhYQT
 NZNXsyjkrbs6+RywByMEKnCwNSw0WrtXqSPyAtQfvPo6RJi/k2RzdYvZ401Lq/S6BCl+1JQA47X
 MA
X-Received: by 2002:a05:600c:45c8:b0:477:8a2a:1244 with SMTP id
 5b1f17b1804b1-47d195558bemr486487715e9.11.1767365240583; 
 Fri, 02 Jan 2026 06:47:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmtS68b7D3JUkiKQjKcLuYcAZ657f45A5nRXfotv8FuYbvGGw5aUTH3FaDolLZhnFP7ILAKA==
X-Received: by 2002:a05:600c:45c8:b0:477:8a2a:1244 with SMTP id
 5b1f17b1804b1-47d195558bemr486487485e9.11.1767365240203; 
 Fri, 02 Jan 2026 06:47:20 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82feasm85749911f8f.24.2026.01.02.06.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 06:47:19 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] usb_kbd: remove match string
Date: Fri,  2 Jan 2026 15:47:15 +0100
Message-ID: <20260102144715.185656-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

U-Boot has added a compatible match string "usb-keyboard" to bind the
USB keyboard driver. But this compatible string is neither used in U-Boot
nor defined in Linux.

USB keyboards are identified via a USB interface descriptor or via USB
vendor and product IDs both in U-Boot and in Linux.

Remove the superfluous match string.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	expand the commit message
---
 common/usb_kbd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 36107a3b278..29b01a85955 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -690,15 +690,9 @@ err:
 	return ret;
 }
 
-static const struct udevice_id usb_kbd_ids[] = {
-	{ .compatible = "usb-keyboard" },
-	{ }
-};
-
 U_BOOT_DRIVER(usb_kbd) = {
 	.name	= "usb_kbd",
 	.id	= UCLASS_KEYBOARD,
-	.of_match = usb_kbd_ids,
 	.probe = usb_kbd_probe,
 	.remove = usb_kbd_remove,
 };
-- 
2.51.0

