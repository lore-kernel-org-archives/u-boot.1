Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D98DC79FA5
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74AA183DFF;
	Mon,  5 Jan 2026 17:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XN4A0W2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45E48398C; Mon,  5 Jan 2026 17:41:18 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBAF3839A8
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so967845e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631276; x=1768236076;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zimDLWe+R6g4KrPX4q8XkSHuS6mFsYagnzp4PJDzHkw=;
 b=XN4A0W2x7TQx1rZTVU6qdmW7YGfXkFJbTHx52ptQmRimjI4j+g0ANATEYoiETsExnP
 ImBEUBjcEwDQ+4CtfotXVGQ7Mk7yn/iPsr2O+WiG/RkGdegbMw41OjAxLrWQ8AR6OYaC
 RgDvqPmg9lLRgGQpmoA/Qx2hw+ZoyykwfLjGPz/2I8oAPqB/xQtxNsQeWF51z3DJxnFz
 idNV0eCNsNBqyykmmBmGjddm/wAuyhKI17Ha9hBct7YId77ibTM4SZFdrlgKpx8nDcLM
 Ix1xMADWwqDfSL4ccVRxnwXfw0lRa64APzZOJAFI9W0/+d4qTVsLaMGINaTP042tsllj
 7dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631276; x=1768236076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zimDLWe+R6g4KrPX4q8XkSHuS6mFsYagnzp4PJDzHkw=;
 b=qLAnadOq/fRGVaZ1ah5Gk4hOnmptx4Py9MoowtWIwG7wJgK1l0b0+KcoZDLIz0nVmQ
 XcQZ7vQ2rEcEyiLLARi9ojRXBfdYPbPH86/KZ/l+M5liZOgJ1pCJOljDnHrEFWmmw//w
 zpLcVIp3tehypkN83aLu5GlnhQzUYBhCX/f1PbTsT5zHuYgAccLo/Xzeue3/jbU90kmK
 IZSnteooNirmLlTruAiAd5FEgK33U0c+/u6ZcBY+UxZzRFkkTbvGSKtK5PtMW8MW5uwY
 kwHV+zLiHes95pKORAg3J5x4Dh08ZvUFAGByYStvXkiWivT/m8rfA4J3U+BPD4K7xkhy
 +hTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDUgaoBdphhhRJ0QAxSwGMRn4JuURLnP7jNjD/772pZqQVfSi1sN5q8HSXyGfbWwvhpD5NIN8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1gpAnVLUzG4Jf13cUczGir5hllNwNaY1ZMBY9Q5nxRmHdfF67
 kXi8tG6gBjb3iXpX/YDp9xm/cHgG+vKpHG+3YOloOi+1M3AwJukdJMTw4/0lD74ccvo=
X-Gm-Gg: AY/fxX6T83Bx/2rP2t0Ehfj9SXaSuiCRuKZMZ00lyBei7k59EzOk80uWtHSiaAOt8QH
 rO8FXZeCYw3miwvhW4nuRPu7l9el/TlSn4MJ6gAvogXRtVqbgYEjH3KHuOScLx1OhIctF49PDlD
 yl1yGRbSCNjpeGJvnYLMAaWjRHgcvCzOXD0g73j7ENKpMY3hGKA3LbVGxJ9pnHvW47S4VRPrhHh
 6iQGIvtMYYxlUkrmouWQVkoUQsqQejrAXrmiAFXcZe6vYMhI8KEm8WIzp0idEbWz9dx6EcsIeTW
 lZGcssqWgHF2vE0WN018ihtXLI1wxH4hslTvXO9SjGooIMXzihTr7d/DHqPy2MyKAlmPHwT/IJW
 bsAocEbSfItZWv46b7aZzO7lGC4nrR7Pkpmdo5QMEAeMDqOhtAXkot/XlFxDYdUVxgHpuaN9JeV
 ipvYAqPWHXEi5F+jID1is=
X-Google-Smtp-Source: AGHT+IFDAHilpaIaXHMlwALy+HW2rYB9kMY6yEPuX3eXZpCKtogfSe+F2PCVcgmzu3KVmT3cjH2Y2Q==
X-Received: by 2002:a05:600c:4706:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-47d195495e1mr620904775e9.3.1767631276169; 
 Mon, 05 Jan 2026 08:41:16 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d13ed3fsm160875615e9.1.2026.01.05.08.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:15 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:46 +0100
Subject: [PATCH v9 01/13] arm: mach-k3: Kconfig: Add symbol for IO+DDR Low
 Power Mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-1-7e33f2c77dbf@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Op+O6gzW8LIXkNV/KvnP7P+ut0cXOoRR7MXS+CuUb6I=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszolxlXTPzXG1YutZnD+3eNgtqX7QtjrI26fgkbPE070
 dowZcmqjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhITyTDX5kblX8lWy9vEbbt
 vDhx9va2vU4Ks9bv1ShUz+Dt7eTNqmP4X9T89W2IxOFNu3IPmj6MED1Qse3D8oy3b0Jmue05E3l
 jHicA
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

Symbol to enable support to resume from IO+DDR where the SoC is turned
off and DDR is in self-refresh.

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

