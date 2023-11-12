Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C663BC4167B
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55D986F42;
	Sun, 12 Nov 2023 01:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DXfRR3jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338F286F93; Sun, 12 Nov 2023 01:10:00 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B106886FFD
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-359398abeb5so11958355ab.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747777; x=1700352577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4gvT6gybatVq9pHXAmwPC62rwuXAK7rPfttJEnGseM=;
 b=DXfRR3joDLAhc4fili/EouSCE8+MJDd/H3BCYexUscvuV3VGwvgq6Ap/MUkpmEqKrl
 NpTDodIVBhzL53pLWKAp3AxV9wvkCMY0Izo8aVa3QCKPAFWHo66bWuFh5ilfp8a4pYnK
 27rAv80IA46ktJnr81KwPC1qB4zlOwnyhUFwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747777; x=1700352577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4gvT6gybatVq9pHXAmwPC62rwuXAK7rPfttJEnGseM=;
 b=qh9oVnZ+e5Q7vDCN8qpfIseXXTErJLXmUvrsLqGP8bunLZC0Ii/OwJd7In67xM5Jc8
 9Ps+SI08ayEOU6Fy1ClRmRbecgDAOPFfPBQzSEgHTB8+aBQHWwL0flCapWrcwi6X+KNm
 zrxtwsUBncibl5qC8C5a8Koa4KlJcCLH9mLN3rSugxy2bEVlS26QiFH/Srl3RKJ2z7a+
 nDococbb+WtEDUG7MC0d79XF6d83TxVoCANCHCbb5WUWLQHxs7xImMXjFM9P96o0TYbE
 o7vtlf8ZV1bkMKUiJgtEshu3GSlf2JBkHUB1VsISzuCf4UjIxzxtiPU52ugGf04Oxfue
 1UDA==
X-Gm-Message-State: AOJu0YyDmPfWY5CrsMWCoE3N24HaF00Gadh1vT3CS6LTUbl49ofrYMaf
 l929rN8L4Y43q58+ooHYgOykVIcXJtpPav05j0A0Gg==
X-Google-Smtp-Source: AGHT+IGIuaLvCUPD1XHFeT15GFaBNO0T7WE/ssm7/oqn0GBYoCgOG1OOPkgG699wtB/LCJqimYiAdw==
X-Received: by 2002:a05:6e02:216e:b0:359:4b03:d943 with SMTP id
 s14-20020a056e02216e00b003594b03d943mr4602519ilv.11.1699747777249; 
 Sat, 11 Nov 2023 16:09:37 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 07/29] bootm: Simplify arguments for bootm_pre_load()
Date: Sat, 11 Nov 2023 17:08:52 -0700
Message-ID: <20231112000923.73568-8-sjg@chromium.org>
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

Move the argument decoding to the caller, to avoid needing to pass the
command-line arguments.

Add a function comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index fda97706fc26..1482a2cc783f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -82,22 +82,31 @@ static int bootm_start(void)
 	return 0;
 }
 
-static ulong bootm_data_addr(int argc, char *const argv[])
+static ulong bootm_data_addr(const char *addr_str)
 {
 	ulong addr;
 
-	if (argc > 0)
-		addr = simple_strtoul(argv[0], NULL, 16);
+	if (addr_str)
+		addr = hextoul(addr_str, NULL);
 	else
 		addr = image_load_addr;
 
 	return addr;
 }
 
-static int bootm_pre_load(struct cmd_tbl *cmdtp, int flag, int argc,
-			  char *const argv[])
+/**
+ * bootm_pre_load() - Handle the pre-load processing
+ *
+ * This can be used to do a full signature check of the image, for example.
+ * It calls image_pre_load() with the data address of the image to check.
+ *
+ * @addr_str: String containing load address in hex, or NULL to use
+ * image_load_addr
+ * Return: 0 if OK, CMD_RET_FAILURE on failure
+ */
+static int bootm_pre_load(const char *addr_str)
 {
-	ulong data_addr = bootm_data_addr(argc, argv);
+	ulong data_addr = bootm_data_addr(addr_str);
 	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTM_PRE_LOAD))
@@ -785,7 +794,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = bootm_start();
 
 	if (!ret && (states & BOOTM_STATE_PRE_LOAD))
-		ret = bootm_pre_load(cmdtp, flag, argc, argv);
+		ret = bootm_pre_load(argv[0]);
 
 	if (!ret && (states & BOOTM_STATE_FINDOS))
 		ret = bootm_find_os(cmdtp, flag, argc, argv);
-- 
2.42.0.869.gea05f2083d-goog

