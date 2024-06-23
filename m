Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD44C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D1588585;
	Sun, 23 Jun 2024 22:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ko4ZJN40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2998187D10; Sun, 23 Jun 2024 22:30:50 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D26BC882E2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eeea388a8eso146538139f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174646; x=1719779446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKYwqY+IHEHV9jkrjdhvX/VMk/xHorMv05GeBADBFuk=;
 b=ko4ZJN40Mp5Iwuj1trIRRsnARLlxRCM3IJU3NBPALyQD1KiPfyAnyrj6EDdfQJjkwe
 K/owbsdtyxX4CfFJXqCBf7h56jOrncFu4CmPNG9R/Uito1y0LlsSPH/PtZkYJspYbM14
 4M2sfo4irA2Ef6oTLyKW1lDX3DpuQnmZu6mYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174646; x=1719779446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKYwqY+IHEHV9jkrjdhvX/VMk/xHorMv05GeBADBFuk=;
 b=iv3G+g4BWIYBQMzK4XFCuAkuUQZBK4LAsNg5CCoPfH0mD72JcaLqdnJiGvsQkOLarU
 btAtLq2FiGzcfOLS90eKbHcakA6WRO23GlaJDqUeElB36UlXPgeFiL6YO8lB9nyGHvJq
 8u0hvVvEubqgz2Vm6s/6wAq9x02gNMmX0hnrzgYJGTZJC2XDpUnU/mK5MhK3Tk8j1lxl
 S6NY+HacvOypQGx6XN6aqFx3a6E1+uk36rqXZOLGPhiODhiBpBYhnnS5nS42wcQXEVfU
 XB2Z0mskpvgMKXzVJIEIe5fZ3j7vy+odPpt6jJAMzU9NgZ66CNR+IdJfskoduyyB1WZY
 Xg7w==
X-Gm-Message-State: AOJu0YxnY/TvYa30DdX1yeRUePzhp3iQNaRAUwYnpUY+RG9Q8d8NFNfV
 43UktriHAAdELQeMjKXiZ8GmQYUfMg7vGi00w8ASbqaUlntXE4qW20Pr4WXuCNu7MQ1A3ec3ww4
 jEQ==
X-Google-Smtp-Source: AGHT+IFmsqnOC1l9fB2kPG/9PcbB9g5Phr21vHOPhyUCufGg7CbhM9KpEFJRpTCzLUvlJs8NQN/XMg==
X-Received: by 2002:a05:6602:1481:b0:7f3:a80e:8cf5 with SMTP id
 ca18e2360f4ac-7f3a80e8d73mr293847639f.1.1719174646561; 
 Sun, 23 Jun 2024 13:30:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 13/14] Update u-boot.cfg to include CFG also
Date: Sun, 23 Jun 2024 14:30:32 -0600
Message-Id: <20240623203033.1566505-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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

Some configuration is now in variables with a CFG_ prefix. Add these to
the .cfg file so that we can see everything in one place. Sort the
options so they are easier to find and compare.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to update u-boot.cfg with CFG_... options

 scripts/Makefile.autoconf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
index b42f9b525fe..65ff11ea508 100644
--- a/scripts/Makefile.autoconf
+++ b/scripts/Makefile.autoconf
@@ -71,7 +71,7 @@ quiet_cmd_autoconf = GEN     $@
 quiet_cmd_u_boot_cfg = CFG     $@
       cmd_u_boot_cfg = \
 	$(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.h > $@.tmp && { \
-		grep 'define CONFIG_' $@.tmp | \
+		egrep 'define (CONFIG_|CFG_)' $@.tmp | sort | \
 			sed '/define CONFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
 		rm $@.tmp;						\
 	} || {								\
-- 
2.34.1

