Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3B3C54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 11:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAFA87ECD;
	Mon, 25 Mar 2024 12:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JcBUfdAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665A687EBD; Mon, 25 Mar 2024 12:47:20 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F1A87E8C
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 12:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56be32b9775so3572184a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711367238; x=1711972038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIjA+IHP02KgDl1pzDSRClzJQWzEm1L1Mtnzae8MkkE=;
 b=JcBUfdAlQnVgjnQifGpZJCJbZN3UmjQZsbN7xBVre9Mo9pI9iw44mZuU4H174rERK4
 Qf+Yvf5WnqxTe9BY1BgMKzxA45qlDXA16ehKz0erEt6ynetqspmwrKSmU/v/0NZyRdX7
 jISx9OHXBXjX4JO1Kn5LIymQQoqaLRHLZko0nSFqglfSD1uDrvHYSJPzNy4VDcG2f5kv
 P5SiMh/n4OlrKLYsJJFUCkRP+xua5hvQJ6+BRZfjChMqCOE1Olbbuwp1oLsKtVGDbREm
 S2cf15ptuDlK2535HhbcuK/F3oGtsgzzYYkgdEt5TyKxSkRYZwDODfWYslnoQTc9DMgs
 VfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711367238; x=1711972038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIjA+IHP02KgDl1pzDSRClzJQWzEm1L1Mtnzae8MkkE=;
 b=a3Nl37dRiC8ZhY5CLE1TZGUg4cAlvo8zHkJmEc3yhEwNp8n84L0EoehZ8iapR/cs1I
 TzTYpuwnbPtg0i3E/X34ceQuEr4+N+sGrfa/n4K19BZSsn/DOuBr+2vA7iMP+Q0rYohS
 EdGfLkjbCQGFuH4oxFnzOanExBwpUZrNlD5ha8WChQqd8a3Sh7uPwBvatGLkeu0MTJ2e
 r6FV/yFIblIfAgCPHTP1ChYLzVqmjCkbyDqT9FDpEAjX/PtQm3LbfRl47fIYoJrbIDfr
 VOeyBtlcNckNkyv9Jwff0iNqz6J81CPt1sR89pAJFyMug97gLcgQyt5UiGpckOJmSS7O
 6FEA==
X-Gm-Message-State: AOJu0YyOvTnieBKpVZWObuUbyQMfZFW+A/iAGVHnvk8WPldv2QrtE+Ty
 pu9ke0BI+/1SXAEFcUbC0e8qn2ZsDoLaOD3yxbBjd/QH6YlWqhfH53T/mMZJeZ0=
X-Google-Smtp-Source: AGHT+IEAwIZKPiu/VJKei0QP/6OdWTFh3uEXqbS1qBzWBO5VdYJd3hU8Q3MPJgEZnAuFvq52qoXXgw==
X-Received: by 2002:a17:906:db08:b0:a47:52ed:8961 with SMTP id
 xj8-20020a170906db0800b00a4752ed8961mr2921807ejb.7.1711367237715; 
 Mon, 25 Mar 2024 04:47:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:da6e:975d:104b:c525])
 by smtp.gmail.com with ESMTPSA id
 jy10-20020a170907762a00b00a461e10094asm2988864ejc.95.2024.03.25.04.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 04:47:17 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Breno Matheus Lima <breno.lima@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH v1 2/3] configs: colibri-imx7: set non-secure boot mode as
 default
Date: Mon, 25 Mar 2024 12:46:41 +0100
Message-Id: <20240325114642.3664840-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325114642.3664840-1-ghidoliemanuele@gmail.com>
References: <20240325114642.3664840-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Linux kernel is supposed to run in non-secure world,
fix the defconfig accordingly.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/colibri_imx7_emmc_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index 9d4423cd0d6a..8dd9fe6e6a38 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="imx7d-colibri-emmc-eval-v3"
 CONFIG_TARGET_COLIBRI_IMX7=y
 CONFIG_TARGET_COLIBRI_IMX7_EMMC=y
 CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 CONFIG_IMX_RDC=y
 CONFIG_IMX_BOOTAUX=y
 CONFIG_IMX_HAB=y
-- 
2.34.1

