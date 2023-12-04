Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56CDC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEFDA875D6;
	Mon,  4 Dec 2023 01:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EEOiH2/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2255E877C4; Mon,  4 Dec 2023 01:27:38 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECC8D875BD
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cfb30ce241so22639175ad.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649654; x=1702254454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxZ+UmQZf+v555YKTJ/jtvuesOK+AF+uRz35/qP1KQA=;
 b=EEOiH2/WFbwyd/CU77ulIO1yJr3ghlbEkTpx/Gn1y0bD0Dj/vlrD6/uHXx3fGFxK4B
 BsOv2A0689BA25URSktzqk1fVOK/o5MEjJsJ++QxKlJQU7shkf2bIcbXlKzbHbi7j+JJ
 GgalVFlpznYlDBUMQEE8tJeTI01l0/Oh1Zgnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649654; x=1702254454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxZ+UmQZf+v555YKTJ/jtvuesOK+AF+uRz35/qP1KQA=;
 b=cZ2W0c/jC5D29+UGrg3SvHOE72rUTPrjxk9akjeiR6F6KgVlSWuiKpCFK7/w75aog2
 rgDGwY9R2RxM/yVOCpubWo/rgbQyFoGx5sMn9M6Rk2jJlZuCnTs8Mp5Bs4/ujZQvTFtM
 EABwK5J3S9It+JyRo8VGzlAGFMtVdL+Q4dpn1dhVWmEOb/H5m+BX9Xkl0UnJbAP957yT
 MsIWGKGWb2a3XVV6upc4dWZTxIVZ557v5ukBb7mxc2EVi99BZK+Xg/fzhy3uxM7xidit
 1flSgaL5WIeFA9rhKbUfdeh9lQE9ekHHtOCf27vIA2EyW/JLF7/HS/esJzulnzEwvlXA
 9LMA==
X-Gm-Message-State: AOJu0YxLmpFxRxKiwewOuZRKL239TUz32p0z6Dzt9SVJCDwMP+Gm0RNg
 x7lmRB58EBoGLX5tBApJGR7XUT9aunOKuyi/ywCaMA==
X-Google-Smtp-Source: AGHT+IETlNeZEH8Ziy/GEiOw7SJ2GzKq5QCdRlH7iKAq05yUDece4dhacD6uG4r6IyjK07tgKStlnA==
X-Received: by 2002:a17:902:c404:b0:1d0:6ffe:9fb with SMTP id
 k4-20020a170902c40400b001d06ffe09fbmr4250461plk.89.1701649654278; 
 Sun, 03 Dec 2023 16:27:34 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>
Subject: [PATCH 08/18] m68k: Add a reset_cpu() function
Date: Sun,  3 Dec 2023 17:26:24 -0700
Message-ID: <20231203172622.8.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
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

Since there are lots of reset functions, this one actually just calls
do_reset(). Future refactoring could correct this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/m68k/lib/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/lib/traps.c b/arch/m68k/lib/traps.c
index c283351181d8..ae8ae6ccf592 100644
--- a/arch/m68k/lib/traps.c
+++ b/arch/m68k/lib/traps.c
@@ -7,6 +7,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <cpu_func.h>
 #include <init.h>
 #include <watchdog.h>
 #include <command.h>
@@ -65,3 +66,9 @@ int arch_initr_trap(void)
 
 	return 0;
 }
+
+void reset_cpu(void)
+{
+	/* TODO: Refactor all the do_reset calls to be reset_cpu() instead */
+	do_reset(NULL, 0, 0, NULL);
+}
-- 
2.43.0.rc2.451.g8631bc7472-goog

