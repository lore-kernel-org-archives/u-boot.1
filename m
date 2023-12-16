Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7843CC4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E90E887C8C;
	Sat, 16 Dec 2023 04:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dPSWzUqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B5887C4D; Sat, 16 Dec 2023 04:15:24 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A370187B69
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35f92aaf7bcso4493585ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696518; x=1703301318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHa9R1pRqshphagjBGtYt478FM0UiaFPsMmgusNwl8g=;
 b=dPSWzUqxgWtiTbRke1SWpxvTcytyab1E8exwl9N8byvtTaDeEG4S5zJ2OWAUSEyXX/
 7EI+zFFbFYhjX5hUUlVgTUWOvpTWz2bev12Q1eIff23VtOBDlJgHmblu82mz1tN/p9VM
 cEkXaMARssFFNHOfEsLXXhWS7f5hiEsPptVcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696518; x=1703301318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHa9R1pRqshphagjBGtYt478FM0UiaFPsMmgusNwl8g=;
 b=X49UTNUZYXADVwoPaVsktR30lHuGra6HgWXjLOiLSnh28n8FfBeHQya7oEb8GXrNT2
 C+m923YxidmvHeNd/e5RS7vrMpK+nbWKDWfD6KN6scABBVSdfdSnOHWWyU+NSWA8+SN+
 8q09S2+kuakw3QJF4ADt7zRX5VsbC1vsubOsB9e714fL5tcSuszGr9qfmYlBd5AATr0u
 H3GHluSQgWEgyzvrW8REXwRiNNvww/IBRWhAD0Irjp+yo523UTw2OivY5fKgfaQcLISc
 hVfMpRpqQKaU5oc8Yh3zdtZonnYYA/m9DGTfi2jxrcT2+solRB7wWLXYAH6JnB7nqk+p
 zflg==
X-Gm-Message-State: AOJu0Yy3XiIfRv8OLgLKkIVwIuk6qGohuhNq4m1imuCwfJsvV/A09FjU
 MoAi4zutnyz43gyhPt1ACeY8XOyPqqO5+9kBOHCPiQ==
X-Google-Smtp-Source: AGHT+IF2zxrFaMeWbvn36ZqrxPpUT44ePRlrDYdX4Ar1vAGDES8E2rXvznwyo6tUKjJrF3w9JRtrgA==
X-Received: by 2002:a05:6e02:20c1:b0:35d:a33f:f08a with SMTP id
 1-20020a056e0220c100b0035da33ff08amr15861062ilq.18.1702696518082; 
 Fri, 15 Dec 2023 19:15:18 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 11/22] bootm: Move do_bootm_states() comment to header file
Date: Fri, 15 Dec 2023 20:14:15 -0700
Message-ID: <20231216031446.2222362-7-sjg@chromium.org>
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

This is an exported function, so move the function comment to the
bootm.h header file.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

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
index 7cfaa0a7d053..81f2514f1b7b 100644
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

