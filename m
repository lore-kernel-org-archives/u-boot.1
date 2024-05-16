Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A863C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 22:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3478848A;
	Fri, 17 May 2024 00:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="hAGprsLC";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="i5aokhM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F1F8847A; Fri, 17 May 2024 00:16:49 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4840F8847B
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 00:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 6F21D114017D;
 Thu, 16 May 2024 18:16:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 16 May 2024 18:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715897804;
 x=1715984204; bh=5wsVYl5DYfdbbACTlhcq9RQbKafVnqIAW4RQkST78R0=; b=
 hAGprsLCYqkx6FvM2BpBDWbc2pRQX6iXPl0JQQQecQpInwDoWdHx1BwzzGjHIX0A
 9VmQfdC5Bf4NV7H4oZpxOLUJV/eooZtkR/0/D0iJYFYcWKh3p+oy++//FpPFaOch
 C4ATmPqc97+b1UBM8m+wCx/pcvpDAM6YRZQ19U9OmdKaoy1qFZ40IrddWgqW+kpm
 ceuhhQwlDt9DPVaXOpdFiguP1IsvRlWP0awVM6ro/dBFdiikZKZbWCLlviGilaFr
 7f1iHxSIZ7De3CDDYFwZZvkGNWfr3d4Fa38J+7SQbYXTnJ2An+ZIAXTOqY8tg3VW
 Z2dZ9257fC2G1bP2PVumjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715897804; x=
 1715984204; bh=5wsVYl5DYfdbbACTlhcq9RQbKafVnqIAW4RQkST78R0=; b=i
 5aokhM/2BB3m7/bAwS8EqeIdKtidMxGV3oQtHNl1oCjz62926EEPgCM7ve8hFGn8
 dxx2wXwwj2aX8AAOPtd9N94Kemj7UGYdSqrF7wDWx6ClR8MIZ6kIyrBD2KQDNe8R
 TPhknWBn8MArBodIjEBMKgz1YvIfitBkBgrHIv+VvmqKd0AeQXBVJ/J6fAu5Hqdq
 1Khw4LrdW77fO7vyZfaZSBzTo9wwvDtyTgsnx4uy7C2bZek8bm6f4jYesnsKLT4k
 UvWbbctJnClrcA5Ra3fHh5DxPVXiw84ywii+7H+m1tmE/FUgTw91tVk4xXiiOHRe
 1zbRF4sMFaokpXAc0W+Dw==
X-ME-Sender: <xms:zIVGZsoD1Li5N7u_kTnq154WHFnsaNxkio4RmNVce023Z945s7sdQg>
 <xme:zIVGZio12x_FX7YciojvN572GT7KJS9eHsBtJf5vwgWUtYRuU3X0hLvlYSXHGO4v5
 hHKkycMNcxTI2iOyr8>
X-ME-Received: <xmr:zIVGZhO3MeiInzx70GKCs7bkHjgAduTfnNZDwJNezDhJnQsixAvRYPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:zIVGZj5xDQzJ_CblBqieA79BgfsIL3A604NDyd82StfiZZx9ojdGzw>
 <xmx:zIVGZr6v4prX1lkNx1UOQmyHGET7E7A2-QvHdxlI7cTlTm4MHDhLjg>
 <xmx:zIVGZjgkeOSV-B70uTkTb2y-Myd-lEIuDBOOm1QkRAfatPLBIUxlJw>
 <xmx:zIVGZl5N750Ia8GugrDdMKMP-9hBdheSJAx_7jOKg1ovJbZQfnBQpw>
 <xmx:zIVGZoFdedfjaJFKW5GCAC_449FwTfZp7V4g-4ibcOkNMqvZBS1_XJ_t>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 18:16:42 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 23:16:41 +0100
Subject: [PATCH 1/6] video: Move generated bmp headers to include/generated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-rework-video-format-v1-1-f69822b742a3@flygoat.com>
References: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
In-Reply-To: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3231;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8kOE+ZUuYQfNp37iE630ezhBV00SMxcRgIDOSD1Rr0s=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjS31tNCr3K0mny7BHMm9eb22r4SknNNFsvZWvqYefprn
 rv+EU87SlkYxDgYZMUUWUIElPo2NF5ccP1B1h+YOaxMIEMYuDgFYCKayxkZ9ldyfNes6X+T0KvT
 OvuSydNlad8OZD6/NW/vx5dG7akNdYwMc96uDe6Nrw+8e7Zxy8ys+DD+9JzUe6lyOQ08lc+m2rD
 wAAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Emphasis that those headers are generated.
Also naturally gitignore them.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 Makefile                          | 2 +-
 board/aristainetos/aristainetos.c | 2 +-
 board/toradex/common/tdx-common.c | 2 +-
 common/splash.c                   | 4 ++--
 tools/Makefile                    | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 44deb339af19..77f3fead7f26 100644
--- a/Makefile
+++ b/Makefile
@@ -2191,7 +2191,7 @@ CLEAN_DIRS  += $(MODVERDIR) \
 	       $(foreach d, spl tpl vpl, $(patsubst %,$d/%, \
 			$(filter-out include, $(shell ls -1 $d 2>/dev/null))))
 
-CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
+CLEAN_FILES += include/autoconf.mk* include/generated/bmp_*.h \
 	       include/config.h include/generated/env.* drivers/video/u_boot_logo.S \
 	       tools/version.h u-boot* MLO* SPL System.map fit-dtb.blob* \
 	       u-boot-ivt.img.log u-boot-dtb.imx.log SPL.log u-boot.imx.log \
diff --git a/board/aristainetos/aristainetos.c b/board/aristainetos/aristainetos.c
index 8cfac9fbb342..bd7f00dfc0fe 100644
--- a/board/aristainetos/aristainetos.c
+++ b/board/aristainetos/aristainetos.c
@@ -27,7 +27,6 @@
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/sections.h>
-#include <bmp_logo.h>
 #include <dm/root.h>
 #include <env.h>
 #include <i2c_eeprom.h>
@@ -40,6 +39,7 @@
 #include <power/da9063_pmic.h>
 #include <splash.h>
 #include <video.h>
+#include <generated/bmp_logo.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index a6b45cdab810..ffd5946b4ec8 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -12,9 +12,9 @@
 #include <sysinfo.h>
 
 #ifdef CONFIG_VIDEO
-#include <bmp_logo.h>
 #include <splash.h>
 #include <video.h>
+#include <generated/bmp_logo.h>
 #endif
 
 #include "tdx-cfg-block.h"
diff --git a/common/splash.c b/common/splash.c
index c5591293634a..096fcba09913 100644
--- a/common/splash.c
+++ b/common/splash.c
@@ -62,7 +62,7 @@ static struct splash_location default_splash_locations[] = {
 
 #ifdef CONFIG_VIDEO_LOGO
 
-#include <bmp_logo_data.h>
+#include <generated/bmp_logo_data.h>
 
 static int splash_video_logo_load(void)
 {
@@ -121,7 +121,7 @@ void splash_get_pos(int *x, int *y)
 #if CONFIG_IS_ENABLED(VIDEO) && !CONFIG_IS_ENABLED(HIDE_LOGO_VERSION)
 
 #ifdef CONFIG_VIDEO_LOGO
-#include <bmp_logo.h>
+#include <generated/bmp_logo.h>
 #endif
 #include <dm.h>
 #include <video_console.h>
diff --git a/tools/Makefile b/tools/Makefile
index 6a4280e3668f..edbe3fabc105 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -283,8 +283,8 @@ always := $(hostprogs-y)
 hostprogs-y += printinitialenv
 
 # Generated LCD/video logo
-LOGO_H = $(objtree)/include/bmp_logo.h
-LOGO_DATA_H = $(objtree)/include/bmp_logo_data.h
+LOGO_H = $(objtree)/include/generated/bmp_logo.h
+LOGO_DATA_H = $(objtree)/include/generated/bmp_logo_data.h
 LOGO-$(CONFIG_VIDEO_LOGO) += $(LOGO_H)
 LOGO-$(CONFIG_VIDEO_LOGO) += $(LOGO_DATA_H)
 

-- 
2.34.1

