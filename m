Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7018C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 17:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B95387017;
	Sat, 11 Nov 2023 18:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Bcl2x2B+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BF1D86FF2; Sat, 11 Nov 2023 18:36:34 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71BD486F67
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 18:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5aa7172bafdso2128233a12.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 09:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699724189; x=1700328989; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwV1OJwFXdzoLX54/DSeFYlAijE8E7+d7ZciQACQ/Ts=;
 b=Bcl2x2B+zaSPvKND4THfzcLwEqmSK4dfkbILo48L+Xan+ZYxG77j6nJ9Up8UeEwCpG
 kZX51yZy4ypopmd4e6EHpWUjiTqQJhaeiy+h5SIOi6cISfyclTobJMOg+0FCxA8ep3Iy
 wGTW9wQhkFzzQduTrLpMnmdC+hRw/R6j2CmuokE78VCBGLHSK5SSa5JQdzmwav7jkmId
 tDaEXmpqQXmfP+eM2v8wUI1yisV1tuXVcnkkrS4bvGUd7ahrURHFQAEGHvOa1/T9dtxH
 oPVBAOwbroXN6OwSW7XKlHjA1IZ2TXxDw7M5NqDnH1WoabeDrKh6mnVPuoBSwQJkDMJE
 Q/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699724189; x=1700328989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwV1OJwFXdzoLX54/DSeFYlAijE8E7+d7ZciQACQ/Ts=;
 b=M+TAHSCW9B7QkZAXiQCXRpuplPNKY1JrDqSalaMvVmyXMWP9ooIgTX6Mh4it5kHLdp
 KNM7R0GijV0jzIRV9swpS9ARuEIpqLAbyAcrmDztWyYnbkwu+lZKCWBuk9hC18Maho+7
 y/5/xemTMzo3POsTMWztXID46+2GjdNLhoLoSjkuN8Ojh7LqWNeKEFABjyndyzAvpL0n
 +hEe3q88I15Rm8YtgMauuL2khUWLwfUI5OODAsMncRKsYomO6aeH19fT/5n205eQau87
 oGIUIb3gnAyojOT+fprKqackH9424SsisucC8HPWUgTptlpZWQMXfBf4jPoXY/9KjQON
 8Wtg==
X-Gm-Message-State: AOJu0YzfrdH4WdWv3o53po8psFolkUjLNGNKBv/qcxNXYzpr158oxI+o
 tEwU2d1/2o3BpVQWlSNeV2KcXw==
X-Google-Smtp-Source: AGHT+IH/mFT/dDq8AOGdlloU8LRGFCFb1xiL+Brr5k+vxiOlDVYzuIfo1kJTY/KKpO6jLgsvE1hnNw==
X-Received: by 2002:a17:90b:3a87:b0:279:1367:b9a3 with SMTP id
 om7-20020a17090b3a8700b002791367b9a3mr1773451pjb.4.1699724188693; 
 Sat, 11 Nov 2023 09:36:28 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com ([223.233.86.194])
 by smtp.googlemail.com with ESMTPSA id
 15-20020a17090a030f00b0027d0c3507fcsm3809877pje.9.2023.11.11.09.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 09:36:27 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] net: axi_emac: Use reg property for DMA registers
Date: Sat, 11 Nov 2023 23:06:03 +0530
Message-Id: <20231111173604.93103-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231111173604.93103-1-mchitale@ventanamicro.com>
References: <20231111173604.93103-1-mchitale@ventanamicro.com>
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
Reviewed-by: Michal Simek <michal.simek@amd.com>
---
Changes in v2:
====
Add Reviewed-by Tag.

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

