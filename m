Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6392CA1005
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E85AC88CF7;
	Fri, 30 Aug 2024 17:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UZx3FjbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585CE88CD5; Fri, 30 Aug 2024 17:57:46 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE2D788C75
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-70943713472so944952a34.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725033462; x=1725638262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvx+OSd/qEmaYvqkbQ2O8pkMqNCsgUCrsZyTpmqIRyY=;
 b=UZx3FjbA8cnqRRgQTWXsOd7UT+Ad0/QpX3QjeeQv+r7HowioLaWNaiGYVrjg40lvMc
 hPYp5ibr70PhyzoNzY9ABfZypwI0/qr0qIQ2Ttx2Ap0mrd8Dh2U0ydTePuB/H7+UTmOp
 xbBcSuVbkl/9kKPHtQ4HDa2Hf+HavpCDdP6Sa9UIkpQlMd7Uxyg8T/AzCLoyehhbGPSE
 d+YvuRMeYkhcck3knVZlXBDaYLfonw3WA/vFJCDINNebJ/kXUMs6EEM1M14XVy/IRX/s
 oO3rIE5nFiXtelGQPWg5DxuBo0gloxLQntz0jbj0zzD2ZhKQT1BGPdV/15suoJafqMoX
 KxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725033462; x=1725638262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvx+OSd/qEmaYvqkbQ2O8pkMqNCsgUCrsZyTpmqIRyY=;
 b=lrCujwqyzfgSzSqeHV0nn3S4Ja67Fvc0Z3Kwsgl/i+uxzRHiCWjHxjBD0ikI8QEcCR
 61TNx5KFl0g5JQTMJoyTRsOXXBy7lXC0dvxTkijwqbhjHwLqklH9TaYbeZLGJNm7Cdr7
 HUs4/xFM31VG3BHSWyG8d3P4dMCDq1wAqOyVAvzrDZh6tvcDQiyplraQZF19zn9/ULHz
 HFNJViKjf1mucjFMXtJZOTz9lvncxgKuZ+x7/RxceQjkiK9i29iZ8P5tlEpb8LEbDeOF
 16Cjs8SUAzgF6cnM4Gkb8qgChut68laDJUqQ1K9VzhmpJRUEMxVxLbWbzpnT8P+0V7j+
 38PA==
X-Gm-Message-State: AOJu0YyiKj5WhG2VZqJhYY00gNJIjNdLTB+Syl9OlyHgKORFquHocoRn
 ypYu/KvnwhQfSXl4XI0aEo/jhnnAZLToDWmVzqZ+ehlJJEg4H9APvPhdSg==
X-Google-Smtp-Source: AGHT+IGFi2nsiWmlzJ7LiExAj6Jml6zmvKy2lOqU1LCQXr/2IueQPGvnoREKuOEGSOCdOiHDgOxpzw==
X-Received: by 2002:a05:6830:44ab:b0:70a:949c:144e with SMTP id
 46e09a7af769-70f5c42cdeamr6434935a34.32.1725033462479; 
 Fri, 30 Aug 2024 08:57:42 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f671a8630sm490092a34.51.2024.08.30.08.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:57:42 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 6/9] sunxi: Correct TPR6 parameter for H616 DRAM driver
Date: Fri, 30 Aug 2024 10:55:11 -0500
Message-Id: <20240830155514.481410-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830155514.481410-1-macroalpha82@gmail.com>
References: <20240830155514.481410-1-macroalpha82@gmail.com>
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

Correct the default TPR6 parameter based on suggestion from Mikhail
Kalashnikov. [1]

[1] https://lore.kernel.org/u-boot/4c003cab-c8b8-484d-924d-084e71fe666e@gmail.com/

Fixes: 4b02f0120a4b ("sunxi: H616: add LPDDR4 DRAM support")
Suggested-by: Mikhail Kalashnikov <iuncuim@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 078f8c19fa..5b3571025f 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -87,7 +87,7 @@ config DRAM_SUN50I_H616_TPR2
 
 config DRAM_SUN50I_H616_TPR6
 	hex "H616 DRAM TPR6 parameter"
-	default 0x3300c080
+	default 0x33c00080
 	help
 	  TPR6 value from vendor DRAM settings.
 
-- 
2.34.1

