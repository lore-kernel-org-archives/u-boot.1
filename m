Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FBDC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0CA1885A8;
	Sat, 13 Jul 2024 09:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kSFO3ywX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715E98855E; Sat, 13 Jul 2024 09:03:43 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76DD6882B6
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2eedeca1c79so6031811fa.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854220; x=1721459020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyK7t0kvcmNRwyIj9BooHzueZCJwB50nHeKdzNqqlLw=;
 b=kSFO3ywXAXBhFd6eXzpuHgseh41S3tsvre4nl5uhQCoSftLs7nlEoJ4XYmA/vF/r1j
 riunCzVYIFaPAvbWveY+faRnxl9YgqF7I47+ls0i/TlUCOmBfCxOpM38TO+hVtYCo3Mw
 NKceQqzEu2nxd7hcUGcxsSlaINLeUQPVa9co0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854220; x=1721459020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyK7t0kvcmNRwyIj9BooHzueZCJwB50nHeKdzNqqlLw=;
 b=O8zNeiii0bmkBEM2dx60SbvPh1XSrFJShrkzDExHAfEgosAVnGff9Ww2Tli0zzKCZ8
 LNzdZa5gczg/EN599hORcKqcpv097oJoYT8st6xyzoREg8+0GEFHdYOVfLvYu/7rG1ou
 hIQ2Kzgk9wmKKWt9BtKrl5FUzOY3w6WOqBdBUBwcfoCODZOAZeVX1I5qMIFIV+D6YA2s
 3Obj8mdqOk8thCeh5SFQseaXVhQ8YIfNmUxL8mvaNfnx9pC5s51BxazmGfymeBuCDdWe
 pSYKVthNODmLlUeGP404ACcNA6T9Za8VfuwEY7M7j1Kur/z6cjFKZRXzOhMtbq5Zbl9n
 usKg==
X-Gm-Message-State: AOJu0Yxyb0r62AOOH+YtUIydOREoQzHYrDh1s/VJlVZiJLcBLX3ncx9J
 RUyk/0fvFTE9QR4IyCV8GLcGQ2YBpMpaC5g8tOaQ84joncYazEHYyc3UF+wIYuirVQAnE++C9U8
 =
X-Google-Smtp-Source: AGHT+IGrQGqEJETKvuo3Xiarft4dXD6+BtUBUdauWK46v400Yhy8sCkvI8N0lsSFPJTEcbTWBpEe/w==
X-Received: by 2002:a2e:9048:0:b0:2ee:6254:f9f1 with SMTP id
 38308e7fff4ca-2eeb30b8afdmr99488271fa.6.1720854220284; 
 Sat, 13 Jul 2024 00:03:40 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/21] sandbox: Use const in os_jump_to_file()
Date: Sat, 13 Jul 2024 08:00:35 +0100
Message-Id: <20240713070055.2172883-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

The argument array is not changed by the callee, so mark it const.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/os.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index d7869b2e368..6a8a5e7b89b 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -808,7 +808,7 @@ static int make_exec(char *fname, const void *data, int size)
  * @count: Number of arguments in @add_args
  * Return: 0 if OK, -ENOMEM if out of memory
  */
-static int add_args(char ***argvp, char *add_args[], int count)
+static int add_args(char ***argvp, const char *add_args[], int count)
 {
 	char **argv, **ap;
 	int argc;
@@ -859,7 +859,7 @@ static int os_jump_to_file(const char *fname, bool delete_it)
 	struct sandbox_state *state = state_get_current();
 	char mem_fname[30];
 	int fd, err;
-	char *extra_args[5];
+	const char *extra_args[5];
 	char **argv = state->argv;
 	int argc;
 #ifdef DEBUG
-- 
2.34.1

