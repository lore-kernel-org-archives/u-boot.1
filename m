Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA37CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF6CE60D94;
	Fri,  2 Oct 2026 14:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VO9GrbTYt2HM; Fri,  2 Oct 2026 14:01:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1653A60B56
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949703;
	b=hzgIzcF2Odk9wCvo+UzHzk9T5HgVnwBQjThGDxn4aIMCmzihDx+OEgWFxiKRdKf8Ffy/
	 zKFztpwUUX9+iS+sa4kmZGrPn0uqaXFrDem1W9kgovkz/8CYfIwo7rWIjd+RkgHjeJP91
	 HO1OwTWIEpCc10v8QLQ0jWr7ObJWlFX7VmBOq4wFEGtg8ChIcxrROibwisasdPjs6yQsF
	 2Om68DF+wmndsxcENWegzxXZ9lU+1Ww659K5UUT6TmDbscYWkIPJzOhhju5j3JmSFg4cm
	 ZqjEPNRgoYmt05Pww3qHFUqH/ULHYCWCmOWi8ezwxHmRcKv8ASKZ5geeCfnVrrcf+Tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949703;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IIsz8m9NtRhUdntyaADZUdrTakR1WFWenSKPNLDIkfs=;
	b=hmQank30r2I4SFwpRzIOTwMPy0W1QxoOliEixRfOhiCy5cSBqgURrlfwJfBlo3yMB/Fq
	 agmScLkJ5wsu5i+c/76+rB7OCTDFVtMNGpnY2gm+Wp8zN4D1UTebH5zXqcqoZ92+v3djh
	 kJ5ySpiHXbJ++fikD6bWO/g/dtVug3pNkF0roIMaVQQF7v4gWYvY9YZ/jEYvDWdk0wzQL
	 eI4rv0r7Tb0b5QYP6IdRMYLk9BLnWhmRy2aM6w2mnqG1UMeZfb5NH8kyMA5KO7frcXYzB
	 3n+FmpGgsKk7huCGA/zMapcBrblWow5yk5AutXxTHC4Y3OhOiS2dbW8TtKv4CzatwzA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949703;
	bh=IIsz8m9NtRhUdntyaADZUdrTakR1WFWenSKPNLDIkfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UXvrgjmnQRMnXOVEatfZzDDULYQc9ZPV01mWYmY2gP2+L2vvCbdcqZPO1DN3kg01Y
	 dnXzuZvuHCKZGv8O/czq+kobznAZwGpC1/CrNOKTODU34jbL5tKVoBbFPn4xhPH/LR
	 6TmHRXUR3zqRgSmd+sC9D8+veRUOh92mxuiQRhJsvsH45oEer5TJ4BmbOvgEg8CiQP
	 BNkYZR+7+vq0AosvH1nAmsx850h6NFU1EPDoMrxy1YOjebK1mH8gsfXNEqYOneGAdu
	 NGOdeOhVwrgMvCvrMnp57ohPQiapSosFrcG+JCuRH2/uvPl1vGrFKPvCL2gqNY8W9g
	 2GDa8dg0QdOLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1653A60B56;
	Fri,  2 Oct 2026 14:01:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B3B32E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D65940D95
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70to_vsjw98e for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 958D840D87
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::17"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949699;
 b=fQmrzc6IKicGt5M8Scx5YMsKc2Lzw66dFB3UmanoTVMBqUGSFRv9oLcskk6ms9T8cb3W
 o5l790EGMNqJPde9fOR/7/J/Rh1Y9i88vhP8oCZBRNLTvcEWhDGwJ8tz05hk7t82MrYqm
 rg/KAVyipXzu+UgZ+5I93chWfk6V/yP3puDq3akiPifbh1oZ7rB0Hojbtyvpy7ICP6KM4
 9u1tcntO2B5ozRiDfbCcGbcKzx+aA3cPQ4WUwvsXJ/5H0jBefCLraaj+rnjmn7llKOiAq
 94RVINJT7OwP1imUJZQBLokFitljTlKzqN6lCDtSgQOsmHaWvoQUGjNLnrCWObsw/lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949699;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=IIsz8m9NtRhUdntyaADZUdrTakR1WFWenSKPNLDIkfs=;
 b=bRF76lEgck2Hgu/pNna0v4jRYL90DqF8ty2Z2gZIz5a7xHxn2s0elHjUCAsnzzjIft1N
 WV2RXGtkpEX4UNXctUpOhBjIr2/qPBtT+nUldGKbUj6CMvcGHRa5YIit5JCTt6gIUMLOw
 j1X0FjeLPN5mnOMo6OGaW8uFYTOs+JmHHXcyGKwSTLm6LcynqZHfaZ7Jz8vheZg5r6TKp
 WaEA0t6CsGA5LV2TiB7l35nLguifZ6HjYNBDOn+/+Db8CY89WxIf2oQoNy3iBeYVOpYxQ
 /tZBzNCpxw9U8fqcYrx2xCAT0U7WG1UwlxnTVAU2lN/LgKjVSRMLMqUPJy6rEvABAjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MhaUu6zk; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::17"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::17; helo=mail-wr2-x17.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MhaUu6zk
Received: from mail-wr2-x17.google.com (mail-wr2-x17.google.com
 [IPv6:2a00:1450:4864:30::17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 958D840D87
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:38 +0000 (UTC)
Received: by mail-wr2-x17.google.com with SMTP id
 ffacd0b85a97d-48b0622cc90so1342434f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949696; x=1791554496;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IIsz8m9NtRhUdntyaADZUdrTakR1WFWenSKPNLDIkfs=;
 b=MhaUu6zkMWO8woHBw+bh+yx60AUvwMxF4MBE6deABCXaTeEfh/d+CH+Lw0ye1DV7xU
 IVhRq13VpvYuBm7iyCPswQ1O9GFj2MBN+76SOaD2L9PxCr3Ez3Yg5yRFjTdFD7MTj9QK
 kjAvVbdTm5gJlMuE65lQ85TqXUJnTrY2xuhwo+yyC6vZHX7sOR84y0tcN0Lkfk42YTI3
 rOXLE7z77OjqOUAY7R3HBIPCauqpY7Z65mz4P7GNhukFsnBi1bdfKazoQNRPRQCWUPVn
 s+2N25n69OssrK1oOJ0fZXEWQnuy6l0+mF8vEXEHdI4KP7MH25aKGef8pg0htTsNAPqb
 iRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949696; x=1791554496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IIsz8m9NtRhUdntyaADZUdrTakR1WFWenSKPNLDIkfs=;
 b=XyLq+OvLP/p7LpbGtdFvEP/oiSmZoh7GiaEd3Py0th+7ZFaAC3UGbj9jQSQMNbPLdX
 fsJuGEHb2zC2nplgLrJJYM2txKU4j7b7SY+1uHLakcIzseaRrKWWD0bDuYj01oWy7VUT
 6yYcDjWluxFk39oiyan5eC9D9P4pvrRBEUwe4j/aOxnbzAFf7lgEbAsVHpKAYxrzAWJH
 uTc7T8Zisz/ZMDhu3j+q7oyoAA1yztffbTe/r5a+UyoddeZxFarg3QPcTHS7AegzVetn
 kj8Z3YlsI9fLm0R0tcYQ28xPKmCruKr6OaK/y8wVmCcSclacEwNriBTeYGyRyUDUv+ec
 ujKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBywtsu9x5PCv0UnNRk6s9vsmTuKocuuwSoUMnB5B1zbXIBTXmYlNmQbVmgsRaZVNjp9mmVTwNo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJqYIsTQNvAgJzHDuEcyXtwxjT9NeBXQKhwBlIOCAKPK66+XVzW
 KH6OZrbLN5uObOJAIptPtocor8ikcWAFxs9Y/PfxckZKs1N9HUPN75DM8JdvdFAnsYc=
X-Gm-Gg: AYBFou24hFGYJ3nHGzV+ElzxkkqX7N4uXRLdbImVAsk7qirRW6zXOJ3Q8fkZV+c0PcZ
 RXf7gGPeW7HLlCUXpvQIsTnF8coYDs5aYcbkGa7HG9N237sFjgPWeJy/eMt86ZD0+wlj43ZqOoR
 8zV8g2bQN66AXM9SsrlgpVbhvAnQVZcziFBAkhSWIHVDN06l3Keye6LOvG9M6XtRCNo5N0RLlu7
 YH3CFoYnVVxCxO1x6iiuYuWl5Vqs1s+auBw0YQv/QYVeThc8kW7eXokYuaHx2/2ms+4QQ5rr39i
 LTSxiERt7nx3fLggO+rDEV02nPX+qiCTQxqfX6Bp/29nC8onSV+MUCdZAIZu6l2P5iVTZd8dKQW
 SKFLuYTMEFrM5eDyTSSRmCLJ4tsTspLb9DO8F9L5B2p4rmJTWkAAJN/kjRFB2TSUUFUCaht0K6P
 HgePX/6iCPlBF6d2yiFvXJceRs1ZKCflhPNWeVUeuE/Ya0/mdk0ufS5A5ZpwcrwJEsNacyR2Kqo
 1dMxqD0jv34U8cr2sI/WcpXajh2izhdgBSoczII5bhWxpgdro2NS175M9JFLx5sS++q/oQn+jGe
 gLpS+iS8RL9Bh3GV2ns5up+qcOgEXlrrwVPhBtN+rGINb9qXOJ8PpmC6
X-Received: by 2002:a05:6000:41cf:b0:487:62d:37dc with SMTP id
 ffacd0b85a97d-48b1273e37fmr4949645f8f.32.1790949696318; 
 Fri, 02 Oct 2026 07:01:36 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:04:03 +0200
Subject: [PATCH v2 12/13] configs: mediatek: mt8365_evk: enable dsi
 pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-12-9e435457b90c@baylibre.com>
References: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
In-Reply-To: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
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

Enable the configuration required for the DSI pipeline on Genio 350 EVK:
video, regulator fixed, dm_gpio, the MediaTek DSI driver, the PHY uclass
and the startek kd070fhfid015 panel which is the default display for the
Genio 350 EVK. That panel drives its reset and enable lines through
GPIOs only, so no backlight driver is needed.

Everything else the driver needs, the MIPI DSI PHY included, is selected
by CONFIG_VIDEO_MEDIATEK_DSI. The U-Boot logo is not enabled by a symbol
of its own: CONFIG_VIDEO_LOGO is "default y if !SPLASH_SCREEN", so
CONFIG_VIDEO=y already brings it in.

CONFIG_VIDEO also turns CONFIG_CONSOLE_MUX and CONFIG_CMD_CLS on by
default. Both are turned back off: the display is only there for the
boot logo, the console stays on the serial port.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8365_evk_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index cc01dcf434c..a608cdd75a1 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -5,6 +5,7 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_TEXT_BASE=0x4c000000
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8365-evk"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_TARGET_MT8365=y
@@ -21,15 +22,20 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
+CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_MT6357=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_VIDEO=y
+CONFIG_PANEL_STARTEK_KD070FHFID015=y
+CONFIG_VIDEO_MEDIATEK_DSI=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y

-- 
2.55.0

