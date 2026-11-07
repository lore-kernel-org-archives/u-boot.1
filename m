Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F1606A338
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V9txbM3o;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=p4aEnsV0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 683E281664;
	Sat,  7 Nov 2026 14:33:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4v2pK6EFPrRl; Sat,  7 Nov 2026 14:33:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C79E2816DC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062005;
	b=TrxT2VCfEIeUG9nfiCb82QBeGscbdi2NpdDI8tb3/QnkOAalZxFDcid+xKNmQ/WJthSu
	 uMy0YLtnXbIhYzPTRHYz8aoCqGyVkeR0L8c/Xe0Cuyx/PGw6kp0tHx7dzWhpC7GbX2NdA
	 aM1f+I3RTjd/JrRmoszK/GpYtyHwwgOKNXUaeKpTkO4Y0GdGz6AE65XZ+UcdonOV5crDz
	 GUSsrXeLM/4MUQfDffJxuwaKHKQfYW3UFJBbChD0f6A5QwaZYZOhHsh06C2zGk4TTr0Li
	 Jz5wcL+Qc+YJVaxLdYiFq1fF/scmVQXPC2Oz8kJY95a+CXOV01l93DE3EferZ3fuLWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062005;
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
	b=a9yJYy1pEVAmXGO+f1S+6ukX4TUoAn5Jaasj6mreShNGOUJy9b9fpUA4hNkYyml0mH48
	 KwwiqkgnwDbF80mLrsv2+Zr6ua6dA/HISMWs0cC5TVWapJcJttwHIbemd9SDk81OK3gQw
	 EptrzVhi9H8xa6hQG1L9K7a8aLe8hHhmsABrQC6oEvfQjhMR4P1o3HYIyoEmgk1j/O+TZ
	 iMS3r5SZw7gzuUfbcJzZB/D8P/BE1n+hy3HB8C4KtDxfUd5ooSmApFOTSYRi+RTeFRDyC
	 lIUl2LDhUohjLvupg3lYMwxPffujz80hv7DsgXh0Z+rgYaD0PLPMZcltTATcH7F5vOQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=p4aEnsV0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062005;
	bh=+1ivQhzXNbKFFlrPXiOvKDoGA61L3Y5PzuC4NA/YTRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V9txbM3o9R5aDTE9Z/3VT+FXQ/mAZaDcQj7AXW9JhSEw4djDa2n6hu/rbEOczix+j
	 /yPEhw5YBsY5MxHzqM4tb02HHktum/vbH7fcBRUsf+MUFVtlBGufbbrFLS9Iv4X9Bo
	 bPMMolw3ROM/OVp/N1L3dizcAsvgqaJDPNjfxsdsjNPm5d1OjOXUWaNHyIA7qbGPi4
	 Y2UmSOrF0lbDBXqQvhOrIELJ51yJ6677xCVttwey3IPYnf4pPGrMfAB3ekqHwzQNeI
	 jJ/gwQSlTQxHQg+VdqSR5LGxUuu1LTB/vt3D4cCzYz7O8eP/nx91qJ4zyI+HxS5J+I
	 xVOFloGunpLAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C79E2816DC;
	Sat,  7 Nov 2026 14:33:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3184E34D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BC1D81698
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2FdYmo6S9y2H for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2DA01814B8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=p4aEnsV0
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DA01814B8
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:16 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so240007f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061995; x=1794666795;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1ivQhzXNbKFFlrPXiOvKDoGA61L3Y5PzuC4NA/YTRw=;
 b=p4aEnsV0Lbg3IkL7r1WFr+8PYuzCK6DK1BI9g5u0GFxgxt8fcp7LQfYLSo0fFYLx+D
 n8ZEeMH0kAFvsOQjdmXVbWBpcKpub5SzrKjFm5gENrxXxjRSjUaVI8Xk0A8hgEplWUJa
 cH5bSCO9JG3g+Hp6X6KK2uOgEeYLd89PJELzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061995; x=1794666795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+1ivQhzXNbKFFlrPXiOvKDoGA61L3Y5PzuC4NA/YTRw=;
 b=zxeTHuZhrqiXUFCOfX4puWo0G85L3cAhSZ+UTPd8bq+o+fsFtoFGxSI9qB6PtGijTF
 SLpKweur0hlTn9I+FaRsls+WOSNrjaKGLtbAIrBG+fs3oJDhLIXoNtfuQqLahyuSVqvL
 XWlG5KdUmSmmd2vWRq6oQ8Xpd1x+/s+lxR/nT6Ce6xqBxmTEHhp5p5ozLKrTQprb+CvJ
 O2+l1La4qcrLBCcaxpyOwVb+AMOOu8XUZ25AxNJkOj15Hs+kvNBCIlWc9Wp2O4g7iSqv
 lIyn3fcbErLquG8JmVL8d+dEVPiOUJlpBC++W0h/3uRkw4zhnOn4VDVb3xvMbMzTAW54
 FZog==
X-Forwarded-Encrypted: i=1;
 AL+hErEVJQX9Zl80f5aUMLGLV4tHhRnBJci25FUOiGj5/sK//1U61EC26t9m1Drct7xCnOINzAhVbNs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9T+Kg+R4LtVz70RnQOZIZXRULJ6VXd7xBP+XdyYrrLtLnSivDv
 AFANWPdFdlfe/Ayoy14nf30/0PSYhbq1rq4eYtmxzUnbiXpIP0SeSQMI4AGCLXh/M2o=
X-Gm-Gg: AYBFou2db9BUSy0HJcY5RjWaR+8QELEK6Yu5L4m3L+LKGJk0nDPx0KmOYvjiCutKyky
 L2iUos5FbQBuEBcJus2tCGfha+m4vCx3YuP/+OXfPxbMnjKMWABo8OfsC8EraJ7Pp0SO67KSzy5
 VG3M8E1hxzoxTMM/NiMS/VAMCCue8HyJRBPJOjdpXxvRsVIPj5JiwuUWyzImz8dGnJSipRQvLHZ
 jzgxqMj7PsXU4GAa50okgNqzE1q9k+QU01/u3ONtCzmtaQckB0r2AWXhvR22PXiZ5ed9XdEAGwX
 KRETUNcfNIOhM9XzisMIKKCWx9gk12ZFwk2D0jJoDILgnVXomUf1jSlNOyKi2bmxEPhqAQDKIOJ
 sR48diHIOuT0yZpVwkHcbjgR3AjbPg4osWfMIFnCvvNY5qnaA7ULP0UsWdCoq+xXVSQz7egcbQ0
 /tX195Tw3+ruFa8CsVurWfqNAZsMH1mEBpoxML4lhy5i7VBn2A4BQNL/2YBgBOCyN1vOy1wtqAt
 Ij2aO+BAjXMTy5KoC1WmDlGZ8Q+mlt1efdnR2DWvY41wZpJPo+YptvyWFEu9nRG6Aaqz6ZM92Er
 Hym6HY2RYK30ZR4qp7wDBUeRuAOfyykP2aj615JcOUMSkp7r7HlzlU/1Jxq1PxdRyPb4QqKFlSU
 O2k/1JbqpA2qNarLg3MBovDLEgH89K8ZAjsGVN0KnFbOuqeKWBDAVrvYsTmrrA7ZKjU3ThTbH8f
 Tw3hxbjoiBRLamTX+22/5JeipfUg==
X-Received: by 2002:a5d:59c3:0:b0:48b:1a0:5630 with SMTP id
 ffacd0b85a97d-492778d16d6mr11388708f8f.41.1794061994882; 
 Sat, 07 Nov 2026 06:33:14 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:13 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 14/35] arm64: dts: st: support Engicam MicroGEA-STM32MP257
 SoM
Date: Sat,  7 Nov 2026 15:32:04 +0100
Message-ID: <20261107143241.2236511-15-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

