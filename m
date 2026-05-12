Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8AACD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 22:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8870284099;
	Wed, 13 May 2026 00:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="MTVI4IWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9082184099; Wed, 13 May 2026 00:32:28 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82C8084198
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 00:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-69b4f7d66e2so1025056eaf.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778625145; x=1779229945;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/+IEmMapfZajFHpZ6aluJ+SVmYVMMOkjwyrxpMnFhEI=;
 b=MTVI4IWdYBL1LVqyY6pd4CA3q37Jrm1XDxkO4WoymkN5vmGCP+l8fVmWG5tUWSFyDk
 wy359P6200vJo7LaS+LFJbDxEf26lE+1rAPy2ukhMAL1W/VY1AEqUhzTUvHJl0NNWRxw
 WQDFoBRj6I0F1zY/HFKyij0DSENt3fJxzruF1jTXa/LS/bF1JTxqnpn1jzHOPpguioEf
 MO9PpqokJthPGiUL84zelGzj8FcvhW+ududArJkcblDlGf7rA/ZU8ivY/H0ODa9Z83xP
 LLLuGlemDOuHRI27hoTK3T59zwtQ3oBT9s2/eu367T05p8+zLgNGahB6neftIPbupWC/
 jTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778625145; x=1779229945;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/+IEmMapfZajFHpZ6aluJ+SVmYVMMOkjwyrxpMnFhEI=;
 b=Jsirs1nW8ph2hiTDfdxvQz5LUbj6wVJDJXY8gV2PSp1UyGPNzoHyDj0qZ+08RXxewP
 6DluSKCqnUVe+dsNRspnqbIvyN+JZ6n40ZkrYD+4MiuER6NyfrmGoAOlkY2yXLiP/VJ3
 fEGoalqiB2F5VyH7hkdGGU6W94JOUF3DHMhhmm18v4fWsBPuZmyPBIYy3BDh4InYP5Sp
 XDkSQEiUnQCEPr3Zm8kjh4LNl0R3d1CjS61dfMKFPdeO93fYfZGiBNW5UhiiKua3TJk2
 0vJjbQ2LzoZT7xNsnrqaqlMa8jme8wf4mSumYN2FwZFuUJRibrrkL6FotsRFFo5BEd3w
 ZRfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Zhz+veZ8zp7H/JFLz7IjmisXyDh76DSAJPERaXMRlTllrl0PJ/8pikHOoCxjJnpy8GcflwvM=@lists.denx.de
X-Gm-Message-State: AOJu0YwodFFEbPOFA+2mugB5lxLvUiTVEKCso5g/Dm/qalJZ2lIrDloG
 bc9ka2kGYK95Pi7rcjavB8X7hpIGXfgs2spoyQBghIZWXf8T/cc4JpY3yWMCpYy7Clk=
X-Gm-Gg: Acq92OFt9PissMchcWqTHMEYUxvdYPD7phRRpLpnZE/Lcyp6TzByWLpCqqLaz5anl5b
 1N7/Bd/9e+zNbRXc8ZunYKi5mQ9s3yCZFNlIFadudg1HB1GAA0Dn1fB2oiAVZuOwufgkpbbu9hg
 SdJJ8lv/XSR5vdwHOjARA31iuIMr8C7yz76Q7iJWmF4TkhNBjHLx9Q5z1Pa8mX4Fi3wgl3on6py
 LJwSquPbvDO42U9n6NZkXwI6mAQ8juynH360TzVgfbVJWuhO8o6WkOrANJSxc7MnE2aaywYqvQy
 GCU3aRkr01zNQpHkFrhhI0mWdYHeUrDcxVChik4ZJFviWJ5+52XlGp0fokKpVa7Q/5v3RopxkEx
 5I9HwSqy7Kwmf2+0N4AS3DUqjLp0/zquspib2CGkqRtbx7IvuXGCwRsPQnGmuQO/2HW6pOeIUhD
 +Jmy0GmYfhRAeIdXgvGAdNIpqWez6y
X-Received: by 2002:a05:6820:1389:b0:69b:34db:20d3 with SMTP id
 006d021491bc7-69b78e30892mr471278eaf.43.1778625145218; 
 Tue, 12 May 2026 15:32:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ca1:aac3:aee4:c93f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dc0193sm8334545eaf.11.2026.05.12.15.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 15:32:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 12 May 2026 17:31:52 -0500
Subject: [PATCH v2 2/3] configs/mt8195: enable bootstd, FIT and DT overlays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-mtk-genio-defconfig-v2-2-bf4c30ef7f14@baylibre.com>
References: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
In-Reply-To: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
To: Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=EKMoo7vZz6cpNSz9gdpC63FJlAvfuIZ5mtGnki4k50U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqA6pn7uhD3AWXIgV2DKlhAapX3Hp/IFNb2FnJC
 CJPuTOphfuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagOqZxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7GwH/2uN44OJezYy3GCND+rBhLF0NbK6KKFNeE/4ZW7
 uzjR5n3SR2d/4Dd/1NPhDkCMptJ4TCz39zvsKvSD7K3hlg4n0dJMlcR8arDf2wj05johVo4vFk1
 OJmnj5JaBuRQdv9RaEt98Am9gbI+Y4/p2aHUqsOJcUs3FPKm+9iWwpM8WOcZqlpxR4cNWGSW7i2
 Cvev7uQt7r11Fl6xB10mMHyghmffEFpjntpceIxNKHgs97OtD2snA0PJGKCRXFfwFofeVW52Bw+
 NtuWZMuNumyJZf6L3jT0qJt6wzHTbCbzWMEe7OAwwP4+3tMAr+lYQZDhpdb+8R8zSvbuOAZyYv7
 jpeI=
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

Enable options needed by the default board support package for Genio
1200 EVK board that uses this config.

CONFIG_CMD_PART is selected by the new options, so is removed here since
it is now redundant.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8195.config | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/mt8195.config b/configs/mt8195.config
index ed66ea22956..03f57d46708 100644
--- a/configs/mt8195.config
+++ b/configs/mt8195.config
@@ -4,13 +4,15 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_TEXT_BASE=0x4c000000
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_TARGET_MT8195=y
 CONFIG_SYS_LOAD_ADDR=0x60000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y

-- 
2.43.0

