Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7AEC3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D750888FC;
	Thu,  4 Jul 2024 09:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VsZgmU7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D4C4888EC; Thu,  4 Jul 2024 09:49:14 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A3D1888FC
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-424acfff613so2718835e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720079351; x=1720684151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLAe3+PdXcNntF6HHKEzTzB26YxxirSGeryH0nQjYqo=;
 b=VsZgmU7UNNHKDFYI0B1weUoS2Vlj9BDgD3VOImSnhWPfEl/3a+SCbAmMEye7vpo6N6
 KUDeWGYBEWT5ucFal6NBgh7xdWpU81aHPwy675PP9hjjeVeQ0rjFQ1oOcIPhmiCi7KLR
 b6VR8GcEo7dnf7um1Eyw5SsaciOLLAk7aWuiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079351; x=1720684151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLAe3+PdXcNntF6HHKEzTzB26YxxirSGeryH0nQjYqo=;
 b=Jkp03kzW+VJfA7eljD/8czpv0AuvLaxTdzSsTFWsiR4doHhYrWcj6/DNd4vDf1G9es
 4PI64ClRDgChUhWMU1oh+FtzIWHuRU4Xra4BbXEB7upML+shDpZoeI6/iiEg0M+cY1Dx
 v9oBDAk3Pq0f7vz2AYJjJEzCtRkSw7LKkFVz6fVdjsFRyHT+EW9R6edlut39Rf7MM4CM
 D4/aBAG1v4+46C1I65CNFI2E5CQuS4F1m2NIaaL6JZeJybH2lPpT6AycURy2WyZH7KzL
 B5KvnriHY896YY+QT1MRA2A1R9C2KraicfMfctyrvSwakma/ZwT1QCrMIGKjU4qBqw8U
 welg==
X-Gm-Message-State: AOJu0Yz3YeyxWrkkrJ4HfWuF1BKv+HW2pkBVZ9e77RcjUzl0IMpOmuue
 Zm3rOS6UQ6eDqmhipC98Wy1bSEZ23ht0Zc94t68ZivhGIncYIYM/G/1UDHsU23ttSGkqO/nihtA
 =
X-Google-Smtp-Source: AGHT+IHjLUAnJiXiymbhCTVVVaNH1/Oyyst4pIijEXEgOeQc4NjRzQOAlU+UH2O6lwCrMYyylDR/jQ==
X-Received: by 2002:a05:600c:4205:b0:424:aa40:88ae with SMTP id
 5b1f17b1804b1-4264a3bc392mr9528655e9.3.1720079350800; 
 Thu, 04 Jul 2024 00:49:10 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm12885515e9.32.2024.07.04.00.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 00:49:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 5/5] sandbox: Drop video-sync in serial driver
Date: Thu,  4 Jul 2024 08:48:59 +0100
Message-Id: <20240704074859.2956745-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704074859.2956745-1-sjg@chromium.org>
References: <20240704074859.2956745-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Fix 'groth' and 'work-around' typos in cover letter

 drivers/serial/sandbox.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
index ec0068e33d3..77a1558db68 100644
--- a/drivers/serial/sandbox.c
+++ b/drivers/serial/sandbox.c
@@ -138,8 +138,6 @@ static int sandbox_serial_pending(struct udevice *dev, bool input)
 		return 0;
 
 	os_usleep(100);
-	if (IS_ENABLED(CONFIG_VIDEO) && !IS_ENABLED(CONFIG_SPL_BUILD))
-		video_sync_all();
 	avail = membuff_putraw(&priv->buf, 100, false, &data);
 	if (!avail)
 		return 1;	/* buffer full */
-- 
2.34.1

