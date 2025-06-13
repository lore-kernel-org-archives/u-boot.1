Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4CCC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD3B82E58;
	Fri, 13 Jun 2025 15:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EE96Jg04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C168082C30; Fri, 13 Jun 2025 15:22:10 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A482282CA8
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo4058308a12.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820928; x=1750425728;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YH7RQcDZBakQSVWyFAg9AGEuHvXE7Xc2CpzPy2PcGcg=;
 b=EE96Jg04s3RqDFgJUf0IRNQJUJSsxBpVCqet6o+6nyBHXS4cKVyJ+7VRW9zSxJSgCj
 bHKNe82hyGDePcSHE7Cuxhl3R1OGCkOxDrcmFxLkRXVt3vri2qLa6kPsmcmM+F93yp3Q
 cAeR8VKVaJlaqeYz3TVay1Fn+1v4pLYEshhvpkFZmNHoI4MrX+MO8Xzpv2wynAbwfsW+
 noTw1NP2p6J+lZA06UrdDlDbqDefH9ZWiPF97yNHyHEzKs4tWWqm3vHXM4H5Et6Hp/e9
 4sj0e7p7APbwp6SMqXMxdu5f/AY+JEzvjI5Yio2kV1o9ONAt9LzwwWDFhwk6/zekhbJK
 CbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820928; x=1750425728;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YH7RQcDZBakQSVWyFAg9AGEuHvXE7Xc2CpzPy2PcGcg=;
 b=Qx4my6ksaSDCOEe+CDz7v+bjS1ZFz/r0uCIaks/E0xDupajlNHGux7qxaUS+tJf5sK
 cVQ2rOJqCBD5ItWEkB0g2WUF/bIebDeN2kNn7w0QP/FqIswz4aIj7MS1eR8MlCjMyzHV
 iDSVKVU+ppz0ZsO6nXmDQW+PdXACtB0nHs7DmPsPkz3fv9/xXGZZsR/mAIGD/d+F1DWv
 0pxwUhGBre0VXiclbTqQ+YAoq7cqxyLQrMtxuo4xfHvQZIEN8lN0DpM9FBqTR7AU2BiR
 o11VUBgkRwI/IHDDQfWskO4hcwCb1Lh4I7wJ92fPZiGenoL5aZ+tDebejyMY9WMH1gKw
 A3WQ==
X-Gm-Message-State: AOJu0YyQqz2bDdhBKaN+wYY4bgIIm/MxJE0rbF2HO7z8rfgY49eVDe3i
 zzaH4/4NdPjyqWRbndlLnKYu/ajHK5RmW+B16jVEXoNHbkdzWJ+YeXkfu7L7KPEBY3VhuqccY/c
 evOaF
X-Gm-Gg: ASbGncuMFABtXYy02JMI05d/c+ViiHiNI9ceHrab/NvQukXIdxxm/qcTj0/uEUpL06g
 Du45COblvHThy/MZDIGK7NicAU3n8spea9+xegs8enCQ1vrN/q0ahi4e7a6T1HE4ZsW33NRNv3m
 dVDfV7rEyDbWRL6bOhBmc3w3WO8Pv3DoJLUWzNEIbCrMXvGKlZrozdVkDIdRgds4ujMZwgkmmXl
 /bXgo7ZtnRuuB8PiDO+FA3Y4mGwJnCSnVeHNYShJ+2hEVnVcGAqYmoJiTQ8bJC2kRcRIBUy6nkY
 LM+yWpVcAcurr8wZGancoBv0N+fbBTvGwHa29uz+M9UQ5UoIP7qaYKYI1PI=
X-Google-Smtp-Source: AGHT+IE01lfAL8HHVTzEbBOcaN5v7Ep9ZSdxefVljl/bcaRJ1Vf3rL317L906DpMyLekgAvmNgsLww==
X-Received: by 2002:a05:6402:d0b:b0:604:6196:e26b with SMTP id
 4fb4d7f45d1cf-608b4a2bd39mr2166647a12.21.1749820928081; 
 Fri, 13 Jun 2025 06:22:08 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-608b4a5b716sm1217164a12.41.2025.06.13.06.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:07 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:33 +0200
Subject: [PATCH v2 13/22] arm64: dts: ti: k3-am62a-mcu: Add R5F remote proc
 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-13-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835; i=msp@baylibre.com;
 h=from:subject:message-id; bh=w0sYZzm/t4lkoTQtAxsbP+3RS3KRDpg+AoVu0qpT8sk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1X0fOBVFGG/eKOBiUH2T9ubw13lB3NI31rzqXcOb1
 amtmbe7o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZy+wPDX2mj37bnjG/5B+90
 E9PyenjvMIfr7Fkmv52ulhxjLejOncjI8GPhlGSJhvVRdy5kn3Ca8/v+BsFnN1xZvOYtVZq4k1X
 VlxUA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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
Tested-by: Daniel Schultz <d.schultz@phytec.de>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250502220325.3230653-4-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 7f321892dc53015e29cd1055231727b8cdc24923 ]

(cherry picked from commit 349f1d769bb67fda0271159557589c849c843b12)
---
 dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi
index 9ed9d703ff24d80171fdb29abbb0d5e3819c8a90..ee961ced7208f99acf239ba9c8d8cbef0c326481 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi
@@ -174,4 +174,29 @@
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
+			resets = <&k3_reset 9 1>;
+			firmware-name = "am62a-mcu-r5f0_0-fw";
+			ti,atcm-enable = <0>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <0>;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <9>;
+			ti,sci-proc-ids = <0x03 0xff>;
+		};
+	};
 };

-- 
2.49.0

