Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1279C678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 09:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43D1D86C7C;
	Fri, 18 Aug 2023 11:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHvR/vaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2121D86C7D; Fri, 18 Aug 2023 11:34:50 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8700386C5C
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fe4762173bso982209e87.3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692351286; x=1692956086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q23Hy0uzIDH0iZ1eRHCnBhM/4vpPMj1PCM3CpkBFz5Y=;
 b=kHvR/vaBupH5qzW+KyVEuMu0/2MLnzHsM6EYjhEfNitqiHhK89yhK6DnYqOXsXBL75
 u8D946qzQR7YvVrUjgKDwd87THArJ8BrBCP4uLrMWz1+psibWOdRFBd7ZXyZLxx4z3uy
 NnpHwBJph9AJI2cdqBWiSbtY72mKUWyK/kYQQ2T8OaSHaNwfMCdV07L8HYKZTF8cUR7Z
 dhBGQpO3FrHdUfE0U7v83645W6CJYyNy6k+MjmiBwbUs32icIPd0B5qZ2oBF3K0B6JcC
 stxORdATA0GFFSRuNQ6lrREpH/ejY3qrYXSKldJ0TptLZeFRK8TzYSvkXnxhQGraZ2LV
 6AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692351286; x=1692956086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q23Hy0uzIDH0iZ1eRHCnBhM/4vpPMj1PCM3CpkBFz5Y=;
 b=hiuvNCgzRvsHlaQDnmHhSOZqRLI0E3mQV2kvTOkB5h3hE4GpK0kYZFFMhoqH+ZRqz9
 htHwn6P2FvsK4pXdQdGHXAf+e3H2r61CApEtTA80paTxMl731+Qc4vQ5fSeTL9SRHzs9
 71i1v60JLhgFq8r9qCOiH1XdjVQS3OYdycCiXAazamwl4kPCrJbqe4aWZpKtD0E0QTl6
 o7fGvXvb9emesObTjgC79k+3p/tVK3x34/XYHhwVB48+n/rhcH6HFB9XcaUCeIFFHchu
 o/W6kj5AjxRQXLv2dq0ojGhTQIobW8EgNbGZ1jLH0DzPRLy2/A28sVR+fFtXDPXrrRaB
 UXaQ==
X-Gm-Message-State: AOJu0Yw7u0iso0BKAysRQ0XM2j8aL1814U9SjN0wR0uY+g3mAGC8X6Ea
 WHJdQbznpHgf4kBwSL7uWgDD9+qMrlY=
X-Google-Smtp-Source: AGHT+IGohPFTE207cyb2/DM4hr3U7s/kjY8uicemmespANFQ+pCMW4xkYvoBWyMXQ8TxnvXP49V27A==
X-Received: by 2002:a19:711d:0:b0:4ff:a25b:bca2 with SMTP id
 m29-20020a19711d000000b004ffa25bbca2mr1155986lfc.46.1692351286142; 
 Fri, 18 Aug 2023 02:34:46 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194]) by smtp.gmail.com with ESMTPSA id
 z7-20020a19f707000000b004fe3e0956ffsm266540lfe.142.2023.08.18.02.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:34:45 -0700 (PDT)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: u-boot@lists.denx.de
Cc: Maksim Kiselev <bigunclemax@gmail.com>
Subject: [PATCH v1] serial-uclass: reset gd->cur_serial_dev to NULL if serial
 not found
Date: Fri, 18 Aug 2023 12:34:30 +0300
Message-Id: <20230818093430.2755595-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Reset gd->cur_serial_dev pointer to avoid calling non-relocated code
from relocated code if a serial driver is not found and
CONFIG_REQUIRE_SERIAL_CONSOLE is disabled.

Here is detailed explanation of what this patch is trying to fix.

U-boot calls the serial_find_console_or_panic() function twice.
The first console setup occurs before U-boot relocation in
the serial_init(). This stage uses simple FDT parsing and
assigns gd->cur_serial_dev to a "serial" device that lives in
non-relocated code too.

The second console setup after U-boot relocation(from serial_initialize())
may use full live DT (if OF_LIVE enabled) probe sequence with buses,
clocks, resets, etc... And if the console setup fails at this step,
than we should be caught by panic_str("No serial driver found").

But... If we disable CONFIG_REQUIRE_SERIAL_CONSOLE, than we
return from serial_init() with gd->cur_serial_dev pointing
to the "old"(non-relocated) serial device.

And if this area, where "old" serial device is placed, is changed
(e.g. Linux kernel may be relocated at this address), than we will get
an unexpected crash on the next call of printf().

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/serial/serial-uclass.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 067fae2614..e954f0189b 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -151,6 +151,7 @@ static void serial_find_console_or_panic(void)
 #ifdef CONFIG_REQUIRE_SERIAL_CONSOLE
 	panic_str("No serial driver found");
 #endif
+	gd->cur_serial_dev = NULL;
 }
 #endif /* CONFIG_SERIAL_PRESENT */
 
-- 
2.39.2

