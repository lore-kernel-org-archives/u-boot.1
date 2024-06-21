Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA92C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C71886AA;
	Fri, 21 Jun 2024 21:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R9lEgfIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D797E885F1; Fri, 21 Jun 2024 21:52:45 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB9828863F
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7eb7c0f9784so90895139f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999562; x=1719604362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKYwqY+IHEHV9jkrjdhvX/VMk/xHorMv05GeBADBFuk=;
 b=R9lEgfIG+1lc+MyJ2WwcLVgPzttGHOigce4RHd87t5GSxm+xKJRp8oa5oucz2EzIP8
 HA4SMs/YB/vvRisA/UA+8I+sdBSypicIuR4B0K6LbMxmoVGTq52gadJMhrb6ezZxerl4
 OW+QjqxILaB53uWtIwJrMAZftY2Lyf2goNQI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999562; x=1719604362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKYwqY+IHEHV9jkrjdhvX/VMk/xHorMv05GeBADBFuk=;
 b=W3CDlT7G/4JP2ToK4zjDAve+ggg/Qrp7NjnZTOx/iT1Y+yKDW1r9O9V+I9eTFIfCMv
 WGL3FnHWOV0EPO+3392jPHJ3WTFZjf+49mSOc7I0nPAzVrfl4xvT/gwSZY7PYU0PlHny
 PpRlJwSrnSeMbH39xjbRLPzyyGx9X1sl1luAPg2zPWHhcq0F/t/1s5gqugCHtrcLPU2q
 nFQ66Qzt2CAho05ZpYlolY947bS7C1UHeYT30M3piKanYfUFKe/vM+r8yR6DSTk5eThq
 fq/9R00+dJjJ9d5B5uRPbMrW5XTy2jjPol0cDlMFE6j0Ne7vv4riH0jWOnBJDQuZYfhg
 I+2A==
X-Gm-Message-State: AOJu0Yy3WG+LPnX79d4YV42Eumiekt7kDiyNxsbvnz2vFUbRKyokl0Nj
 X3zOg50FkSIbjtm+sDaY4Wz9FAiuO+ZH0G+JbSItvQRFz0F34RrHAUY8VpTRVk6Uh6oGkBWMest
 F6w==
X-Google-Smtp-Source: AGHT+IF2lAYv954YtaGtjghWrCb2eRvpirew9w4GC/av/XoJdfNy2/sQPLOgRrabyv3fzF5u9Cu8xQ==
X-Received: by 2002:a05:6602:1508:b0:7eb:c7ff:26e6 with SMTP id
 ca18e2360f4ac-7f13ee70710mr1056485939f.15.1718999562469; 
 Fri, 21 Jun 2024 12:52:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 42/43] Update u-boot.cfg to include CFG also
Date: Fri, 21 Jun 2024 13:52:03 -0600
Message-Id: <20240621195204.2675252-43-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

