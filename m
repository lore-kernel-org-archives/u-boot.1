Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A216D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2B383CD3;
	Mon, 29 Dec 2025 02:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/aei4f3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A7A183BC7; Mon, 29 Dec 2025 01:06:05 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8023083AAE
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 01:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=aargri@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c75a5cb752so6116010a34.2
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766966760; x=1767571560; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QA2rduo2lhuOMOg/7Salgi8RwL2oY6xil1EmNYRUayI=;
 b=e/aei4f38aUBTdQMpX7lrwhYCIuAP2T0MTnpjT42Vhi/wRUrr1ANs7Vp7jkro4oT02
 enf7OYHFfQt/WdrlEgjcmVSUipJ62D3zqcV4PAswBL7ja9a0vB/Sap9gfU3/BvLzs5bj
 jziW7hmnPTfgjbRtxNXTCNPU05W4Ac57f53QvzIXABB1XmH0QfzdoCRMYdlPVPwjdigY
 KyLfIbuWkDuihOg/JOQyNAHIvksfUIjTD/8jKGYEcAu/zEFoxGMmjaFJfyGNo3/P1dsG
 2RvmVdqYtpI0pzSlvR4GpUW5tZWcYwwgiOwyGksvQFMfAWaQpcgEj0InO2J5MWvlVmmi
 8x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766966760; x=1767571560;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QA2rduo2lhuOMOg/7Salgi8RwL2oY6xil1EmNYRUayI=;
 b=my3IkiYAeWaYXvaN4/ooJ6CVbHvCQJgNSfsCs3TQIGJhX1pQUUGhEuMlbusz+STOaG
 MDY3aLN/lpdX2rYblRpyXnvgeG6FSJBFgT4BT1PT20tsRyRw7lwqgxPEDRw2dVp0Ytcb
 1GNU722f9l9mwXWxIEtzruDcxOGoiQkSttKsr06pQY9wuNkbqrIaxhjEv5QjIuJ8QDsQ
 92herKCa3nszNQAI2tvVoRbSCa6TH+tmhT3G6z7Y+G2sv55q/Q8Mtr8Imjgd5ZoMjP9b
 bxsGKtNT0D2tXM2IjrYVFo2cyXD3sd9bnZOBDx7GiCsFq3HC/C0tE2h5y97M75cBCISa
 3OAA==
X-Gm-Message-State: AOJu0YyRl2/uIjMxvwjYYOgKuK/wLqH5NR5Q5Rxlxv7/iNi7jBzNI7QF
 kLnLS8EZ4CL/6bdUsUQt548dib0qw3t85/Jb9+ZbL/fk8qo6Yfh2wgWK
X-Gm-Gg: AY/fxX6uFlzLDHMiCHbLSWVDnl7lTy7rfEDbWWZhiT516NIOYS9ijSwacxDFrpGZq54
 VdjLmHrRnSlZ+hmUmYKvJiiseQnE/H42xJqDdjBzEqSSPFLsE1sL/2PSGSHSFlJCnaovACKyU+e
 0LXG4HU/a0fPpiH0F7vBuV4pjQmzdODy7ryVK00WwHsntRxxMT+3UjASaaEX6/33KhdEI+a1ux/
 NQAiyppSKvzBNIlgxFn4h/pD05rmdu98eR0T8lIYHuugD5NtohRLA+0jXpP2k9NXJBehggtO4KH
 ciSUaTWAESbi3536WhgKHZW240hb3NgnwM3xQJiaPfob5a4deZnReB4l9NA8RzZIl+eZorTGMi0
 6RtGNAiMOGO/R3/xndEMteVwaEwH0zriLEfOomketn+wowRl1sSR2+fUbmAxQpvW7n33hYjsajI
 0nzf+DmQmX562ZaJlVQYmLqE9HYjTuqKlZeZv+dCRJ+eh2WqeEdqfwUp91piiVDVbZlbY=
X-Google-Smtp-Source: AGHT+IGGX+v7hBNGYKCL4DDGxwralFvQ5+yoXKQ+vNqSuNBL26Ies/+vNLF7JezeBfRUWuQcxh9t5Q==
X-Received: by 2002:a05:6830:3153:b0:7c6:aea0:3382 with SMTP id
 46e09a7af769-7cc66a0ebb9mr16761223a34.23.1766966760284; 
 Sun, 28 Dec 2025 16:06:00 -0800 (PST)
Received: from [127.0.1.1] (172-2-191-226.lightspeed.clmboh.sbcglobal.net.
 [172.2.191.226]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9468sm19397294a34.28.2025.12.28.16.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 16:05:59 -0800 (PST)
From: Aaron Griffith <aargri@gmail.com>
Date: Sun, 28 Dec 2025 19:05:25 -0500
Subject: [PATCH 3/5] rockchip: sdram: allow config headers to override
 ATAGs location
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-rockchip-tpl-use-atags-v1-3-8ac5140c3763@gmail.com>
References: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
In-Reply-To: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Aaron Griffith <aargri@gmail.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 29 Dec 2025 02:48:58 +0100
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

The Rockchip TPL on some SoCs (notably RK3506) place the ATAGS region
somewhere other than the default this code expects. This change allows
that region to be placed somewhere different by defining ATAGS_SIZE
and ATAGS_OFFSET inside a configuration header for either the SoC or
the board.

Signed-off-by: Aaron Griffith <aargri@gmail.com>
---
 arch/arm/mach-rockchip/sdram.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 2f39928bcbda2936fb4f079bbb72fa13f80af6c0..98c02570dc4e4a8315c25a5caad5d568db10c5d8 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -38,8 +38,12 @@ struct tos_parameter_t {
 
 #ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL_DDR_MEM
 /* Tag size and offset */
+#ifndef ATAGS_SIZE
 #define ATAGS_SIZE		SZ_8K
+#endif
+#ifndef ATAGS_OFFSET
 #define ATAGS_OFFSET		(SZ_2M - ATAGS_SIZE)
+#endif
 #define ATAGS_PHYS_BASE		(CFG_SYS_SDRAM_BASE + ATAGS_OFFSET)
 #define ATAGS_PHYS_END		(ATAGS_PHYS_BASE + ATAGS_SIZE)
 

-- 
2.47.3

