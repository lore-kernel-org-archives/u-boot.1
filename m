Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CFFF428C0
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88D3C84178;
	Wed, 15 Apr 2026 20:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kaLzat8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36452841CD; Wed, 15 Apr 2026 20:39:52 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FDC8407D
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so49960695e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776278389; x=1776883189;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aGwirzM4VrV18gToNHF6IkhRWOX8zDPJeVApjl+Zv70=;
 b=kaLzat8DPV9d31W4yNBvPsU/UpGizf41olKRrXeXfR1JH9eadRhkb2NJHadItV6A40
 x6hAtwhfJhTfeOQf+zTZgKMMpGDzmz2uoPpn3Q6IPhuhrX5m4X0dQ5sMN+1DNwb95bNz
 9C+YZO8dsvNhjBpy9JtDQS8NjizTi5ddOAUCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776278389; x=1776883189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGwirzM4VrV18gToNHF6IkhRWOX8zDPJeVApjl+Zv70=;
 b=cmXNJTVyavY8TdLg3bRxk/hW80Y/Uk2+kTY/VBpZwLplZBuxSXRODdkyD2JabWDzgA
 NzEU77FZnWTwuHrpBKr3YgrEri/IE9hoHmqYIQXEXYZVfttYQRhL9p7oVxXjj4cDC3wr
 e8TwcBJKyGKfXpyA3ZIja2WsxAhr2wf7DMx7LUjDoZZ9aNoA/f05dgX9kvtvG3yjlzlm
 C+BwkPheL3mca8HPIEHSoaxl/Y/wfud7y6ASZJRMcyRqxUllXPPU93cGmMOlpTrvIjG5
 kKHYC3VUCYGwJrNqprJLexgDQQ7yzzP6DJC29JFvIbr/X3GDIv6lkhcv0DFFVanaQm6q
 Qp1A==
X-Gm-Message-State: AOJu0Yxg5ZWJZ2M6UbHIVBOf+ssqTCcjrHXO8/NxrRSzzUh0ST1huV9u
 f9jprBA3EltSk6EtFnhTrSpldTEcP6tgnx7kxu5pHAbvi5lUeeBZLo1AxyW00aUzZXRTMW0egjA
 sgJly
X-Gm-Gg: AeBDietZx4u6abSLvuqA4uJwg/lXV7eAHo3nTENYJBZz6GJrX2KS5Xh7h2Mp+HzwdpL
 mklZsoQFcRR4siGLT97KuFoJFGaIENnhUQA9dtqlusw98z3Ony65Nsiv3xv5MVz7J6EMHKfGbVM
 uXqkA1rpwU5HBlCkGYmTlpV9NxV9zmPlqbcyNWew9t3VvPovtWdIekGEzN1SmBb9HuwdRcOEZuJ
 dmWRRVEK168sXbNd8haN4dr4f0QR17tUf7QLdsmIiNZK0WLiTive2/HxSqWh6mUWxySMi3w2NEV
 1h00i5lYSqMPpP8q90gFcv4UwwWLsVRhWcl4hs4qu3P0P8lscCca1DasZnSwkFEVNzso0PuYou+
 02JT5Jo3T7x5e4fHvusqRczAlTD+TqI0Ai0MhHM4pZtLwoOZYOGp8cix+5up2quHiP6IJ6a581o
 wn4LrnDT1cCC3dbOlKvm41rONtqFrK1fcS4CmeTElh/nYDWIeLwzqehlOSQBhpMI6J+vPrlcjD9
 4tfJOUqTmZhzKorUCxAxNwtQNwJs5+IJYKLhNqfon5XB4bM7HiRaYFSjg==
X-Received: by 2002:a05:600c:3f19:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-488d67bbc2amr297163155e9.1.1776278388618; 
 Wed, 15 Apr 2026 11:39:48 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ecde5b26sm169445735e9.2.2026.04.15.11.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:39:47 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Simon Glass <simon.glass@canonical.com>
Subject: [PATCH v2] video: Kconfig: fix indentation of help text
Date: Wed, 15 Apr 2026 20:39:35 +0200
Message-ID: <20260415183942.3032406-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

Fix the indentation of the help text for VIDEO_LCD_NOVATEK_NT35510 and
VIDEO_LCD_ORISETECH_OTM8009A to align with the standard Kconfig format.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

---

Changes in v2:
- Review-by tag of Tom Rini and Svyatoslav Ryhel

 drivers/video/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 08c9b0207884..8ce660804072 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -566,15 +566,15 @@ config VIDEO_LCD_NOVATEK_NT35510
 	bool "Novatek NT35510 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Novatek nt35510
-	dsi panel.
+	  Say Y here if you want to enable support for Novatek nt35510
+	  dsi panel.
 
 config VIDEO_LCD_ORISETECH_OTM8009A
 	bool "OTM8009A DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Orise Technology
-	otm8009a 480x800 dsi 2dl panel.
+	  Say Y here if you want to enable support for Orise Technology
+	  otm8009a 480x800 dsi 2dl panel.
 
 config VIDEO_LCD_LG_LD070WX3
 	bool "LD070WX3 DSI LCD panel support"
-- 
2.43.0

base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
branch: video-kconfig-help-text
