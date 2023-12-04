Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D7EC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA078784C;
	Mon,  4 Dec 2023 01:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ii/T1Bgr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DDE7875EB; Mon,  4 Dec 2023 01:27:53 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76CF7877E5
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5be30d543c4so953593a12.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649669; x=1702254469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5AEYtkcu32nrTXRxtgkEjOU6Nsox0PSbFzsnACs1ic=;
 b=Ii/T1Bgr5uzOpctUdAMVBwSKOS5bO9934DmkYbZwEvaS8KrxwboVnS7fnEBatjHiSY
 Wm4ZoHTVKFXQhDZAv0KiJcVRj+tAP0MUCUUQexJwuo4HAcEPsJ1gCxG2VLPRrMT9mZJf
 nIRsZK5wUu3/wSyW4PclmElXw1BuvrXoNsLWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649669; x=1702254469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5AEYtkcu32nrTXRxtgkEjOU6Nsox0PSbFzsnACs1ic=;
 b=sTVcQvSjZfPaW9q4L+FvvJT0DGznE+jnppXg1tHE5NidnOWTNcTadmqX+TKtRL7EdU
 qayjWNi6yl98li/u2MRMSXT+RcAzpRKI1hwOHrBEVoc1XhdYZIjGQ5sztBycFkxCCmU0
 3SzOUgW/EqMgtKrPxY+Q9HLATO3gpVGVLu2Bnk1GAZ1VMgXuqZGZRfTOYTEFm9uoW23W
 Qrowu1G6UGN+UTZFA3u/xsCiPsX0k8kkrHb1BhQdmfRmozHvFJ8+Njr0JJg0q3Mp8Ia6
 2Q9xgNKgrAz/+MD1fJYtEKtUL9M/9CiLX37R4xgfz0UNRqN6UZTuoFT6Df4Le5UkapRi
 tRXg==
X-Gm-Message-State: AOJu0Yzo+KWUwq8eS8tv39eD+oCCp4crOtUDLaY+E2892o49J+KJz28g
 xb/LiizOxXmcHHL2B0MYp1yB+/ElWCrJXwJSPaRdaw==
X-Google-Smtp-Source: AGHT+IFQdk4uGLftTQskTzSK23uUyiKnbuouCG03XeisPNVlzJs5Gg47Ppkr/VKeLLsEh4Kqp5sKUQ==
X-Received: by 2002:a17:902:9a41:b0:1cf:88d9:c3b1 with SMTP id
 x1-20020a1709029a4100b001cf88d9c3b1mr1128836plv.62.1701649669771; 
 Sun, 03 Dec 2023 16:27:49 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 12/18] bootm: Adjust how the board is reset
Date: Sun,  3 Dec 2023 17:26:28 -0700
Message-ID: <20231204002642.895926-6-sjg@chromium.org>
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

Use reset_cpu() to reset the board, copying the logic from the 'reset'
command. This makes more sense than directly calling the do_reset()
function with the arguments passsed to the bootm command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index d2448f6306dc..de5c32099ceb 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1138,10 +1138,12 @@ err:
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
2.43.0.rc2.451.g8631bc7472-goog

