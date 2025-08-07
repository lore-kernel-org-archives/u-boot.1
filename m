Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4D9C87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 05:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 073158433B;
	Thu,  7 Aug 2025 07:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q4TGwtjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB27B8433B; Thu,  7 Aug 2025 07:32:45 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F3C83BC9
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 07:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-31ec95ad016so583623a91.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 22:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754544762; x=1755149562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDrSWzzNW9qcUnSpsmpSOBUgluhQyOePdSNbQ4n9AVU=;
 b=Q4TGwtjnz4AYKZfo5K2rAppJn44uxpG7X11NT+okCP9ulNTGPqG6hXV1LkDiii+/BC
 dwUiXq3oEzl7oa7AGhm6yRuVX9ArN2EIQXcXxvkzTrWUIqxN0FgKc+CkCgBT7yJvYcrN
 v/hNq+ZiasyMZs8S4fQGgqk2Bac8ztTTOZnIhPHEGyp1Nk7wvZpUUmByIdpqzcE8fK0s
 qt/r8Cb0Ycqn2Aftxcox6AUNuUAVuDAxP5kveUFd21Nl8ARXeNW0Jg/hlPERt8pAtgbW
 fXnvN9FcUT8jw4uzfBKx+OuxUilaxYFt8o3NjNWaWeF8a/uSYeTYwlgUGz524zmNQ4QK
 BDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754544762; x=1755149562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDrSWzzNW9qcUnSpsmpSOBUgluhQyOePdSNbQ4n9AVU=;
 b=gKlcSmzAlSGAe2yLaDvJgXkiNEuSE0oakR5A2JDyh2GHSL0nLTahsHg1BkVtvXBk7d
 RiaS1ouU1ZiBbgcljdRLoxkuVlREnm4DW8+OUoqG+qVyXZeL7QTOR/D0+jB9PybA6iFE
 4VcGfTYYj+0ddCvYuV46iUeJO2+/ymPjHld0bHQAMVldQ3BEGkLkP3sZKOnjAhPX9bPv
 5GlSvVf3s9bcy/87uLUuz8SQY11LYnlPa6sgHl/IXnxI1tz2Y6zT1b4sPcqzouL8spUQ
 lLhkIjwZ6cFRoW/jlwFqMO7iFyTlFqolCZnhFJUM+w9p9DZ3YNUGcAswYfKArUtMVVED
 G3Cg==
X-Gm-Message-State: AOJu0YwHDosqXkJ0dQ+vSFxxq2iTH3uaCkp/q0daJlslNC8WkYOXwZIQ
 9H1pCfoksVDXzdzwynVEKkiZnJGKa3LGyNEBDV9RzOb6M0iRmRhQdin9
X-Gm-Gg: ASbGncuJKR67qEX+tkHu+Er0/CONDjg99uzUeseiiIBc6VI7fi+THG9uypPHoXCDG0a
 VeL2IAiJSHmaNUStLq5vuDsHkYXL0P3eEssw6AFUWmKSwxx8ebn9kHvcGd7lgBbAMnfwB/zMZcJ
 LSB28n5dp7+Uw7sP+cdEqxMgEkeN/Lqi/u80ckXh1WAFeRDe7vPGA9hHSgS74usCuTBjEjGyejQ
 BevfezrR2OAttiAuE1XdlT0nBLRnxicUwKs+jyIqoPsqOm2R86B1qypwEloeM8y4jlmUWMIpaT3
 lrAk0Y7DfsZo326QWUhZ7ROsIxu8sDh8K2XfbBW524m6YBN2KyWq9mQVkPJhgsnSARbLALN8jQW
 GcgbDAdBBjtLNx3Us0d7YwoifZmMvslDzNA==
X-Google-Smtp-Source: AGHT+IE7G7p1+sJxjOuyGrY15UrLreaCtYBhK//hypAjRFM6O9d4WnHYyO/JmkKZoT1K7sPM/9yIvw==
X-Received: by 2002:a17:90b:5706:b0:31f:6d95:8f76 with SMTP id
 98e67ed59e1d1-32166cca3e0mr7040988a91.29.1754544761780; 
 Wed, 06 Aug 2025 22:32:41 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3216126c98fsm4384084a91.21.2025.08.06.22.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 22:32:41 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v2 1/7] arm: dts: npcm8xx: add pinmux for VCD input
Date: Thu,  7 Aug 2025 13:32:18 +0800
Message-Id: <20250807053224.2169557-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
References: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
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

From: Stanley Chu <yschu@nuvoton.com>

Add pinmux to select the HSYNC signal as the VCD input.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
index bc047d4b443..6f933355d9e 100644
--- a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
+++ b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
@@ -1056,5 +1056,9 @@
 			groups = "jtag2";
 			function = "jtag2";
 		};
+		vcdhs_pins: vcdhs-pins {
+			groups = "vcdhs";
+			function = "vcdhs";
+		};
 	};
 };
-- 
2.34.1

