Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C459CD8CA8
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 03:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B1D849A9;
	Wed, 10 Jun 2026 05:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fK2aCeoO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F88849AA; Wed, 10 Jun 2026 05:02:39 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D983848D8
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 05:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c8588ec1b44so4290602a12.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 20:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781060556; x=1781665356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hlZ7n4atxHIZ7QEgXfMb/OaVtHAKNYfo9Bguue43gWk=;
 b=fK2aCeoOBy1POozmHUct2jeqyG+JBP36kV0LA+i2FTOzMZmS8x95znSLNL+md2lQKX
 gxn5H+X3eR2GvIoCFZ86pf6qSISnC//7aKw2EIfgs4iHRF8btSrZnKrjyJ8A1ydpYYUM
 7EOzHsimtAGNWJRpZ2RCz+VUuQUNH1EqakCiCxJSYotVke6KXcrLR3vGxoWf7HM3KldJ
 eOekRS569NbYcZZJO8STmMiITAXo+0ojh+4aykcDvjL40M+Y89gKnDDA4wPVUifz7SSa
 0sLZKnmOnENhzRjuvsMmuF2HUpeYjW8KCuaqqKAPw0bsL0kuXhNBkM7opuqVe6r5zs4v
 aEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781060556; x=1781665356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlZ7n4atxHIZ7QEgXfMb/OaVtHAKNYfo9Bguue43gWk=;
 b=bs6m7/dTKtcvQojtSvFrvlHH33CXM6ivOQo+Wyk2QVJ9f7FGg+qsL4BxuGfx5JMrCZ
 GyfLH5Nz0o6YfSwlu+LFZod6uuqyaYxevyoXlfRLu/Cty9BNxY9QZfr6dcSl09Pusxp5
 Do25jxfFXg4lunbaPmEsBeQrg6RL4UFSKWk734IsKIrUVb22PkjUHpJ1RB98GW5XDuwy
 4kdLpaJKnXb23g+dqlW8auylPaT6H1J512sndpSvwa+fwxI/YfY5fJUN1Cneszb3a79p
 fX2aLa0ssan4QHH87AJyvZuTlGGtix8FNc7hEbo35SjX8bVhDsuaoQtqEqsUGb5Fb2Me
 SDpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sqVkDr6/cM+WzCx3Zz3VxMRqi2xRzvWRvfZFK0s8BuJn436ukZvBJ8JnvWNw1Vng576x6sto=@lists.denx.de
X-Gm-Message-State: AOJu0YxRRSs7FL9xMxl6x+h3gyZzKP1iFSSxOeQPcu+5HG52mOXXSSwv
 VKqCji4/aShjCcRJ7rujYAFucMDmncWSnEr0gQbB3HfF7Ubsrs9cSc9YXoKQyraY18A=
X-Gm-Gg: Acq92OGRtg9Bh3ErLsc1iwin7grubWFjKeiTtgqvRNE9a/W4RV2YjRhw/q+EV2th4nd
 yDDuduyjRo+HhmY5Hk7gJYnO1arZrnY6fqQ1ANkYDtcd17S0mLJx1SGORiK3uIe/oa8crDzPiyT
 HuPPoBM0FFlvmEgRJ8J/+bUEduNLEmJxVCDJlUbplaYpVJABIjIF7m/uRfjRpxWcEMAIMyYBi2G
 J1DErjgh7Rcizh31Ns+p6NDXNaWKNDCeld/xj5cf5NB19MtUnOa8pkKyRbEkyEA8I1qpNeRZai9
 c1zpM/l3QqrGKX2qY7fp6i9jUFjPs97kPSC9R68SXMv3kE/hd5gKka4yx8Lw2ViFR9N5jkV+0Ny
 O9nPz4ytTCBzjTFhF7Z/YNpQANdUBX2JM7a03EtjiM/XxUfskxyKvQ3dHoCU5H4Amlv+x1WK5av
 ZUvJHpGiLWqQ==
X-Received: by 2002:a05:6a21:6113:b0:3a2:d838:bfc6 with SMTP id
 adf61e73a8af0-3b4cd007d6dmr29798988637.29.1781060555634; 
 Tue, 09 Jun 2026 20:02:35 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2607:f130:0:13b::3a])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df04a0e9sm17102453a12.13.2026.06.09.20.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 20:02:34 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Tianling Shen <cnsztl@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH] rockchip: boot_mode: fix download key detection
Date: Wed, 10 Jun 2026 11:01:54 +0800
Message-ID: <20260610030154.173455-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.54.0
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

rockchip_dnl_key_pressed() looks for the ADC device by checking
whether the device name starts with "saradc".

On RK3328, RK3576, RK3588 etc., the SARADC node is named "adc@...",
so the device name no longer has the "saradc" prefix. As a result,
U-Boot fails to find the SARADC device and does not sample the
download key state.

Do not rely on the DT node name. Match the bound Rockchip SARADC
driver instead, which works for both "saradc@..." and "adc@..."
node names.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm/mach-rockchip/boot_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
index 55e9456668ae..363fad523cbd 100644
--- a/arch/arm/mach-rockchip/boot_mode.c
+++ b/arch/arm/mach-rockchip/boot_mode.c
@@ -51,7 +51,7 @@ __weak int rockchip_dnl_key_pressed(void)
 
 	ret = -ENODEV;
 	uclass_foreach_dev(dev, uc) {
-		if (!strncmp(dev->name, "saradc", 6)) {
+		if (!strcmp(dev->driver->name, "rockchip_saradc")) {
 			ret = adc_channel_single_shot(dev->name, 1, &val);
 			break;
 		}
-- 
2.54.0

