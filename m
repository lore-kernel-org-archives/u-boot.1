Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470D9CD13CF
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD3388C87;
	Tue,  3 Sep 2024 10:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A8uBSMEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89E5588CF2; Tue,  3 Sep 2024 10:38:55 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF0288C30
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42c7856ed66so23989195e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352733; x=1725957533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyG3QXG+UUiIibtKovBRnK2Z7clawHN81b2WLACzqvU=;
 b=A8uBSMEVeT0g8jB0NiaItGBGyvg0YdpEuW+lHvtc0Jm3XMuEwovdDGns0rWCQI+MdU
 V5zYP3AEoAVusvwNxtITgpGFCravzFflqzo/VIcK36kVNLeYtE++gqEIlLozot364bEh
 Qu9EXiIMGlynsUdhYH8O2Qx3xZYxOqUNWqlK4CPwfu1n5saVa0R1Y4LDsM0/aUM3UPGn
 UMQZwmMOull6sGF0kVXEihBdVT6+0e7Kxbe5ItWCWAycru0uUYzd5t1tgYJsojgq/bJN
 yf/D5sfYVEoDl9jkKUj4WSXVt90SVGedJX5crB4sQnj/nV6wzNFLQTeGy2qS+GvYelOw
 RlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352733; x=1725957533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyG3QXG+UUiIibtKovBRnK2Z7clawHN81b2WLACzqvU=;
 b=hmPvAJiC5vhbf7QTSL1H2fD3S+B7F4aKlzuexU8wiJ13ozXKm9SPOzWs1vOnbMSeSK
 mFR8fRXgVfHAAuZzCXFqUydSLzkm/FMB3YN6dnDt6ofeh55JjpZu0OtbvirWIs/duPeH
 dwDlkJ7Fofjj+JyQfKfzV/6HHQyIizYAVFY4erAgjNXdbqHsTiq095NSWA2laMR6EL6j
 nnA4s7qnnAaseiDJ2+83FYh9vsmI+vtHfOIC9LeO3mX0wCEYyIdd7Xytl7Db/FMTG4Uw
 dG1FG2UyYqYiHsfXbyxxNzBU6YKoGlo+oSnw01IMoSIJ4fShlknjgDY5Oc76rbXQr7wR
 r8Ig==
X-Gm-Message-State: AOJu0YwcKR4zeveUMQJfRpIhwkDJTWGtvAFMWdr/OlvuEj7vWTqPOBHa
 ejuJ30/w6YsEpon7X63J/YSjQ3TloGo122pnpY2YxD3McvRpICu9Z1saJT62xGv+qRy4bcsRAQj
 rYw5S7w==
X-Google-Smtp-Source: AGHT+IF33/nGoEy81AnCluOH09houJoN9FgYSswxftJ0U2sPHalWYxZzGUAnROFQcErIfdDkEx7tuw==
X-Received: by 2002:a05:600c:3ba7:b0:425:7c5f:1bac with SMTP id
 5b1f17b1804b1-42bb0306f94mr138048555e9.21.1725352732842; 
 Tue, 03 Sep 2024 01:38:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 05/16] arm: omap2: add missing #include <netdev.h>
Date: Tue,  3 Sep 2024 10:38:02 +0200
Message-Id: <5c4e108966560a56f1f6e9257d9c4f78059b8a2b.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

emac.c implements cpu_eth_init() so it needs to pull the corresponding
header file.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/mach-omap2/omap3/emac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap3/emac.c b/arch/arm/mach-omap2/omap3/emac.c
index 7348e92cabd..1e30a06361d 100644
--- a/arch/arm/mach-omap2/omap3/emac.c
+++ b/arch/arm/mach-omap2/omap3/emac.c
@@ -9,6 +9,7 @@
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/am35x_def.h>
+#include <netdev.h>
 
 /*
  * Initializes on-chip ethernet controllers.
-- 
2.40.1

