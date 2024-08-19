Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393D2C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 15:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07BB288CD5;
	Mon, 19 Aug 2024 17:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dzkj8IgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B42EA88CA0; Mon, 19 Aug 2024 17:02:06 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7124688CD1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2705d31a35cso808865fac.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724079723; x=1724684523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kjo9pDFsvtwhRHezPLs3FvZtXyZY5+SglhV9vXSsQ2I=;
 b=Dzkj8IgClLIDaukxkG62olO++GrGs9EnGanwfJn9B84K4frDDYXPjprEtkioPuiOJm
 t6PQfpVYqV4LV13HPifax4ZQjDRPPRJ8gtq7bISkG7BAPf5B8TafOYu+eJmu7K0RKnjm
 i/7FVcN48TIX3DNllwsVjXbgd6r2HIelKSirhNCEz4C8YD2e4UG03OKKdnvpXO3XOQIP
 Jey7wt0GLBOdrKcQbtVRDnfMynyzS+W8SFlcsInkmfvbgd0mHL1e9G9AKwjtOHAtgAEt
 HTvduZJ/fwAz2QE9Ya3hi5LQkNNMjQRyH3fmpTptR5U6UO3tNfpGftkk/G9Q6x1uOuFM
 egMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079723; x=1724684523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjo9pDFsvtwhRHezPLs3FvZtXyZY5+SglhV9vXSsQ2I=;
 b=KRHmQHBT/vfFsR9aZapEQ4Z+idXn3QzkvSiQeBHWnssRK+c16lSvZ1ilOBKD6SDPml
 SoWOOxfs1xpzfSfK3FEoEvFU+za6N/wFXPcbR2omZDeRXMvhw7Fzorff+LgkKVzYJnAK
 MAy+QShH8i6htlZd6J0lqSVzugiy4Y6tmUQcSrc1zwNJ96ZYz6W8YYUrs7yNvJgiydyN
 gKWW8szmmHkkyjYSViHxA8uNsnxSLyxP8ILHmeeN0FlpdscYcywjTxyYgyQqRjvCwpai
 F5PqRHkX3da9v8HML3DsPX9Nwez4Cq8xoXV42HrGwasjQiIFTBmwGrlaqiTnSrcKc2iZ
 9lfg==
X-Gm-Message-State: AOJu0Yyet6ozmEysnNiW+538wuJ/ETOjOZkaL4kACiWZnceCaloj91/4
 rb6GkOCqCQaFZ8krsDicA8neuF4yyhQdja5Q1AkxfCl+n/gG8YiDAg/iYg==
X-Google-Smtp-Source: AGHT+IHk0gCJU935BaNpa4t4kkcECyCuVcU3k8xzJcj3GJTiXQpVvg+B9Mw2qcEZCHu4iy9i0i/i9A==
X-Received: by 2002:a05:6870:d287:b0:25e:19fe:f233 with SMTP id
 586e51a60fabf-2701c5a0e76mr13215346fac.32.1724079723072; 
 Mon, 19 Aug 2024 08:02:03 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27004432d18sm2945189fac.7.2024.08.19.08.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:02:02 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 3/9] sunxi: H616: DRAM: Adjust configuration procedure
Date: Mon, 19 Aug 2024 09:59:32 -0500
Message-Id: <20240819145938.503221-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819145938.503221-1-macroalpha82@gmail.com>
References: <20240819145938.503221-1-macroalpha82@gmail.com>
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
index dfaa270d96..72194fffc2 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1023,12 +1023,16 @@ static bool mctl_phy_init(const struct dram_para *para,
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
@@ -1047,6 +1051,8 @@ static bool mctl_phy_init(const struct dram_para *para,
 	mctl_await_completion(&mctl_ctl->swstat, 1, 1);
 	mctl_await_completion(&mctl_ctl->statr, 3, 1);
 
+	udelay(200);
+
 	writel(0, &mctl_ctl->swctl);
 	clrbits_le32(&mctl_ctl->dfimisc, 1);
 
@@ -1290,8 +1296,10 @@ static bool mctl_ctrl_init(const struct dram_para *para,
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

