Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BF6CD37AF
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 00:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C949C84A5F;
	Sun, 10 May 2026 02:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="zyfrrmLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3960984A44; Sun, 10 May 2026 02:07:25 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241AB84A63
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 02:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b9fcf7c91bso30938195ad.0
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778371641; x=1778976441;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BQkDeHAzzvEbfMnWz/rrkhqeYixLSuvSQJhpOEYPjag=;
 b=zyfrrmLF4/D3QH97uGrRQbXao/BvDvOApAchmmOyDN6+MVRQ3Kf40ZRxsBpb46wHfV
 T0U4BTlhbpw5BGpS4WeA1nXfYrvJgpdChtgd6jdOzjKXW0OssKkLpceYqf0AlqQkH40z
 +4B5aUfqrDCXnr0+d5rn1NsQUIDgJDECfGlV33xHWcIzSx/piIhl7WJxe8AHrd6hlM+q
 Z7fXnjIQo/kXuHzKSkBnzNHoEl0Sui7n7q/AsncLccCnWWGkGfke15tm8fTDLotcgvZR
 LGayiWuaMeKovLxad1jUK12gybnVKboCS5uhfOdE43PqD63SNCPREW4umxTLYlKpC81P
 xXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778371641; x=1778976441;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BQkDeHAzzvEbfMnWz/rrkhqeYixLSuvSQJhpOEYPjag=;
 b=Q6NyAe9UkcBvy3ojerc9tIEFLvxBtLD+MJALvFCNBLGVOTB2ELhthhw9bkLKM3KaTq
 n5e1AjsEybsfyoGMi/+Ilgm9+wCxVWhrQI3ycCf1KKqrxlFjDj/xrabygfF8FORpwhBI
 VKwbXsAFhFqmfvMNC38TVzkWrZt1vqrMluIGJPlZwYhHnjnm+bVib9/wotXMUzs+VE60
 yH3buI/rNioJzS6c5tL4bYzg+2MQOQsDUvB631HBgbOXLvm9db8vxbTm401PURrD3apP
 76TAfrBS8mps8eWhlIyAVpCos/GMiZnb98uAJuo4aydjCyYDr6j+i0pUVJMEeRWPKMzX
 exyQ==
X-Gm-Message-State: AOJu0YzQnTemQoJrJb4+0UVfP5IUdHEIiQjXS+KC8d9QZJ49Po0qoyrD
 XtNMKXvWdcAdnKftT/wd+5OMnl2b7MBcKg859x8wyGllxEs/GV3/KbYdjTk6RuVakzA=
X-Gm-Gg: Acq92OESpIVlecsSb9vRzQWXqo7PsjNfSRq3xN+91rTUm5eKOkYQQbfq3bQoDgR3Lgi
 p3sOtj9PIRePuYiLVc6MvEXfUneHN6TaKiVcoOUiG8MQahWf0ufmeSWIHWx7a1+WhEDJwa6D4ih
 3Az4xYCx8OsqM+CtOta1jijt2kLBC+7AtZuryoz6YJHMWkoYJ2CGqakk/1S+n1P9T7xc9jF86oK
 mOlNc7UWPzhRB2zsUWxT3W4OlRWlfx/G7Ixk8gNkNUbBnssPwMISJZjCOM/LKix5jRyORTHnTbn
 E2dB3CIUJA/pdI8sxryGnY26w0vyRN9aKuRbb2fgkO3MBQkcuspTZGA/9+8EMBde/iMYs7cP2q7
 W8SgfJoDAUoqex/zn8oehQuOutpdkc7OVxxxAu2+23esOepagZf5lLhU3/EPhriOi9SLTIvZBB1
 mZMWbofdzgk5pxLtfw1g9jDD2ZTijpYWF8SYT45inSM3zKrt3kyb53MQ==
X-Received: by 2002:a17:903:13cf:b0:2b2:501c:bc0 with SMTP id
 d9443c01a7336-2ba79290f29mr175414205ad.7.1778371641448; 
 Sat, 09 May 2026 17:07:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d3fee3sm57010625ad.18.2026.05.09.17.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 17:07:21 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Sun, 10 May 2026 08:06:26 -0400
Subject: [PATCH 4/8] configs: bananapi-f3: enable Spacemit K1 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-b4-k1-clk-reset-upstream-dts-v1-4-db0b0503ee44@riscstar.com>
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
In-Reply-To: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

Enable CLK_SPACEMIT and CLK_SPACEMIT_K1 to compile in the K1
per-syscon clock drivers.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 configs/bananapi-f3_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/bananapi-f3_defconfig b/configs/bananapi-f3_defconfig
index a726ce84775..9f9424adc9f 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/bananapi-f3_defconfig
@@ -17,6 +17,8 @@ CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
 CONFIG_HUSH_PARSER=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_CLK_SPACEMIT=y
+CONFIG_CLK_SPACEMIT_K1=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_RESET_SPACEMIT_K1=y

-- 
2.43.0

