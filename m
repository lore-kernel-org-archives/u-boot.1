Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A97606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M2NqsKOQ;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=r0jTVrQ6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF80360635;
	Sat, 28 Nov 2026 13:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ChUgkSXOguNi; Sat, 28 Nov 2026 13:12:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC21E6066A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871535;
	b=X2vCWmy7fb3b2GPv1NFFn5oHGYgc8PWkVivNmrZiTMdHn+SLQFsBFG7p3dnRvoXPlTam
	 X6iegsdKF5FpTtu9+P0NctCgr3ajnKHOVOLaNoBslPxjpVAh0itwsb0gJh1jPjPeeqFdI
	 fDICKG3ni8DuKe+dRPTyhEOd5jX6B3da5Niqmej9Yxd4/11eXitCONz5tMjOPTW4saQOI
	 9wRJpCO1gWZbhLAvTdb+bJ66oikf1+67nBfQZF6nE2riIwy0ZeLJ2Nh0l+hzSozHD8eO0
	 WR1Pe7oZF1h9r/z+Di25BkrnCJuyQFHB7ycMYTEWiiDYk+lVWutySl0yEET5EOdZKXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871535;
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
	b=rFTtTNwkc5R/Qbwvo3tpgZy+qApjbZoKuPEn2pMkjXZgp5XzuT3u1/GHgAOllzNck5Rj
	 s7mKySJ1KIwgIq88vJ8mlOp9OjXxcYOPwEaaz0+2AC5J6cgSJnA7lhPhvqgGoGQvlai0o
	 cIJRL0siTj9ugMWXGD5rCuVbYchnBNj+KVnTbh6cNb+EzCEfD/rRvpVEsJTiNz5yNEgDa
	 qLSYvTT87eNAraTDZdWTI+QQC5qAmD5bo8f4P3Im6TBK99Lh091Ebqw6+qZk8wEeN6w0M
	 9uj+LAErjZCldGbkmSU62aVELXBHiff/jk/k9DZNZ92Ud3i0NSyVQo5nMAtn6AZlS8w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871535;
	bh=mLeabquhLypPwGKl0y42DOfxQ184ltG1ldGGGUT4CXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M2NqsKOQBWtntbU3Se0g95tq4SfnhM+cCSnrQIcLYi6KtQJghnBvWqVJmSoaXu3YU
	 6m9XKVejdfGpD5nLuvmeILAX3RSoiB/zFJcKiSQKxea0kf5bxBfIF44+VNd/EVqJ6r
	 HbpECFJA12Hj70vhBPJ9+xt8SSLfajHxnFx0lo4MxfkvTGlNWaDGukQiG1uPa0X6XQ
	 ECNjwtIGqLa60JzEvFnhxQ2Y17IJf6Kpo2Le/BEHIoiF1Tc4bK++S2a63BLvbwnA7+
	 8u35LUK+JWkpooMIQREaQzTa4mbnplLeI1XQbEkJRrhsj3iCo+xmWoS6FLQ/lnkhFA
	 Ld9MJ8Hk8eWIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC21E6066A;
	Sat, 28 Nov 2026 13:12:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CDD70BF4
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4009400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NvdGLBt3iizk for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A34B54005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=r0jTVrQ6
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A34B54005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:00 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so70929805e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871518; x=1796476318;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mLeabquhLypPwGKl0y42DOfxQ184ltG1ldGGGUT4CXo=;
 b=r0jTVrQ6oL1QNXoUB6NztOAlUft5WBiGqy2INTo/peT5DHZks3FSKPi0Itu2WSIvlU
 XczQXAmoUuUJC4E0A86AMEPO6xUwcr+1ropMfd4fVAyLyZ1xq/FbEiXpQ1ytimV47Rh8
 incRDIi20OKcGbiUnLA9F3FKbQmufMi66yiKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871518; x=1796476318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mLeabquhLypPwGKl0y42DOfxQ184ltG1ldGGGUT4CXo=;
 b=TTA5Ia9fHVmRDxf30wA0LlGWG8raWmoLlrcOE6sFJ8ykyrYlqYZG8bx1S88hGceNz0
 nDkLaW6PxGI5n+c/nsSzQOEWcP1SRK0aa8IWf9V8xRWIdSO4ut1ZRDuhCe3XHBmkLW0C
 SMvxXRhOh2C6HNF1muBvrG9fTrQmMgSzVG11mUucogkSeRAotjucE7x5Pw3QnV8SMiVy
 qDsPirX4wIdDaQeYUBM6oKxFek2E+UUrfio/fOPNZDi5D5JwoBun3vVDMMJTo8/UnbTT
 /AkIsD/nmV7ad1J95bb6RP2oYhvoYFjiddW3ihNiybLgzkcOLg4Bvl9s4ZLTxW4zZs4R
 AcFg==
X-Forwarded-Encrypted: i=1;
 AL+hErHLPeSbdvt7CfOej44EC5xMU6eRnTYyny3GElE9XEu1uBW1XSS3bLykovYIHzE0ZyE+Zjxk+80=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+NKfSYiFVL6MFmSz9TT8b3UdSNcuXxlgJGFMj27Xr/VodeZsVC
 xWJpcXQs9dZt4Oa4US6KkIFfhk4J7sOCgAqrqT9yLRqGntBfZhmU5BmaX+Mfn286YYs=
X-Gm-Gg: AZFdTZfP6mEUc70wXY98VKydNL2ADn81EtCzYyo5DLu8jm0ggSuBkOsQGFQif9eGCAa
 vT+6G6DkNfmQKbZcGik25rmNkWjJpQ4c2sPmH9PqMwn+RFJEhmN4qoQpERCDawFGZ1B8JX+NXND
 x5mHyMXFW01oo4VXtWuBEdrE/cyFz/fmG232ZBCWQl+Y9JeNgelX1hemdZnXboD5gs+9rtAfX28
 HZOtWvyYjIZOM0EX7n2C4fBIwZgCQgePnsesjYNFc6fJCk1bxDivQhUzCvPTrnCB8y0DQzlv7wd
 fYECdfmjA7ubJpysgq466SG1Q1fAUpaP/8+gsCsVtonYSSwyKl/XrZylHzA2m3RJzXi6exVx465
 TqMxZaj/ZNoGwJyl/b5uss9WlJzhG8UVMYts5Oq7pL1u7tNTIE0Eb7enftsItKu8fALYybX6QBj
 Fw8z9i4Tv/eesojrQX51uVoKmuHqLWoB61g9TXYaY2cGI2KhJLyPOI8HYyc68i3wfiGSrP/AWq0
 ftjX4fOaILVNhJ81rpA7cWpWGgRxMhKLhuIrYwFpck53pXgshhM85XKs1nLzCfTKHNw4C0OpX8u
 NuZ1d3XZ1m/oRThL/G4EUiE+Qnphv4Vrna76vbiiA3r1gafzIERQD38ax9p8tAeeHhTuJwjO8ry
 4PcgXJUcJRRw6M0W1EpREVMQV7iwwBxE3CMBSNnQGuqQJUV1iAWUsINcdXu94bJYgZu7AkMIOBm
 K952ZVGKE0cLf8/+XgYKw26Ui6+TgM31OVMq242UAvZ7db4OY=
X-Received: by 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id
 5b1f17b1804b1-4bb8880fe46mr556794185e9.11.1795871518446; 
 Sat, 28 Nov 2026 05:11:58 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:58 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 17/29] arm64: dts: st: add Engicam MicroGEA-STM32MP257D-RMM
 LVDS display overlay
Date: Sat, 28 Nov 2026 14:10:34 +0100
Message-ID: <20261128131125.2141352-18-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

