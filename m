Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D74C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 13:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4033487214;
	Mon, 15 Jan 2024 14:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vrm1CDX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 603DE875E9; Mon, 15 Jan 2024 14:47:28 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E2586EF1
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 14:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5FDA13F15B
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705326442;
 bh=hQElnugzimXxLUXyVZDcb/nfdx7K3xeN+mKLeR+X8gs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=vrm1CDX79buRwE9zNvbFW+NZ8f3o8GHcoNBtpaofjkQaxx6ia/X9lhuQ/kxEbQKUw
 opUOURpbh23iGp8WKp/c1U50/yeUX3mlL+eTE6sJukAuMM0TfbMCT2pRVCa+wStU3J
 sGPobAF3A4ivhNodOmLvsirpeMD2WFp7FoEiAz179+QUfRbXC2fJQjtVqEVQuwBRhP
 6cV8xObQK4nNQO77AlFiusNJBRzUoVAQUp3Vycl+ZoxVdvYffr0RcF8Q3u9oE1O8de
 ntChODNMVmFIUx4mA0Xi+fS6EEwwdGMX+oiGY4b92RhG5Up7+Lc7nzkTRfhCmSdO7G
 +Fnt9gGPQb6Sw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40e4f70af99so50866635e9.2
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 05:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705326442; x=1705931242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hQElnugzimXxLUXyVZDcb/nfdx7K3xeN+mKLeR+X8gs=;
 b=hd7pwCDKGymq/+Fnn5Pnoc13YGm6aM5Gv/AAE7efW91gKpAbkvkqWzmjTUb6Uv29+L
 LX4WR/VEltzzgS5NIEWnKbQDn1mcXT06GYmu7kVDzLZLdrDFSF2I2z6rpYLLBvT6Slni
 hLbmE6rTsH/HbNd+lqT0Z2zzLAlnL1EZc1NW6Kf6ZnnlFjYgXqwBNHBuYf2Sab/JpQIs
 xw28I9i54yO+JCmoVcdlyrl94u9KtIkZ7umBFGF4s/vFVQkNsOj9yvKjaP5hiY5Yus46
 LtHJbOVIChzFYLrRu4mRwd852F/jeveKR1Ytf1okiFdTqSlHgkjVqxSF0dsY8NM97jEj
 qHtw==
X-Gm-Message-State: AOJu0YxwiyftcS7wjgnOIUksUYw6WvOiRtUW7HGsJOQ2jEIPxCK4LyUZ
 fcJyE75XUtrjMXdC66XP+yHs6f/DkR69ESjM7Y9Vi/C8KFPnO0xud0M9WIjwasKgmdTpKxP5qq9
 5aaljijgrQlxMYX46b4NKWdrMEFTyoo+ZZKlrbA==
X-Received: by 2002:a05:600c:2e05:b0:40e:74e6:5f1d with SMTP id
 o5-20020a05600c2e0500b0040e74e65f1dmr1131789wmf.57.1705326441900; 
 Mon, 15 Jan 2024 05:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjovI5RUJO0GgAUveliFO52TgOTW9ux7JbVnyOtzs6k/keeAeN/3cWaLDZS/cK22i7WI8H2g==
X-Received: by 2002:a05:600c:2e05:b0:40e:74e6:5f1d with SMTP id
 o5-20020a05600c2e0500b0040e74e65f1dmr1131776wmf.57.1705326441526; 
 Mon, 15 Jan 2024 05:47:21 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a05600c355300b0040e76b60235sm4703281wmq.8.2024.01.15.05.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 05:47:21 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Yurii Monakov <monakov.y@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Harald Seiler <hws@denx.de>,
 Dave Jones <dave.jones@canonical.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: increase default for SYS_MAXARGS
Date: Mon, 15 Jan 2024 14:46:56 +0100
Message-ID: <20240115134656.50917-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The value of CONFIG SYS_MAXARGS limits the usability of the 'for' command.
The current default of 16 is too low for some use case. Cf.
https://bugs.launchpad.net/snap-core18/+bug/1910094

Increase the default to 64.

Reported-by: Dave Jones <dave.jones@canonical.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 150fa37a50a..4dbf89b7d71 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -90,7 +90,7 @@ config SYS_PROMPT_HUSH_PS2
 
 config SYS_MAXARGS
 	int "Maximum number arguments accepted by commands"
-	default 16
+	default 64
 
 config SYS_XTRACE
 	bool "Command execution tracer"
-- 
2.43.0

