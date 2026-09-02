Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AED3C624D9
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3A768100F;
	Wed,  2 Sep 2026 14:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6bo9-Eh9EzuQ; Wed,  2 Sep 2026 14:17:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358610;
	bh=i7X3K3Qrfl/jwTsv79fOGE5IxYE4sLASeAQZjKwPAYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k5wDbIzi+0nFyY29ohYxqNqx7Cp1UBqTYWjx/gKwxDw8IbmzaUDxf69eynhjg/luw
	 RwUGhc4afo+dZA5rUuMpBWw2W8lfCLD3M0vU6HojP3hWuCt0AHgw7cPuENjGxIW3dt
	 mkepVyTy7pmk/mv/lQixUd75ahohSz7uQDy7A7qcRdhTlv72YibqDqZPxM7KB1qhtO
	 G0L7SIBncpubQZjUtsW4B9mtz3dlO0CzyrBt5K/Y2Q2R7BuKZlZMwNHClUzW4CMzLg
	 xClsomuc62GYdYLrC8HcnpuJnZSYRlh+zPnXT1hFRp0qUBWMhXtcTNSY0lNjDQqaG+
	 IWDMqA7nFNqEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3128980FB0;
	Wed,  2 Sep 2026 14:16:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 496BA1D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46FD9400A6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWP5dbH01fLa for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=heoh5+Dx
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11E0A4006F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:39 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-485538d3499so697239f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358597; x=1788963397;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i7X3K3Qrfl/jwTsv79fOGE5IxYE4sLASeAQZjKwPAYA=;
 b=heoh5+Dx40GqfosMk9xt6cHq2mUKAeZKHv4aIkH89E6hujLFPj4yePTgGHmds7THbD
 usmRUGbOexZQLDPPJFLX5yvGg4ej972Saimuz796wLk2ZWWfKqZZuLDolTUDlhPwlN8Q
 65oU7oMy9taSClMWd4gnoUCCeXH7gYsbzQ5aZjMg3V7X2tRcbz16IcvrE0SAWeFzmUMP
 mcN4YZA4dHnJLX1IOJiub3F49Y0F/nf3zcaaJ+R4Qw656xEfrKhMIP8I4s7GS37pNlyW
 LPst5xgQ3uGxYRlCP+EsGyzSBNuViPVpHeU9f1B/tHVWr9hnaUKJJcEdz+J+tNr8g7XR
 nvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358597; x=1788963397;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i7X3K3Qrfl/jwTsv79fOGE5IxYE4sLASeAQZjKwPAYA=;
 b=TY3O1eZZkLO0oWl12jOa1TEufccNsNcay/Yc1OJBTxQOmEMA+Z/FDtub+j0xICkasw
 1V1MtA7/gMEqEHDyuXFrv25Bsg3oFEkivXIU8JdX6icSKBlRXw2BOziZ6YUnRKMHUD5E
 HcIwSsYuR199WJ5qUIGjKFu9M8T2akAltrqh6R6U6KXi1VkOgS7EfShhLX9sEJuhP8jF
 kpAFsaFQEPD31DVLb+njQN3+0LEQIb2R7RMAmyiS8m9bhrOiPxwcjVMSHiah40nnBw3o
 3gE2j6XgoNVhpqrTl7ausDFM4tx9kYKcxEnRx8ebGMo1fMNCCk1S9KHS2lJQFytV2jJR
 +tbg==
X-Gm-Message-State: AFuF++moRi+574bkrjRz8rAH8jRhKtENiwkUJnD61aLb4SaVP6Z/bmpo
 mQpCqbwBdFT25GXWfFdoKehJv8atctCoQMLiPvikOZJXifyTU+iwJ6ntSQHPE1NcvWU=
X-Gm-Gg: AYBFou0YY4pgz31IJt2tRdK5ZTw/kN1j7zJiwEx6DbJKCW16RwY3G1rFB3FqlavyF9+
 VWsC4VOj3pKP1iC2dtju1+GKrqLWN9I+t/F9NlrV9oBhPS08PU++V1aLBHb3sJTbe6UC6oiwgi/
 by6edGsCCxC1DtV5TEoRSUrJojpwxXVnsI6N22lQikOaGutyN78R5OMoh869pkenubz62wCeFw3
 6M4qssAOYSVDf4GkcKmFhJwfpxfyIUsEDPC9m4UQhFVJdkBNC6wJhdavDIA5VgagXwanhp4Ygfi
 0hZV64k3eE+IB1Sx+Dthm/a1kQj9/S5xEWnxr50CiUA/0AdgvXW2Hx1SX1hcXQzeh1HueQ/+jIS
 j8qyKYUbHSHq8WBi8pvl0KzgOcuAmftNFfG4+qJsl7MxBTs6U2ZSsIamlL06Wv/4J35uXrZMBIt
 hWOWMqhG60pSys4JFsw3IiM28JHub4unzbHpBiG3CsRw5e45diSzagHa/HXyx5SR+IOVFUsvV/X
 zQxWrg5ODnfvcBqPAKYWgyFcxORdoiuUHeU17NtjB4S5FFLxLn0Ison7IpuXxAbDy5P7kjN2VU3
 Qma31y43qMaj8PEaLC4H0ZbiSjcVtM8MBCVNfE2Q9G+s
X-Received: by 2002:a05:6000:18ab:b0:481:512b:f0e7 with SMTP id
 ffacd0b85a97d-48488f1898emr9675028f8f.17.1788358597285; 
 Wed, 02 Sep 2026 07:16:37 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:36 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:16:04 +0200
Subject: [PATCH v4 14/14] configs: mediatek: mt8188: enable hdmi pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-14-7c3b4f068a56@baylibre.com>
References: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
In-Reply-To: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
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
 configs/mt8188.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index c6785476d9a..31468a7f005 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -12,16 +12,21 @@ CONFIG_BOOTSTD_FULL=y
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
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_MEDIATEK_HDMI=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y

-- 
2.55.0

