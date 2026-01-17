Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94A5C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37EA083A9A;
	Sun, 18 Jan 2026 14:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PZp0+F4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D563833C6; Sat, 17 Jan 2026 20:08:28 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52DB382BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-502a98c66f7so12987641cf.1
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768676905; x=1769281705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzOr2Ehkw99Rz+W6fQ8Lrf3BStVE/BxJKxRwyX6FNiQ=;
 b=PZp0+F4nt/q79quxqTkjk23tKoNJ+13Qfm6CZ9+V7czy4nlCjxYfDEjat9kKR3AtX9
 /lD6C5hZISn2VdRf/pgYM2Wvkxmikf0X/IjXZGJHTESSQt4ugWUZdNo5+tFgC+C+YcYo
 y1jy5/a8Whl+bhzYo5Q7K5jLtEJMu/1o6o4d1oQcrL5wauePoAFskestXSbKpYLjXP77
 UPHbES7WM0AANYf9nJSTPRbSSmI00lYoXO14tyOqwwqn/e44szdq3E7O3hImBdU2Vbqi
 c/eEcJvB8oHNuL1bUobB3twzqjmE+pUgdLLDMWEDlT6Vk7ql0avUtHBeI60HHRXZmrVC
 jsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768676905; x=1769281705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HzOr2Ehkw99Rz+W6fQ8Lrf3BStVE/BxJKxRwyX6FNiQ=;
 b=EPL5cFh4wAt3KVI9PA+DZuq72F7JiVVRnEQW37ofbLmTZnEnd9F3X1/r0g8wFmtPx9
 qq5W544XZB8nSf0lpkFtqdXtR7egVFAzOGuEPjPGEqtFoUkzuBEG4oLum2Msju9xvUC8
 3ff19g19NFuhEdP513USlGLYtPPJ60depN/3THMvyNFZoQinz2oZnKnCitPtcikx+i5K
 N9zP1DdLUmYoQjS53i437gh3zEjfG/ThHjc/LtA09KFzNf5hByGOhxgcl30Sf7vv8n5D
 ccdX92rRb0LXlWghoAP8ZSLtpWPbzXX1v9EJUF9saqjabNZnnJYwpt/b+e3VgEsTGk9j
 b+dg==
X-Gm-Message-State: AOJu0Yz6BG5p+d+O8rIo3BriXynXttuUwh+Jm+nmZ2ENkZxH6FJeroC1
 62O+6Yr3SVuOD2a0tjOvpfz7zgayO2xeAu5rp0gURafeY56MTcFMVZmu9R2Krw==
X-Gm-Gg: AY/fxX5v3A1k+AexOYipjF+kM6zRp6aVF+y9/jkoUCG0Vtrbc4shQaJYSxmCaPSGoOb
 Qw9VZgkT2qgb1KTW/bbaspn2+ldvM//TuliYmhvDp4zCg/7bbby/5fEs4+rjINtmmZ0BN5YW2rr
 klpJaQO3jEOxBFoWNH9DFkfkjX4z0UJZ8Ntx3Kv2ftdzOXoL4sLeKtVp8Q1lESbINp7p93SuqT+
 DV8IpJwaOcF6Rc2YlUn0FWl0ZdP46HR2xELWsfNW0NqXxKrRi42WetSug6X0/BBBuxYuiaw4DlF
 rxp3SYDjucqI55hIycW9dkQz/1L507Vz2F1HD8+FLH2/Vcg/sm+vZPTGBJeaRbmZ/XLPsb+/Kdn
 jDslMi84faiCSyBMRZFqtcpv0y2LMRearc2jTtG038jXvAuo/D5l3ySGuOxe284orn08oxQbAgQ
 N/WnEkLY0MONE0gosmY8K5xyBHXTjCjOMkXtqcDcUI7fhYukReJR4ABz+ELTfQD+A6aj3+Ywo=
X-Received: by 2002:a05:622a:548:b0:4f1:ccdd:ffde with SMTP id
 d75a77b69052e-502a168a6acmr96263041cf.21.1768676904837; 
 Sat, 17 Jan 2026 11:08:24 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:08:24 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@gentoo.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Aniket Limaye <a-limaye@ti.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Samuel Holland <samuel@sholland.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, Finley Xiao <finley.xiao@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH 09/17] board: k1: initialize clock and serial devices in SPL
Date: Sat, 17 Jan 2026 14:01:43 -0500
Message-Id: <20260117190231.977686-10-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

From: Raymond Mao <raymond.mao@riscstar.com>

Initialize clock and serial devices in SPL. Otherwise, the device
driver won't be loaded in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 board/spacemit/k1/spl.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 11a097389f1..1c299810d39 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -3,8 +3,44 @@
  * Copyright (c) 2025-2026, RISCStar Ltd.
  */
 
+#include <dm/device.h>
+#include <dm/uclass.h>
 #include <spl.h>
 
+static void clk_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "clock-controller@d4090000", &dev);
+	if (ret)
+		panic("Fail to detect clock-controller@d4090000\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4050000", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4050000\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4282800", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4282800\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4015000", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4015000\n");
+
+	if (device_active(dev))
+		debug("clk: device is active\n");
+	else
+		debug("clk: device not active, probing...\n");
+}
+
+void serial_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_SERIAL, 0, &dev);
+	if (ret)
+		panic("Serial uclass init failed: %d\n", ret);
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -15,6 +51,8 @@ void board_init_f(ulong dummy)
 
 	riscv_cpu_setup();
 
+	clk_early_init();
+	serial_early_init();
 	preloader_console_init();
 }
 
-- 
2.25.1

