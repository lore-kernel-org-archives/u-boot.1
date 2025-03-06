Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3131AC19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2FDE81B5C;
	Thu,  6 Mar 2025 01:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="URx+lCLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F04D381273; Thu,  6 Mar 2025 01:28:27 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17CA080FE2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85ad9632156so8544939f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220845; x=1741825645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHZ1dY/q1/SV8HyXJEi0esNEL3qptGTtmKKyIDWxJ4s=;
 b=URx+lCLzUJ5hbixnsdXKTRFRUrGH2cS7jJso6OW04EXqfRb+eyif5Yyabhp4PIm3zi
 WKHob3c77um84UFteYXJx2W3Mm08MV+4uO8XYhVY/Wwjzn995bbWjHvxxF6UIvBES+ka
 1m8WEqczmhKuN6BMjPL2cMrnnQ986U2aiJJHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220845; x=1741825645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHZ1dY/q1/SV8HyXJEi0esNEL3qptGTtmKKyIDWxJ4s=;
 b=FKUBYudWYc4a9blkIAjztLxUgP4kS+VryG+6+ksev7iqRnq06E+yZj2dZS4XVCTbbT
 pIetqvGC9STAodYXyeRibhdIdPnGeU92kVlQTQ59F3HFPdHd50UhEywbAPeivW6SaAJY
 oLYIFwfm3pYDqO4Cn3pzerJRJCgjMeOjC5geRYcOGdrnpyLs9OQDiXX9g9rmP3beAlzu
 kyy3io5hKg0KcJn94JGocFJQTm3Q2yFR6xYGGxLPUevyv6NHq1hTKhXZa9o3bFZv9Bdy
 pwyLDS6Q7LyaHjqyOZ/Bx6N+f7C+nMCscCfnx6+RtjZwdR50rwA38s9sSk9kaZamA8Dj
 Ov8w==
X-Gm-Message-State: AOJu0Yzzo2XlxbflPSNZMZk/hs9GOtYVbdQpSjLMSW+PY1MuCyGDoQ1A
 oL0pd2CJ+npISWd866v8LMoRDKs1m7BckmqdWMsvEedWij+WkQ41LRj4RUMX82Ao7e0fZU0/2oQ
 =
X-Gm-Gg: ASbGncuq3jCovIaELwCxWU/Lk/3Y74wRT1goUUOKzL6g0sul0HsPZmoJWR+DCksH1h0
 Yi6Pdr4gHKmY6ujCYpml07iL6OR32phxXlJcgBViENSlIL7DLIDW7R3bZnIkrLKNXhgC9yZCVoc
 h3XhEG7G8rz+xyCLhxY91A1wmCq3Xsxrd789dXkIJ37v/d/rpa3o0xjd1fss6D+ctkuNHrRCdNe
 B/VdQXwEC38aUCkzeffWq6O5doeOdnDzaS6h1jhiup5X8+mGpLQXyiHaQEXgnxC1KMlv9P3dvLd
 rIL0ZmuzjCTSh3ifJsRnvMJvtGm/+O0K+IbPpgOFl7z6RqIrGO24ewsIVPiydnbwfABO+oorwB+
 Wiu7hPQ==
X-Google-Smtp-Source: AGHT+IH8wH0ld5pq842KTWxIc9KKHWdpLOdN9+P1Klr4KHhMvyT/yuw7DlUegvwRtaTudW5kK7zewQ==
X-Received: by 2002:a05:6602:4c02:b0:85a:e24f:2b50 with SMTP id
 ca18e2360f4ac-85aff8819cbmr593385939f.2.1741220845637; 
 Wed, 05 Mar 2025 16:27:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v5 22/29] net: Tidy up the comments to parse_args()
Date: Wed,  5 Mar 2025 17:25:16 -0700
Message-ID: <20250306002533.2380866-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

This function is a bit vague as to what it does. Expand the comment a
little, to specify which args are provided and which variables are
updated.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 cmd/net.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index deebd5b710f..89a4d9b38d4 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -313,9 +313,18 @@ static int parse_addr_size(char * const argv[])
 /**
  * parse_args() - parse command line arguments
  *
+ * Sets:
+ *
+ * - net_boot_file_name_explicit to true if a filename was specified
+ * - net_boot_file_name to that filename, if specified, else the value of the
+ *	'bootfile' environment variable
+ * - image_load_addr if a load address was provided
+ * - image_save_addr and image_save_size, if proto == TFTPPUT
+ *
  * @proto:	command prototype
- * @argc:	number of arguments
- * @argv:	command line arguments
+ * @argc:	number of arguments, include the command, which has already been
+ *		parsed
+ * @argv:	command line arguments, with argv[0] being the command
  * Return:	0 on success
  */
 static int parse_args(enum proto_t proto, int argc, char *const argv[])
-- 
2.43.0

