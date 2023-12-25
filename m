Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44825C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 04:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6AD3877DE;
	Mon, 25 Dec 2023 05:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IlzZI4KN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FAE8877F1; Mon, 25 Dec 2023 05:45:50 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793B4877FD
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 05:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bb6fc61ce7so2511944b6e.3
 for <u-boot@lists.denx.de>; Sun, 24 Dec 2023 20:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703479546; x=1704084346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0/Y7/jGSTjjDx7KgsviVofBq3DjOreBKBqX2VLJA1I=;
 b=IlzZI4KN6RQMwg6XUkc2/aecnLyrLiuzcTm2E0LBf9o522sjIH8/vW86UOVUeEUJKB
 CLiDbZXo86vI60fBstLYoVlLkti7YN2Fn+HRZeq4ab3C+n5kG74qUUEYw5WPsFGvPnVq
 6F1qM0b/7h5L4mM0sjq96P4yXjqfXwSOW0P7xO23tWA/opz9Kk/ZjnCAywmq2Ix49yw0
 fmwjHBVjTqKvvgh9511jhOaqWhz4aXc7mRpHSL2/fUcl+fK4B8aaOnF7dVS85yH0ZKj3
 TlBHiA8anDZoKDMMoDmgXeyGonJaQE322wPePEV/EUvUdNr9+6y7TJMJgwY0PAt2MrwZ
 ezPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703479546; x=1704084346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0/Y7/jGSTjjDx7KgsviVofBq3DjOreBKBqX2VLJA1I=;
 b=IC9hAJIYofgD4BdmeqK/5oHDqemLs3t+qRIKO7otf/zr10Tg5vYxCnjm4MuJIlTt8m
 pa8pXWpdBD3YA/9EBsxPt472mOYP6zHsOf6F21SxY6PS6Vi5B/KJpRbiiKh36kCZ6XZx
 66c5c99TqIjV9IHt2C73w609fm+VbY9qOi2JI/IqhJ7+s88R505hu5TzQ6v+qZR5XzjF
 zLFZM/uQBkkDpA9zdL1omylwP5r4L3+CbYEwbV4vRDK2IOv7tcm8qMBWBoRk+D8uImVd
 qWnW5Er5kChkAwU1nnCvMokohXy0lLcPSgdFWkj+UG8r95IqY/989pw7a4ojwxsrtZ1k
 5lyQ==
X-Gm-Message-State: AOJu0YyU7wH0IRA92EbI2u2VT7QnQu1ju2it9z3j8LyHXn1zf2LA0jhq
 Ds5ZFJZRopqWNmQ5eZwsbK3NYUXV72Z86hxIZXBEGV74jXQ=
X-Google-Smtp-Source: AGHT+IF07Zzs6PkxvzXiZIN4m9gp0ywpiZ939HL0fUlc+fHh57YnsCQSqUzu+X2TyjOsIHtjNtPHnw==
X-Received: by 2002:a05:6808:3097:b0:3bb:634f:66ed with SMTP id
 bl23-20020a056808309700b003bb634f66edmr4836396oib.11.1703479546378; 
 Sun, 24 Dec 2023 20:45:46 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 f30-20020aa79d9e000000b006d9ae6fe867sm2272875pfq.110.2023.12.24.20.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 20:45:45 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 2/3] efi_loader: avoid pointer access after calling
 efi_delete_handle
Date: Mon, 25 Dec 2023 13:43:55 +0900
Message-Id: <20231225044356.626900-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231225044356.626900-1-masahisa.kojima@linaro.org>
References: <20231225044356.626900-1-masahisa.kojima@linaro.org>
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

efi_delete_handle() calls efi_purge_handle(), then it finally
frees the efi handle.
Both diskobj and handle variables in efi_disk_remove() have
the same pointer, we can not access diskobj->dp after calling
efi_delete_handle().

This commit saves the struct efi_device_path pointer before
calling efi_delete_handle(). This commit also fixes the
missing free for volume member in struct efi_disk_obj.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_disk.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index a2f8b531a3..415d8601ba 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -701,7 +701,9 @@ int efi_disk_remove(void *ctx, struct event *event)
 	struct udevice *dev = event->data.dm.dev;
 	efi_handle_t handle;
 	struct blk_desc *desc;
+	struct efi_device_path *dp = NULL;
 	struct efi_disk_obj *diskobj = NULL;
+	struct efi_simple_file_system_protocol *volume = NULL;
 	efi_status_t ret;
 
 	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
@@ -722,14 +724,18 @@ int efi_disk_remove(void *ctx, struct event *event)
 		return 0;
 	}
 
+	if (diskobj) {
+		dp = diskobj->dp;
+		volume = diskobj->volume;
+	}
+
 	ret = efi_delete_handle(handle);
 	/* Do not delete DM device if there are still EFI drivers attached. */
 	if (ret != EFI_SUCCESS)
 		return -1;
 
-	if (diskobj)
-		efi_free_pool(diskobj->dp);
-
+	efi_free_pool(dp);
+	free(volume);
 	dev_tag_del(dev, DM_TAG_EFI);
 
 	return 0;
-- 
2.34.1

