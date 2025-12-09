Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6669CD3B996
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 21:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F2B83BF1;
	Tue,  9 Dec 2025 22:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cKJ4AMG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F2683642; Tue,  9 Dec 2025 22:03:55 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B1983106
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 22:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so47677735e9.3
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 13:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765314233; x=1765919033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=US3peNsrsvmwJeCmwXoULu4Gec2JyD72SVJ71so/3NI=;
 b=cKJ4AMG59JAo1XJyeOprcHTP8rStohgc+mo8KsvBpGtqMr3jECFj2aSvZZ9t34kZZN
 TyADjyQxNwHClNp+ZH2vGCrVuwvH3p8PSf8GgfSLsfXRanS2QO/aQCAHfORr4XDVIJwe
 5xZRP81VB+AJ2TjqC4JV7E6Q9k7aUzrh1u/aEiFdjLLZZrQCG63QNtlCfqZB7QZWdd88
 aSOnE3UwNGIoESaiyzj2gQGT1HAvZBnORhxvS0qWSfovWn7vnnnDe5fpHppXmtmEeCmd
 LiixxuHCFsvaACvwB0y1ksVHfuvHaXk6VGwTXChNWcwl0u7SdK0FhEG+IxDvdVTbcXZ5
 8R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765314233; x=1765919033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=US3peNsrsvmwJeCmwXoULu4Gec2JyD72SVJ71so/3NI=;
 b=fPV8yXXRIJYnJvHv334LoHfa0L5BEAtOvhVwF7aaSpREhANDIoL15aR/zsNOzDy83q
 9QtEjtJZu2lzBXNvbH2c1x3kJ4xgI13kGAVulE81FP6ThHHGJoWCqY3+f4t5GSOpDije
 72+gg0LFSF+B+iipTPuNU9YRESblQxVObt4+Ngp4gucgwLQfvrpdWTAk9xhGkJRLPxtK
 Ffwg604a+kQBKEJbHWnulrzIgDI7hv/SHS5x8pe5comE/imdYyABmwO99e0UdMir2HxD
 mqamKZ3oMtApjYkwTGAcKl6trEnadSe1xWeQQcfiMBrSFTwxQeJ8IsJGbYBlZGAr59aB
 lDaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4kt1oQxBNXZtE+1VcWuMI9WgtjFgoJ50PB67+gQSQ+bQ4Nd611b7sWo4sle9sr1I6x2mLzEQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxCHuB1SjoAnyfp5yVoaovfkVZW7GtcyzUQElcqIRrUXUPSDFMJ
 lW70Y7HVEdjGP39nSUKQR9IZd7zJMTTFwchjI3mDIa88TMeU7ss8HEZF
X-Gm-Gg: ASbGncssq+eSYiwqhqxSIUBXe3XruL5wYEEPkkNZyDMlW50WLpHAIZBRPRqDhEP3+SW
 Wb1uac6t7eBEBn30OVdkPlN/29nuYHAnFWeARmeNLhu3REhl9L272mKZqJ6MPA0NtMoD/BF5SaG
 g7WBje8vIA/k8/I5dyO0ee3YDiiAWXujKg5jFPLRQ1v8FYU2iOnlOhZXTJAV4JPboJ+3miOge1K
 0Grpgl1R0wBiidtJo9cDqFqHV4bEp7/yhQQJNjxrFZEMPlTYDzjXJsAUz84T8zDp83HAPhQ7P60
 AB2RIqcveo7W1Uj25A78Ff9cehN7bGoyzDIFMydrm+lMhn5lWKRRL2Sj249l9umczOGhDF+MRhz
 6c7xhCe3j+P6Bxos+Rg0iKntXXQA6ryAzMxb3FjwbtmjFB+yxN8hesOrpxwb30c4vzesuDFS8/d
 KsZ1CsltnOfFtVpQagy6JcxEi8NW0cDxqZWRhV8KQIsfU28QRbjzJ5sHrH86+WR7jgKzhsQLS+A
 0CiwarJz5YmT4IC7xqWZ/HvRFf0Z4ZqUaF1nWH6qd0UTlAsy3QzMkFF+tEKxwNkoPE494PqP1BO
 rA9WdIQ2cH22xU9SVUMbXW00Hetb2ORZCp6Ktfn3b5hvhNvigzsgPPsRGIgSdO/7FyxfFFhtnkr
 5xfzDe4PX4A==
X-Google-Smtp-Source: AGHT+IG+F6krYwp8FjS6ebbBQ958pEuYuQENNjDsHIrhCYyF3gVSqYQawTEU8t7cV+TgLA03rLKOkw==
X-Received: by 2002:a05:600c:3513:b0:479:3a89:121e with SMTP id
 5b1f17b1804b1-47a8381e5a5mr1561065e9.37.1765314232789; 
 Tue, 09 Dec 2025 13:03:52 -0800 (PST)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47a82d34aadsm9163505e9.8.2025.12.09.13.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 13:03:51 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Dusty Mabe <dusty@dustymabe.com>
Subject: [PATCH] rockchip: rk3568-nanopi-r5: Drop duplicated/extra sdhci
Date: Tue,  9 Dec 2025 21:03:40 +0000
Message-ID: <20251209210347.492763-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.52.0
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

The pinctrl settings are now upstream, with the upstream
voltage supplies, and the HS200 mode is confirmed to work
fine but the HS400 mode had reported issues so let's just
consume what the upstream DT has now as it's all known good.

Reported-by: Dusty Mabe <dusty@dustymabe.com>
Tested-by: Dusty Mabe <dusty@dustymabe.com>
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
index 64c43374c04..7e24be1a5e7 100644
--- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
@@ -12,14 +12,6 @@
 	/delete-property/ vpcie3v3-supply;
 };
 
-&sdhci {
-	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
-};
-
 &vcc5v0_usb_host {
 	/delete-property/ regulator-always-on;
 	/delete-property/ regulator-boot-on;
-- 
2.52.0

