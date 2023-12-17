Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E012BC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E50F87C8E;
	Sun, 17 Dec 2023 17:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XUJ2qgZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E8B687CB0; Sun, 17 Dec 2023 17:36:42 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A8987C9B
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7b719f05b11so117631439f.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702830998; x=1703435798; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jko5SIFIvLvpQaeqwCGQI8wi+ruZaHC+S9n0+g/QOg=;
 b=XUJ2qgZI4iXhzQ2i7S4UbvIGQQk1Z8jzek+k5Kq61Gx8XgdA838oxQ82+pD3nh1pLZ
 sup14FAsiKPzXhGn44zkwSlnFu/7WY3lkcxDb6SbLbp12ypww65mJicKsXgwDoBk2gIS
 R2CJc25+y8Mm5C8iE/Ihd9ulWI5d+acaX6/nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702830998; x=1703435798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jko5SIFIvLvpQaeqwCGQI8wi+ruZaHC+S9n0+g/QOg=;
 b=YhUdrPgFgD96Xdtnq3U58uzLYuRFhXIg6+ewg5GnAgAYtUGAmuf6jw9ivMpj24MSUn
 UahmzE2DiQQSUqtZ+eOG/hugxkKdJ1iFeVN5N3z5cgPB9GbTznmsDrzp8YAH4Qkxigz8
 jqHkYT6QvplyQW+cMULWGAdBpw59gWt7EqK9RC4Ic1h9Ufu1/d9+1P0TCfDpYwhFkOjp
 vKlO+HkZ4i7d5itfScHhQTnuBfp7ulti84/Mv297OsabVyeEP+BSHu7T4pvQsTQmL4pl
 /3rUV6qJ6bR9ESLv6xBphaMQss0o1wyhJuRbCSKzx855d/7O59nWsozWB1LQaGNilue7
 auOQ==
X-Gm-Message-State: AOJu0YwIDdIYSnZ19P39xMmGYFXd57yuGU53+cNhKkpROvbQ0eZbKhlK
 UNSkbqDiyKqLERCHHVNGH7wLgV8b5QljInSsQiLJvQ==
X-Google-Smtp-Source: AGHT+IG0ZU80HFnXoW8Mfu+Ta6urDaka0GUCrdk1S1qFPOy7x6BYUHXBleDpW8zH8soMulTBT4CbVQ==
X-Received: by 2002:a6b:f804:0:b0:7b4:3c04:4ff with SMTP id
 o4-20020a6bf804000000b007b43c0404ffmr17314378ioh.43.1702830998223; 
 Sun, 17 Dec 2023 08:36:38 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/10] fdtgrep: Tidy up comment for h_include()
Date: Sun, 17 Dec 2023 09:36:18 -0700
Message-ID: <20231217163627.2339802-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231217163627.2339802-1-sjg@chromium.org>
References: <20231217163627.2339802-1-sjg@chromium.org>
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

Copy the comment from fdt_first_region() so that it is clear what value
this function returns.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index b56d2fe21c9a..a6cdc326709d 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -576,15 +576,21 @@ static int check_type_include(void *priv, int type, const char *data, int size)
 }
 
 /**
- * h_include() - Include handler function for fdtgrep_find_regions()
+ * h_include() - Include handler function for fdt_first_region()
  *
  * This function decides whether to include or exclude a node, property or
- * compatible string. The function is defined by fdtgrep_find_regions().
+ * compatible string. The function is defined by fdt_first_region().
  *
  * The algorithm is documented in the code - disp->invert is 0 for normal
  * operation, and 1 to invert the sense of all matches.
  *
- * See
+ * @priv: Private pointer as passed to fdtgrep_find_regions()
+ * @fdt: Pointer to FDT blob
+ * @offset: Offset of this node / property
+ * @type: Type of this part, FDT_IS_...
+ * @data: Pointer to data (node name, property name, compatible string)
+ * @size: Size of data, or 0 if none
+ * Return: 0 to exclude, 1 to include, -1 if no information is available
  */
 static int h_include(void *priv, const void *fdt, int offset, int type,
 		     const char *data, int size)
-- 
2.43.0.472.g3155946c3a-goog

