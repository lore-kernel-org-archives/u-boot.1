Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F107C88E40
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18C91810AE;
	Thu, 10 Sep 2026 14:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LvTpIh29Jo6E; Thu, 10 Sep 2026 14:04:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 36531810B5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049089;
	b=aY0UZEWRgus4zRvGY0c0XC8QveTnYgKocdK0NNZVAOhia1abVALJ0ZsOpXJVSSXj0jHI
	 kChG6FsiFAwFJRi3gxAndP7RZW31sMEXQyX1qMXKZ3nrFtKZau2t0gZHxqz/dhV0O5WUb
	 DJvpE81uwn8IAbO9oVPWxfyq+ecZrYbqrkQxokpgITnbEEgU69TzlworUL1tNc/HAXZ80
	 kKXkoHZdQO54M8/arJNg/L2J4hhfTTOhuiOtqW1tz1gyHA2Jsc6AMAInThiElezptzJvM
	 b5sqCOSH3Jx/tsldfIse7ceRsItmJzZSqD4cMA3hC89jSTJP6xdPy8G4dvu/bJ10c3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789049089;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DaLoOW2uu/h4cUSSoUngVkh+ttTGZgP7da2caOc16R8=;
	b=dIorxeGkAeY3RpzkRQ6iA5U2WISgAhh93cI/pzKQC99YdDVImoRP5ddoUSYupXNbavln
	 zeukpVHbfDXPZsmRLn35xUVf1EQxP2bEvAUxZhCnAuraFGy7o230swCj8JaUv2mAYTrdm
	 4jglRNXru9pfRKWJ8OlCr3O4mWcC/N1A0udNrPYDh+sdUdbzabxFeRKqUAoYRqEh9orIE
	 mYv+JQCNNTeDRxKqLh38GV9/ci4Riy6noRVewC7WYKOgO3GJ/OyrMHbf4+1Mfu6St1NJJ
	 rjNsUM4sHHFYIy6kZIiMQHOqWCM9u9wivksuyVhR82EIlQABrY73lJ7j03prkFed8Yg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789049089;
	bh=DaLoOW2uu/h4cUSSoUngVkh+ttTGZgP7da2caOc16R8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SpPfOt2/nDWndiMmv00oBiUnDiphOz+yroGC+Src+Ec2AnakccR8WTCwr/MrPwnw4
	 mAshZMMM9Kv/pbc+cQ39cRmzxSEl6IoHCSbCNFJw2fy/G6LePYlbMCDi1lYQE2C0pF
	 raapWvtu+kFjE3G6/RbVYJJtz/xTTrXtkfttHjmxb7nbt4Cy1xAJ9llU6lwLQg3qIp
	 VP+HO0RZNAJjdU50t3OxW4+YJcVtOyl7YGXkBVdiPdzD8fkttqO419e5bBBuvgVaeD
	 YGdm2gdQnJFGP1C7mDVZGEUVhE8ccnjIPVW6ANdXr00lksWSPLdP7Ms2uuMGxdBA2L
	 EiKbFjzOIYH+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36531810B5;
	Thu, 10 Sep 2026 14:04:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BFC429B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25DC640680
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbY5CYua4w0M for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:04:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DB20440593
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789049080;
 b=awT4NPPkB2FDGshA6Z/hdZcMx6IuateQ75P4JLQUwvzfWTnQU8Xwl4tt1Xu0fF5xZa+U
 fsaR6ZPg+0w2tHQZfuIimlQTF3fyuWTHkPLmC0KaZD3MN3d5vr4foAr455MXcUUah/W8T
 cVCjUF1d6Xw8nP6TLUiOvvWLEHMZWv2Pb8RdwxufbNX53uDezLAKuEfYJ6HYYOdza0zo1
 Wt8ssda8aa2wBRb2DLxksYDV5lNvZHz6ofTsEhUIgf/BOdXYBdOf67Qpex3JWjg5pmRO6
 MNufBIqHic//IoM/EagPgbrGFOHUm00wcD2bNKHJksje3SRWJbk0S1N1UrTfOQ1BMdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789049080;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=DaLoOW2uu/h4cUSSoUngVkh+ttTGZgP7da2caOc16R8=;
 b=BeAoj7IqUHbPo9DgIsnUIk8jLZ7mQm8uvBeuGIOChenjlbjhDE3VtBtHL5swdMXKAY2T
 x+rNNEPePLP+t4Zq8wauTnhrKZ5QC8TUHJJHixMR0WORyWh0TF5J2wsKEoCW0lut73S/H
 WmvIdiu6OOP1IP838dAt1YnwcqgLa9xI52l/wBP/jp+23iZ2ZnRNWUylznbXTCafKIvbm
 rqiOHPc+EySwGxR7qo8qVMWYSQm9co4PEKQGBpAvkGOIS0nniENhFut1FoxqupK/TfLG2
 axpAAi1z5Gio7kqqpcIWkGCXBFHyS/Pm10mKVvOZEHkKaY9mduveqGVbB3O49DAR6ng==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZeCaNJdg; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZeCaNJdg
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB20440593
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:39 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso11619175e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789049077; x=1789653877;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DaLoOW2uu/h4cUSSoUngVkh+ttTGZgP7da2caOc16R8=;
 b=ZeCaNJdgrEEm4ohunKeyKfBWzTRAmJ3wL8bSXJWT2gBAR+MDY/IaET/6eqleTaeC6o
 1ieYsLYqO/oumZySSC7e5dj4hl695n1PEByT5hA1WLnwsTbsPR84YM5j2wuedgNk4VYY
 mqLR0k6hRWyN7nuPWQwfJl5KaBvEIVDHd64cHbPq3CAWb42ZOAmku6IqtROkKxgQaMdu
 27u4l1QBSyN7g0VDSX3Au3QBvtAKscVkALFUFKQMsePFTGAPzVsi7EnbcA9nvLiZwzlT
 SKh+XzUqcb3EQbnKeLXk1in6OKD0YXmtxicbv3ztAWHc552OKjbd0BVA0XAwlCA+DXnc
 +y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789049077; x=1789653877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DaLoOW2uu/h4cUSSoUngVkh+ttTGZgP7da2caOc16R8=;
 b=FJ6znNSOxF97vu2C6//wmqHeHEwZrWK1SFhWuG/lTR/5CY/EUFbWzpRYTc4YZbvC1v
 L1NyL75HHh9d6kEGF++yvjecEn9UOXyaYdO4TIhF9PkuoSnZqQPsuPfQ4ldfJr2nqsFI
 aZ26qSX0C5NgGwNtBWQFowt2DR1TNkwW5YoE8T+sNHJ/ioF6aGR/HXt+tHoP2Psu1Jty
 kiznmUQMYgVjLNWY+6krBH+MY+NFfU5Fz3gpT0EGhUTUHqQT/xosdl0AKajj5P04Xwq1
 yt5zl5tJh/K3C6gbx3kAopZ79lxzskJjharjjCIl9t1M9cgiKJSfnZVXybnosSDvp2li
 2lsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsbDafitUIpqRO5jJjFzzsjvkpo43v1cBVMjHaaGEIqGGSpAlEP+dBWJe6eDzmrMUD5u7ylwo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nUDwwN3pNN6SE+uU+UY23xq78gUK4IVti9hXbK4610MzFVNb4u
 8TpRf6KPz76mYmhxkU+CR+3pvtVo9W06DYFr5UOAxCHDFY8tUs3VmOw5qQh84T+Pn+Lr4c8dqct
 rVX/uH/I=
X-Gm-Gg: AYBFou1B8VHd2HANYYHHdU4ZA/rwdGvIXVW/oXmuZpbHojWnrvK4z7QA9aqNAm+MPau
 2U6lHNg6z6DlJs6okSb3ldG15xElJbsVQBv5wqA00Gq/1o7ckIRNgsmsgt93/rHghbN/SkXYfu5
 qzPRQVovSSL4GFMj9JFVPxssw7mGoe95K8H0oA80TzNnxsMKGPQzhnkSUNz2DhDLHUP4SvjJ8ML
 7GdgXTBPRk606/cVn2AHtUlUuaPLwv3nTj2f4fVAV4nC0kJR6w07r47ES9WM4oXsPrpTd42rKQX
 s/VG32xX+uXmnwNcxh8huuxQH+vVvRUwgLxM1yC9xzmRTfZP0KWNovD+JWJBsqePsOcRFXquq24
 6gyi9HLCo76SCLaAUDW1haEebhiXgdV+hSIvG6nD67zdXEQkrVbAUvaRUzPzYVrsdzfxoL8JT6y
 DAzy7CTuzQCEhjzgzUMZH4N6MRNSZpPHiNoyWU08aDxXMfjgcxbvMEVdc00Qp8cDzJ4FZt4OM=
X-Received: by 2002:a05:600c:548f:b0:49d:2936:8ad1 with SMTP id
 5b1f17b1804b1-49d29368cc2mr40579975e9.1.1789049077348; 
 Thu, 10 Sep 2026 07:04:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20db6e76sm147660745e9.3.2026.09.10.07.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:04:36 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 10 Sep 2026 16:04:24 +0200
Subject: [PATCH 3/3] configs: remove unused meson64_android.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-remove_sei_android-v1-3-b7bcbcef3834@baylibre.com>
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

SEI510 and SEI610 were the last users of meson64_android.h. Remove
this unused header now that both boards use meson64.h.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 MAINTAINERS                       |   1 -
 include/configs/meson64_android.h | 279 --------------------------------------
 2 files changed, 280 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e9ccca5ca4..e5bf89afdec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -198,7 +198,6 @@ F:	drivers/power/domain/meson-gx-pwrc-vpu.c
 F:	drivers/video/meson/
 F:	drivers/watchdog/meson_gxbb_wdt.c
 F:	include/configs/meson64.h
-F:	include/configs/meson64_android.h
 F:	tools/amlimage*
 F:	doc/board/amlogic/
 N:	meson
diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
deleted file mode 100644
index d6ef0a83a68..00000000000
--- a/include/configs/meson64_android.h
+++ /dev/null
@@ -1,279 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Configuration for Android Amlogic Meson 64bits SoCs
- *
- * Copyright (C) 2019 Baylibre, SAS
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#ifndef __MESON64_ANDROID_CONFIG_H
-#define __MESON64_ANDROID_CONFIG_H
-
-#include <linux/sizes.h>
-
-#ifndef BOOT_PARTITION
-#define BOOT_PARTITION "boot"
-#endif
-
-#ifndef LOGO_PARTITION
-#define LOGO_PARTITION "logo"
-#endif
-
-#ifndef CONTROL_PARTITION
-#define CONTROL_PARTITION "misc"
-#endif
-
-#ifndef EXTRA_ANDROID_ENV_SETTINGS
-#define EXTRA_ANDROID_ENV_SETTINGS ""
-#endif
-
-#if defined(CONFIG_CMD_AVB)
-#define AVB_VERIFY_CHECK \
-	"if test \"${force_avb}\" -eq 1; then " \
-		"if run avb_verify; then " \
-			"echo AVB verification OK.;" \
-			"setenv bootargs \"$bootargs $avb_bootargs\";" \
-		"else " \
-			"echo AVB verification failed.;" \
-		"exit; fi;" \
-	"else " \
-		"setenv bootargs \"$bootargs androidboot.verifiedbootstate=orange\";" \
-		"echo Running without AVB...; "\
-	"fi;"
-
-#define AVB_VERIFY_CMD "avb_verify=avb init ${mmcdev}; avb verify $slot_suffix;\0"
-#else
-#define AVB_VERIFY_CHECK ""
-#define AVB_VERIFY_CMD ""
-#endif
-
-#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
-#define ANDROIDBOOT_GET_CURRENT_SLOT_CMD "get_current_slot=" \
-	"if part number mmc ${mmcdev} " CONTROL_PARTITION " control_part_number; " \
-	"then " \
-		"echo " CONTROL_PARTITION \
-			" partition number:${control_part_number};" \
-		"bcb ab_select current_slot mmc ${mmcdev}:${control_part_number};" \
-	"else " \
-		"echo " CONTROL_PARTITION " partition not found;" \
-	"fi;\0"
-
-#define AB_SELECT_SLOT \
-	"run get_current_slot; " \
-	"if test -e \"${current_slot}\"; " \
-	"then " \
-		"setenv slot_suffix _${current_slot}; " \
-	"else " \
-		"echo current_slot not found;" \
-		"exit;" \
-	"fi;"
-
-#define AB_SELECT_ARGS \
-	"setenv bootargs_ab androidboot.slot_suffix=${slot_suffix}; " \
-	"echo A/B cmdline addition: ${bootargs_ab};" \
-	"setenv bootargs ${bootargs} ${bootargs_ab};"
-
-#define AB_BOOTARGS " androidboot.force_normal_boot=1"
-#define RECOVERY_PARTITION "boot"
-#else
-#define AB_SELECT_SLOT ""
-#define AB_SELECT_ARGS " "
-#define ANDROIDBOOT_GET_CURRENT_SLOT_CMD ""
-#define AB_BOOTARGS " "
-#define RECOVERY_PARTITION "recovery"
-#endif
-
-#if defined(CONFIG_CMD_ABOOTIMG)
-/*
- * Prepares complete device tree blob for current board (for Android boot).
- *
- * Boot image or recovery image should be loaded into $loadaddr prior to running
- * these commands. The logic of these commnads is next:
- *
- *   1. Read correct DTB for current SoC/board from boot image in $loadaddr
- *      to $fdtaddr
- *   2. Merge all needed DTBO for current board from 'dtbo' partition into read
- *      DTB
- *   3. User should provide $fdtaddr as 3rd argument to 'bootm'
- */
-#define PREPARE_FDT \
-	"echo Preparing FDT...; " \
-	"if test $board_name = sei510; then " \
-		"echo \"  Reading DTB for sei510...\"; " \
-		"setenv dtb_index 0;" \
-	"elif test $board_name = sei610; then " \
-		"echo \"  Reading DTB for sei610...\"; " \
-		"setenv dtb_index 1;" \
-	"else " \
-		"echo Error: Android boot is not supported for $board_name; " \
-		"exit; " \
-	"fi; " \
-	"abootimg get dtb --index=$dtb_index dtb_start dtb_size; " \
-	"cp.b $dtb_start $fdt_addr_r $dtb_size; " \
-	"fdt addr $fdt_addr_r  0x80000; "
-
-#define BOOT_CMD "bootm ${loadaddr} ${loadaddr} ${fdt_addr_r};"
-
-#else
-#define PREPARE_FDT " "
-#define BOOT_CMD "bootm ${loadaddr};"
-#endif
-
-#define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
-	"bootcmd_fastboot=" \
-		"setenv run_fastboot 0;" \
-		"if test \"${boot_source}\" = \"usb\"; then " \
-			"echo Fastboot forced by usb rom boot;" \
-			"setenv run_fastboot 1;" \
-		"fi;" \
-		"if test \"${run_fastboot}\" -eq 0; then " \
-			"if gpt verify mmc ${mmcdev} ${partitions}; then; " \
-			"else " \
-				"echo Broken MMC partition scheme;" \
-				"setenv run_fastboot 1;" \
-			"fi; " \
-		"fi;" \
-		"if test \"${run_fastboot}\" -eq 0; then " \
-			"if bcb load " __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
-			CONTROL_PARTITION "; then " \
-				"if bcb test command = bootonce-bootloader; then " \
-					"echo BCB: Bootloader boot...; " \
-					"bcb clear command; bcb store; " \
-					"setenv run_fastboot 1;" \
-				"elif bcb test command = boot-fastboot; then " \
-					"echo BCB: fastboot userspace boot...; " \
-					"setenv force_recovery 1;" \
-				"fi; " \
-			"else " \
-				"echo Warning: BCB is corrupted or does not exist; " \
-			"fi;" \
-		"fi;" \
-		"if test \"${run_fastboot}\" -eq 1; then " \
-			"echo Running Fastboot...;" \
-			"fastboot " __stringify(CONFIG_FASTBOOT_USB_DEV) "; " \
-		"fi\0"
-
-#define BOOTENV_DEV_NAME_FASTBOOT(devtypeu, devtypel, instance)	\
-		"fastboot "
-
-#define BOOTENV_DEV_RECOVERY(devtypeu, devtypel, instance) \
-	"bootcmd_recovery=" \
-		"pinmux dev pinctrl@14;" \
-		"pinmux dev pinctrl@40;" \
-		"setenv run_recovery 0;" \
-		"if run check_button; then " \
-			"echo Recovery button is pressed;" \
-			"setenv run_recovery 1;" \
-		"fi; " \
-		"if bcb load " __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
-		CONTROL_PARTITION "; then " \
-			"if bcb test command = boot-recovery; then " \
-				"echo BCB: Recovery boot...; " \
-				"setenv run_recovery 1;" \
-			"fi;" \
-		"else " \
-			"echo Warning: BCB is corrupted or does not exist; " \
-		"fi;" \
-		"if test \"${skip_recovery}\" -eq 1; then " \
-			"echo Recovery skipped by environment;" \
-			"setenv run_recovery 0;" \
-		"fi;" \
-		"if test \"${force_recovery}\" -eq 1; then " \
-			"echo Recovery forced by environment;" \
-			"setenv run_recovery 1;" \
-		"fi;" \
-		"if test \"${run_recovery}\" -eq 1; then " \
-			"echo Running Recovery...;" \
-			"mmc dev ${mmcdev};" \
-			"setenv bootargs \"${bootargs} androidboot.serialno=${serial#}\";" \
-			AB_SELECT_SLOT \
-			AB_SELECT_ARGS \
-			AVB_VERIFY_CHECK \
-			"part start mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_start;" \
-			"part size mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_size;" \
-			"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
-				PREPARE_FDT \
-				"echo Running Android Recovery...;" \
-				BOOT_CMD \
-			"fi;" \
-			"echo Failed to boot Android...;" \
-			"reset;" \
-		"fi\0"
-
-#define BOOTENV_DEV_NAME_RECOVERY(devtypeu, devtypel, instance)	\
-		"recovery "
-
-#define BOOTENV_DEV_SYSTEM(devtypeu, devtypel, instance) \
-	"bootcmd_system=" \
-		"echo Loading Android " BOOT_PARTITION " partition...;" \
-		"mmc dev ${mmcdev};" \
-		"setenv bootargs ${bootargs} androidboot.serialno=${serial#};" \
-		AB_SELECT_SLOT \
-		AB_SELECT_ARGS \
-		AVB_VERIFY_CHECK \
-		"part start mmc ${mmcdev} " BOOT_PARTITION "${slot_suffix} boot_start;" \
-		"part size mmc ${mmcdev} " BOOT_PARTITION "${slot_suffix} boot_size;" \
-		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
-			PREPARE_FDT \
-			"setenv bootargs \"${bootargs} " AB_BOOTARGS "\"  ; " \
-			"echo Running Android...;" \
-			BOOT_CMD \
-		"fi;" \
-		"echo Failed to boot Android...;\0"
-
-#define BOOTENV_DEV_NAME_SYSTEM(devtypeu, devtypel, instance)	\
-		"system "
-
-#define BOOTENV_DEV_PANIC(devtypeu, devtypel, instance) \
-	"bootcmd_panic=" \
-		"fastboot " __stringify(CONFIG_FASTBOOT_USB_DEV) "; " \
-		"reset\0"
-
-#define BOOTENV_DEV_NAME_PANIC(devtypeu, devtypel, instance)	\
-		"panic "
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(FASTBOOT, fastboot, na) \
-	func(RECOVERY, recovery, na) \
-	func(SYSTEM, system, na) \
-	func(PANIC, panic, na) \
-
-#define PREBOOT_LOAD_LOGO \
-	"if test \"${boot_source}\" != \"usb\" && " \
-		"gpt verify mmc ${mmcdev} ${partitions}; then; " \
-		"mmc dev ${mmcdev};" \
-		"part start mmc ${mmcdev} " LOGO_PARTITION " boot_start;" \
-		"part size mmc ${mmcdev} " LOGO_PARTITION " boot_size;" \
-		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
-			"bmp display ${loadaddr} m m;" \
-		"fi;" \
-	"fi;"
-
-#define CFG_EXTRA_ENV_SETTINGS                                     \
-	EXTRA_ANDROID_ENV_SETTINGS                                    \
-	"partitions=" PARTS_DEFAULT "\0"                              \
-	"mmcdev=2\0"                                                  \
-	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
-	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
-	ANDROIDBOOT_GET_CURRENT_SLOT_CMD                              \
-	AVB_VERIFY_CMD                                                \
-	"force_avb=0\0"                                               \
-	"gpio_recovery=88\0"                                          \
-	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
-	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
-	"stdin=" STDIN_CFG "\0"                                       \
-	"stdout=" STDOUT_CFG "\0"                                     \
-	"stderr=" STDOUT_CFG "\0"                                     \
-	"dtboaddr=0x08200000\0"                                       \
-	"loadaddr=0x01080000\0"                                       \
-	"fdt_addr_r=0x01000000\0"                                     \
-	"scriptaddr=0x08000000\0"                                     \
-	"kernel_addr_r=0x01080000\0"                                  \
-	"pxefile_addr_r=0x01080000\0"                                 \
-	"ramdisk_addr_r=0x13000000\0"                                 \
-	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0"        \
-	BOOTENV
-
-#include <configs/meson64.h>
-
-#endif /* __MESON64_ANDROID_CONFIG_H */

-- 
2.34.1

