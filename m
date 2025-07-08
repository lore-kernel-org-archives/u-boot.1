Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799F9C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 15:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 777CE833CC;
	Tue,  8 Jul 2025 17:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D7fP6KaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA0883371; Tue,  8 Jul 2025 17:25:08 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B05E88338D
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 17:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae3cd8fdd77so948187266b.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751988306; x=1752593106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urjqgI6DAH4a/i1++UF4IUaIuSN4XN+Zn75193bu9tM=;
 b=D7fP6KaKfBNs7hjEJeCxlQISpBq+KMOm/cb03bYqNlp7oQa1Qdi1YpDXeyN3hnNzqo
 pvKLp04Ggnp1hQoM5qJpYIoMhcFpszX8I7v5EehifyVHUBkqVsvXDACvsLMl5ygy752u
 8IxPkiZR1UHM9CqOUko1+Gd0QMkcHfuYp/NqKuHpjF6CWm5bBWTw7aXs2eBlQM08tiAV
 5I9vmBDiosFG++QW7iUD/24XSwbEgNNana4B++OXfTl/AEvazRYqr9TQdROZL7rXBIg7
 tccdQimv56ks9kK/c8p4c/oCBEYVLHaC4FBxzkVLJsiJxVIiWPlsnmzTOaMTeQ6cqiU8
 sr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751988306; x=1752593106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=urjqgI6DAH4a/i1++UF4IUaIuSN4XN+Zn75193bu9tM=;
 b=DK23+YKhdBwxN6dqydmd+8WJeYHT7pmb1SOJU2Q+oXX0PzOLPZgaVIyDMghKZWNxcU
 NZJB3qXslZRA5oeYRy2k9d8sDiabgUfqH5XW8yCN/NpbyXsVdkrqrATeIGoyEYno0ueV
 lJF5DMqllFfDXtbY15sQXmn8G1iSWht6p3SbSYCwMBl3Ys4hm4I3QaAICGhoT3KQucmO
 C2Q2gStcYLJfJU3OBsO69dAv04tT6DH7mLv/9HI2xM8qGc7Iv33k1MD3duGpU11HeH7Y
 pNQYfwNDUiZ6hhdpROoA+1Ucoh9w1qtrdf6Z4DvHwi1mdQeiHyJEszi6g2xjL1JJxQ6w
 PWQg==
X-Gm-Message-State: AOJu0YzDtQfptnEsH7al5Zf60ZDZssOS8oUEnI8YhTsOfi/DHgIwU2a1
 WAeFgSj4kSigN59XVhlzrq83c+ITVAt0JkraBssowq+Rb3P4YJ4QiCs5HTNhLBCJ
X-Gm-Gg: ASbGncvO1F1GVxACLLJUjlNmZdzkp5Zdl97PUXEJ3PNS3KGJIvK43zMAZmJPBGTSQ4h
 GA8Evo1g9LOHZfICFxpHBl4EStwChQ2BnWrrNiAePU/mOMEbX+XIoeBACzA3XRZRDpKiGWnFnGm
 aHSEH3MoRHCHUS9BOYUBHedoumQsWlnYL5iNaEoANMZezYQc35hcJw2nt1Tk7U8a8GMrr+1yPzJ
 QaMl09yK9nuv6BoyIqyAaxS0pSvpdCLamuwHRiTTA4er9QmjNf9JT5Sb7L5ba4qYsTiGPucy0IJ
 9iJrUcDpWlfem2y71ESwKAA0gDzdKHNIaZhWKsu1q4mSAtIhsLh8ouPR0EFMwBaI
X-Google-Smtp-Source: AGHT+IEoB5rB9gHwUt063MEhqd/6Yu9M39NL8Y3+HKrDMGfI/OwFFOyEtwnxVj8iupuEUrdS5ECksQ==
X-Received: by 2002:a17:907:6d04:b0:ae0:34d4:28a5 with SMTP id
 a640c23a62f3a-ae3fe3dafd3mr1622589266b.0.1751988305834; 
 Tue, 08 Jul 2025 08:25:05 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66d931csm921950666b.10.2025.07.08.08.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 08:25:05 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v5 2/6] drivers: fpga: add Kconfig dependency
Date: Tue,  8 Jul 2025 17:24:47 +0200
Message-ID: <20250708152455.1214487-3-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250708152455.1214487-1-vtpieter@gmail.com>
References: <20250708152455.1214487-1-vtpieter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Jul 2025 17:29:30 +0200
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

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

FPGA_SOCFPGA requires ARCH_SOCFPGA cause socfpga.c contains
arch/arm/mach-socfpga/* include macros.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/fpga/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 62cb77b098c..9456ca3149a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -15,6 +15,7 @@ config FPGA_ALTERA
 
 config FPGA_SOCFPGA
 	bool "Enable Gen5 and Arria10 common FPGA drivers"
+	depends on ARCH_SOCFPGA
 	select FPGA_ALTERA
 	help
 	  Say Y here to enable the Gen5 and Arria10 common FPGA driver
-- 
2.48.1

