Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0F5C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E03B1806C9;
	Wed,  5 Feb 2025 02:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LPilHzzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD010809A8; Wed,  5 Feb 2025 02:57:46 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0E01800B3
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5f4c111991bso213735eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720662; x=1739325462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQ+ayA7ynpV0p/V6WLgHSyOkrOP7g5Kgx4vFr8Wrsmw=;
 b=LPilHzzSscbtO7Vc6DzRvX0+VmvsV3BdiEyULQe5qybHXHYs5WUDqPZhtzN+177TjH
 FTIuKuKLykvU1f70oPPfAN4TM2U36nWF903wwF0LNBJfevlogED7tfQq39fJhFs6GhUD
 d+CPl/GAU9Lv1wU+nBzUKbYSwo4Col+0CX+Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720662; x=1739325462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQ+ayA7ynpV0p/V6WLgHSyOkrOP7g5Kgx4vFr8Wrsmw=;
 b=wNKprdqLf2kHRkUAX7wSdK81f4omyi6RRnxyuwHuirWYW4UlLIhqTnvKVaNPp9V05A
 GZkpW3r0sAClgqjTJsB0sUfPcy3qvBHLLKEu7yvsBLFRzXy/3l0jHt8/6SCmilUT7YSo
 JE41Vqa6fJBKY4COJqV255CmWOvJLLdndh3Vg01ERtQ3R81+Z0BaIYeCif7yhp81oLkr
 PTLrnvgxeCFeJQQS7UXco7NcqUXfTAfiN0/dDxR7FoTCWxxF1fqMD1xcnsZJO0fVVZD0
 odzrSOZiZOh4d3kRkJbr3Gg2mI+P9+SmKGcPCW54MOKxMPToH/g9saskRxsQFIVRg4U0
 iaDg==
X-Gm-Message-State: AOJu0YyFmjRQmdcCB9jbu3hO9/WsR1NxcYY5cG/HvUj6S2ya4hKAZ45u
 ucD0s7s1OD1/XE7atl3H9WOtbcmYusKSYbUlBTztKsqqwzHU8+CjC9o9CfrO+u7ZjUrnimdZj5Y
 =
X-Gm-Gg: ASbGnctrxGmAF+3/XflbV6epsMpt75JFax8hR7Mz5iKpVG5aUW3y2mAS56z6wbsLa/6
 gMQVYkl4dl1fxAvy8Cq1TL8wesE39tfkdxufIrAwTmgVDOwPOXU1IMBhCfV5kuhmOxP/84TPTbx
 gvdTZ4VvH0ZqoEDXboHxfmCiwQehmo3wf+RMJP8aup+MCTJutwRfVTdzl6tnTxlkKOrcVU6Ts1k
 XZNvnI/ONN0QF+tStQ7woJKC4GsygwDuC7MAP7FpmTAINGEXwqlFfPFfck9a39wT1vv97uxZ0QY
 rPZ+zPY3Grc/riN4F/fbVcIuTT3UTZA+kTGy+7BhR0JidFPSp0Yz
X-Google-Smtp-Source: AGHT+IEKeQ4GvqypmHmrxspb6wkAL3lcmWxyovGKUHhlVY+8oN1hm//XDag4VDQyyQtfRQGvk6YjuA==
X-Received: by 2002:a05:6820:1ca5:b0:5fa:61a7:16b8 with SMTP id
 006d021491bc7-5fc479ec7cbmr881465eaf.2.1738720662043; 
 Tue, 04 Feb 2025 17:57:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 24/29] rockchip: Allow SPL to set up SDRAM
Date: Tue,  4 Feb 2025 18:55:14 -0700
Message-ID: <20250205015606.2686149-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The current logic assumes that if TPL exists then it must be setting up
the SDRAM. This is not true with VBE, so allow this to be controlled by
whether CONFIG_TPL_RAM is enabled, or not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-rockchip/tpl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index cc794a7dca2..2a261199179 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -60,10 +60,12 @@ void board_init_f(ulong dummy)
 
 	tpl_board_init();
 
-	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-	if (ret) {
-		printf("DRAM init failed: %d\n", ret);
-		return;
+	if (CONFIG_IS_ENABLED(RAM)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret) {
+			printf("DRAM init failed: %d\n", ret);
+			return;
+		}
 	}
 }
 
-- 
2.43.0

