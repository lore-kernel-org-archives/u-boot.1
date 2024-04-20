Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465A1C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 10:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928458864D;
	Sat, 20 Apr 2024 12:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C5nLFpm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B2B8811C; Sat, 20 Apr 2024 09:09:48 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D690A88131
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 09:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so24038645ad.3
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713596984; x=1714201784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcDaC9/5Vp8sFrSNDO1KneeJUHfof5+6rm8eeJNpIqA=;
 b=C5nLFpm8kpYKz+qdkHykkcVE8LdiUsHa7oaOCd017ImAt5zGvrg9s3j7J2WusP2pQp
 xvOCpRG007dU6X3QhsDhA+Pa6nUXiPfnYfzAijKaoGGdQa8rq76crbEyZUtdWylLiKHo
 vVeru97p8YzWmPQoBHNTPnCW46ipfbn7ub36toZzRKOjEyrbgJmLosdP/aZpizCCshy+
 l5rnO523G6EC5Wf2dRpzEzLwf0ZOrbsKof8z7tsjfX7ji7XONgW8q39l6HhTRkDuaV+W
 dP1yn50scLNdibbXJlkhkS18fzqPu+Y1odGlXh8q0XMiMMHuBzE8m0kC7VVYGwzDL5Ba
 Mj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713596984; x=1714201784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcDaC9/5Vp8sFrSNDO1KneeJUHfof5+6rm8eeJNpIqA=;
 b=FhkofUmP/vGfdPVBTKOUk9P8Yrw+RgPkMbOBWP1saDxHf8U/LwMZAUmgAhsT2tWCLL
 L3sGHKzdw18jtjdhc++Rhdvx1nM/i3nD8ZceVVgh76Uk9Ytg9jLlZkT3qRQbgEokA8dN
 fZuAk7VjdiE1dRuMufN8sZZ0Es79e3CqmZOmqL26bHSo4/Pv4gxYdxsV4vr/qLSVcy7+
 Y1MEc0OoWZxKUc66SWTgujsSPpjHZp2/F0E+lJleGQ6bqIBL0NCn69Ru+uzyGx22Df6C
 3VrXZrHvB5KQPJQIXYyQ3UB0QaerOKSlDhyGVZCi+vXQkVv1XjvfB4eTLOlOr5ysj39r
 w5Pg==
X-Gm-Message-State: AOJu0Yxwr37QMOopWh7/RzxVu73W+OICzLFe8EmQdmEkrnanhs6UnAuY
 U7CqzJb4PHhOfhtoOnMX74NpQcEeRjxBWznLdj23UxNKAM8N3mlED6ub8Ltc7wM=
X-Google-Smtp-Source: AGHT+IHAN/8yNvmJ/UXEUcGaETUSGKxkyK4xeA29vw3TpMykeNLCfpyfQTPn4fBpQ4enyo1ZPuZMog==
X-Received: by 2002:a17:902:ea11:b0:1e4:b1ea:23ef with SMTP id
 s17-20020a170902ea1100b001e4b1ea23efmr5528312plg.49.1713596983895; 
 Sat, 20 Apr 2024 00:09:43 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a170903248500b001e43576a7a1sm4443065plw.222.2024.04.20.00.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 00:09:43 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] riscv: dts: sophgo: Add spi nor flash controller node
Date: Sat, 20 Apr 2024 15:08:24 +0800
Message-ID: <20240420070923.9154-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240420070923.9154-1-seashell11234455@gmail.com>
References: <20240420070923.9154-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Apr 2024 12:11:39 +0200
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

Add spi nor flash controller node for cv18xx SoCs

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 arch/riscv/dts/cv1800b-milkv-duo.dts | 13 +++++++++++++
 arch/riscv/dts/cv18xx.dtsi           | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/riscv/dts/cv1800b-milkv-duo.dts b/arch/riscv/dts/cv1800b-milkv-duo.dts
index 94e64ddce8..dd2c9cd17c 100644
--- a/arch/riscv/dts/cv1800b-milkv-duo.dts
+++ b/arch/riscv/dts/cv1800b-milkv-duo.dts
@@ -41,6 +41,19 @@
 	no-sdio;
 };
 
+&spif {
+	status = "okay";
+
+	spiflash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <75000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		m25p,fast-read;
+	};
+}
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
index ec99c4deeb..1623e354df 100644
--- a/arch/riscv/dts/cv18xx.dtsi
+++ b/arch/riscv/dts/cv18xx.dtsi
@@ -52,6 +52,13 @@
 		#clock-cells = <0>;
 	};
 
+	spif_clk: spi-flash-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <300000000>;
+		clock-output-names = "spif_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -197,6 +204,16 @@
 			status = "disabled";
 		};
 
+		spif: spi-nor@10000000 {
+			compatible = "sophgo,cv1800b-spif";
+			reg = <0x10000000 0x10000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&spif_clk>;
+			interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		plic: interrupt-controller@70000000 {
 			reg = <0x70000000 0x4000000>;
 			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
-- 
2.41.0

