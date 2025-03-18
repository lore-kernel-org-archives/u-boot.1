Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021A9C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1604F81D5A;
	Wed, 19 Mar 2025 00:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZbHT1ZWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD98D81C67; Wed, 19 Mar 2025 00:42:56 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A63788129F
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7c0e135e953so622405985a.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341373; x=1742946173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78XxD8d60rf9WHFuvZDIxK6/gX5cmozWBmw9etgsnpc=;
 b=ZbHT1ZWKoStEmy0OB8VZ746Y3vSFxrRk6sL3SMtxGPZ2uVeMUssgEkC2PrNHt86ZZi
 NLCYzBGDxmvT3IkGQzax5QQnfO51A/+zYmvxVU9Oa+RNjG4yEpGS88HHJVMTkO6HiinN
 94FBrDBE7DFXe9YM5kToshj7+WMe/J4saRYFi5/7ge7R/U/RFclmA7E8fBJqgcwubl1k
 MGb0Y/RICouQVgq/I9S3NmNPQF5WeYyNWoyQAGQF+C89425CySSuK9Y1Qu+VJYSlBGl/
 7m9HRQR+V46wGsoFTTnfsbJmdmy5KR0vlKgbO8EKcq7FQv+bjQf7H1secBQvsndxzJEy
 fG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341373; x=1742946173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78XxD8d60rf9WHFuvZDIxK6/gX5cmozWBmw9etgsnpc=;
 b=TZuffVa4n/C1IKbOBkIFA6NKXMhegxUypsi1LNeQN/yOvdPNR2ludP7Y2xQzwwUUPL
 QlXfaBHnIGDuMV/MM1vaBeQDdhiZqMXWJkew+Rfr9b8Ng1A2EzZ1rID1Sp9cLcEvZlgq
 utPErD/VQsflInJx9Swm2VKwsOegPgo9qhzFenrm+sriJcnplbzeFnTGcRbV2Sn34Lei
 qkQiaQmPJxS8ywppJU79AyzgOxio3Vkcj2fGcCggKxNotjT/D0bx0JESBg1KFn6b2Y2N
 /ptQKZz19kuJmlOUQS4idL3S4OOSJqd7iAxBQQ520EOw9V/zgKGetV3HkWn9D2ibC+CB
 PRrg==
X-Gm-Message-State: AOJu0YwpbHuNzvZDgCZTMW6Cf9bR80uV6Jshf38HPeHlSgHZEcTHbaNQ
 zYDvJrt3oGo8xHbzEdMvLEI3Ma0QHAwZzIemaIyRBF+Tbh7Sg2BaQzAOkw==
X-Gm-Gg: ASbGncun+XoZns8gA2pkDBqcGQXsEPSupHZSrmQH7yx5i2M/eOUMn2ITxXbxeEWo1s0
 BSujydY1NhWNgeOdflBpItpvs6gXjAXe+yHWoDCY0WyPXbNs01rxUnvD9APY6epQ2RlAVP3ggbE
 e1E3AX8l67D/8WxLnRalvmGafp1wn5eQmCQTJX6LohkMk6iYEUwZdtGQjnig1n3pI25HBqdmfsw
 h1CunaZTcKdoaRSW7YI9n8deE9Gaoyh1eU+eINYlMA/l90uO5Xjb+kyTb4hHE5UhYRu2a7mOegV
 V13sGlNZ2B7x3PkTuz8Pru7YNE21GJYIRk5BJedkbiCNfOonO9d+j43usPKszgGGIPDyrr+QLgZ
 5Hyby3t5e/abpxuadDEo=
X-Google-Smtp-Source: AGHT+IH9yny2fEV7tqqeJGCNsPBAyKIBORXxaMzXVQ6MjsWdE3JsHLsNWDe/YUr/N3AcFOKUijKnnQ==
X-Received: by 2002:a05:622a:558c:b0:476:fd1a:1ab8 with SMTP id
 d75a77b69052e-477082c2704mr14532381cf.1.1742341373188; 
 Tue, 18 Mar 2025 16:42:53 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:42:52 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V3 06/10] board: beacon: imx8mm: Let clock system enable UART
 clock
Date: Tue, 18 Mar 2025 18:38:34 -0500
Message-ID: <20250318233849.587520-7-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250318233849.587520-1-aford173@gmail.com>
References: <20250318233849.587520-1-aford173@gmail.com>
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 board/beacon/imx8mm/spl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

V3: No change
V2: No change

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

