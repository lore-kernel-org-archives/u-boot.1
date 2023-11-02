Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA94C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 095C887671;
	Thu,  2 Nov 2023 09:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PjXsb39p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB4387671; Thu,  2 Nov 2023 09:23:58 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3DFA876D9
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc34c3420bso4983945ad.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 01:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698913427; x=1699518227; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aX/fCtToZfoBE2e2Z2TopeadAJkOT8DyIP9mPkZCbjY=;
 b=PjXsb39pmOyqq3XcDuEtoZcgThYEgSJgPnWuoIROBHw4KqCosO86JdGlwQjKd5mnNX
 4D5IEUQJtHnWIzzsOgrKiMRR2gQ3s9BdHaNNfMD9fJ4bq/5yChNTbv9VuC0CHW+PHq2P
 5APB6RxKssd+BW0ExH90QrU8gKMd4BqBZM7aIPyo1sj9/moS1ZoTyAtJkDz10lOedQOf
 cfriEdpxAggxXyfTNx95FK0rAB/ckpGqRf1xPa7IqbCkcYBui28l0mZe8IVZ37tC0sIX
 JqHq8Y3ijdRXAbn36oOmRLU1VSE0RyKPFb/fP9FWN0Cz+maQgWIg2G3QxPECjDcIuwLr
 425g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698913427; x=1699518227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aX/fCtToZfoBE2e2Z2TopeadAJkOT8DyIP9mPkZCbjY=;
 b=f6P4CPgvxoF+H4EEobOQLg5OOH3gObMngaVPgTCYqw2jicjyyOOPCnHUqBCVYV1dGj
 GIC/I2oJwx18foyn8xN9Kkx6VH+1maVi7dbNJWFbhuIcFjmLYnjtN4FplOvrOmvDpvRG
 sgURP+OKcQiHbF40cf2fWBmABo5p5T/KEOp/apD5eUo3ns0zlCwGwKFj4Qn04JHZ//MB
 0LWMnfOi6dupwRx3xS9Yw0I5O8CoOhdQ+t0F+FZH47Jc5bQQ62G+eJ8zMircWrBDb+Ym
 Tezv//9EKWMnilklbIEI+MLUotXbYvI2NO4hk37oSwikoky0yVvOaTz6mVNJdIGKYgn9
 yVWg==
X-Gm-Message-State: AOJu0Yyqqzo1vTDVWa656nyiN/Jb74sBUVhobbshOfKypxut9R16QBaJ
 2NbtTTVLcM4XqE1LSZYDb7orag==
X-Google-Smtp-Source: AGHT+IHluEXqegf1d7jJRtFynlz3WoMXhSLNlGYoPllvJy+uZGT8X+C3FK9m4+cROYNQ3LWOb2uTVg==
X-Received: by 2002:a17:903:41c7:b0:1cc:510b:36c with SMTP id
 u7-20020a17090341c700b001cc510b036cmr11368137ple.54.1698913427201; 
 Thu, 02 Nov 2023 01:23:47 -0700 (PDT)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:5315:cd32:1e1a:95f3:9ce0:bc69])
 by smtp.googlemail.com with ESMTPSA id
 l9-20020a170902d34900b001cc47c1c29csm2546789plk.84.2023.11.02.01.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 01:23:46 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: axi_emac: Use reg property for DMA registers
Date: Thu,  2 Nov 2023 13:53:02 +0530
Message-Id: <20231102082303.354944-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102082303.354944-1-mchitale@ventanamicro.com>
References: <20231102082303.354944-1-mchitale@ventanamicro.com>
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

As per the xlnx,axi-ethernet-1.00.a DT documentation in linux, the AXI
DMA registers can be obtained via the reg property or via a separate
node for the axistream DMA controller. Currently only the latter is
supported, so add support to fetch the DMA controller registers from the
"reg" property.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/net/xilinx_axi_emac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index 54f2232768..ef151ee51b 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -903,12 +903,11 @@ static int axi_emac_of_to_plat(struct udevice *dev)
 
 	ret = dev_read_phandle_with_args(dev, "axistream-connected", NULL, 0, 0,
 					 &axistream_node);
-	if (ret) {
-		printf("%s: axistream is not found\n", __func__);
-		return -EINVAL;
-	}
+	if (!ret)
+		plat->dmatx = (struct axidma_reg *)ofnode_get_addr(axistream_node.node);
+	else
+		plat->dmatx = (struct axidma_reg *)dev_read_addr_index(dev, 1);
 
-	plat->dmatx = (struct axidma_reg *)ofnode_get_addr(axistream_node.node);
 	if (!plat->dmatx) {
 		printf("%s: axi_dma register space not found\n", __func__);
 		return -EINVAL;
-- 
2.34.1

