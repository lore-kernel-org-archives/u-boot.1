Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25142C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 19:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99DE88428;
	Thu,  2 May 2024 21:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V2yTP0UN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB4BA88387; Thu,  2 May 2024 21:34:19 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A117D8837B
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 21:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c61486d3fcso4951780b6e.2
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714678455; x=1715283255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boOqKasgg1zSgue9gL7UHIYJXcFeUmlluUHrTziWIiQ=;
 b=V2yTP0UNU9z4cur3CQsZbiVS9J/2J1AyRCSi55/+Nl4FdavW9hVJYzq+8tniAQxewN
 s1sIlxu/getVsNC+UiaAadR/EFQhKfrqXbGRiDMEvr9CeY2ogkNxVE/H2EEcDiYXVgbW
 /jjGatsDeUsotBeWOrwf0rMWee6MegcpbLIAshv1hIz2xnR9a38cj9m8q6p7DxMPvlCd
 PvGLdqdXbjhumCkGGoqLA4zS+bmYS+i/x6GBnZtyxyjPIISsqvhb05pm+53gois7LWgm
 tJ1LDJiKbgVFK1kMKHkioD4sDqpSSS771aPjaw1+zp75HY6FfLCiE70wLbPg+tFZxdbL
 0kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714678455; x=1715283255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=boOqKasgg1zSgue9gL7UHIYJXcFeUmlluUHrTziWIiQ=;
 b=rQM+nMIL4yfZgGx7omW2uOXEEY3wJmYSRHDdhJsVa9XYd9xjFUbVw4jkhYknelmYI3
 VBWAVlZgN+EkAwARTvNdApYfrWTFQxTdWoNQ2sMLOZdw1C0efERbJJcfeos/HeLJSdJ2
 MyyevdtgoUt2Lda7OcftF7LUBFVFmiDL6/PxxLKhrRJDvj8VWnUSjG1SoUB6qY33qepM
 cZ+PdjXmgkXBW083oHP0yvIVgos2XDA5SLXFjzbemljh1m2k9XxejaGzHeK0smaQM2QT
 BnNz/3woB6SPhcFiUuJ0V1Apj20eejW745D4flj8eHLNGh2Z1WKr1QF6RbgJ4CZKFtFH
 k5vA==
X-Gm-Message-State: AOJu0Ywh/bMuR0TiA1IQ5zx1c7bP81ELw3i2Br4khNKNhdUnJEtGIjwF
 jicJj839LqqvDonZTGZXOyD95VUfiDa01OeJ1JXqMqiu9dhOFR4m/8hKqQ==
X-Google-Smtp-Source: AGHT+IG0UGdB3c+6ywp1F16P6vPOOnJa9ph+hciIf/sL182q+TV4+xOJlc8kl2tZ9NlYCi1JnrhZ/g==
X-Received: by 2002:a05:6808:4406:b0:3c7:533f:cebe with SMTP id
 eo6-20020a056808440600b003c7533fcebemr865702oib.26.1714678455328; 
 Thu, 02 May 2024 12:34:15 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 ck9-20020a056808250900b003c4f39fb9e7sm252340oib.36.2024.05.02.12.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 12:34:14 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: dsimic@manjaro.org, jonas@kwiboo.se, trini@konsulko.com,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/2] board: rockchip: rgxx3: Use sdmmc0 as first device
Date: Thu,  2 May 2024 14:34:10 -0500
Message-Id: <20240502193410.1080938-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502193410.1080938-1-macroalpha82@gmail.com>
References: <20240502193410.1080938-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Some of the rgxx3 devices do not have a way to recover from a poor
flash of a bootloader to eMMC. Set the device to always attempt to boot
from sdmmc0 first which ensures that we can override the boot from
emmc if we have a card present with a valid U-Boot stage.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
index 793ed4ae8a..18f540a3a2 100644
--- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
@@ -4,7 +4,7 @@
 
 / {
 	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc1, &sdmmc0;
+		u-boot,spl-boot-order = &sdmmc0, &sdmmc1, &sdhci;
 	};
 };
 
-- 
2.34.1

