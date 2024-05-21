Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497DFC25B78
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 15:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8388C8873C;
	Tue, 21 May 2024 17:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WdEOPnnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 449EE88349; Tue, 21 May 2024 17:46:03 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D25AD8833A
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 17:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5b3241a69f4so1807313eaf.2
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716306359; x=1716911159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQNUba+/vf3NjavS6d7thsKKJQjWqMYO1nlfDoQzQsI=;
 b=WdEOPnnNQ7pI12ckJeTngpjS3yp3UFyJRGBO4wV2pmj/7/aNZoYuS/AdCiaGi8xds6
 9SwU89ziaZcg5GWuumE14jI/k+DHZgMyDzDl/DW+uyN3Fk4gE2lq9VmEaqTSD1si5wwz
 5g1KIenpqoxse4TvDIlasUSh3xawxiKJf/nXTgiOMgaZvNGDfw55i8cweg6wCcb0QhhA
 5fKkqH2MsXKujh/IS2Aw7HCt1QK4qPF6bDhUX1XtFnrcSGHmSLCMMGykN7aqwdpRxVof
 8wNllB5orqN1FMGVRvb6p1ANPfxAat5D826sDf1AVW2laNo9phbAB/GVV1ZDBLcxIT6F
 dqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716306359; x=1716911159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQNUba+/vf3NjavS6d7thsKKJQjWqMYO1nlfDoQzQsI=;
 b=PxKSL6XMZ1mjRKeKBUkKTflH5XR8tEsDI0Gbm72SYxVZ/y7pxCn7XiNo+R4xrpK85v
 XP8jxnOJjrdHzgb9DtoLx5Ah8i6alRvI21SVDCHA4u0dv+6PITngp6daRYJjMKpPEG9/
 OVEkAk3VY6rH7ekUYzPY6Zcbqu3yCj+il2A2YbX2GWtlUaXPyuweixzNLJzGBRDWiXZA
 9fI0H5TEluPwnxZO8O8mpF8syRwLeD99jgbqj5kgweRgCunezrcieOp6aACxSP5IagA5
 P6G+2galsrMhLpPASc49KoHvt92S908AXNckIUYiILh78BS1IypRoBYAAymp8QxyZGBa
 JsTA==
X-Gm-Message-State: AOJu0YwWy0LFjxvSsR/My2Gj1CLb5FIhd4XN/ojmkPe8EnSSRiAmFHXS
 8rNh/1dpsbuT7D1kd+SA+CKI07ZsVu+aDVr4kAU/5WdV4USPfld1NrGonw==
X-Google-Smtp-Source: AGHT+IE/ArpLfIgCGqgNPTmXmG1QATNSheOPnpXAG8iZcPnds1wUik8JihiC0WaTpShNBbGsmzmVhg==
X-Received: by 2002:a4a:8c6c:0:b0:5af:a5d8:c445 with SMTP id
 006d021491bc7-5b2815c582cmr34737581eaf.0.1716306359415; 
 Tue, 21 May 2024 08:45:59 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b5390b9c54sm676960eaf.0.2024.05.21.08.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 08:45:59 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/2 V2] board: rockchip: rgxx3: Use sdmmc0 as first device
Date: Tue, 21 May 2024 10:45:49 -0500
Message-Id: <20240521154549.255607-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521154549.255607-1-macroalpha82@gmail.com>
References: <20240521154549.255607-1-macroalpha82@gmail.com>
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
emmc if we have a card present with a valid fit signature. The
expectation is that this will protect from the very unlikely chance
we have a valid FIT signature on the eMMC but the U-Boot stage fails
for some other reason.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
index 793ed4ae8a..c7e849816a 100644
--- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
@@ -4,7 +4,7 @@
 
 / {
 	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc1, &sdmmc0;
+		u-boot,spl-boot-order = &sdmmc0, &sdhci;
 	};
 };
 
-- 
2.34.1

