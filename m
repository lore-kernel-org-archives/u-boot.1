Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B51C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 10:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C4C86E75;
	Sat, 11 Nov 2023 11:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QjaolVnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E98686EE5; Sat, 11 Nov 2023 11:44:47 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86ECE86E02
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 11:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5441305cbd1so4563907a12.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 02:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699699485; x=1700304285;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e+1GC+qj9BVs+Mg44mGic1I3vxKheAhj9j2BSr5gqbM=;
 b=QjaolVnbnK0UY3NDRuqfUpbYzPfo8XyMB5VEbCKkC8l3WScWk/eAcMxkbvj9cluNpx
 pXK+SfD41/zUVv3LjxIPrQ6uX0/BBgvgXpUhMDeIbV4JIWESIoBCFq1B3S/vAVlo9MG+
 d+mvWKzPI/VkGDC86Q1xS/jOPVASM5ooefuu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699699485; x=1700304285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+1GC+qj9BVs+Mg44mGic1I3vxKheAhj9j2BSr5gqbM=;
 b=PmDa1RHg+BJnAJgTSnlZycHaDKKVaa3djzVse+bHd4GpL3cdRnIWrsmi9I6GgUp19L
 qrMC/JIUH3Ot+EFIR/F8hBoA/+H2DQlqFt2nkWTgkphmg75rEDQjhP2HJLzB56U+xxvD
 q/bZt/AMS9jC/l3HnGm2uJOHC3XaPAs9fHJH6upYvHqlB5u7ahNZxtIsE7s7uHI2m2Wg
 TrTsNnTtz9Faz88JI4A3bqXaiF2yWJEwDIbAPg7gIXIiddg2fVpB0dkJl9ZIwkLpp1j2
 vg9a/Hov/UqLP3O3pzjV9HD8DR8j9K/t2GYQtGiIkoMUEOfZHVHCTGcEcVy7cQpfe2yW
 eeXQ==
X-Gm-Message-State: AOJu0YzrCosbfFi79mvG0fLP0TNEoLOzb/tqgpmaQaQGW3ClGUHbUsAY
 oNAySKHxPxs9KahI/jt0xu+Ec2atax+m/9n1NWEPWA==
X-Google-Smtp-Source: AGHT+IHHxeEu1fxpKm5KBi2rQ3y1fR8UP9CbTRM32nTDyaumpwLipkS6dpcPO0BI91k4l36B2M87Mw==
X-Received: by 2002:a50:fc09:0:b0:544:98ad:8e99 with SMTP id
 i9-20020a50fc09000000b0054498ad8e99mr1044060edr.40.1699699484795; 
 Sat, 11 Nov 2023 02:44:44 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a50d481000000b0053e5f67d637sm834078edi.9.2023.11.11.02.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 02:44:44 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32f769-disco: rework ltdc node
Date: Sat, 11 Nov 2023 11:44:36 +0100
Message-ID: <20231111104440.137117-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
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

With commit f479f5dbb7ac ("ARM: dts: stm32: add ltdc support on
stm32f746 MCU"), which adds the 'ltdc' node in stm32f746.dtsi, we can
simplify stm32f769-disco-uboot.dtsi and align stm32f769-disco.dtsi with
the kernel version.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/dts/stm32f769-disco-u-boot.dtsi | 23 +++++++++--------------
 arch/arm/dts/stm32f769-disco.dts         |  4 ++++
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm/dts/stm32f769-disco-u-boot.dtsi b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
index 2c823cce98b4..add55c96e21f 100644
--- a/arch/arm/dts/stm32f769-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
@@ -70,22 +70,17 @@
 				};
 			};
 		};
+	};
+};
 
-		ltdc: display-controller@40016800 {
-			compatible = "st,stm32-ltdc";
-			reg = <0x40016800 0x200>;
-			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
-			clocks = <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>;
-
-			status = "okay";
-			bootph-all;
+&ltdc {
+	clocks = <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>;
+	bootph-all;
 
-			ports {
-				port@0 {
-					dp_out: endpoint {
-						remote-endpoint = <&dsi_in>;
-					};
-				};
+	ports {
+		port@0 {
+			dp_out: endpoint {
+				remote-endpoint = <&dsi_in>;
 			};
 		};
 	};
diff --git a/arch/arm/dts/stm32f769-disco.dts b/arch/arm/dts/stm32f769-disco.dts
index 6f93fc7bcfcd..d63cd2ba7eb4 100644
--- a/arch/arm/dts/stm32f769-disco.dts
+++ b/arch/arm/dts/stm32f769-disco.dts
@@ -86,6 +86,10 @@
 	status = "okay";
 };
 
+&ltdc {
+	status = "okay";
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.42.0

