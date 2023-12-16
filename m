Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8EDC4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6481287B98;
	Sat, 16 Dec 2023 04:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fr+OIq0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2631087B75; Sat, 16 Dec 2023 04:15:15 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D144E87B6C
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35f72db10f7so5465385ab.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696510; x=1703301310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqlUquu0I55v1hvQor3uryWpofiAdEq0Tbakf+dGhwE=;
 b=fr+OIq0OGsCHJ5eNc+HylqUQGniJcsH73Qgh7E049EEyJWmiM4zH5YJpcFi+m2MpyI
 kPXn6Q4AAAfNugovsSuuQhahUKs41LB/xhOUe2/YNxSFCBNqvjrsWxNL1PVLLarcIKME
 1I++WQTnoE5YSuxSU63pnTupPTTRP5lH12/fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696510; x=1703301310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hqlUquu0I55v1hvQor3uryWpofiAdEq0Tbakf+dGhwE=;
 b=BjLPNhHqE9GJTxIVCSMkBU6Ehox9rFuaLTAkl3GwYgU9d3g26DIeqY4GlZREUe43yN
 Qnbm5F5d4rCh6yYHvm26duC3rPrUD0SqCfnYPI6m9fhEuM66Md2xBHTYGgx4VMQriuzn
 7RENsi+gxe4w9Ao6zX7cy8n+Z8a6nBNZRZU9fJkRBc1xJJYPQxOrU4t5aN9gYk+Hl7Gp
 bNHknx9gUUMPqTebzy/4cWg3WzkymLxWTHULPndriKM/epkRwuEcyRrl6AVRPDOYa88e
 FyYbLFDTmXGYmAtiPYt+3lItP7gkju2t04KU4IHCHqkn9nm1sbqtsS744uje7EUVTv5c
 5IVQ==
X-Gm-Message-State: AOJu0YxkNj9dH9U5Nn+U9fgLH8XxiHABG0kyH+Bkxar1n5/KZLkOwxT6
 Y+IXZ5YKmPBaQnpAbKG3rw+zjGe1iGgjP+yB1YVQhQ==
X-Google-Smtp-Source: AGHT+IE7U6MmPjyoUjAru7V2NPdz3xgM+/1dV/yuDWiGkl/OiC/sg2BUe8dB1SnIgyIlYcsgedzTKg==
X-Received: by 2002:a92:ca0a:0:b0:35f:684d:7289 with SMTP id
 j10-20020a92ca0a000000b0035f684d7289mr10784826ils.42.1702696510235; 
 Fri, 15 Dec 2023 19:15:10 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andy Fleming <afleming@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>
Subject: [PATCH v3 03/22] ppc: Add a reset_cpu() function
Date: Fri, 15 Dec 2023 20:14:07 -0700
Message-ID: <20231215201413.v3.3.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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

(no changes since v1)

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
2.43.0.472.g3155946c3a-goog

