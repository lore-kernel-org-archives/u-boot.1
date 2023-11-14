Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ED0C54E7C
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 20:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 055318719F;
	Tue, 14 Nov 2023 21:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="lxGMucmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21E08718E; Tue, 14 Nov 2023 21:34:29 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A7D8719F
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 21:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso50148165e9.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 12:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699994064; x=1700598864;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRiLHlIuXNO8mkqDbjccT03gMX7eZqrZUL7Ew+/MiCc=;
 b=lxGMucmvGUenuuKVmnOIS1y5gr5c/VYWLM5mrYnSp9VWnFFqdUbsAJ9uHoX6KGjppJ
 l/gCuahGYZM63xuvZbwCiP7s8Hj4gdTJ9jxhqqUPvgPSyXQ2XrjZ/5qesLEl/9seV4qm
 CCO9ndWaibm774/WBruZK/ELKEVr/ch4Thxl9H7GQlE9P4yg38FIL2DM0yv2ahLk3C35
 HvApk0QQG1Awh83Y0sbiojNkAuzuA3qhS5xIjp6WFpLj3hm5h4JwJCV98wmHg1GFF0r3
 HGbwl56P+PnFNF4PkL7R5VqZjdKGrIKa6JJgZ74bHzzT00+LWlHvTzWo//XmdiuyQXm/
 phjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699994064; x=1700598864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRiLHlIuXNO8mkqDbjccT03gMX7eZqrZUL7Ew+/MiCc=;
 b=qf0sowJb6GcesQr7ocQ8hDFd7jSeBFXqi/zbvyj4pW5uviuewyzA9bywrg5G+aBh06
 vnQ+nYnUWKLviepvJ3xk1gsGk3VWeRKOuK331HY+y2iMW6HavLJ+dmf0oRVKUSzQOTsr
 +StrL7TZcKwU/Ojm+Jup+6nntaKA1S8HULXUM0jgLXy3DMeZNU+fceXLK08KGWIn5foP
 hbTZ/aN4RYtVOC0EakfRvIaIq1+3T+F4mJxvN4VywkrEfwbG9MJ1P+jP4AmgCiJx7GIz
 EzEPFGNexDDJnjAHyyRjiDN/A1QImtvxfimretx5q7dZ5hqsAO9q22zZlVGeFn5H7ZD8
 hKfg==
X-Gm-Message-State: AOJu0Yy+789G/skfTTSIEQi20dHOEimiFwiMv1qvOn9QcaabnasZftVm
 cDzMtUIV+o5j+eCbOZZ6UY87dw==
X-Google-Smtp-Source: AGHT+IHw5VIo5EvHw5Mv5jWKefA+Ji3FLC9rkmfI8Q3ea2yaMH3gfWAGq36FQJnyvthbx/3R4N7bZg==
X-Received: by 2002:a05:6000:bc2:b0:31f:a0ab:26b5 with SMTP id
 dm2-20020a0560000bc200b0031fa0ab26b5mr7495833wrb.8.1699994063549; 
 Tue, 14 Nov 2023 12:34:23 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 q12-20020a05600000cc00b0032db4e660d9sm8659691wrx.56.2023.11.14.12.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 12:34:23 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: jonas@kwiboo.se
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, Shantur Rathore <i@shantur.com>
Subject: [PATCH v2] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip SoCs
Date: Tue, 14 Nov 2023 20:33:09 +0000
Message-Id: <20231114203309.852289-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CABEcMwWNxzvkkC6-OwUx7AedhctfT00fM-ubXVf9ec1RoMmgOQ@mail.gmail.com>
References: <CABEcMwWNxzvkkC6-OwUx7AedhctfT00fM-ubXVf9ec1RoMmgOQ@mail.gmail.com>
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

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c98..fca6ef6d7e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
 	imply CMD_DM
 	imply DEBUG_UART_BOARD_INIT
 	imply BOOTSTD_DEFAULTS
+	imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
 	imply FAT_WRITE
 	imply SARADC_ROCKCHIP
 	imply SPL_SYSRESET
-- 
2.40.1

