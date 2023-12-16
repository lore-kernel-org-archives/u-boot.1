Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41305C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CE687C68;
	Sat, 16 Dec 2023 04:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZGKE3YAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C4487C00; Sat, 16 Dec 2023 04:15:17 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7019F87AE6
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-35e70495835so5818015ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696513; x=1703301313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEondYvWCislx9HLi4+EAVleIwRJKaFENXj5XdT4HLg=;
 b=ZGKE3YACdHuzSmEgqaHkyRQljNV91h81G+XPdglv06CEFygJfYe64kc0XdQCBghqnx
 FSnsO3xh4EVlaEcMig7f51/ilbdlZBYIN4Gg34Y6PBNShZVz1QMzWQwTIFHhmf9yjuuB
 7ARLjU9wtgr//8euiqbyLYL+Vjwkr6QZO0KtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696513; x=1703301313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEondYvWCislx9HLi4+EAVleIwRJKaFENXj5XdT4HLg=;
 b=xBlEw22BCd5CoXn9SOqShYVhpyRmq3JILa13iStKzE4r6yr3pUOSuFGsVjwF7lGR9K
 WUBowz0Ouk+JaOBFPq+udEW+n0VtdR5D7sq+bmljT95xuhB3rzzr2SpfZfzqEuLo/2A1
 7nruqVDiFzKrRAPWmnfpUmKFxs+PiYP6gu2JKT/skdTt3kGPkfoGeTXgdDHk04x61+Ng
 aYjh4xt8PtGlHf58yR6HRwGuLTuL0AiznBfcICct8fmBGYJhzQgjFFKYg3BM/6dI3dL9
 36C7A/MQoz7dYsK01iRyvSfCfHoOkIK5Cr2mxcdJFUDATcOdZxg18zeBwzmevqdri3EJ
 3rAw==
X-Gm-Message-State: AOJu0YyVFX9RIHUp0k73Aap2ILC2AxPNXXLEHHLhvA+xmm+3G4PeG6fW
 2dQpKpxdKNEfBj6FZ/9MqrGjrkZB+X/2JRguXxD3sA==
X-Google-Smtp-Source: AGHT+IEwuPcag/leo90F9aoNVsc08fa9/mZy4pbWXFgCnjdYXzyH5J4DZvwvHe3Xh1E0LBKa0Eq96A==
X-Received: by 2002:a05:6e02:1c2f:b0:35f:656f:3751 with SMTP id
 m15-20020a056e021c2f00b0035f656f3751mr9621373ilh.22.1702696513001; 
 Fri, 15 Dec 2023 19:15:13 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 06/22] bootm: Adjust how the board is reset
Date: Fri, 15 Dec 2023 20:14:10 -0700
Message-ID: <20231216031446.2222362-2-sjg@chromium.org>
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

Use reset_cpu() to reset the board, copying the logic from the 'reset'
command. This makes more sense than directly calling the do_reset()
function with the arguments passsed to the bootm command.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 boot/bootm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 301cfded05cb..8a0dba5074e8 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1140,10 +1140,12 @@ err:
 	if (iflag)
 		enable_interrupts();
 
-	if (ret == BOOTM_ERR_UNIMPLEMENTED)
+	if (ret == BOOTM_ERR_UNIMPLEMENTED) {
 		bootstage_error(BOOTSTAGE_ID_DECOMP_UNIMPL);
-	else if (ret == BOOTM_ERR_RESET)
-		do_reset(cmdtp, flag, argc, argv);
+	} else if (ret == BOOTM_ERR_RESET) {
+		printf("Resetting the board...\n");
+		reset_cpu();
+	}
 
 	return ret;
 }
-- 
2.43.0.472.g3155946c3a-goog

