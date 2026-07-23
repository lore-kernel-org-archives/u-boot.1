Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D122C531CC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 17:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0777160AB9;
	Thu, 23 Jul 2026 17:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WpoiYelU33y0; Thu, 23 Jul 2026 17:37:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9C5E60AAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784828244;
	bh=UCtvqt7dvjWgVpWuwseVXOAtJOV1HOs35v4wF9L++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zjo2S2Eh/IyOwohLNdha2fcivUcp+DEhzFhrqQ6gelqs3IrC8u59gGT9rTgXfcPXg
	 I1cBygUP2D8MFh50LUtcvq2HdiqVKN6HmzpHekZHeUxMJtCEJF08E42UKi8GhJsR0k
	 aRDMze7zXesSLLpFEJPWnZMJ+wF1w8lmJ2DFCJQKDdTzUvsIQXWjJB0J34fvVS8/s7
	 5qjTIItAtwE+9w1dTteMvX3sAUVbg8DGX3dH8ufdbEdD1Un3awoFT5YuPC6Cw4x1ix
	 oJX+X5phcC8+5wMpRjbPS0WgmDB2iygqWxjyeSTXHelU2J87mArv12QTNl3uV8/FnT
	 1gU6S5bsY4QLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9C5E60AAE;
	Thu, 23 Jul 2026 17:37:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2729707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBFEA60A9E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kPja6Zo2deOe for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 17:37:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=andreas.zdziarstek@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DB99360AA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB99360AA6
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB99360AA6
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:13 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so8600325e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828230; x=1785433030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UCtvqt7dvjWgVpWuwseVXOAtJOV1HOs35v4wF9L++aw=;
 b=MrB8dkvR0h577fnqxF0NsQ9cDWh/wqCFVFrm2v9/DvM+3rXqTCTTj1myGW+GuyyTgu
 nxPmw2EIKCWUC1Dh3Qb4UIVwWisiteeg99D2NZHbYoHc9FZj7OrY+bgD/B1k5U/7Koyb
 cHSzj+BWMtGWYk5owq2vhIvTK9PUBbWlcbQruAFCnseqmCxmrqNYHaqEMBTzddyq4kYQ
 3Mr1zKaoHeq9JATx+jtTBxPs6PZwzCBJFbsMQZFFfWH6BeIXy0YD+Z6uq1oN26iS8gB8
 uOKeK4Qvy5YNr0C7M+TCpmHCEg0LqcydbqUi3A98S99Uk24sKzbKrSHwQPFepB4OU9e3
 vfkw==
X-Gm-Message-State: AOJu0Yw0entvAUikafaash+cjxIrbI5DgYub9z62UIUT0uVa+XYLFk99
 /dN74E2Etf2S/dkLbqPp8RBWt6QL+Gy5Iy8saa0QaIJMeM7V01Aj1/i7TRIIAYN/
X-Gm-Gg: AR+sD109da+2y5c09R5RFP9nZkQj9y/RB4SDYTrRw+CLmUjrVVRlx/T0k00zoMnO8xn
 RSB6Zp4+tyw9ZZ6//LT3lHVpWK3/5lTUG3DPR7njEww7qYhgBp6pmDvcxQn1JHEoWjh7L7DqsuJ
 UGLN8mSAS2Cd+70z44WHN+Pq3UYAbkTtZB+gmCC35IeUMx76Ii1dAhvEVrfSXW51Ia5tg0rk/eu
 Gnqff7q2/YRHjjxikF0FTj/A0GR9xsbFUAVSnRaED2bXF1S28+9BNPHbuezBYnYGwGathu5rGm0
 r8e60+bljJMirbtMuWyWP6PraOIXGxjFxEWRkE69+OoicmC8P7uXe1Xde6p/0FYDExiu8Nkvrf7
 7ya38MfyNIr2TO5TIEdplidkAPtAqCV6pIKD+dOmL07tkgxUm553JkbYet3NWWvGU1n/P4tdjLp
 eWFAMZUs/iWGvhsOaJF2rBJYc75SaNJEYKFG/1QnnSo3dO0qqhsjd3
X-Received: by 2002:a05:600c:4708:b0:495:4c74:6a14 with SMTP id
 5b1f17b1804b1-49573cc6d64mr45293605e9.14.1784828230266; 
 Thu, 23 Jul 2026 10:37:10 -0700 (PDT)
Received: from turbine.fritz.box (p5787a491.dip0.t-ipconnect.de.
 [87.135.164.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af914a9sm8497645e9.15.2026.07.23.10.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:37:09 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <u-boot@0leil.net>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v5 1/4] rockchip: rk3568: make the WDT trigger a first global
 reset
Date: Thu, 23 Jul 2026 19:36:41 +0200
Message-ID: <20260723173644.234688-2-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723173644.234688-1-andreas.zdziarstek@gmail.com>
References: <20260723173644.234688-1-andreas.zdziarstek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784828230; x=1785433030;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UCtvqt7dvjWgVpWuwseVXOAtJOV1HOs35v4wF9L++aw=;
 b=WN1T6XIKxcSCZUtiNFacVRTX9AW/iRXM/LRzKOF6tgiAwaYG7aGvXEdy+NDFcb+oLa
 X7mhpl4hOoIf/UxnhRv0jVnT8QjnZdCOZgQR/2UHbS38giX5aDmrpn8n46gu3yAuytuJ
 5rf+yFNZvHa5rdL3QEiaPE+t2Zw3+Gvd9bsTBsw1UIxERttm0x6vp4LLQv8/jvyUzx3D
 ZbpJthCCNhG0r/tYzk8/n8WWEgNsZvp8Xe9wdl/Gxc8xOVxQxBGlKNfiCF4LUvzudh0k
 LXC3/4j14BrZqMSW6SLu225LZFx2sDU7KPSNLfk4d1jhjDAbnNg7A2L/SLwHwpAGY6Px
 SMBg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WN1T6XIK
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

Default is a second global reset which causes a system hang on a timeout
in U-Boot.

Access the register through the rk3568_cru struct to match how PX30 does
it in arch_cpu_init().

Verified on the Hardkernel ODROID-M1S (RK3566): a watchdog timeout now
cleanly reboots the board.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 2b1eafee37c..8bed529a5c1 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -9,6 +9,7 @@
 #include <misc.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
+#include <asm/arch-rockchip/cru_rk3568.h>
 #include <asm/arch-rockchip/grf_rk3568.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <dt-bindings/clock/rk3568-cru.h>
@@ -37,6 +38,9 @@
 #define CPU_GRF_BASE		0xfdc30000
 #define GRF_CORE_PVTPLL_CON0	(0x10)
 
+#define CRU_BASE		0xfdd20000
+#define WDT_GLB_SRST_CTRL	BIT(1)
+
 /* PMU_GRF_GPIO0D_IOMUX_L */
 enum {
 	GPIO0D1_SHIFT		= 4,
@@ -117,6 +121,8 @@ void board_debug_uart_init(void)
 int arch_cpu_init(void)
 {
 #ifdef CONFIG_XPL_BUILD
+	static struct rk3568_cru * const cru = (void *)CRU_BASE;
+
 	/*
 	 * When perform idle operation, corresponding clock can
 	 * be opened or gated automatically.
@@ -145,6 +151,9 @@ int arch_cpu_init(void)
 	/* Enable VO power domain for display */
 	writel((PMU_PD_VO_DWN_ENA << 16),
 	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
+
+	/* Make WDT trigger a first global reset */
+	setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);
 #endif
 	return 0;
 }
-- 
2.53.0

