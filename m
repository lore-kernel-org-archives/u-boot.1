Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BD8C7EE2A
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8625482DA1;
	Mon, 23 Jun 2025 14:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ruPY5LbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07D3082CCE; Mon, 23 Jun 2025 14:10:32 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E812882D17
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad8a6c202ffso780219266b.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680629; x=1751285429;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tudm4fUG5XVhNJd7avMNxgpHISIrhY4g/G8Va8f6XI4=;
 b=ruPY5LbROM1CtFrb4EbkTGpcXMb5U3fwKW263Mjv2j725d//nqOzAD6/RBiHlhugJF
 34hYnZcyxxaumQh8jTiUXSdj3jD2TakHDdDTIuG3G3c0QDNPu1KlTHxB9qWchSVXKer8
 SpKMVi9uTP5huJrUiZXSF13wjYh7HweEJ0rfa8YMVjkFeTu5kybBeyuJvZoKQDn+mLm/
 dxzHvOTUqZNACDglGS42Bc96cxMh60In0ZttB/WJKOAdPVTiMOouB2pBRf/GuIq5/HXZ
 7CR3WJ8/Xe2mToXUaN2Oh5UxcMfS0YsEaF3QyEq02GgQ7kYxNc5xnmfgzU6vQVJ+I+5R
 wpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680629; x=1751285429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tudm4fUG5XVhNJd7avMNxgpHISIrhY4g/G8Va8f6XI4=;
 b=od6WydoEtl3eMfjjug6VRoo7EaIJ2AIrxiM29DkgRg6k1NZkzz0LIqVWuN4v2qhAoU
 Ain/H96T9VXw2sqC2jUzpyyJxt10d5rrKM+FPYrBcEeGPaULmYZMpzbQQPpBsfpKhOAw
 DPYO0TRzLWnU1CjIHh0yNIygNC58/fOWz7f4oMzT7l3EwolLFlOfueaa+FFF0BTQ2hF/
 NeNU1Fqad6nrOL14fuvFX53zL3Y2RxfxH7pjUVfQqJMiCXkbJOMbCuGLREacaJJJ78RN
 xhTii4TidJ4c/0JHmyJhipaWeDB0md6qG1QN8kaxPVZaqRTsTxdxJ14UN3mN50A4t1vp
 FG9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUwk8m/Ux0yNarViwzYSq+UHE+8/5wA209qVmQONDfRhVohWi7vX+71PsWb837jaVPHHwLsdc=@lists.denx.de
X-Gm-Message-State: AOJu0YzrSayvnqSQQxXH2NurdqTTtKdylL8Af9alG2ZJCxB2fWZ6oNb+
 xil1fkCkwePt8pw/KdqfyWe6EvFgCzDdwjIXP16s/3dzAifCasx2YRxiW7ayxApm74A=
X-Gm-Gg: ASbGncs5+VJreF5iTsnMcLJs1g4r/RQcs2elwx1pC0T3n218V6OhHsq+ETL0g4c3j6q
 UlQflZrN8Tzc4Zceav/ZGz0jAzmRPVHCd9t8Wbp0u1w3QHnn0PzriaTqlK96Z0ih5bHMJV5DO4X
 k3VEQmq1oAS/m2JjTtAPi1GYiNyUFBsa/y85cCeFdK44nFgdFARiJjYWirpjRCMdRQSA2hgCjv5
 gAKKODe+OunhSvQimBlD+zWrz8ro7RH9dgiBQEN4Iv19/CxDAGM6vHnzGltM2Hk1LUx+KeNXV90
 ZwL8r7Kg+elljHGPBXI1UFg2YwS/mvY7zJnXJaRIs1o3utaB45ubw63fLY4=
X-Google-Smtp-Source: AGHT+IGL0XIgNPLQujeqrl+iTYrb568FnxtNmG9M4nMTh4084+egBttXQfkdHHxJXPvDFkPAor7f8g==
X-Received: by 2002:a17:906:f58f:b0:ade:9b52:4cc2 with SMTP id
 a640c23a62f3a-ae057c7af01mr1195272066b.59.1750680629396; 
 Mon, 23 Jun 2025 05:10:29 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-60a18541d89sm6061008a12.18.2025.06.23.05.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:28 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:25 +0200
Subject: [PATCH v3 02/22] arm: mach-k3: Kconfig: Add symbols for IO+DDR Low
 Power Mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-2-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MBaZdl2uiEJ+2O15wUJpkFmdRcBSPjBTXe/m05XGW04=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI55N2ZZvE3DOvJKo+22e/2Cia78NKnskWhpOKBAtSE
 rSdwsI6SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCIeixgZnur9sn1ezfNnwuGv
 wZoetT+0NKdU+Nlc5X54p/FktViQJ8MfXrPn3yN9pjqc6pR7Erq/Xfi2ROfB7Z38Dgu5g1gddZZ
 xAQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
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
2.49.0

