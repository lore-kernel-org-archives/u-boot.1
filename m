Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693CAE69166
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175CE83E16;
	Mon, 22 Dec 2025 21:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PW0NKrW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B27683E70; Mon, 22 Dec 2025 21:03:04 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0319B83DEB
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so30480315e9.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433781; x=1767038581;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fRmt5bRgcwvj06wvWV9ib5uL1fd2vAST2VDDAK8mxAw=;
 b=PW0NKrW7h44flKvTb9ZQN4Ul2zM97gpb5tq+WtvNhM7WEbhXMhaqf0V+KoMeBsEXxM
 Ldg7E4oJSogz2ZL+fyT7jIXmtlZHvjJ+YqGiRwMNmnEd801DOGhP2OkNjMWSLFdqg3Xe
 YdSmy2A66fJwnNIif6/+AJaU3QLg6wg2wz3TVXBrbeXk/x1+YGd8I4rp1hFbrhPilBDd
 usVjrYJPGfwpMxUF6Jje/iuZtdPVDiXBN6r2dx6pFwNuB1waHdfleRXAJqXJW041XypX
 6ZeouXjpHk6GHULlXLB4Hif71AQVmuoqi6wJ87UA4LyAsigLUEdEDqjLHZcWlbWA+R++
 q7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433781; x=1767038581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fRmt5bRgcwvj06wvWV9ib5uL1fd2vAST2VDDAK8mxAw=;
 b=G/A0vbmqDuFpR9qLuxtblCnwQnLF1LuV6psLGziFN0kWso8ctY0sKiqEog1cCTIFoF
 868IZN1LJIbltSyWM8Kpk0rKSLTGXiLo+FPqmcUdQBUhtUEDwYh13nljJ3gNnYgnEdZc
 uj0pjpd3sJkW9WYVNQYFaOwsAKhvc2lNiHAlHV9/NA+01LJJuFYlV6GlJxCdkEoLRyiy
 iGko6E1DPGMSUTnTRxVBkdP3TAhEnKm7Tl2K3aBjKjTd7MvxhvJjqZurxpK7QIcXMEUU
 CiU+LNL+sQSnHD0RfHhdWxdTIUNKI3H0dSvT2ddGUSKnuKgY1kMJTaxV7IaN9j6I2KxF
 Tm8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnwCYwaB0BQwMvm2liIDceINEimzqkgrSkWW+P2l7gIwe2k+QCdA2nEYdBKquw/yemKibzlSA=@lists.denx.de
X-Gm-Message-State: AOJu0YwNCIrsEtuKP6lQPnFMxdAlZd//E1lIRc4mefqvJVNWPWRaDpjg
 Ozp13fRDmLjBL9v9Y5mm2z+wv3DFNXJeveQtdWmgDHIBPEsIFQyHgarpPWaQLsYbOe0=
X-Gm-Gg: AY/fxX565KhhpX/QbqvLNX4ECKjWAzpimKkZHZJN1qA8zlxArMhqrCGQ1L6X25WbkR2
 Bm7o4NAE5feOgxiMPFCjVm4dH8d7xdpU/SQ2+hZzyHFw5dMOujSkBUl0UTiJLUJxoBv2AgI535P
 0mAQgu6KvJfU3fOVheuI8MmThYMiWr/bQ5+Q2GAz2dqd4HM5V8RvnkpsamNMXuSYz8UShcqYeCs
 VbVmKGGC5ofzgEYtYNmo6UjgL5tDT5J/5IKarKAJCznigEuu/mO6Y6RvIkkWXEmPn0rfi+QpsIa
 9MvhOESAHObhE1zPH0AtoK49xCdes573YW/TI6puhxL/CPC0Uf1oAtjmtb5GwsZ/97hQzOgB6Up
 084z1sGCEX9d9VDUHI1VP35qLsBFOIumelfM9uq5vt69KDiitV9tC5heqF7oaOqc1Hct+jq+J/c
 DxqGO8Z72w
X-Google-Smtp-Source: AGHT+IHL+iznCM1YJKIUrnB/+Srka2+/ITPdNfg6HtXyFyGOmpxVTdLgazHvrQ2d53Rur7kVAzs/ew==
X-Received: by 2002:a05:600c:1c29:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-47d1959d4bamr140268775e9.34.1766433781279; 
 Mon, 22 Dec 2025 12:03:01 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82fa1sm22970502f8f.23.2025.12.22.12.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:03:00 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:31 +0100
Subject: [PATCH v8 10/13] arm: dts: k3-am62a: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-10-e70fed16b166@baylibre.com>
References: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
In-Reply-To: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
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
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WensgOXxKD0Du+6xBh83aHYlObQdldMOsDulEh+5QLc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxWcivuuzcVoI6louPfv4R+spv337txU3ynj5XAw5d
 KcgIdy9o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACbiEMbI0MvA/Gup00rG3ay2
 VVvDJzBOeqWqmVJw7umZ+H0zeSSevGH4n5HDaSC/Vcd1zu8r3rdUZYKWOVXy2Itf0f1pE707+8B
 pVgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 22 Dec 2025 21:04:36 +0100
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

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
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

