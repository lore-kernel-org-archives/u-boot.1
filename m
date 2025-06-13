Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E727BC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2900B82E8E;
	Fri, 13 Jun 2025 15:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Imx4aM2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B8F582D2E; Fri, 13 Jun 2025 15:22:13 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5D2A82CA8
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so4473379a12.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820930; x=1750425730;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LhL5B4ldLZxu+ZIn0SyPYoAeWCdAfoqsuqq1LYkRlhQ=;
 b=Imx4aM2k88IG9jmha6AUTkvzuQZDo2FVH150oHmhJZPvDwpE9nHZoQZqvCfcMW01e4
 xAch3Arqv1T/jWysH0thRnMBCp9OKgRIJB6VV5NZuJqj2Dnpeg1NOHWQKFrcLThV0FPi
 tF+wetKqUROvcWR5JQEwk1/59gQuExhOKJxiklOWG2fTHumMAffoHeFLL7JbGwggzF+x
 3zJ2EinOfUkFNOYQKpdKT8ipGfoBqUr4TS/NfkMo/t3xCi/6u9EGfuxySerrqqbqI8N9
 FemgY6WXYddfUxLxtcBJTl8stdn6mmZZvMHeaDtZPiTZFLahgKThMg7YQInbI7kqKOJg
 pJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820930; x=1750425730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LhL5B4ldLZxu+ZIn0SyPYoAeWCdAfoqsuqq1LYkRlhQ=;
 b=VaU7vlKodqzcfJTkvc8Fw3a6rM2Ns8CFHggdS3irSTWLi+BzgJ90q4cSUbqE0fZjk3
 EtsEMyBuzweNtvmoLLBEncIJiKqvH1SATXYV6604xU87tAr4+Ff+5ype1KHm60KcJMAL
 x3CT3kO94F+HWqruQIs5sIAK55bgwQ3B7ZcRCajLa2eM3hh0OQUhHZlJBbkBNTjX8DRw
 rfVZ+vZl+WueXK4fDCcYyY0gmOqoiMUsimyokwtEDKfsLWPlMpNMnvNdH10kCWm03F/r
 gLjewGauEQ61G9GTk4KddVm8ydhnATJ/1DNsplmQ9VMkayq3We5/y3+AlSuC1JFFO5yX
 Nq6w==
X-Gm-Message-State: AOJu0YzMGI3Y8PpEf3Rok6af+hM3UaIDWEU0KWl9XwOWkh2UbQJrWK1o
 mrR15p6dcbkAcGuZZCyPqbcx3pa06fXZsWwBnb6E+NZNCBbpgyCR8vxGkYYsf6GHHzhRVoB7ZjM
 LguRS
X-Gm-Gg: ASbGncsMlpNqZlcVOcxnmLavQ9sQmcTywZ/4p5haYBv+zlaLw2N1M19UN8CCMNgNxlx
 e6N5r63DMSTVevGzJrX3Boi6/lR8dxC8gkW3lqVhj/5FhnvODaLOqZAZMmalPtPVpv/yU4hweDc
 03cPyaCVHX07o0I3loSl99nODUfua5P4iM/pWtF+YUUwXqW+Objw3fK9LJuOiNVOKHdKMAx/lHO
 hT5ySlAL8a6YZgfA+KuXagr4KroGgP3QvhjIiCLl5Vd8fqaVVA/H5Cmcgbq83J2gV694vuwo2XG
 hFOFJPH5Xy1F65bAdtJJRnzVwL8PQB2vUP0gMk9a6YDvaU29prADOPCoZfY=
X-Google-Smtp-Source: AGHT+IFapcDxKfVdTvQbRsB6jg40wvME3T3vn1dt6WaDZtDnRMVZpvwlPvoVy1VlMriBRcjFhECoMA==
X-Received: by 2002:a05:6402:4307:b0:607:4625:98f5 with SMTP id
 4fb4d7f45d1cf-608b4a1b933mr2210499a12.23.1749820930147; 
 Fri, 13 Jun 2025 06:22:10 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-608b4a5e72csm1211106a12.48.2025.06.13.06.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:09 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:35 +0200
Subject: [PATCH v2 15/22] arm64: dts: ti: k3-am62a-main: Add C7xv device node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-15-3d233aaea355@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=msp@baylibre.com;
 h=from:subject:message-id; bh=KoTACttwDlAmRXGMZBtocHE9coZxBUxXXB/nYM2CUrU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1ePsVy6svxG0t+OeUA9TXeoD+c8csucEhMyDv23R5
 bVtmFTVUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABOR2MDI8Hfjp6NZVplRN3Kq
 lMvcfFWOy6071PrZ6ulduQU9tQdmCzD893IKDltdfK55Qu6G/3cLjqyxX6Ah9Fr2Qlii3rff+wM
 f8QEA
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

From: Jai Luthra <j-luthra@ti.com>

AM62A SoCs have a C7xv DSP subsystem with Analytics engine capability.
This subsystem is intended for deep learning purposes. Define the
device node for C7xv DSP.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Tested-by: Daniel Schultz <d.schultz@phytec.de>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250502220325.3230653-6-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 56f13d79430f8faa27943e376ac25aca0836ee93 ]

(cherry picked from commit d115e1eada3ede7e3598de8758e0ef48ff76f499)
---
 dts/upstream/src/arm64/ti/k3-am62a-main.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-main.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-main.dtsi
index a1daba7b1fad5dee026ce4ba52077e01baca0131..d296e9e179738aa6661756c82ccf608ac53959bb 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-main.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-main.dtsi
@@ -1123,6 +1123,18 @@
 		power-domains = <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
 	};
 
+	c7x_0: dsp@7e000000 {
+		compatible = "ti,am62a-c7xv-dsp";
+		reg = <0x00 0x7e000000 0x00 0x00100000>;
+		reg-names = "l2sram";
+		resets = <&k3_reset 208 1>;
+		firmware-name = "am62a-c71_0-fw";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <208>;
+		ti,sci-proc-ids = <0x04 0xff>;
+		status = "disabled";
+	};
+
 	e5010: jpeg-encoder@fd20000 {
 		compatible = "ti,am62a-jpeg-enc", "img,e5010-jpeg-enc";
 		reg = <0x00 0xfd20000 0x00 0x100>,

-- 
2.49.0

