Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCE4C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 117A66088D;
	Tue, 28 Jul 2026 12:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H2qYcjjHMtUL; Tue, 28 Jul 2026 12:30:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DCE5460896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241800;
	bh=gFWrGVg22ZPjyPDEPWBOf+8xKpqOh0UDmRU+CruAYZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zb2tobGO54bonji5GpBNOXK2R+7PVJ85s7jwWLPCtdKWginRoo4QLobbg58+jhF6w
	 RlDB41zSG+B1L6ckBUH5brzJKNkiEB7MapuKhGjsVjJ/De+RNEPl4wVi9EFqIMlVQH
	 kOXxRKWYBFrEmtlJW/HXNH2vFmELXwWATLoxbLqAPLXeXfHJPP7DNXTrJGGbll4uk9
	 iBAOWLii4aR5MvVMqtuA+YUjVUgzYvD3khxQEvP53MHHqy9Cac7NFxY9H6k6fYyjiM
	 ajDd0L8kAPfbiDGgl6KKhNsyr3m14BWmRAJLS95rsemREm0k6TvSgbz6nnnfix/U3G
	 VO3WAeooy5Xqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCE5460896;
	Tue, 28 Jul 2026 12:29:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B6A423F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D35F40314
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLcSHDN2pvwK for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0AAC24006B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AAC24006B
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0AAC24006B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:44 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so28215585e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241783; x=1785846583;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gFWrGVg22ZPjyPDEPWBOf+8xKpqOh0UDmRU+CruAYZ8=;
 b=TI27/oi65Hbg8Bazu8G+dKpIwcyauEYKUAc0g2GvCkDKazht30PuixQMuRdq3Qd8qS
 nbDgYXDs2qeolElnBLLoPLH1wz5vQUjUUBz5SuquJlTGUS3ZPm5N3QgjSaALFVcPKGzy
 lEQQ3ZJ1g0nc35AGWuWetDt7eK/dSZ273chbMmoXonwkwPFpRMF54cZtvmg3bFOCMM/R
 FTpOUe/hLSQ8O4tCifdWvI/bUSlAOc/6laU7f2lFEFYjfSfj9nxosd0jaqhM8R4wAQb5
 DOWeXfEactoxQH83nUdaZljFT7/dGHYeFxFF/fMg0V+WXCXa78Ac/6eNT9phXmHtfsKA
 GTwg==
X-Gm-Message-State: AOJu0YwAGPQMHZkNz9lNsVsmjqGQjTxHk7r/qMyRxgQ044AY0MRq7I/p
 J7vpupAB6v3UABdtjiXqgj1rrEBUSpWqpkIqHLWHdEtGA2MeqAnkXM/fPfx3QDBpeGs=
X-Gm-Gg: AR+sD13c9krP997zGbprw67bsKXGFCMI5Ai/G0xyOjfQahh/o24ByCN5MwYw11D/mqO
 C+OohxqmYVu6nIcGey808ScG7Vb7zqCiZ+NviX/srD4ohP/Jspb2VexJKXroFB+Gx3bU7FKRyqv
 KgYjvV5pPZpKqMyO3FjoCYrLr+ZLPXfBBUKtQ+1f0ayb0P5XNqQjAtxQ6wsiKRgrUeoWlHyGpK3
 8rXEhWWypKz5cuIvFdMhq5DoLnJyv8PPl+92Bu74v+rTslTXL96WOxrA96dSWBUfRJcPL16P+Rl
 +MivJJ/fD9SF31WGlmeegWc6qPANtclnCufuL7IIaTcwPjZ12N/W62Erhsox/ekwvr10SpNTuIB
 Kt2118+CsXFxScjQbIU9n03XJZpLYR+i/8tW/iiuKCJdtCJ9sYN8wy1akamAMmO4S7NKcR1GRQD
 2ha6EUgDZ4qEifzuSVS93T+8IB8Qh2tuR3vRmNjYHAwhDaPeCXcNq/gY617qQo69ArmtXkDCU08
 W1gBQI7HS8n3Xo/nJLAAzw+P6FmAWpOhy2GCThHVfhnIHUmWglo6tMWen/GEx0=
X-Received: by 2002:a05:600c:46cc:b0:492:68bc:3237 with SMTP id
 5b1f17b1804b1-496c6586337mr23955505e9.32.1785241782543; 
 Tue, 28 Jul 2026 05:29:42 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:42 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:45 +0200
Subject: [PATCH 13/13] configs: mediatek: mt8188: enable hdmi pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-13-ac54bd75f960@baylibre.com>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
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
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785241783; x=1785846583;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gFWrGVg22ZPjyPDEPWBOf+8xKpqOh0UDmRU+CruAYZ8=;
 b=BGUpgZjsX54Xq8qwhcm4N0BmoRFnY7ujnTi52rZSuQIoB12f7A2bVuHDdJciE7cN+g
 TA96//0egF+36RUdAZX/7wYXJU613rLB4LtgsLQCPE2KSlJSg77iJxorQEh1WoIHRG8A
 CtT5lpY00OA51fFwWmMBvuJSeuSyx/RzK8I+6iWiT0WSWqcGiXmjNdvj9HbVHc5FpdpI
 hQ3X/ZX3SsImWA4OWW2dgB/YVetipLPUsoRGpPSj73a/F/3TuRwhA5vcSGIpI6Ouc8f0
 6/mrqhNST/wG6YD3LnFrgR8w7ALCMMqWasVjT8433sQPbWl5NrAB4xpVrM4SuUOcJkHw
 SR7w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BGUpgZjs
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable the configuration required for the HDMI pipeline on MT8188
based boards such as the Genio 510 EVK (MT8370) and Genio 700 EVK
(MT8390): video, the MediaTek HDMI driver, DM I2C for the DDC bus,
the PHY uclass and splash screen support.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8188.config | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index 29e2b3db878..9d7cf13a191 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -9,13 +9,18 @@ CONFIG_TARGET_MT8188=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
+# CONFIG_EXPO is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_BMP=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
+CONFIG_DM_I2C=y
 CONFIG_MMC_MTK=y
+CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT8188=y
@@ -25,6 +30,13 @@ CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_VIDEO=y
+CONFIG_VIDEO_MEDIATEK_HDMI=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_SPLASH_SOURCE=y
+CONFIG_VIDEO_BMP_RLE8=y
+CONFIG_BMP_24BPP=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
 # CONFIG_RANDOM_UUID is not set

-- 
2.54.0

