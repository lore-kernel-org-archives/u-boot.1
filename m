Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7AAC47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10601874DC;
	Thu, 16 Nov 2023 17:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="I0K6bODh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74884874ED; Thu, 16 Nov 2023 17:44:15 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C87874DE
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc29f39e7aso8274265ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700153049; x=1700757849; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QqQyvVN1ex0mG4j3WO+9yX9EMI3gfuPAaI5l6G5rIw=;
 b=I0K6bODhe4CNhy26rqeiLBimMJGB4q3TKawBnkkKE7FmMVH3F4lF8bfy1rN6j/ZXEg
 ZMHm1OAuCviBLAVJHdby4HeSywgFamDgufsy8vhZsNePnQOHu/GscbIgH9WPiizUUu3D
 6jt5A8SynIsaL+WIsPfgOZzKbf+8YqtPMTdcJUQNCOUSriTa8OtTLKJtNVH4MXJXACnr
 DH2CvQD94pfippJ/hzRygySfiIi+caEKPNaZSVsf2sEAurOTWnPiVAfJ/gTDigfN3+td
 ETonEFQ9zKg6LxIGTj8/H8k3KulAjo0gsUliPhqEOg2B5srVhnnZXPILaoP0sjfmPmsb
 HaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153049; x=1700757849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QqQyvVN1ex0mG4j3WO+9yX9EMI3gfuPAaI5l6G5rIw=;
 b=kUZhzcdjbu0tdOte4VdaeAsUhIDLFu5jHW4sMdU4apUxX4CJCtcfoUCOUBo++AfHq+
 u6f7r+HuIT2l56OOC8ldCd5TMU3rqYJ5xZQPiz7ZzFIBTJjavetEXRWXys+3vbw7LHU3
 we2QOhw0tBHOW+qkS5OiwVETsi3JA3VfvT72taEGsbWDj0mIGenxDHry9MQWCwR5oWg7
 gttGpdG+YoW3QgQUn3Uu94CUTLf7N4sB175hWnvP9+JyBm4uMLdQh7yv3T6iULApF7sr
 wHHBAaeSOG8/irnsKGSQViSYUdCS4LNXtxFRCmKUuhSqG7ygRXv8PMxiP3+DFfJrPzzV
 HVYg==
X-Gm-Message-State: AOJu0Yzo+26J5xFTgkk0ll8fUawnGQemaZXsQYxcQ5BTWgQ8RZ8hKFLb
 9/d9p+3ALLVrrDJEse4HNVkVERpyP3bjTjFAvrBwRw==
X-Google-Smtp-Source: AGHT+IGUhbWfeweZ6tZfHu3cfiF9ZczyFc2Yil1Cgu382WWiYRrY/Lk/vWBfcFQg6KEz+HkBzGgQ/w==
X-Received: by 2002:a17:902:efd2:b0:1cc:3a60:bd69 with SMTP id
 ja18-20020a170902efd200b001cc3a60bd69mr1967799plb.25.1700153048901; 
 Thu, 16 Nov 2023 08:44:08 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:57e3:f37f:e352:7f6c:bf18:83f0])
 by smtp.googlemail.com with ESMTPSA id
 l2-20020a170902f68200b001c5eb37e92csm9439839plg.305.2023.11.16.08.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 08:44:08 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] drivers: xilinx_spi: Probe fifo_depth at runtime
Date: Thu, 16 Nov 2023 22:13:36 +0530
Message-Id: <20231116164336.140171-4-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116164336.140171-1-mchitale@ventanamicro.com>
References: <20231116164336.140171-1-mchitale@ventanamicro.com>
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

If the fifo-size DT parameter is not provided then probe the
controller's fifo depth at runtime. This is ported from a patch
in the Linux Xilinx SPI driver.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/r/1422029330-10971-5-git-send-email-ricardo.ribalda@gmail.com
---
 drivers/spi/xilinx_spi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index b63cda2091..94ddf4967e 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -109,6 +109,27 @@ struct xilinx_spi_priv {
 	u8 startup;
 };
 
+static int xilinx_spi_find_buffer_size(struct xilinx_spi_regs *regs)
+{
+	u8 sr;
+	int n_words = 0;
+
+	/*
+	 * Before the buffer_size detection reset the core
+	 * to make sure to start with a clean state.
+	 */
+	writel(SPISSR_RESET_VALUE, &regs->srr);
+
+	/* Fill the Tx FIFO with as many words as possible */
+	do {
+		writel(0, &regs->spidtr);
+		sr = readl(&regs->spisr);
+		n_words++;
+	} while (!(sr & SPISR_TX_FULL));
+
+	return n_words;
+}
+
 static int xilinx_spi_probe(struct udevice *bus)
 {
 	struct xilinx_spi_priv *priv = dev_get_priv(bus);
@@ -116,6 +137,8 @@ static int xilinx_spi_probe(struct udevice *bus)
 
 	regs = priv->regs = dev_read_addr_ptr(bus);
 	priv->fifo_depth = dev_read_u32_default(bus, "fifo-size", 0);
+	if (!priv->fifo_depth)
+		priv->fifo_depth = xilinx_spi_find_buffer_size(regs);
 
 	writel(SPISSR_RESET_VALUE, &regs->srr);
 
-- 
2.34.1

