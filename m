Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CF606A332
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bPn0WLuJ;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=IqSfpIN6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F9A9608E3;
	Sat,  7 Nov 2026 14:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y4jnP44ZxaFS; Sat,  7 Nov 2026 14:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 733F66080F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062014;
	b=Yv5zeMCExOeTS7oB+6SdF6eyTbkXiTAtk1nxj/rxz+SYh+jBDWD+RkjIyWS53vd4xCbG
	 YOQmR41QIwudxSAt9GjNl4LLdYoJeD8G3r28fctNprcUrm0/atIKW0/Y3h0oSXmyObBik
	 pim4K5CHFlzdumJnGo1b1SkxUr63pqBHR285lfqKZsoNM7UmxUtagAjNiT0Hncdq162Xi
	 BO+5v3K8q7KRJWENH0tPW0q4Zt7//SjoyvGNI69LIlHVGdbryv9xIuhSxodPbVzDToXLq
	 LVB3IK6wk+19F3bshimcyi5srDzn7m459j8MlADN51BOt89QGwI5lCPZjXLXYsVgTUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mLeabquhLypPwGKl0y42DOfxQ184ltG1ldGGGUT4CXo=;
	b=K9j4a8BhkvYatMDviQ+Q4eTal3xTv6yjsuPmD+lDLwwl/AYuz3cLLRHAhC04NJqVK3lh
	 EtuUmOqW/kx9hXIHv30pa7Mu8VtnEoWmC28Y/IF+kQAfe4NmPNFeWNMFSOB7FAZ1673bv
	 UOK7ml30gxcXGcfs1bYJILKk0fWUUb6xHnzOyaqUWsn1ll3FI/kXwFCtWZXMNc31g19yY
	 4C0z5zQy5IsniuqdYy9ABXVCKpQ7dVvxLWaVZYttuThrmthobCbJY7HCgJP/oHFTFfgpK
	 6tW8SFriEyRLGnNJlt0m/KQ+8+ECTQrye/Ec3UffMjidwI3vJmpa5NOLymXhcf7vmmw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062014;
	bh=mLeabquhLypPwGKl0y42DOfxQ184ltG1ldGGGUT4CXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bPn0WLuJOF3TJHDRVo0knQFOq43F5oYadZwoDvA4ymPzD6m6X0akDbMA70ZPRjPcG
	 AsbpQzghBujWE797cMmVUzytMTX22eLg2kxd7c9b5trE5C9su+S7pq4SG5U8HmSeZ8
	 wIGXPKZTI2hEJY6gohpxItrmwif07BJ/b0pZ6gyuKQh3NLWRpTGrc6QRNtKynR0/5I
	 8BHZdvPUDNG+rR3jW9eY5+EUPRvVVZ7HdXXD1T8Qnbt6NRx+ZgM6z9jJMbYNAVKwGC
	 79PFjHrbM/kuTjYqWCx3rpec9NCuOz5xLg6JU7XeG2RbP9kzSPMJZvTYumem9yOhbP
	 lB78zwS8OI/uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 733F66080F;
	Sat,  7 Nov 2026 14:33:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E1BC211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F51340762
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gec0r3cIOnnK for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E274340757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=IqSfpIN6
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E274340757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:22 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso787310f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062001; x=1794666801;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mLeabquhLypPwGKl0y42DOfxQ184ltG1ldGGGUT4CXo=;
 b=IqSfpIN6zkrtYAZg6SrXMhmoYznM4ewnnP6HRwdjze+Ndm1EaN+7u02JgMQWJHNm8y
 PAUQSNG6RowZRCP83WxdWU5ZCGUqOG7oMXdQDbJZeohQCnggbMX7bK2eVqiy3wsBkldA
 wwdOPzBzh0vgAtowejePHBYIrJj326ccihjEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062001; x=1794666801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mLeabquhLypPwGKl0y42DOfxQ184ltG1ldGGGUT4CXo=;
 b=dfuSab4uIzYzZsLQAgSO00WGD8wVfvqp6brHFBgT8E+lTA2e3rd8JHbtGX2Nsmo9fn
 AAkhvpJ/Ig0pSZAB9gBlje5fRrU1JO0ZNC0AkGUZFupaQ84W/VTTEF8u7dSDPs5fB4/+
 G2Tpd/OoWS5TQWIXzR+GDBuKS6J37IUpoIwksUBbkHg3EWkrKk3vvynakgZzEr8owuuL
 afUinObjoS6HKZ6pZ8YWXhb+Dk7kLvEOikaCHp5Ts0XXKY7bA8Q7HePTj2vlqIg0zhuR
 i5W68UiI2TOLcz4WnUKCUJhyn/osxYBzPLi6F6GKbegl4m2DtC2JNOeqXMAfxf4oyWpQ
 gMNA==
X-Forwarded-Encrypted: i=1;
 AL+hErEyIy2zgagTK9PFmUw9RGUlIF0uOcgQg/OcMv/SAgdBURlrpgHGlQ3Q/AhSqhe46Y0M8Fu63bE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Y3WH7RK31jMLKgJp/lFcCrPHfZ9er9EuiOpzlyHepzX/bRji3
 3CoYzkTAVEdDuoRkaDV83I8zwCNQFK9DHKpd6HMDiiWVI3qHG9Gw81RIGRv1NdDAgq0=
X-Gm-Gg: AYBFou3GrWfHguVGVMTmqJi4d+xBgJ/jym8XA5ardptmkXUmI2tLPA8OB9LBNcJ1rmc
 BXpipDCZHIP6FMWBcPeSRV8tldva1HfetuXbJjqFzCNT2LmUWglGXDTjUKu2QUe41dHhbWavx7e
 qb8UY30A/LqBndfA7/I8n78ikq2Ka/Eo3VeiGMDh5DwKh+AxAy8KluEtJxJUarVtMUccn0bKIm0
 PW7OQOcFCnxUQuUU+g2b6FvIK3oXqXHuRSdEGsSZScBgbfulY5q3xnswv3TQhxAmc/0KvPHLvYP
 F6DzIat40UqqOFf6QkrhUTmFXWPZbe72Mc0KvUuG/HZFcDKvgeLQv1sD8LIbJuuamD7h4SbYIcU
 imCu4HXh4Z+Jpmvbn6/pqRma7HdQotTJJkqgki/bJQl3YHH5torw9ot3pm1WA3LwdtYaGKi7nGm
 +/KbWMVenJ9S+Q7MZVIC6VtF4m5hdoQOkvKJx8/e62Nzqs7z/JfYEG6atWoMs/VEXrslKQ+0iiA
 OUNOX4D7RNsrjxnEY5iZw1NK6x/sJraU4Yth0GvXaRjlZ7TiKHym1TQczZv/adnkcQUitrLwNjt
 fUF6MhOT9ls+EQEzbRnHhJH4HWNkoKKXnCH9pawQHAzFIS67aJq1qv1gJ7WUC39yK1nShXopMh+
 pJ+rijEVIW5WSVWvBDWfMvOeZE9hO8Jmm9fdLFFn9TWgWiGkYUJcTPhhMsUbBuG9/G3gBYn+H/m
 DpN7dwiUrU8Z+y5RYtF5faEAhUcrPGkyZnPZ/EVLQsE5D6GLQ=
X-Received: by 2002:a05:6000:4027:b0:487:1575:ebe2 with SMTP id
 ffacd0b85a97d-492778d0df3mr11037993f8f.44.1794062000652; 
 Sat, 07 Nov 2026 06:33:20 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:20 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 17/35] arm64: dts: st: add Engicam MicroGEA-STM32MP257D-RMM
 LVDS display overlay
Date: Sat,  7 Nov 2026 15:32:07 +0100
Message-ID: <20261107143241.2236511-18-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an overlay for the variant fitted with the AM-1280800W8TZQW-T00H
10.1" 1280x800 LVDS panel. Its touchscreen is connected over USB, so
there is no touchscreen node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260923155333.610134-3-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 29ee49c0f82fffb8b0eed14b4ef3ff19ab89f455 ]

(cherry picked from commit 535f863022c1f9491a2d224023f5a6e3419ebc6f)
---

(no changes since v1)

 ...gea-rmm-overlay-am-1280800w8tzqw-t00h.dtso | 67 +++++++++++++++++++
 .../st/stm32mp257d-engicam-microgea-rmm.dts   |  2 +-
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtso

diff --git a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtso b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtso
new file mode 100644
index 000000000000..7655c1bf56b1
--- /dev/null
+++ b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtso
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ *
+ * Ampire AM-1280800W8TZQW-T00H 10.1" 1280x800 LVDS panel. Its touchscreen
+ * controller is connected over USB.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/st,stm32mp25-rcc.h>
+
+&{/} {
+	panel-lvds {
+		compatible = "ampire,am-1280800w8tzqw-t00h";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds_out>;
+			};
+		};
+	};
+};
+
+&framebuffer {
+	clocks = <&rcc CK_BUS_LTDC>, <&rcc CK_KER_LTDC>,
+		 <&rcc CK_BUS_LVDS>, <&rcc CK_KER_LVDSPHY>;
+};
+
+&ltdc {
+	status = "okay";
+
+	port {
+		ltdc_out: endpoint {
+			remote-endpoint = <&lvds_in>;
+		};
+	};
+};
+
+&lvds {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			lvds_in: endpoint {
+				remote-endpoint = <&ltdc_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			lvds_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
diff --git a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
index faedddc2c914..96b7cb6b5bc1 100644
--- a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
+++ b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
@@ -43,7 +43,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		framebuffer {
+		framebuffer: framebuffer {
 			compatible = "simple-framebuffer";
 			clocks = <&rcc CK_BUS_LTDC>, <&rcc CK_KER_LTDC>;
 			lcd-supply = <&reg_3v3>;
-- 
2.43.0

