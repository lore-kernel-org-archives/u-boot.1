Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A02CE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A8B989771;
	Mon,  9 Dec 2024 19:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FTpJa8a0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA7989753; Mon,  9 Dec 2024 19:20:17 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E03E89466
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 19:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a7750318a2so32532365ab.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 10:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733768413; x=1734373213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gL5979ugL1xb0eTwkMc1VXcnn9/wgfKBODlC47evQw=;
 b=FTpJa8a0kEqw31559/0XEc/cPWxP3nKyJED7vSOgZcrf2uKsaAppMfOp6GQhfJj1F3
 No5hCTi6/uPIE0ygZfPHpIkgxHIO0tlqadKTwpWUt87cEmiAVlCinmnkLh8pk57Sg7yx
 hB2zdTn3N5aGon40XSNA1m0X4n0skxIELi8Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733768413; x=1734373213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gL5979ugL1xb0eTwkMc1VXcnn9/wgfKBODlC47evQw=;
 b=YkTyMENSL1RNOSTZdcYl38ahPM3I68YK8shjouyZ7ScB2WxXnqnZiMwtgFsjxQf3a1
 7MtAsGFfLwF1+JAfZv+lYtT6VJitAmb1zThizyms+w48xsPR8ut0n15jadkV9m4izxDk
 4Z5bpXK8xTRrWq93/5yzRHtNo3wZaO+JiO20a1wCkvuqN4w8+3fTMiZM46fsfgkoamcm
 lTgI34yWH4F/904HFK2UCE9b244EwPd8r6L4X+mHD74e8ZQ3BoKunFiqnKS7Aj5gigt0
 /eyTtmDWcEPUYKNKH8FfuJUEbJznECS1O96NHKeJUbvuS/d7XqCFTYunQMKnRwUa6oLU
 oRkQ==
X-Gm-Message-State: AOJu0YxvnKaypjSzcRXJnO+SR28YCLuJR1Ybo7+ph/tyimdt4T29YVnk
 yrB8l/lPRwkzB/4Z4GZdGuPASnqA2ZbSkbQ0b3k35aYrsNpvgyPyPMB24YTP8a/1AWOQWNSXQb8
 =
X-Gm-Gg: ASbGncvBqC5qsmdp5kWJB7s/7mIFhJQUEGOjwod8oGZdAQ4oLT+4x7hSQyFpf124uBm
 IS4Cpu7zxS/VzEtt0dhNlWoynAs/gc0qCBpLGx39b/kQS4MHFF528I2tpeEPrkhFMyzAtFyFVUo
 6Bb/sKRDP797IPj/6tUd7vZQCGGWc+DZBAohBI4Z32vanvP6OxVfdqtYqI2XVizdLXnY4C7tI8D
 oBpRm6WbHy7H8t/zohP2YlWm4zfQ5wK5A/VLcoSmVSEFM54kE4erDKA0M8hBi2Lp5TFz8NMSeY1
 9OLpZxkw4d0=
X-Google-Smtp-Source: AGHT+IH6Sw2ULQ85zgPWidlwttOwp0GnbSHTPDXFaBqKfMCwTkQdi0tQD9Vic69Y3nOKpQhDogEE8Q==
X-Received: by 2002:a05:6e02:20cf:b0:3a7:4674:d637 with SMTP id
 e9e14a558f8ab-3a811d7716cmr166625705ab.3.1733768413195; 
 Mon, 09 Dec 2024 10:20:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d8845sm2390429173.83.2024.12.09.10.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:20:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 2/5] rpi: Set bootm_size to 512MB
Date: Mon,  9 Dec 2024 11:19:58 -0700
Message-Id: <20241209182002.671953-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209182002.671953-1-sjg@chromium.org>
References: <20241209182002.671953-1-sjg@chromium.org>
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

Set this option so that all boot images stay within the bottom 512MB of
memory. This should allow us to drop the fdt_high and initrd_high
options.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Add new patch to set bootm_size

 board/raspberrypi/rpi/rpi.env | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285edd..a58ef38b1aa 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -61,6 +61,13 @@ dfu_alt_info+=zImage fat 0 1
  * only 64M, the remaining 25M starting at 0x02700000 should allow quite
  * large initrds before they start colliding with U-Boot.
  */
+
+/*
+ * limit bootm_size to 512MB so that all boot images stay within the bottom
+ * 512MB of memory
+ */
+bootm_size=0x20000000
+
 #ifdef CONFIG_ARM64
 fdt_high=ffffffffffffffff
 initrd_high=ffffffffffffffff
-- 
2.34.1

