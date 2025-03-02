Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD850C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971A4812BC;
	Sun,  2 Mar 2025 17:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="blGLa0zg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5F2481273; Sun,  2 Mar 2025 17:53:54 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778C780017
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d0465a8d34so36331495ab.0
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934395; x=1741539195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7bxhsfjS1Hn2cWdAB5kYBLjErfEn45a9AcA8NB8Zls=;
 b=blGLa0zg2faPGWUdsNArM69f0SVHZ7vxfggGDqupMRNsWng+OyzXUTxdCd7BV2xckf
 dbtiNv+fTlkVu0POFEvN6KXm16FBgZ74IunQ2t+zzpU1CYMMUGUX1RJzEODgyrv2hWBo
 y4h3F1hDvhSFLQu6PbnPKc2JbWxmDrtFQk95YX+QhCaVDKjMzR9QEulMoeiKJl0a5gaR
 h5g2if1itZktugmNDxZYVJNY15GKO2qqdKzq+uqesarAfB/NzMXH3GdORZeBLl2tHwaC
 L5HxU2TjAn4v/qEJErHbMJC+GByDQtNUNmEVFrtVXTmbY4Q1idWCRbBKrWmurx0Q9VmX
 xnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934395; x=1741539195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7bxhsfjS1Hn2cWdAB5kYBLjErfEn45a9AcA8NB8Zls=;
 b=U+QpFiMRiwzS2SjiZcruImaldXddEWFF6981Pj3O88IKnzLyzzyqCdBgLGlfgMptkJ
 8wlApbf2dhRc2g1B68uurFIuJiQfDgn3bJYY10dOlzEkk8uTtjxEdYmEnHAo5TQIj5Av
 9fOS9I21eWod03QBrWKYbfOpOh5dsAksstWp96Qz6UOJ8IYwqDiZRFoS3RCApe1rEjxU
 /G/OUajV0GhINQM0pTgKbPE4c85VCG/4y9yqKCWOY+GUGrDx4N5PMoPVCQLOjviH3DJK
 SDNZcfiQXClAS/VyT2jV0sNldSJvrM8F3ZhHj1ralEuSjbEaT18OowXkjtgOhQX8Kf6L
 9dbQ==
X-Gm-Message-State: AOJu0Yylx2cUv2uF9Eq1m7ox/mXYdzCJTZdDtrwx9ka6EjjGEPwFeuFU
 4zmjuVLiMXiht2DpEWuvTARE/hscrXG2ibzAMppzVKyZj862NW4jvZ4Scw==
X-Gm-Gg: ASbGncvDBEMiy4eR9DHTClFR9xShFMg5vRnOVXFEg+EhZNDBuOHuuBWYVP5CmTFYGRX
 M8oL6BJqBKtd+z4paBp9XsRglfTJPFhd/E1jF2BhxTAlI+lwNk7KNvhuuI3jbMSGvw5hq+IJrvA
 7WpdQPYojD7k40SMrlbfPkzNOa38rZlXpLzrB4fVNHpUOhUBW8TkWajlEXzuSIPu+KBG+nVycQe
 Oj8IATpzCeePbEEGJ4bEKAWtFqq6cGiJ+N0ZMIi5UwBaF7h+GzIrGXx7t45yVq8IXIfzazouGRu
 DvUtplcZACu9XwHamKakWQL9WrIz0VoVCUKS/ZOGkFqUZkefP2s2u+BhRFneZC+iyNhSmBnYkN7
 DdFgA5SVPdgTtr+/wTsI=
X-Google-Smtp-Source: AGHT+IHxTNmEjTA7jtJn2yd+4aW7ph41t6KoxfCkwi53xb5Xs7rEoX2JArHaiV/tSoGQUL9dxOJW4Q==
X-Received: by 2002:a05:6e02:138d:b0:3d2:b72d:a507 with SMTP id
 e9e14a558f8ab-3d3e6fac54amr97860945ab.19.1740934394673; 
 Sun, 02 Mar 2025 08:53:14 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:53:14 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 06/10] board: beacon: imx8mm: Let clock system enable UART
 clock
Date: Sun,  2 Mar 2025 10:52:33 -0600
Message-ID: <20250302165249.267992-7-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250302165249.267992-1-aford173@gmail.com>
References: <20250302165249.267992-1-aford173@gmail.com>
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

Now that the UART driver can enable the required clocks, remove
the hard-coded clock enable.  This requires a small re-order
of a couple functions.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 board/beacon/imx8mm/spl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/board/beacon/imx8mm/spl.c b/board/beacon/imx8mm/spl.c
index 12013aa5a4d..93ee5b7ee0c 100644
--- a/board/beacon/imx8mm/spl.c
+++ b/board/beacon/imx8mm/spl.c
@@ -100,9 +100,6 @@ void board_init_f(ulong dummy)
 	int ret;
 
 	arch_cpu_init();
-
-	init_uart_clk(1);
-
 	timer_init();
 
 	/* Clear the BSS. */
@@ -114,8 +111,6 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
-	preloader_console_init();
-
 	ret = uclass_get_device_by_name(UCLASS_CLK,
 					"clock-controller@30380000",
 					&dev);
@@ -124,6 +119,7 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
+	preloader_console_init();
 	enable_tzc380();
 
 	power_init_board();
-- 
2.45.2

