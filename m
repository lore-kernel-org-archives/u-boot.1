Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF5CD4A5F4
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 12:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F62E8307F;
	Sun, 18 Jan 2026 13:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="k0G4v2tE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5443C8313B; Sun, 18 Jan 2026 13:06:21 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5880D82BF2
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 13:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E66EC3FDEC
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1768737977;
 bh=NjBqR83t/AIKxqnCQ4DqNYpyTOQFhCzTfSVCuQ6cMUk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=k0G4v2tE1qC9q8oIE455UHyxpmrsAZ7F9PCdSGc/NEBxtL8OaV9zJ/tq/X32bR4in
 zjkXoC1dRWJ7A/6n2t8VEnQddp6oSk1F04scSIRjDFriCqIWIUylElNGvc6Znhtukm
 xHhkjv2zA7+2n9HVYQ2R2s4NSkA5qGF86VixHVIDRir4tRQgDTLjSG4JN8yNJdyPs/
 M8kK+0rgBH7Q7W05ydnow3ean2VvBS3/sQgV2tPa8zBsDN2l9F3toNa9OKnnHIqh7m
 aa0ExSqZELjgTt+Li00+ArFrMAzu6oCMBQftMa9KGBl2mRLgvC+VgWWhL+co2fXLyG
 vrTbDp8WzjekzhF6JTc9hDV+OVKpDs/Ul8c/UX863DPS/0ggtJxhDNPiiqVZHbLc0w
 jJaRpTSBG9HzJbbUAfXicQQggr435TRhYMOp/1Ms4i/qybbZ1SP9lpE5tITsvbCtOp
 hLL7ArZUKl33+Grcn4a7SnrUEETV2y/PA6WkOx/9Xv5BqMeIpYhr2AYMsLts1ld7+R
 f8ksnOFf2G94/fhtrE4lsI31AvQK0o4CsbM/P7gY2Ny6HW0Gf88XB9K4EczFotS8cD
 9bh0Dsv68pRSf82c3e9sCe5Mb0wS1VZW0Ok9nO/mRYaSXallDJZff4V7UdbJiG/E1B
 8SKNdY1D1/6epUuWHXc1F6A8=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47edee0b11cso17320925e9.1
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 04:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768737977; x=1769342777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjBqR83t/AIKxqnCQ4DqNYpyTOQFhCzTfSVCuQ6cMUk=;
 b=gtELWLG02SICLB3fpbjHdkNBeLGc2zp+2ljh1iEWmWu8M3OPxRIvG8oSszV0aQjxCH
 FslGUxDqLHJl0O59uvsyGGmR+YdWQwT8rkR0DlAILK7a0yBvtfqDhITkzoz+r8QPwHZo
 7/m82NPLv8wd+Y4txXHAHhOgXwST6JxsCKlJNi7eSxU9wG+X1Q6oQtbZIqIMh5eDSVXj
 Qdd3zjjZH0thwHT5vXHUtPCXJWsdxfi1aDDRqOHvNdgRuwP6mMi8rDq/yi7wjSmV9jtl
 Q/sScCX/7JXTYjUMjI45iilgIZnxQAD7TmH6MvdoH8iaMlIl9AkwoBOVn7fNOEDKXLtg
 tYQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKeycWDwmQj+FC5b/cnvtX7UGttZHftJ73P1LOMKjANMtMsKQ/pIIltjKd77gx3P9N4ZFCbeM=@lists.denx.de
X-Gm-Message-State: AOJu0YyfvbvbDGgQu9ge/1HratJCXRan4Ox6PPW8Y0iImcYZxIsnbyyo
 sdP7EViFeocxUtqR/drOTw9OuT6aumoa/37xZy9i/xK7qu20An4kZdiCaquEeWGxxy96PIO3G31
 uaQvNftS1LWpAoYH6mPxKQSAE9LivAdnbFTPl5q/s6l6KbcaL4d1LjUePCW8PFukexxy6RC0vXz
 V93p8=
X-Gm-Gg: AY/fxX6Lmq4h2Sw2QwnWVbStNSVS/HYA6qL/BOq+cZdI71uDyHEzBIPXQTz9SxX7M+r
 60SG5ebzdHujTaJqs75lV/XkXr35kZfehbAsfSD9BbHmZGBijR2NcPF/HPpo1tzCsyuNhw+/XKJ
 G4p89qK2AeT0nDGQOGv9ig05IdF4KLVuZyZWIBMHCcv/Id7gh9uxBKpVb3E4oiy5I9ssyLyNIp4
 LSi2SLtq9SVPi+uVki2MaKLYIObRWt8x7GFggSl/1NIvpwpZi817tDMWR0NYXSLU33CmeVocMkR
 P2QNiwChvOixz3QWhnI32kU8yHCxyD1yuS9YVD5Hw5kkNqyDgU7HVKSUfeRpBQGt9zuMli2pSj2
 X6b4jlkse/wtV8DesCGy+33wA0d7J9vLG
X-Received: by 2002:a05:600c:3b84:b0:47e:e575:a33e with SMTP id
 5b1f17b1804b1-4801eb14eb8mr93986375e9.33.1768737977454; 
 Sun, 18 Jan 2026 04:06:17 -0800 (PST)
X-Received: by 2002:a05:600c:3b84:b0:47e:e575:a33e with SMTP id
 5b1f17b1804b1-4801eb14eb8mr93986195e9.33.1768737977095; 
 Sun, 18 Jan 2026 04:06:17 -0800 (PST)
Received: from workstation5 ([2a02:3037:6ee:7719:df76:1721:7535:ce35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999810bsm16731734f8f.40.2026.01.18.04.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 04:06:16 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <e@freeshell.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: expand on JH7110 boot select switches
Date: Sun, 18 Jan 2026 13:05:23 +0100
Message-ID: <20260118120523.13724-1-heinrich.schuchardt@canonical.com>
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

While some boards have separate switch RGPIO0, RGPIO1 others only
have a common switch.

Describe the restriction.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/starfive/jh7110_common.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
index 77102fcc189..14ec556ab13 100644
--- a/doc/board/starfive/jh7110_common.rst
+++ b/doc/board/starfive/jh7110_common.rst
@@ -237,6 +237,11 @@ RGPIO1 RGPIO0 StarFive loader function @ 0x2A00_0000
 1      1      UART Serial XMODEM loader
 ====== ====== ======================================
 
+While some boards have separate switches for RGPIO0 and RGPI01 (Milk-V Mars,
+StarFive VisionFive 2, Pine64 Star64) other boards only offer a common
+switch (Orange Pi RV, StarFive VisionFive 2 Lite) or control line
+(Milk-V Mars CM). Here booting from SD-card or eMMC is not possible.
+
 According to `JH-7110 Boot User Guide BootROM`_ the StarFive loader code reads
 content to SRAM @ 0x0800_0000 from different media selected by [RGPIO1,RGPIO0].
 
-- 
2.51.0

