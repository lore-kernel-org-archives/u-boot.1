Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83E7C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99818406CD;
	Wed, 22 Jul 2026 21:36:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5vg446L2qDJL; Wed, 22 Jul 2026 21:36:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03094406DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784756207;
	bh=4FqHZrnIxyPqUTFt+ydmHXRhBMxDXIQRvCjgBsFDjLY=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=p/qSXVYxlJUfuOG7COeJ/ulHw2+eTS9UK1+7OmVUeEBc1+SWeRmCUxEf11MN1p5K/
	 e+IfRWNbxzS4MkfBbv1lcecuMUy2RpmCqardAfXqruqVfCbOHtJXlVbTcXC8mN8LHO
	 WCF1YAvndDbMJlNBr9ZY4FnQfYEDgcaHL/TZrBRl5xQwmmPMuynHFMKajkYfi2TzJC
	 TiQzBwV3kvCCORAE+j+hW3GkRsG/YLJDBdnoRfe82YtMuuQrf85QxQfbIJ0SJdoDcy
	 93/tVFINSR/spJ7Jj68oD/EP8LrPnLaYWtCGbC6inBjoEIiKyHAOvFEI9DaRNEPT5L
	 t7K2out2q/96A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03094406DA;
	Wed, 22 Jul 2026 21:36:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 43AAD390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35851402F5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajqaoNFjiMyZ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:36:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1793540082
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1793540082
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1793540082
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:42 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso36132145e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756201; x=1785361001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4FqHZrnIxyPqUTFt+ydmHXRhBMxDXIQRvCjgBsFDjLY=;
 b=XJPlIR350/iPZfa7iV9bw8PmqxlgJ9kb+v7whjLjTNQaMAKITimxkrPlpjSoK8Qdk4
 8h6kQ7yhcoe6zFRg+QKT3aXKMcC4h6CwIn6Fj4A6TXuMlrPeS/ZpZdLspO1rFE2TcZFi
 w2tIjw1W9yu5tJ/GRJg2HxPU/KXgxjRPvE29IHhbZjC3Qww4CZaSEsQ7NQuDl130G1nu
 WJWlLbo6aSlxAEjVFTGbfVEsAPHL6bBwD9srquppiQ5PE9aGL7yYawugSGU18/anj5DU
 2LnA6Gw/BaEWsBPTjKriHFYSbG1tz7w29arB62fsR7zKpQLNL0psvp7hrTDfC4UBeqhW
 WfpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrt6Slfq04XuGwbaZBP2LnMc0Mmiuhj0n/q+xqrmJRrbDcXjdwFscfr/z0LE0H7tmKM/wQllQM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxOZG7YUOzg9CLpuT7RlE0LBwPEx6uzkdCg3VsJkqIrkOkcict6
 QoQyZAEth/rl8kAnt9AZye1gkUNx+/2pOpBjTrPvjXmwpBbLKMvLe1rh9Rhi17ZVYxk=
X-Gm-Gg: AR+sD11vrXSssSkjsmgucbAdRWJLXojhqej/e3UVC1fPmujuSpnXtAts+xpOR0U45vT
 ENphW+eAFm0pWM+b1RorzB6Mkkn7+oO2v295TTR884f5GWPQ6vqj1FQL0xHaS59HEL41dShkEll
 828IxPTb5AsmL2X8+SuUu4N21Oru/hsrQ23owW6uOUo43+qtaO1IitF2vp6EHukpRVDI5wuhYXl
 WWt7B2M2rWmd24VTDsz7C3T5E1jcnQfVhzrvRmx9J8+6+rSXElvPT6swRb794FyU1W3zNwJlMe4
 yVYbRQs9S64oV62gXlG2jqOjmOeeUMSM6i+pwZiB4rGt6ZCX8bAlLaBhBmEhoqQabP/SOlHdosF
 Yc/BxT3ATf3R7Y9WQBSL+XdC8FdD2ZmJemmb6SvQTWg8edqJc4wn1FxVv4JsTUlxk5W4OgKEtkI
 1uBXbkVi6G+BgKNrNmBJxUZZNHcUX4BkJAE6NJV4FA0jxtBxB9TgNQYWCy6ok=
X-Received: by 2002:a05:600c:1c28:b0:495:4bf3:2150 with SMTP id
 5b1f17b1804b1-49573cc2f2cmr3868555e9.8.1784756200814; 
 Wed, 22 Jul 2026 14:36:40 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a509901sm174954605e9.8.2026.07.22.14.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 14:36:40 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:35:48 +0200
Subject: [PATCH v2 1/4] arm: dts: mediatek: prepare Genio 700 devices for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-mt8390-spl-v2-1-7aa005345711@baylibre.com>
References: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784756201; x=1785361001;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4FqHZrnIxyPqUTFt+ydmHXRhBMxDXIQRvCjgBsFDjLY=;
 b=OzCLw6AtCQwLQSIfSaS++nQhH92UsQXmwTuvmOqMzjZrhQ1qPNpRTQMfxKUZqUNfVc
 UvekyuYu7m1nfLme1Ky/6Zwx6vWBOQHlX4QK8mlrUTCh2+CB17uvAWJICKLSVo6u9nTN
 QUbOZB4fxoFxEVbQIg/1XvYWt5HW3aD3gS9v7onbo+vV0jiV/mMv6spOcZ8gOyqucAwO
 96PXT8yPHVWgqR3hR8NFY2mcMuFxX0TCzuMWydCAnL2pDC6SA15T/OWLjP5RsgTCX4/t
 HcHmr+CcfNDkqFnJgVa0MbxqDtHVd/jQ5/RjAyvUeSuHJxakAZU/vkaLdqufsMHPUVhq
 XT0w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OzCLw6At
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Genio 700 boot flow enters U-Boot SPL after an external DDR loader
has initialized DRAM. SPL then needs the debug UART and eMMC controller,
together with their clock, syscon, pinctrl and watchdog providers, to
load the firmware FIT.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi | 86 +++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 586d15bf72e..2b392c866fb 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -5,3 +5,89 @@
  */
 
 #include "mt8188-u-boot.dtsi"
+
+&clk26m {
+	bootph-pre-ram;
+};
+
+&gic {
+	bootph-pre-ram;
+};
+
+&topckgen {
+	bootph-pre-ram;
+};
+
+&infracfg_ao {
+	bootph-pre-ram;
+};
+
+&pio {
+	bootph-pre-ram;
+};
+
+&watchdog {
+	bootph-pre-ram;
+};
+
+&apmixedsys {
+	bootph-pre-ram;
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&mmc0 {
+	bootph-pre-ram;
+};
+
+/ {
+	memory@40000000 {
+		bootph-pre-ram;
+	};
+};
+
+&mmc0_default_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&mmc0_uhs_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-ds {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&uart0_pins {
+	bootph-pre-ram;
+
+	pins {
+		bootph-pre-ram;
+	};
+};

-- 
2.55.0

