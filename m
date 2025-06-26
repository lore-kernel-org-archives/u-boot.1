Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021C1C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E78B80E9A;
	Thu, 26 Jun 2025 14:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ljMhUM7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105AE82E08; Thu, 26 Jun 2025 11:35:35 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AEBA82C4C
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-adb4e36904bso164897866b.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 02:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750930530; x=1751535330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urjqgI6DAH4a/i1++UF4IUaIuSN4XN+Zn75193bu9tM=;
 b=ljMhUM7n9RknrJpfaSX3f5Cwl9BgcXySH3jXGPya1YoKfGlSkY2BWLVlQOOX8dEEMf
 RDXQuO+iaCxFQgryQMQuMxOely9I3nJynM6tYXKMAL93wP8e2Tj8Rpk0nmdHDYwvfr3G
 rtuhrKj1sIA/PB6+8LCF9r+7THHDRV+ivhxO3GjTLZ736QZAvF87gTwoYTpHT8ZhzgvW
 //g1KxTviGpSH+/Je1uMW732LL18P+CArvc9Uot9MOBi58UlCwnY+7meLifCvaTwyAaG
 vOfUP8p2hTjn0iEUk6CfT6xtqW7Mw4y52skCQeOaZ1o//kxUPoklquWoSt8ARPt7GePZ
 wD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750930530; x=1751535330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=urjqgI6DAH4a/i1++UF4IUaIuSN4XN+Zn75193bu9tM=;
 b=mc1ALhGrTSV19c00WiJNP9nacs800GoCf19vuAN3xqJiwNdpq6WPHz0ILtLI1tYgBh
 CNyoQmUlNTREJ1UkI/jDca9nEnYTLSnQhr7L7Xrjrf3T1xWJx5qB4cUcXPoyAeC/4ZX6
 pA+IaRzGuzna8WiPe9nMFO/BlWjcCk8DmduxxFcX2Nl0AgBrJqTIZqwn88wmmgsGAZqJ
 8Ulr/av5YpLepJHJRBAg1EAxuWjRccPKFAKcUYUxW4crriFO4KMPmM+2kGMP0pxx3X75
 8xqXYwmYltmkqL3f5JgNkJdEJ5wsBxiTZWDlDpMVxf5rUkzbTGdVqmoE3buZZVVXhTPo
 24Jg==
X-Gm-Message-State: AOJu0YyYdJosX0f3bFmtEDYDZuoZ2Nn2gsOdrSlcBXfQJb8nkSAgDHPv
 jmO+s2Q6Og1Fk1JbTgihvsOYwtaRUSn4wI6HEqz7NRPn3OjNQjmi1Cpi3vbdpw==
X-Gm-Gg: ASbGncsd6qIzeJueamUnG/IUkY/nr87FbFIYCVy6OAcWhAYERpByJIZN+L3drqvZc01
 ZGjabgKGVNQLz6CUq0hOEm7CNEiXL3Mb2cPiMl3/6AluRoaBI25ty1YfnAAmp7/nOuOzE01f9QM
 sejQjA4mncofT8cjydGbSx0Mwaz3HSdwfXaJbrswzh8J/EOY0bptuJnzHdXXVdBVbpr0FfwCTnL
 57jajE+D+Cv2Q54YRdhy1txWmwVvpT9tngqwCwsIzMtduki8lheL5L5gWe4RXtJWxrqiFrK+rDG
 wPgFrt52AaEbra2+fFMuYFMuPjZaEaYJk9SItkB7djQLUJDR5yp+OoYfMjXiG9tD
X-Google-Smtp-Source: AGHT+IHyTAtFuMcioGhUOFfDm12iDNEA5VPuqyiP5q/rSuVQHhVQ2byp1DfiM0ZhrHxCmNQE+LLTRA==
X-Received: by 2002:a17:907:1c0b:b0:ae0:d1ac:d0 with SMTP id
 a640c23a62f3a-ae0d1ac09cdmr320236166b.50.1750930530465; 
 Thu, 26 Jun 2025 02:35:30 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0d950eae0sm76670766b.149.2025.06.26.02.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 02:35:30 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v3 2/4] Amend drivers/fpga Kconfig for FPGA_SOCFPGA
Date: Thu, 26 Jun 2025 11:35:14 +0200
Message-ID: <20250626093519.115655-3-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626093519.115655-1-vtpieter@gmail.com>
References: <20250626093519.115655-1-vtpieter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Jun 2025 14:57:08 +0200
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

