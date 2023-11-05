Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F55C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 20:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F5586F20;
	Sun,  5 Nov 2023 21:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="llavMAav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD0286F12; Sun,  5 Nov 2023 21:05:21 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BFE086EDA
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 21:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3594560fa09so15371135ab.0
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 12:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699214711; x=1699819511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lEGLWbImSi8puI4TacO42g9mtXeBb68/FZhWAxODNf0=;
 b=llavMAavyDh6exWA4RCzyrsNh8tb93wYhQDaxHXMD5BRTrvbKTZKWTc3LrR3/vTOAG
 Uc3iYJ5o9czsPkXX837wPwCpX/5FGF31592oAcLddIPTZPryPW8FzwMU/jr3OyVnHrzk
 TbAgmTmVeQQwT6lOXfCLVs1oLBnF0E6LJisnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699214711; x=1699819511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lEGLWbImSi8puI4TacO42g9mtXeBb68/FZhWAxODNf0=;
 b=qzu7V+2eqyxGRKe54LdJ+hMpaLx3tmCFnH7OWbI3qX/eCGp45cwRjHbPkGeSxXrhsm
 UxE3kZuYAxCvStfpyMTysNGPA/JzNNmjdkjcDuEYk8imkrUkeJFXbwez7jDvwNpnuKGY
 naK5OtjdjnAy1HA5HS9Pv8AxPfUOQ4uTiuPg76u7w/vofUoFpGOkCIYl2aDYQ0F6PM6u
 eP59xecmjDg7UuqsMwEHF6yuS2mV3fq6mpWyCHZ5S5CIrLDHbpxlm59xJmPXZ9mY4Ig4
 puc6b07T2Q2dMnJgNpWJNMQi6gHIS6bXix+HsAwaBsQYs72W7N95fI+IBocjYNKew0SB
 C8vA==
X-Gm-Message-State: AOJu0Yzf+5D4/A9QcStBwjBrJP9wpvA919DuHYga8ly6hhT4ZRr1Iq/g
 yzArspau59JJJzY/6XaJHF8Pz4Gzs8rirHSDugRnGw==
X-Google-Smtp-Source: AGHT+IEJd6R893HQYHLjEQhyujB1EiVV4/QeBauyorpeofHuxdJVpehsl5nJjC4NpnAxdje6Iiwt7g==
X-Received: by 2002:a05:6602:1506:b0:7a9:945f:e46 with SMTP id
 g6-20020a056602150600b007a9945f0e46mr37621208iow.13.1699214710829; 
 Sun, 05 Nov 2023 12:05:10 -0800 (PST)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a029693000000b0044d10eda3a8sm1685512jai.158.2023.11.05.12.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:05:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 1/4] bootm: Allow ignoring the load address with kernel_noload
Date: Sun,  5 Nov 2023 13:03:51 -0700
Message-ID: <20231105130351.1.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
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

This image type is supposed to ignore the load address. But at present
it fails if the load address is missing. If it is zero, the image is
loaded at address 0, which may not work on all boards.

Make use of the kernel_addr_r environment variable, instead, since this
seems to be a more reliable final address for the kernel.

Another option would be to create a new Kconfig for this, or to use a
region of memory known to be free, e.g. calculated from the DRAM banks.
But in any case we should try to avoid conflicting with the
kernel_addr_r variable. So the approach in this patch seems reasonable
to me.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cb61485c226c..7583be5a4515 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -176,7 +176,13 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		images.os.end = fit_get_end(images.fit_hdr_os);
 
-		if (fit_image_get_load(images.fit_hdr_os, images.fit_noffset_os,
+		if (images.os.type == IH_TYPE_KERNEL_NOLOAD) {
+			ulong load;
+
+			load = env_get_hex("kernel_addr_r", -1UL);
+			printf("Using kernel load address %lx\n", load);
+			images.os.load = load;
+		} else if (fit_image_get_load(images.fit_hdr_os, images.fit_noffset_os,
 				       &images.os.load)) {
 			puts("Can't get image load address!\n");
 			bootstage_error(BOOTSTAGE_ID_FIT_LOADADDR);
@@ -229,7 +235,7 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		ret = fit_image_get_entry(images.fit_hdr_os,
 					  images.fit_noffset_os, &images.ep);
-		if (ret) {
+		if (ret && images.os.type == IH_TYPE_KERNEL_NOLOAD) {
 			puts("Can't get entry point property!\n");
 			return 1;
 		}
-- 
2.42.0.869.gea05f2083d-goog

