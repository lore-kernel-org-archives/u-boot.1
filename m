Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DF7C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4DB680D63;
	Wed, 26 Aug 2026 13:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQ078xxBnC4x; Wed, 26 Aug 2026 13:09:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749799;
	bh=gFWrGVg22ZPjyPDEPWBOf+8xKpqOh0UDmRU+CruAYZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JX6+E1ZP9CzKCroiDBBJ/v2zXYqJNKmFzKdOM2UYqQwjxGUSJr3eYy2Dw0EAmrIc6
	 KO/ECvcuBvL1ZjxzISFf97miIl8PDVbDOd5HRRN837D7Vbz9yaMPj2hIQue8/BI0N3
	 kBBZVE1nFJZ0VwvtAK5XqDqSY/rEU4RNnQbU3C88t9uzgSGMBTrFcBNOG9w7gYeA60
	 /AcCnABcAvaWczIjd4qcdXImIJx8orQKh9l1UA33Dlmj36cbNnD0Me76iDht6aSzh4
	 21WbFlr8LDoxjaP5TULP+aSj3YAGVUOUeVDtXgljp/24uyJj4PcwO8wRWUzzcxnLjQ
	 5FIV3nxeQP16w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AFC680CA7;
	Wed, 26 Aug 2026 13:09:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D64A53C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD12C406FD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0VLDRFdpdBQp for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JgLYqIou
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 893C2406C5
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:50 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47fecbb7000so405257f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749789; x=1788354589;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gFWrGVg22ZPjyPDEPWBOf+8xKpqOh0UDmRU+CruAYZ8=;
 b=JgLYqIouIl/nf1C3Zro8X9eFL7pUUsOP+JiLV8YdS3el3EjMCx68x3ShfP6H2pKuBb
 0Ve2OFCWtwpoPKhfUxlt5kXsfY8SZSBxmM5Nq2AZQGADFoySOk7/v/+bbs04cs6PPoD2
 Zs6n6LhejuutCIIGb80ZCOP0h9QR8iXNFSaIuHaiG74tLX9e8LZc5rhTcRfrPvBhh0Z0
 43aKnAMpcA0uAKDFSl+ptGsCoX5wUhnnOhEMMAaCjF06zKhqR1cp/ZJi2o1QlIAp8oJl
 llQmgJ9piASj/3OlnqJN9FW4Hsek8Dadbk+ceOeZXiFFqHUsEVaiPSZejLo6BwF2sqyA
 pxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749789; x=1788354589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gFWrGVg22ZPjyPDEPWBOf+8xKpqOh0UDmRU+CruAYZ8=;
 b=sib/cz1gp3trs44sroo0PBOppiutTvbGEnn4QRbbafSxjuVq/1Q0JxtsmhguW1p09k
 RAEGTK44FteZKqiwoFm2yiqjerVAyRPeDmEiJVrY4p4vHzROzJcrwYOOxl39bcajGno/
 qfVHjru99rUFUva4OqGwtlROucG7sriKdZPOd3vV3JRkSgmW/66emcxBojpM/DpzNVC8
 JN+JgBGJapLGrSe11g392oqyVhGdFucgnUJM6825uqcvX32+5hNUUUvDhutiw+DiEoC5
 2csGnOrVeDgSogJH8FcJkyxTGi5ucNRheMW3A+UqPU7nLIt4wFy08OFQNJ+vpCC2AyPQ
 qnKA==
X-Gm-Message-State: AFuF++kOrDGIHQdtGFIa4TqR0Z4hXVK/7fsPTYryvnACejQnpvMQSUxu
 Fl4KiLYU63B+Onu85AP+ccLOztFV+wefa0UwzBY0bO6ouq9f6zxfRbeLbUESg+1Jngw=
X-Gm-Gg: AR+sD10YKkA9BxebYHv80Zrp2NTP6SKFM/wazEk/RKQkM7nIVbraXHAgP8IHGV1i1ny
 5ODzt4YfwrfAX+pTEGt1uBCYxawVFVZX0lzsjiwJE4+mq4lRh+KDbAxZHAtkXj2/KbxOL9gOsLN
 7r5Otpq7oYW+WeMQEzp6LYpWKDZPlM2+qBlbKGyLa4p3lE8NvF00FtisxQ0+GLpIUiGh4AtKxV+
 Gwacwya/sqyS8sdDsE82zRCyv5RjcwTywC8vCTbAcr0h5kVhienZA5CUU3P1AmBhj/8p7XQNvEN
 VGQAsDDb04d3rzk8bh8lwyMz4EV4k0+oiHBJ8Z+hlOcwcV5hHA0fN4ZGlYeyuqb2wIZ5LKjdqWW
 Ztef+zKJRcv7ejNXn7qQJqWXsfhqzb4NspOuO1jxF3Itc4bgOpyub4whmjbZJ2HpvAq1Lm6jxLi
 ZQKFOdwGfeH3j04TlDSgky5vNLlK00Os7534/Y/l+m9tl++lvChqjwUACzThwaUcFfFrmXNAoMY
 xUUFC5xy7Ai8txPkyR6+TxvMokxjzlSH1ziEM9/443ln2vHQbnpQksX+sqqy1jusvKrTfsUCQBG
 8jlFyivJ5Gm2UUhvzOvbqXKt04NfWBG2CZxtM/pgoVkM9w==
X-Received: by 2002:a05:6000:71d:b0:47f:8d71:210a with SMTP id
 ffacd0b85a97d-482e26e47a3mr7888366f8f.15.1787749788673; 
 Wed, 26 Aug 2026 06:09:48 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:47 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:41 +0200
Subject: [PATCH v2 14/14] configs: mediatek: mt8188: enable hdmi pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-14-68ebb1bf17df@baylibre.com>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
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

