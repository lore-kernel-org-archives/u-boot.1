Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E05C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E83877E9;
	Mon,  4 Dec 2023 01:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RQPg4ucv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02CBC877DA; Mon,  4 Dec 2023 01:27:43 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38AD18761C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d0b2752dc6so242155ad.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649658; x=1702254458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fkoMaiOccVCoonfxXwWG2Fvs4mCWJEl0X8EhMYsbtI=;
 b=RQPg4ucvyIAwm5DoBLEMTtttqsxd1havidt1hOMzEjUrLpUC8ijczj6eH36t5REgAs
 xa53vHAZPyDlXBdutdfL+saXHU5UWRe+t0wVVMWMxLuZVtmCdwRB0DcsO7U4amWWawPb
 j71Tl35G3XqUPq4EB/Rfo7KPg7uN24lEo8waw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649658; x=1702254458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fkoMaiOccVCoonfxXwWG2Fvs4mCWJEl0X8EhMYsbtI=;
 b=mnofxpqMTqVchTegRhMemAgfFt8X9HRkb37Y1Ohoupg/A5yko3GwKL84QPrbbnkODl
 Ad0pd/82wdL/TWUyIfIxIZR2O+RwlAe38Car5XmicgMU66ceM5ickA3Eqti8qfHhRPxR
 Dk+z0sya+l03Ss8+wPd13JsKN5jCfGGyu9x43EUQPAzNCB7ntmd0tRCWXQVOfMLbNDQv
 G/l43IyIRzcULI8dyUR1nHRr5zp4eWarbem70PcA+hS84EoAMq+E6kNFbCKqlKX4KAQa
 vQALROk4MU36A9bTKD8VxZs/jUpyeOhwviPOeYHEfcme0yQwki40FGd/MyJ+/bk+/ZDx
 LJQA==
X-Gm-Message-State: AOJu0Yx9Kq2ms2nTw1eQv6Q+L4IXmmg8ojQY97w+dbVT+6hhxy55F4kU
 azQAv6unUUX+AWcTYbn/R2O7CZtz+7wNCdGRvROMkg==
X-Google-Smtp-Source: AGHT+IEnfHKU08ZWheYKBxyfEGBXpgYmacPFeKjMNnZTrR0z2Ily9ECknfGncpoaoF7vT5iawle7Fw==
X-Received: by 2002:a17:902:d482:b0:1d0:7d0b:5571 with SMTP id
 c2-20020a170902d48200b001d07d0b5571mr2393099plg.109.1701649658353; 
 Sun, 03 Dec 2023 16:27:38 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andy Fleming <afleming@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>
Subject: [PATCH 09/18] ppc: Add a reset_cpu() function
Date: Sun,  3 Dec 2023 17:26:25 -0700
Message-ID: <20231203172622.9.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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

The current do_reset() is called from a command context. Add a function
which can be used from anywhere, as is done on ARM.

This is only needed if CONFIG_SYSRESET is disabled.

Since there are lots of reset functions, this one actually just calls
do_reset(). Future refactoring could correct this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/powerpc/lib/traps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/lib/traps.c b/arch/powerpc/lib/traps.c
index c7bce82a44b3..cf8da2e5df0d 100644
--- a/arch/powerpc/lib/traps.c
+++ b/arch/powerpc/lib/traps.c
@@ -4,6 +4,8 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <command.h>
+#include <cpu_func.h>
 #include <init.h>
 #include <asm/global_data.h>
 
@@ -17,3 +19,11 @@ int arch_initr_trap(void)
 
 	return 0;
 }
+
+#ifndef CONFIG_SYSRESET
+void reset_cpu(void)
+{
+	/* TODO: Refactor all the do_reset calls to be reset_cpu() instead */
+	do_reset(NULL, 0, 0, NULL);
+}
+#endif
-- 
2.43.0.rc2.451.g8631bc7472-goog

