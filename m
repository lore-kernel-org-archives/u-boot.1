Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51E9C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 01:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44CD81D5D;
	Mon,  7 Jul 2025 03:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iw+FG0ie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2264981D6A; Mon,  7 Jul 2025 03:18:39 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A6E810EB
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 03:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-55622414cf4so2504095e87.3
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 18:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751851116; x=1752455916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AwlsmMo/G5MuXiKW1brmJYZ3LQDH2duHvmlJEl1qmfE=;
 b=Iw+FG0ielm+6bJqmJ76ytoqP8PJScN/CCfD8acsX1/fHH0BOJPvDDPTsuWjFU50WUk
 ph5sH5VxjaRI8bqna8yl6IpvKFR8L8BDHX4+gnQdlWGrPAaMLGQ4AE2DRSQmowz/Jbvn
 OY4SbUV4mlRLK1n71aJXMhb4o9kyeKeudk1NnQiNFPYnlgbP13ofGEbpr51310K1qxux
 MkmmcdjxTQwzKgN8XYodEQVs4C87wt4nRwfyzHFoucNw3qTzUtAKvNDTQ3OS/ctifiKZ
 9IauR5H+FBzGeM3aqYmfXexwQSmYsZbSX4v6oroZGVTQeZ+0insmuGHm01YWB5fg54jl
 ivgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751851116; x=1752455916;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AwlsmMo/G5MuXiKW1brmJYZ3LQDH2duHvmlJEl1qmfE=;
 b=S+NVmEjIoVQFqrGQgWGlAFS+Zzt9EdQnyFh4Yjcn5zThIaKga1TqiLoYNfem4dazdV
 R/I0LyXgPM07T5h/iu8OM8AGyX9MTPEpwbKHtFwNzNEmBcFQGQ57AxrMO4j/PsoYn3cP
 bF0QT+5iZgk91nVPF3qepxPyO6Kk3YopIV8bUfD/vBfN8fz0boRQsro1pBm8lM0vUtlM
 8TJmEgO0/VW0t1tbLOXMW9SvrBXxOIAVy17//M+QPYQdt7QD3N6nbRIZFWSYtwjmSgy8
 xefB42OwFuzsjwEmhX42w5aSEOYI1wDEI6eKxdAwUScJV94o1iw5F4wnyWCCiPajTHdM
 GgVA==
X-Gm-Message-State: AOJu0YzdbMmZfR9bS77ikk/xeYjGgz0/i99ExUh4SkL8rc1ZoW276zBG
 /0T4rjn5ByjxoyobbdN0+KY6GQ/BTecPEQYl40ckHRjN727HcU0okSltKgvrdMAmOBR01h1LjQu
 EZA5o7hZHOMc7ZsldlSh7i3TNKneaiZAzbfsu
X-Gm-Gg: ASbGnctWKKynseAF1lKBRm25Jq/CcZ67H7uatkhBCY8f3vXsWJVTQv40b3PeGnwe6fu
 0+6kXGps4mEpmc90SySUsGjTII/HHFh16uohbWGErpX9fRJmT14agM4eQz/P2LZcqsgbwbDLqn+
 oRugFdek3wZfM/C5sNLRRRYyxYq9LVvezYhW34p3pFRGe0R6UURSr8uXU2Vg924cCLHPNLVsBDW
 4kTiCXSdjonnA==
X-Google-Smtp-Source: AGHT+IEB6aYbqA0ttmO36HgMqjs+YTzb4VXqQCpKGiSpsJ7wMif4w98w/XE4Pq50HcbYJtu/YbWwRH+2e26NyD3ENMs=
X-Received: by 2002:a05:6512:230a:b0:553:277b:17c8 with SMTP id
 2adb3069b0e04-557e559e67emr1804776e87.35.1751851115755; Sun, 06 Jul 2025
 18:18:35 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 6 Jul 2025 22:18:24 -0300
X-Gm-Features: Ac12FXwcB2dw2epHDDxxdXCdi8bQE643M-iw64CR6IpJ2JSapeDFNom11rHyDDU
Message-ID: <CAOMZO5Ag7CmRBhpvOB5btNvHiAMayBoxSYMoBJXbV3-w1ET7jA@mail.gmail.com>
Subject: i.MX6UL: Adding bootcount support
To: U-Boot-Denx <u-boot@lists.denx.de>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Schrempf Frieder <frieder.schrempf@kontron.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Heiko Schocher <hs@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I'm trying to enable bootcount support on the imx6ul-evk board like this:

--- a/configs/mx6ul_14x14_evk_defconfig
+++ b/configs/mx6ul_14x14_evk_defconfig
@@ -110,3 +110,8 @@ CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_SYS_BOOTCOUNT_ADDR=0x020B0068
+CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_SYS_BOOTCOUNT_MAGIC=0xB0C4000
+CONFIG_SYS_BOOTCOUNT_BE=y

However, the 'bootcount' variable does not increment after a 'reset' command:

=> print bootcount
bootcount=1

Has anyone managed to get bootcount working on it?MX6UL?

Thanks,

Fabio Estevam
