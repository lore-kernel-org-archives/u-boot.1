Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69944E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A9B8033A;
	Fri, 20 Dec 2024 01:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EZUrSfXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D4680378; Fri, 20 Dec 2024 01:35:06 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3E68039A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a77980fe3aso5151635ab.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734654900; x=1735259700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPcOXl+F0DdVp1TvxLI0xT2GTtllzUyr5+SGlJ3FaA8=;
 b=EZUrSfXQ40KH2ORGJq6uKhhNGzEUbwEfuMb6urwmx0OLuLaUqZQLHBSoNIzWraP2sV
 Wzb4EcUzns0IwsEEKCleXYl+PdG8azmhFVhWDvf66D5PJXxhbEFf4SYBk4CSUFwkFkHU
 WWkSazKyDEFXH+p3D4TnFRGIlMdIbpeeAMq2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734654900; x=1735259700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPcOXl+F0DdVp1TvxLI0xT2GTtllzUyr5+SGlJ3FaA8=;
 b=xGRBgOJiZEpYIgj1Mlx8nd0uv+02xZ64xEBBrhMk50zzmxXIMS1Ikv9lcQQDbUUaYS
 9s1StGbSXf7J1+fZdkaiRjbK68actEVQoIQHxaVFWOpCyJ2XTfXEf+Obd3db6GTDmlil
 2Mfdm+rez/AXvApajsSfuKFbCAKpVKMYkKc4pa9H249+gpnr8ZMPGnX3fC/wN0NSyKCX
 ciNyC3XfRDaaraexAZKFuNlYHEEzmoByvjzeQmL8MJgRhNYDXQw8+rD0VbNTnXjhKWSK
 q9yx8z6M4qwSmwUCuW0CPJUe4qi2R0inLT0SZkii3Qdgza5xZDen/P4ETCQoh6FrRFcJ
 bMZg==
X-Gm-Message-State: AOJu0YyaqIEGBfqc070njGHPZv+XQfdaZUYb6QViKLAn9HRFwoq8VrZ5
 Ol02kLfY2Y9V7mKu6WAyrEebpC7AWhwzm93yr/+rILQ68+fPyH6+9OhIads4tE7g+EHtYNFGZkA
 =
X-Gm-Gg: ASbGnctSZdGjqPJoXoEbPbjx3uPYr1PGuqF4xP4VnZHctrDSZ8co0AF4Bhp1PP67H8e
 jaHFkqDdrMnRnhMOCdl1hgBQnUC3QGG1nvjzS8T1tJnarME4B1zaIQWyANiv5ll/NGbhXpd/mEV
 lN2XDPy6ekyTteqQtile4j3XQ//Vm1wZgD7UD6geRXcZWsc8PUakA1gmobBfy3zH1Bm2JOpQXZI
 blgwzjUMgd4HoponhV5SKfObyGkDLQjWPFnpc7Ucp/Zx4/x8NUE9+0fWrmht6cgEGNJZE4vAGl0
 Po/R0IxcUGs5Kah0iw==
X-Google-Smtp-Source: AGHT+IHrcaPisq5Lp/AZJ6Z2aySHo+ODwxcSw6ET69mHGlRDaF88eMJmMTpagcmsopdP55kMAmvC4Q==
X-Received: by 2002:a05:6e02:1101:b0:3a8:16c2:3772 with SMTP id
 e9e14a558f8ab-3c026e954f9mr43671245ab.0.1734654900275; 
 Thu, 19 Dec 2024 16:35:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c20bc69sm548273173.141.2024.12.19.16.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 16:34:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v4 3/5] rpi: Drop fdt_high and initrd_high
Date: Thu, 19 Dec 2024 17:34:45 -0700
Message-Id: <20241220003447.2913443-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220003447.2913443-1-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
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

