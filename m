Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D82F013FA
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 21:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE1448423C;
	Mon, 16 Mar 2026 22:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k9cqW3xK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70FEA8422D; Mon, 16 Mar 2026 22:55:52 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4788D8414E
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 22:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40f1ffba6a0so3003804fac.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773698149; x=1774302949;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jiDPpvqRfGQbwA7xH/eLjfFPTUqjKarTJ5M0ShRh+g4=;
 b=k9cqW3xKNaSZeQzmKVopPguH3DHFz6T2dJrQTAK0tO3lZcfcxJxAv29XAHguzkTpo9
 +3bmrnU++X56lZ9uzQq79smO0jvI91D575ZKW1OgKc2ZQf8TY6ouCDzNaF/wFbrKVAqa
 mwj8uSDAcs9NjCsUYE3VkHsD5gfg3BURmiAEey4m3xvaUWaMBPKXAAzgU1r2Z7tGls07
 r3dDi8a9jAqHXn5x6iJeQvr1wShNXGYio204SackOZ1xnFmr5ace2Ak9pntr3ggExW5u
 a1GD2g2cEbXRxsLeHB1KxcjXnQ/0Z0t6WpYj0uskjp4BlVjxiHfC/Wh2oNM0atHGrQu9
 m3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773698149; x=1774302949;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jiDPpvqRfGQbwA7xH/eLjfFPTUqjKarTJ5M0ShRh+g4=;
 b=RgQxnm9wke2T68MXkfnmecNI7RdcU5tAO/PrOOFnSSnX3Ja9sZduKtKh7BfjCkfZ2I
 L1kQiNOvQeJc5e4aZQqDVgDNrqbnqit57/5Ltn7pGSnlKcc5v//JqelYxm4LC3+dfU+v
 no3KtAzzg/gdTnuaKO6QGzcQ15Dn7A7pLS4osb4B/siL4HCRHUbiiZaUijkZxxn2N0W6
 0wbwvJpZNlQDbVbbPNyBkyb7M6nyZ+kmNDiuKusQJ6zlX2HTm+/5kWe3wv+rbmgWYDTX
 twbJCwaOM2W5c+O23J12ZxiKFPUMwHUEgbJcXtuN4IMjrAl5D20+zgX/yMnOKnYudyw3
 MNxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGYxpDfuU4LY0bL5tqzqyjJ+5MPHoOhdKcNjMdorv9cOrQeZ5oNP4zGYYESpr2HhfL2MPZcao=@lists.denx.de
X-Gm-Message-State: AOJu0YxaIgVRPkMy7suph0Lu9p4pey+1Az1lxEsuKMkI4mn9S6pLw+qy
 WYxmKHPNtBsmvBMJIxWD++TlrcGlC/vXo8lWA9wpNualOjpS65gnpsA+oUKElOHSsEQ=
X-Gm-Gg: ATEYQzwvM0rVx5ID93yn6Iaw+i95aN90QISV5wpLpBiWDzi5O04w9Ao7K/N8L05VQhv
 t3FBjqpi25xzJ6uq614syVrhcTDV7BRMsBSlL8rMJ4/8fmG59gKaMnaBk5LIbRk18WUdSExbozh
 H1P5IlQc3zQUvvBQVVnGJfkqPGXcAnns2gZv90ws8eZEV7lCQmCHbyQb9gqULhEs2GrJs2FOWeL
 UKN/f8e0r6IM9Zpc0S1Drd4AT6OU4UTsmecRFwBqLF1Pev33bCccAk1o+5Zryi1W/Rx578hknDG
 mb1nghN2CR7BykZIK0o8lhg1ZpoUJWPHCtCOpSzka9Fsjg+FtfSLua5LX6V1Kkc7A5O84tmR5iQ
 u8lfmR8XvLx6ykssoTHT0tISckgn/ziZFOJuJ+8mFP5K0DAn72DoI7EjyFdJF78GnJ1xiX48rkR
 Tt4Kx1azpLOeAFcGg+aveH2h0CnO4=
X-Received: by 2002:a05:6870:ad0c:b0:3fa:aa1:5b1c with SMTP id
 586e51a60fabf-417b9399102mr9754769fac.30.1773698148914; 
 Mon, 16 Mar 2026 14:55:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6995:28aa:eeda:102])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41791432d87sm17978547fac.1.2026.03.16.14.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 14:55:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Mar 2026 16:55:16 -0500
Subject: [PATCH 3/3] configs: mt8189: enable GPIO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-mtk-ext-mmc-boot-v1-3-1aae51a44705@baylibre.com>
References: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
In-Reply-To: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=SM+Zfs3KwXnTf8HYY3IsVjIHrgQuQlWM27/gjjL/deU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpuHxbYnHUkVG/mpGk9QCKbbuxJ1ogKNOIU4GfX
 9fX6LbzfG2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabh8WxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ayq8H+wbpPsJIvYEZ7xYkQ6+3981Nud0Db0wLxQskoCp
 DcZQowlxRH5e09V/H78j8oaKefJo4kWS0ZLVL53sKIsL72oieKiQkPb+S5i7jVeOP8sKjWzJ3y2
 kdinoaQrXOUxhJgXnvZyFR8EoqZJDe99ry7wiSsvp5EsDAwNsAOtM9blGeHdVIG4wQR96GqQuYP
 WHxgULmS+4ENOTVoCniIHPB288H+3vOg3vkfQkM0dzlPdEIQavPofNvxj8uiPnQySRbCUrEGA+A
 qj58E2EqNqAnTH22Bw5Dnvfmrx5hshgaG+3+vGrC/hPfZYfS4o8VznQ0I5DwxB8fOxtklkA2kHX
 +m8E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Enable GPIO support for mt8189-based boards. This is needed for U-Boot
to be able to use the SD card slot on the board (for the CD pin).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 966d05d1a03..0c158cd9430 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -5,6 +5,7 @@ CONFIG_ARCH_MEDIATEK=y
 CONFIG_TEXT_BASE=0x4c000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_GPIO=y
 CONFIG_TARGET_MT8189=y
 CONFIG_MTK_MEM_MAP_DDR_SIZE=0x200000000
 CONFIG_SYS_LOAD_ADDR=0x4c000000
@@ -12,6 +13,7 @@ CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PMIC=y

-- 
2.43.0

