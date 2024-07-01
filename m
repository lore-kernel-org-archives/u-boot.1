Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5F1C30653
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 23:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C319A88655;
	Tue,  2 Jul 2024 01:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TmUTPJtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A700886B1; Tue,  2 Jul 2024 00:00:22 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8AC886BB
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 00:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52cdf2c7454so7388130e87.1
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 15:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719871218; x=1720476018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UHMt2ncuTtHonTuLdimx1zxT37IDvLAX3BAnYG5Y78Q=;
 b=TmUTPJtlby4y2IE2GXaj0L8tZUpt/V7xmmxI8SkJxRmYFzFBF8iVXJMeL1cvbU8s1S
 N1Bt0kVz+WNCgaZv7I1arMBF3YFrf9QicElSxSQ1gx8nQfP9FfT4bonsPUJmbaTK/5q8
 7clL3jgdljVs1Vi8g2Jq+pF4184qjOLx2doq6F7viEDoi/DSdfKmSjbou1IvIkuR7Fg3
 QvdHE5pidLKUJ366i0DR7c0V1G+l/WtjKfAssQFfo2h9qKiq646Liker1sUbo7+qofvS
 gbNbvlGpwyZYBNr2vvw75reZMtLR3wEAQ7aYyldZHrKkCcAjgZWuALsToLM/Uty3LL+M
 s5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719871218; x=1720476018;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UHMt2ncuTtHonTuLdimx1zxT37IDvLAX3BAnYG5Y78Q=;
 b=YuseJK9p8tbHFPLo+d7c3YtgnVOp2X7fTDeIx5hL3lkbe2oAQJNHWF/SGH48pxKsOb
 BE0B9+y5Tow8HvkdnuWW4+eVeCfx3Ly9JuDKORdjB9zo/Kp8k2Vt3paqWKsfwv89jk06
 iEIlHdpyNpHPStj3zOTCxP6Yw4FJJMt489JGSE3xx5gLYXnxJyjtt32++jrEE181b03/
 5mZqd4E3rLNWynrPCQA4CgjBNe8ejZvaA60xF8wPevVnM3fcYPDJ8s/iLeBUo1cQfHo0
 7AOz+gwQkRvNrvHyyrgEIqFz8A4v+5RCHkM0VG9UCkGuSa53hImuKUyPjl0w/iM+02To
 wuFQ==
X-Gm-Message-State: AOJu0Yxmv07PwA0vGO3m5u6i8Fp7/N1Ve+nqd9m1H591rKIjG5ZDnFRQ
 Kv7UEiIdtnkQjp9x8weMVrZStUA1ip+/lh/AyKROPjDGoDwwlJJ1
X-Google-Smtp-Source: AGHT+IEsodzegFmUhI8K3+YoXe+Iw19w6LPfPwhHOb0WtFE0kc9wWZFzkZAyRNpe2G0jJArq6DTVaA==
X-Received: by 2002:a05:6512:3b12:b0:52c:e3bd:c70e with SMTP id
 2adb3069b0e04-52e8264aec7mr5636251e87.6.1719871217413; 
 Mon, 01 Jul 2024 15:00:17 -0700 (PDT)
Received: from 9a2819e34573.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf63981sm358079366b.82.2024.07.01.15.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 15:00:16 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: marex@denx.de, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de,
	l.rubusch@gmail.com
Subject: [PATCH] ARM: socfpga: fix broken function call for arria10
Date: Mon,  1 Jul 2024 21:59:27 +0000
Message-Id: <20240701215927.285961-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Jul 2024 01:35:34 +0200
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

Remove obsolete arguments in the function call. The call's argument list
differs from its more recent definition. This breaks compilation of the
'socfpga_arria10_defconfig' target, with additionally enabled:

  CONFIG_CADENCE_QSPI=y'

The removed arguments are obtained from device-tree declaration.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
The patch makes the problem disappear. While messing with some old
Intels, it looked to me as if this usually turned off code region of
the misc_arria10.c still contains legacy arguments in the call. Thus
broke my compilation. I'm unsure. Please verify.
---
 arch/arm/mach-socfpga/misc_arria10.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 93c9e8b0..5c782f6b 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -211,11 +211,9 @@ int qspi_flash_software_reset(void)
 	struct udevice *flash;
 	int ret;
 
-	/* Get the flash info */
+	/* Get the flash info, speed and mode will be read from DT */
 	ret = spi_flash_probe_bus_cs(CONFIG_SF_DEFAULT_BUS,
 				     CONFIG_SF_DEFAULT_CS,
-				     CONFIG_SF_DEFAULT_SPEED,
-				     CONFIG_SF_DEFAULT_MODE,
 				     &flash);
 
 	if (ret) {
-- 
2.25.1

