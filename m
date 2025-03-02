Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A804C282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C928123D;
	Sun,  2 Mar 2025 17:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ds2rD+YP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A89810EA; Sun,  2 Mar 2025 17:53:58 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B1E811A7
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3ce868498d3so12022705ab.3
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934397; x=1741539197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lh6EZzVenEwH2I7NCyVltN4nA1m57eno6Xr1AUHPyyU=;
 b=ds2rD+YP0zQKBsPB8d0tFqoeB4zBZ1L3CqAl1Juo0X8Ptbk5sV9xbMySsF+jmakcHj
 qwWocynURkbi4BdXAwTPO87srrEFf/s0DVRY5hMj938n7zRfSi5YlrvBDMi9n4c4mg4Q
 3yAmmf1eX/9yGt1zsq2140Yr//23sF3Kk8mz3C+vb1RrUskH0i1Zh7//Zh25YDmDFA6K
 RCBN4/ywmv7u+uV0StNDhitEOET+BVBAdiXQX5MnV1TcUy0Y/NXVE1dnu/sJ8zoCaY8R
 uoJK9qfYQIR26yXHx9eh1JOXqf22ROgy78oeZGDLWqVfWVPH51mBpxM3Y3MWyrckx1ra
 dUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934397; x=1741539197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lh6EZzVenEwH2I7NCyVltN4nA1m57eno6Xr1AUHPyyU=;
 b=CFQ8f9SwIYasrMpDuMFGLhVNwOFZ6bYp9/ltZEdhkZ1qTfUi5n+LPY+Lc7PKJfonDJ
 e3DIDFeLQnPkkdoWIfde6+N2gLVNT4NhgE7GJtAuGzKC7VlRegZUGjcI5toHN7kXzNEt
 pTafQU/0mLYfug/omeHIcr+v0wGk/gCZrUsSDTPxF9hxouny6L2aSpfZ6fS487Ys1XNf
 648zYHx/iz+RC5IVdkpLj/VPTCkGOI/5k5Ek1OfwxjbnlKdp5EMOwssoUnU1ifuSPpGc
 vd03xX/IMkfCGDrlDpad/VHfqABeyWCOmZuhZSQ4Hd5sTtvkzdtIe/MY+7X1ffxFE6JY
 0Y5Q==
X-Gm-Message-State: AOJu0YyhJlxc2G1u/Q0beT8Xz4sJUMZq3g89KaouwR23Lz/vED4luPDK
 OATjsZFzE6VowSlW7h6s7DzFUnFpbU6ACuPxHFMX8kLZo57ufhsYi+OoYw==
X-Gm-Gg: ASbGncsGZc3lRIi1RWlAGEY4JxJFjF6k1EB906MOe7pjhw5jITIfoaMtQZrM/SDgmVR
 9tqnq+56aTJjD5+vVA4tXdGRz27aBk7TCuErPvEn8qvvcUMJqMWwznR/9fo1FZ5C2NnmWm951hK
 lRVvisijK9HRqscDZ4YdvnKHf8jrNlJApDE1liXYxc0WBrW1izZP2E4BMT0Rzbf94je6IAHG7lD
 irl7sqLz2ZdD4uVMpnwtkH4b39XyKD1NaaFp9pOPnicKF4hRaVf6jznb7QUT32kt252cPCRjk3w
 xSY1IdbG3r+EvVxqUDwJV4jc6hC+zsiLkTAsmgxxqRODiQzaXrL+XhLwtK0DzFw3X6F9ksm+Mzl
 HFcr+OgI0hzQppkFYhxM=
X-Google-Smtp-Source: AGHT+IFrtIJ+PydQq+f8XorF1ICEmj+MqksNa+p9Cbn/V4HR2DaV3Petjj1Nhy/mzFveNChRXknmOA==
X-Received: by 2002:a05:6e02:1fc9:b0:3d3:fbae:3978 with SMTP id
 e9e14a558f8ab-3d3fbae3ab5mr37947655ab.9.1740934397508; 
 Sun, 02 Mar 2025 08:53:17 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:53:16 -0800 (PST)
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
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 07/10] board: beacon: imx8mn: Let clock system enable UART
 clock
Date: Sun,  2 Mar 2025 10:52:34 -0600
Message-ID: <20250302165249.267992-8-aford173@gmail.com>
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
the hard-coded clock enable.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 board/beacon/imx8mn/spl.c | 2 --
 1 file changed, 2 deletions(-)

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

