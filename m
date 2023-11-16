Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41FDC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B747874F9;
	Thu, 16 Nov 2023 05:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B6tMPbgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE4C874D6; Thu, 16 Nov 2023 05:11:47 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68CFC87478
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-359d27f6d46so1386475ab.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107904; x=1700712704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVxQ09fypJy/firdeJ08kfjudyx/y1hN2BDLEaaxHak=;
 b=B6tMPbgFkCTvQOJ79zzMetbUWsZ6lzJ0lTkChl7ifJ+A4Hj23ANkl4Q5/YbSVCO63L
 Kugygp/iextZb94mUYE6zNm9U2B996FGoD/thj3CdRAd7ks9sEbP0SrJKsmmq9sQz6v+
 GvbNr/p6YVWdTwjDpBFlZGOlRorRas2c+Kbx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107904; x=1700712704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zVxQ09fypJy/firdeJ08kfjudyx/y1hN2BDLEaaxHak=;
 b=Y1YGeW3U6VUS2E4iBZLnTmhgfDTmmhw0BjRGnB5NSaHBON8ZxUTI3k03DoDLkJOnlO
 vYVMBqV55Pj5rBZZlILL+RX62sukDReOixE40CX+X4awnHs+X5eRyScltfNfERaS2lUK
 Yotb+i3PzOy9y0MWr9o4hrLUUzCOOOHRTp3PFEnK1oMapjzXm5DryXryo5ktDlqFPA6c
 hllC6TD/uh06ClpLhmy6xImZ5jg4/QX1GoQqGttRivF0cMngaA2DYeCN4BMwW9fHH2b4
 YS3PAEn7UjE1z1eQZ/Ugc2ecmK9/PE8d+DEOcl609pzFq20vJ5h6L5CEk7hV+gTnZqZ6
 Lrng==
X-Gm-Message-State: AOJu0YwN0cKG+bqdshiGvpTfGfWZm+fROLgeZgM8mR230C9OgIKSrMJx
 lvOiN3vEe/XkLiL9NzNm9/Px2p3qzPhiJKniON+pnw==
X-Google-Smtp-Source: AGHT+IG9yRed44JvtpSfDelNjAPO7G8GArzN9FHoIg/4gChX+wYotExExAcRPhP1MUdIs8/LMpxH3g==
X-Received: by 2002:a05:6e02:1aa7:b0:357:a180:6b74 with SMTP id
 l7-20020a056e021aa700b00357a1806b74mr19326584ilv.27.1700107904054; 
 Wed, 15 Nov 2023 20:11:44 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 28/32] bootm: optee: Drop special call to bootm_find_other()
Date: Wed, 15 Nov 2023 21:10:28 -0700
Message-ID: <20231116041043.362055-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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
2.43.0.rc0.421.g78406f8d94-goog

