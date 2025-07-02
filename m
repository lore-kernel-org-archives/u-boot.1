Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA29AC83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE6082ADA;
	Wed,  2 Jul 2025 03:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="daP2Nuvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A96D582F03; Wed,  2 Jul 2025 03:05:17 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6670C82103
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2eacb421554so1146253fac.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418313; x=1752023113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9sP9Ib06RhRAG1g2FFj21RRlncLu4of1Segn1FoMP2Y=;
 b=daP2Nuvcm6aDMK+bpl74/UtXf3QXJtlJafHKPmKq868OhWEGfK6k30dd31R4tFMFic
 VoAlAkH3UQHgd32LWR1JTeGY727P0E3QUWOYyH01Kfwur1xXWe67GR4OpiGf/SVgVfzb
 +nKKxlaLW6+P7mWpnp779FZFPKUQvH6Uu+FK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418313; x=1752023113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9sP9Ib06RhRAG1g2FFj21RRlncLu4of1Segn1FoMP2Y=;
 b=wxTSB6zh9+vNxyuk60N4apcBOHL2kQBE4zetrCpIW+hZ9dZKAx0j0HZYLcMthi8zKE
 mE1zQQ140cMvRX/YTz0cFXNevIzQMp/UPJIqyA84Bgaq7nO/G8CgMfPjgJCP4/s6l/Op
 FfxWF2o8gEjVeXmp2xUaExJiC9VFjp1vr9ul0LGLO/w3XiSolemK7aFwrfBwKP4BEon2
 B7r/wu7RmKzIt+s7s3tfoQT5aW5izsL3IQapmjH6BxNqzcBlXNu98JfuWcnh5qUlDwk/
 Mosxjdi623U1rTbNg1wED2Z+s36IhKuPcKoE74TKpP6QKlJYOxZMxWWf9t0p20hZjQcW
 kq6g==
X-Gm-Message-State: AOJu0YwUN73lwdEvBhpJvzO67btGiHmdR3EZTTVg5lnVNVh7zsiw2o5Z
 i/XaW0p+shorumtT8Bgl6siQV+vfOtHzuwcOzk0aeyIC0rRjqqgtodvSRQjbrykCIJSTIjZ+xZo
 Qzb6QNpM=
X-Gm-Gg: ASbGncvoa2L6bbT11AEHPAPyhQCCvXNumEPUbVaXaJ/RSXskk6djWJLGhuvl7uXWIsK
 65Wkn8OR8XjbK4M0bPx0qd4B78wU29wghyvoy1HXMl3BVDuiz9BQL6D4YeCOm2HKsn/UF52TNvH
 SFZpEfi0Eg9wrREr8Si1FzRD1BtLtk/pP90WKyp0lYAZGpMHY99BKze4x6X7yug4hqpzoy1g67t
 TJgowPJEYdRJYlrfrr6ckpQ+o4Uzb6fYkXbRtfQMhGkbTCzbmjz/W+kN3SUD8EpDr9on15AVBR9
 638AGiEpkUjo2oDaAEXTXIYst71A4F80iRAt5aFsMZwffLeXbNGNd1yDRPmomHtoFB3hfg776dy
 u+qmM69J6827gWNvtMRZS0j7GOf11lwhx0w==
X-Google-Smtp-Source: AGHT+IEccvSExtwPcpOGqELzlwl5/6AF0unM5Ualbrp+BAf3Jvj5c3DeZlNE8MJ7s8T1JOYnPX6aJQ==
X-Received: by 2002:a05:6870:a1a8:b0:2d4:ce45:6993 with SMTP id
 586e51a60fabf-2f5c7d80446mr796824fac.30.1751418313047; 
 Tue, 01 Jul 2025 18:05:13 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eb261fsm3613967fac.8.2025.07.01.18.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:05:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: [PATCH] cmd/Kconfig: Tighten dependencies on CMD_BLOB
Date: Tue,  1 Jul 2025 19:05:11 -0600
Message-ID: <20250702010511.19141-1-trini@konsulko.com>
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

In order for this command to build we need to compile
drivers/crypto/fsl/fsl_blob.c and this in turn includes
drivers/crypto/fsl/jr.h which references "ccsr_sec_t" which is only a
defined type for SYS_FSL_SEC_COMPAT >= 4. Express that requirement in
Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 19f47c893439..89f102855b0f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2621,6 +2621,7 @@ config CMD_AES
 config CMD_BLOB
 	bool "Enable the 'blob' command"
 	depends on !MX6ULL && !MX6SLL && !MX6SL
+	depends on SYS_FSL_SEC_COMPAT >= 4
 	select IMX_HAB if ARCH_MX6 || ARCH_MX7 || ARCH_MX7ULP || ARCH_IMX8M
 	help
 	  This is used with the Freescale secure boot mechanism.
-- 
2.43.0

