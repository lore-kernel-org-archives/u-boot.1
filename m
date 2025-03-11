Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2523DC28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE6981BF4;
	Tue, 11 Mar 2025 14:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CnJalFMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED634807D7; Tue, 11 Mar 2025 11:33:17 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A482781760
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac289147833so419197066b.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689179; x=1742293979;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UzFC93Co9c6gzVXTSm+hIHRL0UGJHQ73j9oEEvJSbxU=;
 b=CnJalFMqpazWEbGR9cEYLAARZyJp6jEZblNgnIQZjS+xvMlg+HPCURqtFcUd7ePqxs
 UCGQ2mosakn06NpkQWHfOlAIRpBPzXFDM+nbgtByirB/61zGDnAoUQvjYLrdP5vu/TEn
 nl99MGRfg2KsNBVUmw4PDJ4pqhaZRV8Bp/9RuxpEiLFI/XaayEh4QX1/H1k3WEZFMIY9
 HO1zZK7uhsFmONZnyTY3fSFlP/RwaPME0QPA1ekiONCDY9x7wecUhs3Oh7i8RbUW+FFI
 MKsCGWjiuJUoddMUcpnN1ccV2lwOLbgh95tr2oJ6PNqDzL6tLsE2vjSlGG1jbSlPhB81
 HQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689179; x=1742293979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UzFC93Co9c6gzVXTSm+hIHRL0UGJHQ73j9oEEvJSbxU=;
 b=QL3HCu+/TfiKgcBPD3MP/C0SMqFhEwDLgDyBalmHCYWjdMAqDLTcmy5l3d8ZaJHuXW
 k22zprj69PoOxFf2LROM3vS5C4JElNt30wvLrxjpG9d24Q2Wvi7rom9ewwW0z9ImJrYD
 Zj8lRGIbejmUm581g0//Q0blkSXSdkIwBrFWxOaN2gpN6ZzkZaUBA6F5LMcQCy3gSRul
 hKdKuZM2FkIBU3ysENQ6RnHMeNEiiWpsv+BQRl2ps13tELpgUk5919W0EZKMAKc16Mii
 JcChvJSJgCyWyCKDvBEzeZxUMsw/x8gdAAccFRZOliEq0Dc7oBvVpn0k6PDYKdI2Udh5
 3Fsg==
X-Gm-Message-State: AOJu0YwwwbUqn3kxy5pCNMHuxF6jx/FGwuakadPkXN56bjrYKiazOISR
 qGaE+AVEm/jvgH1iR2G9y7jRPe+AbTsRx6rMQXzEmkeWVu3ppvw4sXD6NZ5idFNw5jGjIhsi49e
 s
X-Gm-Gg: ASbGncvLaORPxp6jQyVk1Vih0U1eydTQGcJq5lpyXOCajfUpKrR3lPRL7Difb01GuBV
 9fK6wmRjT8yaikrer1HR0bq8MXgumhroaznvF0fc314h0Mp9HtmOfUdR42uVYERq4oXfE3hc3Y1
 bYtuyW0/ZGezm6hfjuKR3oGaXrgrktQyq4Vr5HrFu3cF+IIm7pLkK9gIrCpdvjLDSCj1v/7eAtn
 pnYhiSLQhtHASldgpfNMIJq7nqTxbHun6B5TMWXFbqU2YAEW9flif5zef7rTmkLPFCBzOsn9uEd
 EMnDeqanvBtL38DiyCBOxtLFrhBybsl2Q3OW+h/5
X-Google-Smtp-Source: AGHT+IHHq8Ink+T9bM9UoL6wUXHnmCYsDiLQQhklVYMBHyIFw6kQGWkCdsdQZzteUL0qXoPKcDw3cg==
X-Received: by 2002:a17:907:60d2:b0:ac2:a2f9:4728 with SMTP id
 a640c23a62f3a-ac2a2fa14a9mr813711966b.56.1741689178831; 
 Tue, 11 Mar 2025 03:32:58 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac28a7f1ed0sm445162266b.66.2025.03.11.03.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:58 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:50 +0100
Subject: [PATCH 11/19] arm64: dts: ti: k3-am62a-wakeup: Add R5F device node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-11-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 Judith Mendez <jm@ti.com>, Andrew Davis <afd@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=msp@baylibre.com;
 h=from:subject:message-id; bh=6Vyic2Yqm0Gv2btFxCzRw+bZmPSfVQ7K4Z2gkaNXx+E=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCMrbz9x3TfzxVgf+HU/E10tenhLqXxH2axm7Vdycl
 ot3Wv5c6ihlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmYrGSkWHvfO2eZWcCpaNZ
 0nTy5ktqmsVEFyVNTgqQM9YsVnk0XZGR4dIGA6MbahUvphXes5+pJDtVtzxBrX/hP/X4TRZO7nt
 T+QA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

From: Devarsh Thakkar <devarsht@ti.com>

AM62A SoCs have a single R5F core in wakeup domain. This core is
also used as a device manager for the SoC.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250210221530.1234009-4-jm@ti.com
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi
index 0b1dd5390cd3f42b0ec56bab042388722b4c22a1..04ca0f7fd57c91b3ae4031bf299cc8d84c1a8402 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi
@@ -81,6 +81,31 @@
 		status = "reserved";
 	};
 
+	wkup_r5fss0: r5fss@78000000 {
+		compatible = "ti,am62-r5fss";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x78000000 0x00 0x78000000 0x8000>,
+			 <0x78100000 0x00 0x78100000 0x8000>;
+		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		wkup_r5fss0_core0: r5f@78000000 {
+			compatible = "ti,am62-r5f";
+			reg = <0x78000000 0x00008000>,
+			      <0x78100000 0x00008000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <121>;
+			ti,sci-proc-ids = <0x01 0xff>;
+			resets = <&k3_reset 121 1>;
+			firmware-name = "am62a-wkup-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
 	wkup_vtm0: temperature-sensor@b00000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0xb00000 0x00 0x400>,

-- 
2.47.2

