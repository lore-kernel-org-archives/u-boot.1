Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F2606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cmU11mt2;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gCXKBPFD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B43F60AB9;
	Fri, 27 Nov 2026 06:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y8QBzVuL16AT; Fri, 27 Nov 2026 06:36:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5CF8560AAC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795761401;
	b=h0ThvOdlkfQvgtBHafepX6fdSplrmjlW8Vq9bBg08OBMskd+0m09MfPxCH01VbTPZklg
	 En/cUNC1sXaoXbY1XaeeQRoJZpEIpVESjtmNhhGfqG0mfe/34QxzV5kta3kEmrCZx91HD
	 zQhE7NglKa+te+4TMNrBFIpLBEKD+iYZT5uLbF6nJ09vNQMoOqLj9u+gRLmefzirjyGCh
	 NzOZiN+rmPZtD3Yyr4juZ2KwHw5d/Pp/GApLClwjwomgPoIqHGAxRCGURsGylwcfO2EQM
	 7AY3RI5sBGOIMgUR9aixd/txFS53IBf1dpAj+3VtsMqsFuBcuGW3pobCCcJYv2wFkRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795761401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=68O7M0XnKh/a+UNKVLMTBzF4WAy0vPvg7YKpwrBMZUc=;
	b=KmtOU5TkCRl4/Jtt7rjXtVXbShltFYHmmrWRX6AsW2e3pGKrxSKuvRGmJdXB+0j8Kli5
	 T6EvDwVCYYR17qpwsX7Rc579805+hhGLkKPk/YCOjH0FrDzeLaS9jSvuT6gZhWOvxttZl
	 K9xiHiUAHkOLa9yyX2XLc3Hu7xcEcDBqn3JPEhw/E2EkrZPSC1Q0tqD0pu+l/QPEmvQrM
	 gRMICkHShjTSWx0cUakRw23D5d2k5nTA7EMuwNTWFwtbgex/ane9M8vZ/vCogf4N7PbH4
	 n6U4MkBsCaUu/GzkmasNG3WSpriHV/S5GaU4xvOzi/HPC0pwHdoqZKz7nE5OW7K/DVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795761401;
	bh=68O7M0XnKh/a+UNKVLMTBzF4WAy0vPvg7YKpwrBMZUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cmU11mt2ah7WvjyTnA+Unr8J7OFbflHAtKITLTN4qDrGY8vsmK5dwSCbOnZGsT1Wi
	 hZ6idSVWhi2oWrKkyNT1fwI9Uq+KGMb7NP1dyfGH4mwzXWQ0Cjbmq5wNdgwcO8O3cm
	 W5qtc1K+w0o7FCfLpOnSP3BQI/aMuV3slrhmBkdJnDcntKBUVaVyu6nEVj3KFXbxfP
	 o9zycy8zbo1ao/y7Xp2lezGLEWp6SmHjeLNB366V9gtzSaWqHNWsutT9Uc2y5B6YNm
	 a+NwxBmywzkdnxkmTevsb1CMlrqUim408oBY4Fzbh24oIwRsT9Mk8sQ9ne5oBIeqo6
	 2Ux+Gg+73Q/tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CF8560AAC;
	Fri, 27 Nov 2026 06:36:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 599B62BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F3988115E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uW--sZ014Ttm for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC922811FD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=gCXKBPFD
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC922811FD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:35 +0000 (UTC)
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-33fb4680717so4132438eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795761395; x=1796366195;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=68O7M0XnKh/a+UNKVLMTBzF4WAy0vPvg7YKpwrBMZUc=;
 b=gCXKBPFDc4XPkWRW5y0Uaxy6J6Z81VeGjbjmSzFmveLeiWww7MrGzNxaYswUoE+d0P
 GQssfGTDmsQKH2kniado4sgobc8+qb3kjEGdJtV4yG5FMaZxVuZGzcgMLT4SZSNWL0xn
 edubGVKLEiYuKxdWMZJG+ay0RyXpancIcEJCSnZe39HnDUyI/7Mn2esNRdp7noIPvA/t
 XyasySfdktRfnJO4DBLeZmMASLnRfG2UqJF3rG8k3dJnGlbhtoCLItS+DKYdX1r74m/I
 KkUvdRU7bnBwMi/b70iseKTJXkMqw5xljA9P8gnEfnufFKVcKN/ipK3HEstDAmvd3qPk
 KFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795761395; x=1796366195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=68O7M0XnKh/a+UNKVLMTBzF4WAy0vPvg7YKpwrBMZUc=;
 b=BJaf6pncTtG2O7rZdgqNvUavS4Pjx1e39NbBmGFNYNe7TtJr/GLQiQ5Ce2buWmjf0p
 KcNN4IBuQ2VPw9Wz3jasitG9MJTgmtS9uBcyxFrYjHXF4GJnMpTRmFt+yDaC7ljJhfVq
 6dow4bqb5p8CGLEsaHhDU/ih5zSG9DyA3Ko/HJelSlSpHFJV5xFvXf8bXSMwpv1bcfw7
 LKqqa504U8y5bnGyQw16QuETFt1IUj8LEsN89+N9mzYunU5OOZqVbQp3TwzAPn1H/yRM
 LdHcGr0J2IvEyG8Y8JoDIMiH/6jC0xzh2kLv+6MmrIuPf+dczGXIbQS3wo3aLt7y7vO4
 WaTw==
X-Gm-Message-State: APuU4Z+DO+Tzx5Vbk4t6amYkQvmtj/B4qqjlInvPxMDp2l4GGHQxE7gH
 XwEdro5jfBGciZgFfjTn57/B1wolAURxB7arL7kyS5BlC9iFIqaz1HCf
X-Gm-Gg: AZFdTZcTNEF0TpryJRsF+smgKd+eDpe6nuaZfKOpA9iG3HIVAFprhrrwpuNgwcsXYZC
 Ciw33kDzwLNvPl+rSp9Q8y/yGfDbndtu+q9usgAQDpngOZIdxbi6BjvllOly9aUBCmf4PIUG7Ev
 JTokyL+O2/sp3RyU9itG8sooci65BjxwvKibfMT+lpPeuGYopO72eOdF67MiQXxXjbIxe2rbhNg
 nC8sRhLRM+rAEI01eci7ehW9j260q/o82chC5Rnuqcw2Renf2spzSIKIQ/ocbCQlIj4C9RqW2Bw
 h1YV2OC+QJQ1AAp5tlA/Akw2soKswyqopXTiuR14Pz4XyXhxq8dQm3gCJs4igvIkaeZKplKRj4I
 zqlOBwTbfsFK36s6HHgMAc44ycouMgcsollIw5PazNBqm7Dqf3oPqvI3IWE6IDat2U16wzUx289
 Dwa8GMoTUaKKtc4vJIxpqyUL0EWQkLJbaE0N6q1sbm9vL7PcVcaCUNBy4sFhGNn0+cS42cglST9
 3VV7N0Fasj2DV6UxS4jhOlz1cjK/Qx/bdUmWn9TVxBVehvqEhNsKv+W8v/7Nsb/rv7EDp11k+IQ
 Oi/SCznEq4Cz7kbCSg3QG6BPoq4SCssmFREen4vZ0jbezNNkxzkO4DE8RX7MxH1tvAVaJ4KQaZW
 uQjNt00QK6wwuwmX8g9yQzno=
X-Received: by 2002:a05:693c:65c3:b0:386:e9bb:d9d3 with SMTP id
 5a478bee46e88-386e9bbda7dmr2052822eec.28.1795761394894; 
 Thu, 26 Nov 2026 22:36:34 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (55.11.81.34.bc.googleusercontent.com. [34.81.11.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672c6f31sm67452444eec.15.2026.11.26.22.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:36:34 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, visitorckw@gmail.com
Subject: [PATCH v2 2/8] arm64: dts: google: Add initial dts for
 frankel/blazer/mustang
Date: Fri, 27 Nov 2026 06:36:14 +0000
Message-ID: <20261127063620.399391-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127063620.399391-1-visitorckw@gmail.com>
References: <20261127063620.399391-1-visitorckw@gmail.com>
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

From: Douglas Anderson <dianders@chromium.org>

Add initial device trees for frankel (Pixel 10), blazer (Pixel 10
Pro) and mustang (Pixel 10 Pro XL). These device trees are enough to
boot to a serial prompt using an initramfs.

Currently only Laguna B0 silicon found in mass production phones is
officially supported. Further revisions such as A0 silicon and EVT
devices maybe added in the future if they are useful. As of today,
these device trees boot fine on EVT devices with A0 silicon.

A few things can be noted about these device trees:

1. They purposely choose to use the full 64-bit address and size cells
   for the root node and the `soc@0` node. Although I haven't tested
   the need for this, I presume the arguments made in
   commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase address
   and size cells for soc") would apply here.
2. Though it looks as if the UART is never enabled, the bootloader
   knows to enable the UART when the console is turned on. Baud rate
   is configurable in the bootloader so is never hardcoded in the
   device tree.

Changes by Peter Griffin:
 - Remove dtbo overlay approach and add individual board dts
 - Update to lga-pixel-common naming like gs101-pixel-common
 - Reorder nodes alpha-numerically by the node name
 - Add ramoops reserved-memory (tested with console=pstore)
 - Add reserved-memory for bootloader & gsa logs
 - Add reserved-memory for Android BootLoader ABL (used on Watchdog
   reset to extract boolotader logs / parse breadcrumbs / ramdump etc).
 - Add osc 38.4Mhz fixed-clock

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Co-developed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260918-contrib-pg-pixel10-initial-dts-v4-3-745eaca28b1a@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

[ upstream commit: 54edd8698bb1fb40c339d0cb2f15baad6993dd48 ]

(cherry picked from commit 77fa53f1644508c892edcd6312b14f0b947021c7)
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 dts/upstream/src/arm64/google/lga-blazer.dts  |  15 +
 dts/upstream/src/arm64/google/lga-frankel.dts |  15 +
 dts/upstream/src/arm64/google/lga-mustang.dts |  15 +
 .../src/arm64/google/lga-pixel-common.dtsi    |  22 +
 dts/upstream/src/arm64/google/lga.dtsi        | 413 ++++++++++++++++++
 5 files changed, 480 insertions(+)
 create mode 100644 dts/upstream/src/arm64/google/lga-blazer.dts
 create mode 100644 dts/upstream/src/arm64/google/lga-frankel.dts
 create mode 100644 dts/upstream/src/arm64/google/lga-mustang.dts
 create mode 100644 dts/upstream/src/arm64/google/lga-pixel-common.dtsi
 create mode 100644 dts/upstream/src/arm64/google/lga.dtsi

diff --git a/dts/upstream/src/arm64/google/lga-blazer.dts b/dts/upstream/src/arm64/google/lga-blazer.dts
new file mode 100644
index 00000000000..0894606624f
--- /dev/null
+++ b/dts/upstream/src/arm64/google/lga-blazer.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Blazer Device Tree (Pixel 10 Pro)
+ *
+ * Copyright 2021-2023 Google LLC
+ */
+
+/dts-v1/;
+
+#include "lga-pixel-common.dtsi"
+
+/ {
+	model = "Blazer";
+	compatible = "google,lga-blazer", "google,lga";
+};
diff --git a/dts/upstream/src/arm64/google/lga-frankel.dts b/dts/upstream/src/arm64/google/lga-frankel.dts
new file mode 100644
index 00000000000..7504222a728
--- /dev/null
+++ b/dts/upstream/src/arm64/google/lga-frankel.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Frankel Device Tree (Pixel 10)
+ *
+ * Copyright 2021-2023 Google LLC
+ */
+
+/dts-v1/;
+
+#include "lga-pixel-common.dtsi"
+
+/ {
+	model = "Frankel";
+	compatible = "google,lga-frankel", "google,lga";
+};
diff --git a/dts/upstream/src/arm64/google/lga-mustang.dts b/dts/upstream/src/arm64/google/lga-mustang.dts
new file mode 100644
index 00000000000..6ac0b5ef22f
--- /dev/null
+++ b/dts/upstream/src/arm64/google/lga-mustang.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Mustang Device Tree (Pixel 10 Pro XL)
+ *
+ * Copyright 2021-2023 Google LLC
+ */
+
+/dts-v1/;
+
+#include "lga-pixel-common.dtsi"
+
+/ {
+	model = "Mustang";
+	compatible = "google,lga-mustang", "google,lga";
+};
diff --git a/dts/upstream/src/arm64/google/lga-pixel-common.dtsi b/dts/upstream/src/arm64/google/lga-pixel-common.dtsi
new file mode 100644
index 00000000000..5aaa2e5af8e
--- /dev/null
+++ b/dts/upstream/src/arm64/google/lga-pixel-common.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Google Pixel 10 family common dtsi.
+ *
+ * Copyright 2024-2025 Google LLC.
+ */
+
+#include "lga.dtsi"
+
+/ {
+	aliases {
+		serial0 = &lsion_cli16_uart;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&osc {
+	clock-frequency = <38400000>;
+};
diff --git a/dts/upstream/src/arm64/google/lga.dtsi b/dts/upstream/src/arm64/google/lga.dtsi
new file mode 100644
index 00000000000..26a14b3a1b1
--- /dev/null
+++ b/dts/upstream/src/arm64/google/lga.dtsi
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Google Tensor G5 (laguna) SoC rev B0
+ *
+ * Copyright 2024-2025 Google LLC.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	osc: clock-38400000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hayes_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a520";
+			reg = <0x000>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <258>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd0>;
+			power-domain-names = "psci";
+		};
+
+		hayes_1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a520";
+			reg = <0x100>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <258>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd1>;
+			power-domain-names = "psci";
+		};
+
+		hunter_0: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a725";
+			reg = <0x200>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd2>;
+			power-domain-names = "psci";
+		};
+
+		hunter_1: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a725";
+			reg = <0x300>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd3>;
+			power-domain-names = "psci";
+		};
+
+		hunter_2: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a725";
+			reg = <0x400>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd4>;
+			power-domain-names = "psci";
+		};
+
+		hunter_3: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a725";
+			reg = <0x500>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd5>;
+			power-domain-names = "psci";
+		};
+
+		hunter_4: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a725";
+			reg = <0x600>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd6>;
+			power-domain-names = "psci";
+		};
+
+		hunterelp_0: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-x4";
+			reg = <0x700>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <1024>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd7>;
+			power-domain-names = "psci";
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&hayes_0>;
+				};
+
+				core1 {
+					cpu = <&hayes_1>;
+				};
+
+				core2 {
+					cpu = <&hunter_0>;
+				};
+
+				core3 {
+					cpu = <&hunter_1>;
+				};
+
+				core4 {
+					cpu = <&hunter_2>;
+				};
+
+				core5 {
+					cpu = <&hunter_3>;
+				};
+
+				core6 {
+					cpu = <&hunter_4>;
+				};
+
+				core7 {
+					cpu = <&hunterelp_0>;
+				};
+			};
+		};
+
+		domain-idle-states {
+			cluster_1_c3: cluster-1-c3 {
+				compatible = "domain-idle-state";
+
+				entry-latency-us = <325>;
+				exit-latency-us = <553>;
+				min-residency-us = <10000>;
+
+				idle-state-name = "cluster-1-c3";
+
+				arm,psci-suspend-param = <0x40010033>;
+			};
+
+			cluster_2_c3: cluster-2-c3 {
+				compatible = "domain-idle-state";
+
+				entry-latency-us = <345>;
+				exit-latency-us = <673>;
+				min-residency-us = <10000>;
+
+				idle-state-name = "cluster-2-c3";
+
+				arm,psci-suspend-param = <0x40010033>;
+			};
+
+			cluster_c4_deep: cluster-c4-deep {
+				compatible = "domain-idle-state";
+
+				entry-latency-us = <510>;
+				exit-latency-us = <1027>;
+				min-residency-us = <10000>;
+
+				idle-state-name = "cluster-c4-deep";
+
+				arm,psci-suspend-param = <0x40020333>;
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_big_c2: cpu-big-c2 {
+				compatible = "arm,idle-state";
+
+				entry-latency-us = <110>;
+				exit-latency-us = <413>;
+				min-residency-us = <3950>;
+
+				idle-state-name = "cpu-big-c2";
+				local-timer-stop;
+
+				arm,psci-suspend-param = <0x40000003>;
+			};
+
+			cpu_lit_c2: cpu-lit-c2 {
+				compatible = "arm,idle-state";
+
+				entry-latency-us = <132>;
+				exit-latency-us = <296>;
+				min-residency-us = <3610>;
+
+				idle-state-name = "cpu-lit-c2";
+				local-timer-stop;
+
+				arm,psci-suspend-param = <0x40000003>;
+			};
+
+			cpu_mid1_c2: cpu-mid1-c2 {
+				compatible = "arm,idle-state";
+
+				entry-latency-us = <130>;
+				exit-latency-us = <274>;
+				min-residency-us = <2720>;
+
+				idle-state-name = "cpu-mid1-c2";
+				local-timer-stop;
+
+				arm,psci-suspend-param = <0x40000003>;
+			};
+
+			cpu_mid2_c2: cpu-mid2-c2 {
+				compatible = "arm,idle-state";
+
+				entry-latency-us = <130>;
+				exit-latency-us = <274>;
+				min-residency-us = <2720>;
+
+				idle-state-name = "cpu-mid2-c2";
+				local-timer-stop;
+
+				arm,psci-suspend-param = <0x40000003>;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		cpucl1: power-domain-cluster-1 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cluster_1_c3>;
+			power-domains = <&cpu_top_cl>;
+		};
+
+		cpucl2: power-domain-cluster-2 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cluster_2_c3>;
+			power-domains = <&cpu_top_cl>;
+		};
+
+		cpu_pd0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_lit_c2>;
+			power-domains = <&cpu_top_cl>;
+		};
+
+		cpu_pd1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_lit_c2>;
+			power-domains = <&cpu_top_cl>;
+		};
+
+		cpu_pd2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_mid1_c2>;
+			power-domains = <&cpucl1>;
+		};
+
+		cpu_pd3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_mid1_c2>;
+			power-domains = <&cpucl1>;
+		};
+
+		cpu_pd4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_mid1_c2>;
+			power-domains = <&cpucl1>;
+		};
+
+		cpu_pd5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_mid2_c2>;
+			power-domains = <&cpucl2>;
+		};
+
+		cpu_pd6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_mid2_c2>;
+			power-domains = <&cpucl2>;
+		};
+
+		cpu_pd7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_big_c2>;
+			power-domains = <&cpucl2>;
+		};
+
+		cpu_top_cl: power-domain-top-cluster {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cluster_c4_deep>;
+		};
+	};
+
+	reserved_memory: reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		/*
+		 * Store ramoops at a known location in DRAM, for access by the
+		 * ABL following a crash-reset.
+		 */
+		ramoops@95200000 {
+			compatible = "ramoops";
+			reg = <0x0 0x95200000 0x0 0x400000>;
+			console-size = <0x200000>;
+			pmsg-size = <0x200000>;
+		};
+
+		/* bootloader logs */
+		bldr_log_reserved: bldr-log-reserved@95600000 {
+			reg = <0x0 0x95600000 0x0 0x100000>;
+			no-map;
+		};
+
+		/* gsa logs */
+		gsa_reserved_log: gsa-reserved-log@a61b0000 {
+			reg = <0x0 0xa61b0000 0x0 0x00004000>;
+			no-map;
+		};
+
+		/* Android BootLoader (ABL) for ramdump/coredump processing */
+		abl@be000000 {
+			reg = <0x0 0xbe000000 0x0 0x1000000>;
+			no-map;
+		};
+	};
+
+	soc: soc@0 {
+		compatible = "simple-bus";
+		ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		gic: interrupt-controller@5880000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x05880000 0x0 0x10000>,
+			      <0x0 0x05900000 0x0 0x200000>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			#interrupt-cells = <4>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&hayes_0 &hayes_1
+						    &hunter_0 &hunter_1 &hunter_2
+						    &hunter_3 &hunter_4>;
+				};
+
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&hunterelp_0>;
+				};
+			};
+		};
+
+		lsion_cli16_uart: serial@db62000 {
+			compatible = "google,lga-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x0db62000 0x0 0x100>;
+
+			clock-frequency = <200000000>;
+			interrupts = <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH 0>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+
+			status = "disabled";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
+	};
+};
-- 
2.56.1.839.g22a8290db9-goog

