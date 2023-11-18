Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FB0C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C4386D12;
	Sat, 18 Nov 2023 22:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="itk97eeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD6D8753B; Sat, 18 Nov 2023 22:06:34 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170CD87504
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a6907e9aa8so116324239f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341573; x=1700946373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WE/98gwI4OaLTOodzrTHSjqOhmfNtsEPAtYO5kXdNfI=;
 b=itk97eehDmpWwiX694/dk2RIB02KJ2Nq+hRp3juFYjaWhBwqDs1Tv6RbH+gjuFkYSD
 QMLeiJRvYvUxplvW0U8ZVqNyXRW5NVZYq4F0aicxxPuY8g1qmDYRwKe6TtMJ8XTnU3JJ
 Fk87bze0hJgV3fB9IDRoGLR0Zwa2QFQg3EWeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341573; x=1700946373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WE/98gwI4OaLTOodzrTHSjqOhmfNtsEPAtYO5kXdNfI=;
 b=UJCVxbSZtk04NdBoLk7y+cffGkV7vuA52TYTCKlFmfea6LGoyjNkb/UepneWHAB9M7
 ru/CPgC6sso17eKz9X62bBNj3UZARiX4SgwTCzTfk3T1JgLjU2Cf1QLGHpDuvioPK7O3
 SjZm1e/SDoycKPscxdhanjWqR+JCpnw5Vx+8lTCcwUh/xm8ZICnpdFO46udmVIDgQnsV
 J6y8/6ayf8XJXpFCWW1WHmo0UBoBUY7+brCzrKaqlkCUEl+aFGUZ1nwDy7aLFMS5y0fA
 ly4iyfY5b/IhDjyI2dUAisepN8HMeT9J7PDcihR2aEmFLsS5BLuh3H92q0MU5sylTdy9
 AGDw==
X-Gm-Message-State: AOJu0YyQorb+/GgfzZGTCvwSCNCBZ+PjDLpmFV1uiJy46X71Kn3vBSy/
 3xGA1du4u8GUt5GCuXwELo7TeaMkXSQf3MEFbw9Ang==
X-Google-Smtp-Source: AGHT+IFBaDnr0pi7p/YmcR/tWiagjs8e82g3zz003b2CHLtFBbaS7JmxHGe1hDR0Z6sKHvfzDI1kxQ==
X-Received: by 2002:a05:6602:400f:b0:787:1555:efca with SMTP id
 bk15-20020a056602400f00b007871555efcamr4874078iob.5.1700341573593; 
 Sat, 18 Nov 2023 13:06:13 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 20/32] bootm: Drop #ifdef in bootm_find_images()
Date: Sat, 18 Nov 2023 14:05:08 -0700
Message-ID: <20231118210547.577026-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

The OF_LIBFDT #ifdef makes it harder to use a local variable for that
code block. Convert it to if() instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index d5893e82d128..d9c62d730f7f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -524,29 +524,29 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		return 1;
 	}
 
-#if CONFIG_IS_ENABLED(OF_LIBFDT)
-	/* find flattened device tree */
-	ret = boot_get_fdt(flag, argc, argv, IH_ARCH_DEFAULT, &images,
-			   &images.ft_addr, &images.ft_len);
-	if (ret) {
-		puts("Could not find a valid device tree\n");
-		return 1;
-	}
+	if (CONFIG_IS_ENABLED(OF_LIBFDT)) {
+		/* find flattened device tree */
+		ret = boot_get_fdt(flag, argc, argv, IH_ARCH_DEFAULT, &images,
+				   &images.ft_addr, &images.ft_len);
+		if (ret) {
+			puts("Could not find a valid device tree\n");
+			return 1;
+		}
 
-	/* check if FDT overlaps OS image */
-	if (images.ft_addr &&
-	    (((ulong)images.ft_addr >= start &&
-	      (ulong)images.ft_addr < start + size) ||
-	     ((ulong)images.ft_addr + images.ft_len >= start &&
-	      (ulong)images.ft_addr + images.ft_len < start + size))) {
-		printf("ERROR: FDT image overlaps OS image (OS=0x%lx..0x%lx)\n",
-		       start, start + size);
-		return 1;
-	}
+		/* check if FDT overlaps OS image */
+		if (images.ft_addr &&
+		    (((ulong)images.ft_addr >= start &&
+		      (ulong)images.ft_addr < start + size) ||
+		     ((ulong)images.ft_addr + images.ft_len >= start &&
+		      (ulong)images.ft_addr + images.ft_len < start + size))) {
+			printf("ERROR: FDT image overlaps OS image (OS=0x%lx..0x%lx)\n",
+			       start, start + size);
+			return 1;
+		}
 
-	if (IS_ENABLED(CONFIG_CMD_FDT))
-		set_working_fdt_addr(map_to_sysmem(images.ft_addr));
-#endif
+		if (IS_ENABLED(CONFIG_CMD_FDT))
+			set_working_fdt_addr(map_to_sysmem(images.ft_addr));
+	}
 
 #if CONFIG_IS_ENABLED(FIT)
 	if (IS_ENABLED(CONFIG_FPGA)) {
-- 
2.43.0.rc0.421.g78406f8d94-goog

