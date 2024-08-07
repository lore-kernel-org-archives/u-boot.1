Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF3FC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B4C88B57;
	Thu,  8 Aug 2024 00:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gFQvIxdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B2A888CF; Thu,  8 Aug 2024 00:48:21 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E2E388A65
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39641271f2aso1427275ab.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070898; x=1723675698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uL+Mo7zDnYq8QcayVxxmVZvVDuZ5FFJAov/B/dJaoks=;
 b=gFQvIxdCeJDZgs/M0aQtv7XE4QF6jpKmnHil+9zoXFDmPlOWCSUG7iuHVqMzgGV4zm
 awM06NgFJ6mnXe5aFhXrf8gWKz9QlgX/whMVSV6f0fLo6XLcdtpsRfphIV5IiTK5zrl6
 L38fobdMhsSo7AcKI+Sd6AdOpJbVmCCzJ5wF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070898; x=1723675698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uL+Mo7zDnYq8QcayVxxmVZvVDuZ5FFJAov/B/dJaoks=;
 b=UzOfk/30FvuhBCxHOWpW1/HNVF6xVyL7klqcH8IddqT+08kh/anetcC0XPd8sJzX9t
 hQhCrUlLTDAzYvDoDFex5kC2N+Wggpbg88XO4vTLAbvDcSrOoi416btFhcKTa18anGki
 Wa+92dEf6w+cLrEQyQfP2t0jZQAGnYXaji8a9AarpaIagwyfzExuPX+ognpfhzDLpDst
 aL/lVDaiZzl+qnLmOrk205Kjxw22OF3rbj9GfiCkKoqDmHFmx2zz1GZ4VrlgRrrD4oJj
 zD4rPZpIMeRjzr63XEPGXwu750hN6cugyG4ygyJuWnbgscPDIT+C3OjVBZVf9GgDewyB
 PqDA==
X-Gm-Message-State: AOJu0YxOGn71Rf5WiCTGV2l6JlrkmRIo34s9sVbf+ZVW8TLtowG3oZQl
 Q/DR3Es5thRHG9bHekLlCut/L94t7SoNKa13WdA/5w/zq/CqznEd+eDIVGkPpA6AuacQuQbMaOU
 =
X-Google-Smtp-Source: AGHT+IFScUGUrSxCDU7kCRmqNP7So7mgf47A0buluDR5QSowFgeGflFHKW7pWwARA5VBYUEdOTF3IQ==
X-Received: by 2002:a05:6e02:1aaa:b0:39b:3a44:fe8a with SMTP id
 e9e14a558f8ab-39b5ec64cadmr1121495ab.4.1723070897712; 
 Wed, 07 Aug 2024 15:48:17 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 16/21] upl: Plumb in universal payload to the init process
Date: Wed,  7 Aug 2024 16:47:34 -0600
Message-Id: <20240807224739.3858517-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

Read the UPL early in boot so that it is available. For now none of the
information is used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig     | 12 +++++++++++-
 common/board_f.c | 22 ++++++++++++++++++++++
 common/board_r.c |  2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 60a4cddf5ec..7ac34574079 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -763,7 +763,9 @@ config UPL_READ
 	help
 	  Provides support for decoding a UPL-format payload into a C structure
 	  which can be used elsewhere in U-Boot. This is just the reading
-	  implementation, useful for trying it out.
+	  implementation, useful for trying it out. See UPL_IN for how
+	  to tell U-Boot to actually read it on startup and use it for memory
+	  and device information, etc.
 
 config UPL_WRITE
 	bool "upl - Support writing a Universal Payload handoff"
@@ -774,6 +776,14 @@ config UPL_WRITE
 	  for how to tell U-Boot SPL to actually write it before jumping to
 	  the next phase.
 
+config UPL_IN
+	bool "upl - Read the UPL handoff on startup"
+	select UPL_READ
+	help
+	  Read an SPL handoff when U-Boot starts and use it to provide
+	  devices, memory layout, etc. required by U-Boot. This allows U-Boot
+	  to function as a payload in the meaning of the specification.
+
 if SPL
 
 config SPL_UPL
diff --git a/common/board_f.c b/common/board_f.c
index 29e185137ad..d71005d9f83 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -40,6 +40,7 @@
 #include <sysreset.h>
 #include <timer.h>
 #include <trace.h>
+#include <upl.h>
 #include <video.h>
 #include <watchdog.h>
 #include <asm/cache.h>
@@ -859,6 +860,26 @@ __weak int clear_bss(void)
 	return 0;
 }
 
+static int initf_upl(void)
+{
+	struct upl *upl;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_UPL_IN) || !(gd->flags & GD_FLG_UPL))
+		return 0;
+
+	upl = malloc(sizeof(struct upl));
+	if (upl)
+		ret = upl_read_handoff(upl, oftree_default());
+	if (ret) {
+		printf("UPL handoff: read failure (err=%dE)\n", ret);
+		return ret;
+	}
+	gd_set_upl(upl);
+
+	return 0;
+}
+
 static const init_fnc_t init_sequence_f[] = {
 	setup_mon_len,
 #ifdef CONFIG_OF_CONTROL
@@ -868,6 +889,7 @@ static const init_fnc_t init_sequence_f[] = {
 	trace_early_init,
 #endif
 	initf_malloc,
+	initf_upl,
 	log_init,
 	initf_bootstage,	/* uses its own timer, so does not need DM */
 	event_init,
diff --git a/common/board_r.c b/common/board_r.c
index d4ba245ac69..f445803d7a4 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -521,6 +521,8 @@ static int dm_announce(void)
 		       uclass_count);
 		if (CONFIG_IS_ENABLED(OF_REAL))
 			printf(", devicetree: %s", fdtdec_get_srcname());
+		if (CONFIG_IS_ENABLED(UPL))
+			printf(", universal payload active");
 		printf("\n");
 		if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE) &&
 		    (gd->fdt_src == FDTSRC_SEPARATE ||
-- 
2.34.1

