Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09AAC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC4D8701F;
	Sun, 19 Nov 2023 15:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W72sPJMt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D9D087076; Sun, 19 Nov 2023 15:43:54 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B2486F45
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a67b9cd230so114907939f.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405030; x=1701009830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BH9FKZ07kT9BsFm6ZBRRDTcwHFMHq61a+jIOk++gmJA=;
 b=W72sPJMt56Rk32ONrz+jcFRQdo+KT0r9L9mAOZNi1Z86H74qi66GBev6yO6OhQaYci
 3kaa+btcbquS4WpMnxxgRJxXlTImJlFvKU6Y5x/JLdii5EIYTBzNGs1BB2aNLe+U09dH
 U9Xl22lN1sAY/HgrBUbiNqaQGbpNDvtJT/RHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405030; x=1701009830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BH9FKZ07kT9BsFm6ZBRRDTcwHFMHq61a+jIOk++gmJA=;
 b=pNJWTp0S3ECpsD//2cZlMRIZ/3P+RloztsbUkfU/79IQnRJId1NjH4ZFSF76nkkDJv
 xu5BrxdSJMRDZV2ogcptVB2UuXIjO+lgidNgnU9yPmH9QKhovENNBovoReNapoPbaICo
 5ucTjSx57TDHZ2UYafIR06U2SS9imy4B5zdADlUeSVIKMyRj+lUzEBR+ZKB4Q4nM5zup
 ruMARviJkeMB+s5lnm9L6iSA4uHhUqkJeEgH9jdlhGnqzoCNZYlMj0WV9kNpaVKUKmN3
 IB/iLhcDQOSW29wYSkI53YGM9L1rRRvvduXaggemQqUROVZtCWRV2dVSyP7jZShz7pRl
 pZUg==
X-Gm-Message-State: AOJu0Yyn2ZHnST42poGskfGcOL8GJ/LKdZfhshmQnKJKAtfjlHjkOMLn
 8bHjYB/VxtYQqI/JigK0rzQZSucxKbC6gHj3N0YfFA==
X-Google-Smtp-Source: AGHT+IHaRtYf2OeVMGavSTF+aa5tcCS9TZnZnoAhtpUxAGQbbGdTC63wl8UdyeHxRQc3BZ45eseMSg==
X-Received: by 2002:a05:6602:1a8c:b0:7b0:1dbf:291a with SMTP id
 bn12-20020a0566021a8c00b007b01dbf291amr7019337iob.16.1700405030199; 
 Sun, 19 Nov 2023 06:43:50 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a023505000000b00463f8b3e34asm1511196jaa.23.2023.11.19.06.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:43:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 2/4] image: Show the load address when decompressing
Date: Sun, 19 Nov 2023 07:43:32 -0700
Message-ID: <20231119074333.v3.2.Ie1c352a32eff905cf333491bf3d7d315e25e3f31@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119144338.630138-1-sjg@chromium.org>
References: <20231119144338.630138-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

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
2.43.0.rc0.421.g78406f8d94-goog

