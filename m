Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604DEC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE6287541;
	Sat, 18 Nov 2023 22:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EbD6EY2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF8C874A5; Sat, 18 Nov 2023 22:06:43 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7618751F
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a692658181so115164239f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341580; x=1700946380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCp7vZ94xgt1jjTnFnfT5s7Hd+IHSmGCkoIoLViljyg=;
 b=EbD6EY2xp7HD8nM1IN/gN6Ye2Fx6PQJDT+RVq95ulcn2DTSMJvUGwY7Yh1H7U3ZQ4w
 oAkngTp3p6WbW9+ONTQVOwjJm98dtSFFiNF77yTQbxHIpFfzEcaflCQAiCcKC0+yVvRr
 7QKuGBxxKMVnd249vbV6kajIPF4fKNMd1rQtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341580; x=1700946380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCp7vZ94xgt1jjTnFnfT5s7Hd+IHSmGCkoIoLViljyg=;
 b=Y5P/uggRtf5/80RuOIAaIRzCmnHPQZZ7elIL6cIj/HEo9U22TAd03GSzDo1NSoeM/l
 evFMy6qEfut4WWArkd6yAoyv/iE8oMzZEBkJRSiWVYeYM8Iz5GlV3FIOylYLo5DgBGqr
 /G8a9MxCd6QPEUoULFAokKqk8Y3i663UNuqZa0MSNO4r5Jm5tZrweWz0nBplU2WYGYQp
 s0cBOJkvONjMKZJOjtAulQVacMjX4iJ+t4OfCUMar23fIvTOHcIGgnkKxW5TRTywJ9wg
 NEHsRroTQxSnq7RGSm9TshYJgp/KD+ihmHdtGTy0CiQm/PNO8FnK6PhRdtFFZfTHwKeU
 IMrw==
X-Gm-Message-State: AOJu0YwX7maXEjkSzWRclmI8mWoqL/8t/FcL/wVcs8nXEKghpMroVrJp
 N13zAVXsF6kUTTfIQ+Cl73K6XHmo1lKFMoVDlAtLlA==
X-Google-Smtp-Source: AGHT+IG3qCkEpp/ynbQ9S2E2BXqQwzifhMUlJn2yMjrgWRbzcSPgpUDdZ6c6dH8uikqhF0dSmUORhg==
X-Received: by 2002:a05:6602:3718:b0:7a9:4268:fc26 with SMTP id
 bh24-20020a056602371800b007a94268fc26mr4415308iob.10.1700341580541; 
 Sat, 18 Nov 2023 13:06:20 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 27/32] bootm: optee: Drop special call to bootm_find_other()
Date: Sat, 18 Nov 2023 14:05:15 -0700
Message-ID: <20231118210547.577026-28-sjg@chromium.org>
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

The normal bootm flow calls bootm_find_other() can call the
BOOTM_STATE_FINDOTHER state as part of its processing. Fix the
condition there so that this hack can be removed.

Also drop the confusing check for the OS type, since do_bootm_tee() is
only called if the condition is met - see bootm_os_get_boot_func()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c    |  2 +-
 boot/bootm_os.c | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index dc64de952c23..45491e3f30aa 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -584,7 +584,7 @@ static int bootm_find_other(struct cmd_tbl *cmdtp, int flag, int argc,
 	     images.os.type == IH_TYPE_KERNEL_NOLOAD ||
 	     images.os.type == IH_TYPE_MULTI) &&
 	    (images.os.os == IH_OS_LINUX || images.os.os == IH_OS_VXWORKS ||
-	     images.os.os == IH_OS_EFI))
+	     images.os.os == IH_OS_EFI || images.os.os == IH_OS_TEE))
 		return bootm_find_images(flag, argc, argv, 0, 0);
 
 	return 0;
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index af25c9e7c81b..b92422171a84 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -460,11 +460,6 @@ static int do_bootm_tee(int flag, int argc, char *const argv[],
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
@@ -472,11 +467,6 @@ static int do_bootm_tee(int flag, int argc, char *const argv[],
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
2.43.0.rc0.421.g78406f8d94-goog

