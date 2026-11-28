Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B773606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bRk4FM8W;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=R5qjlMXe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 489486065D;
	Sat, 28 Nov 2026 13:12:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VY66BgXWLvbC; Sat, 28 Nov 2026 13:12:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2945260650
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871530;
	b=NvcOnoNQJThN7H0068PIRLmFl0EdM9LMKQYrCmrE4EfCLe+ooqprNO55eEhmWFvdV9a7
	 UZzPHUj9pvNLIERq5ZXWo4FLfXQKnKoJ7LkfUmX3HzZ2s2QfHshLFT5R5BwFusk3tvTS5
	 4+5HY4IZWeaeS50Ipe3+8OhPzcNROnkqOITRG6tRAyJUTydnNDvsASuph9K4426O8hVPq
	 D+OnITdKfYocg/fUfZ/2hAlzEs/2O77dJyBbcyf/92VKcr33T6JZvYQpIzT/cB7pB6ITs
	 isYaXp2Ub6IWJ9kmWaAssI2S/jHwM7VCPl2qV8DJU85y8vEu13U3Z/wSScgoZDW+sLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+1ivQhzXNbKFFlrPXiOvKDoGA61L3Y5PzuC4NA/YTRw=;
	b=tWPbLicVJ61Iw4ZVkaUbQ7BOVbJpWR0rTJpiDO+tXu9SNd4Y67PdVEMESEVdyREgik/D
	 PyrFaojhpIZmb5J/J17vsEeZMXLHMAolGZTwnGhrCt2E1yBtcgN5BDuUe6DxldxlSWHZ3
	 BH2bb36820cOdWJCheYoJH5K5eqHrPQocKOOelUPePK4ece9u+X3pxdXr24axglxlPky/
	 mwqjVIZY0tU1GJexpleVvhVPGg+c2sz+fucgea8lsWEecQHK5+ao14nn3YbKSjbFDvqF4
	 iaEtk+AOXbaDt7tDk1EHJm37tFLTNVA1nJWgBWiC3V8PYBAO2q4LgGo+Ba0hKFw4IRQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=R5qjlMXe;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871530;
	bh=+1ivQhzXNbKFFlrPXiOvKDoGA61L3Y5PzuC4NA/YTRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bRk4FM8WiGOaIXcljVxAG0QOqLNP2tSXlpI2ro4n5rHUsSZ9FDR/eQSK81ajk2U5b
	 3tpR+I1G160OyVIQIckpQr2C48ICB17eCtwMg8fNS9t2v+3fIfY7pBymKL287Vg2pB
	 Pjxx13blmOu/oHdJ13glCvdgcAHcPN3uaOT99ATifaVOuHBVxGJNJpIiMfx5g9+0El
	 z0Lt2eCYOERX+df0LuS1gAo3tDS8FQah4VL92+2x9hTXWzrOjfOO6fWU3ofbrIQcId
	 oHDXfoWAtAMLoQr0SqpjmFBEebFgpSeITMMnSMB7eWuApQmF1O3X0olbncVCH1tRjQ
	 e0H78X0D096qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2945260650;
	Sat, 28 Nov 2026 13:12:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 686133D9
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DB24606A2
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8zHq_1hqq3R for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0CAF060670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=R5qjlMXe
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CAF060670
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:55 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so81983335e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871514; x=1796476314;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1ivQhzXNbKFFlrPXiOvKDoGA61L3Y5PzuC4NA/YTRw=;
 b=R5qjlMXeJc7PLw1UMhiZvl1SUNVUbhA7BfacgzpoyNI2S6Ehg6ebTHbKBEk+Oko72b
 7U7XXyp4CTNTaUgMrY2SkOTMXAyfol9NW4x1rqE3QNmGqL2QNKYqtpJ5f09TZO2kE3wH
 dmr86g6oE566zSL3YCMwrlfv9eBTxIPXFnc94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871514; x=1796476314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+1ivQhzXNbKFFlrPXiOvKDoGA61L3Y5PzuC4NA/YTRw=;
 b=IQ2TJeGykz2ge4bMV839ruuIcIqbWhWP43WbTogBFwOQnWcbqdQ351SFpBdlq4oxJg
 SgrOACbwzlEOdr462BcYFE51+vvoCCRz1R+fHTbkTq0XctHyPp8L/ZhCfthx7quKHjpL
 oJiGrxWoVPsICek/DsxWZVWYXoqwPQDTMvmczBnNaG91Wv+VkFXNuIMfmUr5xX+pEEZd
 F49xgFycYzJZlEvU6Xu0nBuvD5tj9eTRik9XRhE84A0u9TZpPM39lKWtn18p7l2k4EA+
 34V6yuhxUjf7QTxnwYUBPXOo8yTXI4TxKAt92zkKZtzdsxPn6hXPmCMG6XEBGceimNKU
 CLdg==
X-Forwarded-Encrypted: i=1;
 AL+hErEynlvq/J0ibbfDww2coxBJ45qzYvJ0tLyFPbH0pz5y+ZN/n0MYHkD+O/Hoe/21j+BfprrvVuk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8sWb/YddU57WLbMqi2O0G5FmSN6GTd1cSt/EVk+aMoLpC7sFvw
 Wf7uhzuB6VzwNHQiIoeMoISeFYcudmA7u1nWWYRpRAOqi0gNLokYzy8ZI9OlVboq3XNiT8Nmh0n
 4vVUE
X-Gm-Gg: AZFdTZce/PrcGpHHqNs51bQEHVFxjfaSqI1Sik2JZ6hchkRAx6W+dzzuanwHpsydPd9
 xWtnT2zI+C6pOuZ9eRiVL1NkgcR45IKax3a1GhVvKbxVxmJuz2ph+n+O0WvxHI7AcPkejKfDvje
 AbhwjUJNSjrMyVcFCuKusF7w+uWfX5WPtTPH98QdsqIKH4bWOwzYnS7ZdC59/p5t/xEUFU9IPCM
 2uZ9OyE8IOUravu55pccoVWGCL59zazcvsGf9pQ45d575wLKvgnhrUNIpmtE0JtceusG2CGaTkH
 6ki878zA7MAFhvdbqAPxz2dVBCT6JTuF1b3xMCBfg+9iDQ+0lHe4bquRDLqsHXRz1ZK8DKRjZl7
 cbTIYkoMFt5IfglnvOVnmxaktfG4hKZiBfrDkOYDQXyaLQbDmRLP+r2o5c7MgRCeYnW/6lbbh77
 heZadGjFfleR5UtfAsNECfN6fD+HplXck0gJUyHTGMsYOi56fHwRHANY6Ko743rg3mZUWUwawpc
 je4Ssv/fskmAejlZq9oWqlgbM/Rr52gPg22lvP9CQ0RS07IX1nX4LvRew5wsbCdX+FDbkVwCIE0
 7EsZ9w2rY9QOfXlFkYkqoeqG9VsrH6CedJ21nlYRmKYKltsDUDCkw5SNj0m5ZB2+iSrN4xOssfc
 pc2MHzpLH7dqcvzO+DW62vMRlWPbxqEL4mrvUkZMlxMFVE2SUqBAdHPZXKKTPIv90CHCC+rp1EV
 dZeSwa/1ezqaHPbAt7Ij8rPoYLhw==
X-Received: by 2002:a05:600c:674b:b0:4bb:6847:791f with SMTP id
 5b1f17b1804b1-4bb8880f267mr526573325e9.7.1795871514066; 
 Sat, 28 Nov 2026 05:11:54 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:53 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 14/29] arm64: dts: st: support Engicam MicroGEA-STM32MP257
 SoM
Date: Sat, 28 Nov 2026 14:10:31 +0100
Message-ID: <20261128131125.2141352-15-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Support Engicam MicroGEA-STM32MP257 SoM with:

 - 8 GB eMMC Flash
 - 2 GB LPDDR4 DRAM

The SoM also provides an Ethernet MAC, but Ethernet support is not
enabled at this stage due to a known silicon limitation documented in
[1].

This corresponds to section 2.21.2 ("ETH1 RMII mode could have CRC
errors"), where CRC errors may occur in ETH1 RMII direct mode when
directly connected to I/Os.

The workaround requires use of the Ethernet switch (ETHSW), which
introduces additional DT bindings and topology complexity. This is
intended to be addressed in a separate patch series.

[1] https://www.st.com/resource/en/errata_sheet/es0598-stm32mp23xx25xx-device-errata-stmicroelectronics.pdf

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-15-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: c5ce8d7bcc787c8aa4896629c14fe7b837c78ec6 ]

(cherry picked from commit 64dbd1de4f75d254211eae12b8ed6318d2e830e4)
---

(no changes since v1)

 .../arm64/st/stm32mp257-engicam-microgea.dtsi | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257-engicam-microgea.dtsi

diff --git a/dts/upstream/src/arm64/st/stm32mp257-engicam-microgea.dtsi b/dts/upstream/src/arm64/st/stm32mp257-engicam-microgea.dtsi
new file mode 100644
index 000000000000..5b4287e86def
--- /dev/null
+++ b/dts/upstream/src/arm64/st/stm32mp257-engicam-microgea.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/st,stm32mp25-regulator.h>
+#include "stm32mp257.dtsi"
+#include "stm32mp25-pinctrl.dtsi"
+#include "stm32mp25xxai-pinctrl.dtsi"
+
+/ {
+	model = "Engicam MicroGEA STM32MP257 SoM";
+	compatible = "engicam,microgea-stm32mp257", "st,stm32mp257";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+};
+
+&scmi_regu {
+	scmi_vddio1: regulator@0 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+	scmi_vddcore: regulator@b {
+		reg = <VOLTD_SCMI_STPMIC2_BUCK2>;
+		regulator-name = "vddcore";
+	};
+	scmi_v1v8: regulator@e {
+		reg = <VOLTD_SCMI_STPMIC2_BUCK5>;
+		regulator-name = "v1v8";
+	};
+	scmi_v3v3: regulator@10 {
+		reg = <VOLTD_SCMI_STPMIC2_BUCK7>;
+		regulator-name = "v3v3";
+	};
+	scmi_vdd3v3_usb: regulator@14 {
+		reg = <VOLTD_SCMI_STPMIC2_LDO4>;
+		regulator-name = "vdd3v3_usb";
+	};
+};
+
+/* eMMC */
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	st,neg-edge;
+	bus-width = <8>;
+	vmmc-supply = <&scmi_v3v3>;
+	vqmmc-supply = <&scmi_vddio2>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
-- 
2.43.0

