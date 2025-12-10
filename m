Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1B9D3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 702F683DA6;
	Wed, 10 Dec 2025 16:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W2aJ+0i6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94CF683869; Wed, 10 Dec 2025 15:11:11 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A323380077
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b76b5afdf04so1126632166b.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375869; x=1765980669;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tu4eT6SupLNLD8nmrrd+M8emsZw/aGFSC/c8P3Y1Ls0=;
 b=W2aJ+0i6bevy1qfeLJ4gR3YZCe5C/EgQl5clkzq/m0itRRl5LXWwGkkB8EUeT7RojL
 d30BAMG8u9cYR2crCR6lx0oJ1WKn71BKTkcYh6APQpBLZ0A0EDmY/O/60z0dvDU3ZAZU
 GR0mSpz35BWe1veNMqu3yE5JpP4Z6KWu/C1vJ0JF+L78xJC0kqYP0ok0Tuenez2VZAPu
 U/JUIIOAEGLuaEHD0a98NPU5JP2aThI1FOigh2DXlybLpY663uhzeOEQNSPDjuv/U+ML
 75wBDbFCD+bbx/ubt2ISCECCpe1DgZJiumZ6lwhcrqXE2GI7ErpwgSwF8UQVp1qEee0z
 vLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375869; x=1765980669;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tu4eT6SupLNLD8nmrrd+M8emsZw/aGFSC/c8P3Y1Ls0=;
 b=D1uarZOmBAjGI8OdLTEnL/U8PMZcWWtAZUMVZULFpcbWg6cqN+5tbNrhsN6oOkzOu/
 3zkgmbfDIl+aslnRCiTddPv1/yZBvsuy/KFz4ykbs6jdPVIccJdO0St7V/ULz+G3wNyh
 K2hf1X1afdoxec3zcc7/9N1wb4OTRbqPclubWJuf7R6HEo05+rszOnIvxOFMIUKik7bg
 jjNAq7WcQXNvC7wycjs0d7DXHHaiNzbJMpWWo9NNBLbipiVkU+b3SLHs4myxdvUt7k3t
 vAHr5q14aZZI1ojoGXtQYHy0WcObDZqvSEs9QW7VhRc2/a8yU1nXT+I7uwZrXIfmGFCe
 jUnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbL9cw/spZM1IuJOLaapXAOypBMZWlXGdOENADTqFx9AQv7bn0KuFm5UKc4UYPYpnx75jwIbg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4oksd0Qt87C5oQuQokroo/29qnLIde/jmrAU+btWX2cxofw6p
 qYvV9g8TruIR2s8OzgneVpaSSqoxYCqmDbnCfgYWt8xSQ10kAMfKezD6dLuQjwWt4FS030lTzCr
 qnbPz
X-Gm-Gg: ASbGncuPpTjl+9++c9oBmvZJKjPymZ24BjQ/2VN/qMGeXHJ1bgweb6CjWudC5qFWYVh
 tdDePY+2q/Mlrc1PyJkCQfz6NWE1tKlpz20k581fwCj24OP9jodZ6sEzxiq/z6jFHIbM7gmmsrw
 JsO+dBhq1eKYR3U9YtUEHza0MHgI4uS/VyjEMmc3/ZG6u38sPVCIdJgIJ+tFOgfcPSNsKEr5Myr
 OEvoMfVGwo3N7Egf+n7B/B3RgzS3hAG6wT1Q8c4X7vz5WCrKdLfm4KaNP3A7+lJNBW7FUZgkQE1
 rd6Ai6TA+nFlDN3sDuWQHzIuEkPDEF0EEVL84CEdTa8ger173EC+yjQYaDtXhN28vgq+165CzqL
 Y/+0Swql86hneU8HeoMGrb8ND1qRU5TwzRWSLnjAcoBTRFRaP3i3JrEUwKw1F7CkZukqm4YjNby
 Z7hQCQNFO2YSohBqgGkIU=
X-Google-Smtp-Source: AGHT+IEON9vs1x4oK9mnym6QqBsDzM0UkhDem97r2BPd/UX8bxL8y15Aes5h2VCRUtUCmFBbEtxiUA==
X-Received: by 2002:a17:907:3f25:b0:b7a:18ba:a63 with SMTP id
 a640c23a62f3a-b7ce82d3402mr250700666b.19.1765375868994; 
 Wed, 10 Dec 2025 06:11:08 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f44597d7sm1711097566b.11.2025.12.10.06.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:11:08 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:09:07 +0100
Subject: [PATCH v7 13/13] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-13-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=msp@baylibre.com;
 h=from:subject:message-id; bh=+1FLRQznu7vBUYLkWVsW3TSqyEPI0MT6bAKgsQM3sLM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzL+tjfme9674Vcq/r57H7wvbOfP+kezz4SFTqFPeK8j
 dmCRVeKOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiUQaMDDP8nDaaBZ6drvdO
 bd4dhbW/ZNZ2Mij2/BXULKrgtBL0ecTI8I/lweY6nawW9aS4I1NWTg3/u27vkj/XtNY3L5EMrNv
 UywIA
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

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Tested-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am62px_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index c9592d7b6c4cc037a886fe81385791269a825aa3..39e8093597352e6ed3fb67ac59e0494239a51352 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -123,3 +123,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.51.0

