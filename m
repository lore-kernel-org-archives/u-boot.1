Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6104C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 13:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C5082D21;
	Fri, 13 Jun 2025 15:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B0XHtjCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AE8882D21; Fri, 13 Jun 2025 15:21:59 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1475082D09
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-adf3b33f968so51314466b.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820916; x=1750425716;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tudm4fUG5XVhNJd7avMNxgpHISIrhY4g/G8Va8f6XI4=;
 b=B0XHtjCzebcRVtWsrUVhBanOH5qN2PsXxUDpcMAko4f1mYBF9fOTExe/LX73yv33UB
 ND+yri9e7nvGM6FTwhd4hWOX4SKvLB8BSS7PbbXYy0YqhJDNLV/oRz+P/911Mbe/UgrX
 P9qqXbCd2k+mOJRBCMpWQFBArpOPepzEW7bS4YDCiDDKFPMOaXv0Rtv5c+o7sosKYf1O
 k18bmDwzMHMBnm34zSUc94OzgXnp/jOLU76etat5BmevZEoHKO390Dzg+VVsc/TjBfJk
 4Z41FfIEFSGCb4gxkxFb5UsPBdytONPxsR4OoOiZpFkNTPmiw5YbGrqwL1NMWwMFJoH/
 3ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820916; x=1750425716;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tudm4fUG5XVhNJd7avMNxgpHISIrhY4g/G8Va8f6XI4=;
 b=aLcw1JywZQkf9K1PRdzLsUlpQWyojbYjAk2VjbB8LSaMr9WwurgiQVSN9z3I0mjgt3
 xjTx7v3jFvKY3lA7+MbzEDFrhJLHe1eOyD0p4DFRNBXUj8aRjgNtBemUPYvLPsKIX1Xx
 7UMCF2Y9jzApd/eFTGqZ5eOvqFlHGVQqnc28LztBuIrkvAR0LUWl3xJQx6vaZykaWGGF
 2pH9htYS6n3p3Vz5YvyHmN5hXSZS+89m7yayPvvAK0iKnithTDUkb53tkvPu0O6pI849
 LLvapyUtXqkA35M4GR5kBjuyruY75NghwwGCZ0WHx54InVcRjIUwaEx/iQifbnHyO40e
 3EkQ==
X-Gm-Message-State: AOJu0YwA8f7uu1mdvvFwP7SabRMtgp0YjceNtYDYzoP3Q2aIXobJgq4o
 vJwrC2aOlbJUUSrIZDfcW13BNCILXdFcADPlSyMx6J1RGmCeHaf7/hUchLnAcVFGs8CKXVzbPfd
 A0GKF
X-Gm-Gg: ASbGncugoxxgflXUPyxK3lnLEiF31MQCMiwrp6GvcoEZmySyQzD2pqPUPZ/C3CH/c4A
 9eyubJwpXEA5O9wpQyOHgHxwdbLxDeBDnLO1IX3LCXy/ZAvH3AjjI3KKGr0sLxyHYLhsqy77j+6
 JKKynQHZoJ7DY7grkMaWZraextLlwZ8dxi2ZWyipac7Cbuj/HvDU0K4e3LqqqI1q9K1cUHr08j3
 5n6XnW6/G7DCNkEIBIs67kgz/QcAUxlKfrZIxcpvp8jNgLIzLmzvUgT9qHhN9kYazkDg/GB1iGm
 MueMKUyvb8OKnFUgPHZs+p/2Rsvisk8felha6/ed5GoZIX+LssKMBCBCNvA=
X-Google-Smtp-Source: AGHT+IHu0p4/VRpedpzuDJSZFzCflH3Z14UZNiUsPXC11FK8TjFPxJJk+GfxOPVpOtIgPuyDrieoqA==
X-Received: by 2002:a17:907:2d13:b0:add:fb1c:a9c3 with SMTP id
 a640c23a62f3a-adf561306e4mr70639866b.28.1749820916478; 
 Fri, 13 Jun 2025 06:21:56 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec81c1876sm129364466b.56.2025.06.13.06.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:21:56 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:22 +0200
Subject: [PATCH v2 02/22] arm: mach-k3: Kconfig: Add symbols for IO+DDR Low
 Power Mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-2-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MBaZdl2uiEJ+2O15wUJpkFmdRcBSPjBTXe/m05XGW04=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1bo9SVsW7t916aH1UyEZ7jMF5nVbNC5OO33j0+ajP
 1jtuvJ/dpSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEXn5nZJh29vP/SCWhtkVK
 G43Mf7IfF5z24trRgOiGV4+XihvHx2xmZHh77yqzxc6VmoIWbdO+fLfn4Hv+4cDH+e+P/VjxNb8
 mkJMNAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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

