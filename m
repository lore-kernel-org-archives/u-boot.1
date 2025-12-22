Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183CAE69166
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5798E83FC5;
	Mon, 22 Dec 2025 21:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U+s5BGED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A1DC83E88; Mon, 22 Dec 2025 21:03:05 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1488283B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso25919345e9.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433782; x=1767038582;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zF/5UH6gL4zSa9KYCQ6MMPjHMcYSpf7GvHImAbRf7iQ=;
 b=U+s5BGEDIIaUzV3m3Jbo6wlV4a44obFc+0VqclsZCU1gzR1o4TYlqvvq/8QvZdTvzk
 C0cVWRFNWG8707+nOc6s/9MoiJJyj7uRUtLr9n6ZKCZ5isZB9ukRUujV4Cz2lZBwBsDH
 0rkMeIsWSpDJxrpCdubvbfntcV5U0CEz6Tl/GBXODBQNbPzaNO9F5Jtjb/c2e207O4+E
 t/OjW4KTdvCqLwt3XLaRDwAl7TTcsVsVHekImzDemV2OtnuetFwExEd2abpQjqLidcpV
 Jma8dDVf1eQBJJW+TAz0CtsfSgLN2AlLD03QCFideDPHpaM3jeGgZep8BQt7RtnvJT5r
 2j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433782; x=1767038582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zF/5UH6gL4zSa9KYCQ6MMPjHMcYSpf7GvHImAbRf7iQ=;
 b=RNSThe0kFMgA72tJowJfpJpUxvGWgVPB17JkSrfGXj2xWWAV1et/1xJmdvHTyJ+7B1
 r1HB6EO9u01CYZdf6zhMIWyATTrV5zhWbHfrpIzAC2tO8VozMREm7mncIEBS1gGJp6vh
 eirS6mDqwBn+z13Y/Q5w+l69iJEHAUVSqJT6RAgbk9XCxCPhasEhY/VYb0mUkEkBqzgN
 XI3AfZps85C3PrQkv/JSl0CjGsL/qewyALOGFUwD0CfFAgT8TQy7MYm/T86YhX/ESOS5
 tZzpN36YEpmxVJDvJw6t+m0XM0ptVYlx0dMI1sleceyxOYJfewnxnGo6ggoDl6X3UAMi
 EcgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6w10NWy+WODiLze9LkmZBUP1/DeUCwp9QNO0JpKRxWrUPtL1VwHLdUwM9lQ5iQBKKqvBBrJk=@lists.denx.de
X-Gm-Message-State: AOJu0YyOiBgGw/vCNVF3kbseFK0Rcdh4xky1y1kiOvikI1ZiQjCxNntr
 bWdfqfohODVvWuqHC0hut4gcsSFRKfPdIjRryRvPOTxosXsN6xjstVttmw69Q2raQxU=
X-Gm-Gg: AY/fxX7Fs3HFX9u5FLj2TJc+a6THwZ2V8/y8gPK89hX8YKKjVTHxShCLuiqAXaz0rD0
 rtHHGx1jqHSlOeDj14TXxRjdo8Dz0NDhHD27KTlyIj6XZy2LP9oUQbfCqaeW3h25fa4SNpbcjbd
 DwvUgGxb9ZL0P7cFVanUBc1AWkeX8njbGXIO5qz7l4hdyWQJ7aApN6PQlVwmZf4ySQ1jBCZz1hP
 V2CHvJ3eDz8JxYo1U4KZMs7vq9LfgIJ+CkqhB+W+PPt1ObBWfw/DWVXoai+YSb/micTa8smddCT
 35+Cc9ncoNv50ghUmncj89M3ZBvdeEWLZcWklYELfzOXs/IFzQ3g3ooldRp/v8Eu75dORXigf5C
 1RiOamDFxwP13mrE4pOVJIbQeS+3w+OKOJKgXN1gvWBqPMGXGAtUmOkAEaGgmbIDe3+y1fTVBWL
 QMKVwtd5px
X-Google-Smtp-Source: AGHT+IGrKiaTmpODSiVAcqhhNUrG9n4qmUbxpueKTNjblsSLbatVtcDNnf0+D7i0hRoosNKOdYCSgA==
X-Received: by 2002:a05:600c:6610:b0:477:a219:cdc3 with SMTP id
 5b1f17b1804b1-47d18bd56b8mr121668275e9.12.1766433782479; 
 Mon, 22 Dec 2025 12:03:02 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3bbe1c8sm102137655e9.11.2025.12.22.12.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:03:02 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:32 +0100
Subject: [PATCH v8 11/13] arm: dts: k3-am62p: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-11-e70fed16b166@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=msp@baylibre.com;
 h=from:subject:message-id; bh=IR3ZGyvRn5SQ5Y2r5+Lc01qHOn6U2D0tHEfc8+7Sn4A=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxRdzIraFbRd9KRCyzczJUJm3ZHH0ric9Uq9s/J20x
 PYx7FzcUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABMpXc/IMNszNlVYcoFioeAf
 89MG81nfCl1dIrqkeFaeTGkk+3S1LYwM27tygxntw7cLNy/cutFBubGuK+POhAeVZ/f/C9mX3+L
 CAgA=
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
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
index cf087c6e343a8af6f4bb2093bb6c3f28395a2686..26133d818973214914f68838f678dda5aba63970 100644
--- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
@@ -13,6 +13,14 @@
 	};
 };
 
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
+};
+
 &dmsc {
 	bootph-pre-ram;
 };
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};

-- 
2.51.0

