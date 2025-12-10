Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2211ED3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD83583D7A;
	Wed, 10 Dec 2025 16:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="apiys7BM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 245A183869; Wed, 10 Dec 2025 15:11:07 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9981980077
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6492e25cd7eso1548640a12.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375864; x=1765980664;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LEZlegaggtx1IJtRmNHgctjbIdWLDK6iV7Wsg3nyp3k=;
 b=apiys7BMRsDhQ1ZYpv7+K3V4Uq9rihbjD9yNfTC1Gkssx77pOZ2unP483K9efwR50o
 gwxB5rsDfsPJWEGVOCNlA5uLmZcSPnSo1pv2/bj5J3ZnGwCYVrILFoCWGtPWjLOoJBAJ
 eFR2G+956rrPi84N45EaMGfJFIB9SuuUZrpCkMO7WkXqtb120gIjN6pEKNwwIHxI9BJT
 RgYiGC1+X5ae4IuzZDRs9IcgKA8+lRxugG9P5T/jTAcTlb+3GyLGhn1rX/F/FDBd2HNB
 MpC6F9eAUVWbSr0eq6C2tF+qnfabA8gQXcZWxA1+oHxOEUIAyhQIpIzjKTtdjCdPQzPT
 aePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375864; x=1765980664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LEZlegaggtx1IJtRmNHgctjbIdWLDK6iV7Wsg3nyp3k=;
 b=LcyLY9XJy2SOKmvNRnQTurtvHBZH0jIOJvtuBrfW1xsX/cJvU2K1Yv9xDqWRo1gpYk
 nZdNIctY5cymOuQI80A47Uq7U1hmw72aX1WFLBNclxJiUxoATkHHit1FsdNeKGpo4rgo
 oSMUdW1gbvcRevGQ6BnuSeo7858OjwXIiujBrypFzAmGRiSu9QOTJCDN8JhG++y4WQa3
 cmaK5a0gS3rvTPDyoCoQND3cJsa3gV/e9Kd0frKEZUqNA31HrZntEBXJvga25xvvhD0J
 64G6cVvkCVif/2bFEQi91iKgl74u3zN0Ew74Lcm9PYGf3w85xuarRRjmpG3nG7J89jii
 R/oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt2Y6+Fd4FdxScZmpPXQk8Gb9aMcBBV8GhH0O9j3pKbFZndspyfvkzCDlN8hEwVNdGWxB/KKg=@lists.denx.de
X-Gm-Message-State: AOJu0YyOY6qVgsgBsrkG0KG4fm3jkT6pRXndDehbY6m8+7di+a++ohv6
 VHJWi/VAnkOknLecq65mPUO5d3GK2A5wil+WYBlFVzfq4hXi2+vl22VCfZtWhd0QU4d6Vh7RUJS
 1/ssr
X-Gm-Gg: AY/fxX598MZBA0od8RhyVHkHLVZmgMjAVvDF46iDT+thtRO21YNoNVuIWpf9S//cO5g
 BuzPTcTjZL132p9L0HZPVujUlZ5pLQdH9Q+EvMY8a7Neut16+DYUOm3js53P/PTvpdNw5RMLN6Z
 zZ2VYwNy9BfESXW94GQVjpitx0Zgp50YNaivogbs9jXgb6WsyNTCE9OL1O+Dmd2mPq0Rvu8OI/w
 5Sl8Sy5cQdPKoXgdTjGACzruTVUpzW1NkibU8O5fkJ9ru7lX3VQNyh5SSPzkG77GzC3gW6B4Zw5
 MrJlopwFRjsC0mBfoIGvJAWgI3T+ZAOT505YX2rhDR1M33NpxJVkQdH5IgGWlCuh57Ph77nZxy3
 1FvijF8VI+fecK7TuRl9Vuk7SFRoQFKju7G5+SGEyOw8eqwz73veBW3e8xgJMyqGtt6grG/MYm5
 oD2wWec5ep
X-Google-Smtp-Source: AGHT+IHXQGdh8ImpThItbopOvvQpgVUqWcnSN56jyVkAhFq7RVyz0i1IRTKg3TrhCXFUnE2P5W9ttQ==
X-Received: by 2002:a05:6402:144b:b0:645:d07:8924 with SMTP id
 4fb4d7f45d1cf-6496e201dadmr2542140a12.16.1765375863974; 
 Wed, 10 Dec 2025 06:11:03 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edd772sm16781401a12.12.2025.12.10.06.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:11:03 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:09:04 +0100
Subject: [PATCH v7 10/13] arm: dts: k3-am62a: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-10-f113b156f83f@baylibre.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=820; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WWZNLO1ZuCNIR+38/99MAC+EjhdfgM9NRUrGfvvZ87w=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLele+x59mJ2s92/tQtjEgeaeeAN+/1cterr17ryYjW
 ojDMza1o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACbSPpuR4eYD16tPVjZ23L6V
 ni2YXVSv7qZgolNY/a2Aj83q983ODoZ/xu+Xtjp8uDa/SPxO17s+3iKuJIV/U+dfS/Hhtbng6FX
 LAQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 10 Dec 2025 16:53:41 +0100
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
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
index a70fc88317e04de032e4da1428e25eb78ecc30cf..84f3a5c199b344d17300b9672cb9c77f607beb6c 100644
--- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
@@ -16,6 +16,10 @@
 	};
 };
 
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
+};
+
 &cbass_main {
 	bootph-all;
 };
@@ -68,6 +72,10 @@
 	bootph-all;
 };
 
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};
+
 &cbass_wakeup {
 	bootph-all;
 };

-- 
2.51.0

