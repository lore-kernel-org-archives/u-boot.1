Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D04FB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A882840C1;
	Tue, 17 Mar 2026 02:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JV2cmVJ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F9E83BC8; Tue, 17 Mar 2026 02:24:25 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C2783BC8
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d75371d873so5446627a34.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710660; x=1774315460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3JLgRnVNURgoB/4fnm3Cs7SiJV0YCd2OkncUaG/YT5c=;
 b=JV2cmVJ4fqFHuewK/M2RkwtgPTz6MdLtZ+/E9ygoCy138sa4dbuyXt0z1oB1MriBMO
 CTsSOUSJ0pBwUSXgh06AkY2DGXCI8GyvLGNiefXSFWq7hRuJ7DlDjUvoSUTSJnKHyc1C
 Mhy54AJB9z6fy7gko4LL0fXk6QK3XlEMnBalM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710660; x=1774315460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JLgRnVNURgoB/4fnm3Cs7SiJV0YCd2OkncUaG/YT5c=;
 b=ht0TEY1S9SPH8Co0U28m2xqbKCSKw6UjDuc2IgKXxSm8UdAB4kkwHFpbntIMaiKAcB
 m0ushRcam496AWvBe/JF2mJ6t/YKRhxgMF6nNb7Mv8QbJa4Ydc/IbRChJH0dojXD1ohy
 tjS2uLnXzNLo3Bc4kiITgVfS7AKf0iFt7JbAuUELa8O0+6aEzzADiqvhRL3qa6ZGRSnp
 ceq3CbRQlwlzg2yTrIsrrO3vCRUTMCuJVSfRqDUr5l4orf0MHqngKIduBhYF/3mq89Yc
 zzL2qxgYFUjXfRaRYeo9LQzT2ecE5YK8rVTfCOKTZe6hP10q/KIMkoMR1Lp4fht//0By
 RIgQ==
X-Gm-Message-State: AOJu0Ywt8G66XroP3piyTmsRkEdWxJYf5e9+toHtxuxakaYfOAREqrXR
 o/Piwcq3+p9jP1B22MKBi6v4Y121q9x7gm7ZMp9GmeFiqW3FUd5ygH9hV8IU0SmtBXYMdeGzazS
 /0e/jkn0=
X-Gm-Gg: ATEYQzxf7sbrbt9zdEPhYt64TXG8MpYd0DpxaXFhN1QK7RJL8Q3J6btkO0rWBcyDbat
 7FZpl4S6zVQLkiMxVXab7h/DSuHAe8JJ+VWsNAe4rmf0EFWKdRVvrPMnoiEFPltpN2eOhumx9Dc
 cwHNOlVorP+F27XRxXgVTuU7/FwyuRlhQV58tZ1hAOmmaGCPHZqitQ1/lSi63vXkMNrF8SoZZLK
 t0HMrAxdvStf7pXJLh0g3ERBjR0npzL2++J/sTnSXvbyB/2nLEHjxJmBi3x9rWg5XMa1OyFavqv
 m7MH0PRUxhWrqsD1Mj/+f1/FdeFU6oSgvUgSaE2LnY0WlAfAMERRgE8WQdCKKpC2jng7CkXp3xz
 V8r0QPrev8Cl9GDkG01fIGg1DcL3tONDfEq+cADMWgTWmhvt8CjzaGHUIKUve4ilzsILs/Re4pV
 PZz5yJR707HwAPFxYAd656RGcsIIczjUoNa0pKLsO2traOYeJAF2oFcQ4oy9dmSWhx4gM+Vi41j
 R/5yGdwoZoUF1GXiPfVeBLNk2Lju3XAAjOS6D7vcQCxgQ7DPIE=
X-Received: by 2002:a05:6830:6abb:b0:7d7:5959:946f with SMTP id
 46e09a7af769-7d78242a0b5mr10736992a34.7.1773710659705; 
 Mon, 16 Mar 2026 18:24:19 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d77c961e79sm10315912a34.7.2026.03.16.18.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Subject: [PATCH] usb: isp1760: Correct dependencies for USB_ISP1760
Date: Mon, 16 Mar 2026 19:24:16 -0600
Message-ID: <20260317012416.4162318-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for USB_ISP1760. It depends on DM && OF_CONTROL being set and
functionally requires REGMAP. As part of fixing that issue, we change
"tristate" to "bool" and remove mentions of module support as that's not
a thing in U-Boot.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
---
 drivers/usb/isp1760/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/isp1760/Kconfig b/drivers/usb/isp1760/Kconfig
index 993d71e74cd2..d1c5a687d9e7 100644
--- a/drivers/usb/isp1760/Kconfig
+++ b/drivers/usb/isp1760/Kconfig
@@ -1,11 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
 config USB_ISP1760
-	tristate "NXP ISP 1760/1761/1763 support"
+	bool "NXP ISP 1760/1761/1763 support"
+	depends on DM && OF_CONTROL
 	select DM_USB
+	select REGMAP
 	select USB_HOST
 	help
-	  Say Y or M here if your system as an ISP1760/1761/1763 USB host
+	  Say Y here if your system as an ISP1760/1761/1763 USB host
 	  controller.
 
 	  This USB controller is usually attached to a non-DMA-Master
-- 
2.43.0

