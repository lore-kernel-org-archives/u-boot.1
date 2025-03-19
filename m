Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E82FC282EC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 01:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C94781D25;
	Wed, 19 Mar 2025 02:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OO4Y1YIi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A21981101; Wed, 19 Mar 2025 02:43:21 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C3C0805C3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 02:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6e900a7ce55so85552356d6.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742348596; x=1742953396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoTrTBdzzGHp9HDEoklrmT7EvP7EXjDJBZOxYlnp9L0=;
 b=OO4Y1YIitzC0nbwhgar7Uxj136riF99WtB72+EVGruFdVn4AZsOt85kgnP0N0l81qV
 t6hcMBRiRGv4a/OSf+Jdql75MOMb6Gz4OE8Y3OKHMereSRWk5+I0LC/Shpc3rP+eKsZ9
 KxXK8hjtvSgouqqRYJtYzHyHJjckQGpJmF43M3L/BvRKJzyJoE3/CejA2w6WRTRfBzOH
 hsB+KWNj4z9TZSOXSAw2h1Z25vV1aRwK9PPES4/nKjhfm9mVW6xXdqmd/xZkyHOKOxdf
 RpSS/xnddpHO+2XWANFvzM4oiRg/AHsQrDOS+XN8mYV017C2ZEUjcYd5pvB02S9R2YUm
 lCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742348596; x=1742953396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoTrTBdzzGHp9HDEoklrmT7EvP7EXjDJBZOxYlnp9L0=;
 b=VvfzXpnjwPbqLtvEDv0u7NzxNhHzGnMubCYpnWXNElZ8BSCw6G8Th53ACOCYDMpjiH
 FGeFtwisvstfs5UGyPeulw9sxvkyqBnHo0+vEfXOPHLxzRjGqertIhe9MZ0k3AE+A5M0
 kPc0sOoZdA/tRMyqmr91eNpHNH+D53R7bGR5HxrXn1yfzIGCkAc2Zf+8E0ykcV9kXCXy
 XBcqRo8Dz4KC8UCIz77ipISypbOJuYZ5VFb8LsHoZoF22VTnCtJI9SP/cAIcc3u2PCxC
 7un0PrsgcOGFOdknzReOhWm1rANtLsD7kwM7x5EN60QGg6BkFLXtS+Yqwa4DyyXl6G74
 MlOg==
X-Gm-Message-State: AOJu0YzjU3+LYDTsmdpwsPwFaHvuGwJbS91Hpp23GxHl8Rzl8EDHAT2P
 eh/NJwZZgO1F0CEQ6g+TI3gYlF2nkOLmWixohwJn0Igwu+rNiEVWj4g1Vg==
X-Gm-Gg: ASbGncvKjCnJrelxS1N5f+XmBzYg2MMrm8ZFSPeeUHuhaJzFhlxWsSZoSJ81OFmh7Lb
 cVAJrLEsAxfZahgvm4irQA1I4v07yYSgJ/2Qns0vjnBDgxcKG5Gc+A6Mr951k+DSeXLz5CJ2aiy
 IkyyDnAMcnPrZfNTJdF/jgLI6RDp6inNc3bm4lrWeOl3bmaFveJN6aPYYhRMczEshAT+ar5uqLz
 AS8ZcqCwSQFREFkq1ES9Hl5dIFdqQaXJjL7snyRgicWKEskCLWT96Vggu6f7i77IMZzeopojBvp
 tcx7JwBVRpZOjLKOLn4jscPaRxEjYHvTF1PeR2fJKWF5/oiT30hYzjPnUP/KeLOkzDmoN7V9Equ
 geHer/DQiyv6gowYowsM=
X-Google-Smtp-Source: AGHT+IF+rAIu0E1gKArXth3irZqYCUoqB7YJNjVZiNJOcN2GhsZd05G2iCwLvxVSHgbFKn/LBzODOg==
X-Received: by 2002:a05:6214:27ec:b0:6e8:9021:9090 with SMTP id
 6a1803df08f44-6eb293b1dffmr17861516d6.26.1742348596548; 
 Tue, 18 Mar 2025 18:43:16 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c4e6a1sm795871185a.18.2025.03.18.18.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 18:43:15 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 4/4] arm64: imx: imx8mp-beacon: Enable CPU_IMX
Date: Tue, 18 Mar 2025 20:42:37 -0500
Message-ID: <20250319014240.592189-4-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250319014240.592189-1-aford173@gmail.com>
References: <20250319014240.592189-1-aford173@gmail.com>
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

Enable CPU_IMX to register the ARM core and identify the
speed and temperature information using the driver model.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index 9709f628f9c..2893270d0c1 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -88,6 +88,8 @@ CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
+CONFIG_CPU=y
+CONFIG_CPU_IMX=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
 CONFIG_FASTBOOT_BUF_SIZE=0x20000000
-- 
2.45.2

