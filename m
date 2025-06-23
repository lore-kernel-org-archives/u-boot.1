Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFAFC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF6182F8E;
	Mon, 23 Jun 2025 14:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NXcQnRs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB02082D2B; Mon, 23 Jun 2025 14:10:48 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6611382CCE
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad8a8da2376so651272066b.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680646; x=1751285446;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WzVxwIZwQdIvEUWd8NBVmaDGSmkMMWdLZpDT6nqJ9As=;
 b=NXcQnRs5Zi5hORPKtXpGM/EQlaOO7MTmcbbfmDoMVBzti7uy9ZnSbknq1KPHYq+bZd
 ailPDKs8CNdOp4MPMTASpX3cU46z1tAA6l7ugYv8xbqA5EuC1HiGSHaFVe7f2892Gh5b
 0yarnH7Bylk3qK2r2zZSW7riI+pBNwAQW3xI5IaAvRjZPwluqRJlRDUpJuXdM0+hsbkA
 eI0B8Mxp3dx9ES+SGqSbN9a/0UuhqXBZtbUEOafaQRmUySlZE3ygtf/owsTYI5LTLBWn
 TvqDEdAoMSl8oMdYKCD1Vkw6BA9GGK5dWHXCRkQ2WzI0ohrIiuQUrFguwUU/3w0HMUEN
 urrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680646; x=1751285446;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WzVxwIZwQdIvEUWd8NBVmaDGSmkMMWdLZpDT6nqJ9As=;
 b=F+Ub2y+3N6zk5WgZXsYAUbo8IYLGsFL2PzVcmtq0PK0XKwDZ8HawIVw/TvHmVhMPmV
 dZrxt70zi3u8OotEmQhcxebNIbV0Q5PTng1Ksz08UlwbzjUf1PKikQYRsHA8bvhqCERt
 4Dum93/W2crn4oTjQ8uDAJR6dwa0ipyB2xXjEDXYnYPJM/hfvGbrCWjihuSw9/Vx4IyK
 F0Y4ZyJg/yKPG5UTp7HGNooUD0Uz8nBBBybqrVMPBhfCMcMqE+xtQBrQoG01+u3mn5Hu
 TLWpQy0I2PqWmWHFjyS3ZwSt7v8t3rEfQsJCGRckDFe7oj6dN45B4kezdOBRBxWwqx5E
 D2GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQf6FYYft7t1dx//alxX24hmTDT8dx7JxzfBom0HUsRU+Krg/U9+znRcwLNq1pWr9hlthPav8=@lists.denx.de
X-Gm-Message-State: AOJu0YzoHSD/fweewT+Udk7mvhaHsAJs9foaa/uSo1RlUCBltU4qdIqb
 0R1wBDxrSZCDVsyN6aNfv+0qZe467u3ufHiErBlXGfO0I1MobM0DAGWL5L6zAVlMF0Y=
X-Gm-Gg: ASbGncu6kK5dCVlUCIfmZOH95+gyWzAwty6WhdG0juvErHb3H2zcy1IuqXQgNbDmWZr
 WsAgfnIruRxYnstQWbq/RDZT5mTsQQQqIM+AyIAgaRQnrZeGT31TEEp5sDAW4NalQ2gc+rAEygC
 4Gt8PIbdmsgAwfGPrGkfMvOg7v2+zMdsWeuFnfk3hYUxO3BaTxG8YFgJ8122/7JNtRDx9Ha9zw6
 JpVrGXqo26+hD8UV211k06Pd/bUMksP0R7A6bjqC2qm0cth7JnsAhXACzvrKJAy95VDEGrxu3TZ
 7U9/MTRAFEPgYSsjeLF7ENAnVlWNEwIkFBaOthVVTebrB001Wf3T62QB7Ztv/csa+D8RlA==
X-Google-Smtp-Source: AGHT+IFjHUxAUuMWjHugaepNqqs5IckqzwzmIlFjkhiFGY+YqiNCFAEhQVRv/DzIAu8/ZCSLnt74wg==
X-Received: by 2002:a17:907:3f1d:b0:ade:c102:dc9a with SMTP id
 a640c23a62f3a-ae057c46464mr1166417566b.40.1750680645856; 
 Mon, 23 Jun 2025 05:10:45 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae053e7fb0esm697584166b.22.2025.06.23.05.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:45 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:38 +0200
Subject: [PATCH v3 15/22] arm64: dts: ti: k3-am62a-main: Add C7xv device node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-15-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723; i=msp@baylibre.com;
 h=from:subject:message-id; bh=V9ZXVxMX+zxkyFPUKQLHdFsKJ4SFs9A2VnlBIf0g7R4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxIF87uyvSXa+TVmtqjm3svN7+1f+WYP8Fg2rENytImH
 2fHli7tKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIm0dTIyfOIRunzAfM6KvvlH
 j/0L/rVq3s1bF7gecU8sZ6s3yc7lm8vI8LttUozn9rC6Pw/5DCvKf229UiTeIJP6qFjUf+N8q8e
 xbAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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

