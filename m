Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B129AC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A7FD82C79;
	Fri,  2 May 2025 17:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jLvEjfyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7D6812BC; Fri,  2 May 2025 13:36:21 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A61080F03
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 13:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brunosampaioleite@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-30bef9b04adso17608751fa.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746185778; x=1746790578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dt+9s3TAX9nIu8jfe6bsA0rfNacVrC5fXtALuaI3D0c=;
 b=jLvEjfyvfDPAnFZ1tlEhgCW+5gpMXLDOxRa09lPy2dlNhhjZLOP97JIKDF9A5HnD/z
 UE44GOWYFRE4UiEYFlNAOetcPEBbFKKyGUtb7a0jTe7QhH7Anv2YAEoUg1LMTMhUjfDp
 ulIOzatVcN9AoTX8Ug72Oo1SOQxo5LQ/mYWWAi0uQVxI7rLDgkK+RnGyJTOx3JTFw+yt
 phG/gymaR3TUzHOyD1m7vN8VXSja1DhRntmTpf0LxtDzQSs59FinPBe3muwXP6O9KQNk
 k3frlBOpImPIbMrxyL/cQVy9teVonbxMfXATSbkQVdDghShawgBilCZLZw/rGd0inKyP
 o+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746185778; x=1746790578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dt+9s3TAX9nIu8jfe6bsA0rfNacVrC5fXtALuaI3D0c=;
 b=rwXEvPltUCUj1O2pyZAG3jrZ66w4dhRNNdylTdQDwH4dOciQchduX/U+TeoNgGkr3r
 6HTgKK54GFoEprrzuXfYQn+f4H/AhXaZd98X/DhBti9IlRRzRsdXDuCn41RPqLVZUC/s
 Ibwt8ymsEU5SRSdg6YhXttIMPda2k67ZPi9j/Bd/D7QINzIGovio2hj9a3JXeIeZjRmu
 4PfpKzkwAincuj9vTU00z3zrZ0mU5fH2T3/26le4sZu4FKretYUM2QDGgicl/9H5Vkjs
 dOc6hvmHJPTLNX0IgRjTz5k70ym1IwLbYevWNQ0rm2jpZJRqADgPCokikXoHAU39oJ0e
 4tzw==
X-Gm-Message-State: AOJu0YxglqgfsIbDnhUGHLiinbnFPRY5TqHDHRXliCp3xv8GaGYyUwYk
 6Wiel4jtjL0LUz6XNvIXNJ7W4Dg+DLgf27+eehO7811yFxWVoLxAtq9k62yW
X-Gm-Gg: ASbGnct3CT6cnWwPOmRJ75it+b4XrTYNFOG4+iy94vRmbEkdLpT9YQ30hpDz5j91R83
 e7JkM+SKJl1VQU95+9kZz92+phdgM2KzfZXTOD1c30yf0vBWbJeYv7GbpzZXjZNPCGdMZ/akRHG
 GXvoYDOaJbB6iBABSlHIYUvsRTLPZOJIdqWHGCLbL01ODXtAg0CI23W0jjMD7VkzVRWgp09MCWi
 4W120sXBacURO+b7gM6eqvq9bNCL87+JWSO9E5Ddc9JWLLeQtqYUS6xSxX/sq2KfkYN65o5+Bme
 /MMC0KM7aERTW1gmE2OgLZsDoyr5/wnbM/dsgoXi6TfiyYoiVMnfaVYB6lclBhy5h5tYm8I6QA=
 =
X-Google-Smtp-Source: AGHT+IGRLTzZO7ebnjVBtsY6L5HPXs2hB3PRN30sqfeGwzK70m9cUa+JLqXBczYWQmaF78S2brUh/Q==
X-Received: by 2002:a05:651c:1507:b0:30c:518e:452 with SMTP id
 38308e7fff4ca-320c41f1f72mr6416201fa.13.1746185778148; 
 Fri, 02 May 2025 04:36:18 -0700 (PDT)
Received: from brule-Precision-3590.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3202a89ef3fsm3172141fa.69.2025.05.02.04.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 04:36:17 -0700 (PDT)
From: Bruno Leite <brunosampaioleite@gmail.com>
To: u-boot@lists.denx.de
Cc: ravi@prevas.dk, probinson@gmail.com, Matthias Brugger <mbrugger@suse.com>,
 clast@prevas.dk, Bruno Leite <brule@prevas.dk>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] Add rpi5 specific defconfig
Date: Fri,  2 May 2025 13:34:33 +0200
Message-ID: <20250502113556.134731-1-brunosampaioleite@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 May 2025 17:01:15 +0200
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

From: Bruno Leite <brule@prevas.dk>


Currently rpi5 uses a generic rpi_arm64_defconfig file that builds rpi4
devicetree. Add a defconfig that is specific to the rpi5 building the
now available upstream dts for that board. The defconfig makes use of
defconfig including that is now available and only changes the DTS
related config.

It is also necessary to add a more specific u-boot.dtsi to rpi5, since
due to the ARCH_BCM283X config it will try to build the
bcm283x-u-boot.dtsi and break.


Bruno Leite (2):
  arm64: dts: rpi5: add rpi5 u-boot.dtsi
  configs: rpi5: add rpi5 specific defconfig

 arch/arm/dts/bcm2712-rpi-5-b-u-boot.dtsi | 8 ++++++++
 configs/rpi_5_defconfig                  | 4 ++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/arm/dts/bcm2712-rpi-5-b-u-boot.dtsi
 create mode 100644 configs/rpi_5_defconfig

-- 
2.45.2

