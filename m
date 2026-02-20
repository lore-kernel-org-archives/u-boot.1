Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C0CC56203
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 14:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DA283C39;
	Fri, 20 Feb 2026 15:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aZeLeWPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2E583C39; Fri, 20 Feb 2026 15:33:20 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D2783936
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 15:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B6D73F659
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1771597998;
 bh=RCXjaK5lLuWKDjQVoFNPTx9BwMMnaBw39mCBluvnpRw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=aZeLeWPV14Hj5sukBVw4b656koVwir64AVkUEOO9nFOntzhK3vdOi9oUp6F8RYcHl
 Vj+f1JT0LPivYBF2wNUTPoSdE0amzWDek3eme0BUhLvdo05kPtSMrWIUO5XNRBCMcF
 0x5VdaIuRROMnhwyGruSkQvrHPrZNGg9oF6ZIAEJm4yrgjPYPMuqkr6wgat5px9TjP
 RRzWlAHuM939XM1DqnsKDW3FryzTdh1MRTnGfAc+ptM1HY0XiTg6RZOP98kxTry4WY
 cieOX4Iu/LZVLOsMbsSBrWEEW5tkrbmQc6E4JvOzzQKNl4qgYensftg2T7/6br+j+a
 iO8lm7f+fBAwUQro24tSzfqQ5nY3/Z5mosNv6A8PVeJy64hx7b6g7zd3HporYESlVm
 3/jJus5XqVe+uIMe9494lcK09Mcp+Wbg7OI2Eh5H6oNNxDyG2FEqozVEa/VsMeog7E
 D0QtNk6mfxadllhek/Ya5K9FYnT2ZYjvcGQEjDZW6pIrQ5MGg37XNMnWdzEa9V/RVT
 YiZhCBwqdaFeMFikTCHKcNYpoJqAMRZK0Sb996SU1/TsAEurrv40hDe2PuBcl0vAkB
 XhoSO4rBbtVLt8qNHU6HiiP1rcP3eY7zfWtQsXNdRVNMBy4AaEsR/Ods05QVpfV/FY
 utI3IW+x9PtLdBYugtk9h46U=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43630b02fb4so2141022f8f.3
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 06:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771597998; x=1772202798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCXjaK5lLuWKDjQVoFNPTx9BwMMnaBw39mCBluvnpRw=;
 b=Iv7rjz2TZCW84+wUQ4vnDlbAmyWflBQdfquNsdoGZLROBSjgEXwTttkGRGQLQi6GkU
 dnSRblg1Vbwai5xRW6UQiv8RNdaTjL0v5HcfFNTYp1WcCYolHe824RBL1cc8kbLZOCYG
 N73DhXZAMa9E62bqI2eZkOD+vNwTUnqXvvy6ftH7Gs7UbVf9KsI+rokEPOtWOMP5A6gw
 9piUvEBh1r5ROIL/Fx+3Vh/yZVVFDeEln3WP4DAJLfSWH79ysRuWWCI7qm3ET+yk9WHg
 e8Wr4MtHeB77IBfGfVqz7kS+Q0dqr5SGnWj6Cg63gPQ4TygQbttuglGUYIzVEeAUs9H2
 vsHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUibE0+SNBsYMG/NkeAkbHsuOCcum745Z8c94ZfZjSeJ7OLVd+iaY3xGvhZCtVmupYpHWx3IPw=@lists.denx.de
X-Gm-Message-State: AOJu0YyRigJWuNSCFsBeBPahgR4B4youjlf7x/5E3f2pD88dIlZPjJa5
 VVhUnI/rYeFeReqEaVRmmB3BMSyoQNUdRz+YvF2nEE6WEpn5IdRtU09ORClVULRpojrkqQFa5Kt
 GLTPaFAtKO76PihQ62neTt6IaQcdonsEOqcl9MbdMBB8NTJitSLRB7nT8ZlxpOAlWUKEsC/c=
X-Gm-Gg: AZuq6aLbRQXFWLHtM/vq+XFDx/DD+9S4XzofegSwm2aQCPvn8R8W3M9gDf+ENsDFt9U
 /ecS1+WuepJKYrYQCY/EfAcpFF+p5iiD/K1kF/7EDFPJeqLuwp7V+cK4VA9gxDpntViYUYTwjZ3
 kLYte3lT0oKcXkCLCNAdhQINpSXK5bX/RF1XP4GlIf+pjzOjRQk9TvpwK74S6qYecgOiDmmlcVw
 qOhQu3LfFr77Y15OhRKu8dgyA1nIpqBnQ/cHtWMqVw+QkzZ9feTlWFE+W0Iknp6tYPINV08Stfg
 NYG4l7NQuYtY+ze8+sNpVUXF1Xdfffk4ixHYq+bCk0Pw4vI1PA7XML4Z9VAdj/GlWsDIX9uO1pL
 cMiI+xnenN5Yw+1ldLwKhtRftZzB6ZMaFTvUcm0X8XKHDsXMbEgpkQhC3SrwzAIBynWBTHnveMX
 YlxwDEBctql2q7JeJoIHLxb1raS4DLgryL0HPDLu2KIoFr
X-Received: by 2002:a5d:5f83:0:b0:435:bcbe:d104 with SMTP id
 ffacd0b85a97d-4396f17c94bmr173937f8f.34.1771597997956; 
 Fri, 20 Feb 2026 06:33:17 -0800 (PST)
X-Received: by 2002:a5d:5f83:0:b0:435:bcbe:d104 with SMTP id
 ffacd0b85a97d-4396f17c94bmr173882f8f.34.1771597997513; 
 Fri, 20 Feb 2026 06:33:17 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac800esm59646283f8f.27.2026.02.20.06.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 06:33:16 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 George Chan <gchan9527@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: availability of command mii for NET_LWIP
Date: Fri, 20 Feb 2026 15:33:11 +0100
Message-ID: <20260220143311.36196-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

If we are using the legacy or the LWIP network stack,
should not influence our decision to provide command `mii`.

Let BOOT_DEFAULTS_CMDS imply MII if either of the network
stacks is available.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index e5db165424a..3f8f3e7cf35 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -435,7 +435,7 @@ config BOOT_DEFAULTS_CMDS
 	select CMD_PXE if CMD_NET
 	select CMD_BOOTI if ARM64
 	select CMD_BOOTZ if ARM && !ARM64
-	imply CMD_MII if NET
+	imply CMD_MII if NET || NET_LWIP
 
 config BOOT_DEFAULTS
 	bool  # Common defaults for standard boot and distroboot
-- 
2.51.0

