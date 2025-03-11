Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCE8C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF4D8186D;
	Tue, 11 Mar 2025 14:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EVKZ6ofZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3017E817D3; Tue, 11 Mar 2025 11:33:12 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B5D801BE
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so7634947a12.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689178; x=1742293978;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fv7SRD9wFg9+xYwwJRYssIej7tnTxY/eStGq9RS+v0g=;
 b=EVKZ6ofZSk7QKysTq5Gw+wh210G6qtBRQOFdc53ISzJ+YUjd6Yf+xGdJ5WcxhefF6E
 wOCibCpiHb/EY35akYSD9inEiEiIfJZ2cT5UvJjVUMH2008NqdoUtz3aR5X9mq4X6y1L
 n8cwl4mv4Ed9ggtp+LEFWlhmoE9NzUcenXlNb/YewbXSAm4H0Nb/X4Lh3BamhfxVqpQq
 8eN2HmGFIj48wCy359GyhZYo38NHKdKy2MuSqjZgwbzUmLzaUFEvgvI4MCpuWNlfJsDt
 vmnGizNCuGpwoD7OcsS9BGhiXr+ukF8kMmNmLKoX5MyatsupIenFzUwzYS45YqLNkpJp
 gaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689178; x=1742293978;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fv7SRD9wFg9+xYwwJRYssIej7tnTxY/eStGq9RS+v0g=;
 b=MGm+nw7//KJCau9RNcgpgKIvE2IOIWo4BP8wYbWwSGGZ51KY6LGVYVy+C/biUEyffa
 8ztByalDkK8Ot7W4zd5M719RA+dyCd0weursohubWKfds49GOy3nANivcCihGb7txv6G
 gb9fQymGAvg081Yl7r/dI9yNWg1r1PTd/RNATtlASy2U6FQVNZQ1QISCQJ1E02RCw3wh
 zFOeh4sL9mPJDRqGgrQixlG91Ed7CS4TlWp+O3X7n6FbVA3Lz0a48LhjnwuVkiAbnR/z
 3XdQcpAdHonCQ0VrBnjn+gnvfIcyD4rZSZ6wZjtBRlnS7CktaMoi/hqblO0ZPUXJO5EU
 k4/A==
X-Gm-Message-State: AOJu0Yxh3r39sMrOeVf29KahTzGps50ma6rABcWQbgnPppuE+TWqri7u
 DTvllnd7lXJ52iV4LiHc+T+lj2LVxbOwx3QTvoulTg9PvglVuWmtxh4SSlTipQfcmK2/smtoMjC
 F
X-Gm-Gg: ASbGncvm0Fd/dDelDwQJpqgCEz9Nds2bxk5hUbqGGOdk6joGkZFHfmba9GK7FUO2F6f
 P7UZgB7v7FAS2Bi5h7NdYgjigvxgO/n8+XYLkXm0Goz1LN/1xcapwSxicHSljn+yUmpY48H8A8b
 Z28Zyvodme5FZgS63movWpbx74yJAGUt5l2pSPn9QMLjEblvwjnpfEp8qvZTJmYYhvhrIjSQqOb
 BiG+EkYpWgwn/1mHZSGGz3B4xSY33vZwT/3tJ2qftGo/9rpY1gPDmOn7Ajz8lhNOuas18viUVDE
 VCXwVioYbUCrvZWbBkVg6Aoh1VAl7wzE+0YQ4Q5/
X-Google-Smtp-Source: AGHT+IHp3rmAYS1ei/S0EKc04vLlHuKZ2yB/PJmB2u8Kpe+ZyG7MZFgv3NCi8x+Gch6JL+Z2tWW4CA==
X-Received: by 2002:a17:907:9381:b0:ac2:51ac:35e9 with SMTP id
 a640c23a62f3a-ac252fb627amr1446562166b.45.1741689177683; 
 Tue, 11 Mar 2025 03:32:57 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac2399d4edfsm909437666b.171.2025.03.11.03.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:57 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:49 +0100
Subject: [PATCH 10/19] arm64: dts: ti: k3-am62a-mcu: Add R5F remote proc node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-10-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Hari Nagalla <hnagalla@ti.com>, Judith Mendez <jm@ti.com>, 
 Andrew Davis <afd@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Hc50FLjyjBO1UzKnwH2u2PuS//7/F2FQCFPqEnls378=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCErNUeT8pp69Qcbp8fZUQRG52B87X2s+0Lq7/2rwy
 dKcfYH8HaUsDGIcDLJiiix3Pyx8Vyd3fUHEukeOMHNYmUCGMHBxCsBEmF8wMpzIZH3b3nvqe4a+
 6E3dqpveN6WnrJgjufdK/dS/B6vNprEzMuzhr+ZY9iar6Yfy5RmWVi5V6hLSxw8xXrtmHLxY/Ma
 uzQwA
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

From: Hari Nagalla <hnagalla@ti.com>

AM62A SoCs have a single R5F core in the MCU voltage domain.
Add the R5FSS node with the child node for core0 in MCU voltage
domain .dtsi file.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250210221530.1234009-3-jm@ti.com
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi
index 0469c766b769e46068f23e0073f951aa094c456f..1178cc6a9be8ce295f15f6131ae8434fa7c4d0c6 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi
@@ -175,4 +175,29 @@
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 		status = "disabled";
 	};
+
+	mcu_r5fss0: r5fss@79000000 {
+		compatible = "ti,am62-r5fss";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x79000000 0x00 0x79000000 0x8000>,
+			 <0x79020000 0x00 0x79020000 0x8000>;
+		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		mcu_r5fss0_core0: r5f@79000000 {
+			compatible = "ti,am62-r5f";
+			reg = <0x79000000 0x00008000>,
+			      <0x79020000 0x00008000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <9>;
+			ti,sci-proc-ids = <0x03 0xff>;
+			resets = <&k3_reset 9 1>;
+			firmware-name = "am62a-mcu-r5f0_0-fw";
+			ti,atcm-enable = <0>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <0>;
+		};
+	};
 };

-- 
2.47.2

