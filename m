Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1EEC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 03:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD6888069D;
	Fri, 17 Jan 2025 04:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l/gCRr1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 882A9806D8; Fri, 17 Jan 2025 04:00:54 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B76D801B0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 04:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d888fc8300so9698386d6.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 19:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737082850; x=1737687650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GI4UzWKRCaTiAJ1K3gASHCoa4NcDILxWZTnOPt8nj/0=;
 b=l/gCRr1SOEanH+PI5RoM+no05Timj0K9hwqZ5kg9+rhbLmRteBpNQMsz9R55v9UWZT
 /fLEhGAn6SwawsRYNchqMD4MorWtwZzbiLR0O2VnrlZa2kuLFdLcemQ/1kYYGM/cQghO
 LQvQ9tANhbkiuDz5CrD51BdOthN/WykQZ/yrxCZ6rLl9+cL8CY0wmD4qp+esng35dJPs
 IL1QnLurKGw537Wn8ZRpchOlyb/iShuIhpOX1ddg6ATHcB3OD/oWNFyutGWEqi/pwMdY
 L2AfYWrsBgi8QvYzCq8RBFpIWWtFyFls5+c1rADJt58yvzAOuilG3VJIJqjwKtalpJEU
 j23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737082850; x=1737687650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GI4UzWKRCaTiAJ1K3gASHCoa4NcDILxWZTnOPt8nj/0=;
 b=LSqQ65WQLJLKEfzrMhf9t08Ln026XSRwBv/QY+Esm4c/601M5dNvbwozJpzZp46ZsU
 dx12B2ZS/Is2Jiy1h9AEALM0wQK35FI/w2yw2TEznw+01d56cPk8iJFaW4BDmiqEah7O
 9bGREh46m604Cu4r7uCxI5ywan6IVHqTRYar8Pf9vyNXjfw0vpuyBraL1foD2gnyyUwK
 brfOYfL+Df+VbiSLtVCSC66TMC9k4MQQu4ALZ7cNMHO6VTJStQW5+mgQzEUrCLZ1SV/H
 o5WpTzuJttlNDgfvtHQrXyr4Dh8Puh82sQVjkaPngzbdfQIrxJSY0ZQzT5zmE29nNwqw
 delg==
X-Gm-Message-State: AOJu0Yy0Dq9vjkeU9Nenlla43260BED+ErwJmW13SYWwLBgT+SWzM9u1
 minimAaFBuo1PD/yl3yo7PBvJhmLLyHJP7rPo25uEHukuhtB5/EmKOi80A==
X-Gm-Gg: ASbGnculHLpfthHh/B3KxUDtmaUzylxjcnV/lhVc5k6+vm2jvUUsBmHNHDJXyFNmMa2
 EA8ahWWIS8Z/x9qyNLhi4BAdNmSMj6vWdhywjQl7Kb3VYCltXu1LNXk8UZMnaxLEpRyzfSHLBif
 5WVmRfrpg3wy9AvoKQDbGUbo7WxG+nY0LcO+JBmsCUZP4oPeQm6BWaN4sYlJmc9622eDQDcqWwx
 VlwR4oZ8xEkl4BvHBWx4WbzJ6dYwZJzrEn1tF2pe3gWPcoy85YOfrP7OJZsxpstMuy1kbBPcg/Y
 B6LYHex0Urh45xS8eSEi8HAFDB4TzyXNo88uSw==
X-Google-Smtp-Source: AGHT+IGySsTnTenduM7ItXVl6bwgPU6iO9Rl76nZTOlmTvTob0twbgEiWUiJRAxVnlf1tVDLb8UOmw==
X-Received: by 2002:a05:6214:4401:b0:6e1:a5c1:d52d with SMTP id
 6a1803df08f44-6e1b21c46bdmr23187846d6.31.1737082850601; 
 Thu, 16 Jan 2025 19:00:50 -0800 (PST)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net.
 [108.26.179.17]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc0efb1sm7228876d6.26.2025.01.16.19.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 19:00:49 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Jesse Taube <Mr.Bossman075@gmail.com>
Subject: [PATCH] pinctrl: imx: Fix NULL dereference in imx_pinctrl_probe()
Date: Thu, 16 Jan 2025 22:00:48 -0500
Message-ID: <20250117030048.3874426-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.45.2
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

When converting to ofnode `ofnode_read_u32` was accedentally used to
replace `fdtdec_get_int` instead of `ofnode_read_u32_default`.
Use `ofnode_read_u32_default` to fix this.

Fixes: 59382d2 ("pinctrl: imx: Convert to use livetree API for fdt access")
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 drivers/pinctrl/nxp/pinctrl-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index b1960c56b51..54cec37327c 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -219,7 +219,7 @@ int imx_pinctrl_probe(struct udevice *dev,
 	if (info->flags & IMX8_USE_SCU)
 		return 0;
 
-	addr = ofnode_get_addr_size_index(dev_ofnode(dev), 0, &size);
+	addr = ofnode_get_addr_size_index(node, 0, &size);
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
@@ -228,7 +228,7 @@ int imx_pinctrl_probe(struct udevice *dev,
 		return -ENOMEM;
 	priv->info = info;
 
-	info->mux_mask = ofnode_read_u32(node, "fsl,mux_mask", 0);
+	info->mux_mask = ofnode_read_u32_default(node, "fsl,mux_mask", 0);
 	/*
 	 * Refer to linux documentation for details:
 	 * Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
-- 
2.45.2

