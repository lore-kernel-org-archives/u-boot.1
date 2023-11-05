Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0065C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 20:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C21086F12;
	Sun,  5 Nov 2023 21:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hAPoH353";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29B386ED0; Sun,  5 Nov 2023 21:05:20 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3780086F38
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 21:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a66aa8ebb7so160173639f.3
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 12:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699214713; x=1699819513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57oi2LYbsfOK1d/bOdc4KMGSyNm1+YX06e1bIaxW4yM=;
 b=hAPoH353Re/dujmzt9TeGlteXhzRNocBPe6ulFTcJfgeNxyMvH1oixeQNEbZ5yfkwV
 Q0UxY2VYMlSprzzbuqw5Gk4Ro8lIJn2ypnKnikQTmEhEQVjvedUXEwZXVPOkzU/SU4zs
 Jb9ziBaQLq6YIIknclGUKXXpUEP4ifj28Vp9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699214713; x=1699819513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57oi2LYbsfOK1d/bOdc4KMGSyNm1+YX06e1bIaxW4yM=;
 b=xHZmEAs8NvFCe1Bqacgtxy4tlHyMTNZbIID2BYFWdNmK8sH/nEUON7QRriov6Hv6Rl
 Orvly7rhs1ojD7S0tbkLx58uICdgtBuWk9IHK17v/fGx64/jT2HsGySI1wmf7L2DzUbI
 PSTao6zNBcubgxeaE/o31QqESR4quoCq5CfuS0Q/6xJt4gUKJJMqT13BsyASOD7qgNKz
 XijjAH7ocf/rvpe4OnJI5r3MGurA+0R05PpkSYpxFW3coR3xan9wqtk5hAooN1eWhj2O
 EyzsaXijtK6KzrKQAIIAkiNHoNJ1IWn8E0kBYpvrigTgkjyAZAn8pPLaneoclRL/7J+p
 d89Q==
X-Gm-Message-State: AOJu0YwCj26jDEPIJuwTtqUsXXISWruK1d279tAP5Zu8qYWI44ie98oE
 VvNVfChn+/4CMzA3TmDeE+Bzmd12x46KcaKBUYf3Rg==
X-Google-Smtp-Source: AGHT+IHLp+bQGegVxcHyKvzqeO1cbBWmLRTITV7Qii+6iS1YB+EDssU0yEsi3FVkvhUxUG5k4ajeig==
X-Received: by 2002:a05:6602:2b85:b0:7a9:b1c9:4382 with SMTP id
 r5-20020a0566022b8500b007a9b1c94382mr35960686iov.5.1699214712791; 
 Sun, 05 Nov 2023 12:05:12 -0800 (PST)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a029693000000b0044d10eda3a8sm1685512jai.158.2023.11.05.12.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:05:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 3/4] image: Show the load address when decompressing
Date: Sun,  5 Nov 2023 13:03:53 -0700
Message-ID: <20231105130351.3.Ie1c352a32eff905cf333491bf3d7d315e25e3f31@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231105200453.1887418-1-sjg@chromium.org>
References: <20231105200453.1887418-1-sjg@chromium.org>
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

The destination address for decompression (or copying) is useful
information. Show this to the user while booting, e.g.:

   Uncompressing Kernel Image (no loading done) to 2080000

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index 88b67bc3a199..675b5dd77f94 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -415,15 +415,20 @@ void image_print_contents(const void *ptr)
  * @type:	OS type (IH_OS_...)
  * @comp_type:	Compression type being used (IH_COMP_...)
  * @is_xip:	true if the load address matches the image start
+ * @load:	Load address for printing
  */
-static void print_decomp_msg(int comp_type, int type, bool is_xip)
+static void print_decomp_msg(int comp_type, int type, bool is_xip,
+			     ulong load)
 {
 	const char *name = genimg_get_type_name(type);
 
+	/* Shows "Loading Kernel Image" for example */
 	if (comp_type == IH_COMP_NONE)
-		printf("   %s %s\n", is_xip ? "XIP" : "Loading", name);
+		printf("   %s %s", is_xip ? "XIP" : "Loading", name);
 	else
-		printf("   Uncompressing %s\n", name);
+		printf("   Uncompressing %s", name);
+
+	printf(" to %lx\n", load);
 }
 
 int image_decomp_type(const unsigned char *buf, ulong len)
@@ -448,7 +453,7 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 	int ret = -ENOSYS;
 
 	*load_end = load;
-	print_decomp_msg(comp, type, load == image_start);
+	print_decomp_msg(comp, type, load == image_start, load);
 
 	/*
 	 * Load the image to the right place, decompressing if needed. After
-- 
2.42.0.869.gea05f2083d-goog

