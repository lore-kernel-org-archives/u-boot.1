Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965F7C79FA7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F70383EC8;
	Mon,  5 Jan 2026 17:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y5x1FnAX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC3183E2B; Mon,  5 Jan 2026 17:41:32 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4007583990
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso726055e9.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631290; x=1768236090;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zF/5UH6gL4zSa9KYCQ6MMPjHMcYSpf7GvHImAbRf7iQ=;
 b=y5x1FnAX3Futv3yD4pj+hRHlhZcWW84cgTzD0hNURqHj4/bTFgg/5PvsbSSlLK7tmX
 JO+YT1b66oh35skr6y2uGfXWGNdLWSDQP3u0YI8p6L5UYVbZ8uHeQJxf40MiExTeY8rn
 PuMwt3WaB0izpfCLuuLiV5CPXB3UF5PNcLwQkY5CQnVP+q6Kf1k2zbYJ+jklAHvyaO+y
 Bi+J2EvByLPlMBaNd03Ihx6ua4hkJZtEgGXSqxvV0Bsc3Kj5PVFJ3AOwpZ7tLC2TX+6x
 7nyS+xt0bozBj3lPz9LoqEtzBp/EAcevbi/9oif8xb8w3JW1geoi3ouw7GstzgzJlupG
 sUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631290; x=1768236090;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zF/5UH6gL4zSa9KYCQ6MMPjHMcYSpf7GvHImAbRf7iQ=;
 b=dPfkDE6iZNL/dXbN4QMOMMUK5uCJoVNBihb9UkVUG+1tzfajaSATo2VXXvayHrf9Yi
 GPGqD6iJLBxk9O/vruREd3ZBjnw9lziQKt+gDXR4BllZyqTPdSjECR+ifKPfODFdZ/47
 vu/yzoWJ8uIa+pW4wuXqjKTWIB97aoNQzE/Oluk54stehjbeEIasz8o8AMw1QVJ9auLS
 N/g20UloWdyU7HKn520K5VV1lV40wfMOQoJ2mFwasUQgXdxwmev5V6hO4Is/z/ypfg4t
 vSWh3h6VKN+Jri+IP8hT2QeEVgF0CY6IU9r1yS6cSUQ8pAABrhxi7HgL4VxzBGdvbPQA
 Bfpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7kdesLYSauC5zleGP51M4UtxNMY9681LRtwNUO2NCtv6OjJ4T3nwaWjWv68/XcPybkpVu5Rw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz15NxK8vmS48qbql3xid9QU/KY8tOFqwekFZpel4uR9L5CXRNS
 rYCDjreg8IkE2mT+uG6R3plHP2OGbPJc0daKxHnKVUcwoXdkZJ+Trp57fGjqQ8KTGIY=
X-Gm-Gg: AY/fxX7B5Q2jDXNbvYFyC4Sq/p5040RxqeM7XjVG/gBCkGJl7mm4jZ+L09UTbaFgy8M
 FCVkl2Y1LZW4ySpqwhl2OMUDpMhpaSCB924OWDgae2lwY0sqrGfcUNQV10gcBBorQ7z65N6Z8Kj
 qtFz6Bt+aT6iB7UL6xB42P5UQo/N1a5TfQBfkVWGWNdJbB/plqCWNl1JdYa4KKQ8pJahtDdnp2V
 JKL63IXebVdgPzlQdcDrszP6NjF1rBLWDE1mEx0TINR1P0T4PpQKbNPRQzLzMd6I48nhAT3+KCf
 CTQSRB0UYgEmIFQGR6IH9Yg5Nm9mXQcRB4QVoSu54zaw5iawuP/9ej+kDFY7j7qrOzXP6EHVEqU
 viIyTM7ymWyOFpQEoG/b2gUpW0BQ6MQkBtAbtaeIhOTNVRyLNhVNNylqgN/7ymUYjd6XkYfqQCp
 0/d5ljXWUK
X-Google-Smtp-Source: AGHT+IGUyIIvW39T6euhUxi4er1hVqipfk/Eo43U3pNa15XLOyxNM8x3H5jV3d7QADAYJgDDaUwTwA==
X-Received: by 2002:a05:600c:35cb:b0:479:3a88:de60 with SMTP id
 5b1f17b1804b1-47d1959e061mr607983145e9.37.1767631289628; 
 Mon, 05 Jan 2026 08:41:29 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca52b1asm434607f8f.20.2026.01.05.08.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:29 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:56 +0100
Subject: [PATCH v9 11/13] arm: dts: k3-am62p: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-11-7e33f2c77dbf@baylibre.com>
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
In-Reply-To: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszol7M2Gls5PHGWC1ebntV9aJ+av+6i3pP8RiE3i+ZbK
 e0SqOjqKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgInscmf4Kz7BMl3rX9CVhwzl
 dQdqA6VckvQPSPLb24nOnl7IWlvwiJFh9u59QrxOqo1L2l2ebL5WVbskxHFRzUee3YUnPE4955z
 LAQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 17:42:35 +0100
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

