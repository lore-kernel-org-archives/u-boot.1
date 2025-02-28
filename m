Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251B2C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC2F811D8;
	Fri, 28 Feb 2025 13:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="csXU5Sl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210C7807D7; Fri, 28 Feb 2025 10:53:47 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3264080FF0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 10:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1146843f8f.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 01:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740736422; x=1741341222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkMIdz3ji8pj7egmNsUJ6bkUoECnxBdjjEE9KlwxrVo=;
 b=csXU5Sl5PXLZCdHTVdyTEc7i2NHxZ3HhVrgSrqxYb/rBu8AzAX7fRyH5J1f/gicgZq
 mnouW9HIUUhcBEI3DXoHCxRScQyravKuVkZ63yrAwPqIOCePPjk8E3sGHyJGe0XSYXmR
 6LRSGcKqlULrTgX0Cg+PfXFzjgdmY1ksfvmyeG4J84X7+5fSSO5ZCJHt3JRI5UPYUVYz
 VXhUOwph6kkuD9GwBcHNc+geE9XjjUlFB2McYi2Z2fIWSqZ7hdYhp7/k3VdLq5XWNk8D
 jY+UM/92DQExA0suGI6T4vNFmZYLg9A3GjQg52dGUoVltUYAO/xT7+iVFDN5WNDuuWln
 VF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740736422; x=1741341222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lkMIdz3ji8pj7egmNsUJ6bkUoECnxBdjjEE9KlwxrVo=;
 b=FsjS/l828gi/tfJr28Rg0QYt+HvzFPI84pBDyLB3zaBntDyQb4I+wlKVPxsgIIDXcn
 Cl9mIXRcLGZ2np/TnL+jO1kBxbhKI3NqryIRGMOxN0apNsweeYcvya3k+qPmhe1P4x+f
 3TODR0Z2zzLlhRs7iqwHNjmnQ9nN5zMBbjE/yqrhIQl5o06sADkOzMwF4ekP7V2/WxcC
 QmvCgrGmoYULxD4i6BP378yylXRA5HO1swYrty948snJJVK6gDTobZIeKlIC5+abpeij
 qHQukzb9TrHUtmj+Y/JUf29ca85Glaw0eGeHg82IGQ0r0bsQDWBsPYoB+NDOwETGlwXU
 cvhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmK3npazzWdm0nfwC32mwoXkj8NRqHNOOHXDQR2oSrF3yVHz4lPNHVSu7UkywM2YJILQY0KEw=@lists.denx.de
X-Gm-Message-State: AOJu0YzT3eHziVJhDBdYW+bY8iiKAGks/vVUVcKuTDO5I2MpGzRPtBAT
 rPPRqPO8aD2G5h4jjM0R9nEPm+KFfSqwfeKD78ktUg1+9shF9gpX
X-Gm-Gg: ASbGncuRi01DsGjWgAH/QkygCN3n5zF5+D6h2fA3HbldG5WWHGoFoDlPKTTrv8v4mHl
 iQ7ifwPiiXEUtDimEaxAjwR87rrm2ftdoa2T4LzU4idKkzXBDesWXo8PlYc2xhMO/bKwc+HFIfd
 z6STDoncqg1gzlUZVDjtgFUz99wgkSn2Jbc7EMP71K2Q9KAm0xc+DuE/qp2VSVcfHWAVpso+wBH
 zvaG6xEyiP7JvcTdHmdc+oHt/DTDoKvPlyrN8wLld3xF5yvujAkwDjqPvPslBw9qlwXElgnOaNl
 BNIuUcjJ9Y5lhtfTyCz65gKjMsU3D6jsZFODmfEdvCJh0VV3sWYUyOgOKwV1+F2HPAkO18xe/Lj
 LQN/5
X-Google-Smtp-Source: AGHT+IHYyJKMhW8xRSqOBTQmYaeZRgyTgFABwN8c3L5UHbhcbRLUQFCiQAtJ7sbusyPeS2f151XrVg==
X-Received: by 2002:a5d:47c3:0:b0:38d:b610:190b with SMTP id
 ffacd0b85a97d-390eca377a4mr2057837f8f.46.1740736422561; 
 Fri, 28 Feb 2025 01:53:42 -0800 (PST)
Received: from ernest.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e46f580bsm4667401f8f.0.2025.02.28.01.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 01:53:42 -0800 (PST)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
X-Google-Original-From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Parth Pancholi <parth.pancholi@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v1 2/2] toradex: apalis/colibri imx6: Select correct DTB for
 SoM v1.2+
Date: Fri, 28 Feb 2025 10:52:54 +0100
Message-ID: <20250228095317.621037-3-ernest.vanhoecke@toradex.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228095317.621037-1-ernest.vanhoecke@toradex.com>
References: <20250228095317.621037-1-ernest.vanhoecke@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Feb 2025 13:45:41 +0100
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

When "fdtfile" is not set, use the "variant" environment variable to
select the correct DTB.

Apalis/Colibri iMX6 V1.2 replaced the STMPE811 ADC/Touch controller
which is EOL with the TLA2024 ADC and AD7879 touch controller. They thus
require a different DTB, which we can easily select with the variant env
variable.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 configs/apalis_imx6_defconfig  | 2 +-
 configs/colibri_imx6_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index a3f65c5c0269..f51386d10a88 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -31,7 +31,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run distro_bootcmd; usb start; setenv stdout serial,vidconsole; setenv stdin serial,usbkbd"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6q-apalis-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1055
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 4c6ba80789b6..9fc844b32690 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -30,7 +30,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run distro_bootcmd; usb start; setenv stdout serial,vidconsole; setenv stdin serial,usbkbd"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6dl-colibri-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6dl-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1056
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
-- 
2.43.0

