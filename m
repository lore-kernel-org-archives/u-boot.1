Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34360D711CD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C75983869;
	Fri, 19 Dec 2025 00:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kxaZuT2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE8118309A; Fri, 19 Dec 2025 00:24:38 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314FB83642
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-455a461ab6eso448281b6e.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766100275; x=1766705075;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6X5EF8o/UNYyI1PS6XhPmq7/Jf16/3A9Fz/zXEwAxm8=;
 b=kxaZuT2HT3NHSGbw8W4vOan7WLIjc5YIllmg2nVJWlC8Et4bL2h1ZpvfXP1v3JyaeN
 jBL0vdIYGTgk4wz0gEXzq+FR48D4q3lk9loKQTEfxJimtlREbMnlm718bSC1sgFy85ia
 ELAcLPLA940fLGN6bTPY7BW0kIkm4H4LO+jHVlMNaz8WMTrs4lcm4JATcxPxk2z+RMCU
 TN/7l8VAWtDQhCz4rSAjtbKlI5Vd0XCz8bK0zzK6yDxz1j4jZR5Zv6dOsJ1S0LcR7722
 6NiZc69TFTzajsG35qSp4EwlDan9Zb1Kt/+nKfQygj9LQepkrfhBoZG4nLEQlDS/yQUZ
 e5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100275; x=1766705075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6X5EF8o/UNYyI1PS6XhPmq7/Jf16/3A9Fz/zXEwAxm8=;
 b=PcQXQlO6t3E3j5N5TVK3KhIwkAxY0G10lhMP0Kg59bDzUmTiRbFothVEHYq2Vgo+cU
 c6ARY/cIgm5uUBilCQecWaIMma9vgzNuUI/TdGH1hubL0MJZgetX6fjte9CM4HN1oC4s
 JteMRM4DABn0O5RWYrhLLX86NCEHLQk4q1PqW3MtmEt1fB03X4+2q5yuxHtFtiB95Q5F
 Vio0xvoyRzswo9GcFT0IOf3n5qxq0hA6HBVytUpFAAFqNCMYvW3HWGLNb+/MNhlvgrnC
 3wnW5VxinUQw9i20Scnw/SC7tSPecI/TV8omcchXJ9cRHmT1M/9IFreGYZRpWCfx4aZG
 1WgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWglb8KYKqVfWUWv3NChSTuTInId2g3iZxsf4vdckVT5dGCHgIBhxMNjK3EElCqdWmOZtPTXn4=@lists.denx.de
X-Gm-Message-State: AOJu0YzBAefjnqCQuEFdDs/6p52mGNBax9m9bSLdJQ5eoOpkKlTvmt39
 jxHsHQwjKcfNI9FH052YI9mSl7oPz6Laz5661KWCSNs/uOybbNCcpYk2cpN4ZcWnNGY=
X-Gm-Gg: AY/fxX7Zk19M9/ayJZk7VIvOs/ex3EN2aK50bZjC3LXqHZ6l7PDEGW/nxcDPe0uuhZs
 WTVyzRi8r4QVE2P2UB/bscoxD6etHYF1jY3T5qF7EbiaDCGfgG1px3rVF1Yu8FQ8rULjYsa6VHy
 qsI5Bl/7eNmfrrmflt5f5jeW2aCLkyd93oynXGAWwEvQ+7uqdsTcievkaB2H2OjLAP19BuKqc13
 dgKCZ0IYthb8oKxujnNpRtF7PYKQmPrJl7HW44Nfp0YAm5h4CQdgt3IyAqGx9f1fKsyW2yXcjvU
 ILQbOfWfIewSoh/OuHTkM0tF3hI7r3KiqA/JmmWG+VPDiydpOlHM5LHVQK/oHOktFx15LVduqvZ
 UFjB3SlDf5u2LlFngBNsGPjHXSzhS6ria9J7hd4OrBaVT+acohVRTJM3ZPnLswTUKbH6F+MrQVg
 MkyvEUWmURTK7XtfY=
X-Google-Smtp-Source: AGHT+IEbe7qpz7MABi0vLhrDupqDQCcRmI6Z4SVhLrocNrpoOdeF8tb7TuJUp25H9E8sRGBz9JQVFQ==
X-Received: by 2002:a05:6808:2229:b0:450:4782:2b57 with SMTP id
 5614622812f47-457b1ee21fcmr537572b6e.18.1766100274910; 
 Thu, 18 Dec 2025 15:24:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:67e5:27b0:56a0:f05d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be228asm300334b6e.9.2025.12.18.15.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:24:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 17:23:21 -0600
Subject: [PATCH 1/9] mt8365_evk_defconfig: enable clk command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-mt8365-fixes-v1-1-4f8ff0de3268@baylibre.com>
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
In-Reply-To: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=692; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=C/cVHGc5jpknb8qD97FkcrdzQP0jQDNT9+bwH8lKdGQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRIz1HuUUzmojMh6y5vu8gJ3sTsowT2mdbetcp
 b5QxJK94HOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUSM9RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AddwH/2joMYy8wF/rlmiKusjn0A7vvxeNPGLDJQzY6tE
 wy2uzHDbQg92XriKPImpFGnZGxW1CZ/LOxCVUv6cwlSngqR/9N2FrT82+RXE08Ll3RuW20LG0RE
 Fw0g2+raiYmfTtVZffjKAiZWhlUHTVpb+KeMkbitEZB6n/w5sZuQZKaZyVLH/oXXzAySVJVoB+A
 56zTnLYDhcUCIqfFs7qFuN9Pryn9svcvDgqTemAxoqKUtcGaQ8C7W+/OKBHZYa+eHKDxi0LpQPJ
 EMw1KVLhGo54wupa6aBiI48FNdL+YcCf9HMeKdMVBdEsUKHXQtnhUyyWfrnwOI4P8vqYC+KhfEe
 9XMY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 19 Dec 2025 00:28:35 +0100
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

Enable CONFIG_CMD_CLK in the mt8365_evk_defconfig to allow using the
clk dump command for debugging clock configurations.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8365_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index 7b411453e00..a9f7a24bcba 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -11,6 +11,7 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_IDENT_STRING=" mt8365-evk"
 CONFIG_DEFAULT_FDT_FILE="mt8365-evk"
 # CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y

-- 
2.43.0

