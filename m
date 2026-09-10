Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4457DC79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE8D7810AA;
	Thu, 10 Sep 2026 14:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HGtSjjK0wvxb; Thu, 10 Sep 2026 14:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E66388108D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049087;
	b=amBllEpZw59DzU1Vb3adx4OkuTZee1GUmZsIdE8dFCh2hSC6IZw5QXsVMh2Hoe//qtc9
	 g0XMHCLZgorzcYPgFo0RcRPQ1T40rKbOoaar7nxfqHvALUquSTX5YeUg4wVE1vILKVWTn
	 dtlfICQuqGlslNbjTSZ0CwHFMy48YJqamaJ9zuTkZ6kdb36U6FnGNssKo50BnsY8vCCvE
	 F30atwHKwofFpZ6A8Uw8rlRdcUo3yT2RFuaXtOWdbiJP6GhY2r3Bsxr+LxtbQb8C9Ji4U
	 NQjHLnqFv6/+Vvrd1xdoCfyHuVMaK1ysXO+1K0H9DMb9fd9Lje2CAtaJI5CjFngj3AA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789049087;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QgqLAMnM0QnMkdx8jYMYTz3x06MbZ4R0X0M4NhMO5Ok=;
	b=IF2nP1ASJMHvxZaWjv5VV/Pke/UWR5yxPJB5cfAtezQRBmYe9qxzrQ/oGUqxYrGa1Moj
	 ohbNpa8PyJ7TFOnXtoDa1KpfIPKDX8D8yPx4bCl7x7hjz0rWrmqQ3EfR63tKHyyAOwGEj
	 B1wL0cEeGEL+SUmqwPchBrBRdFgHLgMFz9EprpZyC7SqteR09ps/CD4CklTTgbhGhHTCu
	 UFODapoa9ozerVDVyTU8DkxB5rO0FYRMFSSyYVxRCkyiu65DX57cnBOqfKqzxEm2GO4az
	 jfyzNw6F+WsH+l+h2uIBepSYFSevxKXY2eUwNrkpo/IGXDwoJz7EtgHNOZ5RvBywnIw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Cxshij5D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789049087;
	bh=QgqLAMnM0QnMkdx8jYMYTz3x06MbZ4R0X0M4NhMO5Ok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X3r9BAq0esNl5+6QbSCxDjeybPiz6hteowlxYvI1EzIuUf6aGbhbI4ZFlJ1h2JBWu
	 GSSMZIN+kFEMeV3uGdFIi+f8/AzZz40tWZg5EAFjJhEaaRmcySccAEdb0KEqERRkYw
	 ydSE+3Pq9liZDDCQn9FCRblzD0ylHRM8JwsCoPbeumhO42FBBf2btlF7ZC1bxHCSGp
	 rjvMshdxagq0OjnlK/OMLslPFKjQ51mWTTg1qJ3W9zAo+kDb9lm67rF6q82olNu423
	 kPAyK2k9AIyD4KXjwquMsJj4gdMEJ64+xljhkimlCwEYetK2WRrRN9Wt12oV7FpKwh
	 zU/lf2RpmxLZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E66388108D;
	Thu, 10 Sep 2026 14:04:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CC4AE11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E18B81007
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jGVL9hsiF2fw for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:04:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C8D7E81006
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789049079;
 b=WTs0ivEiPj59xKxY0U3dzCxU+fnUoELad64noSjqJQgQzwavYfQmWvzFL73gKVbpOxHY
 OtebkVNusiUpi2ZfP8FQEzJZTElHVd55CPX9DQEUEMFvFZmzog7prsZmWQ2c9juOdA35p
 hlQwHI4VWsqz1XxzHKcVxRQmeKu1EsvnzaPEexvo0Z8nXhN0aVhyhH6PLSJdP0uzjMwRN
 h6tUdJfkmRZe/j3FmZ9pcW7UKSRTJv5zK0cknSVIlh8p3JGjqq8kUeBGVYZMqb+JTjpjE
 6EP9AvKBu7b3n/8XtNhtXjIoVIYMVeeOg58/DkjkOzMqvyeHmKM23G+rROi+F6p8C+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789049079;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=QgqLAMnM0QnMkdx8jYMYTz3x06MbZ4R0X0M4NhMO5Ok=;
 b=jD+2TxklVmuEUFSQIxzLc5NeqbJayAgSTrhERTtfb4iuYiZ8TgSFS7Bc7ABpOdjtncdz
 H86095sm/sgUlhiFgCcV1hKGEmNb5SPZkbGx11S7XfRQKu6wr67eCcfI7p+7Ai16NXbgM
 skfALbHSSrad/pPFRNT1Ta06U6FxuhfvGDZMJORrKxdkhRdDd7ULtFBzBTCk/3884RM2G
 tvLYaTSkvCWQ/6eUaogpEAB33A2/f6PSZY8y2xv7YElXFcwzooO4c9csP5XrRwiK/jAXA
 zYJBSJIGurwa6XTU+4EnrM8TsqDDISKKd06Zouh66pK7ip34+2p49xpra81Zum3/9+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Cxshij5D; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Cxshij5D
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8D7E81006
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:38 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so14530405e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789049076; x=1789653876;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QgqLAMnM0QnMkdx8jYMYTz3x06MbZ4R0X0M4NhMO5Ok=;
 b=Cxshij5Dfu0gyaAmAn0bLhrpO+0TSXtpuBfvgRdZ8yG4RW92Dk+H8yd9ZN4KgnxQMc
 bdVsHtEOqJEtBxHYrlLTNi9EDGkKnbDeKBhDRJB2kMgbvIXnnbn4dEzqXvlJP167dk0l
 lTJcROXkvf7uC4T9xmS9e0ktAdevxGdIcKM6PCYx3FpH0SNMXAdaNHXbVDP1krjxrMfo
 FjuTCuop+EbEl2P269VzJFxDjJgRFdtbzX0Yw+GV4jO0irW04goPsO9JyvweJR4hm23c
 fe6u27k77mri2DWV3w8CfArsEqvI7wXa0lAK5oIZAJBVkeV36GsIOqDL333YMqDrSpPs
 rhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789049076; x=1789653876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QgqLAMnM0QnMkdx8jYMYTz3x06MbZ4R0X0M4NhMO5Ok=;
 b=KPYNW2qDH+FCZSwiI9uhs2CkAgqZfbX1cN+ICmIEFO1tRgtHW4bwKWo6OdAK82DOOv
 CT8eDhSwU+LmrPj94XFyNxGEvzTiJM22bqWOCAEchldjlm2t7C6L5loM5xaNJMxI/kXh
 9yZEDng7xsKMPHsdykjbtc/kxeJKKuNMHhj2gh67n86CUY7PEWG3JiC+aYy3cj1lj5+S
 OTI/sczmVNksYQHyjtPs4yFunxxDqyBeNfs/hgHEFRxwHXt/lbuOZ95hIt35g5DO3jjN
 X6bpRVOBdCbVof0L6vwj7RshSoGY6jHho4U8jDBl6xHpHmo3aTQZhKREXjGyz2jCYyJx
 6NLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEWxS0kyAAJR3NoVgZy7sUvakhNgK7lVP2nwdrNDjlWYDBWpY0y2VxOcYn3TnoTDIdIxSsauk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n9/LvRma4JXEw3j42A0OGXDPXI9zMjtjeYiAXNVKku2v9EW7gS
 +/ZadypFer3/LOzsQhxssCYzablq4lorAyxxvRX0/CbNCdWGRt1llnaMdoxOYjArsrcll3MxKAT
 I3YAez9U=
X-Gm-Gg: AYBFou0LmthqOUtLwfWPxVwIvM5KLoCH6o8Ow7dFTWbRtkTN+TAq/FLGIWbEr1UgP0l
 +xp/VSZlEySdgsGqsc6eeMksLGRq91K76YPRqIXmxbB4alCtm9T2Z6Ni9HobYtfs7eAukGMEwbI
 GVfLMmaZz5KmFaJErhkxA0Ggj0wg0nuaXE9XvQakZSPrjf38y0t7WQRYTwUpNnYGT83acdXgi9B
 QMEvhCasCk4nrI3U+gZQ5pMgXauG+CRUN6kw1uEwR1jNSw93YQ/UhOaSQUgWLKmlUXBr2mzBiQ1
 S4D0uWLyqoEzwUuQko/b1XEDPOM1Jm522mA/DM4cxaQwzjGN9gbTR+sbjVSgKPNh9Knx/Crxadg
 x6yyFlZeEzs/IptmRgfOXumcycavxEj5KHXhJaWK9myjNs9X5Mgd0jX/LJ8SXIi7cA+jTXN9GaC
 Nn8bKkz2U86TAyJe6bK2OF3vsPynubqVKMdnhcImaMPExfRpkXGnzH/UKkUB1Z1odYBDopjYA=
X-Received: by 2002:a05:600c:4f4b:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49d1f21afcdmr231341375e9.1.1789049075852; 
 Thu, 10 Sep 2026 07:04:35 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20db6e76sm147660745e9.3.2026.09.10.07.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:04:35 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 10 Sep 2026 16:04:22 +0200
Subject: [PATCH 1/3] configs: sei510: drop Android support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-remove_sei_android-v1-1-b7bcbcef3834@baylibre.com>
References: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
In-Reply-To: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
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

Android is no longer supported on SEI510. Remove its Android
configuration and use meson64.h for generic board support.

Drop "fastboot oem format" as well, since it depends on the removed
Android partition layout.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 board/amlogic/sei510/MAINTAINERS |  1 -
 configs/sei510_defconfig         | 10 ----------
 include/configs/sei510.h         | 30 ------------------------------
 3 files changed, 41 deletions(-)

diff --git a/board/amlogic/sei510/MAINTAINERS b/board/amlogic/sei510/MAINTAINERS
index c6039bc82e2..ea27e800983 100644
--- a/board/amlogic/sei510/MAINTAINERS
+++ b/board/amlogic/sei510/MAINTAINERS
@@ -4,5 +4,4 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/sei510/
 F:	configs/sei510_defconfig
-F:	include/configs/sei510.h
 F:	doc/board/amlogic/sei510.rst
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 689c12e388f..0ef6343098a 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="sei510"
-CONFIG_SYS_CONFIG_NAME="sei510"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_SYS_MALLOC_LEN=0x8000000
@@ -25,18 +24,12 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="run load_logo"
 # CONFIG_CONSOLE_MUX is not set
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_AVB_VERIFY=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
-CONFIG_CMD_ADTIMG=y
-CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
-CONFIG_CMD_BCB=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -47,7 +40,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_BMP=y
 CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -58,7 +50,6 @@ CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=2
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 # CONFIG_INPUT is not set
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_MDIO=y
@@ -99,4 +90,3 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
-CONFIG_LIBAVB=y
diff --git a/include/configs/sei510.h b/include/configs/sei510.h
deleted file mode 100644
index 0f8070b8d31..00000000000
--- a/include/configs/sei510.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Configuration for the SEI510
- *
- * Copyright (C) 2019 Baylibre, SAS
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
-#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
-
-#define PARTS_DEFAULT \
-	"uuid_disk=${uuid_gpt_disk};" \
-	"name=logo,size=2M,uuid=" LOGO_UUID \
-	"name=misc,size=128K,uuid=${uuid_gpt_misc};" \
-	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
-	"name=vbmeta,size=64K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
-	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
-	"name=super,size=2304M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=4820M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-
-#include <configs/meson64_android.h>
-
-#endif /* __CONFIG_H */

-- 
2.34.1

