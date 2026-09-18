Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F4EC982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 22:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28D7040BF8;
	Fri, 18 Sep 2026 22:18:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PpnTDC-YLcJl; Fri, 18 Sep 2026 22:18:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3D1CA40BC1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789769907;
	b=bNTQiFkd4qF4MEPuInJU5tvnMoGo4Tn1+NJf2SjcgfYUAOKdmPABpTAlc8YV7fk5CL7B
	 jrvRl+KEvB6sd+bROoiv7BHP+Ht20YEteeCSH2VIAjQMWz+VlxGLVE3/VrwCOMsZIry5g
	 mjxCJCsjViVcWIW/DMTGzVC32pyLWNtius3T7mCpG7dVoEjL49inLPj3PtpJ7BapP3QaB
	 QRcrsH8rxS0BL7o2h9v9Debu5G5XJ4+uuNilBKL+PRI++bxAd/48rVqX554UYq0cPl8TH
	 7oHvPmbWsCRGrf+H/ymkx7BrVuBQqGbJqBnlFss+vUaEUyu8D/vTQH0p0IYtowxuPaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789769907;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RbojSCkN2gvUN8mn4UQRbJrSsinVmpY0DLpVt+t9Tl8=;
	b=U0OMg2s1/cHgVzCqlPA1eUWk6PkBvg8bkcqY/ri/JqHsueQE9FxBA9UGBxAmRkz3xphL
	 U3ta54nQWrb8BkIlVeJ8WR3ffOmbxW6Zqpr2D/rUmuEjXDSKcDO3Hh6N/xxQ4Uahmih9Z
	 V2atlpwEOq2ACdobWUEnMXlRVRlJJnetnSQFyXQAUfElmq112pNEEWfZBpUJPXeGGGeRZ
	 TWGFLzlGncsboCtju0TikIbBTUAtZB9HizeFd5cwlXy2NTlZpzNhvfgSwSPTYdFrIxB0x
	 CV9ydwgcxUGZ994xWNsgv1HemowNVfvzjTj2Rf21IZ7snjnWxM+X3kjM5wMdFoO2bCg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789769907;
	bh=RbojSCkN2gvUN8mn4UQRbJrSsinVmpY0DLpVt+t9Tl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SX8+dtppUS7jp0v6w43ChpZcZR7dINNunipW1bfbBsISaMtXOpyAbzInd7bXg7NRJ
	 I6aR9wsxJb6oxR2MLjTPnZeIC29xNcDH8kiVWyDMY7QJTIgr6cdrepJQ6O0RHAGT5D
	 ABW7g1w/JpTdwVHAwtegjhMwOgdNFcgXGYE08ttiWsRtdrPIflF5+AyAMauuEgqwyx
	 dEuO4MUzpDHUsOUdeNAtiHdVh/N3yiXGnr5OrSc7ieO6lLHp7E0oWBz7a+ts9pMC6q
	 goTB0+mR04GjcXXs95UJhV1PLgnAVfmUSMb9/1vvf8y+kQixffxBfpzVPOE/GiWf5J
	 23K9GRGZZh10A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D1CA40BC1;
	Fri, 18 Sep 2026 22:18:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2C5D237
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A465D400AB
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qSDykoQSHZGH for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 22:18:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5BF13400F5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789769904;
 b=JDN2E8xyZncnX1Uql84viVQtt16U+bGRfZnle8HSTTC2mNEVlrl3ldpQANOa4GRu/Cbl
 v0AjSWwzkS9oH3wh4j9n3kZmLTW+ufgVi7B6FpTR+t9PjKcnod1YJaa+2KJqxTV42ZCEd
 cjRk9o0J6s20cZgsj4GjvJsLmlGKeo3J+ILr0ITsD+KiK079MnOGWzdcrN/InXXE+mbIy
 RPVvYJE9Q1nPM6Oa1viUO/mhZlV76L313CWAYb/F0h3rtrQqTJqnIIiJ5jsO0v80VurfJ
 aToaftNaAP4yPXXx3Z4D0WLHejuOw8d7EeRKFdR1tsmnDGfIXjPa4OdhxcMdVJY/aTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789769904;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=RbojSCkN2gvUN8mn4UQRbJrSsinVmpY0DLpVt+t9Tl8=;
 b=je//HacEw9lfsOorcfwDMr+yhNtpsUYy4c+jr5WDsURU/gvRVLGM05p4UbQDSbkOCjha
 NaGxi9QUzzYkXeRubAIXWJi4bhouryBEmjm6KU9cKBn01EFw+2NkY7rrwraq33y30AAia
 llfmVyXtmdXvFdkxIFDW5A4RSqvsl2uBt5F+3WRzfsPMR3ge9SovkD/M+Rk5fRKocPQHa
 j0TS2ikthqS/x/+qKZfW88CSaDHIp1Om6uNeOfhhbEAGKnhTiiciCwHj9Y1NWwQZExAqV
 95hmxAXaigMtcTpv89M8hHs28CQLv1swSRenTSvdzGKiQxcq18vIO+7yxlvgpKjpwRw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=YcIghCp+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=YcIghCp+
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BF13400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:24 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6c2613d8157so543513eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789769903; x=1790374703;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RbojSCkN2gvUN8mn4UQRbJrSsinVmpY0DLpVt+t9Tl8=;
 b=YcIghCp++PeD97tAtioYZd2X3RW09ylm9B894fVOqUDWfvC+HJsGknZXUITCyMfWr6
 SvtcRuSnBDKWXmhNAtX/qPuCvwiyG4qxLNaSrQEfIbEsIBbpcNaDaRfwv1kox29BDao+
 EyNOAlSol880hXdxJZbc0pdEVACD7bZjEweCiaYJUDUeSyfFS6K32tIPsVIoU+yqJd43
 q8oHNLK3GLLr8v5ObSvr9EoA4lyk0wHkZRAQRudz39HevEEkssXeElqyhEGrkF+hjgnr
 Neyxagclrr444R3ZQVZmzTYU5JxnsWviz617jyKYrjDv68JS707w9INNHz8401h/N5mo
 HM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789769903; x=1790374703;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RbojSCkN2gvUN8mn4UQRbJrSsinVmpY0DLpVt+t9Tl8=;
 b=qPYqadB+vyzJBFAOmyaRgti3fX9aiOW9ceRzaiKQ7qwycjojBD6pSXTGApp9uca/9U
 2Bobcs6RY0BPCGDpyC4ET6VKZ7ZUOX+z6Le65rkIqQXd5bGQpAGdyRfy/PtYp9XEgPix
 /vR2fDr/U5pXNGqfu4oQXTgtC1FlLUX/7V/p5fEv8Vaa2G7hGZZdUtLVQjG/HybbvvKJ
 tssFnCBFoYFJr0NB7ujSrVTem7X8eXYnhXLix+/GRi9bUNu3UtHmpy9FLRZ7t8VlcKBn
 z4WbVYEzce5UvaOKq5iyTGAwvr0jeEkibnb7h15C81lNoJLqPDpQ15xJn3MqvCfuNnUF
 VDQg==
X-Gm-Message-State: AFuF++kJymhLCgRvXE0RFwNE2z8heyV0TH/g1XNQUZ+z/uOVZVOCFZhQ
 mnTTcW3/sFPRvxQSqqpvDogYceABoNd93dOxzQ9dsYgTZoqzPr91fPyPjn/YZm1+43c=
X-Gm-Gg: AYBFou1N9sy2ApjM/65hnSgjoZ4K7LrWFjLsZH9YGRZkoa+g8X7myjjDKdAFWt3hBiy
 IcvAV/E+8N/z6YrDXr5oVjBL7Ll5IjclRB76a3iI8HhgI8Tx7Q0KJqhpALOCVRPNGo0Zl9M5TCX
 ahRzJ4EHkT9dJNCp3wl5pc8IAv4cOl4b27N7qcA1sx9wIITHhnI956whaPB8BLvP4MMw2WCaaIT
 UcHa2rySeElBzjPxzvKe1EOeWb9a/JhjrZNeFaQf6mLR/dacs2OB2fJfgoT8J/oMjUgDVMUIOgt
 PUgY+pKu1XuJuUn+VUxOGwkhV60scv4Hys8GZAZ6bh3G+7WKTWLrR2oZixh35oR4HJEkmmEZLXE
 nJEg6qm/MD1ugUiuQsLznKchYailTkyHU0WOoEwH0FPdyhqcJg606tUkdZT/Bd9fEp34iG3+S7o
 i2v4T0eE+FKIaiJrZ0aWsWH10ebABrJUwSA2uA9nBYloTAoWZ+jYnWVz/itNl3NWglIZ2je5VS
X-Received: by 2002:a05:6820:1845:b0:6c9:80d9:5f4 with SMTP id
 006d021491bc7-6ca9c94f271mr4160084eaf.53.1789769902997; 
 Fri, 18 Sep 2026 15:18:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:921:e69:d103:4708])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd34f2d2fdsm1426959eaf.8.2026.09.18.15.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 15:18:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Sep 2026 17:17:34 -0500
Subject: [PATCH v5 2/4] arm: mediatek: add MT8366 application processor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-mtk-genio-360-bringup-v5-2-31451a136f96@baylibre.com>
References: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
In-Reply-To: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5191; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=HJCfz15+Sxa+9bL2L74ghUglAyOGtOTeF7Az5gZEt98=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLLW7uiJ7tyRHJGWFRyTOeVSBdPejLeTuj5wa/xW4dxlN
 iUnY0d1J6MXCwMjF4OJmCLLG4mb85L4mq/NuZExA2YQKxPIFDGZlJzU5Iy81CKHpMTKnMykolS9
 5PxcBi5OAZjClwocDI1v11WtrBL3/iCoMj15k3PfFlNezvka321ZnimkOf0QyHDa75AfstHoghN
 3wwKvicr5u8oVjKJNnDXupOxh/iHPcfz2UadMd4ffG8+r3rfb2LNaesHDYoUzPBaR/65P1SmOX1
 xVx+acc8HmZabQRcVdFmp8VV/mzvvDZecwT+t3acVmvX3WIi/3/FP3svhx3vyEKveEoDrJnVq/J
 pdq29/3+SqXlhjAllPe/1nVXTWaQWPySaUJ69+9DDOPmdPDWsIseDdfwSFS/6LvKs2FH/hUC0xO
 lRrennChtOKxXcTxhJKDLlcfG2couh2r7Gp7YPZSmNWql3+V9L7qx7K/fIRDPiq9nZV/LuHd998 A
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

From: Chris Chen <chris-qj.chen@mediatek.com>

Add basic support for the MT8366 application processor including init
Kconfig target.

Signed-off-by: Chris Chen <chris-qj.chen@mediatek.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig         | 12 ++++++-
 arch/arm/mach-mediatek/Makefile        |  1 +
 arch/arm/mach-mediatek/cpu.c           |  3 +-
 arch/arm/mach-mediatek/mt8366/Makefile |  3 ++
 arch/arm/mach-mediatek/mt8366/init.c   | 58 ++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 5e6c50ca64d..c278b220773 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -119,6 +119,15 @@ config TARGET_MT8365
 	  It is including UART, SPI, USB2.0 dual role, SD and MMC cards, NAND, PWM,
 	  I2C, I2S, S/PDIF, and several LPDDR3 and LPDDR4 options.
 
+config TARGET_MT8366
+	bool "MediaTek MT8366 SoC"
+	select ARM64
+	help
+	  The MediaTek MT8366 is a ARM64-based SoC with a single-core Cortex-A76 and
+	  a five-core Cortex-A55. It is including UART, SPI, USB3.0 dual role,
+	  SD and MMC cards, PWM, I2C, I2S, S/PDIF, and several LPDDR4x
+	  options.
+
 config TARGET_MT8512
 	bool "MediaTek MT8512 SoC"
 	select ARM64
@@ -159,6 +168,7 @@ config MTK_MEM_MAP_DDR_BASE_PHY
 config MTK_MEM_MAP_DDR_SIZE
 	hex "DDR .size in mem_map"
 	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188 || TARGET_MT8195
+	default 0x100000000 if TARGET_MT8366
 	default 0xc0000000 if TARGET_MT8365
 	default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT8183
 	default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
@@ -207,7 +217,7 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
 config MTK_TZ_MOVABLE
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 35f748a70d6..51bf5789bb5 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_TARGET_MT8188) += mt8188/
 obj-$(CONFIG_TARGET_MT8189) += mt8189/
 obj-$(CONFIG_TARGET_MT8195) += mt8195/
 obj-$(CONFIG_TARGET_MT8365) += mt8365/
+obj-$(CONFIG_TARGET_MT8366) += mt8366/
 obj-$(CONFIG_TARGET_MT8512) += mt8512/
 obj-$(CONFIG_TARGET_MT8516) += mt8516/
 obj-$(CONFIG_TARGET_MT8518) += mt8518/
diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
index 56a41e42df6..04ede8823b0 100644
--- a/arch/arm/mach-mediatek/cpu.c
+++ b/arch/arm/mach-mediatek/cpu.c
@@ -39,7 +39,8 @@ void enable_caches(void)
 u32 mediatek_sip_part_name(void)
 {
 	if (CONFIG_IS_ENABLED(TARGET_MT8188) || CONFIG_IS_ENABLED(TARGET_MT8189) ||
-	    CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_MT8365)) {
+	    CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_MT8365) ||
+	    CONFIG_IS_ENABLED(TARGET_MT8366)) {
 		struct arm_smccc_res res __maybe_unused;
 
 		arm_smccc_smc(MTK_SIP_PLAT_BINFO, 0, 0, 0, 0, 0, 0, 0, &res);
diff --git a/arch/arm/mach-mediatek/mt8366/Makefile b/arch/arm/mach-mediatek/mt8366/Makefile
new file mode 100644
index 00000000000..661744a4398
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8366/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += init.o
diff --git a/arch/arm/mach-mediatek/mt8366/init.c b/arch/arm/mach-mediatek/mt8366/init.c
new file mode 100644
index 00000000000..13123be068e
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8366/init.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Baylibre, SAS
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Chris Chen <chris-qj.chen@mediatek.com>
+ */
+
+#include <fdtdec.h>
+#include <stdio.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <dm/uclass.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <wdt.h>
+
+#include "../cpu.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/*
+	 * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals like
+	 * MMC requires DMA buffer allocated below SZ_4G.
+	 */
+	return min(gd->ram_top, SZ_4G);
+}
+
+void reset_cpu(void)
+{
+	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
+		psci_system_reset();
+	} else {
+		struct udevice *wdt;
+
+		uclass_first_device(UCLASS_WDT, &wdt);
+		if (wdt)
+			wdt_expire_now(wdt, 0);
+	}
+}
+
+int print_cpuinfo(void)
+{
+	u32 part = mediatek_sip_part_name();
+
+	if (part)
+		printf("CPU:   MediaTek MT%.4x\n", part);
+	else
+		printf("CPU:   MediaTek MT8366 series\n");
+
+	return 0;
+}

-- 
2.43.0

