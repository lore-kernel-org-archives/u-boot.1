Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38B9C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EDC5874BB;
	Thu, 16 Nov 2023 05:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FEFRwzVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EFC8870D2; Thu, 16 Nov 2023 05:11:33 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C8687497
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-359472f74c5so1646085ab.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107889; x=1700712689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okIDMAT2FBo5e5Uko5BdRAZJ+V9haBJdUuOGKgdm7i8=;
 b=FEFRwzVxVEgpJybrgg3PAdsE6aRG4JLETuParPi7oxCGe0IRngmlQDCXXKmtx7Rgi4
 0SU17d9v0DBZz0gwBgO/oyQf9HpJHixmGfdpAl1FApfY06k3Dg0HfHDwrBb8+SO9nRVR
 YcKSmrUyWXkAONAvdZWfv9JmOT/NFHy+2bhs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107889; x=1700712689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okIDMAT2FBo5e5Uko5BdRAZJ+V9haBJdUuOGKgdm7i8=;
 b=LGZVJDX9sYCxuGV4pEmhLzDuSVErcccGUp+jdKLrkTKmrpFl6POGVQ8cIySuasbNuO
 aqvUsZ4Y2+/jaakhH0Q5hmj6yQGN3w/f6ZXDvET0QuTOO71hKX7tHO5Z5VtOLGb48Lq4
 eDwfc7pcsuSgDU9eUxrbtarbl66vV9FnmSXqmimkmp3f+lYi/4pCPIl2oYIM8WGXsn53
 eE+esX+gpaEtLx0+XLUEojN47BYHSTrDfRnw4gQ6hRUTmxXZ5YPipZrgKA0RhzfcUXNS
 BSw9pLrv357HovfooceZ7IaV6aRSw1z//MDvMcHEAdV2D7f8aUFqg/Og7jKb7vnjF64p
 Wdjw==
X-Gm-Message-State: AOJu0YyfFOWX1WEZXPwqLZET6jc3DWfyxeSoQ2h4zfKwbH3r1RYt/AAc
 4a8goaiGVeNrlRfht0rQH8lwXAloxRHKauD/lKfOmg==
X-Google-Smtp-Source: AGHT+IEFkXkVa+5rAInHOsKXn/olUTo3oS3x5EA5DewDsSmg8I0orlQbiDE4gnuBlQ5vPkuBo0LwWQ==
X-Received: by 2002:a05:6e02:1d1d:b0:35a:b283:d17f with SMTP id
 i29-20020a056e021d1d00b0035ab283d17fmr15450619ila.12.1700107889715; 
 Wed, 15 Nov 2023 20:11:29 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 12/32] image: Document error codes from fit_image_load()
Date: Wed, 15 Nov 2023 21:10:12 -0700
Message-ID: <20231116041043.362055-13-sjg@chromium.org>
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

Put a list of these in the function documentation so it is easier to
decode what went wrong.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 include/image.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index 798c5f9c16e4..d37e44721672 100644
--- a/include/image.h
+++ b/include/image.h
@@ -728,7 +728,13 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
  * @param load_op	Decribes what to do with the load address
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
- * Return: node offset of image, or -ve error code on error
+ * Return: node offset of image, or -ve error code on error:
+ *   -ENOEXEC - unsupported architecture
+ *   -ENOENT - could not find image / subimage
+ *   -EACCES - hash, signature or decryptions failure
+ *   -EBADF - invalid OS or image type, or cannot get image load-address
+ *   -EXDEV - memory overwritten / overlap
+ *   -NOEXEC - image decompression error, or invalid FDT
  */
 int fit_image_load(struct bootm_headers *images, ulong addr,
 		   const char **fit_unamep, const char **fit_uname_configp,
-- 
2.43.0.rc0.421.g78406f8d94-goog

