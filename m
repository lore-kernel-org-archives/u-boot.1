Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE41AC79FA5
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60EE983EB3;
	Mon,  5 Jan 2026 17:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XJrImtaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1C0883E21; Mon,  5 Jan 2026 17:41:30 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A0C8398C
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso691625e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631288; x=1768236088;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fRmt5bRgcwvj06wvWV9ib5uL1fd2vAST2VDDAK8mxAw=;
 b=XJrImtaJGZBxfXQEjEdRagIqtGO4B9qLv4VjifXRY4x4E2REI3fg3LZXAzzvJ6gRha
 aAuKNZtcJ4LKoHSpkmnh5oJrFt9BNiqgHAoJH11RrzY65GS81TOi9Sw6yE0BboLyrj0l
 jfAn4AW9eKx4aLh+BDyx8/HDCmiqdU2VkqfBJ/+EHOnIiytiUOoVyR6+LGvWXNYIhknr
 YmeiC1PKX1SXSU4IQHItBUhBPwm4BIphPwk32Lh4omS0PmczCTtTcbOJEAhbnhDYliC2
 67fHI29SUyLVAaPQDZlDRCF+MPFYb6TQL9S76PYdgCoYkmSGGjr3sdC1RmkvZQAbfZil
 mQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631288; x=1768236088;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fRmt5bRgcwvj06wvWV9ib5uL1fd2vAST2VDDAK8mxAw=;
 b=gHgJXBGPXa+UlyMvVgTTYfN3wxmUN4+uMcSZMn2gE1KfmYEV9GetdEUZkID1q/JLYE
 5QRWgb+vlfwWs0bJOj+MLmS0Frdu4bO0IYriSZ0tQfQD+esIUTWhpUcmKiTsI/U2UTlu
 7NQ37ArPNajdWxK9Tcmpp67WKo/yJ9EY4WrI94xAH70726OWaTQNpaNm9a8XuQ6LT3rx
 LG5wTz3cXhBseLj6B7ycJZqqV5a+vMWLD5r2uiFoRrbkawnC66rJNwCsi9ArC0HjplRj
 zB+3zO5ob4zEKiQYzOXU4ZutEvV9Tjn6E8PzP4nJlbO1BBcfZd0laHhzj8JDe/boH/q6
 eDmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTpRNN8rlYN2/z85lHJIeENpv/fr5L8wy5H0WvwuLdCe6Ij0F15UJAifO3bSt2NlSZx1Qf+Mg=@lists.denx.de
X-Gm-Message-State: AOJu0YxdgWITPlexmUhL/b09F3Y0zS+gNbpFf5wssJQA5KTA7j04D5DS
 /MqmgoXlea61Q9PTmAQXA157aT/rydKPKfdrsFXs9zdY9rI0xJ1icXlkBMNAvmEGvWw=
X-Gm-Gg: AY/fxX46/AcnNeNEx4YvuivNTJ+DpDV7tp/s6lHp4pwIDTSIv61xpBhicxwlMxYitBU
 NdwMZYZz+8XWupH7FqZ7ZmOhcV6i76OG+LlRCLotjzQboAibG8pOuQ35OhB3K/XYupXUM4hbaEX
 Kf5+NoE9YwEOmmZ3wKcsnH7st9zxl6gfpznNLhBw5K8z6UVX5iquHat+cSQjEdd3M75Q29CDCz/
 O7K3puuuCb/3W3eR+oWm1zjJoMA8gmQ0wjlfJS0AR4pIaOOr2ETgLdXhRXnqxT1Hek4SYkC3Ei2
 wCS/dAyCNY/c9WXTSiiTjy767dKf8FhOBPpdIYVONQGlxTPfUv1MYoihS1BWYNqU8IYDR9S29Yo
 P6brCkYrmBTVKrxtWI3c2WppAyjE4cv0e2I6pEFO6NU+StcKPWhZeJU95SU7TKbJbBG8lDs6Rr0
 w2pHZGLyN2
X-Google-Smtp-Source: AGHT+IF5JQvc0zZNRUyZe2Bvdoc1F3AMatzEoncrCIUg6oxOUheFy1+Y1+JklNc55obsBztvKwLtdA==
X-Received: by 2002:a05:600c:4746:b0:479:33be:b23e with SMTP id
 5b1f17b1804b1-47d34de4cacmr529582595e9.17.1767631288320; 
 Mon, 05 Jan 2026 08:41:28 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6ba40b55sm64112215e9.3.2026.01.05.08.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:27 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:55 +0100
Subject: [PATCH v9 10/13] arm: dts: k3-am62a: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-10-7e33f2c77dbf@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WensgOXxKD0Du+6xBh83aHYlObQdldMOsDulEh+5QLc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszol1M8Hj2RZGTnc0pcFLrcc+3EJQ7NEz+XSe25uPJAT
 lriteyzHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARNxOGv0KFGi8fTzB0ChBx
 j17nuC9S61nsnqTJgSHLns13qLUrCWVkeBdUxKQ/4YnSrKA4VcN27fZnya0TUmMmcXpxH7J7rxj
 ICAA=
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

