Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F618CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F7D8359F;
	Fri, 26 Sep 2025 17:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iw+3PD57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CB6835B3; Fri, 26 Sep 2025 17:30:39 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA418319C
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-88cdb27571eso106907239f.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900636; x=1759505436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ej78/K67eK1fqUqVRiOX9Vxq57zUFI3+CNGVde90aek=;
 b=Iw+3PD57Dl5VBOmcYIlwnLOC0H3S1Y7POQ9QmvycKJD+GzbnVKAiJaZiKF+mhOCg1B
 qghGD9uROj7Tm4yPqn+VUKwdA2RQ4J45P/bFrM5tnrC3vBhl6BvwA64IX7feFWEQFtOy
 ZbtQQTIA1E+ET+aGxTVEPathY64E4XZpCMjK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900636; x=1759505436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ej78/K67eK1fqUqVRiOX9Vxq57zUFI3+CNGVde90aek=;
 b=EkwQx+hIaLW/euggp7vXUB1SxfJpBp7jf/jElGq7956hMyrPYPR6kUEvcFh1bEQbGd
 ejEgI4rwfACA6SBjUywQzIq94wIOwNEjdVycJYqdeMfaCKeD9mnL/MeIMG051Nv+dx6z
 oVtJ3RjASjEXhCawSwL3y2kP4uwcdmjS5bD7evHsJ1hlbEdJp7C4fV+YhkCRJInMU0nA
 2zZ25lbZmP9YcF5EvLRMxuEG5SsZO+KhOMT5nFyR2Ako0UQak3omd4/NDHDmlUN6DIbJ
 kKIav1qLxN025Giz9hPg5cACACb99oW6U1AxcYDaABp91RJsM+M/M+HbbzdtHN5nHbiP
 aSfA==
X-Gm-Message-State: AOJu0Yxqww57WT9mWGhGWFSoJ6Y142Rd/NT0Y/LKQWEfGnxfbXbnrWip
 coKKdQGtvECDp7JTYv+f5GrQtly4ZoDGsmdWP4A2+yqUrHemuTKjVolOSL9n+JBAOwBr2kE6Rn+
 YuT2rqx4=
X-Gm-Gg: ASbGncuUqr2g80yhuRm2ghv+Ezglbyju8dVqBUgafobvUQP9+OdVDFoLzN5FHR3eALu
 x+TSYjuJG0aURc0WyXSDD+7qkBA1re1Ae/sREkIW52IYLSgr27bwhd5w/1IOMjk4K3wBbtXiuu4
 LMFw4wKIOs9Yky4LFpj8n0F5v973iI6w3u3JH6DSgIMj0O7uN7w2wEEm1IhPCGbP/A5qePSnTqw
 ASr4eJ+t6vYutIcDeX/cdgwrkxSHM9gH+lsf7/w8kz8tYabt+lirTQR4q675GvK1/u9/nf916HN
 bgF1+yuOWcP5ZMkHDo2tzqlnXgVw5gxltgQKNrjYOmUpli85r+tvlvKCZz1c3GOrTVKVbyQjWQo
 ci9VZetjn8gTxytBWQUF2HXwLzKuCL0Ui1MipqLdNpMTDDR9GV18conoS2oAoAjo3lp4W/y0P7m
 DdXZB/
X-Google-Smtp-Source: AGHT+IEFSR2aO0cMaUu9cVf8VQUPvuDSff3MBlvo3gmkNumfImElX6eq6Eds4+17QpvXI37AxNClKA==
X-Received: by 2002:a05:6e02:8a:b0:425:7974:fe21 with SMTP id
 e9e14a558f8ab-4259563dd93mr103049035ab.22.1758900636138; 
 Fri, 26 Sep 2025 08:30:36 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bff81253sm23263865ab.34.2025.09.26.08.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:30:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 1/5] omap3: evm: Drop old musb omap3 driver
Date: Fri, 26 Sep 2025 09:30:30 -0600
Message-ID: <20250926153034.3680674-1-trini@konsulko.com>
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

From: Peter Robinson <pbrobinson@gmail.com>

The USB_OMAP3 driver was (re)added in commit e74e9f620a6 as part
of migrating to DM_USB but the config already had MUSB_OMAP2PLUS
which is the newer musb driver and what other omap3 devices use.
So drop it so we can drop the old driver.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
Changes in v2:
- None
---
 configs/omap3_evm_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index a813d216787c..f99798ac1a57 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -78,7 +78,6 @@ CONFIG_OMAP3_SPI=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_OMAP3=y
 CONFIG_USB_MUSB_GADGET=y
 CONFIG_USB_MUSB_OMAP2PLUS=y
 CONFIG_USB_HOST_ETHER=y
-- 
2.43.0

