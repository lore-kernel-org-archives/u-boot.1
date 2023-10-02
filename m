Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A03E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 12:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B43C887133;
	Mon,  2 Oct 2023 14:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="A0ekbQet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 459FB870FD; Mon,  2 Oct 2023 14:43:02 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DEC486DE0
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 14:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c1854bebf5so92244491fa.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 05:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1696250577; x=1696855377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNn8I4VxGrzC8AqDHg3U3BownhynTadSg8+ejsyhI4o=;
 b=A0ekbQetEGCXD/Yd3XkAOyZ16vom4M1l/+cwWSj+5Ui5Or7b3horUF6ffE1iwDrBdd
 tIRy6Tj5CThuHxns9RUpbPbl72OVOS72VF/3GnGor1YcWTrh7s0kutTrvCmm4lylh7zm
 Q/Kss0fv/wCxMLPg5DQFlMexRtT0Zhi+UQKGpnGBr6+i+Td6+WmRY16fUTvOGmK9mPbK
 Q8Jrbzm/PxQntl46964JIpLoFvt4iOJ7kERFbNNNYFWPUWU1FZoCq7dQ52Buxcn/aC8l
 RIlGUCtwUiAdpaotxwrLplmAXF7yRoaTmXNtaLbFmg8+wXDlPXrUdyeIAH6Qm0xVbx3R
 J7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696250577; x=1696855377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNn8I4VxGrzC8AqDHg3U3BownhynTadSg8+ejsyhI4o=;
 b=lT3eRbr67/9c5hfvgJ7Qld2WUZEPflu/dhDH5rjPQT5R17dU4zLGK9UnZWXtAuVmCO
 Ojizh6jWEno5nMYD/h4VoQRDx9/pAlN8vfjwLbS5VXuHYLoXPbr9MTFMMI8fsswXCsw8
 TkPtLfgesje4ZOafCQCyQEfjITJtDj6ucxamyrwLLlN423v6RyWn8TfVpfbVv888XwPS
 4OdBgOUVdDYcYL86Gw9z4jHTesF8HhvgcumkaLkKkZ3UJ+A/iorlOpnCgBfrIYgzZdOO
 BLPVFbm/rLMF7smwdHwwWF7KZHZCGvh8yAE7McnFiau4pxVcqKFesrG/A0NxEehvH3VL
 to4g==
X-Gm-Message-State: AOJu0Yxe78WU0Rg1xCRO64z+exIIUhbNT5BPij1krYRL0thNIkrBIWpA
 D/EQH1ywPch4enzwsb9c6TF0NQ==
X-Google-Smtp-Source: AGHT+IGbNa87VRjuFhIPk7eLYKJE41x3Js1odMgbAmdlENiO+khXLHOxHFskN5vG3QYmkBmy5/5wpQ==
X-Received: by 2002:a05:6512:308a:b0:500:daf6:3898 with SMTP id
 z10-20020a056512308a00b00500daf63898mr10897062lfd.26.1696250577428; 
 Mon, 02 Oct 2023 05:42:57 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 e8-20020ac25468000000b004faa2de9877sm4719316lfn.286.2023.10.02.05.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 05:42:56 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v3 3/4] arm: dts: at91: sama5: Add flexcom4 node
Date: Mon,  2 Oct 2023 14:42:16 +0200
Message-ID: <20231002124217.68220-4-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231002124217.68220-1-artur@conclusive.pl>
References: <20231002124217.68220-1-artur@conclusive.pl>
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

Set up flexcom4 for Microchip SAMA5D27 SoC and prepare it for usage in
I2C mode.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---

v3: no change

v2: new patch

 arch/arm/dts/sama5d2.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/sama5d2.dtsi b/arch/arm/dts/sama5d2.dtsi
index dd6468ed96aa..819564fdd5bb 100644
--- a/arch/arm/dts/sama5d2.dtsi
+++ b/arch/arm/dts/sama5d2.dtsi
@@ -781,6 +781,26 @@
 				status = "disabled";
 			};
 
+			flx4: flexcom@fc018000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xfc018000 0x200>;
+				clocks = <&flx4_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xfc018000 0x800>;
+				status = "disabled";
+
+				i2c6: i2c@600 {
+					compatible = "atmel,sama5d2-i2c";
+					reg = <0x600 0x200>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&flx4_clk>;
+					clock-names = "i2c6_clk";
+					status = "disabled";
+				};
+			};
+
 			aic: interrupt-controller@fc020000 {
 				#interrupt-cells = <3>;
 				compatible = "atmel,sama5d2-aic";
-- 
2.42.0

