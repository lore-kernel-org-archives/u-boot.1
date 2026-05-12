Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411DDCD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 07:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4530801A9;
	Tue, 12 May 2026 09:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LaZ2Ceok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3242680F0E; Tue, 12 May 2026 09:12:08 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1946B800AE
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 09:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so46254515e9.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1778569925; x=1779174725;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WzmnV3kggwSU5sM2eqbuwF2Q9DjxSpkrCPTMYcDnehY=;
 b=LaZ2Ceok3uuNkF3L9OeeLKUrkKAwCimuLoop3nD7lflSguiuk1mM1jBTDBETG09P6d
 C4dAukuGugjgq8vfcW7Bn1h5PPaH2t2ys58ej+g8iGotm+ZoL0YDad4E/P0Anbh8d7qt
 fS09XIBYjhlc3TzppqFvupRoKVhkVh/EHK85E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778569925; x=1779174725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WzmnV3kggwSU5sM2eqbuwF2Q9DjxSpkrCPTMYcDnehY=;
 b=bt9/XXeqMUA92GuQTXcBSLdcxpmXE5Y8Zg4wjPEcIOGJkZCORVjoi07WCVOaxJRHaO
 jnBiYytQq0aVIa1CesrkYTsqD9JYLc/aiAlK6tmA7g768de50fjsauuQwrUwu6YtXmZo
 joXV4WHkXqKOc82WrYQUlb4J5QXc4MgXuJ2ucph72kU7hiftvBRsy3CKpQmcwma/dMVe
 5PgjVaP91QkRuLNaGmp8Z+Bv8GBj+RA11fc8OM9TkCgKtk2hnHotraFkXl5PEGUGggkz
 DJ8oPJqTyKUgkhHp6UqRONO7BEOtVZlHBa+ACeeOYZ6UN5tXvnoVw/NySZybZB1BmbOE
 sOdw==
X-Gm-Message-State: AOJu0Yyf4Ce9b+DJXXqBCG9PqgAnt8TA6foTpj8rsnnlJafra5QpA0AA
 mW5SSIkgvmd1KuUpqer4RG4UkKjRkYNniJpCDC91GWhRLVyGDREw8F0QrNcvX95m9rwd1kfHE/N
 HRWQp
X-Gm-Gg: Acq92OFy5ywyGTf/CSGEI8hADCrF+ItJRrI2WXyvNOQxiyLMjzfZ8HdWQbBUnjYwuqh
 y6D1COPbRJwQSzYjHZAxC/w80/L/nUJGucoGCkFOCsVlfpnByVHaFetan1XweZSArlN/NJ0Sxa3
 B7UgsbbG0L8KpzMYfY8gu8rKlvDWe9KtgjNGLyTuC7DbFjgSdA76m74IRQsqddwAr4/Esuzt9FC
 9ASPnZsWosRRfUs+DhciZYDbEobC07qiJhV+Y0umfFD3E1yV0/xX2tFWMXDe7KL/yyL3lnx/Kic
 Zzm2FBlFANceGacVyWOpGJI64Nrk8AkPK8Lmn9WuupNnM1F5D4cAHxNeEaseLJGZ1G/G4IDAV0Z
 uTuGwVTs3lz/o1sdmEBxsvi0Uq/j6Bzdv3kHfxGliuUmvSgl/z173ejEPPnY4Cgf3dOfWBIir/W
 9CS5Eb1zHr7Wvs4BLdA6D1x19PJunDI6v6/dtQuFS79mt4miCh6wo/AhHfEjnvF5tchDBIj1GHq
 6AeB52eXGIgOjpQIdyQ786Vb9E6405L
X-Received: by 2002:a05:600c:528e:b0:48e:7f1c:8778 with SMTP id
 5b1f17b1804b1-48e8fe721bcmr27120735e9.17.1778569925057; 
 Tue, 12 May 2026 00:12:05 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.. ([2.196.40.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e908d890fsm24601385e9.15.2026.05.12.00.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 00:12:04 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: add U-Boot specific dtsi for stm32mp157f-dk2
Date: Tue, 12 May 2026 09:11:24 +0200
Message-ID: <20260512071157.564081-1-dario.binacchi@amarulasolutions.com>
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

The STM32MP157F-DK2 board is a direct derivative of the STM32MP157C-DK2.
As explained by ST [1], the "STM32MP157F-DK2 is assembled with latest
STM32MP15 RevZ cut which is the only one available for new product now.
The major differences in this 'F' variant SoC are the increased max
frequency of the Cortex-A7 cores and the correction of some HW bugs
(Device Rev.Z, see errata ES0438)".

Introducing arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi by including
stm32mp157c-dk2-u-boot.dtsi allows inheriting U-Boot specific properties
(e.g., bootph, fwumdata), avoiding code duplication and ensuring
feature parity.

[1] https://community.st.com/t5/stm32-mpus-products-and-hardware/i-m-wondering-what-s-the-difference-point-between-stm32mp157c/td-p/213460

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi

diff --git a/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
new file mode 100644
index 000000000000..456ba70ba9ca
--- /dev/null
+++ b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include "stm32mp157c-dk2-u-boot.dtsi"
-- 
2.43.0

base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
branch: stm32mp157f-dk2-u-boot
