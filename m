Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6484DCDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB4788DFD;
	Thu, 26 Sep 2024 22:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QW14YWLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F14CD88E03; Thu, 26 Sep 2024 22:48:57 +0200 (CEST)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A77688E0D
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-84ea36b65cfso328376241.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383733; x=1727988533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vk+OMDNlr3r9Q+CRSJ2cU+IaVGewo/ifyvQ0fMYF/Kk=;
 b=QW14YWLvNtdphYwTNZCB+EaGXSxodtxILN7y7FAMNXTnvtFkJJy6CN8qez3JJmK8ZH
 GWXAi0ekH/MJcJ/p0Dqc99qxo2+Hy1WvFrwLRVfKGYZGpLvsEbcvbj0v3CBCDzG04UgN
 3A/wZGkwa3dM8t+B+DwVP+mRLoe98vtrA+Z2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383733; x=1727988533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vk+OMDNlr3r9Q+CRSJ2cU+IaVGewo/ifyvQ0fMYF/Kk=;
 b=OUu/jpX0llqDFQenT56wqk54dNXoy6GTMSkRFD/+vBY2Q7B/sgGAUREoVYsUYUuZ4B
 R1K6KubUhhw4nQJHq1ac2u2rLx4hwoKWm1WKc/BcWgHM03a1gAqeAhAoLlA0NqwObduq
 Ad0fIBuaiC+Xnj/9xtH/zWjsIhT1mxslvVeykVR4Ft3Vd3RR7qbgh0Evx7cAODuFtDWV
 B/IJ1VDF14LJ+4hPKBdgoLT/t3PBIWVP+3LzDBgP83k/cBxWZuhVg7BXbNq76TgrCBlM
 Dcc861fLGRAxvZPLHHFmLb3D6guTQP0vCR9NGpMgmMxjtJ4CPvyS5SZLZ8lkmbr4rB2y
 nHFg==
X-Gm-Message-State: AOJu0YxM6aEfYjM8IGPoc+MZ+Bz1sNNj7PhRI+IdpWS0iBsXwACXn+js
 fj15/K6VHL1l0KrP1SY4JpplC8ncV7UeTFZSm0GKkwVmkfc48rOWh3/BbA31P5gFiYo8kU8Z5pR
 7G4Bokak=
X-Google-Smtp-Source: AGHT+IEbKA5skK9E4iE9jNnA2CiLzDxh1dSKEvnaRXi7QkuvnBZtf13r7a55LXHzv7Fy18jQBAxNWA==
X-Received: by 2002:a05:6102:511f:b0:48f:4eeb:566d with SMTP id
 ada2fe7eead31-4a2d7f2d916mr1106148137.12.1727383732964; 
 Thu, 26 Sep 2024 13:48:52 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:48:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH 07/27] mx23_olinuxino: Drop STATUS_LED
Date: Thu, 26 Sep 2024 22:44:27 +0200
Message-ID: <20240926204455.963584-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

This feature is very old and does not use the LED framework. Drop it
from this board.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/mx23_olinuxino_defconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/configs/mx23_olinuxino_defconfig b/configs/mx23_olinuxino_defconfig
index 335de62e84b..febf7f544b3 100644
--- a/configs/mx23_olinuxino_defconfig
+++ b/configs/mx23_olinuxino_defconfig
@@ -39,14 +39,6 @@ CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
 CONFIG_MXS_GPIO=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=778
-CONFIG_LED_STATUS_STATE=2
-CONFIG_LED_STATUS_BOOT_ENABLE=y
-CONFIG_LED_STATUS_BOOT=0
-CONFIG_LED_STATUS_CMD=y
 CONFIG_MMC_MXS=y
 CONFIG_CONS_INDEX=0
 CONFIG_DM_SERIAL=y
-- 
2.43.0

