Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B551C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDA23407A3;
	Tue,  1 Sep 2026 14:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K-p8dXf0FiWE; Tue,  1 Sep 2026 14:39:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273551;
	bh=JwEM9586+QKefbYqEXNHlJpXtGJCiG5N5l/z8T8BrpM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L+FqcpYfCnHhR8S3cCVazocsQJMxvZDZioYRKx79KKW/1OLlNvLZYkeF6OopRABUO
	 WMB3TP6mnfLwvrVkH8J0JhaHH5GW8IEnX5oY4kUhjpkOXzhoRKXmD6bFJgQ9tahvFC
	 aKQ9KqdGJ3QQM7RTOmdsYE4fZjnQBCG0BtDE1GlXL9DP/TNQe//W5nZpEeTJq5yyc4
	 JjdgqZfpbohXdejeQ5TlKUwC7GznW7dCmHzl5vC+6Oi0QCl8ChEONcX5eIR/v9sbeP
	 kgMlsvErFLbHVvMFTBjhAkf5yptPv05pqrBueQxGrfM4wNBNRFKtH88U6A2bXkNgCW
	 dwui4TVtRP5zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAE48407A0;
	Tue,  1 Sep 2026 14:39:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 23AFC2FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A439401CE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:39:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 55eGiFPd25UQ for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:39:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cwtlsQNp
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20618401CA
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:39:01 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so10883385e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273540; x=1788878340;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JwEM9586+QKefbYqEXNHlJpXtGJCiG5N5l/z8T8BrpM=;
 b=cwtlsQNpjszg3BF7AC2sTF2KHHhArn1Rrl0N4QZOftJJ1vGrA26EfdEJ11iLDulJLP
 3C9Rs2ykuExcsPkJ2ZHsOjhBKIB7ecGl3grk7UA6HbmEL8M8jDapA6didoVwQTcOfgkF
 NcCA8N9F0+r2ghtCgEK0owMiNfl81G3BfO+qR8+Q0GFpSwwJK+B6thz6Obdm2EVSNt5T
 9gw4GJIGXwmNFNks8ISkipX7r9P5D63JiqCMAnymgZi9oQc9A/h38LsdI23GqTUSDowd
 JjbAMK2sNarON6x1wO7TknWjI2gqh9E1rJ3qGn/D+xO+WtM3fMIxaMmH5La13E13G7B4
 hwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273540; x=1788878340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JwEM9586+QKefbYqEXNHlJpXtGJCiG5N5l/z8T8BrpM=;
 b=AmwxVIfC2f4s3aYTeEurRPVu8g1aRLGIctSei4c824ilQnEdPmZtDya+0BATXG9Nh9
 lmrZIjnHW7Wm1x0Nj539uYYhttSujw0z3p27YVJCYEfKgWCK48T+YYOaJ71gP65DZZ9S
 rYcFtwEJcuZhWtmT+sKjOhVi8V4sOzh5sLS8Gm8AAhqyHi5tB8IIkXzoFdP5P0zc6vgq
 KOzrYpHU3rqOWhEC1jckTj2MMDHl5D7bLWveAUOnF68mtLGxDKdVRlDI77GU4KmctNmS
 y3nZRZIzC1IdjLmAfiKbZtYs3XiMyFrVecmJAmjsTlKZvtYUBWSEGjANA9D7dqxJcW+a
 Pv9g==
X-Gm-Message-State: AFuF++kP8IE8hEaC64eho+yNH70Og0QFpaH7rUfYTAyfLeIcgMDpDfg+
 H90qQyKJj/4sIIt7AoxJmdE8VRGemXHl7YCcDCEg+ynVutjTBy8stnminQE0L1zcGeQ=
X-Gm-Gg: AR+sD10CpBCk3xbN2QrzfYgO5e7gvfqFsl3a7PqXYIFquDRwu+1LC+o21TuzVBczezf
 3/cPPL8Lc/fk1Ab7SLXwCpv6I8NcVSEgbYThivCmSS3Dp7Net9TxGKA0Jj2mE5hN2TRXSF+n3qg
 nq2RfLvwDc2ofU2GSZDJIW9i40WT1y1yvJe1q61rUh5m43QrCMUc/mmIWVSoq5W3l/QeF4hPnjC
 JkyIblNg5GEZszjg7hdS4ZMyWi4Xv0QBu8Bo88O8bxgH80d+osAoAnf0SmfR/JUV04ZZ3Lc1VEx
 W2oFcJsfvepdAmhhr2yiGSe+MAC0JAKXNI/+5yPVV8ApKH+d8+Xnbb3bKS/SmkmIfh+XSRWBqEt
 QdX2K9j8YwAddMJdkRDDARVXhnIXWJM88uL2V+eQMpDz98QqhYOYPwfgY+MeP25cwt7cm77xS8Y
 P4lpMEqwAugmUR46mma1pK+uE0bLJ5vC6njFu2ys7Y95v8bZYkbKdB4R+VOfTPO7dHqprrTHBnV
 vTsJ4V1GUBJLwmrv9NFIjIGJuvipSTvnfF7q6+PeiVZBINHPq3F0cJWiJ8wiErURo9ddUmXqkQV
 3bzxuOaqlgPWpzVFDAffSHziZNrKIBoxGAL9bFhyTt8F
X-Received: by 2002:a05:600c:4688:b0:499:78b3:7b36 with SMTP id
 5b1f17b1804b1-49b91c4fa79mr457980775e9.11.1788273539830; 
 Tue, 01 Sep 2026 07:38:59 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:59 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:39:00 +0200
Subject: [PATCH v3 14/14] configs: mediatek: mt8188: enable hdmi pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-14-38194a531b9f@baylibre.com>
References: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
In-Reply-To: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable the configuration required for the HDMI pipeline on MT8188
based boards such as the Genio 510 EVK (MT8370) and Genio 700 EVK
(MT8390): video, the MediaTek HDMI driver, DM I2C for the DDC bus,
the PHY uclass and the U-Boot logo.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8188.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index c6785476d9a..4e7d9ee142f 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -12,10 +12,13 @@ CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
+CONFIG_DM_I2C=y
 CONFIG_MMC_MTK=y
+CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT8188_POWER_DOMAIN=y
@@ -23,6 +26,9 @@ CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_VIDEO=y
+CONFIG_VIDEO_MEDIATEK_HDMI=y
+CONFIG_VIDEO_LOGO=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
 # CONFIG_RANDOM_UUID is not set

-- 
2.55.0

