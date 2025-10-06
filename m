Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0B2CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A26183DA7;
	Mon,  6 Oct 2025 17:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C4XxPBMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11AD683DCA; Mon,  6 Oct 2025 17:39:08 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 920FF83C6E
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-911520e43edso203001139f.0
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759765142; x=1760369942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fn9QpfCwkHtLPQfCd031lUCH+xQPJ/T+GtVa2kwaW4E=;
 b=C4XxPBMOvBW2n4iFQ9SrtCwAFJQVmN4YS7fNIN3rz118HDGl2mypffeyri+ysSebtg
 MLoQdYYQIhqRgCWI4AU2fDXtntUq25WW6i2Yvm0iEVVTYi8QXFsEkQwTRviB6Ulh8tfT
 ZmUcjHTcH99MHh/L/8A7gyuO2VE1E88ZeOs4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759765142; x=1760369942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fn9QpfCwkHtLPQfCd031lUCH+xQPJ/T+GtVa2kwaW4E=;
 b=dd0HdomD2/VKr7zRxXf5yUqtWQj2k1Rq29qIHfxCPJJcudeAAQzxAYwZsMGpPIe0b4
 yBVK5C9v7bLajQGz8T+dHoLZ0xloAVK7OXVdm/ms9NfoOjBdIDoAEhBo8mjA2Ne+g724
 LwmAIF4f7i3YbVADGjfdJjbiEERCidfMtiJ6VJGou3OrzMf6muiAox+YLn/CpwdqoLKI
 mf93B6TC1O0dRO/7vbUwvmsFmPv3a+FYx51Nu+zrCx4wOBEJWj/Fd7tig5rm3UPZrt+U
 I4FdfAmHNIXruiAoijfpwNPkOFAOceIRpqQlNo/puGpvjK9HrL7oG2sqHBKCtckvMtvX
 +BbQ==
X-Gm-Message-State: AOJu0Yxx0LF+tb0zXfAOJgdNqfnUX7UKMLmMyGXXVdxLHKcRlmwF0Rae
 I6WbS3mmwK2Kk4hGIBWiDDVcjNb+O+Cv5PpA9MejiWhmo41NtFTbzYFxxHUvHzU3K9KeOvkAroy
 AoXW86yA=
X-Gm-Gg: ASbGncuUGgM/BlsA/HicP9cikIZerNOfVsRDDX5N1jMWO4//ufxjgiFPdxgwZtU2drN
 gTQmDxVB3M+Am8+RcCfRUb45SDGBrpN60Ux6mUsCF9D59Paw6Qcyik41b3oZanYP7x3q0uuH4Cm
 XdBPFqdjQO5diWRx+6jx5icv/Y61GpPqE1iGk3mcFFXLtuOKrEA2Vpn4rEQgqnxt4NKLQeM0WD7
 TBieCeum/cVdNCKb9fml0Xh2Y7JY7DxUsGWm8zSSXSCXqe4TJCIQ3HdLiqvjCJUniVtyUuVP9on
 o6zF7xbaa2bbYmB5p2FNv/FJ1ewWu6Cacrm6n00ddIa+2hap7I8o5uViqSbKYAwHzR9mTO/gE1d
 csDugWqPWkw/k9U5P/Mqhv+voZw1mqLagyTo/BrmmFo6+GpHQjVdo6FCvoBKT2nTskUw/aF4xuo
 TzIZJO3UC4Zffj
X-Google-Smtp-Source: AGHT+IGDrBnZI3x839WIml0SXfWHklPHsezSH7GFBDciZ6GcAIbRv/zsqFT/Y3x60NAORuwiPsrlLg==
X-Received: by 2002:a05:6602:340b:b0:92f:4e37:2f29 with SMTP id
 ca18e2360f4ac-93b96a97a10mr1776931139f.15.1759765142156; 
 Mon, 06 Oct 2025 08:39:02 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7e3a6ab7sm477928039f.12.2025.10.06.08.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:39:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Manorit Chawdhry <m-chawdhry@ti.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2] clk: ti: Tighten some TI clock driver dependencies
Date: Mon,  6 Oct 2025 09:38:59 -0600
Message-ID: <20251006153859.280336-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Attempting to build with "allyesconfig" means that we try and build all
available options for the sandbox platforms. Doing so exposes that the
drivers under drivers/clk/ti/ can only be compiled or linked on
ARCH_OMAP2PLUS platforms as some drivers require platform specific
headers while other drivers depend on these first drivers to link.
Express those requirements in Kconfig as well.

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Make it clearer how I hit this problem, and that it's ARCH_OMAP2PLUS
  specific drivers here.
- Add Manorit's tag.

Cc: Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Andrew Davis <afd@ti.com>
Cc: Udit Kumar <u-kumar1@ti.com>
---
 drivers/clk/ti/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index fbcdefd889ae..ae39e94cc867 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -18,19 +18,19 @@ config CLK_TI_CTRL
 
 config CLK_TI_DIVIDER
 	bool "TI divider clock driver"
-	depends on CLK && OF_CONTROL && CLK_CCF
+	depends on CLK && OF_CONTROL && CLK_CCF && ARCH_OMAP2PLUS
 	help
 	  This enables the divider clock driver support on TI's SoCs.
 
 config CLK_TI_GATE
 	bool "TI gate clock driver"
-	depends on CLK && OF_CONTROL
+	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
 	help
 	  This enables the gate clock driver support on TI's SoCs.
 
 config CLK_TI_MUX
 	bool "TI mux clock driver"
-	depends on CLK && OF_CONTROL && CLK_CCF
+	depends on CLK && OF_CONTROL && CLK_CCF && ARCH_OMAP2PLUS
 	help
 	  This enables the mux clock driver support on TI's SoCs.
 
-- 
2.43.0

