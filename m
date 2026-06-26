Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F0BC43327
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 14:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F29384979;
	Fri, 26 Jun 2026 16:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="px9yIwjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0FF3849E5; Fri, 26 Jun 2026 16:45:50 +0200 (CEST)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536588404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 16:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-139a71baa35so3065938c88.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782485146; x=1783089946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKlDkATizMtshTsXCe65WrdAFpp7svhGaJJ8ZjtDs8E=;
 b=px9yIwjsCR6YCmxeATpdEuN7bxdku+Axw8vcohvxe5rEGNzDzM0UNzhP6x9HxRenLX
 yJYWMDNNVXi4vl5w8WOwZEWmCwoRTlKCGK6qSxXAS+PTCqTokBthb0JE3MiVkkxnU6XR
 TX3QeQJ8U/8dQ2QH4KC1IVzmXG+A/RMRXRz5TzX4SvE4dZW6RGYUiVyAb/iwYUotIRJ2
 5hq/RJdkF8S8b302YCvw6D5j52ao28VSzQvp2jgLlV/CPK8w2DGPrz9L6nVrnHyc35Y8
 5naJBEs7XTQ4O3yzf9QUPfH2xaTMN+b1rqjrJeucnL27wKTGuLNXgILYMCCmneSYoEye
 aFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782485146; x=1783089946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IKlDkATizMtshTsXCe65WrdAFpp7svhGaJJ8ZjtDs8E=;
 b=pnQVaGJSjcgajAXCOmKCDfCMP9TCZjn+8zQ9+8e3GBSKHIXNQq1DoCG64BI3yoPEGN
 3z56Mx5ojsiHCOpwLguxkuez/Leos2r5EV4wq/e1UHYNp0PJn9d54AtftJonbczxppi4
 zieDFeIorTAgLOh+wNrHYmc1yj6vcwmvqgcM9ExrLt51ZO/F0OT91rpzrBL7/aBuYnhk
 saEWDQjiqxsyks/MQx5K8h9wEx2UOaeHibVqEDZK/W8cBHSWNs5L/Hd+hsNn39oX1S1b
 CK9c6lRdMMWAX1PImQkRyYpMoTflTFL8V6TFeo4JiBTGTj2mEXPeRPbPa0qe2NguuwXP
 o/qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fXCNcbJpD43DUngeD+0W8Q15wXjGfmnmhdy3vXMKN5FFY0JglD6uUBpEvZGVdAQKVaDHk8FY=@lists.denx.de
X-Gm-Message-State: AOJu0YwSBUTr92ntUF2vcK+/j7T5UDaqCa0lhfHtfIb3Gka4Rt/vQ+2j
 hg7HkwOLTMwUarDRPwcrlbZfEMpfSbia8ma2Kmv1WGgNyHl3WNSDRMlhDE4UZg==
X-Gm-Gg: AfdE7clVIat9pnceJn07jL529yE0tL6nLm3gxhnNmPpVd0UT9FsVobuTLXGLmwgYoD/
 nz68IYTjsM0S0diasd5PWmUNZZoMBe0jx2xA8dcEdtA31AjX9oWZB6oWAehfSulAky/p5pUslBL
 m6RBIllbc8/tQ/USYRYmwmC/E7+dv9c424P6SP8kcpg1nPqjkjWSLXAmDd1Xv6/8AvrAFkKlZIh
 CfA9+ZJQyqJxR1pv4aVAxvUpvANkqVayOV0BQrPawD+hI5/hojWckm9y1ceBIdjMpQ1lJtEI0NB
 lg31WBKr5zk69uU+7YokKhGBqt+7l8heJwUG/MoThQ8heTLjtVgX2kWKge3tSVeH1LjQx1grLCU
 WUw024kBSSFtJzl6z2LaA9lfMfiVs7FcLH+EZv2VRaHgRqEjmJLyufWq9CDl+wXidSZWmAjPBjY
 tYwSJ4O6R3cIvUknjWm+htSaA9+DExBP3qp7j73cZwJzwWrrfGLbj0MWQoATM=
X-Received: by 2002:a05:7022:390:b0:139:c4e3:9499 with SMTP id
 a92af1059eb24-139db9edd39mr5585803c88.2.1782485145560; 
 Fri, 26 Jun 2026 07:45:45 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:24b8:381f:62d1:5cfb:ac63])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d9105b57sm18823739c88.14.2026.06.26.07.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 07:45:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, sunil@amarulasolutions.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 3/5] mtd: spi-nor-ids: Add XMC XM25QH128C
Date: Fri, 26 Jun 2026 11:45:31 -0300
Message-ID: <20260626144533.2925490-3-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626144533.2925490-1-festevam@gmail.com>
References: <20260626144533.2925490-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Add the JEDEC ID for the XMC XM25QH128C SPI NOR flash.

This is a 128Mbit device using 64KiB sectors and supporting 4KiB
erase, dual read and quad read, matching the other XM25QH128 variants.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aab..18d61ddd2e33 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -669,6 +669,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("XM25QH128C", 0x204018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-- 
2.43.0

