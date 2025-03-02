Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA54C282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF0C811B3;
	Sun,  2 Mar 2025 17:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kKpLYA9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18EF7811A7; Sun,  2 Mar 2025 17:53:52 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE7E980017
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d2a8c2467eso13870155ab.3
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934400; x=1741539200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAJ7KCFBjC4aNeP52U7QWpauIQvAoxuxQaAKurp/GSI=;
 b=kKpLYA9duzIyLrcHXS24Md5p6HFAgvMZgDjaM/qeGX0cd4XFbWaR5pFu3fwYEA11pi
 Dktu9//UjcwO78csNnJlJo+1xFr67lzYm68zDZd+56fHIks4q1/t+nkTvzd1fnrL7kgS
 crM0nHCdS8xeXH9WdmOxg3AnIcV/ZD7156wRNzm0sjzi93iWpY+AtNopL7UCERBbr6n+
 F4HRnsJg8z3x0xEF4Ai/uHn/iUpcL8E0kf6K1A/sDsWJ9YSxtSEhKj9zaphqy4EuDhr1
 V4sALdtyzTVPElFrRFbXCgsYKU8UWs7jMpxZCVr9uGaDlbCNlFvn6ieHdX+SnZjUJNty
 g3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934400; x=1741539200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DAJ7KCFBjC4aNeP52U7QWpauIQvAoxuxQaAKurp/GSI=;
 b=AsEglxN8RvCecb5ApozioJcfTpjhCg/u3PQEUWQeeLE3KOf9HeEkx7KjJ2wrzLmgG6
 Y2JahS6Ls+ZstiBeCFplYYWUgLcsClkb0gHCdIdtfObLf4GOSNw9PtR1M8ooeaGkbFpR
 jPl4HQQjFSIt5GtGQABenYbmndJcjVduA33d8JD4nom09HMv/qSDhUJwrJKOlC2kG6Qj
 l72XzLos3aOZWTGTJ4s3hz7RSUpYjiQzu9IRmdswh+2oQwisrV67H8W0vZUJXx1d8e0b
 mNnqXkIjBQdDblZa4C2z1n7ZW8oma1VzSa/Ak48vNr0emwvAbT1u17/aFGSQBWgmcfKI
 zkRA==
X-Gm-Message-State: AOJu0YwrX1dpLcj0I37EuHRNzY/ekH8QU7YH0BM1nAzTN949/I1cc9sE
 LPOPM38HbyTrp9mnK0X/C/ce9SP94WwOwnZ581W8omojz+RSbLohjoxy4w==
X-Gm-Gg: ASbGncvE+38Lct/wYxVEj9tweuKfMkDkfLu0lcey6tkcRGM2sYZ/zehLyZ/sLS8B4dA
 dbAxtWcXL5tV6ekLNnM9q0agE93qb7CLkdHmhRwlL7tzgpOYcAWWcu/Xh+a9zAMa/euT9JYbxhK
 YE8DxLFPrrpluc1b4H2iWT/Ix18HutZD9MvLNUJbXjyfIOAxMpMtF3G93e+ZHTBhbNmX0umLHxu
 ErU/5Vy1RbiMe6+TOUA0J7WXBx9DCNsGJBudoYATNhbCMsNsoOnz72gRlp1m2QnF39URY8VjHjq
 fcEFalx2jkzWA+0shmuWwB47ICFwKPdKLpOd0c9x+9dzH87jcSWHlQmP4g9DhL8wLm0YpEMh/Gg
 vcCNrgRMKh3r3igfd7t8=
X-Google-Smtp-Source: AGHT+IHGaljanYFTJUpCBaHCLApa3pQF0pcl39wywFvokG0kkTbshOws360UOPe/saq/gOjyeR6+8w==
X-Received: by 2002:a05:6e02:19ca:b0:3d1:79ec:bef2 with SMTP id
 e9e14a558f8ab-3d3e6e73d90mr79574065ab.6.1740934400067; 
 Sun, 02 Mar 2025 08:53:20 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:53:19 -0800 (PST)
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
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 08/10] clk: imx: select SPL_CLK_COMPOSITE_CCF when
 SPL_CLK_IMX8MP
Date: Sun,  2 Mar 2025 10:52:35 -0600
Message-ID: <20250302165249.267992-9-aford173@gmail.com>
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

If SPL_CLK_IMX8MP is selected alone, it causes a build error.
The clock composite is required when using the clock framework, so
select it when SPL_CLK_IMX8MP is enabled.  This is already being
done outside of SPL.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/clk/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 56d893e0579..d17a54fb9b3 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -60,6 +60,7 @@ config SPL_CLK_IMX8MP
 	depends on ARCH_IMX8M && SPL
 	select SPL_CLK
 	select SPL_CLK_CCF
+	select SPL_CLK_COMPOSITE_CCF
 	help
 	  This enables SPL DM/DTS support for clock driver in i.MX8MP
 
-- 
2.45.2

