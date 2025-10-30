Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4051DCCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 672FD8399B;
	Thu, 30 Oct 2025 14:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GIR7gvHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B688D83893; Thu, 30 Oct 2025 11:01:44 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7C2800B1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47719ad0c7dso7905995e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818502; x=1762423302;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fQ9/lG/pHy8dN1Y1eIHArnFIvXtFlbRfSiKhhTdA+EU=;
 b=GIR7gvHtRgk6xUUdAI6n/KNW9WiC1OTZRHEJiQZoID08uYDvddcqCXk7VcsBhTjFgT
 DE0x+gVkIDda9TpPwflpW0MJuqOrzhiMY6Cp5YG00z5JZTIrM9xiyYLE+shbHJJbuDQV
 kZ+KfVfqob2Ezx9yZZgiTHLRagTymNZChmWEhmOCTJuw+WfAjal55+vN7Db3yR/vjWKJ
 j3sb3mB6bThazzZ3DoQRqhEn0sORA5ARqRgS5QEznTvMppSCqSGJyuAAV5+Ztj+CFJGD
 UA1aAy9MXeDrTP5w0PZV6ybVt9WdAWLJf5v3rTwFlcbjsEZwygt9QFAWdzyjPf3UBtCx
 WW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818502; x=1762423302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQ9/lG/pHy8dN1Y1eIHArnFIvXtFlbRfSiKhhTdA+EU=;
 b=HNZ+YjFEmdKaQKkvh4ybtDHGsj3PhWL23yvAvrWXIPdsBbrMmJLtATLmEjJIENxLE3
 kpp9sCiehOTdjXN3j47Ktd/5+hZ3EZ3s2JVWo+Ob4uYZQHZjmizXG4wTmCwzg9BBRIv8
 z2xbj/uLU4KdMyQ0Tt8z1KOAIKJh2lqLLtBhHPffn3eyZgHPf1xF2Xbekd27uOXhoxpm
 CSNYUiZKWSgzM3DFLDfUjMkXCei7LmvlsgR3JvR9/oaOUEeewnOlz/i3tdXDxtYpKdjz
 d/b999Sa2zTXuZCJi4VFRVEKBS0elMlwgOSEBD3GwTRE8mO3Jll5z2Cf59MEu4J4IFwi
 3qiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAww/r1wcd8xcZ2OYb65Vc+hpBH+dW0KyyBXNbRYVrBr+RDLlW9mwmgzs6qPUCHcrahBj18sA=@lists.denx.de
X-Gm-Message-State: AOJu0YwH4TcqKPflra81yU06u67/LynrlPPKxrLdyOAvQys1y8ny0vRD
 IRWbe7YC11Qj0R8kxzGngAWFOcr4OnNkSsQkNeVSPcDtAd7GHqCeIChm6luJcEx3DIY=
X-Gm-Gg: ASbGnctHBey61pDZaS767Figuk+DQlO3sBzAhEMebkZf1BmWmv2m7p8icu9iWUTnpXA
 faLAlk2zRDXbdFIJcgxNG4dHV0/5hpsH0wbtQffoppiFTE7Gr362tywDLpVqy7mXZNIoUEcaPQx
 W0FgYiXmc/4cOmr4KMaTU2tMye1ST9gK/YWOhH4T+4u9rtq/LTqRT+JePzpKhSjL694Kg/hYnex
 X/ChjKpGYXHr8E9MsLc8BK4i4Rcak0Nc6pGVHt3qSGAefrpCdQ/1Mw8FTpomwjI2kR1UZteYvF8
 S9XVd8VdYqyoP7Rw/yKDVh33TTW5DObi9SUX/77oZyyHrxYDFO+SnyX/J1Fg+PL2H7D44c/gSQp
 ptlRTARrlDcGI7hfA584OFnuqd+GfKMAolr2IGOo0g/JIFig/yaIJNJLBydZaIeIA+dopmOPVui
 QFuE7Rqz4kvxV2MPHehQQ=
X-Google-Smtp-Source: AGHT+IFgsZ4EKzPkbTP5dF1UeE2We6MwfCioRGYMvKapmzxIptOrOPCPCk2cnoyh9xpA1M/BsYJoNQ==
X-Received: by 2002:a05:600c:1c9a:b0:46e:1b89:77f1 with SMTP id
 5b1f17b1804b1-477267375cemr22341135e9.9.1761818502145; 
 Thu, 30 Oct 2025 03:01:42 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-429952e3201sm31078797f8f.47.2025.10.30.03.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:41 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:28 +0100
Subject: [PATCH v4 10/13] arm: dts: k3-am62a: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-10-4cef18af0226@baylibre.com>
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=msp@baylibre.com;
 h=from:subject:message-id; bh=yd3BxHL5vkWyoH4yXfml6qGKxgaCqUgI1XQhSk18xis=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxm85CLE5uP75P7dfXVtEVT7N9wz529OrutmGOLbsmR1
 MPrpiqbdJSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEanczMvz+/OXDmxrue2w6
 ncJ79iiKG+0Prqy+wbvo5Eb3Q3Y1XNWMDNuOTjnEUa2UlLIp8iZTplXMOomZ6ss38j7n2sGw6UZ
 qOzcA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

These are needed in SPL to be able to resume from DDR immediately after
booting from IO+DDR.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
index a70fc88317e04de032e4da1428e25eb78ecc30cf..7e6a76f72b2a63bf706c3839189b6213aee4497d 100644
--- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
@@ -14,6 +14,14 @@
 	memory@80000000 {
 		bootph-all;
 	};
+
+	reserved-memory {
+		bootph-pre-ram;
+	};
+};
+
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
 };
 
 &cbass_main {
@@ -68,6 +76,14 @@
 	bootph-all;
 };
 
+&wkup_r5fss0 {
+	bootph-pre-ram;
+};
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};
+
 &cbass_wakeup {
 	bootph-all;
 };

-- 
2.51.0

