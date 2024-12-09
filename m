Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEAEE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0598C89784;
	Mon,  9 Dec 2024 20:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IakGvpRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC7289794; Mon,  9 Dec 2024 20:55:42 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC0E8979B
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a9628d20f0so15077475ab.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733774138; x=1734378938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPcOXl+F0DdVp1TvxLI0xT2GTtllzUyr5+SGlJ3FaA8=;
 b=IakGvpRsD6RODjC6XFj+5Xznjjo9IbWQ1C/+I0o9WRyiXWilyF7v1oek/AFqcvPbG0
 1/qWoSEFeKOkg6XhHRJ8JX9Xrvy64N++XO07YoHyjsYcK4b4SIR50oBenox1WpqiHtsP
 pS1GHnObBOpN6hWSvkHBRvsxmHLxNTxCG4QV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733774138; x=1734378938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPcOXl+F0DdVp1TvxLI0xT2GTtllzUyr5+SGlJ3FaA8=;
 b=LQzVBVKFT8HBnATWY+cyHrBBK7TMfDdK4WPTW282BQPMmcL2u3bivD0h/mgT12yRJ+
 0FqOHAKqOzzSd/G39ja4kGLQfJeol2Jw5yFtZQKT/wF97NXDFaXK+PZos0yxoBHSNGLz
 orhMQTN0qwLXx+tONQBP7NbJtfeaEFtXNa52ifbmjT8XoiUqSh9JCdGzthg6yuSdV9gl
 Up+hSNRfAkw36ONljOh3HzRdSpTvjK7Q5p2HD3VvdYvomN4tv1kZk9e5Kx2IxaOMZdUM
 8SxPLffl8peNP2OE0Ce0W+x/NEcKqQ9jkZ5hDa1XgRjYrg0Pf0gBgGufz8N9F3SP0GJb
 irJA==
X-Gm-Message-State: AOJu0YzpRzpLX/UE9YTRrPHZn80vJj3mWSVPjYxnQeUXqWCzlT3PwvIr
 mYhNcUgmQllK6V9H0b9vJ30FwrkJjfyD4kK69Jz5QUy6Nyi0MlKOAr54Euws73zTRuyQf6UF5+Y
 =
X-Gm-Gg: ASbGncuPHnWN0NH2q9UvZKs69GkwrDVvhDCr4VH2OLgt6hwl8MLpZWGrsZRP+VU4BJ5
 gIGvOwuGEGWqL3ACREFecbWnBg56zK/z8FdBD1E4DGRo0FmnV1T+nz04qcxbelsdSP6pwF54+gB
 GiwoyHK02KPzDbLF0wdWmruF7X/fH04MoPedCL/hAd46QfYqXQqWqWzBlIkKWwGl8QYRHrcay7t
 7Q+dF85dGSflznp0FmMEHSYPYIBLTn0aGalG9j+vECf9byhommWk31KeKUqQA0nbNPqOUY/u3XI
 dvJFsYuYONHLTrU=
X-Google-Smtp-Source: AGHT+IGQvOCyKlKjNGJD9dXzvzyViSfSIRL5qMqokK8i+3RcMyaj7ZtXDAL+faFZeY/f8l0TO42Zng==
X-Received: by 2002:a05:6e02:1d1a:b0:3a7:e732:472a with SMTP id
 e9e14a558f8ab-3a9dbaba3abmr14993515ab.2.1733774138055; 
 Mon, 09 Dec 2024 11:55:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e286146f85sm2348941173.74.2024.12.09.11.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:55:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 3/5] rpi: Drop fdt_high and initrd_high
Date: Mon,  9 Dec 2024 12:55:25 -0700
Message-Id: <20241209195528.730260-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209195528.730260-1-sjg@chromium.org>
References: <20241209195528.730260-1-sjg@chromium.org>
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

These are not needed now since there is a bootm_size setting to keep
things within the lower part of memory.

Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Suggested-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Add new patch to drop fdt_high and initrd_high

 board/raspberrypi/rpi/rpi.env | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index a327fccc77f..9b9fad82828 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -66,13 +66,6 @@ dfu_alt_info+=zImage fat 0 1
  */
 bootm_size=0x20000000
 
-#ifdef CONFIG_ARM64
-fdt_high=ffffffffffffffff
-initrd_high=ffffffffffffffff
-#else
-fdt_high=ffffffff
-initrd_high=ffffffff
-#endif
 kernel_addr_r=0x00080000
 scriptaddr=0x02400000
 pxefile_addr_r=0x02500000
-- 
2.34.1

