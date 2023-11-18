Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB577C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1C78752E;
	Sat, 18 Nov 2023 22:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UEhv3kCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70BE387519; Sat, 18 Nov 2023 22:06:21 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801FE874BA
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35af2b4242eso3388425ab.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341568; x=1700946368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlSXOpJzn3ScI8ZtKLHDwe5sovjX+5/oNgqyB+RvKl4=;
 b=UEhv3kCakIB7xPN7II5ZKKCYCkVAjm7XGpcnNkf6Q4fZWUgoGW3OfPZbhN7yQYqzA2
 NDgGErsftNC3JAQO4h6BbM9Q5QN0kM12GR5lZO+xiUzbZq0yGsrc0Z08hjwwDaMfTlgp
 wZcoUsz+GEN2uGaDKELm/UbBdN+/XBTXVMAf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341568; x=1700946368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlSXOpJzn3ScI8ZtKLHDwe5sovjX+5/oNgqyB+RvKl4=;
 b=kYpQWcvu/VDW4yFwfmAb3hrVdXiaQXAAT5IXjtNgIeQd+5doR1jgYrc8vUwtZZGUCW
 0b4MpOg1a5kQ63qTptZQn4czYVzxOmZkFwEu6UQO9cZRfZCJN/Q7Cug81xRjYQhxSe/c
 DTN66cf6ncrF4C4p09lkpxMBKs9rEYETNnZrDqbyVkbiLEBx84fhlrCSWQ04L0cBJmBu
 DF3+wIIflmNUmV5L2fhC3JrO8CLpk+NkAURKjaWCZa2UfU4BKu4+kQEkVhztkyoviXQc
 El/JNW+o/bVdm4do7JL8BY8edfAz1ehquQgFY0OfykCvcT8UuPmrv10nyJcZWcyw4n6b
 jTwg==
X-Gm-Message-State: AOJu0YwvpfUkHaAvL/ZftNGvt+trQ5/UCCGmoPU4DAx8GIav7PnXW/Bi
 g1zZCZugVoIMoZZGY6Cl3E0XtL2sjthKRfPmhVzeZA==
X-Google-Smtp-Source: AGHT+IHKzrNK/luP2u+nSobP/HinI3v9FDbtH7IH9t0bPpZWMo22R051Tmu51gPY9J3xGyn7wscP5w==
X-Received: by 2002:a6b:5017:0:b0:78b:b892:e334 with SMTP id
 e23-20020a6b5017000000b0078bb892e334mr4059995iob.11.1700341568074; 
 Sat, 18 Nov 2023 13:06:08 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 14/32] bootm: Use the error return from boot_get_kernel()
Date: Sat, 18 Nov 2023 14:05:02 -0700
Message-ID: <20231118210547.577026-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

Rather than looking for a zero-sized image, use the error code returned
to determine if things are OK.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Use the command table to provide the command name, instead of "bootm"

 boot/bootm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 6ed60bf05084..a23c791a9e15 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -324,9 +324,9 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	/* get kernel image header, start address and length */
 	ret = boot_get_kernel(cmdtp->name, argv[0], &images,
 			      &images.os.image_start, &images.os.image_len,
-		       &os_hdr);
-	if (images.os.image_len == 0) {
-		puts("ERROR: can't get kernel image!\n");
+			      &os_hdr);
+	if (ret) {
+		printf("ERROR %dE: can't get kernel image!\n", ret);
 		return 1;
 	}
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

