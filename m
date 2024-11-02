Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C81BE677E8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A1B7892DA;
	Sat,  2 Nov 2024 20:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lvwBETeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D90DE892B5; Sat,  2 Nov 2024 20:37:40 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C54308860B
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbce16d151so19369846d6.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576257; x=1731181057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1l4008HXAOwBtGkGG9zP/XDN9vFeqbe4JP3H6cnPV7U=;
 b=lvwBETeMeeF3YYhc0n2GInQBeiaXSXH0mOD8zZGjZMIZaqjVG4w0rvgMR9c0vBPGv+
 B8MjoIvCE9O1HTusyOY1zpgcdimvuhP4fHBW0IJOE8gEbEy7XTvzqpQhCjlUTcwWmpBc
 6hkXwCCpeXNtToWpokr5KohNz9zOanscDKK3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576257; x=1731181057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1l4008HXAOwBtGkGG9zP/XDN9vFeqbe4JP3H6cnPV7U=;
 b=XByU958tDj2EgpRwnmWQe8z3SuwYLzAeX2nEeLLXGYgM8P5jWt9hu+NyLRj37SfurB
 XEnxxE07HPEoWj9hs9lHqopNpK3Drx5oD8TRIrU2AMlR39qNTZfDGPeYwKFiP9u1Myl7
 aREDxTs1UdnKVozo0xhRZE8OXgeQ8eJ+Giyj31cjbmqBfP+aVWudZDdd6EnLaUmqJDLR
 GhMTl70Zd5TuWrjdKvGKfIwC9YtkePi2cpz4YxlHXQaTXHPMyzA4HNydRh7vYS5aQsHh
 DkzG6VEHAqr6c+I/nazOI/5rz+Q5DCP8VeLpk9l1bTcEpiHqJ9W5IC1bAz74Wm4SLDhc
 d6lQ==
X-Gm-Message-State: AOJu0Yx7XdXOFfrbRFVW8M695uiY/AtL5jGkQXJJA5yHuaoYwRF/svcO
 o1LrDCGQxGUZZZ+cqMpb5D3J6RUfVkAvQ+kuGYehNhP6OsjSW+5WSdKhkHbaHlex7wlgNGODDzV
 4Ywn6
X-Google-Smtp-Source: AGHT+IGrQBhbMifQYSchLIGrZfJIN1IO9bc5agC2GOE1JMQDGp64xY80wvzJP/FgSyzAV9eNwULNQA==
X-Received: by 2002:a05:6214:3a89:b0:6cb:ebfa:c478 with SMTP id
 6a1803df08f44-6d1856f93bdmr447952806d6.28.1730576256924; 
 Sat, 02 Nov 2024 12:37:36 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/20] command_ut: test: Move test into lib
Date: Sat,  2 Nov 2024 13:36:51 -0600
Message-ID: <20241102193715.432529-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the lib/
directory, since that is where compression is implemented.

Rename it to just 'command', since it is obviously a unit test and the
_ut suffix does not add much except to make it different from the names
of other test files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/Makefile                        | 1 -
 test/cmd/Makefile                    | 1 +
 test/{command_ut.c => cmd/command.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{command_ut.c => cmd/command.c} (100%)

diff --git a/test/Makefile b/test/Makefile
index ff621344a03..48d8bc91ae6 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
 endif
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_ut.o
-obj-$(CONFIG_$(XPL_)CMDLINE) += command_ut.o
 obj-y += dm/
 obj-$(CONFIG_FUZZ) += fuzz/
 ifndef CONFIG_SANDBOX_VPL
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index fe7a2165af2..6231a08186d 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -5,6 +5,7 @@
 
 obj-y += cmd_ut_cmd.o
 
+obj-$(CONFIG_$(XPL_)CMDLINE) += command.o
 ifdef CONFIG_HUSH_PARSER
 obj-$(CONFIG_CONSOLE_RECORD) += test_echo.o
 endif
diff --git a/test/command_ut.c b/test/cmd/command.c
similarity index 100%
rename from test/command_ut.c
rename to test/cmd/command.c
-- 
2.43.0

