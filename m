Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1A6C83F2D
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8F486993;
	Sun,  3 Sep 2023 22:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="p/b1B3fr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1AE86951; Sun,  3 Sep 2023 22:57:11 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB5780282
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5009d4a4897so1391211e87.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774628; x=1694379428;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TYglP+cNP848xbNNC8t1ng0fe7mgor003HF4vz/ysA=;
 b=p/b1B3frFVto34NYu09aLyblqYvjBrv/G567kgUkcscrn2G81LDFRtuS6rBA/23wcD
 lOLl2k0jYfewkpIBg4N/9MMRqXbUCGpx2CDaYSj3LdeSxAJb7Tg9gXmMB4Vg+AiMt5e2
 VexQrO+oyiSsTZP07J7t1FhM+tTuUxgqKx9pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774628; x=1694379428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TYglP+cNP848xbNNC8t1ng0fe7mgor003HF4vz/ysA=;
 b=W4jsK6jhG4fyQaYuTwwsxKfM6ciFVP5Vuc1n+8XQa8W47w8Zla2J8aB216e1CkL7+f
 KfpL/B50CWPabFqCStWE3AUw7/2Expyg2SklMHYFWL/d2+ruBDNjH8mu4RZ4rCJzkMd/
 UPFma1EtRRbEYwALlCIHkCdQV4cAuGg/FLTPoFckT+Dbf3SKVjiTw4nbH/CNxVJLhZhW
 FAkamqD4emMRRjxVrnTtW7ma+NI2L1ITFgopVQXuXV4d7TBB2HqHwos2mk4F4ArhLxqI
 6+T6kgO0N36gISQfwaIAARjJG2vQAphHwTVC4T+t8gfB0MgkRH/Dyd6uJP8WHsRiyLPi
 dUuA==
X-Gm-Message-State: AOJu0Yxxm71lQqu058Ss6yhBCMskbMfeHmp7NL39Sm4cjuGI29CLfPrU
 dcJKBs01J9jIYiUn98MWNG8d/UmyBc5IxjnbYNR4+A==
X-Google-Smtp-Source: AGHT+IERULHX1blFhlVfjwrLUxJH/Ugf4m6bQMl7Uvcza6EVO74BjT4aB4HHkDRxrbXTKWAMATHnlA==
X-Received: by 2002:a05:6512:110a:b0:4fe:21f2:a04a with SMTP id
 l10-20020a056512110a00b004fe21f2a04amr6193023lfg.8.1693774628229; 
 Sun, 03 Sep 2023 13:57:08 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 v22-20020aa7d9d6000000b0052568bf9411sm4850232eds.68.2023.09.03.13.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:57:07 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH 2/5] ARM: dts: stm32: make the LTDC clock usable by the
 clock driver
Date: Sun,  3 Sep 2023 22:57:00 +0200
Message-Id: <20230903205703.662080-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
References: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
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

As described in [1], the "clocks" property contains "a phandle to the
clock device node, an index selecting between gated clocks (0) and other
clocks (1), and an index specifying the clock to use." The current version
of the clock driver, unlike the kernel, is currently able to properly
handle nodes with "clocks" properties with an index set to 0.

This patch is preparatory for future developments that require the use
of the LTDC clock.

[1] Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/dts/stm32f469-disco-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
index c07e2022e4a8..dcc70369cd0d 100644
--- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
@@ -134,6 +134,10 @@
 	bootph-all;
 };
 
+&ltdc {
+	clocks = <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>;
+};
+
 &pinctrl {
 	bootph-all;
 
-- 
2.34.1

