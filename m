Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6187C282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE39D812D8;
	Sun,  2 Mar 2025 17:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GhcOvAco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D801C81298; Sun,  2 Mar 2025 17:53:54 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD4A88058A
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d04932a36cso39306125ab.1
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934403; x=1741539203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgqtfvlKWvO4ktGmRbi4MMbwUNlM5ToeO40arJs/5ME=;
 b=GhcOvAcoIwxzBNzbRDRjo9iVtMu4eKslFCw2nnGzj2ZVOWOAynni0OSk5aPLaSukW8
 KabSKI/0OiYd8OwfBIc8kojhEAReoTtvOfBS2V/H33hZiklBWnH9Vmu4ar+lWZL/fNek
 sYbopVEuA9clyMDymaMi3DTUK6acnXeaabYOods2VGDS88ZyakVkN5yQBlk9JAZZyz5X
 Rd9ec/33DHEPw04UiQJaqzlYvFWI+hpxLNbhIsW0vZGZ2oEe7tvMjqc1/aK7L9pqvKe2
 6xJaFYleBgCD4oVZHJ0KKyY4Id7c0QsjyTOXvpIQjmkZ9NB82yp/B09Baoo9t42ymWxj
 d/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934403; x=1741539203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgqtfvlKWvO4ktGmRbi4MMbwUNlM5ToeO40arJs/5ME=;
 b=qIpxnIYLktK3DR0X77lI59ymL5AYHP47jEq2RuNdDNrA19GHGpXDnEslpr63ecOjZg
 emQSYwfi90AkAcPOlzn0MKjFfUh5mK+O3S6xPMAQtOnGZ7veDsXih7UOZERnRV7obbeY
 olltRMyNuK8Fn2HbtP0Ie0aGDODmIzuJvr1K3q2qrV7k1XkS1hMYCgW+JitUdQGgog1D
 pHncJDmBi1c5Dxnwyk1okcubW6Gsn47KcJbMxC0APeEeE2IuoeG1t86Y/ssku/BvC2pI
 wZ1IE+fiCqB3vtwyN0Tm7awuRubz0rO3kt1ssWS7ciPBVcDO0RTXdiSM2IoTe8Tzcz82
 HG3g==
X-Gm-Message-State: AOJu0YwSBqpQ2dtlUFEq3/XLwq7LUpHN+cCU/Hy/EYvLZKdKf2wGvE84
 ACoOUYYMq46bn+h3V3VBnIAbDbAu5yzwA+47ytE/5+UgWfRa9TlAVrUE4A==
X-Gm-Gg: ASbGncsFSblYlOrX3j8iHQlLLAscuSRqz3yfwE/2IboJ+jECBnzR8IpcFuQZ5SZ+Wy1
 a/HWXIaPG6vJ4Euq+2dmJDKZwAJ9Ho2ttG369eR+tzgZj64e5hookRe1OZbkuhf0lEUQE9VOY27
 K0hY6pet8YtrbHJHVFCqSJ9brePp+JH4wWd8U66B2wY6k7kRhMmfWFMt4cnpclGJkHDfa0JCnoi
 GKUs8nM7wfEO/JPQwIK+HLbODRSlV3SrnC/1kGdEDVS3OyO8AKPw2WfQWjIqr71mTKxzRiDthe2
 uwv55LiF4bqlhqZjTKO3b530jiFeIATZEYY7GF8NbbOzZktCnVXh7LMWHfpXblp5glLXodEKbt9
 cDqfAi0DsCpc2CDWXZAI=
X-Google-Smtp-Source: AGHT+IHDG7ngE0ne9nct2Gir1fwk+P0ZcBF5W/fgTKXmpaxcHDIevYQVT8wnzJqVILjpRHDiBT943A==
X-Received: by 2002:a05:6e02:2168:b0:3d3:d132:2ce8 with SMTP id
 e9e14a558f8ab-3d3e6e736ebmr103416595ab.9.1740934402864; 
 Sun, 02 Mar 2025 08:53:22 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:53:22 -0800 (PST)
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
Subject: [PATCH 09/10] configs: imx8mp_beacon: Select SPL_CLK_IMX8MP
Date: Sun,  2 Mar 2025 10:52:36 -0600
Message-ID: <20250302165249.267992-10-aford173@gmail.com>
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

In preparation to remove manual references for enabling some clocks,
enable SPL_CLK_IMX8MP which automatically enables SPL_CCF and
SPL_CLK_COMPOSITE_CCF which permit various drivers to activate
their respective clocks automatically.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 configs/imx8mp_beacon_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index f39e4f5dd28..9709f628f9c 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -86,6 +86,7 @@ CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
-- 
2.45.2

