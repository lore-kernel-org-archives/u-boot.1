Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A89C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 17:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C948088064;
	Wed, 27 Mar 2024 18:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QxEvu4iz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62DC58808D; Wed, 27 Mar 2024 18:04:53 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C24788019
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 18:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dee5daedf6so78355ad.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711559090; x=1712163890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+vmfdBEYYDTQSEs06g/md/jJELvw2LnBXWsyS8YipWE=;
 b=QxEvu4izjAm3ywLKxNEigYj0WKGJAMiX1yLYQ9IE1vNHSMiA4JIODk/zsQEx9Jl160
 J0aVapLAIK5NieWcY31wRs/ff+CVOm6WEF1YMPUxgHUuvvH1T0obo1mttJMS2GSrgZe1
 dJOElnxFXfAM+1RXDjywIMLl6Q+/td5LMzK0JWNm9CwjftgA7BaZJly9gqOb1g+hAL9M
 2nKneqLgqZ8XnhJQzN1dJLp2hFw8+z+/uHyr4Z721Rf2FuFPkaEKibzjjALY/c/F6ixT
 34XFdKcUtIi7Gs2cypRioxRLBc3S+Qj0PuYK6pJ4D2zr2wPz4RprgzCpUUDY50mPRVtH
 kHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711559090; x=1712163890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+vmfdBEYYDTQSEs06g/md/jJELvw2LnBXWsyS8YipWE=;
 b=Ef5+Y2XpYKAdNQWtvLqTOwWtsmxAWVmv38qbec/ahuVqszW/6So1mTE54KAC8TkloY
 5crFAaWy0xr+NfzbH5KHxUY659prs1Ofzz7nSfF1Tbe/Y87jKk/aqYt6OFE7Ba+XT9BN
 hZXIPDCwj5oYjHlYXxdkwowqwNflbnVt5VVcm0Q7lmMkn+CUnD2b8k5Sx/fJwxfwMroK
 0YLC0iJWVtmSFw73/tNOroT70/oCFGBgWXSsAZzbDBc7yAVC6Wr3C2SHZlDxgPZ1HOpD
 IYm64uUSXQYjiRIZXSnmlUf6ezskmJHXJrNzWKOf2RRsoJOibfJtxvJCS18MiEo+T3j1
 gGLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfq5XdtevvZW32awoHFRep/qxslBuoT84HM4tjJ+p2GGSFdXK9zr25WdVvKPOHiiTynVFHYMBP6b5bWEdtmixy8CYKWA==
X-Gm-Message-State: AOJu0YxUd4mRAmoSrwJ0bBhAUoiWuddrzhzi26rQ5djl0KGhgf4P5195
 r6qk7vjdf+VIAIy/Kvgvk2ao1jaXHAVRg/mh1qhcCNWBal5vptHC
X-Google-Smtp-Source: AGHT+IEZ9fnWodp3krOqjUVATyRaJvs4/2EvQ826u8+dgpJynE75/iSLk5heWjr1i48PjJBQrqVCnA==
X-Received: by 2002:a17:902:7b87:b0:1dd:e128:16b1 with SMTP id
 w7-20020a1709027b8700b001dde12816b1mr249986pll.6.1711559089698; 
 Wed, 27 Mar 2024 10:04:49 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bfc9:1394:a603:c344])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a170903249200b001dc6f7e794dsm9249451plw.16.2024.03.27.10.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 10:04:49 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com,
 u-boot@lists.denx.de, cgmeiner@igalia.com
Subject: [PATCH] mx6cuboxi: Do not print devicetree model
Date: Wed, 27 Mar 2024 14:03:59 -0300
Message-Id: <20240327170359.2167228-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The mx6cuboxi_defconfig target supports several board
variants. All of these variants use the hummingboard devicetree in U-Boot.

Currently, the devicetree model as well as the board variant name
are shown:

U-Boot 2024.04-rc5-00003-g774ec4fda8 (Mar 27 2024 - 16:48:35 +0100)

...
Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
Board: MX6 Cubox-i
...

Printing the devicetree model that is used internally by U-Boot
may confuse users.

Unselect the CONFIG_DISPLAY_BOARDINFO option so that only the
board name is printed instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 configs/mx6cuboxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mx6cuboxi_defconfig b/configs/mx6cuboxi_defconfig
index 27ceb22599a6..e3aba715aa58 100644
--- a/configs/mx6cuboxi_defconfig
+++ b/configs/mx6cuboxi_defconfig
@@ -28,6 +28,7 @@ CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="if hdmidet; then usb start; setenv stdin  serial,usbkbd; setenv stdout serial,vidconsole; setenv stderr serial,vidconsole; else setenv stdin  serial; setenv stdout serial; setenv stderr serial; fi;"
 CONFIG_SYS_PBSIZE=532
+# CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FS_EXT4=y
-- 
2.34.1

