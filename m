Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B8606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rrDwFmdd;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jySdiGaA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3E6940A6A;
	Fri, 27 Nov 2026 10:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRcEbrIePM0h; Fri, 27 Nov 2026 10:31:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3053A40A57
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775499;
	b=E5fI7aokU6SdHpCX1Jv0DOak85XZDOWfYHjAUr/Sgjgyem/+fEEnHLG+uM120+XLgtkv
	 9UrkhN8szLjjKp7GQOXFBiqRFFBrJAlqAwinhFeeBCKgcf2HBM9tEQ1QmTpxamnMu480d
	 LVVvKWCQ4jDVGmltIFEFUpzRilAP9ZM6/6mkJo9vd8p+8YOGySHipnfnTa08NM8mjFNeQ
	 GZyq1D+1PQAqk+lGINI3mWhBVpBSzHFczmCaTMsSxAItuHKwMroNd4x/DM/0F0Z4izxCN
	 TADnzZoTWmW8CqSYsIA3nB964b/kbRNdviGCPOfOAM2xYxrXDzCMRaruy41PIXi7HkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PAEYkFxnGtJR5LjY9h/wHAOqwTs4UiFsJalTeBzPiRY=;
	b=dTF9ZkBQzzSDlmx0C+a6ZDdHbCzXoyJ6PD4Xpvgv+q8eaG88ODgsJPKo8TxaBJ3CgQGy
	 ZqBzBQDykT7omLkPnz2nY74Ujj6hZOAOwb4DuiTZa+eXuCV6MIxdJfqSS/eG4ElDu3BIe
	 dumiPzL957/zQOMh45CCdn7jeLkpSZD5NegH5JnsRr/SmiyRTl0wijDrVaYxrmHq77scD
	 3RH0AFtkorvcjfM9SvKiRsJTp6+U/NpEoGqXtqgtkq6w726wO0c9KhY3dVo/ZEHO//Mwl
	 Gjuv9quNxqkPf5Pwx/ASjNlku9Zut3cpg2TLUjOTK960HqyRNSZyREb0Sc1fJ/TJYkA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775499;
	bh=PAEYkFxnGtJR5LjY9h/wHAOqwTs4UiFsJalTeBzPiRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rrDwFmdd2EOHvtGouw8Gn261xAfJrngSZmuZoVyjYY95QKB9GBkUR9T5F02be2JJ5
	 Hx2JntvwHUfk1djFN56Xz8u22wOosYSzK9Nj5XMNFgakr2DvcDOl1KjuGns2ukLo0D
	 F/CEtQMXsDuFLQAz/I97yk3wHxJWKRsoqbNShBi/Lszvtg9mQ+mhGD5BEW1DR1K+GL
	 Ru2nnesfH4vblbDGaoF+vwsbJ8m2a/Hu5S96Afni13mtZxatgC3yjvOO+u9ks8js/M
	 jzozzkd/JJZNspnMj6kRMafCWOAmtV46vGeS344yDH9nu4cAK/Xs4UjidkaquBLgVT
	 oNmfi7cnnV/VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3053A40A57;
	Fri, 27 Nov 2026 10:31:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EFEC0373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D58278122F
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZtxvv1a-AMS for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:31:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2885B81248
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=jySdiGaA
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2885B81248
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:36 +0000 (UTC)
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-385d8a00598so11833079eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775496; x=1796380296;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PAEYkFxnGtJR5LjY9h/wHAOqwTs4UiFsJalTeBzPiRY=;
 b=jySdiGaA9/CBfQ6gNctiaWl3ZwipRwscpgn9wsKlP2ukBQQZCZBvh5uX8yxRHl9xlL
 p3/Y5Lr+xKE8vu88hYYHCvpKsg0TiES5UG3tCJ4HnlLkqSwo3vXirPcwrJF2BLcWTrqP
 lWyxNrjr9tUauCOOH2X9lY/3OlLzNu5D/dNSfXdKgcetOdj2DLl67SNeQtA+8j6yaI+l
 wiQHvY+F/++ckF7WYmKPf8Kh/C4evgc1BeGv1yoLV70UlE/3OwSJd/7rWPNtdf3kxLtX
 20xuC240CLfjHyywkn4Qnd787KTt0nzbXUAQHXxQaHzKTxBGb5QcNrZuBtzOlPhwGWUm
 yTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775496; x=1796380296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PAEYkFxnGtJR5LjY9h/wHAOqwTs4UiFsJalTeBzPiRY=;
 b=PoUzai7q/d5bWFks2tzGXRhEEjvq8zka5pSMMLg4k+YlO0f3UR6PUpx2ukzD0YcW3M
 xMyRj52/VhIct/hZmCcbIgfRHQjf3eJXJ/rVNcVNvbY6mCofEz75Atf6Hdz6AqgZF38G
 myRq7zSjL/ubKM64FFsRMb2Wgka+eu+6+g0TolK2NLL7cVu2VKUQ6aL76dK4dw99xGF4
 XnYsfjc+abnGxSmE3qE9krz0V18efhpikLWA7U6HzGYMF5/f+pOjcgzSM8En6kmTIDYl
 UbMaHtU155DazQw5z+g3NM8fsA6ugt+t0nmVY1JPEuPRhXvrEWuhTpWIqnF6x6VZfbtI
 OMtw==
X-Gm-Message-State: APuU4Z8M2KVt/iWRtA7sbdoNKJ8HNPZfp32X8GaFIUSz0tlFN+M/vq7R
 jJGHFPAVmOOV7Q9EnZbEw0AW8zMMBTVrk+Tso5mAPmxPBePe1un/CCCpF8gB0A==
X-Gm-Gg: AZFdTZfUprn0qf+OqOpzaUKOTV1COFU/UZ/E2aWgUgKyJ9NxC/2U0Jix1CNlgVRkGLF
 tksMlbgKpvy++0h9YOkuB+eNmyj581BO19xXjaypLbjmz1RGqldWvmRbuQq8srGUeHubgR/Fkfu
 BA7xJGoshxJ0YSgo71XIu3jTCKuKy3laKFcsq1OhS5M7FkUTtQK5ldUsCWwM2qnaEsFxRy9Ug/d
 I4hdvZj2mvyRByAiF57MbgVMdvEkhhypDhznQ22F4kQ5N/9ycqj/rQkSfsfE8Es6aBwfDoVuRFx
 BZiGhxlH+M3Lfapha19dc83a3jVjuTNdyCMqBzg8MYoZvzHNu93UULhG+jq6VKEBOGlN9NvZnlw
 pHjSaJnLky8wccCE1DgeujDQ18/vb5gWbQrseRz+xI+Q2JTw1mURDGosM9iRGVsMylQzRpSG/OH
 FtvFPU5sw9pbIb76NCbslsZics8plev2GyLRGM0FaMBq/+c0oySq6HRBOchurEnlR6LeNVQ4iFq
 +uF1gEP+BOvQ4LoPIEml6MMxmAupSZ7wC3RvXcynNTzFqCGPyqZQD9Fh8MC4l2U9MjoUYYn1Z59
 8pWJO61ltkfwo4RyqXBzwOpU/Cnw
X-Received: by 2002:a05:7301:f02:b0:378:7434:a526 with SMTP id
 5a478bee46e88-3856f8519d9mr23621343eec.14.1795775495964; 
 Fri, 27 Nov 2026 02:31:35 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:31:35 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 04/13] clk: spacemit: k1: Add GPIO and AIB clock support in
 SPL
Date: Fri, 27 Nov 2026 10:30:03 +0000
Message-ID: <20261127103030.4647-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127103030.4647-1-linux.amoon@gmail.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SpacemiT K1 GPIO and pinctrl controllers require their functional
and bus clocks to be enabled before accessing the controller registers.

These clocks are currently only available in U-Boot proper, preventing
the GPIO and pinctrl drivers from enabling their clocks in SPL.

Move the GPIO and AIB clock definitions outside the SPL conditional
and register them in the SPL APBC clock table.

This allows both controllers to enable their required clocks during
early boot.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Suggested-by: Junhui Liu <junhui.liu@pigmoral.tech>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/clk/spacemit/clk-k1.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
index 20b8595aa3c..646c81a2d60 100644
--- a/drivers/clk/spacemit/clk-k1.c
+++ b/drivers/clk/spacemit/clk-k1.c
@@ -379,9 +379,6 @@ CCU_MUX_GATE_DEFINE(CLK_UART9, uart9_clk, uart9_clk, uart_clk_parents,
 		    ARRAY_SIZE(uart_clk_parents), APBC_UART9_CLK_RST,
 		    4, 3, BIT(1) | BIT(0), 0);
 
-CCU_GATE_DEFINE(CLK_GPIO, gpio_clk, gpio_clk, "clock-24m", APBC_GPIO_CLK_RST,
-		BIT(1) | BIT(0), 0);
-
 static const char * const pwm_parents[] = {
 	"pll1_d192_12p8",
 	"clock-32k",
@@ -499,9 +496,6 @@ CCU_MUX_GATE_DEFINE(CLK_TIMERS2, timers2_clk, timers2_clk, timer_parents,
 		    ARRAY_SIZE(timer_parents), APBC_TIMERS2_CLK_RST, 4, 3,
 		    BIT(1) | BIT(0), 0);
 
-CCU_GATE_DEFINE(CLK_AIB, aib_clk, aib_clk, "clock-24m", APBC_AIB_CLK_RST,
-		BIT(1) | BIT(0), 0);
-
 CCU_GATE_DEFINE(CLK_ONEWIRE, onewire_clk, onewire_clk, "clock-24m",
 		APBC_ONEWIRE_CLK_RST, BIT(1) | BIT(0), 0);
 
@@ -584,9 +578,6 @@ CCU_GATE_DEFINE(CLK_UART8_BUS, uart8_bus_clk, uart8_bus_clk, "apb_clk",
 CCU_GATE_DEFINE(CLK_UART9_BUS, uart9_bus_clk, uart9_bus_clk, "apb_clk",
 		APBC_UART9_CLK_RST, BIT(0), 0);
 
-CCU_GATE_DEFINE(CLK_GPIO_BUS, gpio_bus_clk, gpio_bus_clk, "apb_clk",
-		APBC_GPIO_CLK_RST, BIT(0), 0);
-
 CCU_GATE_DEFINE(CLK_PWM0_BUS, pwm0_bus_clk, pwm0_bus_clk, "apb_clk",
 		APBC_PWM0_CLK_RST, BIT(0), 0);
 CCU_GATE_DEFINE(CLK_PWM1_BUS, pwm1_bus_clk, pwm1_bus_clk, "apb_clk",
@@ -655,9 +646,6 @@ CCU_GATE_DEFINE(CLK_TIMERS1_BUS, timers1_bus_clk, timers1_bus_clk, "apb_clk",
 CCU_GATE_DEFINE(CLK_TIMERS2_BUS, timers2_bus_clk, timers2_bus_clk, "apb_clk",
 		APBC_TIMERS2_CLK_RST, BIT(0), 0);
 
-CCU_GATE_DEFINE(CLK_AIB_BUS, aib_bus_clk, aib_bus_clk, "apb_clk",
-		APBC_AIB_CLK_RST, BIT(0), 0);
-
 CCU_GATE_DEFINE(CLK_ONEWIRE_BUS, onewire_bus_clk, onewire_bus_clk, "apb_clk",
 		APBC_ONEWIRE_CLK_RST, BIT(0), 0);
 
@@ -672,6 +660,19 @@ CCU_GATE_DEFINE(CLK_TSEN_BUS, tsen_bus_clk, tsen_bus_clk, "apb_clk",
 CCU_GATE_DEFINE(CLK_IPC_AP2AUD_BUS, ipc_ap2aud_bus_clk, ipc_ap2aud_bus_clk,
 		"apb_clk", APBC_IPC_AP2AUD_CLK_RST, BIT(0), 0);
 #endif
+
+CCU_GATE_DEFINE(CLK_GPIO, gpio_clk, gpio_clk, "clock-24m", APBC_GPIO_CLK_RST,
+		BIT(1) | BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_AIB, aib_clk, aib_clk, "clock-24m", APBC_AIB_CLK_RST,
+		BIT(1) | BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_GPIO_BUS, gpio_bus_clk, gpio_bus_clk, "apb_clk",
+		APBC_GPIO_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_AIB_BUS, aib_bus_clk, aib_bus_clk, "apb_clk",
+		APBC_AIB_CLK_RST, BIT(0), 0);
+
 /* APBC clocks end */
 
 /* APMU clocks start */
@@ -1309,10 +1310,14 @@ static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
 #if IS_ENABLED(CONFIG_SPL_BUILD)
 static struct clk *k1_ccu_apbc_clks[] = {
 	&uart0_clk.common.clk,
+	&gpio_clk.common.clk,
 	&twsi2_clk.common.clk,
 	&twsi8_clk.common.clk,
+	&aib_clk.common.clk,
+	&gpio_bus_clk.common.clk,
 	&twsi2_bus_clk.common.clk,
 	&twsi8_bus_clk.common.clk,
+	&aib_bus_clk.common.clk,
 };
 #else
 static struct clk *k1_ccu_apbc_clks[] = {
-- 
2.56.1

