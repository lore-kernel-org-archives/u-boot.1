Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54711C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 10:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A05E81100;
	Thu, 27 Feb 2025 11:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kawChBO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6BCC81100; Thu, 27 Feb 2025 11:30:23 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A4080FE1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223594b3c6dso4822755ad.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 02:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740652167; x=1741256967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvb/cYmJekGNEr5OS7zrBpvDI/vxCmGyy4iPR/9e7Bs=;
 b=kawChBO4YE1tR9ahRMlIdXUP3eeNyneWh6FF/ilTAAoH0m9fO1qJvCIC0R0h1DSCfa
 IAxfcumpHDQwObAM0Ox657pvVWcuApwjENqf/DI8szeZ2mHt3E1f4pTjh0FV4xMhSl2S
 8Au0ijLkk5kji63gjmaTrmlb4YPGcRaAeh/BmZfcBecRnKqvhxUbThxgQGQzP3TuLWo6
 BhWey4Zxk37hJrzlLOtpiQNDAiLE8b7LvYOLBtJ2UKS3H+kYWmAcN/7tf9jZ1cXjRIGh
 g/WteChK9i77geBG+LZxO/EwqVuvL9gqwyC2ZN6WscY6fiyUKWaQgz0khf4hnf5aKn0n
 hc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740652167; x=1741256967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvb/cYmJekGNEr5OS7zrBpvDI/vxCmGyy4iPR/9e7Bs=;
 b=F8m6uzQXpNfgo6yIux3GpRZfhBu0c6k05+WJkAbQc+W2QRo2+Ws1ZJ387h0Jz2FExh
 eHwsVUghAGCMiJjAoTYHEPSo8UZFBsbzFrT4KDOADHqDYerZlZKL3fiWMlT4/0vVhxNi
 iPTIXQ2vyV8f6ocE/kghzxjItrlB147xnkj0IpbMkkimEq7lJHg2Qe7JWxbDhG2a5qEm
 A6OV9ZbZ0sIFchbrLqwpUO59m5xTCmiS9nq8nX3UNpTomzWhL91/ZaOLHco2IdZOj6TH
 gjiYxNkbnWRUx1qEkjiR6bH+xtGt4ubRC6XhtWRBsDcVecxrko9P2lDffSEhLZv4gJl6
 qbug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt8Bez0W626l7Svb1F1zD063Zkp/0vCqgVKhVPIDYTiMgj7YDwel5NWhYnzxKqOuODjH7jdBQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwqgWzHuUzRcdSBALz1D8h7xEjBy6uAeME4qkmjHW6MLzVNRB7J
 fnl2C5IeW83jkCJDxgjENoWfQJ0TlCJ3R6Rzxz3npAVQBUitgkhNSWmpiQ==
X-Gm-Gg: ASbGncvikbRr4bA4eydgh9F5C6a7Q5+e0kJditjvF9OonB4/c/w0rzAYmJhvcqnDHgw
 QCw+Hvq5seK6rKsjq+4JY+vqFzj1tl5BaD66vTWsxnv4g3EOr51wczOik8B0j9lTzqy8zOV/PgY
 JvBd+JKODwVEjWkpf1OzbIgE0za9zaijrbc8UahXuWYNpuvqButG7CUF/goqW2cc8nsS5ddqiPT
 poHnIvSoOdDd9c7rkAC3qDKU7l4cmKYmd/1lWVW++QRqHBsvw1taNjkDx08QmwnUauiSy8qb7TA
 FdSTi56AZ1aIyC+Jt5I8sto2znUsAJouJNUhDSke
X-Google-Smtp-Source: AGHT+IFxE5lJAGuMcXuCt2KkvC2v7kdQOQFJ6OsfbWAtOdcXghsOzcH0EA2oSzt8+bVsT5Wsxgij/g==
X-Received: by 2002:a17:902:cf08:b0:223:517f:94d1 with SMTP id
 d9443c01a7336-223517f9590mr27091975ad.3.1740652167440; 
 Thu, 27 Feb 2025 02:29:27 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5a29:6887:1512:7ff3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22350513ac4sm10977835ad.222.2025.02.27.02.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 02:29:26 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: trini@konsulko.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] imx8mp_evk: Pass kernel_addr_r
Date: Thu, 27 Feb 2025 07:29:16 -0300
Message-Id: <20250227102916.164418-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227102916.164418-1-festevam@gmail.com>
References: <20250227102916.164418-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Currently, booting via bootsd fails because the kernel cannot be retrieved.
The reason for this is the lack of 'kernel_addr_r'.

Pass 'kernel_addr_r' to fix booting via bootstd.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/freescale/imx8mp_evk/imx8mp_evk.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.env b/board/freescale/imx8mp_evk/imx8mp_evk.env
index 18f6c6e200ed..f70e18fa9d97 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.env
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.env
@@ -16,6 +16,7 @@ mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
 mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
 prepare_mcore=setenv mcore_clk clk-imx8mp.mcore_booted
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 mmcboot=echo Booting from mmc ...;
-- 
2.34.1

