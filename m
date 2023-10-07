Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5943EE95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 19:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2D686A02;
	Sat,  7 Oct 2023 21:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zvw1ruMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 350CA86961; Sat,  7 Oct 2023 21:13:14 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F8586A02
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 21:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59f6441215dso39428537b3.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 12:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696705990; x=1697310790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rA/L7Vbet13XIcJog6RB2P2xOXELlxAAiV9mIAOhFuI=;
 b=Zvw1ruMY4PSXYdbTCfHiBLKXKo/eqnN3WsGt2Ztg1Jojo7zeZYPvEgYz//n1XHIXr9
 VmMjwnx7Hl4XSgIAdzNRD0cy3QkMt2noE8asO85v73jJoW83Z8ZcPBW3bZureIGZ99K1
 UrhWlmYkcQ+q/qOz3Za6e1kpxzL9cjMp1svgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696705990; x=1697310790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rA/L7Vbet13XIcJog6RB2P2xOXELlxAAiV9mIAOhFuI=;
 b=XEQMlehRMRce3o52Wd9CP54d9bQVZMWSxiOJN6WqYfTISZlGLO4X3ApkhdTOLCWKfq
 BT4jVexxX8hu7zWUiTIAN6w2qioBbAqHRctwP61Tk0UXsKAH5kNX9gzcvhcu2SFBIG6L
 AJv5Z9q3Ns/vT952qb+E0pKq4gZE7ejytuinuHvxxcZK53PmS2aiiS8GKUjPfwPF5si4
 d0+XxTQWUzqu5zcVIoKVsxvay1oYf3XYRr1+/ae9iStHCDC5UkTyPgMdJXJQq8RPYuJN
 uhMUjsiCicreBOH6CWjm9LNwX0jwb+6RsYtE3auFAmCGiFkxFzqE8lODTK3nwcbPQYej
 UbwA==
X-Gm-Message-State: AOJu0YxY9eK7Gw40lR7VsI9UDygTgCLlUftEVJyVvW4ORX4AP5qBTZpP
 BIG/sUJq6gsg4oGTgNZIXFbqAJhU7otKYN8tnQ+9LA==
X-Google-Smtp-Source: AGHT+IFpZm+scbYeswU3l6L7+tUAkojie1EQpJmAPpNkCYzUAlfgAUmcyi/uCqrQtv8si2060w6ewA==
X-Received: by 2002:a81:84c4:0:b0:58e:fa3c:9401 with SMTP id
 u187-20020a8184c4000000b0058efa3c9401mr10943635ywf.12.1696705990655; 
 Sat, 07 Oct 2023 12:13:10 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-3c47-81c9-6281-4dc8.res6.spectrum.com.
 [2603:6081:7b00:6400:3c47:81c9:6281:4dc8])
 by smtp.gmail.com with ESMTPSA id
 p63-20020a0de642000000b005704c4d3579sm2244883ywe.40.2023.10.07.12.13.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 12:13:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] command.h: Add a U_BOOT_LONGHELP macro
Date: Sat,  7 Oct 2023 15:13:07 -0400
Message-Id: <20231007191308.2222470-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

In order to be able to discard unused long help texts without further
linker lists, add a macro for defining the long help messages which uses
__maybe_unused.  This allows us to discard them as unreferenced as part
of the link.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
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
2.34.1

