Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA06CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A1083ABF;
	Mon, 10 Nov 2025 21:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s2yL6W9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9954783AA0; Mon, 10 Nov 2025 21:11:44 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988CB83AA0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640b4a52950so5225529a12.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805502; x=1763410302;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zSqgheeDYHCKxW5YgUOjbEwqqHvLgbAUrpzhFuoZ3xw=;
 b=s2yL6W9cIUWoDGdC9O0kjp4dU0gSzj4FjlEbNCv8FD44tYAK7z8eZPmJSOar6Jx6LN
 Um5L6WoYwmzbpqpF33xqn4tll5fZXJaSnittK2jHw47dLfx4nBJbv1ZsseFLjAstowzM
 15mzibC33kBGgueUoOrydq86Y+uw0pVxGsftj0VEQ+qFLj5NN/bkk1Tlvym8VkYVWGv0
 +LrTPLIjTD/ukDqEdBVwpClvT1/+Vi3Uf6TSDThPABdzegCCgOspViTxAZAZjCrlTiIo
 VsKBgnu+/79CBuX3Uj/b58V9/+upFQ3AhGI26+3WbmDmqX7bUfC7Ro3n/+mbmOwpDFbV
 kBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805502; x=1763410302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zSqgheeDYHCKxW5YgUOjbEwqqHvLgbAUrpzhFuoZ3xw=;
 b=VAZlTqj2ofvgH0iQkwnMV9YbAsi4ZPgV1XiYZlRayJFK5rykZFnfNvXgAER8Nos7Rz
 UfhzIaoBEY9QT9G+nzAg/gejkFSGhbD5yxLWapKK18ZCaSjZ/lvOfx5jNcTMheJ9SgIW
 yPTT1MKMO5og2b9366GB1iUjRqU6b8ISzhgJa/yWsDHW6kZq9BapGtf7RPwYblwNPDXC
 HlzSg0UJGOpPQM4d0h+inZ6/3Il67m83vqkvg33VvzB3eQbtwoDnd18A/loZzEyzJtyv
 B+eypl2Os83Z0dkV8t7/OhYgaG9SxK96JzFQn6SNBCAoTY8e0AOCZcoyZrBl6GJY28hU
 JrNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvf3uvH433tgwkPJLzb6KTPEwgsxwS8m67DCrOT3YcyMJ9W7gHW8PRzu6/ahOK2eWyAqy4XvE=@lists.denx.de
X-Gm-Message-State: AOJu0YzMmTs5cI9UipPsWDGV3bFfKy1OaiP1b0limqULKcfb9OWzV2mH
 klwFw6yapaiGqaHT0+EsNeOsFwz9YzPDMSRxD+WLUZf2Z711T24K1mkHd1qLeiJi/1o=
X-Gm-Gg: ASbGncuVfD0ZWj0XgEXZXXx+9LVe3Snr0vx1JRngOam2p3WEniOpkS2+zHhY+zLnVOB
 0BHx8F6ePW90bzQVLPJEBi8OgDL2eQvYLBgwi9BxAf9PTaaceKlVqoRRkcbHX8SDiotLJuKejBF
 /VOiiP0yvFPeMjMYhnmPN1lMphz9q9Gf9jeVAjQk8spCWitU21JJT2dkVV4Epe73oPTubUvtbHK
 r+SHrpsqXFMOH3kfh4qb7RA1WsA7D6k9Su0Pfk1mMZ5CE3MVtLL60AA1NhKl9pn3DfYBE+WwDAA
 1MElcup7LJsgI0tdcoAJjPox5shLLQLPK+t+VVFhqbhtZ7+s0JetlO7Xz9DntAe16rny1ZFEEBQ
 pqiAc0UyugSppYEkqIEvRm+keqNaYyXIcT+xcYZlwImc5hCZsJpdpM/ytKxYCJwwzJ6JnGkmm7i
 nH+H2anw==
X-Google-Smtp-Source: AGHT+IFu08SvqwAxvik9tBA/QvxvRcfxx6v3rc5r/IeVeTXKY6AD4Sa9btsWY543WtcJTS6CapsS6g==
X-Received: by 2002:a05:6402:280c:b0:640:af04:d718 with SMTP id
 4fb4d7f45d1cf-6415e8559f2mr6309422a12.30.1762805501975; 
 Mon, 10 Nov 2025 12:11:41 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6412a27d68dsm11151549a12.9.2025.11.10.12.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:40 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:26 +0100
Subject: [PATCH v5 02/13] arm: mach-k3: Kconfig: Add symbols for IO+DDR Low
 Power Mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-2-980ee0036c26@baylibre.com>
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
In-Reply-To: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=msp@baylibre.com;
 h=from:subject:message-id; bh=HO/gadQbNdCPL9w2QbwpZ+6BWlxDxjQcNAQingd8540=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwht70rb33//32r77aAfzN0ojf0TJy1Lf1YYPEBdXfmt
 +9i5kT+7ChlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJlO1gZJhwb4mD1/pv/5V8
 1dNXRP1U2j1bQ92suZFpb8D5JWqlZ1oY/idt08i84adVsvlqpmkz7+KNyfOnsCot7ptTc7134l3
 787wA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 10 Nov 2025 21:13:08 +0100
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

There is one new symbol to enable support to resume from IO+DDR where
the SoC is turned off and DDR is in self-refresh.

The other symbol is the address of a memory region to be used to store
meta data. This has to be the same address as is used by the firmware.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 1b8c0b1eb968f0414107c0bf3142f744ce8364c8..4b7cef64935c7b403051c080eba7bdb48f727bf1 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -148,6 +148,14 @@ config K3_DM_FW
 	  bootloader, it makes RM and PM services not being available
 	  during R5 SPL execution time.
 
+config K3_IODDR
+	bool "Enable IO+DDR Low Power Mode support"
+	depends on SPL && (SOC_K3_AM62A7 || SOC_K3_AM62P5)
+	help
+	  Enable support for IO+DDR Low Power Mode. If this is enabled and a
+	  resume from IO+DDR is detected, metadata in the DDR is used to
+	  restore TIFS and resume DM.
+
 config K3_X509_SWRV
 	int "SWRV for X509 certificate used for boot images"
 	default 1

-- 
2.51.0

