Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA0EC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BDBF8129F;
	Wed, 19 Mar 2025 00:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B7quyB4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F0781B42; Wed, 19 Mar 2025 00:43:01 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07D881D42
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-476ab588f32so44491501cf.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341376; x=1742946176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQAg/64YrNkApGXGBHkJI72TUa5jJ+vn+OGauLvWih8=;
 b=B7quyB4A/g9PrtiMtGLbMSlh/HVXbiJzbi+6yzcpzZA8SJclTCgpZR32Ppf7KvFFGw
 Q6dXbmBzvbmBF/TQ/DKeoiJYHJ3ayMkgpRTMG+ruitaz04WJMZ/LUvFD5UlYdzP7HU8q
 NeKrQCwFzvubr5VsER3TkpLZ0r739s02hDixIhVFuSYkqUSzX+tCz53gtq8+QF0p41MU
 ArGcrNKa+haC8Q9C8wf7dnOiGl+imFGbXbHUz6pxz5A1eETHSF/cvImBieXaEl68IsqD
 aBIFmWpNV11y3grnsYLKShv0ANf/lcMtleN+4+gXX6Dl7zdXyRMq6HR8tM7VU7tAwRYi
 Z0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341376; x=1742946176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQAg/64YrNkApGXGBHkJI72TUa5jJ+vn+OGauLvWih8=;
 b=jmsIxtA8AHwldNliWuXIwSExFXUt93dSlqN0Qi2WTlpuIXR3Oq9J8H68AwJvBc2ZOZ
 KOA2lDL3Q9KDZZ+3iYr1L7tECNEwkmsgqM1tJB0e8fEfVWmORES3rW8YMV4740yePwiH
 z8wJBWAK2eaOPPIDHvWH3cJD7IxVyDBfeJGFJRA+7/xaUfBZpF7WpmSjQZGgpiZ3Kpuo
 N1l1gT+ks+8zf/LiWvYUxhmsFq2K3Cu4IpQvCngXDwAlHSlrNe3mRSf6K5uqJ0xZymwk
 u8261vFooyp+ojqa4nkn3Ea/pIlGWT0K9dgd1F5h1WfbMEOr1bdPU0XrP78vNZslMwKh
 Njzg==
X-Gm-Message-State: AOJu0YwCpA9aT9kuDVoc+7qXyTUkEj/UpHlslh9ah6lPgOGmPFvuC4QN
 FA4bPmuklXKfbkymmp9748dq1D/Qr0ruujX4+IMOuetDJb6YikCwU6f0wg==
X-Gm-Gg: ASbGnctwG6XuS+hh1uMhPmhJi6fwvHmRjp1da+uq2kn22iON3a0kLyuD/2MKvaXQ3EC
 +k1bGURX1x/oBNSBEFR4F9qg7R3AiH+q62wzC3ItIsHdauxUK1JY0TfeIr8cejlbU4bIh+izsxu
 VfVhjHTbmiULFDJ8R2X7N7uyp5XKYhWb934it7b4PYxmAQB6SPmTzA7jF0dG17atHE7sLtgBDTq
 mgg2IVvPjqJwW3HLBl98lSU3ms8gJyLtKikRCwaGOtnUoNt3MlZNkfB/4o779mf1Z3hs9iNTcp/
 g0rFjZouL26ux4xefrFN30dB4sPrlBfKlx9cyWQ8VO2PGPX9QD6P93ZSfj74TphWHEumSZ7Dpjf
 BwiqswDtfQpzcxxGCB7I=
X-Google-Smtp-Source: AGHT+IHPSpZWYl2bx/oroBrhAFamLpd0cRLvbkG4jo2E+AKZRssqsAN9faDe9fR9o8xffqik0T3JYw==
X-Received: by 2002:a05:622a:260f:b0:476:a2cf:705d with SMTP id
 d75a77b69052e-477083a57admr16106361cf.37.1742341376036; 
 Tue, 18 Mar 2025 16:42:56 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:42:55 -0700 (PDT)
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
Subject: [PATCH V3 07/10] board: beacon: imx8mn: Let clock system enable UART
 clock
Date: Tue, 18 Mar 2025 18:38:35 -0500
Message-ID: <20250318233849.587520-8-aford173@gmail.com>
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
the hard-coded clock enable.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 board/beacon/imx8mn/spl.c | 2 --
 1 file changed, 2 deletions(-)

V3:  No Change
V2:  No change

diff --git a/board/beacon/imx8mn/spl.c b/board/beacon/imx8mn/spl.c
index f03841e5a01..e91d3fdcf5e 100644
--- a/board/beacon/imx8mn/spl.c
+++ b/board/beacon/imx8mn/spl.c
@@ -111,8 +111,6 @@ int board_early_init_f(void)
 	/* Claiming pwm pins prevents LCD flicker during startup*/
 	imx_iomux_v3_setup_multiple_pads(pwm_pads, ARRAY_SIZE(pwm_pads));
 
-	init_uart_clk(1);
-
 	return 0;
 }
 
-- 
2.45.2

