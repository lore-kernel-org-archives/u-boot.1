Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442A4C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2068B87805;
	Sun, 12 Nov 2023 01:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CrNvGva1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DE5886BAC; Sun, 12 Nov 2023 01:10:45 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD293871FC
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35aa6107e9fso6843695ab.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747794; x=1700352594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4fgsUxt45hAFVAgQ6O354DmHE1jfxRLcGw091nniFU=;
 b=CrNvGva158X9bHaQ2/shmMrfWK3pIzTinf4kIPEcuisS8BMVxXxy4RO/nLW9dFu3rU
 kMm7Ie3ZquUN9s922Mu1U5bARavAhGfK7zPhI4WltsAanfhHTYQGwgf6tq2GlXghgA/F
 L8ZSu/DfYKev62b8Mf0VmV2hUABt0WT8J4CSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747794; x=1700352594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4fgsUxt45hAFVAgQ6O354DmHE1jfxRLcGw091nniFU=;
 b=T32YfwAWyCuRyw3kWsadzw3UM3eSaAo0zz32D39aZPLpsiumjmwU4SS/8uiGUUnUZU
 +ioC6gu77TTqn9ULmW34W53hoFvCm0Mg9N+RRXcPO1b12xYCVvInmtwHfVVj1balmrph
 xj98bFJJvuTgiWsKDpTgn3G9PNfN2MxISwCbyEoBE4WS7n+pvKVGexP5FXI+98bHbWsD
 j6SzTWyv8dlWL+WeT6URymbNwO7GxoS78Z3XcHzdNd1A4h6el6EJbBgRBAAgdvHNjW2I
 sNLhht02v/N2QjFHPiHPBHbqaTJ5JBlYoywgSxW/Tb1G66xqvZ3vWhMVE5/FBCiAIf3W
 QdlQ==
X-Gm-Message-State: AOJu0Yxd/JBQyQ7ys79d/TnNWcHoIcptOSBCoCNreCthdep91zhbNWci
 bK9zYIb4D+6xXhipTn5Xv9wiDyPOoyLC/XZBAqa0jA==
X-Google-Smtp-Source: AGHT+IHsmEp5GAXLkmWnzSyjAC6sAOPWiIVNdcZs6tkU7jmtdDeNhZiVmSLm1+MH4Ub6/I/sv4e8Dg==
X-Received: by 2002:a05:6e02:154d:b0:358:104:679d with SMTP id
 j13-20020a056e02154d00b003580104679dmr4657302ilu.28.1699747794191; 
 Sat, 11 Nov 2023 16:09:54 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 26/29] bootm: optee: Drop special call to bootm_find_other()
Date: Sat, 11 Nov 2023 17:09:11 -0700
Message-ID: <20231112000923.73568-27-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

The normal bootm flow calls bootm_find_other() can call the
BOOTM_STATE_FINDOTHER state as part of its processing. Fix the
condition there so that this hack can be removed.

Also drop the confusing check for the OS type, since do_bootm_tee() is
only called if the condition is met - see bootm_os_get_boot_func()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c    |  2 +-
 boot/bootm_os.c | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 342d6211a097..62b6ca957f5b 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -583,7 +583,7 @@ static int bootm_find_other(struct cmd_tbl *cmdtp, int flag, int argc,
 	     images.os.type == IH_TYPE_KERNEL_NOLOAD ||
 	     images.os.type == IH_TYPE_MULTI) &&
 	    (images.os.os == IH_OS_LINUX || images.os.os == IH_OS_VXWORKS ||
-	     images.os.os == IH_OS_EFI))
+	     images.os.os == IH_OS_EFI || images.os.os == IH_OS_TEE))
 		return bootm_find_images(flag, argc, argv, 0, 0);
 
 	return 0;
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 9af084a9f823..265df3dda626 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -467,11 +467,6 @@ static int do_bootm_tee(int flag, int argc, char *const argv[],
 {
 	int ret;
 
-	/* Verify OS type */
-	if (images->os.os != IH_OS_TEE) {
-		return 1;
-	};
-
 	/* Validate OPTEE header */
 	ret = optee_verify_bootm_image(images->os.image_start,
 				       images->os.load,
@@ -479,11 +474,6 @@ static int do_bootm_tee(int flag, int argc, char *const argv[],
 	if (ret)
 		return ret;
 
-	/* Locate FDT etc */
-	ret = bootm_find_images(flag, argc, argv, 0, 0);
-	if (ret)
-		return ret;
-
 	/* From here we can run the regular linux boot path */
 	return do_bootm_linux(flag, argc, argv, images);
 }
-- 
2.42.0.869.gea05f2083d-goog

