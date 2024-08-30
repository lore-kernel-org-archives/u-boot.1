Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F94CA1005
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD5688CDF;
	Fri, 30 Aug 2024 17:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D1PnbJ1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E54288C51; Fri, 30 Aug 2024 17:57:43 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4662D887F3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70941cb73e9so858875a34.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725033460; x=1725638260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjGMN8JPijabux8Su8R9vbPFntOPbtfER54XsBLarT4=;
 b=D1PnbJ1qmrjM3D9mVtH8FgEDbcFskmTsYmezigJ8ON4AA01UfJKXGVwlH+gqXQkq/z
 6KOFkKkxesxDdaUEap5rbOkmDKq4uwwhF4giQUhQ/0x+2BvpeN8H+VHdUYZ01h5n43b9
 i7OkwV+4s+Joi6WMrbtSLCLxYOZnWUV7wfezC2NrkunIQ1JNy5eXZ92rc9moROgildr2
 TkyIXT8qPmrHnWSya1Vuzs5d4hryiceRoTDcjPDUND9okpOWhCpywh5e61zT93HIAIlc
 mHxEiF2AlXwfZ2clw9ZGa2nAEhoDClGxjTFdv5FXlt6BgmOIAMBVdO9GA5kISiGsSRuz
 Jy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725033460; x=1725638260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JjGMN8JPijabux8Su8R9vbPFntOPbtfER54XsBLarT4=;
 b=P/zsILYi9Nwm762aXwOOxLwgHUd1XpIlNlrOTl5B9gm4z6LzZlTr6Ikr+ZNNFX6xjR
 p3daxe1VVn0rmytzuCZyIALMkc7SJgO4WZECB+n+ZAzOBodDU5sNQhT34beJbHQABQ4W
 V4OxD9XeNfALwj9uqc8Het80HbHWPvffV2a9yFp1xxDACnJeSJ4qv2MlOU2wCBggtQp3
 bvMwdRU1A6atoNL5WLN6CLehfjFQ58PW8pWJChQ6/wSDTWy9GrWScX0xQS5zWCGzGcK6
 fdC+T1UhBpA/jLnWEga8n7WjO9E7bKDWm/thwCaFm+i7rKDdEAEobkSp8TnYRtG7w8i2
 Ew2w==
X-Gm-Message-State: AOJu0Yy/Jrwu/egO/zAKroh3mXVHY5LkXegygTioCExFPS8XjlvxDHKQ
 StGDZlFdmHrhiMPLp+h5TfSdPto50g3FOK8iL8P+ZzcwYLgjco0dIZTL8g==
X-Google-Smtp-Source: AGHT+IEG5V2t46EvTGeuRixmlfRgdYJi+bJrecDyAP9J+MC+fwm+xBdesN/KrgcOSmwDvwmZlIkf9A==
X-Received: by 2002:a05:6830:700d:b0:709:3015:fd08 with SMTP id
 46e09a7af769-70f5c40da27mr6757685a34.31.1725033459903; 
 Fri, 30 Aug 2024 08:57:39 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f671a8630sm490092a34.51.2024.08.30.08.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:57:39 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 3/9] sunxi: H616: DRAM: Adjust configuration procedure
Date: Fri, 30 Aug 2024 10:55:08 -0500
Message-Id: <20240830155514.481410-4-macroalpha82@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

When comparing configuration procedure to vendor driver, I noticed that
one command was out of order and that some delays were missing.

Fix that.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 52f7799173..35405915e9 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1014,12 +1014,16 @@ static bool mctl_phy_init(const struct dram_para *para,
 		clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x14c, 0xe0, 0x20);
 	}
 
+	clrbits_le32(&mctl_com->unk_0x500, 0x200);
+	udelay(1);
+
 	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x14c, 8);
 
 	mctl_await_completion((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x180), 4, 4);
 
+	udelay(1000);
+
 	writel(0x37, SUNXI_DRAM_PHY0_BASE + 0x58);
-	clrbits_le32(&mctl_com->unk_0x500, 0x200);
 
 	writel(0, &mctl_ctl->swctl);
 	setbits_le32(&mctl_ctl->dfimisc, 1);
@@ -1038,6 +1042,8 @@ static bool mctl_phy_init(const struct dram_para *para,
 	mctl_await_completion(&mctl_ctl->swstat, 1, 1);
 	mctl_await_completion(&mctl_ctl->statr, 3, 1);
 
+	udelay(200);
+
 	writel(0, &mctl_ctl->swctl);
 	clrbits_le32(&mctl_ctl->dfimisc, 1);
 
@@ -1281,8 +1287,10 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 	setbits_le32(&mctl_ctl->clken, BIT(8));
 
 	clrsetbits_le32(&mctl_com->unk_0x500, BIT(24), 0x300);
+	udelay(1);
 	/* this write seems to enable PHY MMIO region */
 	setbits_le32(&mctl_com->unk_0x500, BIT(24));
+	udelay(1);
 
 	if (!mctl_phy_init(para, config))
 		return false;
-- 
2.34.1

