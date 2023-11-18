Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19F3C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA05874A5;
	Sat, 18 Nov 2023 22:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aCzouG3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9335886F95; Sat, 18 Nov 2023 22:06:39 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A7A8750C
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7a67b9cd230so109731439f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341579; x=1700946379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTlhEXm87sL9cLjIF1h0Wxx2yOxwTLUOi4sXQYLXtd4=;
 b=aCzouG3q0n9rDUfs+9Y2MFEYs5J/GHjQKuUoQIMhH8+E8P2wyCJzgPDB55xotuVvso
 dJnPzgdwllLinMZA96685TukNqXyKj/FNAV+YHXuQ9/PiUO3ZCwiLjaFu5dI5HPzHDwV
 Yxb2KSwXJMXy38wF7BaPFGtGDD0M76OA9A40g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341579; x=1700946379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTlhEXm87sL9cLjIF1h0Wxx2yOxwTLUOi4sXQYLXtd4=;
 b=sIikRny8t5wxtFqjAV43iMJPfP1v06hWKZeHHs5MZ0dxadtAdSfsLfFdPHj6azYZWi
 Eq/YNb9aR4hxvaKUfV/kErn6TgmaVL4kc8+ySHsqARKTJQnQgfkVIyHYyT/7w/2ORAFk
 jPG4AxHBFDj1jwFY1YByV9sSn2r3d42/Kpwk6k2XDpdw5frE6JiUeEzfGEOSbKW8gV66
 K0TK0q1rFcFLyIHroNVykmWTAaXv3mzVtFVVGSSc2bsTpBiv/FIJRL0fUp+WDqnY8Npb
 kaRPsXWi58QcqCajokIs6OlzHGeJL1ek/Xompej9jkmorPYSIOr2Ix09Hdbxe3fymzvJ
 oOIQ==
X-Gm-Message-State: AOJu0YxaXEWq2CEHN2AX2qGCsf3etBGLzhRqbEkAeBIDWzSrifnMA+xT
 R8dyZUlPimewh8kp/sIP4yWc6D4zZ5uE66qSsKgTyw==
X-Google-Smtp-Source: AGHT+IF1pDRF0CqU5+QNRqqZqy8irmu/73AFp6zZ/oSPf1ImgpFP0UMI7smf7KhJj13OzqdoBC1lLg==
X-Received: by 2002:a6b:f815:0:b0:79f:c9ad:19ce with SMTP id
 o21-20020a6bf815000000b0079fc9ad19cemr3821582ioh.15.1700341579097; 
 Sat, 18 Nov 2023 13:06:19 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 26/32] bootm: efi: Drop special call to bootm_find_other()
Date: Sat, 18 Nov 2023 14:05:14 -0700
Message-ID: <20231118210547.577026-27-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c    | 10 +++++-----
 boot/bootm_os.c |  6 ------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index db1466cecf2d..dc64de952c23 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -580,11 +580,11 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 static int bootm_find_other(struct cmd_tbl *cmdtp, int flag, int argc,
 			    char *const argv[])
 {
-	if (((images.os.type == IH_TYPE_KERNEL) ||
-	     (images.os.type == IH_TYPE_KERNEL_NOLOAD) ||
-	     (images.os.type == IH_TYPE_MULTI)) &&
-	    (images.os.os == IH_OS_LINUX ||
-		 images.os.os == IH_OS_VXWORKS))
+	if ((images.os.type == IH_TYPE_KERNEL ||
+	     images.os.type == IH_TYPE_KERNEL_NOLOAD ||
+	     images.os.type == IH_TYPE_MULTI) &&
+	    (images.os.os == IH_OS_LINUX || images.os.os == IH_OS_VXWORKS ||
+	     images.os.os == IH_OS_EFI))
 		return bootm_find_images(flag, argc, argv, 0, 0);
 
 	return 0;
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 30296eb27d7d..af25c9e7c81b 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -486,18 +486,12 @@ static int do_bootm_tee(int flag, int argc, char *const argv[],
 static int do_bootm_efi(int flag, int argc, char *const argv[],
 			struct bootm_headers *images)
 {
-	int ret;
 	efi_status_t efi_ret;
 	void *image_buf;
 
 	if (flag != BOOTM_STATE_OS_GO)
 		return 0;
 
-	/* Locate FDT, if provided */
-	ret = bootm_find_images(flag, argc, argv, 0, 0);
-	if (ret)
-		return ret;
-
 	/* Initialize EFI drivers */
 	efi_ret = efi_init_obj_list();
 	if (efi_ret != EFI_SUCCESS) {
-- 
2.43.0.rc0.421.g78406f8d94-goog

