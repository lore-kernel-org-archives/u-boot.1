Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BCCC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 221FD809A4;
	Wed, 22 Jan 2025 14:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UjHaAOXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C25C2801FB; Wed, 22 Jan 2025 06:34:11 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D37A680137
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 06:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6e8814842so642918185a.0
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 21:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737524046; x=1738128846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVEwh22Zg5xO1EciTmzGAMXjmaOreQYjgjT0P1h0Fzo=;
 b=UjHaAOXLtsb2Dj/X49RW084kScnSYy+y74ljShFPC2DNcoKlgLn3pyr17+IN0PVXgC
 w9zBUpbjXd6lQS5Iieto+hXDHzxLiQBRQNDWZdx9TUbWN+2VLmt/eRUcEH0gZUKXQ3bY
 FJYCqoSO93UMvHcaJC1cnol4UqJK70FCLMDVeq56ANYjBtK3MWNG8hVCU39Ykww2BgQF
 UM54k8mmbrYUVUT7qvpriJt3uI12qX/hSfela+rPo5RUFJYYcWzGLMyDTetcYX8wyfBR
 /eUF5JrhfwAt4TJAp0xxs0wu69EcdtahdgDC613WYbwsgbj0rndLV6AnHbi+sQPmhKtu
 b6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737524046; x=1738128846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVEwh22Zg5xO1EciTmzGAMXjmaOreQYjgjT0P1h0Fzo=;
 b=OLTwFnO+rt4ruBI9k5Axxjx9wOEjfs2WGbdgGtFyJwM7C3i2xCD3D9hDlEFckohKVn
 VL9oaFgQ7vYKmvzHJfXyVdGHrcHwPSi4cM3cDpOcorJEUMjW1W0wlSpmD2me+dpiNvFS
 K4pS6rF+Q3DQgH6ZKOaKHJFHaUR2gyjdWnDoFx+uGqhRHLDAlcXiIiW9SZcRSD6TtNAh
 mrloIOXmmSRFXoTeumbmOI95OW0XNsBPkZxN8I5Bhsw/UCxOpl9yNMUf6I1ZycyAlRGF
 IKTWmx5+5bj/5+0T7/h0evrpX2Ar1JURAs8m3uWTYLFnr9/wtxCP4JPCT9kfTkM9fksD
 4REQ==
X-Gm-Message-State: AOJu0YzrmFfcDhjibPOarKnIagbKd6Lq9V4YL5+1vMpOgLsbWwlObqXp
 v7i2ZPf2txf44Q2EjEG0qXOC8Ki8TP7vWtm2ycB8dCxWnpD6ai+wlG+zveca7IQ=
X-Gm-Gg: ASbGnctClsN5NkZeh6Qx2z8Vo3ekJjPbZUwmzgBsPbRdv3zcPElc6CgwocovC2nG4t0
 WYSL88IuETNcf0oyrM094Yem8nYiT4oe2XVcBWedFOZtLaEPpFscXH37xJCQdpynEjIZZqFpTV6
 OPmIPMl2aKQ+n9wMAekHrPHDTs/sXHwNPeVIhYeWHjV+p0/O5gjxrT83LggVLJTC9Ic0bDYM3CW
 htMV0lbAbQYdBzbnNy9o1ZXO1OMh4GkJwaoMn4m/oVKjTTONOqBoZBrnD1kUKQG6QsE+ijJldIx
 eS0hvWVrf/goyX0aAGvFMyXoz8ZPpq2Fcmb3PEWA+6Lg8CIYMdCgmIkjYJyqWTKSM5atF93QGuU
 rVuiEn8y4gQKHOCo=
X-Google-Smtp-Source: AGHT+IEO7LyMV1SQQ4aK84lnM192C11eEILQmkV5fLX3sSvkZZH+psBrpKyEFqrbP93tS3zKHZciSA==
X-Received: by 2002:a05:620a:4001:b0:7b6:d28b:42b4 with SMTP id
 af79cd13be357-7be6321758emr3007945485a.19.1737524046332; 
 Tue, 21 Jan 2025 21:34:06 -0800 (PST)
Received: from localhost.localdomain
 (bras-base-btfdon1720w-grc-54-174-88-143-14.dsl.bell.ca. [174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d98b2sm634136785a.76.2025.01.21.21.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 21:34:04 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] efi_loader: move path out of file_handle
Date: Wed, 22 Jan 2025 00:32:30 -0500
Message-Id: <20250122053232.17365-6-gabriel.dalimonte@gmail.com>
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

In order to support renaming via SetInfo(), path must allow for longer
values than what was originally present when file_handle was allocated.

Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
---

 lib/efi_loader/efi_file.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 95b3c890ee..e72bc36aca 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -38,7 +38,7 @@ struct file_handle {
 	struct fs_dir_stream *dirs;
 	struct fs_dirent *dent;
 
-	char path[0];
+	char *path;
 };
 #define to_fh(x) container_of(x, struct file_handle, base)
 
@@ -176,6 +176,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 		u64 attributes)
 {
 	struct file_handle *fh;
+	char *path;
 	char f0[MAX_UTF8_PER_UTF16] = {0};
 	int plen = 0;
 	int flen = 0;
@@ -192,11 +193,13 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 		plen = strlen(parent->path) + 1;
 	}
 
+	fh = calloc(1, sizeof(*fh));
 	/* +2 is for null and '/' */
-	fh = calloc(1, sizeof(*fh) + plen + (flen * MAX_UTF8_PER_UTF16) + 2);
-	if (!fh)
-		return NULL;
+	path = calloc(1, plen + (flen * MAX_UTF8_PER_UTF16) + 2);
+	if (!fh || !path)
+		goto error;
 
+	fh->path = path;
 	fh->open_mode = open_mode;
 	fh->base = efi_file_handle_protocol;
 	fh->fs = fs;
@@ -243,6 +246,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 	return &fh->base;
 
 error:
+	free(fh->path);
 	free(fh);
 	return NULL;
 }
@@ -366,6 +370,7 @@ out:
 static efi_status_t file_close(struct file_handle *fh)
 {
 	fs_closedir(fh->dirs);
+	free(fh->path);
 	free(fh);
 	return EFI_SUCCESS;
 }
-- 
2.34.1

