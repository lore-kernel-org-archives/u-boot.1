Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA9FC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5215C81110;
	Thu, 30 Jul 2026 14:18:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vvhPSkyZszH2; Thu, 30 Jul 2026 14:18:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C27B8108D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785421115;
	bh=P0RkIrcGfzspLwB+CiGRlP/RPVlUqeE7uDwERrZEY5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H/fmgWgh0QHXgIrqH35BbZwgcvXadi/NtMwQPqjpgZB4J/2u4V2Vnp5YD6h82+l3T
	 S/bKe8LH6KYIlS/Jx1de6hnkTkLjQCSMzYXZPwMBd6GbnXBJWfn6F8TMLnj9eLwSBu
	 +UCTFi5Sc7151M2tToZ5IA2BJ3TQyQsoLavBc2uTMKC3PnwxbAHD25KH+anpgH2gk1
	 K/1g7T+mE2PuniL2kCMbYjDkcQvqK//GqWvxL6hs2bs9tVs6g/KqxRkjNJjsoSRi8n
	 y0H69zrGW8/GZU5/l5PefceA9/Bvj8+vkvxsihJl7vjc+XLuzGk4WUXn9zyJXEJ2tN
	 gZJfWTU+U4trw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C27B8108D;
	Thu, 30 Jul 2026 14:18:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BC5C27C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5202340B35
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZRBjp3aiK8pz for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:18:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 328E640B3B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 328E640B3B
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 328E640B3B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:30 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c160420289bso305535666b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421109; x=1786025909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P0RkIrcGfzspLwB+CiGRlP/RPVlUqeE7uDwERrZEY5U=;
 b=jJOWwGhT+Po1lYD0JVRjs7sW0B1kDEQi0U4setv0vKuYevT3dNl9+GFwcDRFIItcsM
 urWiXvj/rcHpXiFLT873HjOiwFqpHLF7sWbG1MR2zkYNrJC1KBsjXD9ex4yHtC281s/x
 wLLE20H+mlFKBVrptT5dbR4zylGf/Oo3GPdLXe2ShemJO9xfzWps8B9S4HkSUGfX9etW
 RmlR5N9hfnDfuLqomJyQYcnwUrOQoFJBI8Mvc+xDSlXsxRa06CxI/6Q8PiwT+5iF7klm
 AC6my2uAtQ2I6a46ZyUyhJSvCacG5p6+swua2gKez8kG37JTvbCJFYPbUG4oSYHFpfnp
 HslA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUFb1YK2/Qi3mGR79wcG9RvjHXBAu9h4aGwuwtsLymz1T11QsFEkXV+XvxrHcMRZPjZLGZYRs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzh8uNHXVU4eD2FRLKx3IHUIFCIZiQdQmG0WQvIkITymboi1BLY
 dIUeBIiq9qEEnwBkDaHIFXkLLWj7lTGPvQzKDNG9N1UO9jrTNXOQdwa8MggL5w0DEzd0C781z9j
 0O+JiCjrveKu6
X-Gm-Gg: AR+sD13bSxK1XX8YfXflhzO099vdc8aDMk8d7ws9RhvoRD+tKdyVDKzajhKjvVOUuA+
 nrSOQvxiepGnXw6TP3alI5xRYdgmMr4pqaG+8l7W6GTRdNIKdvX9xN2uZimcEI+bapx1MTowFHS
 PhpI4kucHjHuWmILcX637cGeQmBRt5ivbm08V82yvrATKin3EpGVY8m43oSRN+uWMZBms3YpmoT
 tdWaoCkB+NWd+X+BehlNlXtILOd9hHsDjjG9wBDg//QO70Yoyz0LZt7i/E7yd2vuxJmKacvzImY
 MwAsyyrPhFBjG6PWLpzSVGMBUptO1MLEaD/M3C1XiuJe/ZtSQZqJPd6GC9eRJyaIkb1jF87w1b3
 b3NCRcYpuAm6ERfsFG2bSIl9L61lWfReYbMDWy40ieoQnRc9eFJYzRwVZfTpiE2c+Tcr159dRX+
 ZMtjPgxq3xzDRC92r+OrlJXSTi3UdDKVLonb6xsNih//MAB/AirtnsaQi1YBdL14AeUZg9WDwcA
 sgpcVXjIACqT15GkU4a/EwbJnNr+BpmLsWgl7rf9p9P16d5RzjP+M7ItTNoL2Oxk2tbbZeYsmLE
 XFM1gA==
X-Received: by 2002:a17:907:6d04:b0:c12:34f0:49b6 with SMTP id
 a640c23a62f3a-c1fa578fd6amr148997266b.57.1785421109011; 
 Thu, 30 Jul 2026 07:18:29 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851b369sm78608266b.9.2026.07.30.07.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:18:27 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 30 Jul 2026 16:18:07 +0200
Subject: [PATCH v3 1/6] arm: dts: mediatek: prepare Genio 510 and 700
 devices for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-ccaione-upstream-mt8390-spl-v3-1-82fb3bca27a4@baylibre.com>
References: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
In-Reply-To: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785421109; x=1786025909;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P0RkIrcGfzspLwB+CiGRlP/RPVlUqeE7uDwERrZEY5U=;
 b=Oq81FbgvwmupQZjWc6eT31SslMOgATBa+46hYF5DvGo3WQ+Eacdq2jyxzw0Cx+dvjV
 lkELGsvkuFtPf5AAfR7+19h3S0bUChWpN2NJGsaR2VtVUhNJhdEeVSN2oZKQq/qYAqMW
 zucsKa7+GagHKh09LYSE/VBovAahv0AT5lEBwudqXJdo93aD97XUve6myAjs6WAXNL/c
 f9SEdJj40FRsqo+pRweMvaEjzGhD3MzjMOvB8SmpsIQkMODKtebSZo/+U/Oq41jz0WNk
 3veSIzYCPjG6I0kA9SDtAtMZ468L2hS2+fcHtaZ8MFuVHUYOJNkSvnWrMyFx8HHKMCMz
 hlaA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Oq81Fbgv
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

The Genio 510 and Genio 700 boot flows enter U-Boot SPL after an
external DDR loader has initialized DRAM. SPL then needs the debug UART
and eMMC controller, together with their clock, syscon, pinctrl and
watchdog providers, to load the firmware FIT.

Both boards share this MT8188-family dependency chain, so keep the
pre-RAM annotations in a common include used by their board-specific
U-Boot devicetrees.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |  2 +-
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |  2 +-
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  | 94 +++++++++++++++++++++++++++
 board/mediatek/MAINTAINERS                    |  1 +
 4 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 586d15bf72e..1a5f45cba6b 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
-#include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 586d15bf72e..1a5f45cba6b 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
-#include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
new file mode 100644
index 00000000000..87ebc64e6f6
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include "mt8188-u-boot.dtsi"
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
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index d99c6d708b2..d0d25b096e5 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -22,6 +22,7 @@ M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
 F:	arch/arm/dts/mt8188-u-boot.dtsi
+F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config

-- 
2.55.0

