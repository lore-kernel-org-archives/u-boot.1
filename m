Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F43C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 17:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC7F186EEE;
	Sat, 11 Nov 2023 18:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SnP88je4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE21F86F63; Sat, 11 Nov 2023 18:33:09 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7FF86F1C
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 18:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2806cbd43b8so2717322a91.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 09:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699723986; x=1700328786; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbR08Ini5VbqKP+nKWF8nUioGkUSl2FeHUGXdTZ6Bxo=;
 b=SnP88je40HBA9SaX/At9Nx98B4gWQdM5RZvlveMjVh8+p3n8AMiJEE8N05AmnAsR5D
 5UvOtYlCdD/J710QyX6EmyhbntCsoUadpv3lCG0qlbmd/QPz/ahefZ6b6W/H51ixBWCt
 TvvC65TvRYZopM2Oo1pbHqp+K2d2PtHr/oMhXvm6EB5cGO23CEVSaTftCAt1j72/500c
 6XDDF6iazF42i47IA2VYoBRn/t+r+QsSs8rx4jZrsSfX2aO1XWkA491PQeSSP/J69stO
 gTablwnHJnfdm3YQpKDPyCGvUUnPEKlQ/2Ve/j2Ar1pth8R/iFtzp/f0rW4VK7cH7Dox
 fpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699723986; x=1700328786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bbR08Ini5VbqKP+nKWF8nUioGkUSl2FeHUGXdTZ6Bxo=;
 b=whzH5zAbiSVJ4TQLBT2ezjd9IuP9FlMn7FQz4ygc6RMnezMBBb2UajAE6x8kz85QgU
 DUV1RZ7gMYANVF8Bi4P939nhaBoHuyvx33GzIMGuX7Orw97SIEmllCdZ45HT7Uh+YuAc
 5pZTH3SikGGJxgAPmyPXiVV/dpSVFQXObryyCFLpy95C0CCBDdP1ACyBzG9gjEGBsv3q
 zqwLnZF1IdKrQPAvcsV5uQnqXNteSJpMJ9ETdkzdFt+iOnLuLNI/c0bkIbsWVsuzVBmf
 egR5KQy0JOriI9M+qPoq8Ktn58W48gD1dckqnR8IqPN9HsWlJFsqAbf+JlfRxNc2s1mz
 ViVA==
X-Gm-Message-State: AOJu0Yz9DRpGSVBwRUctW7Q5HnFOIHbPiIke1CLRjlF0k4P9RWyI2jb3
 /iQfZ8rY2axciEib9H7BlXWe1w==
X-Google-Smtp-Source: AGHT+IE0AMJdwV7sDIMk0gvxLp2+9rsR/GYwJ2tkRxa5OEVKAhua7yEOjcjqIgWbdge4Wn4mJvnTXg==
X-Received: by 2002:a17:90a:bb83:b0:280:125:e52e with SMTP id
 v3-20020a17090abb8300b002800125e52emr2510798pjr.35.1699723986097; 
 Sat, 11 Nov 2023 09:33:06 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com ([223.233.86.194])
 by smtp.googlemail.com with ESMTPSA id
 c64-20020a17090a494600b0027cf8869ee7sm3772218pjh.0.2023.11.11.09.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 09:33:04 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/3] drivers: xilinx_spi: Add xfer callback
Date: Sat, 11 Nov 2023 23:01:20 +0530
Message-Id: <20231111173121.92889-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231111173121.92889-1-mchitale@ventanamicro.com>
References: <20231111173121.92889-1-mchitale@ventanamicro.com>
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

Add the xfer callback which is used by the MMC_SPI driver and generally by
the dm_spi_xfer callback.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/spi/xilinx_spi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index d9faceec18..b63cda2091 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -278,6 +278,18 @@ static void xilinx_spi_startup_block(struct udevice *dev)
 	spi_cs_deactivate(dev);
 }
 
+static int xilinx_spi_xfer(struct udevice *dev, unsigned int bitlen,
+			   const void *dout, void *din, unsigned long flags)
+{
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+	int ret;
+
+	spi_cs_activate(dev, slave_plat->cs);
+	ret = start_transfer(dev, dout, din, bitlen / 8);
+	spi_cs_deactivate(dev);
+	return ret;
+}
+
 static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
 				  const struct spi_mem_op *op)
 {
@@ -427,6 +439,7 @@ static const struct spi_controller_mem_ops xilinx_spi_mem_ops = {
 static const struct dm_spi_ops xilinx_spi_ops = {
 	.claim_bus	= xilinx_spi_claim_bus,
 	.release_bus	= xilinx_spi_release_bus,
+	.xfer           = xilinx_spi_xfer,
 	.set_speed	= xilinx_spi_set_speed,
 	.set_mode	= xilinx_spi_set_mode,
 	.mem_ops	= &xilinx_spi_mem_ops,
-- 
2.34.1

