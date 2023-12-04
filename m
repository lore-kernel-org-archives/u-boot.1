Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FD8C46CA0
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B4A87898;
	Mon,  4 Dec 2023 01:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="efREUV3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3554878AB; Mon,  4 Dec 2023 01:30:21 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5DEA87655
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6cbd24d9557so3121569b3a.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649817; x=1702254617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SA+vlaviE3KZYMreLJQs/GLtT8Ws2+QqRpfSHtpo5Os=;
 b=efREUV3Y9LfwhuTEPe1u9s5I7j1UzIl1p9ZvtaJUbCXTcarTH4tvqwPoFg+bT2Cvr8
 Dy5be2IyDri4Q251fPQSnNK/+iqMkDQTthbsxPQLksly3ZTHQBUnc9Q71g7R0ehHmFLm
 y2NWX4mrz9rXNHPfKc4RdCRlrRqxyxhvLsh68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649817; x=1702254617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SA+vlaviE3KZYMreLJQs/GLtT8Ws2+QqRpfSHtpo5Os=;
 b=XbI48GuJ9ryoX0ATQhyjBuPp+SvIdzgNPGG60QLIlgVJBHe7GtjSy5BoCFhOYebqd/
 bSo7ch13StZBXzBbg/QWzPSzlJAjht01aoRB5aDcGPGtvkRtQeneauaQoUm9+v+dycb/
 Wgd3FHY1NnwTndnGOOen/HVVZmULQX++pzDM1eUsUMYEDpRONrv7zbN56fu5iZLyEW74
 C7p+H+6r9HzvAn3YyAvT3vJa9KtcC7FxP406aRQ577wIpod/nVI6iJgsPv4CAikkZBfP
 90xtxW93qhPcCKXJaxhxz1Hfal4GIM5m2N1WSUtEFE/JEGy97uxHIWkQ1Cv9M9GElPaH
 Csdg==
X-Gm-Message-State: AOJu0YwdcLAdPfvqmjbSvUyMDfNMwvIdFhwtx7xKz80WTBY3HG8SIdiO
 tQhPNusGfK14G7D9mxZUm+028VRj5dezaf3CzOl6lQ==
X-Google-Smtp-Source: AGHT+IEJLtKyPd0t6YDJuLPw5hQa4JouCp2dzxFj6ix2Aj3hcEp9v692bnk9FDZQV96h3cLn2kzt3w==
X-Received: by 2002:a05:6a20:ddaa:b0:18f:97c:3856 with SMTP id
 kw42-20020a056a20ddaa00b0018f097c3856mr3088699pzb.48.1701649817705; 
 Sun, 03 Dec 2023 16:30:17 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 06/13] x86: zboot: Move environment setting into zboot_load()
Date: Sun,  3 Dec 2023 17:29:31 -0700
Message-ID: <20231204002944.897949-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
References: <20231204002944.897949-1-sjg@chromium.org>
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

The only difference between the command and the underlying logic is the
setting of envrionment variables. Move this out of the command
processing since it needs to be done in any case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/zimage.c |  7 +++++++
 cmd/x86/zboot.c       | 16 ++--------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 1d1249fc25ac..b72e2f01bd57 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -370,6 +370,7 @@ int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
 int zboot_load(void)
 {
 	struct boot_params *base_ptr;
+	int ret;
 
 	if (state.base_ptr) {
 		struct boot_params *from = (struct boot_params *)state.base_ptr;
@@ -389,6 +390,12 @@ int zboot_load(void)
 	}
 	state.base_ptr = base_ptr;
 
+	ret = env_set_hex("zbootbase", map_to_sysmem(state.base_ptr));
+	if (!ret)
+		ret = env_set_hex("zbootaddr", state.load_address);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index f5c90a8ba896..d39ab6a9698f 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -62,30 +62,18 @@ static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-static int _zboot_load(void)
+static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
 {
 	int ret;
 
 	ret = zboot_load();
-	if (!ret)
-		ret = env_set_hex("zbootbase", map_to_sysmem(state.base_ptr));
-	if (!ret)
-		ret = env_set_hex("zbootaddr", state.load_address);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
-			 char *const argv[])
-{
-	if (_zboot_load())
-		return CMD_RET_FAILURE;
-
-	return 0;
-}
-
 static int _zboot_setup(void)
 {
 	struct boot_params *base_ptr = state.base_ptr;
-- 
2.43.0.rc2.451.g8631bc7472-goog

