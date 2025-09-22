Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A3DCAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 13:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6407783211;
	Mon, 22 Sep 2025 15:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="inB91Y/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF5B3833ED; Mon, 22 Sep 2025 15:27:13 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA6B82CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 15:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so636759166b.2
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1758547630; x=1759152430; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=txMOMUxnAABukrNxxUD+Ul0Gxlc9k7JOiDFuQxg9t5o=;
 b=inB91Y/5kKH6ueraqEV5kMPwubqbHENAY8XylFfX//KwIqNQSnk121wU1seagDyet8
 6EipkrmSYEfCWsSsLTkaGYwLeIlhzMxSc8KhPzbmYXhFL1PApfhJfXotFWVAW9smZNlm
 X24UkkAYJjboC4hFWNqc8s1Qedm3BLSUPUyO1P4OHjHGAVUnwH7YXPRpmrIy8tSzrQHo
 Cch0mN6hn96sC3N/SBq1ddUQeRX5rxJxGOH/vd4RWZvo4P44NFGeC3IfO0A7r0aDtddm
 /TnLPUpAjPy2g+9iYoroVMZnjW34oI308lbtebmNlNH5r6qdUdGHlGI1DDk6muQnCXTT
 m4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758547630; x=1759152430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=txMOMUxnAABukrNxxUD+Ul0Gxlc9k7JOiDFuQxg9t5o=;
 b=IKEa9VBbwkoBmzcqG4pACavGtBjc/EzZq9uy8N77ct0Uu4Kn31fwPFmiaz17ZuMdwM
 dr5xVZoVK1FtBsIuIIxAhwTcrDcUcmY7G/wJDeZBfIiezsHE7B1+qHC8R9RDO9z8LgCX
 MLH9f/PZo4L+S9A3ycxFomq06ZzPeQQH596LAYvgmRvD4/LUocGB3fTQqHMEbDl07Z0M
 WqYmYa/MmKkXqlB41Tcm+JUSpztmeQh0WGIidcGJr3eXF6CMnWBwFmwtSUPfUA8yvvVE
 1v+l55whhIXzj7UHWwYe8ltkJ0HS1/bBev+RucnWovKiJpmrwNKbBPDqqm1/JqNqehLh
 OoQg==
X-Gm-Message-State: AOJu0YyYaj/dBe7XgaHSVo/ouaCyeIHAsavQVXfI+MfxSMm521hBxHJE
 hASX5KzuNVDKUNKmUVwS+rPATpr4ncPQQFD39Qz4vgd+MqGaAiH8aRt/V7mfpg==
X-Gm-Gg: ASbGncvdOEa5TuLH870TO8olITwJfy+Q+0iismNn+Mu8OD3HHuH6edmDdiV4mloA7go
 e1YmolvZKU1PCMavgWn2PkRGwh+btgwPKD/4ReiEqLBXjIeXD7SVOLiskd2LeO7W42FCzMZ9TUN
 t+AT9NxEiCwYlR8e8jEKC6+FMTMRkOgeDdiZBM9Q0rITi32NCGI45X5A83zumJIy7uV5Jz5Apfy
 fJxEgiByf+pTv2DG/Pp1f7U8BTcLhFF7JUZNfRbll7L8taYSxJMdXckGvTb617IMV9RHSJLHy2J
 Y92dXCYt2NEa4SbZNiaPLeWb3+cylTfanVts0NHg8w8JPhP3Ig3lgEwFGJfDMVC1idnDTqLcMFu
 QrtCh2HrUP+gvuxj7ucjpo6EuONZDdS1iDsj5wLwd+tv9XKFt6G7ZM1XBjCSWlLSe/wYdC/Ir3S
 bA2mI=
X-Google-Smtp-Source: AGHT+IH4QjTNfXAs8gkiIn7dc7VvKQIacV91RRFIur3jkG/vSYxIVU6lsG5UUVmzXjbiyyoTKkvMqg==
X-Received: by 2002:a17:907:3cd2:b0:b09:d915:1416 with SMTP id
 a640c23a62f3a-b24f51a0a42mr1183196766b.54.1758547630386; 
 Mon, 22 Sep 2025 06:27:10 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2d5c22db22sm168937266b.68.2025.09.22.06.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 06:27:09 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] clk: ti: fix K3 clock driver help texts
Date: Mon, 22 Sep 2025 15:27:00 +0200
Message-Id: <20250922132700.4180174-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

Add "in SPL" to the SPL related driver help texts.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/clk/ti/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index fbcdefd889a..bcf3976a09f 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -49,7 +49,7 @@ config CLK_K3_PLL
 	  Enables PLL clock support for K3 SoC family of devices.
 
 config SPL_CLK_K3_PLL
-	bool "PLL clock support for K3 SoC family of devices"
+	bool "PLL clock support for K3 SoC family of devices in SPL"
 	depends on CLK && LIB_RATIONAL && SPL
 	help
 	  Enables PLL clock support for K3 SoC family of devices.
@@ -61,7 +61,7 @@ config CLK_K3
 	  Enables the clock translation layer from DT to device clocks.
 
 config SPL_CLK_K3
-	bool "Clock support for K3 SoC family of devices"
+	bool "Clock support for K3 SoC family of devices in SPL"
 	depends on CLK && SPL
 	help
 	  Enables the clock translation layer from DT to device clocks.
-- 
2.34.1

