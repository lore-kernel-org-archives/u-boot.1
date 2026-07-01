Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CBFC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B8084BC1;
	Wed,  1 Jul 2026 13:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DWgb3AWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D8584BE4; Wed,  1 Jul 2026 13:47:09 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 754F784BED
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-489f3611e0cso306726b6e.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906425; x=1783511225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMPtHniMNFtNtDOhs62uzk8IBiCIs+ZgaW8NHZgLRH4=;
 b=DWgb3AWXZyYU7LCb4Rha5Mxy1EN3QkmUVDyoXbRHBKisN5AQpODzVg05dbK1nH2Sjg
 JuiS2y+uaMjc6xg56I576nkEwxCOc9SbMPfmJrqGkBU+FJXzXtSU1wkWnnpc1hLC1AVn
 hDNvXoTCDyuaJS8tfYEk18pMT8Nm2Rtl8DCfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906425; x=1783511225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hMPtHniMNFtNtDOhs62uzk8IBiCIs+ZgaW8NHZgLRH4=;
 b=OuYAQOl+n5uEVedpNkehPHzjznSiW8C9Z5faUheT8MEYlG/5eV03a83Hc4sRvNiZH9
 8O2yd49Trb2znfQrX27mk3upBct9NRzXZyUkxy6DsUwtMCNfrFyXqRQxkLs25aAkR7MM
 y0Cb4XgcRpeC9zp4vzH3KcRMUGWDVVEmftp5TNL+t2lwIW7n8ComXAfosRgOQGXLN0zo
 hLeb0H5/KTMaY/LTZL9dQw6n1yRKVYufIqjE0KADqmIkbtDW1qwFCZJsSbJ9QVq25on4
 w5R76F+1/SjXpqnoUivsWfZ/LfsMcA7AOXhjnv1U0EGp+eNoJErnlN8aLBdmMBZOoi5s
 jIjg==
X-Gm-Message-State: AOJu0YyHv+mp+k3FZITR1Cx+4iH2NoxPKJXANZ/I8WouWaQWIq4o+Qt0
 2hnxsqPx4J60njt3960boMTHpUQO0IF1TKuN+HPjfHtZp5/Sxqj74aVP4HF2uwq0B3KxAQj+/bh
 fpiM=
X-Gm-Gg: AfdE7cmS87lINSzjBfKCG4ykOHMsu5ytoqhjqSsUIpjZkTrmSop1JV9OvzoHCpl5kbt
 FJDQyQIoqU4ju2zijNgtbZiUN3k4wEmiNYyD1zXS8yUWkBiR2Az2H7f7yEpIiaUeSNABo7ygjcf
 XQsbEMshi+uvZvFJAjv/oqE7oLQNtaZ90uQ6BgWbUK+njq0y8yDaThE09D+WvvP3/PNFRa01T4R
 t/21vDwNnhc6x50vCOu7d1FHtCpuih4MAGUCc6CSLJf0WeHqJAclPT71B7vzBG9k/uattV+4RRz
 5kXelmhQf19jUQ/KvmLU4h29++dfr+bqBlL73z1RLyKAc7F5T6awPBZWAA2kUUM/DdAX5YXmMmV
 cVxB9vhsIhhagdWlXzcpr9LL/4FWZZW8Yx5wv2La8N+XhEixQdvTcrBryCI6GHNPSN4lr0112BF
 N9iRQRjHk=
X-Received: by 2002:a05:6808:15aa:b0:490:5ba4:18a3 with SMTP id
 5614622812f47-4960efbb539mr885373b6e.30.1782906425207; 
 Wed, 01 Jul 2026 04:47:05 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 04/14] command: Narrow cmd_tbl.maxargs to a short
Date: Wed,  1 Jul 2026 05:42:24 -0600
Message-ID: <20260701114248.1396125-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701114248.1396125-1-sjg@chromium.org>
References: <20260701114248.1396125-1-sjg@chromium.org>
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

maxargs holds the maximum argument count for a command and is currently
an int. The largest value any command actually needs is
CONFIG_SYS_MAXARGS (256 on the boards that raise it), so a short is
ample. Narrowing it frees two bytes in struct cmd_tbl which a later
change uses for a flags byte, with no growth in the per-command entry
size.

Two commands (the sound command and its play sub-command) pass INT_MAX
as maxargs to mean 'accept any number of arguments'. That no longer
fits in a short, so add a CMD_MAXARGS sentinel (SHRT_MAX) and use it in
those two places.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to narrow maxargs to a short, freeing space in
  struct cmd_tbl for the flags byte

 cmd/sound.c       | 4 ++--
 include/command.h | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/cmd/sound.c b/cmd/sound.c
index 7546059022f..68b878641fe 100644
--- a/cmd/sound.c
+++ b/cmd/sound.c
@@ -67,7 +67,7 @@ err:
 
 static struct cmd_tbl cmd_sound_sub[] = {
 	U_BOOT_CMD_MKENT(init, 0, 1, do_init, "", ""),
-	U_BOOT_CMD_MKENT(play, INT_MAX, 1, do_play, "", ""),
+	U_BOOT_CMD_MKENT(play, CMD_MAXARGS, 1, do_play, "", ""),
 };
 
 /* process sound command */
@@ -92,7 +92,7 @@ static int do_sound(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 U_BOOT_CMD(
-	sound, INT_MAX, 1, do_sound,
+	sound, CMD_MAXARGS, 1, do_sound,
 	"sound sub-system",
 	"init - initialise the sound driver\n"
 	"sound play [len [freq [len [freq ...]]]] - play sounds\n"
diff --git a/include/command.h b/include/command.h
index 5d225cd197f..2e9646c97fb 100644
--- a/include/command.h
+++ b/include/command.h
@@ -11,6 +11,7 @@
 #define __COMMAND_H
 
 #include <linker_lists.h>
+#include <limits.h>
 
 #include <linux/compiler_attributes.h>
 
@@ -34,7 +35,7 @@
 
 struct cmd_tbl {
 	char		*name;		/* Command Name			*/
-	int		maxargs;	/* maximum number of arguments	*/
+	short		maxargs;	/* maximum number of arguments	*/
 					/*
 					 * Same as ->cmd() except the command
 					 * tells us if it can be repeated.
@@ -59,6 +60,12 @@ struct cmd_tbl {
 #endif
 };
 
+/*
+ * Use this as a command's maxargs when it accepts any number of arguments.
+ * maxargs is a short, so this is the largest value it can hold.
+ */
+#define CMD_MAXARGS	SHRT_MAX
+
 /**
  * cmd_arg_get() - Get a particular argument
  *
-- 
2.43.0

