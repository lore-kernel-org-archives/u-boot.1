Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6786C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD9C87489;
	Thu, 16 Nov 2023 05:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GuBsfY1r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA248746E; Thu, 16 Nov 2023 05:11:28 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF8B870D2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7b063a6420dso10950439f.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107885; x=1700712685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUZNxzcvqP8EO9qaO4UVerj/R3ahNzEZ9G3Zy8GnxWk=;
 b=GuBsfY1r625aL3a2fKxsxCc4iGKRGHqGPSuEWtyaoglPCQSXhGX+zXycQmowwtPQ+U
 QsWCkpzfuvbu5bfwRYYB8zvqxgyYGfiUvmvxd6O8bD7H+Z+0y8Ymy7ajj4UNyth0mH7M
 koZU6QW/mLUoE7E4N8bNfKEWQlE/siE/50rD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107885; x=1700712685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUZNxzcvqP8EO9qaO4UVerj/R3ahNzEZ9G3Zy8GnxWk=;
 b=A0O1AcA+yAN1aJchhg6elVbMzuOMoHD87dPcFcaWEPqc5VtBQLWYcjEfISZye499rW
 bdkWPEIqctNS/GzrzlF/VWN9XBUkzTLiRkcbXTNVmD5IHZzouddv/CHlutm/gEnyo16K
 vIBinh7N8D4aTLUoK2cBXeZYMid1K9ZzDTs3iG9BPHN/Q/ejPlm0OcahMR8uCG5DspnR
 +jbZIMJ4oH2TRPAWCzbAEycy+vmVL0xXLdATkUm+T4OhCEd4Es/oTaxdx4V48N92a+XY
 rxq1TXXALWnTX+ZLIGT9iFYKIoHz5YO8vI81r+bMtfnqCozzHujdIPVf6NN+G4MW7Abc
 W3ow==
X-Gm-Message-State: AOJu0Ywu+2vhY6yXS4lTQGreYDEtJ4OpQEyyiseqKXm5NFFDOgrGsObC
 KeEviw9I3ePAyfSQyE5Qop3voGtJPrUlDvPIE5Uo0A==
X-Google-Smtp-Source: AGHT+IEnZpab0CRwVMeqC6GygOgIswj7QyPmixs/EFfC+n0fkXD0SqbxxEJueaPoewaahuMtyxfFZg==
X-Received: by 2002:a05:6602:2116:b0:79f:e800:ea95 with SMTP id
 x22-20020a056602211600b0079fe800ea95mr478682iox.3.1700107884880; 
 Wed, 15 Nov 2023 20:11:24 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 07/32] bootm: Drop arguments from bootm_start()
Date: Wed, 15 Nov 2023 21:10:07 -0700
Message-ID: <20231116041043.362055-8-sjg@chromium.org>
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

This function does not use its arguments. Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cb61485c226c..fda97706fc26 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -69,8 +69,7 @@ static void boot_start_lmb(struct bootm_headers *images)
 static inline void boot_start_lmb(struct bootm_headers *images) { }
 #endif
 
-static int bootm_start(struct cmd_tbl *cmdtp, int flag, int argc,
-		       char *const argv[])
+static int bootm_start(void)
 {
 	memset((void *)&images, 0, sizeof(images));
 	images.verify = env_get_yesno("verify");
@@ -783,7 +782,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * any error.
 	 */
 	if (states & BOOTM_STATE_START)
-		ret = bootm_start(cmdtp, flag, argc, argv);
+		ret = bootm_start();
 
 	if (!ret && (states & BOOTM_STATE_PRE_LOAD))
 		ret = bootm_pre_load(cmdtp, flag, argc, argv);
-- 
2.43.0.rc0.421.g78406f8d94-goog

