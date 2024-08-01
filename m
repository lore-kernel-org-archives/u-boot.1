Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E291C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 22:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E0588B9B;
	Fri,  2 Aug 2024 00:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCgcdMRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345B188B86; Fri,  2 Aug 2024 00:57:50 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B9B488B5A
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 00:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3db16129143so4326373b6e.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722553066; x=1723157866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOfYRq/GpR2fn13oNFAAg3ynAb4oCL5zUsQ+faxJgkI=;
 b=gCgcdMRdKaaWpEHqKc810/gC1Bs5fP2ikCas8RIYKA8tyLGqZ3kjFJ2whikR5j+Tge
 8KIcInW8wMk26NEzRb8a+ao5E04wjY8n2Q4SVsvgfFwYmkASLvNSyuVcveP13bI0kvqg
 Ncv6ETNTgYgjW4AlqXGc6Me9LM1C+bQG3iB9jXhJY+dyYxI3m8MhO+kGcpIJobbjxHQ1
 R9oTjfCWcH3HzPLNWvcCALRHfsHDeZm0e+HP/oQfuyGHtWbWlkaqdEW51stcCtdBBAqt
 s2M8Alk3wTOsfZfs2OL32xzml4E0Ey8aI8IbWjYv1qP1o/Bgox4rNfO+j78RY0WUfKIA
 7WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722553066; x=1723157866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOfYRq/GpR2fn13oNFAAg3ynAb4oCL5zUsQ+faxJgkI=;
 b=Y4rIsN0wZyAe8dE5Ojl04stL55Y1y7TcjyNP6PzgUxVS6JVfYwU91bXZZs6KZ4Jf68
 MTciDUia9Qjmc9w1C/dxNUfBeqBJaMfgXbXSom8QN0eHuppcE0qdsuLXEomdTPAMZQmy
 u5N6m+lZeH5HdNDQx7BmBQDoSoXiydeXy4oQ+qfaHj/QwR3kFMfbxBS6mgrz6qvu97NC
 CoYbCjOy5O8nW83jEesoLVzUCxkoOEiushF5xkewGBT4sI0ZIaYki1MulBL8Qr6QiuNx
 MNn+R/3bJkoGj5nyL8ePJpGhw0jLpsE8mCbmHwRuu9G/W8QaZQHBnaYdmI//kVuBD73E
 G4uw==
X-Gm-Message-State: AOJu0YwZ8zX29AgHYhfrjwuP/WzNe+QyY9HVdN+6e/U4unpS6uMWv8xL
 0c8O38fu+t+kJdqDFYCua7eLDi5yEVT3C1x5AZV8/IcmF755ElbqBu01zw==
X-Google-Smtp-Source: AGHT+IF3GrpNRg4z3sqXhtkgaGWv7aMNFWSmUoQIkfjMGdAvkWQokl5jFWMug2gyD8PXUb3DuGv2rQ==
X-Received: by 2002:a05:6870:4191:b0:254:c7f6:3294 with SMTP id
 586e51a60fabf-26891ee23c2mr1789384fac.47.1722553065781; 
 Thu, 01 Aug 2024 15:57:45 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a67b515sm58039fac.50.2024.08.01.15.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 15:57:45 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 5/9] sunxi: H616: DRAM: Adjust configuration procedure
Date: Thu,  1 Aug 2024 17:55:15 -0500
Message-Id: <20240801225519.336667-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801225519.336667-1-macroalpha82@gmail.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
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
index abb8ee760b..aec561cc94 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1025,12 +1025,16 @@ static bool mctl_phy_init(const struct dram_para *para,
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
@@ -1049,6 +1053,8 @@ static bool mctl_phy_init(const struct dram_para *para,
 	mctl_await_completion(&mctl_ctl->swstat, 1, 1);
 	mctl_await_completion(&mctl_ctl->statr, 3, 1);
 
+	udelay(200);
+
 	writel(0, &mctl_ctl->swctl);
 	clrbits_le32(&mctl_ctl->dfimisc, 1);
 
@@ -1292,8 +1298,10 @@ static bool mctl_ctrl_init(const struct dram_para *para,
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

