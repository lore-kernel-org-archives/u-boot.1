Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3D4C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 17:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30BBD84A4C;
	Mon, 29 Jun 2026 19:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gvX62od3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB83849FB; Mon, 29 Jun 2026 19:05:28 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C8C84A29
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 19:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so1198771f8f.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782752726; x=1783357526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhE8k8ZeOTz+CLN29yMmkRutvcpTpg+fn05ZLh4ck4Y=;
 b=gvX62od3vbzT0brEUphuprPc1hMZgIeH5z1/8oNRn3OksvQ9nhSks1JbNWMjrEMgYD
 Cm3JEUBFU1t2UsHk+AmxLFB6v6Ap6sut8K32av51WTMx7lASr8h8HkQCEoBW3SFhWiYu
 8QZq5DsyhwvIaFtRN8U58mrABPiN+ZgwYndEtIUoFXBD2I4feusd80GpaELp1NZBWvqT
 8K9kyxj3LlnHaaahwAZ3I5SeI2Ow0oKLCd6IwAMHuZ+2PsjxobjTytZJFl1VjEVLwK6r
 0TRdz/ni7lg2fZ4V/5okMZhrEl/OdBF6ICG8PBDYFBDg03cUGR/8AQ8xeSBGPaIO7C8X
 4KSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782752726; x=1783357526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HhE8k8ZeOTz+CLN29yMmkRutvcpTpg+fn05ZLh4ck4Y=;
 b=SA+XagJA3uiwG3hX0cqa6Tnlzx9thyP6U2kgAjWA1iB6X2dowdrAamyypmWYeSaJ7l
 13lwuzuW6tzInpSpcyPXmckNdtaysOcgLxjQAV+MPpOiqtTy8nPaZPIOdAaasO8BbDtm
 EgWRtyukmJXlt1uDNwSfE0cG5KEY9iWoTtb34T1c0MKmyoyeNVNQnRafU8OMSS7qQlcW
 1XSifbOK6SiLLbgeiRrlTQ53aKzLyF2R6ah/yMinzPuidual2NF0qbjphPMcBEK103Oc
 ru1Pffkhg/2M9PrDduo1J8vyjWCg6QZ99DHqHT1qUoobK1dkS1/faDSSFkPB1r5KhNI0
 rqGQ==
X-Gm-Message-State: AOJu0Yyl9Ff9yyzHt1Dkl+yBuiP+IASJKjvEHbQlamq3IituUJKhp67z
 M6W34sByMqsNGMLDS/a1LG9I0G4iG19qmRYhenFyheDgd3N6ZLNznJxX2sY8Dwqc
X-Gm-Gg: AfdE7cnBE5DA71ToxTaLncfgT+Gwi/9+GVYSoZybEepuHBMKtlaQgH3jBDN0kMAgskS
 l4alHc0crBt0SwIH0D7grgjspmv8L1Yg1vl8Znoq6GGXigIrrbH5FkQPs/PAIMIFZWwnBvfCv8Y
 fzKxeoMCESJH1Fllr4j3mLfG419ZZr2j+PUWXKndcQ28XKeB6SKR2TfPGdfQqVkrdU7AzpQk65B
 kXffjbb8asHZkyD2N6u6kGa98UGm21HAu9okw7vGcfyh+DliZX6z8XwgXeWaUs5uYNyRrf37T8J
 bbI0jrDOvSOY3t/A23GlaXsPgdZbUhxXHH1/EXl+k0L9QxF+UkqK3VGspX6yplhDWkPVV5tVRIX
 0f8IW2ISqBoGgphJCj3GicFuOfqW9tL0QSzIxEymrcSh46x+BxmHAwwhcup/NZM1tf3UFOEiN/F
 74RHVEiNvS2ARPW9XTwVRw09xGm7KCIj6uFoO+VXKX0FWs22O8Ql9tlQPpw+sTOxQ=
X-Received: by 2002:a05:6000:2997:10b0:475:3a97:8e3c with SMTP id
 ffacd0b85a97d-47550da070emr48896f8f.18.1782752725782; 
 Mon, 29 Jun 2026 10:05:25 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46cf775a4f0sm41791121f8f.17.2026.06.29.10.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 10:05:25 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v2 1/3] rockchip: rk3568: make the WDT trigger a first global
 reset
Date: Mon, 29 Jun 2026 19:05:15 +0200
Message-ID: <20260629170517.1436613-2-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629170517.1436613-1-andreas.zdziarstek@gmail.com>
References: <20260629170517.1436613-1-andreas.zdziarstek@gmail.com>
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

Default is a second global reset which causes a system hang on a timeout
in U-Boot.

Access the register through the rk3568_cru struct to match how PX30 does
it in arch_cpu_init().

Verified on the Hardkernel ODROID-M1S (RK3566): a watchdog timeout now
cleanly reboots the board.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 2b1eafee37c..87bd443e9c4 100644
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
@@ -116,6 +120,8 @@ void board_debug_uart_init(void)
 
 int arch_cpu_init(void)
 {
+	static struct rk3568_cru * const cru = (void *)CRU_BASE;
+
 #ifdef CONFIG_XPL_BUILD
 	/*
 	 * When perform idle operation, corresponding clock can
@@ -146,6 +152,10 @@ int arch_cpu_init(void)
 	writel((PMU_PD_VO_DWN_ENA << 16),
 	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
 #endif
+
+	/* Make WDT trigger a first global reset */
+	setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);
+
 	return 0;
 }
 
-- 
2.53.0

