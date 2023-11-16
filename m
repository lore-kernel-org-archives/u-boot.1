Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE562C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0AB874BD;
	Thu, 16 Nov 2023 05:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TlAgRsBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5D8874AC; Thu, 16 Nov 2023 05:11:35 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D493C870D2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7a694a365d9so14520039f.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107892; x=1700712692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m25xKmMbEPx1JRxU9soNxW/Z2AK3xHB8fbp/GLsY9aM=;
 b=TlAgRsBbAPcO4Yf3ap09/KtQVljbBWw0Ssu3rJ8dfdHBmsy8FjrIlgdINir0iOrrm+
 nOwLSah6oUhfL3QAV+/rxNypFoRKdM+G/6xa52qidcnetpXak3lZcq5qsuiTv9wErL59
 VDoGaKR394F6oS/3miLiBOBNJbZHgZ8o7lqzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107892; x=1700712692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m25xKmMbEPx1JRxU9soNxW/Z2AK3xHB8fbp/GLsY9aM=;
 b=Q6p3bKRNe5EkwOXlw2wOt9o+5AAoZ+r4iqMljoQye4+ZHPIfqLAAEOdyMdH3Aap9bD
 XvV5tFZG7gWPrFSDwg4qe8IHBYFa4KJdU0JQ/Kkhn58Cx9Sy7L2t5C2gpljYmOjTuy41
 h4/ArN/TZVwhfkN0+XxWEfj+eHAcWKYmxCeb19rgz+lGqH1C+04d43ia0/EexxbK8Vzz
 L0bcgeh2leSFzJV0lAnJO56MruLtCoAwIG+SMzL7UmRRZJ6kP9+qhQ+F7b7PZG6MQra+
 nrQdZd+LLTaY4wQapsuy6sB4CLVExBb+K3OwgD4v9uICQgBNVhyf9iENTpeRgQLKDMMJ
 zzFg==
X-Gm-Message-State: AOJu0YzVpi/aXUOHhEDSUUskwGbB62+tvfTDNnAYDuJs+gg6JxxOPYdL
 vEig8AYlFp74VmDs5NViMdU76K9yBb6dwNG7S1yAWQ==
X-Google-Smtp-Source: AGHT+IE9CvFJe0Wd0YtMYGXgVPo6jIleghd5B9EXUzagOuYqWHvmGj3GrR5GLbYdfICCkkBORb+d1g==
X-Received: by 2002:a6b:e812:0:b0:7b0:1b0d:240a with SMTP id
 f18-20020a6be812000000b007b01b0d240amr16259219ioh.3.1700107892443; 
 Wed, 15 Nov 2023 20:11:32 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 15/32] bootm: Use the error return from boot_get_kernel()
Date: Wed, 15 Nov 2023 21:10:15 -0700
Message-ID: <20231116041043.362055-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

