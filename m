Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52598CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 16:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A19A9801BE;
	Mon, 18 Aug 2025 18:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PskUj+w9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F1DB801DD; Mon, 18 Aug 2025 18:51:25 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D550380107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 18:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30cceb07f45so2924277fac.2
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755535881; x=1756140681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lsswQ9vSHXgL4fnabo+LbmeWfeH1x9Bh5olKJ+gqxj4=;
 b=PskUj+w95Paap4CCe/GGIpWGBPctbld9RM75jI3qx1OhoSL8v6PyFpc0gBwLVbuqFh
 lrdXrD8dlGmUx9Yoh5GVNTf8MqcmvqeKIO5QzSLZTiVIWUKddeWhG/kyPj6kxN2PkoYY
 76ncGHiQpwtG+mP0qWt/+H3+KBwSsOMu3Sv9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755535881; x=1756140681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lsswQ9vSHXgL4fnabo+LbmeWfeH1x9Bh5olKJ+gqxj4=;
 b=QqNuwbc/6fby9Ou/jWTdR3x1CnGW5k7J/yRGfkjieCczwDr6CgcQHYBtFlRnqF9/AX
 5pfWp4SKX3TKGFXR4puVylnJtcZkidhTacxauIpp5x0abVMK0VDRBhcz+NsLlDFSe+D1
 QbNplJQ7HTKTP5F53dtjZqpnGpdG4d9+zwtGWbRaia6jKp1Bwc7p4sD5gb2CC0M7oVZP
 UrLjY+xMHun4anFWd/IGXY4C36x5CbW/5psHdXiBYnqpd9lZmC1QjpJpkOyAXtPm6AzA
 5g+vud+FH3kBx9ubhobkujoNR8S4JAudgR6+WL2bTzfBMaHGhQcQtJoRZcXoL2dJZPo0
 D7jw==
X-Gm-Message-State: AOJu0Ywx6uTlEs6Clz0VGHo2iPOxLXZcPGfYbKDTm4nMpFdbSwFOaumo
 7LtFnjRiPXq0BQXBXswV8Px8VfkarcV8MbQNxmXXcJI6hihcTn8+2e+Jhc7ayKLf2jNpVULYUyv
 3rFMbOXc=
X-Gm-Gg: ASbGncueAinLWXrW9GAXU62ZDxO6EkDUsuD6mP/GdnuHn6mBKfkodoI1djH2x1on3kU
 FGlsxDiMmTC/YRRMJzwaQxh9VaqfRKk7pZGvh3weFSjmZoZZcZMxdKNhXLoeW2StTf6aaCO1XvY
 W3Umi4SvxjvaeQVP6Y1qj2t76ayR9i2eBPstyt+0YYOunM1ckxNmAvhQ00bm+h5jY6PI45sKFQq
 obR4NRQBnXrY5h5SlzJx77iQHM3at95HhFXnKSodzSOtYwWaL7NC5xLWnoEAUXlDLEpUnOuGjD9
 9tGbWe06J1lh3d3EktUi//ilEAnCwSk1LVHZ6TXS+PucQf4pAKigFN7yI7Z5lQdl1yHtHJ+ytGq
 sj/K10Ex1/97eMJ9WXoaA/VQi8i1ZXm0ZWvVI47UkZYUjuTGqi92L8ZJE81k=
X-Google-Smtp-Source: AGHT+IHXZzIwjrBdv2+ysdh9zqXWuNfc0/tjnPuWTmwc2LUDHqSD51jlafKXu3UknE8mSq12cyOKrw==
X-Received: by 2002:a05:6870:440d:b0:30b:b37a:6bcd with SMTP id
 586e51a60fabf-310aab043f2mr8070639fac.6.1755535881499; 
 Mon, 18 Aug 2025 09:51:21 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab90df03sm2725804fac.12.2025.08.18.09.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:51:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Sascha Silbe <sascha-pgp@silbe.org>
Subject: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
Date: Mon, 18 Aug 2025 10:51:19 -0600
Message-ID: <20250818165119.3193853-1-trini@konsulko.com>
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

At this time there are still major Linux distributions which by default
boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
DISTRO_DEFAULTS to ensure these platforms can still boot.

Fixes: d780965927d4 ("Drop the special am335x_boneblack_vboot target")
Reported-by: Sascha Silbe <sascha-pgp@silbe.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2ff6f0037384..a6fc46ff4f5f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1163,6 +1163,7 @@ config DISTRO_DEFAULTS
 	select CMD_SYSBOOT
 	select HUSH_PARSER
 	select SYS_LONGHELP
+	select LEGACY_IMAGE_FORMAT
 	help
 	  Note: These scripts have been replaced by Standard Boot. Do not use
 	  them on new boards. See 'Migrating from distro_boot' at
-- 
2.43.0

