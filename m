Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857FDC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C8180F53;
	Tue, 18 Feb 2025 06:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Eu15CRrp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FCC580843; Mon, 17 Feb 2025 19:32:05 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717D1807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-471f2e1bea9so8927341cf.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739817117; x=1740421917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyWtLlLIexzS34fejyz1Po4YlTovptUcZbzSAth6Wcs=;
 b=Eu15CRrpeq+3S2/DT/6SZENo+ouDmONvD12XrBnW15SSfGDGkkRSWrl8NGqVsm3O+S
 dLuilX6zBjIbd6EulgNG4scu+6EOc9O6Jq3b/VbdC+OUnosJcBYKO/ZMLWzjgLraGQNJ
 GNC2ATIxbjNrTM1CRuzZa6/jsF2KHa4/ykvbJtRooVCgi2nXRceor4ZB+yNrgY5FJh9Z
 68ygtCN5J8lvA4tpB8He7SHAyvUupNyb/DADM0HXw0zNIw2GHvGZavZclrsnDsiwuf3d
 P5Rm8nVXvmKOzGeiRI3SBzB6/1Z70J2C/GxOuc8lFPL4wg3tDDLcji5tcpvNxZrEX+Jf
 0pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739817117; x=1740421917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyWtLlLIexzS34fejyz1Po4YlTovptUcZbzSAth6Wcs=;
 b=mAowldUYsBws31JNHJjxSj7RbhHKdnygpfHy34bpdgLJN9HcM0JkvRlyDq+ErHVxy4
 rDYCXxHoGvfI5Yon9462+uEa5Uq8gVJSbXQ1gJw6CVjixD4b5F0keQnADsy/ce88gtuq
 7j8bCaghcB6Nr9YqNTGykB/Y84CJkZQGMClr5VvwGuUAV3PI6a05FbeQJLGy3D1ro7VJ
 kdD7CIDuBp6YTLlgFjrABOfgHodg+yTx3jlomRPr146hM23HxGQMpjcRWaThakdHHos3
 9xj1Kew3npezy3u3zB+BxQUxUC4pq4TtAAbyV169deNpINpTMr6QeZEq+/BPXzLRMUrq
 wnCw==
X-Gm-Message-State: AOJu0YzFi3zUoeEW7/Y6RjlNrwTCQq2djhKPgy8e51Qk6YJkWe8NVX0F
 cTiGS2ezwufTkishr3h1tcuCv/7ksSvcI7/oztrDlclak6p0W+7z6Ov7TA==
X-Gm-Gg: ASbGncteD/mPwCFUxRb8DLhJL9HslzVTyIaowar7mJhczkUXU5bn3IsxUGRBe5sko/m
 ygRvLKpl206c7H+iCLl43V6GYqHsIvQgntEufPK3QDP3d1siJI8i3ZB5FSnTqFJioW/+L1VKLHX
 NgzPQnPjlPL+3YTjmoraNKXoodkpbMMBwZvbNcmCcI9dKwgMtW0Nfbye3fvc0xIL7F5IfKukkte
 4VHmbRVF0GIt6dAj2ICP7OOANs6ZGPEHGhZkIMrFkQU42PDo/WWsRrLSqpWrKICB8iPFFFwuiHO
 dVfLxPpsJAidV3hhsNOnXvpKykpKsiH1pg5DtQ==
X-Google-Smtp-Source: AGHT+IHstlY2kUgyO2GbNsWHe4nIcYxoh73I4O4s+jEvY3V7HWB2zWKUo3H2Y8bsG/Q/vxJS7Oyjpg==
X-Received: by 2002:ac8:584c:0:b0:471:cdeb:da26 with SMTP id
 d75a77b69052e-471dbcc6a4bmr137929781cf.3.1739817117069; 
 Mon, 17 Feb 2025 10:31:57 -0800 (PST)
Received: from localhost.localdomain ([174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2af3722sm50499271cf.49.2025.02.17.10.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:31:56 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/6] efi_loader: support file rename in SetInfo()
Date: Mon, 17 Feb 2025 13:26:47 -0500
Message-Id: <20250217182648.31294-7-gabriel.dalimonte@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
References: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Feb 2025 06:35:28 +0100
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

Following the UEFI specification. The specification did not seem to
delineate if file_name was explicitly a file name only, or could
include paths to move the file to a different directory. The more
generous interpretation of supporting paths was selected.

Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>

---

Changes in v2:
 - simplify freeing of new_file_name and new_path


---
 lib/efi_loader/efi_file.c | 45 +++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 6b15c1f3d27..7d81da8f2d8 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -954,6 +954,7 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
 {
 	struct file_handle *fh = to_fh(file);
 	efi_status_t ret = EFI_UNSUPPORTED;
+	char *new_file_name = NULL, *new_path = NULL;
 
 	EFI_ENTRY("%p, %pUs, %zu, %p", file, info_type, buffer_size, buffer);
 
@@ -983,13 +984,43 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
 		pos = new_file_name;
 		utf16_utf8_strcpy(&pos, info->file_name);
 		if (strcmp(new_file_name, filename)) {
-			/* TODO: we do not support renaming */
-			EFI_PRINT("Renaming not supported\n");
-			free(new_file_name);
-			ret = EFI_ACCESS_DENIED;
-			goto out;
+			int dlen;
+			int rv;
+
+			if (set_blk_dev(fh)) {
+				ret = EFI_DEVICE_ERROR;
+				goto out;
+			}
+			dlen = filename - fh->path;
+			new_path = calloc(1, dlen + strlen(new_file_name) + 1);
+			if (!new_path) {
+				ret = EFI_OUT_OF_RESOURCES;
+				goto out;
+			}
+			memcpy(new_path, fh->path, dlen);
+			strcpy(new_path + dlen, new_file_name);
+			sanitize_path(new_path);
+			rv = fs_exists(new_path);
+			if (rv) {
+				ret = EFI_ACCESS_DENIED;
+				goto out;
+			}
+			/* fs_exists() calls fs_close(), so open file system again */
+			if (set_blk_dev(fh)) {
+				ret = EFI_DEVICE_ERROR;
+				goto out;
+			}
+			rv = fs_rename(fh->path, new_path);
+			if (rv) {
+				ret = EFI_ACCESS_DENIED;
+				goto out;
+			}
+			free(fh->path);
+			fh->path = new_path;
+			/* Prevent new_path from being freed on out */
+			new_path = NULL;
+			ret = EFI_SUCCESS;
 		}
-		free(new_file_name);
 		/* Check for truncation */
 		if (!fh->isdir) {
 			ret = efi_get_file_size(fh, &file_size);
@@ -1012,6 +1043,8 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
 		ret = EFI_UNSUPPORTED;
 	}
 out:
+	free(new_path);
+	free(new_file_name);
 	return EFI_EXIT(ret);
 }
 
-- 
2.34.1

