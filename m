Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA934C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 22:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC44A6077B;
	Tue,  4 Aug 2026 22:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9ZtC18jVhzw; Tue,  4 Aug 2026 22:33:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 707996078D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785882794;
	bh=FZjWMngMIqRI1IBbnxMriEX5kWZudU694TK3tqKiKoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VaGs6ev3K/4mbiFzLUgwYovoqMMqD/K3sLozErEwMYZKaViyckEOdCIhzuTUi5/CQ
	 2lO0wUoNkRsNEW5HpIHQuCPTWYV0nKmvscddR0dVutd4OtuEKu4Po0gNcWDwkBNfHH
	 KoeuSAqTpWmZntDyxV4bX09+2vxzfjcLT9ERQ/vzqm8z3J8ZkJQO5YYlCjO5aZwg1l
	 +/DiLxXDufVtYWTr+35pMf8eQ/a0YtWHzqbTA+CnzWMH3l12xt2KbWu7EhQhtV8lE1
	 vxzjrDuCrdITLfA6gnx7EgdyM14s2i9PzeadprurJNqF4XeB4oRPOpSwuS4/jyNKnf
	 ZzbpFdty+2qMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 707996078D;
	Tue,  4 Aug 2026 22:33:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D49E6296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB02180AA6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b5Otk1dmaVYC for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 22:33:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 045FB80AEC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 045FB80AEC
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 045FB80AEC
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:10 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6ae6e407bfdso200665eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 15:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785882790; x=1786487590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FZjWMngMIqRI1IBbnxMriEX5kWZudU694TK3tqKiKoA=;
 b=kdSP6+q7TJ00PwkPAozWS0exK79XZlncN5IZdgU0qfFl1E9SzUkarGkHUxPn7azwXf
 arfASJf/9k1IpPXa9PWnSFW1qUImkLIWt/QYjr41Ip5wETuzaJ0tNvHWoQBCRprfrSKB
 3Rc0HOfK5B5XPY2vUJpLJc+QdJwQn2B3QQC0xw6bqIm3xphju2v7515c3pOPgjWmX01v
 Fti9PLZefwXDaLN2tCE+MRIs6kkNfaQiPkroQwzw9TtOq53PW1YT7AfrOl41ixOY/OZh
 wNrIVAdbCJuByLUBadbWA403ZHWYkXr1g4V9YWL0XWzB/VHF7vTQXNXJYI0yvdCCJ+sO
 p+pg==
X-Gm-Message-State: AOJu0Yx2HZctHUWWmLEkf2V1WzkPfTG18dJDaQCNvsX8bgkHH1uyFbbz
 9HhVScgG7HGWJLNIIxdtvJf85qNAnq+zTikLYeQqqcdlqA6vUYOcelI+iLke03JFWZQ=
X-Gm-Gg: AR+sD10plmsDYDAFvQyLZW7G0/G1osa1lGxE7g1E1w3B2J1TMPadP0ht4YGsV1F6oLF
 lLINUOKQGr3/yTrKhFBVo8fZz2kZlaVQP/gdlHOsbA1nLofmj1lDtKklfuvradtTcRPxhVAVXRv
 iP5YgEhy9Bc+bNbXx6VFrICAOWPQAUzQQlFLdKDVMWvXaYmjYMSoHEtIbaBmzux5drqZ2xe97Tg
 rqpiFr2qjzObcTGxCVkz1O6dWYPKlqfRUnhTTt1UCMrKJ4EvzWrL/TY4uF3PqcwVatraRVgdDL+
 YBSS9pwQbLX/eccKwfoxOxv5teWugNp5U+HWCHNfx8ve7UuMu0tyUAeGJOpXb268PZfH2xseYN4
 T1gGSE8kO0SRqfyHV++3TdCB7IVRsXDbvOMXtdiaozElzYwm/ENjUNlclzB3de66xtNhYsHc86J
 ofHhtjncBPuOihpFU7RaYsUysEUmk0Wyv8Vv75rZyoUxJbl9sQaRTFu6E5Zqqdc08Si+pAj3zMv
 mSQ
X-Received: by 2002:a05:6820:4dc4:b0:6ae:33fb:454c with SMTP id
 006d021491bc7-6ae96ee2eb1mr1384185eaf.23.1785882789837; 
 Tue, 04 Aug 2026 15:33:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a444:841f:6b21:eaf5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae93d524d3sm1016111eaf.6.2026.08.04.15.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 15:33:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 04 Aug 2026 17:32:07 -0500
Subject: [PATCH 7/7] configs: mediatek: enable PMIC on Genio 360 EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-mtk-pmic-mt6366-v1-7-f3b36b8a1a47@baylibre.com>
References: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
In-Reply-To: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QviseAALeNCUE9Wp7SSh6GiIrRNjYMhs/Etxuu3irYU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcmiTP+blg0WoAe5+p9rjomWenvcLBnGcYkEqF
 kmQ8t6tKEGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanJokxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AEOMH/0Mxibk/rHL46rd0eSI0vhuAtqJ9bs6uzzj+kdY
 AqQ0PKXOXfXZJh8lDrO67f2b+gc8ueMhMtIIP6TQy8iSRL8BMUhqpPepQaRdVmCkD5N+a30k3Cr
 jY4YpS5ElcF11bASJoKOqTx3+Q/jNU1m89vHETvAbVRxbGFvQbYmRW7v7Xl+xPn39yNTvuxFbt6
 jsBDA6OZRI5Um32smTatKjDic4TdVUwargbgX6RlZJ3PDFirTGUzVpw8KxuUQmYhiQxieNAFTAG
 sdIPcNXa99xbV7BObVQPHzzdIfJJHzkK5qd7tOwdTfa/s8eYyqiOIw0jNLKKeCmnemX0HiHalzP
 +7Y0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785882790; x=1786487590;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FZjWMngMIqRI1IBbnxMriEX5kWZudU694TK3tqKiKoA=;
 b=WvEYDI9GhAO6/5r03GzHN9BZN7iVh4Q47wfGarTIzBzNQm1+ejwq5ICC+72QEpFabm
 gZgfEjoxrUWEuj4dYS599zlgRotmzo1xApjcb159NWElh14Bne/ETCcUVwOHITkSw8/Q
 Gyy/vq16YcGw6xwW+40dfTqu50BeT15Sl/nlLt31RY8elqFBJ1s22p9Yj1sp78PYPZrL
 T9W/R5teSQFhYC6Z2JlLvBl18Dg/oM9PuQWt9IlbnA7oXcecgLQr5C2aD/qmejjbE7gh
 N+Bfrv0EqQfLtn56cidsb4pO0JUrLAtdNfHhh509GeKqSvRjG2MJwD/m3UaYyg6zeBj+
 BDSA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WvEYDI9G
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

Now that there is driver and devicetree support for the MT6366 PMIC, we
we can enable it in the Genio 360 EVK defconfig.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8366_genio_360_evk_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/mt8366_genio_360_evk_defconfig b/configs/mt8366_genio_360_evk_defconfig
index 64f6fd2f629..341cd039985 100644
--- a/configs/mt8366_genio_360_evk_defconfig
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -15,9 +15,15 @@ CONFIG_DEFAULT_FDT_FILE="mt8366-genio-360-evk"
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_MT6358=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y

-- 
2.43.0

