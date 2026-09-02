Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EF8C624DB
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 19:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9229E608A8;
	Wed,  2 Sep 2026 19:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bumyklKDyhko; Wed,  2 Sep 2026 19:43:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 76B1760873
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788378188;
	b=OvldP5iPf61fk8VhUF4hV/DuYIVn+BWH9nhIyY31aROgI/OoBVWse3GzyeYlDZ618UwX
	 vCC2jbRwE0GoQmR/wV+boPWq/v+RALAFzOeyMYOjrLCVOYlolCcs/+xsxBcJiCGNYLMTY
	 fF/DwrGq8RjMFaB62A9ahYk4Yf2/MjMuBRESesdVPZ5j49xZH0pYjlWP8zJvrun+lWjsl
	 9WFhlFNBSqPtuo243lztisqDn0zaVw6qsaub5RpaOM1ulxEdk5b1iV2Db6NosVIVyws+T
	 RNkES+BoaDTdGTtEFZGTsLwCgc2VkNbYIgHI1qoTyItBmGN4eiw0JUL9CFRamJHhGzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788378188;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d849HdEkS0QCffQiTG6DULTxDl5m6Sfd04qjndHZNak=;
	b=Mxs3LSDjpUq0Bqsd0vilZqXOfgVaMfsXHUXlk5vIpNn7dOa2vZ+mRX9Wmd6HKdZZz2v7
	 4sLR4Ah6LBHnI7r2ngFZ1F8cM2+ocHKb1mcaVobFCjS02y9vAv/zqzG4nFnvkN2yQOk4o
	 BsXy2IDG+XvP1nffMYqlbMDEJCZGXaVV0J/yFH1GOnYL/AcGy0ndwIr/BKe9RBKgva6Ns
	 SZ/S6pljQ43HbkfX7NhtA4JD/GcxXxfa23mVMi1Fp+piSHVKChQX8QqUEIKJm6NX+IBRi
	 Z3ifxRhiLjST7UbqEBfzswQHYoL//JzuqA+DHIrLc5EFYkMWRssJJRRgf8HQMEsoMEw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788378188;
	bh=d849HdEkS0QCffQiTG6DULTxDl5m6Sfd04qjndHZNak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a/2/ZKtz4scqtNDHcCdhE03vtmuFLUFntN50Ph7Sla0Wbf0sbpNAIyPy470tw0Xqn
	 c0rrtH0sr7bztpRiOCsFI9UklGQRilAkkf8ZZZ8T0rvReRN9eiDqBSJhFXEp3zP8vp
	 H3vNiwsRCROjaCUJr/7qOvDiM4okHhQtenRFHHdX2JRkSlbtoqDbUu6SqEFA75bJxn
	 AdW3WV9LmfjMfAf6mB+CGhwkQzEJHOO+OTZdwKDP94SoT+JMCZv5S5SSrr+foR+zJ5
	 4dpD21qP77j5ADuU6f8WX5ZwxMOB8Lxy4l8SL5YAhJGHXm4IQVB6VAwZNkCjHuHmLb
	 TbvxdRaWRYegg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76B1760873;
	Wed,  2 Sep 2026 19:43:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 654E42B2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 571DF40AB6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:43:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j76tWn-hPhd5 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 19:43:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 84ECD40805
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788378186;
 b=gi+VDdr+vibgqDB6eDIVmE4dYFGlHmJwll8L/3Y4AWIXfYKBg6eWLpp2dUVTyMRzNDsU
 ASnDne6afmcF+PdfQUWXOnjNQcGpPw7O/urQB+AMaTDz9aiQ9k2uQkqvDwCye9S10Zgzz
 5SiCdhvv4sV8r8wJ6jokXFvGWxF9sSiSd56DWdBPiQC4rWtBmssrJPiJku0TgxCZOKqiq
 XoyQJV9D68Si2Fqt9OapNoHoFW/+KpzIxrcvgUHti9HyEFpoE5S/I7ynFuUKKWxvP6eNq
 w51rkSHO/kkjirkuSiiZw57y5G4UiK5cKJ+SeO5lih+RAnipTJhhIqQve3BvLMy8tJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788378186;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=d849HdEkS0QCffQiTG6DULTxDl5m6Sfd04qjndHZNak=;
 b=Oj2HWXedp52xjztEcfDSmJLe9SJ+Bu0l+4NoxYOBJVjt+HpdXjLoh5pG9fQ5756/wkBH
 u+3a6e27vwYmeJcOFx6FEimy/goekOJVP3gKRmt7snZNLggPPNvAzwqlPWpGaj1FwGB7K
 THiZAsh0kGYz8AvbBvvXsQQQi6Zo1B9QCo97gbexTRXb3dkGFF8xmoCmduaUYo7WLQ3ox
 klWkOw3BqCL5XZylKzKuoWww8yPCWVqw/gT76zKkK4axD38L0cDRt28M8xHgEhUXsQlZk
 SR46g/H1IXpZfLaOULH6CNBKIkVQrcauzVeJKX80Umdlk6T9K9IWsR///c7E0DHeHFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nmw+AFxf; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nmw+AFxf
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84ECD40805
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:43:05 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-465cfc7e33dso985784fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788378185; x=1788982985;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d849HdEkS0QCffQiTG6DULTxDl5m6Sfd04qjndHZNak=;
 b=nmw+AFxflgTS5rEbEhNMs7KtpWQIDi3QusG7ReWHNZjaZWycdds2tJmICMPV2FjVeI
 ru6xb9bP4/k9mlx0mNMxRQh6qNPyNu6zvkkAoimNWwHyriBfBajwB1juLhmnUzv+C8s9
 iZ/qmETo+G6VIgbvWAS5DbuhTkHuGutsJOX/fCn37GisxVElRAVTd48Q/Ivi+g9kZHz8
 jZ8n0hvkyWtRicj680nWsOaLfZaws/Z0RVeL0Z5jg9853GANROxYMoTQ0hb6LkOj6weP
 ZXVbx6H/lki51+8qCIwC4zVjK0fT49RunmTaad6VOyWh5e9BhNdlyrj08VvL79kyM0ab
 F8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788378185; x=1788982985;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d849HdEkS0QCffQiTG6DULTxDl5m6Sfd04qjndHZNak=;
 b=setX9qUVcaFlGn7cwN4mVB4kzC2WAuwUZ5Qi1M+l4HmAh8Uk4fyBLUkL2sNh2g9cjq
 ZGpI8Hu0aHuwdYi9eIvlN3F4VvBHSleJKcIbvAhR2h0eitr1mCmzYZvpeeH0J5Mdkxr4
 PuLVDhXYr+Sf+8+qVEBIxi6cGwa5QG1b+GrcqORv0rPKqbaWQcrMb1616B4eNbcTb5ii
 79eqB9TJmi6Chw5d0IBOb5QTLb3gDm9sEX0ujEICU2hVAJzAixbJZ49Z17Bmt3odPLTo
 gi6WndoxuBqqsoMPGvqifmdgFtuESXBPIz9Wsy0WjoUg/ueujcXSt1pZzHKlypCdXxu1
 32iA==
X-Gm-Message-State: AFuF++kVbhrac7AQaUOWFkT0tGGc2eKS7LaTE7ZgtygawHTDV4j0MdaV
 kd3CvosBRU8c89SfIua5ddbefc+BxdTwoNJYFhpPdDqC8HvwU3xvivVrTBc02FL3lYM=
X-Gm-Gg: AR+sD10pUlwEuSypiwMiUT7UZDup8GWm5pizREK6rCOmZYL0RQXQH/OEvyYCLMntdtR
 r9SmmrqeeToA8w6Divs0YuIRkeSUQfTfs9gd6hiX/8U+uxc8Vlxlbw0LzmBDyxTK+sHtq5ZDpAE
 uqCS9w6RxyWDPy/LMK18QydiAzYBnI+XeBOuiBtjO8b1ZFJbORMnrWu9rZZRRhG4bDMrR2omhxe
 Ubfv5H+1DcY9FlyAACwa2xa8Rke8XnoSpjaW0b8ikqVnnBYtKThhgutRBIrwLu4MYYK29f9YGCP
 iD9/+58JRdnb52uaw2OnPF7nDhx2cbO6rRzbinV/O2Rg0FgT4fF0M/PXj8KsxNRJwv5fs/F0DQF
 cLZvGVJOrPoXMXqp1r7dRK+//baGx+wtcpIj9w8dnvjOQ8eDJAwWXbPTVpUWD/yzk6PgBk2UaFW
 i3EhqQNlPPMheamYVgVOCYtikqFw1HDnHmbLx6uc3VksLkhFUI+HybJ+DYwJunHRS9znUVwTQg1
 LoS
X-Received: by 2002:a05:6871:828:b0:46a:5d14:b079 with SMTP id
 586e51a60fabf-46f86261e87mr6258925fac.7.1788378184770; 
 Wed, 02 Sep 2026 12:43:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:518a:9db8:615b:293f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f336c72fdsm4241804fac.17.2026.09.02.12.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 12:43:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 02 Sep 2026 14:42:18 -0500
Subject: [PATCH v4 4/4] board: mediatek: add Genio 360 EVK defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-mtk-genio-360-bringup-v4-4-2d38f522c72b@baylibre.com>
References: <20260902-mtk-genio-360-bringup-v4-0-2d38f522c72b@baylibre.com>
In-Reply-To: <20260902-mtk-genio-360-bringup-v4-0-2d38f522c72b@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=86QR3frISdXiNq64e5VbSk+gIXvorz5CRYpwaRvUcSg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmHwzzY8t1aMIyGe5H0UjU4JxqF/BySjvKj22O
 mb84VDfyT+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaph8MxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AvD8H/3T/5vq184xZqbbu39uAYdnAoh8YrmtLT9EEdCB
 FdbxLlubCnxlLCozVfh0lzUvOKi4RcRjRI8yk0rvCAdVKwpG2XQEL4T1rFHYChdz0pXG9NrrTR/
 Heti9H0FofQKEpZQNab9dQ23FvCRoUeXe3HiSwpyaTCEdujWl57Tq0ou6si+QZU5T99xp8CX5+Q
 6TU0TmX+N8Du6UFQcFsre+BHQJGARZaVWd7Ts9qG0O4L5Q3e5JrvALZHBBJ6zBiyPEs5DdDOYR8
 E/Ab1s5MQkcBvDrLWrXwLaF4kyo0vvU4N2DJb1s11c/xYbyamVw4jHUl2yEkuYjrsIkkVBf//H5
 3N6E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add a new defconfig for the MediaTek Genio 360 Evaluation Kit.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS             |  9 +++++
 configs/mt8366_genio_360_evk_defconfig | 62 ++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 47f91d6e81c..873179a765e 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -14,6 +14,15 @@ M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
 F:	configs/mt8365_evk_defconfig
 
+MT8366
+M:	Macpaul Lin <macpaul.lin@mediatek.com>
+S:	Maintained
+F:	arch/arm/dts/mt8366-genio-360-evk-common.dtsi
+F:	arch/arm/dts/mt8366-genio-360-evk.dts
+F:	arch/arm/dts/mt8366.dtsi
+F:	configs/mt8366_genio_360_evk_defconfig
+F:	include/dt-bindings/gce/mt8366-gce.h
+
 MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
diff --git a/configs/mt8366_genio_360_evk_defconfig b/configs/mt8366_genio_360_evk_defconfig
new file mode 100644
index 00000000000..03de6573aa5
--- /dev/null
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -0,0 +1,62 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="mt8366-genio-360-evk"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_TARGET_MT8366=y
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_DEFAULT_FDT_FILE="mt8366-genio-360-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_NET_LWIP=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MT8366_POWER_DOMAIN=y
+CONFIG_MMC_MTK=y
+CONFIG_FS_FAT=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_MTK=y
+CONFIG_PHY_AIROHA=y
+CONFIG_PHY_AIROHA_AN8801=y
+CONFIG_PHY_ETHERNET_ID=y
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_MT6358=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MTK_SNOR=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MTK=y
+CONFIG_USB_MTU3=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y

-- 
2.43.0

