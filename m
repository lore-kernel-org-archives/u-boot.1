Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A03C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D200A82E9A;
	Wed, 21 May 2025 11:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nLPfR9RB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F11682E5A; Wed, 21 May 2025 11:47:44 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 149EE82E0A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad53cd163d9so832373966b.0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747820861; x=1748425661;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7NL+y29KnispVsvW77N7C8ACwJH2kyHQysY3j8pf8k=;
 b=nLPfR9RB7pnSLaxBhbdd5Ny252sIZZ+15x8YJz1ZlMdsIlnUQ64URlUO2MuHLlXHC1
 FrPx1SHU3KyI+4jlogr2X6eirRCeKmj8aHmyHNvsdzRo57QF0ZnvYet7vCipZMc0oZup
 zpQV5R96NE7H1mkr6dVr/VvssUOkRaEGRjYoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820861; x=1748425661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7NL+y29KnispVsvW77N7C8ACwJH2kyHQysY3j8pf8k=;
 b=EMy21SsM4/1vmoaVFWX0fCUQBYsf/c0Lo1lebWKZ6VJ0pnlRNtUUhV2yRH5fjAYccr
 60MFvLw2twfq1qzMth2VQnu2PV+2cA64REmMmOjihxM5Ch4D6vJqjm1gddEbQJo4ARez
 ozspI5MpMs8vZAWx6LpFYh4UxNo9j4nPudt4CgqQwOBbSaCXRRXNDv8ULwtZsR94nYy2
 dgdMoh7w2q6lC8Qr4gP6jy2n3JAWrg5OYMrCyuNZJIwIo5Wpb9/786suy6RSldW6g3AN
 z3zmBYM6p4s1LkPo091LePwcAHHdsoW/wn+OjcHovxmi26r7FLMnRmc1tZ+COHv63m2t
 /XnQ==
X-Gm-Message-State: AOJu0YxO1N9cdejsE5M3M3KXJ2jfXFAubUjo+jXcYLvtMWWaRBar9eDT
 gKgtKD+CjRipvXLd7HObG3RlEjYDOkXFOccSyR/qXTJppN5yicyDFqn0lB9woEXSTOR2hGI5NyL
 mOrO3
X-Gm-Gg: ASbGncuoR7V76r2UAiHlPzVWuHjvWpfQPdx7f8Tooe+nNqa/coldLmRg09TzsDH0u+L
 uuxFDbqhMpkDEG3e4Ic654rWxNZ5BSWmhDaFnhNiq2noTDaF83YGXV/33bOycxEfq5X78IfzRiC
 4GJn8fHLyS4eJ47EvOWzTbnUXGczTF3RvsPpgDp8oQosZ0O0ISCxdOZJ5UiEGLOPPHMZNoJuOrP
 zrOsLXFyMKg5N3fHxWVpJeUoWNGFF1xAwq5QGXpFZjnz8xmuHlDeVULSDMBzofxRRUKv68UhwOc
 aLYbm8y/5K0n2PJKg83xa0oisvg7kZJPwYNEaIzqReR1ZRy41Fl426olOPNltFRe5PiRO177UiG
 zowpNB6VutaQa
X-Google-Smtp-Source: AGHT+IHsZr17O2aqfAxFEvyWJHEPriDHrtcmAoWUoi7UHY7j9NT3POnIN8veaY4eyeOGJLfgbP9fjA==
X-Received: by 2002:a17:907:6d11:b0:ad2:5198:d715 with SMTP id
 a640c23a62f3a-ad52d48ffb7mr1995205366b.19.1747820861279; 
 Wed, 21 May 2025 02:47:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:cfc5:5070:d6f4:1d86])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d06b497sm863951166b.42.2025.05.21.02.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:47:40 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, Simon Holesch <simon.holesch@bshg.com>,
 linux-amarula@amarulasolutions.com, Michael Bode <michael.bode@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Wolfgang Birkner <wolfgang.birkner@bshg.com>
Subject: [PATCH v3 4/4] board: bsh: imx6ulz_smm_m2: Add delay between DRAM
 read access
Date: Wed, 21 May 2025 11:47:32 +0200
Message-ID: <20250521094735.1037146-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094735.1037146-1-dario.binacchi@amarulasolutions.com>
References: <20250521094735.1037146-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Bode <michael.bode@bshg.com>

A small delay between DRAM read access with wrong parameters and
reconfiguration is necessary.
Without a delay between DRAM read access and a following reconfiguration
this reconfiguration fails for certain DRAM chips (Nanya).

Signed-off-by: Michael Bode <michael.bode@bshg.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Drop changes on arch/arm/include/asm/arch-mx6/mx6-ddr.h and
  arch/arm/mach-imx/mx6/ddr.c files from patch
  [1/1] "board: bsh: imx6ulz_smm_m2: Match SPL DDR settings to DCD
  table"

Changes in v2:
- Add 'static struct' globally in the module where the definitions
  can mabe static.
- Use standard C comment style
- Remove unnecessary variable initializations

 board/bsh/imx6ulz_smm_m2/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index e8255b6d2a62..c330e4d6d39d 100644
--- a/board/bsh/imx6ulz_smm_m2/spl.c
+++ b/board/bsh/imx6ulz_smm_m2/spl.c
@@ -13,6 +13,7 @@
 #include <asm/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/boot_mode.h>
+#include <linux/delay.h>
 #include <linux/libfdt.h>
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
@@ -65,10 +66,12 @@ static void spl_dram_init(void)
 		/* Already configured, nothing to do */
 		break;
 	case SZ_256M:
+		udelay(1);
 		ddr_cfg_write(&bsh_dram_timing_256mb);
 		break;
 	case SZ_128M:
 	default:
+		udelay(1);
 		ddr_cfg_write(&bsh_dram_timing_128mb);
 		break;
 	}
-- 
2.43.0

base-commit: a3e09b24ffd4429909604f1b28455b44306edbaa
branch: bsh-202505-RAM
