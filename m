Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A26C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4704040699;
	Mon,  3 Aug 2026 23:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fAKd8cJPc3Ot; Mon,  3 Aug 2026 23:21:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B935540684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799305;
	bh=vmzK3TE0UWI4VGFERq4S5PMHBNg7gMhcBgSAeeXp74E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gnISv63IHP66aw+Yls5E69QgkXlUBdoQ27SKfWv43hOuAhDzjqpaNb9JvMb6BESty
	 uRTaoLTqkwBI1zSegPpZromICOAzkDQPpjXW7y/RZ1p/XHBKH+ko34Pjtc1jiG6Lwd
	 YaI/M0p4mpaITBiVhMMEyPwEb3gR93Lc26sEAzuzDm2JCod5yJE1I3f4v0+fWYeW+Y
	 60OXXJA5n2PMz2tvEWQItPyS5Vl7bfj5FWLawloPZne4mneueAtI52oAz61TWQ3N1y
	 F0MOB4ptjIBrJYNhBDj6QHKxl1Vb+N7Lk4roaSmku5uuiVF/Q9DGD6Fht374ybUPd/
	 zYRPrxJjXFdTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B935540684;
	Mon,  3 Aug 2026 23:21:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D41923F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 731FA80B88
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSSYv6IjCSDt for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:21:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AA66780C0C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA66780C0C
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA66780C0C
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:39 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so3422334fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 16:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785799298; x=1786404098;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vmzK3TE0UWI4VGFERq4S5PMHBNg7gMhcBgSAeeXp74E=;
 b=JFQIGLWLyLrQTop/G7K1NeAzrNbE+XYIZCakdeu9l3SkmCZbtnf3MszmN/rD11zLpF
 EkQ+kpWQeOd1+T4AabtiCpD5FChrgP4iUnZ+JSsA4Gwyx3bIdPfYT2QZS6g8gbsUHYox
 9EiFxQC96PTjWXftmt3VNW+IZLctCDj4JgD0/ziMSI+txMIo5tuwWymh9/W5slxhnTu2
 z8loxKnR7TviEr6ifj94kZ9UEloreDrQyXoQe7hh0HI3loCIiC2hQhuPUNCHa67QsEGJ
 dIStgo3b3yJ2aApcTsY6xTOd4iEqxnJYMOY/EqirlmGuvhTjMnbrDzsR7kfOCNLO0LNL
 I7Ug==
X-Gm-Message-State: AOJu0Yyw2ZynwbbDK8w+YD+tFrdkaep3mSUOLHt6pQfVYIzXAY/EN1js
 4Jswu+jpbAo5C58y0wUwFsiWKirD5PcbU0SL86tqx663ipe/RyfA2O3h1TdS4dU+0lg=
X-Gm-Gg: AR+sD13h72WxndqrEdtoc7ThHfkBPvcdjOmVPaBlWlJd9eLq0PdTlYDljqJ8+U0pVYA
 c8PqWO8+njTbv/MY0QH96kwYSOnMTPhXdzsuiXdUZ3SdwecKJsgOmkQnKqsJRFy/1waPVHbUbdp
 QLphA1iI9U3dom7fzhQhO2piP/HUDKPMH9RNHw6fllAb5q+M9RH+Py4CFhibVNZL0XPQpBpqhp8
 cTQtkBGDmgGbcPfn126CdH0sqD1lAB2UK7woz/abnC2q2LIUkwrXFQ/OEz6yDVSo349Kp7BrxOC
 f9G3odNPBesfShu9n86ImxqO1K0g6ntecC33LQEeuVT69xbgffFGN6YkH6mybnpoCwkDRv7R/W3
 QTswan5YVxrn/i6HeUmnCCo87KwN2TQcMQGxu9XXtp3ly6TFAUAjGfj2uAs+5elIx2uJlwMaTw3
 Siq7iaC9naaztxfUrfull4OAw876Sl/4665xVfqUovKdaIWhbPjR9pN44Uj6E6/jQ=
X-Received: by 2002:a05:6871:109:b0:447:29d9:cf22 with SMTP id
 586e51a60fabf-4590589d948mr19583531fac.9.1785799298597; 
 Mon, 03 Aug 2026 16:21:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458f60df63fsm9440852fac.6.2026.08.03.16.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 16:21:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Aug 2026 18:20:45 -0500
Subject: [PATCH 6/6] board: mediatek: add Genio 360 EVK defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mtk-genio-360-bringup-v1-6-606ee60755b5@baylibre.com>
References: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
In-Reply-To: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=adzqxjrm+OWjyuughW6L2OJr+a1TwqbKrWhB1FEJbds=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcSJym0hwqqXx5NYs16ZUn8eU3Qi/6rCxWtNRM
 DExntZHQ5WJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanEichYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/An/0H/3AX3Q8lGi1AcCqtBaY0PoP+kEfw22M6Nwx+hVi
 OUTrIUYTkaR+aDm1TuNwGVwXtLYFDNByKG/Lxt1BjoA1HRfPkKsnZMleY6quzpvQNihxoUCyJJ2
 UU027FsTLJzxg/ay1+hwbmCCDDY7wj//C6fRBk5IOEcA/cHI4mDbdYreDWSf4ulk3kEaXo+nS4K
 G/fpX87lIAkZPRaKycur0+2A0SK17xHiCKfyHwRmFUymeoVvWsvAr/1JklE1dY5YQQF62OREzcO
 ZqJmxoSWWZaHMHcPaZCJfICPXITfJRawgjiV01FDusxoKgYh14v51oFfHtA5qu4jtNtxaa1fZFz
 dN0o=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785799298; x=1786404098;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vmzK3TE0UWI4VGFERq4S5PMHBNg7gMhcBgSAeeXp74E=;
 b=WJ4JQIqvhYSHBIhhHf8XYbuR8XCdKjfiLih12cZ0XNgULa2mRY15iU7DJg88kMKrrh
 GawEn+3Kxk40jobgQBm+xxv+ocW7IE8XjIZIxpKGiRlBAIDkpnpVlWZjSlGKFGaDEkwy
 Xud10KcEDGqKGtR3xMImX6WDOl0RsPgP6QQpWSgZgCI5ajDbG3ZSH7K+SySynOAFmOBc
 NuRZ1cHwIGEAb+sFs0XbIB9w7ApViBIcxZ87KnPDxs8K8lcr0D5L7RLYQhtcQm7L1nx+
 wT8gWhTgtLE3uN5GwOW//zF459eeVSobT9tJsP+61J6DaFjmbRmr+UarQ+IKQbUOZQNK
 swOQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WJ4JQIqv
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add a new defconfig for the MediaTek Genio 360 Evaluation Kit.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS             |  8 ++++++++
 configs/mt8366_genio_360_evk_defconfig | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index e657c5b04d5..60c8a0d9d7b 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -17,6 +17,14 @@ M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
 F:	configs/mt8365_evk_defconfig
 
+MT8366
+M:	Macpaul Lin <macpaul.lin@mediatek.com>
+S:	Maintained
+F:	arch/arm/dts/mt8366-genio-360-evk-common.dtsi
+F:	arch/arm/dts/mt8366-genio-360-evk.dts
+F:	arch/arm/dts/mt8366.dtsi
+F:	configs/mt8366_genio_360_evk_defconfig
+
 MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
diff --git a/configs/mt8366_genio_360_evk_defconfig b/configs/mt8366_genio_360_evk_defconfig
new file mode 100644
index 00000000000..64f6fd2f629
--- /dev/null
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -0,0 +1,25 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mt8366-genio-360-evk"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_TARGET_MT8366=y
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_DEFAULT_FDT_FILE="mt8366-genio-360-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CLK=y
+CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y

-- 
2.43.0

