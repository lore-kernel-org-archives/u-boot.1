Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE0CE95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8518286F49;
	Sun,  8 Oct 2023 01:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="czxDXUVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C7786EF3; Sun,  8 Oct 2023 01:13:26 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2193386D82
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-351367c8fcdso13320885ab.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720385; x=1697325185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsW03jWaWGhm8/3RbHxhPad3FrkkTxavGZCnXJT2/L0=;
 b=czxDXUVWI3NBnTjroJ3djIG+mP6k6pb9+2f8oR2gNu4Y0Nq0TqIjFhwDQ/CwTISd/z
 ao/XwfFHlgyOfsKSVF80Qda8Hfq7aORHxq/Z98A4CmAZy7spbwQLq8btsN3kC2jSA078
 VEy0CPPUgRPfcuzoaCrwskucwj09E/WO7LlXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720385; x=1697325185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsW03jWaWGhm8/3RbHxhPad3FrkkTxavGZCnXJT2/L0=;
 b=cS3lk1rOXsSvLyMc6jE5BbZBRWc9UmRoBpolBwNtwapuCs3MrYSL7E+uZehreIp8De
 pmF5e66y66Y/VxfeKXaD6Ov+/jVK+20sTxX+p6Dpk1TlzIrB1GmXLPuCaza5jZt5xGQ3
 yW0loVL2gvQpA19YMHUdXUp2e8AQ6EijJRFHMAgknig9zCs53ArVs0yLupcTcoHXtC4k
 MhNoA53uFu2E+hRTydBfMhC5m7oNBL7y0N2Ptm063O9k+1vMRHT9Iv2zEsQIUNgCJG6n
 UQUtUg89etLXwZ70AMHTUZbXLZ/J8Li8xV1hgFFmOzodh9zImBzpO21NjULg/PBAuKrN
 9O1Q==
X-Gm-Message-State: AOJu0YxaY8QeLfoYjCEI8lauwr+aS+4bQJlvI7sIyV63/7fNyNzZUocu
 ARBlyhMy6tSuPjlqYeCulO1ukvpy3K6T4kk9FD4=
X-Google-Smtp-Source: AGHT+IF0462geNCTZfQad7YfufoR4+K7NeLpfHBol7As1G5xRe4M4nGhWgIVZ/5awGnQaKuRy+ZxsQ==
X-Received: by 2002:a05:6e02:160c:b0:351:4dcd:7655 with SMTP id
 t12-20020a056e02160c00b003514dcd7655mr14024811ilu.31.1696720385222; 
 Sat, 07 Oct 2023 16:13:05 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/27] command.h: Add a U_BOOT_LONGHELP macro
Date: Sat,  7 Oct 2023 17:12:20 -0600
Message-ID: <20231007231255.277623-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

From: Tom Rini <trini@konsulko.com>

In order to be able to discard unused long help texts without further
linker lists, add a macro for defining the long help messages which uses
__maybe_unused.  This allows us to discard them as unreferenced as part
of the link.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/command.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/command.h b/include/command.h
index 34ea989b39b4..a836ea795ab6 100644
--- a/include/command.h
+++ b/include/command.h
@@ -322,6 +322,9 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 # define _CMD_HELP(x)
 #endif
 
+#define U_BOOT_LONGHELP(_cmdname, text)					\
+	static __maybe_unused const char _cmdname##_help_text[] = text;
+
 #define U_BOOT_SUBCMDS_DO_CMD(_cmdname)					\
 	static int do_##_cmdname(struct cmd_tbl *cmdtp, int flag,	\
 				 int argc, char *const argv[],		\
-- 
2.42.0.609.gbb76f46606-goog

