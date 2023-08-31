Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D58C83F34
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 17:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 963AD86614;
	Thu, 31 Aug 2023 19:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="No+I9RqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574BF865A3; Thu, 31 Aug 2023 19:21:11 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A648659D
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 19:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34df2a961a0so3568005ab.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693502467; x=1694107267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8cCH90GYu66tulOeCigboemkcVbyLu1YDn4cNezbyW8=;
 b=No+I9RqFOpBuSgiOErNK67FbDHgU6cxhye/bseVmSRWiJ1qA2sf/Lq1yrlPQ4MAHLj
 uOOHJ2nREFy0GvG6xcQhwpxRX2tjv9uxErFI7IWZ/bkNDo16S2k9AjX9gJ/xErZWFMNx
 p1kEy1b6LCLM6tqL/gVzXL4Yi3ufcwkCdD6iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693502467; x=1694107267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8cCH90GYu66tulOeCigboemkcVbyLu1YDn4cNezbyW8=;
 b=EQIy4p2oNr7xqOc/WTXVdG2ebFz+Jfjqb5+0reqoHMECY6MSuTSLO4a8t5OhMv4A8I
 VBHoCkJIMb6glFOQHnoern5R/kno2+rgO/pFUvUnIiLa1ipF/PUg+oq9RnImlmuTJTfq
 +Q0+5PL3n4NxVAwOIlS7vgjcmvYXK9CTVJ5/IAEFZrsEAUPgVrMpkehbTg9ykvE9unLY
 Ofd3DeGAZD6hqfjkqIAmkc4EzVFc4JhB1TtydDeMeEv0xdt7Y4P3todF/U8SugBqZ29V
 MVV+Q+FqfASL6fpgbyuP+tAyNer7O4oeyKFWoahWmoO7Z9Gp9SAYe9or1BUHNZmSgCRm
 PYWw==
X-Gm-Message-State: AOJu0YzQDVRP4jCr59fji56o0r4UM44W/WgloBES6/tauBCLLQKq1jpw
 MFxxL54L+TFe/RUHTwGsMSQVlqzIGcmxzzHlbZ4=
X-Google-Smtp-Source: AGHT+IFD6HbPm+lSof7JEvacIbfgdJK0K5PHv1cyffZxEvEQ34FQAMoH3jqRWLB7+kbHkgz2Ee55hA==
X-Received: by 2002:a05:6e02:1154:b0:345:d58d:9ae5 with SMTP id
 o20-20020a056e02115400b00345d58d9ae5mr168869ill.7.1693502467223; 
 Thu, 31 Aug 2023 10:21:07 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:24b3:5dcf:cfe6:7f23])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a056638190500b00430bd8692absm503732jal.159.2023.08.31.10.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 10:21:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mike Frysinger <vapier@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 2/2] x86: coreboot: Avoid a declaration after a label
Date: Thu, 31 Aug 2023 11:20:53 -0600
Message-ID: <20230831112051.2.I55a5439c9d6409dce914f7aeee455eb6585289ee@changeid>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831112051.1.I3fe7ac62de70902fd1be093bcda7c53acd43daf8@changeid>
References: <20230831112051.1.I3fe7ac62de70902fd1be093bcda7c53acd43daf8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Declare the global_data pointer at the top of the file, to avoid an
error:

   arch/x86/include/asm/global_data.h:143:35: error: a label can
      only be part of a statement and a declaration is not a statement
   board/coreboot/coreboot/coreboot.c:60:2: note: in expansion of macro
      ‘DECLARE_GLOBAL_DATA_PTR’

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mike Frysinger <vapier@chromium.org>
---

 board/coreboot/coreboot/coreboot.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/board/coreboot/coreboot/coreboot.c b/board/coreboot/coreboot/coreboot.c
index 3b90ae75386..db855c11ae6 100644
--- a/board/coreboot/coreboot/coreboot.c
+++ b/board/coreboot/coreboot/coreboot.c
@@ -10,6 +10,8 @@
 #include <asm/cb_sysinfo.h>
 #include <asm/global_data.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 int board_early_init_r(void)
 {
 	/*
@@ -54,14 +56,12 @@ int show_board_info(void)
 	return 0;
 
 fallback:
-#ifdef CONFIG_OF_CONTROL
-	DECLARE_GLOBAL_DATA_PTR;
-
-	model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
+	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
+		model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
 
-	if (model)
-		printf("Model: %s\n", model);
-#endif
+		if (model)
+			printf("Model: %s\n", model);
+	}
 
 	return checkboard();
 }
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

