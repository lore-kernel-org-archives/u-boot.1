Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2996C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C264D88C4C;
	Thu, 29 Aug 2024 16:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JV5iVOWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABA4C88C4C; Thu, 29 Aug 2024 16:58:30 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A86B88C86
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso3038725ab.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943507; x=1725548307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpY01vtWeQWV4YFYTzBjjbUmiD70J5DE6H5skAh2DVc=;
 b=JV5iVOWqsg/hlhbq9TX7WUxUSO3NJK9aXXqhS4w1fIOAABHI68nFbF4WBgaujXAEQz
 AGi6V3cn1/1QNlIVyU65cwXJ7bnr/Vp1lPUPzv/Hhyc78B/OUfxhWCT6DpXW/YgMU/4A
 5lMLRBvltf3G5ZruJpKF/lYA5R3BEZDCLidik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943507; x=1725548307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpY01vtWeQWV4YFYTzBjjbUmiD70J5DE6H5skAh2DVc=;
 b=aS9r1EjIlUiR9yMppk7PLk2Ll9FkvQQYjIMImoosGtsVSuw2seZHrLChhueHsdOUIQ
 CND9yGLc/f3sLDpLI1zZuwAR7KiN8glWXwVrYD6TtTJaM2xz0lxFYcSRw7MI8/DZVMLM
 tfFk/1o9FcA3hHDDZ4L9/CR48MyA1VYDJ8DnzAE4njWctFzwSoAWWDOiF1FXwGKwP7FF
 WxSfkv7eN3CwjInYYiqKty9VHcE2XcAeKav9reJkBc8ltfhnvuEyWhZBmJpKLrBhQtLq
 wODBibJKuf1qgXRwBPwWxBumlTi2rVc17uc84bpAh3itdabDYyUACdsYvKomttEV1q4S
 XFOw==
X-Gm-Message-State: AOJu0YzMkrdR2bYcqdfEXnBWWbMatFhVMhqIVCDYKTQ7gfDSNF8yVuC/
 dC5x9sxlGt0gBaUirUGS5rSTi0edgBHjsQiuRRxy7blnz6zlzsph/ieA1c0cMPbV1Y9MWeK7Y4M
 =
X-Google-Smtp-Source: AGHT+IElHByrCGST4KRkYU/7LbSly01d1mWSCZ8cNvxAbzPbJ22ToDYH8Dfy6BbbQoeyBl0xXNzZUQ==
X-Received: by 2002:a05:6e02:1607:b0:39b:649:f5e2 with SMTP id
 e9e14a558f8ab-39f3780c2fbmr42824825ab.13.1724943507131; 
 Thu, 29 Aug 2024 07:58:27 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/19] spl: Drop a duplicate variable in boot_from_devices()
Date: Thu, 29 Aug 2024 08:57:56 -0600
Message-Id: <20240829145802.1827952-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

The variable 'ret' is defined twice, which is not intended. This may
have been a local merge error.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 2eefeb6d893 ("spl: Report a loader failure")
---

 common/spl/spl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 5c687cfc73b..d60e60e708e 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -613,7 +613,6 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 	for (i = 0; i < count && spl_boot_list[i] != BOOT_DEVICE_NONE; i++) {
 		struct spl_image_loader *loader;
 		int bootdev = spl_boot_list[i];
-		int ret;
 
 		if (CONFIG_IS_ENABLED(SHOW_ERRORS))
 			ret = -ENXIO;
-- 
2.34.1

