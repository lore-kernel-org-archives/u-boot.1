Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDFDCA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 17:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F3D80B9B;
	Thu, 21 Aug 2025 19:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F1HyEe4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E6282F03; Thu, 21 Aug 2025 19:16:40 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A439D82998
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 19:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-30cce52ba30so923626fac.0
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755796597; x=1756401397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9U47UmHHhtRIb5CdjfT1VXe6ihI+Y2G2K1pMN2X4nA=;
 b=F1HyEe4SbJP+dJHSk5Qwd2aiFf7RrjnOiQJCMeNyD0eL3ftX5kDzDK5q4C3Q0gPOAM
 wgKV6NMyXeSidnkHQd0RGjCa/FOjegXN5V/f7zV9R0vFQRBO57qKpMY2lyLzq7xQk+h0
 PsTDkKBb0XNSl8tF04kHwqBeS16xd2ZMXzm6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755796597; x=1756401397;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9U47UmHHhtRIb5CdjfT1VXe6ihI+Y2G2K1pMN2X4nA=;
 b=KovvsYlxa4e+RUlOd9UB3C27BF1UjItPBw0RIGayqU2NYKzHlstxAmb5YAPjDjnIUt
 2eXvMAUGkmuMMIXoTvfIEN3AXsoivDbOFOlC/RTgLtdwooFKmQzR1DJ2aWIEXGK+9jb9
 4mt/R34qp1o3mVXgEH7t69IFAYT0qkYYKNwd05O2Z9jzAKGc70os16M2kaOey2s/v3rJ
 gPjyDJvlSFgR/aO8e19PjCCznR7l310pbCDGO67Euu7dvKmpXJ+UUvwPsc3+bskYlLY/
 3R3N3dt85PKYX+JXJYxqy8Z4wHr+PFy3tlkz13B9u8qKcGPh+Hl+gY8YEk07DUrV7ok6
 WvhQ==
X-Gm-Message-State: AOJu0YyglQgrCVTpolEhNjXUIeLtQiCLNU+SdcZBPknZSCNKepz7whF5
 ZPzBG7TpJz8r/TEF2t+Kxbpyaa7pSwXVFXsiQTGg9Hj7LCWm9N9AyAirgi+nqSm0uWQ=
X-Gm-Gg: ASbGncvtEH3O/6dGlRfv/R29Am2eaA2GJHpd2aDAk/geDFclVNp7OtuYzH7O7sGOdeX
 6ZPaqNlnMzHPN1Ft+acjnnbw7AWIpHh5ibj+jkdcUfEGbCHd1+LErTkJaqOnUsR7GV3bn+2EvDn
 uCEOYnpsPm+c+GKHgh7goTXX+yDspA7vgs66mR9TCb1r9BU5zL98gzvgnd1jnZqRIo+6JqMYkpC
 NyprPpy8C5JsyF3JC7cV1j4o0xiTxtPQEj1pDbD0YJx7ngfsTxrS3uG6/pnbQkKI3z6VsYVcnvG
 kekM/h2PNG1ZA2qVACyDRx8TvNkmHSKuAPK6TuVcNJ74IRF8BWjqdO7yVAq1N61zpHjjRUrzTgd
 gFBEVABxf0uNwp5DLm1bI8TOaaLwHpKA7zzQLT4I1JOOva9f6VVad39U=
X-Google-Smtp-Source: AGHT+IFFGbuUf28PxNZPcM34w/KpJzMTshKVjVSjc1xdJ+Noe2sBo5gpu5X8WPNbDh1VuVrOd5kisQ==
X-Received: by 2002:a05:6870:a7aa:b0:30b:7d73:617d with SMTP id
 586e51a60fabf-314dcd463acmr9994fac.25.1755796597361; 
 Thu, 21 Aug 2025 10:16:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab952d79sm4999909fac.15.2025.08.21.10.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 10:16:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: w.egorov@phytec.de, d.schultz@phytec.de, michal.simek@amd.com, 
 ilias.apalodimas@linaro.org, j-humphreys@ti.com, John Ma <jma@phytec.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20250813213116.3076551-1-jma@phytec.com>
References: <20250813213116.3076551-1-jma@phytec.com>
Subject: Re: [PATCH] board: phytec: common: k3: Making
 setup_mac_from_eeprom optional
Message-Id: <175579659559.3655101.1444358944733605860.b4-ty@konsulko.com>
Date: Thu, 21 Aug 2025 11:16:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 13 Aug 2025 14:31:16 -0700, John Ma wrote:

> Making the setup_mac_from_eeprom optional for boards without
> CONFIG_PHYTEC_SOM_DETECTION_BLOCKS.
> 
> 

Applied to u-boot/next, thanks!

[1/1] board: phytec: common: k3: Making setup_mac_from_eeprom optional
      commit: 29ce50acbb40d64aabf789640a2866a9f71aefa6
-- 
Tom


