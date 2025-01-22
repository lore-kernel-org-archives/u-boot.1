Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73DDC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F7B809D4;
	Wed, 22 Jan 2025 14:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XBv/BOes";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08DD801F5; Wed, 22 Jan 2025 06:34:19 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D458801FB
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 06:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46c7855df10so52774661cf.3
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 21:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737524055; x=1738128855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIvLTvmyNJyIGBsCkqRW0YeSk9gjNuX8hZjH5BIHB94=;
 b=XBv/BOes3ClHXIIUXaqbJgDU+HPzfm88YULQCSm8lm7BnHjXxqOH5UReAmjqe+toQA
 oLWoqGxPpEvvT/0gEsBpoSahQHT5++Zi9SKkC50vfI8fYeRGEMAEvdMvJD9zwAztqLcD
 BNDN/NPHeShcU1r/hS3d055OrtmoqLrE4BKq75CYQ7/8Nbr9aHwULqZzqCoV//jbNeR7
 x8Be4MkEICP6lBkaOpPDlUxAkyS0/NEPzDbfcWKldNEuzHYdG2u66PLIoXklGVYmQlX8
 6/Iqlpfz//1uoD91Oiw4zHNiVz74lJ9y1xS56sygRc3xU6l68oOiTkmOXTXMPTFLOz8p
 QOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737524055; x=1738128855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIvLTvmyNJyIGBsCkqRW0YeSk9gjNuX8hZjH5BIHB94=;
 b=NF6jHB9uOgqkvTic1fA3DvJpFdB8gfqtwgv1prIdhG7LJx2LKjPv80PlqlDdOgs5Nj
 8/lvF29hqy61UUgMCDBQQUp+YB444r0lRGgcJ76fRneG85ax3H8UV2mhUB3P+5Rad3rf
 9oqHwu1jFNAWJaRVdFKEnejlG+Egw+xWQpfHqtizwhCxIIoonGHTnVpqP7Gl0HyzQ2Lh
 5ZmpFB7TuhwvyemeNnnqoU3Mr54irNgUksBZy8kBpG679BdXz/zc5yo6ufUN0pZf5YjS
 PId2+4pt6199yOG0kl1PnC/eqlU+ijdpct9tDLXCzYI30zhlrQyRxpF4T+dq1uC4uHln
 5GeA==
X-Gm-Message-State: AOJu0YzIbJGRLH4MdkX9+/7d89g4o7Ad8rfgThyqpfEW2f3bkLK8sOWf
 mhvJZxmgQCOMCuysRJTvaUnIlzoXWF9UnP8gmRxZCq38cITDM4bYxc0z7cjmo/8=
X-Gm-Gg: ASbGncuAVlJlLVdq0vJSJczuZPvpbS892vvuFQhSRVrAQKumUn8pyqR95KaJdl0PCBx
 JmnkVp4ec+7DkmwuSfr5Bby91hOK1nnwVp7pi/7yMvDXw9Vkawow5hCY/q/jlVLQXlgo0oB7nM9
 TchwGxpmtNnTe1n/ZDZLzD+DErvpOxKq1ida1qptfB4iV2F2GNluKpB+vk1RvOftVYJ3L+HUhu/
 Z/YqntHa5VosL+u8iyc2OSBbwBWUT7rMbBWcdThIzFYRGYxnlnwjmwH0zUNoepo/F1j8v+nLHH7
 cHnvCX9UPKFB0ppygQ28ZeGK/mOIBYBo9IHocMPzuaMpxjbQW9JPmN6sq7FiJdU9MzZr4OmEuZN
 tP1kj
X-Google-Smtp-Source: AGHT+IE4M8L5E9Yids32IC920+INOTxrju0r9T20aW5VLMpoB+CUAgSwMDFdiuTTgCWlR0xAie6/2Q==
X-Received: by 2002:ac8:5989:0:b0:462:bb8d:3673 with SMTP id
 d75a77b69052e-46e12b96171mr329777481cf.35.1737524055454; 
 Tue, 21 Jan 2025 21:34:15 -0800 (PST)
Received: from localhost.localdomain
 (bras-base-btfdon1720w-grc-54-174-88-143-14.dsl.bell.ca. [174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d98b2sm634136785a.76.2025.01.21.21.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 21:34:14 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] efi_loader: support file rename in SetInfo()
Date: Wed, 22 Jan 2025 00:32:31 -0500
Message-Id: <20250122053232.17365-7-gabriel.dalimonte@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Jan 2025 14:22:36 +0100
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

 lib/efi_loader/efi_file.c | 48 +++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index e72bc36aca..f3d643a057 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -981,11 +981,49 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
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
+			char *new_path;
+
+			if (set_blk_dev(fh)) {
+				free(new_file_name);
+				ret = EFI_DEVICE_ERROR;
+				goto out;
+			}
+			dlen = filename - fh->path;
+			new_path = calloc(1, dlen + strlen(new_file_name) + 1);
+			if (!new_path) {
+				free(new_file_name);
+				ret = EFI_OUT_OF_RESOURCES;
+				goto out;
+			}
+			memcpy(new_path, fh->path, dlen);
+			strcpy(new_path + dlen, new_file_name);
+			sanitize_path(new_path);
+			rv = fs_exists(new_path);
+			if (rv) {
+				free(new_path);
+				free(new_file_name);
+				ret = EFI_ACCESS_DENIED;
+				goto out;
+			}
+			/* fs_exists() calls fs_close(), so open file system again */
+			if (set_blk_dev(fh)) {
+				free(new_path);
+				free(new_file_name);
+				ret = EFI_DEVICE_ERROR;
+				goto out;
+			}
+			rv = fs_rename(fh->path, new_path);
+			if (rv) {
+				free(new_path);
+				free(new_file_name);
+				ret = EFI_ACCESS_DENIED;
+				goto out;
+			}
+			free(fh->path);
+			fh->path = new_path;
+			ret = EFI_SUCCESS;
 		}
 		free(new_file_name);
 		/* Check for truncation */
-- 
2.34.1

