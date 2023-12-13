Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE03C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B2F8749E;
	Wed, 13 Dec 2023 04:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kbe2g/x8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F947871F0; Wed, 13 Dec 2023 04:17:09 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18255877F3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6d9f069e9b0so3990916a34.3
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437419; x=1703042219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MaikpWbrgk8WB9VDpvePX2GOozcT2Sah3h6LukpFSA=;
 b=Kbe2g/x8MpRFQbQnf18F/hoBMrGxUDEWmj8IbSmCLe/r9W25GS+vrDmBw8Lv7CIqgB
 BCshXxkYM7Xb+OupUdLsxNZo7GDyex/QRJNKb4MJ1gWxjbigbrSbEe6IP5MaUP20CfWE
 0pyflCKCPgxgvCQG1vleMEY3KGMYd6HUOJOhI685udPhF9sOkt+WtEQh2Tyyeb3giMuq
 X+WlSb1L3tubxIuj8IJM2vKKfRENkLZv16HYtOungbTXgrVzDmuozk3QpXP1lpcx74Ki
 tUwrcnewHPIDxsgPZvoJWJ9DB2Z+INmkCiVMildDGeSMO9+IRIluMLC8SA3RQYChJU+m
 X7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437419; x=1703042219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MaikpWbrgk8WB9VDpvePX2GOozcT2Sah3h6LukpFSA=;
 b=qx+Xj9E05XbebhHOWaWiP226gChW4NGF4nttq1Pj6RazEIFFuccm8zFHBlyiZ90FNW
 QMOSRm6OOjenG51w+ZPy5i99YNrdnAyvkZsp3SQ7vvQVqD8utKs6F+z/HwErC0opFqOB
 fOz1+Z3R0Lz+YNPfPBwHWEYeagwxFSiJ1z563uIQeBP31Bgm3Z1aTu4nlXyAyGuvmMcc
 3KupF+Rb7qGdhCTKyhTXlitg/wfJKyQwUZ7MEk+lDZY94JwBLI5WQNza820HG4gDq3Z1
 SFqaZIs3tyxYgDLN/g3haX4If1OC2xJP4SzVTXgXwl9A9SFiFqdVw7xsqOvlcNAfixJ8
 mujg==
X-Gm-Message-State: AOJu0YwGDhVn+ljD/u4XldS2h69rGjsHnIhJhGJtwRNATCbklx63MvgF
 5Mgm5U9k2HCOtaiulg/CwL9p8w==
X-Google-Smtp-Source: AGHT+IH9qOFTr6oe9nW4moP2tU44ht3tPbpuAGv8xJ5l4XRG9Opcvk58GUlAJdIaj3Phc564aCSuIg==
X-Received: by 2002:a9d:7694:0:b0:6d9:eaa0:fa84 with SMTP id
 j20-20020a9d7694000000b006d9eaa0fa84mr7371406otl.10.1702437419749; 
 Tue, 12 Dec 2023 19:16:59 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 m19-20020a0568301e7300b006b9cc67386fsm2589272otr.66.2023.12.12.19.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:59 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 13/13] MAINTAINERS: Add new Samsung subsystems
Date: Tue, 12 Dec 2023 21:16:46 -0600
Message-Id: <20231213031646.28828-14-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213031646.28828-1-semen.protsenko@linaro.org>
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
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

Add next Samsung subsystems with Sam Protsenko as a maintainer:

- Samsung CCF Clock Framework
- Exynos850 SoC Support
- Samsung SoC Drivers

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 MAINTAINERS | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f74c0aacaac..3efb3df99d89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -560,6 +560,31 @@ F:	arch/arm/mach-exynos/
 F:	arch/arm/mach-s5pc1xx/
 F:	arch/arm/cpu/armv7/s5p-common/
 
+ARM SAMSUNG CLOCK
+M:	Sam Protsenko <semen.protsenko@linaro.org>
+S:	Maintained
+F:	drivers/clk/exynos/clk-pll.c
+F:	drivers/clk/exynos/clk-pll.h
+F:	drivers/clk/exynos/clk.c
+F:	drivers/clk/exynos/clk.h
+
+ARM SAMSUNG EXYNOS850 SOC
+M:	Sam Protsenko <semen.protsenko@linaro.org>
+S:	Maintained
+F:	arch/arm/dts/exynos850-pinctrl.dtsi
+F:	arch/arm/dts/exynos850.dtsi
+F:	doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml
+F:	drivers/clk/exynos/clk-exynos850.c
+F:	drivers/pinctrl/exynos/pinctrl-exynos850.c
+F:	include/dt-bindings/clock/exynos850.h
+
+ARM SAMSUNG SOC DRIVERS
+M:	Sam Protsenko <semen.protsenko@linaro.org>
+S:	Maintained
+F:	doc/device-tree-bindings/soc/samsung/*
+F:	drivers/soc/samsung/*
+F:	include/dt-bindings/soc/samsung,*.h
+
 ARM SANCLOUD
 M:	Paul Barker <paul.barker@sancloud.com>
 R:	Marc Murphy <marc.murphy@sancloud.com>
-- 
2.39.2

