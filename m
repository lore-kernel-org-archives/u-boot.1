Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55962C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C3D87496;
	Thu, 16 Nov 2023 17:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VX+QuBqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E3E87496; Thu, 16 Nov 2023 17:40:42 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2880186FA5
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc330e8f58so8491705ad.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700152836; x=1700757636; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MwV1OJwFXdzoLX54/DSeFYlAijE8E7+d7ZciQACQ/Ts=;
 b=VX+QuBqmtAhBVWDkMsMmtPwU7JAy1hoNvlbhxAUQe/GIAf3eiPFYbcDH/KITp855HN
 hCalS7z7f0M+mAy/u/1SLbh5Jy80PVpoP1mGCiRLyGPwyX/2itFRGaaB2z+IBM4L5D3K
 pEJ3mb2oI2gtn856KpvtyREQG7ZNeD4+D2foyQxLgBSx9IJi+tpN52oPxh2Ex6cL+KdO
 ODcqz8TTbnRTP9IjyV8mEBXs5xL/vDGk5o6Qow060ofyvz0H+ztX6ZH6Ec39eDpUrGHT
 zHq31wNophVYLjZK/OgN3nor+DUk7wfRBU+Ai7QuvgzHNQlNQfvcgrZ4dJnu+U//u4+h
 syRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700152836; x=1700757636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MwV1OJwFXdzoLX54/DSeFYlAijE8E7+d7ZciQACQ/Ts=;
 b=lOx2W47oe+6PzYvZ4pFh+UdfRYKTcrNC+mXVPIfJ/x6N6MscdSS8wBQDC1tLnWRWb4
 NSai9seN2tJguULM8DgMgJAwhskEFqimSyHuhfCz2M2nieWVfo2m9pZPyWuNTEqjtqyg
 Jxde6514bqrK6/TsiFjKrWONiksNHMPY/h4UhJqdFwXuusxcJer024XUn2XilRGIj+fK
 qrmRHaZDGyXTQjjtYFpSRwpGC6yL3PTN7HrDo/x2LjeFdjRv08ihyQQ0+NJveyMdtTPn
 4/6JZZXnGHlND2sM+uswIo1R2C+8fe5FQ75qWZjRWUVWH2R/FPZeOw4RsVlUtO6j8NMh
 zimA==
X-Gm-Message-State: AOJu0YxAkTq4pE5GwWYMvc17uzUr/TCb/Ct7JuhgL63OIh5dGv+BsXIU
 IEjRM8SF5pecZG2pJ2U2OX7zfg==
X-Google-Smtp-Source: AGHT+IGNYu9GH+jLRd2oBXQPhvxQoZuA8iVgCrJAvwN+hhmSdx6RrXaaWqvNuHRnLz7qr7EM38+cJg==
X-Received: by 2002:a17:902:ea82:b0:1cc:45df:4710 with SMTP id
 x2-20020a170902ea8200b001cc45df4710mr8803801plb.40.1700152836146; 
 Thu, 16 Nov 2023 08:40:36 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:57e3:f37f:e352:7f6c:bf18:83f0])
 by smtp.googlemail.com with ESMTPSA id
 e19-20020a170902ed9300b001c72c07c9d9sm9487189plj.308.2023.11.16.08.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 08:40:35 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] net: axi_emac: Use reg property for DMA registers
Date: Thu, 16 Nov 2023 22:10:24 +0530
Message-Id: <20231116164024.139934-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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

