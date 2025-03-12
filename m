Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956F4C282EC
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4006B81B42;
	Wed, 12 Mar 2025 01:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="myxyYGK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90313819FC; Wed, 12 Mar 2025 01:32:05 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE8B80756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-471fe5e0a80so50411491cf.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741739518; x=1742344318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7bxhsfjS1Hn2cWdAB5kYBLjErfEn45a9AcA8NB8Zls=;
 b=myxyYGK4R64RjuQmGz8doLDSoS5vf+1Suqq4vsyhanMkNdRa/TfySfu5r9xwcXDqoS
 /S/kG4tg1t8XG/FfCmgwLrhqyEYpgzv0Bx8BPXD0qJ+G0xVcWRAjGkpsrNpSB5IQtZNs
 DI+IXgLYsDCuyNmR0MyNOBdZaQMuFco99yHbGubOnW8WameYybOt2qYDOVq4o4lCpu9A
 JzytvC1aTP5VvOyY26nGCSsYdcn27lp0DCsYTty9uekVnPxSAmGBdG/x04n3Eunygnt6
 HOblCoB6OCat7a0Z4Dt3z7VlBuK08ezEpAF7yl54ofmC4MOzliHtLpESK+6N0Omfrq6/
 afHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741739518; x=1742344318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7bxhsfjS1Hn2cWdAB5kYBLjErfEn45a9AcA8NB8Zls=;
 b=XhkYuMk9tHh/CJ5mfMjqfWhTu3NXjjHpbM5oWyupLFp5+iA0+TMJ7r3ffXB9IlMMOA
 D/5dKrJC2A4DVpeSe9ZLQom1qsbI300SYhNnYRMgtY90z54BaSkO39avx0AZAJ3SMZvU
 C7xSy3KdRoxJObRwXLTtr3XCSNE37qge7TVAYbECaJu4rnfL1/HJrXOjko2rjVYPKGJ0
 4wqqXPiHIcGfsF+1wZq1JGBaWUlF/KEnitzqha6oI9Ng7a5sM2/1ShMRZ/dZfN/E2SnO
 u/mVtOKtl6L1iIc3Ki56pQFde9YipOGwsr635usnGvOq6wMCuOyVKN0iyYdafb7iZrFi
 sVqw==
X-Gm-Message-State: AOJu0Yy0w7Fm3q8sGSiIlzidiYUYyv+2kT/tq4LCqBfCY+kAqH1CWhr2
 Gk0PsdRh9sdHXvZI76oWntrFtbKr03JdE8OOVz8jAdYzAE96xY5j51/cMA==
X-Gm-Gg: ASbGnctfgtkrrJ+xevvVj11KXZSdEnnPwnSpiytj4gI2MdFLoVMsE8wMM0N/CBHFrL5
 zRkzqtsHYg33SVXcjdOF7LN2OqDFLemLEm1xJet8gBr8eRSq9pf6Yft/cHV3b9LxXRrO5TwGbNV
 i5+S3HFnfE7EEKnxM1DR8NxQWfBlQwQj4Y+meOFTdJrsVSaTVrSzwPnP/YkLmChFYXd2S9rjGXA
 MnLosgMD9/SSE546mxtAsZrJMMiKauIvQkpuDM8gCn2DHuktYovZm+pHn/Q5dYJ8agaIv45+Yen
 bTSQCV+2UtvjmI7X2k2L2aTvhRhwoVtHKhj9KGVmay6yP/5eiC6MfH82r4gpCqNcS372QTqNFIn
 Bmjj6GGP/v3iWCnadJFQURnadspSqYg==
X-Google-Smtp-Source: AGHT+IEF2e5tzl38fYsZTMkZrPXA4zWX3W0z1yAKqptGw3qQW1UNuK8LreQK39dgfjfmhpHwx7/93g==
X-Received: by 2002:a05:6214:1649:b0:6ea:d1c1:f03f with SMTP id
 6a1803df08f44-6ead1c1f2a6mr4837736d6.21.1741739517952; 
 Tue, 11 Mar 2025 17:31:57 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b798sm78025286d6.80.2025.03.11.17.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:31:57 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V2 06/10] board: beacon: imx8mm: Let clock system enable UART
 clock
Date: Tue, 11 Mar 2025 19:30:26 -0500
Message-ID: <20250312003041.110023-7-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312003041.110023-1-aford173@gmail.com>
References: <20250312003041.110023-1-aford173@gmail.com>
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

