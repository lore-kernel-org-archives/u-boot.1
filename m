Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C63C2BA15
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F269B882DC;
	Wed, 19 Jun 2024 14:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ODYXhvMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B65884AA; Wed, 19 Jun 2024 14:35:01 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF628844F
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7ebde93bf79so283938239f.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718800497; x=1719405297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tw6aQYVCpf6Z1vhy3PFXhnvbODqPE/ptNGn4/nRTx8M=;
 b=ODYXhvMuYuN2XISB+fnG6t+wCZT0tijwHRfpUBXzzZHtzuR105WhdzoSvupUj5CSY8
 JtQhAFhuK0NgMhz3O7KmCk+bMfyUISnlPxUeSU/6wTxt9AN4HH35jJsp+TMo1l2u9/SG
 KFFrMxI39CskWSD4vqw89lmff3z2rl7hg2rCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718800497; x=1719405297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tw6aQYVCpf6Z1vhy3PFXhnvbODqPE/ptNGn4/nRTx8M=;
 b=Oywi4sa6jrLRUgEvEYQb/BXIpNeS6Wnnobm7ZQl8IXhHF/h0Hm900WHJaZBPw0QkAI
 8zd2jvIGm4zXfmzT4U550Va1UneBacqvVOiylRnh6RgTKh9BD5RuZQU/JKHwDuHB2xfu
 8KOZr7VHPvfdeonEakkuP7twBKadf1aTsvqoDI2bfPT30mlnmeldcWrKRdytJLLnJQUE
 r2TVq+oR5bD1QcZ5ZdvtvNgGoAYqtY+Qzb+u7AV9pn6vDMKN2jEPD+QfFG0Op8uMzx+n
 3MQc62iXlCGQjWHSyf1BK9e+x/0PqRzgoi3ygetPgO+LOEzMQte1IzSISSHiU4KJwqAW
 338A==
X-Gm-Message-State: AOJu0YyHLp2fpbiBd9y6EYHGl4ER9kFRxPKel3VP4VDfY6NWSFvFYG84
 pIVM11HSAP6oikUT7qtChR2MQQ+10R23Upn/rznFc+qct0MJ1drX/h1FUK3/0CSjToINMGsFuEJ
 1IQ==
X-Google-Smtp-Source: AGHT+IFY/jGpb4fVgLN+2wDv4TA/ILjI4sxOH77wSTrceJTKuBa3HrNf6M+XuHIQ0qSj57ZRNlrL9Q==
X-Received: by 2002:a05:6602:1589:b0:7eb:4770:6ea2 with SMTP id
 ca18e2360f4ac-7f13ee2aea8mr283704939f.5.1718800497641; 
 Wed, 19 Jun 2024 05:34:57 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b956a20f18sm3701882173.133.2024.06.19.05.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 05:34:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Paul Menzel <paulepanter@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] zboot: Add debugging for booting
Date: Wed, 19 Jun 2024 06:34:51 -0600
Message-Id: <20240619123453.720600-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619123453.720600-1-sjg@chromium.org>
References: <20240619123453.720600-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Show the boot arguments and the state mask, to aid debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/zboot.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index addf28cb4aa..c14219f19e9 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -5,6 +5,8 @@
  * Daniel Engström, Omicron Ceti AB, <daniel@omicron.se>
  */
 
+#define LOG_CATEGORY	LOGC_BOOT
+
 #include <command.h>
 #include <mapmem.h>
 #include <vsprintf.h>
@@ -14,8 +16,14 @@ static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
 	ulong bzimage_addr = 0, bzimage_size, initrd_addr, initrd_size;
-	ulong base_addr;
 	const char *s, *cmdline;
+	ulong base_addr;
+	int i;
+
+	log_debug("argc %d:", argc);
+	for (i = 0; i < argc; i++)
+		log_debug(" %s", argv[i]);
+	log_debug("\n");
 
 	/* argv[1] holds the address of the bzImage */
 	s = cmd_arg1(argc, argv) ? : env_get("fileaddr");
@@ -116,6 +124,7 @@ int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	int ret;
 
+	log_debug("state_mask %x\n", state_mask);
 	if (flag & ZBOOT_STATE_START)
 		ret = do_zboot_start(cmdtp, flag, argc, argv);
 	if (!ret && (flag & ZBOOT_STATE_LOAD))
-- 
2.34.1

