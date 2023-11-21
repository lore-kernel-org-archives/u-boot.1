Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE718C5AD4C
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98D56875C3;
	Tue, 21 Nov 2023 03:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZHaGPwsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE5F86501; Tue, 21 Nov 2023 03:09:53 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FA987596
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b2e72fe47fso3507407b6e.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700532580; x=1701137380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAx0M3nnt1ntuAS6jySbDL3QnUikaUWXCJhipSMR8n0=;
 b=ZHaGPwsANknfP+A40XvYd8vn9ieShgBxwSg0WX90NmUr51pitnKcx/2LYvN+9N9PGI
 Cnx1Y98tkuX40f9JGfylz8nlNb4OQcFcdU9suaSR3W650f06lpe0B74Z365kAjtMpmd5
 GnEbdRK1LqD5B0PwhpYDc0WocYLmt9I7xGTCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700532580; x=1701137380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAx0M3nnt1ntuAS6jySbDL3QnUikaUWXCJhipSMR8n0=;
 b=qMFVyqZidkRY2bOPa+rfqgh+LfR0Zz6M9noYwlfdqoMvdzPabsTQn84rETcbIskKUr
 39guux6uN4KMTMAWtZWV4XCX79u5sF1RMCvZI2xWLuCe4aEpOdoay+Dh66BEO/aW4Pnt
 x6m0xezgjox/jFf3JYL9iNPtN6wvF3cJ27pSC8qAr/6Hy8ctrkjGYOr3t4KJwjKpwCHg
 zt8CmXzjtKQU5Dq4t0S8bjvgyWi9pCVDi4gA5ykjZcD3bTO/f8swJXGCyOnAxf+NXCoO
 iIGMr6hP8OiQ5xJh6k1w4CdShxyYFAzNJy1r5Gr26VAdCaAqORNHxDFjHJQffZjKv3C1
 S+SA==
X-Gm-Message-State: AOJu0YzNtqIjNrDsZfsD6kXdovCN3UACbS+o2PaCUpdVDh6HYEhP3BjF
 w+AW5V2SAHhhcFNaDahVos8At6FKXS84gxeNX5bNzQ==
X-Google-Smtp-Source: AGHT+IFMA0YDYwIVo6Vw04Sw0tX386slMt4OQVKM/Apqp1b849SjvA9ubHtYA017ch7TLrkpBFF0Rg==
X-Received: by 2002:a05:6870:8929:b0:1e9:96c6:e04c with SMTP id
 i41-20020a056870892900b001e996c6e04cmr10091931oao.32.1700532580477; 
 Mon, 20 Nov 2023 18:09:40 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 du20-20020a0568716e1400b001e12f685592sm1542693oac.13.2023.11.20.18.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 18:09:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/5] sandbox: Drop video-sync in serial driver
Date: Mon, 20 Nov 2023 19:09:29 -0700
Message-ID: <20231121020932.733405-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121020932.733405-1-sjg@chromium.org>
References: <20231121020932.733405-1-sjg@chromium.org>
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

With sandbox, when U-Boot is waiting for input it syncs the video
display, since presumably the user has finished typing.

Now that cyclic is used for video syncing, we can drop this. Cyclic
will automatically call the video_idle() function when idle.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Fix 'groth' and 'work-around' typos in cover letter

 drivers/serial/sandbox.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
index f6ac3d228526..be72fd2c65f7 100644
--- a/drivers/serial/sandbox.c
+++ b/drivers/serial/sandbox.c
@@ -139,8 +139,6 @@ static int sandbox_serial_pending(struct udevice *dev, bool input)
 		return 0;
 
 	os_usleep(100);
-	if (IS_ENABLED(CONFIG_VIDEO) && !IS_ENABLED(CONFIG_SPL_BUILD))
-		video_sync_all();
 	avail = membuff_putraw(&priv->buf, 100, false, &data);
 	if (!avail)
 		return 1;	/* buffer full */
-- 
2.43.0.rc1.413.gea7ed67945-goog

