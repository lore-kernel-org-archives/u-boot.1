Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4135DCD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 23:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5C6849AE;
	Sat, 20 Jun 2026 01:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBWXJFCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A85C848EB; Sat, 20 Jun 2026 00:09:17 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B148499C
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 00:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so20356275e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 15:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781906955; x=1782511755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfdUnSqz2oiuMSgGKyTf0fY3jqUk+tbpP7MrkV6b0nQ=;
 b=RBWXJFCt/QXVdA0MOP9Y0S3lvDWKphDj5mYK5EjWCqdzAaTawyPw8GGe0UDi8h4zsP
 D27JHlIy2ZwfYpRVA/awwdX7r4b4jsD5nsbv4bTSGBjiB2AgWB8mZHEs9G1rfpndRSKS
 tqxttp3PTy3Af9IcbTNo+eESl4ozZPXDFNS69q6eKeCv3PQOiPFBCaRGmChpbb7KTMDI
 NiGfT9YOSfBQISfa6abnVBDkWguwtFvG7Y+uonQyC5MtQ5Fx+DWMBBwTZ14T4mGQ/7CL
 KkH5uFw5eGh6TxiyymC4CUlgPrPk4ksOmX752JzyfRHfsq/9zlwU8qfSRBZO6EV/ob8u
 IlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781906955; x=1782511755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CfdUnSqz2oiuMSgGKyTf0fY3jqUk+tbpP7MrkV6b0nQ=;
 b=p8KK1f1nCLN0TkezfcA0/gFXtsCQMSLxUvcjtK26GcK0+IbKWNgOL65TokkTUSUvY6
 BVFR8rRyGIDGMDOXOIxbZT8J3tI4x0nV8Y+1MZns/G9I7uAm6NKdtkcQ6nyXyQ9FNPuB
 r3uQrt4JCdj0ffiiGuyHnGem4ytc1WXt1egz0Rev3W+D4K8IFJEE8HFJMB1vWnOuY9KJ
 LDz6PPaqih9SbgxWeJqWl+wGFprP6Fa18OxGlik0jyIBKdobOv+9M4khWhyCT7ppBeEw
 nUg/2KtFRW+457A7MRKcHLSBur9klLK1PE0S0riSU4OqZoG390nl/jO58dlQtzJOqfxU
 qesQ==
X-Gm-Message-State: AOJu0YxWWJ6f4dxPQfWrRSxcpU44KW+DdhEUGF6hH7iutWIg2g1ETZrJ
 p4ZE0blpVl2nBACx1WdYSskx4+tnfgHGd6vL2xUUvG1FLStQs0y7GOC/nRTCBCr+
X-Gm-Gg: AfdE7cl19dyrpW8OClLcmogfGO/Jkg+t2vtgbsFAAMlBOad3gwq8y065oZ33mnZS9u0
 XHn4zTs1USNbUSWGVt+hOtiiU1SI+wyEv6nF+kY2FH98TYHqSBvveWJagDDhmfTcYnsobH4OkGI
 bBuT72Owc92cE/+IBHrGh5mEyL3q6VeHA5TvW5Jnxtta3rhb4/iDspeGEuX7GMEF2Y+jF+Z/HAG
 2NtVitaGgFn754n+TejRk4Nc2eMkZDYi6k0a0a77TuojWaLnCZlbYyFCzPwSp1vwZErR1gDVXe9
 yMWGHT/GbDNVanUGh+xDvtVhoL3QcXPO/2h8wJetQdT9qiumX6fOY5TB7D5f45BB1BLYHjXgCN6
 RkHLxrcmhVzWYN7IAacmdUMNQXyYf1j/HlX5FNoBDcl4j5eJ+HhunejqvAsJjqYHCqxbaa2Vo1a
 mCMIf5dxxI9QtdoUeMKw3Q+Jc4DX/X9zUlf9ZRhCaVYS6xVSCWjj4bdhbNKVmmPQmchSMX1zMqC
 g==
X-Received: by 2002:a05:600c:1d24:b0:490:be78:1861 with SMTP id
 5b1f17b1804b1-492423140d1mr67875295e9.4.1781906954438; 
 Fri, 19 Jun 2026 15:09:14 -0700 (PDT)
Received: from turbine.fritz.box (p578499fa.dip0.t-ipconnect.de.
 [87.132.153.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4d9csm2176698f8f.4.2026.06.19.15.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:09:14 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH 1/2] rockchip: rk3568: make the WDT trigger a first global
 reset
Date: Sat, 20 Jun 2026 00:08:19 +0200
Message-ID: <20260619220820.301787-2-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
References: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jun 2026 01:29:08 +0200
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

Verified on the Hardkernel ODROID-M1S (RK3566): a watchdog timeout now
cleanly reboots the board.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 2b1eafee37c..77610a6a6ec 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -37,6 +37,10 @@
 #define CPU_GRF_BASE		0xfdc30000
 #define GRF_CORE_PVTPLL_CON0	(0x10)
 
+#define CRU_BASE		0xfdd20000
+#define CRU_GLB_RST_CON		(CRU_BASE + 0x0dc)
+#define WDT_GLB_SRST_CTRL	BIT(1)
+
 /* PMU_GRF_GPIO0D_IOMUX_L */
 enum {
 	GPIO0D1_SHIFT		= 4,
@@ -146,6 +150,10 @@ int arch_cpu_init(void)
 	writel((PMU_PD_VO_DWN_ENA << 16),
 	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
 #endif
+
+	/* Make WDT trigger a first global reset */
+	setbits_le32((void __iomem *)CRU_GLB_RST_CON, WDT_GLB_SRST_CTRL);
+
 	return 0;
 }
 
-- 
2.53.0

