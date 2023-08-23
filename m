Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B9CC3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2B1864CD;
	Wed, 23 Aug 2023 19:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ny2hZ8d5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 216138645E; Wed, 23 Aug 2023 19:26:54 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17FFF8645E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1bb3df62b34so830112fac.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692811610; x=1693416410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQuXx4cgpRzzjjKegwIZ9IOsX8EU/cZOmezFjdV+tH0=;
 b=ny2hZ8d5Diu4WeNr1Tus657yqVkrlXy7KFV7SZkWPZVxaic5g4RoAfBBJU0F/YpPgz
 cbXSla5vXM4uzF/vJmydWoP2JM6FWJz8G5aP8ISvWr9eeuIWmId3ZPWM+J4KsZN5HQgP
 mH6tHhHXkSQhZw0s7LHE05LkXrAF8EaayyeatHHKro7/2KP98Hdm7vRPNYemY6xlAJrV
 +2y9v0r+zfCtk+pEZiZK+58gmGoZGpIMGXD3UTArTdVR2PtbsyaaI0zeVf5VAhNV1vlo
 koGz6NO+34boFu0GH91cPI1V4SL18558QhulUM4CYef0ckbf2TtWK387qsgzo2lMUw7W
 SH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692811610; x=1693416410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQuXx4cgpRzzjjKegwIZ9IOsX8EU/cZOmezFjdV+tH0=;
 b=IUFGculX2CNhVBQAfi5btnBGKq9g/cM2Y0QzfyPKUB9AeDEOC89YZjpCsC/gpYXPrF
 /LLyOJpPXDQb3ew0lFLSd1sDOdJcMQt4pKxCNAy2K51Si92DpW3RflAERmdRNpY2oDOa
 fRFx/fib2ZarIxC1BuGvA8kL5TeRImM63eTToXPps2tyfu3oehLi3ZNrYvmk4FIq+rYi
 l43ZKKYgY00zlrCK7wcbG7wTYKYChabiMItCBFRzRkFY+rVwaxZagZ7fG572C1ZqmVLQ
 XuuZNDpdXar6XXxAnkiTY/0jdPqoqTpdl/9ME+Ilit6yFrqGAEsuKyo1NycNXf0lHwTs
 yrRw==
X-Gm-Message-State: AOJu0Yw9hpnoLOYoSHrAc6aPRglBJ88taXWgdbw86U+ZlCKyafN9PhF/
 LM2SZxu9QYs/mqhWPsb+Yjg=
X-Google-Smtp-Source: AGHT+IGhhgKeC1BweZvMhK79lyL/T1JgNf5GuwDsO3efKrwfcLA+H1jWoJijOksWfWQ/dfU/p9XmOQ==
X-Received: by 2002:a05:6870:ecab:b0:1c8:bbd0:2fd5 with SMTP id
 eo43-20020a056870ecab00b001c8bbd02fd5mr16114554oab.4.1692811610626; 
 Wed, 23 Aug 2023 10:26:50 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ae60:b44a:59b3:894f])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a056870734700b001c0e840ebcfsm7158926oal.35.2023.08.23.10.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:26:50 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/5] thermal: imx_tmu: Select LOG
Date: Wed, 23 Aug 2023 14:26:35 -0300
Message-Id: <20230823172637.303101-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823172637.303101-1-festevam@gmail.com>
References: <20230823172637.303101-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Without LOG being selected, the dev_info() information
from the imx_tmu driver cannot be printed.

Select the LOG option, so that no dev_info() messages are lost.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 681b621760..0a1d11e216 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -29,6 +29,7 @@ config IMX_SCU_THERMAL
 config IMX_TMU
         bool "Thermal Management Unit driver for NXP i.MX8M and iMX93"
         depends on ARCH_IMX8M || IMX93
+        select LOG
         help
           Support for Temperature sensors on NXP i.MX8M and iMX93.
           It supports one critical trip point and one passive trip point.
-- 
2.34.1

