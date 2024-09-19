Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B93CF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624B78911D;
	Thu, 19 Sep 2024 16:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kjDzg01r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F15AF89139; Thu, 19 Sep 2024 16:02:50 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE42B8919E
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5e1b50fea4bso484538eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726754567; x=1727359367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=secJcZcZRQ8rCxns6fwHyP6YkZHK+K0xA3ArxJENVKo=;
 b=kjDzg01rsZ1dpRHxLJfGgfCVpo6M9ExmzorF4Q+0hkD4PMK0dOIrOqUIYB/+qlQCsu
 5P3vGj108l/DwhCVaJx28BxHTZvf0WewsXJxeBkENNpyRW6tUoFUPhMKQpP4WwnKhCum
 7fo1UIT+paWcpNXMz15BOCNRNAxAVZ0ve3iJptZTLX+08svd3ituJiO2K1kK5XE2Qu5z
 JKjL7lcNp4aKAJhDv2bIQOyxU2mmAJ7ZrNQMiuzFRWIvR7YQUqaCWsBbPce4cih66DIa
 TFOd6mceXaaWww4oWvdsxcbuoW/DIJPhsOm6wfaLfjEg2u6jIfACWsCetb1k/ND1mFlp
 SAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726754567; x=1727359367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=secJcZcZRQ8rCxns6fwHyP6YkZHK+K0xA3ArxJENVKo=;
 b=gTQaJGHy1pzanKPH6Jtu4Q4jwjGn4y6WTbLjR7QZ0VR58GSXBNvbUOlFcTPK67AUmQ
 7/g6+wDLc/Aix1LN9QCLkthUUdhtstpxFLNpY9yOLeKlZ2sMELj12Lie6ayY8xL7lzkI
 U+sD+H8Yh2IpAkywFERZyQ1eVhrlE7EbqDc9Vtf9OjG6VjtE3Z4AilBHdgfAAoDlSif2
 nN4PXiejJVHfgcgkyVYu0Hl9b21SAShkkxl3X1IWzB3WAs84wuZAzuep94SvKzJb3trq
 w3KxqEfl4yqiiPAxciQ3voZEXlAFED7LWuvYx97Z/ujqUCDP+BRmfFqGCCm2r1CH5VsU
 cJOQ==
X-Gm-Message-State: AOJu0Yza+o7DH+6o2+0Whx2OAPdrZZCZBstG6Ho/bzOkbjqpOiO300aK
 dTh+Hp0hZYhVo7isrSw7FTBrWDejBS9xromyhmLPJnUnqbir4gQ/4nCc1OB/
X-Google-Smtp-Source: AGHT+IFmXHKJTg7R5FqB88QsHRXBlB7hQjT4kV/LZU6gpyZ+ppo7xHpvtFpbN0bp1J+x8M3FnYSmlw==
X-Received: by 2002:a05:6820:1ca7:b0:5e1:ce95:9e1f with SMTP id
 006d021491bc7-5e2012b6a90mr11839311eaf.2.1726754567186; 
 Thu, 19 Sep 2024 07:02:47 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5e3b0d6ae98sm1941649eaf.5.2024.09.19.07.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 07:02:46 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org,
 quentin.schulz@cherry.de, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 3/4] board: rockchip: Remove ARM SCMI Support from RGxx3
Date: Thu, 19 Sep 2024 09:00:21 -0500
Message-Id: <20240919140022.511067-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919140022.511067-1-macroalpha82@gmail.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
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

Remove config options for ARM SCMI. It is not required to boot the
board and when using the most recent mainline A-TF it actually causes
the device to freeze during boot due to missing SCMI support.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 configs/anbernic-rgxx3-rk3566_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index f5e5470df8c..49d3766613e 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -49,8 +49,6 @@ CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_ADC=y
 CONFIG_SPL_CLK=y
-CONFIG_ARM_SMCCC_FEATURES=y
-CONFIG_SCMI_FIRMWARE=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-- 
2.34.1

