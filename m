Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D123C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4291A87AF9;
	Thu, 14 Dec 2023 17:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DFir+VMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFAAC87AFE; Thu, 14 Dec 2023 17:51:58 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEB387AF0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35d5b30eb85so25025325ab.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572713; x=1703177513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naWnTBL1GMoO+o1aNGUBT01W2NFsG789Ru1bEKFFCe8=;
 b=DFir+VMraZdR7faPlSmLhec91s17VLDJPhUmgsS4yFIpUP1MB2+4eAwCQ2RabAjgv+
 CR5CFl90XnJCjMuzMA+0Bb7Fz/Tu/h5+JdtSLRHNs8n3rhlWqXseReF8d1G10ooHAaJH
 sXZwfq4fmy5vVDheH7jZLx5wuuVwyIMi89SIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572713; x=1703177513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=naWnTBL1GMoO+o1aNGUBT01W2NFsG789Ru1bEKFFCe8=;
 b=g8K6mLy8yxZZqh2hCAiJoFq3PfnCFSMkikj7wHe1QvwgY/wdTvbSCdSSi0S0qM0+Uz
 TOYVKzVWs7UNI/4NViBy0zSSh+CVKBYhz+e72WspXzU4LV1Re55+rmUCC4mwZWSOXzCs
 UkqzAcs0Bhv4R7w4rdwxwTOppsF0QIppT4Ehb0Z96OfnCwEejswcgic1+80ay1B8MDHQ
 z4Wm7/b12uanqk7DJkWoacZjGYMbo0RGkiXv339LhCzGGHCDEL9F6z0SFo2MSLBUg+/L
 iuCDX3C1rsVOaa/QW/ic1eqRKvKhCALJFPiPLx19Ir8OYDvSO2LjJak+7jYgTax3xko9
 /ENA==
X-Gm-Message-State: AOJu0Yxn5O1beQ43jiy4DpOgTSPv+dJu79FAzL5k7xDSjnvvXQw6Nr3I
 fkf4QRxTjaevIS7diBIHXGz4+6i36/LVHWv/mozheg==
X-Google-Smtp-Source: AGHT+IHP95PZdRa+Io8uQLnQTzCWEEyLBglcwErDUbCbiUvZHkQRabQZyrydhead4RgqXYPfdJOokA==
X-Received: by 2002:a05:6e02:16cb:b0:35d:9344:b033 with SMTP id
 11-20020a056e0216cb00b0035d9344b033mr12503019ilx.12.1702572713106; 
 Thu, 14 Dec 2023 08:51:53 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 11/21] bootm: Move do_bootm_states() comment to header file
Date: Thu, 14 Dec 2023 09:50:20 -0700
Message-ID: <20231214165112.2182274-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

This is an exported function, so move the function comment to the
bootm.h header file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split out patch to move do_bootm_states() comment to header

 boot/bootm.c    | 25 -------------------------
 include/bootm.h | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 9e42fa5117d0..875f8a1c2a56 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -990,31 +990,6 @@ unmap_image:
 	return ret;
 }
 
-/**
- * Execute selected states of the bootm command.
- *
- * Note the arguments to this state must be the first argument, Any 'bootm'
- * or sub-command arguments must have already been taken.
- *
- * Note that if states contains more than one flag it MUST contain
- * BOOTM_STATE_START, since this handles and consumes the command line args.
- *
- * Also note that aside from boot_os_fn functions and bootm_load_os no other
- * functions we store the return value of in 'ret' may use a negative return
- * value, without special handling.
- *
- * @param cmdtp		Pointer to bootm command table entry
- * @param flag		Command flags (CMD_FLAG_...)
- * @param argc		Number of subcommand arguments (0 = no arguments)
- * @param argv		Arguments
- * @param states	Mask containing states to run (BOOTM_STATE_...)
- * @param images	Image header information
- * @param boot_progress 1 to show boot progress, 0 to not do this
- * Return: 0 if ok, something else on error. Some errors will cause this
- *	function to perform a reboot! If states contains BOOTM_STATE_OS_GO
- *	then the intent is to boot an OS, so this function will not return
- *	unless the image type is standalone.
- */
 int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[], int states, struct bootm_headers *images,
 		    int boot_progress)
diff --git a/include/bootm.h b/include/bootm.h
index c9ab55f18d39..950ce5181f1d 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -131,6 +131,31 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
  */
 int bootm_measure(struct bootm_headers *images);
 
+/**
+ * Execute selected states of the bootm command.
+ *
+ * Note the arguments to this state must be the first argument, Any 'bootm'
+ * or sub-command arguments must have already been taken.
+ *
+ * Note that if states contains more than one flag it MUST contain
+ * BOOTM_STATE_START, since this handles and consumes the command line args.
+ *
+ * Also note that aside from boot_os_fn functions and bootm_load_os no other
+ * functions we store the return value of in 'ret' may use a negative return
+ * value, without special handling.
+ *
+ * @param cmdtp		Pointer to bootm command table entry
+ * @param flag		Command flags (CMD_FLAG_...)
+ * @param argc		Number of subcommand arguments (0 = no arguments)
+ * @param argv		Arguments
+ * @param states	Mask containing states to run (BOOTM_STATE_...)
+ * @param images	Image header information
+ * @param boot_progress 1 to show boot progress, 0 to not do this
+ * Return: 0 if ok, something else on error. Some errors will cause this
+ *	function to perform a reboot! If states contains BOOTM_STATE_OS_GO
+ *	then the intent is to boot an OS, so this function will not return
+ *	unless the image type is standalone.
+ */
 int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[], int states, struct bootm_headers *images,
 		    int boot_progress);
-- 
2.43.0.472.g3155946c3a-goog

