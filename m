Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9B1D59D6B
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9982689A78;
	Mon, 25 Nov 2024 21:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NWUioUni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CE389A78; Mon, 25 Nov 2024 21:45:25 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E519589251
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-841837213b1so75972239f.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567521; x=1733172321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lULJg4+iW9x4e9+CBRp2K6a1knH7KktKICGlFjcCQog=;
 b=NWUioUniEAgr/WU3Y5K0QuF51SzsVtNtbOJKvHDikT9fkC41Z1DKx/oJw3Ee+ooUrT
 CpjwcvXM8Oep6if70SpN2q0xZUxsn5jvHAHnOQHyCrPsk0xvGwLV9teJn2jLkYVvIXcX
 CRb/dxOOe0Wm3mM3MEWY2h3gzTFEWBWARkOnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567521; x=1733172321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lULJg4+iW9x4e9+CBRp2K6a1knH7KktKICGlFjcCQog=;
 b=hmlishJxEqgtWg0nERsyJZ34UVkB0v6z4h5HZ7mpUf2m77pbG6KlpG70rHjuOh4E+W
 Db29apjZ+t8z3Ps02n3lUtB8lGhDgl8el69tVWMrHBgkVxMYGjAh8QBai7I9kiL+MkoD
 hHH+x7fJGZugW5bhv3fL+UXsbJsERAq49BaZFn+0/lD24YV1hXIsdFmfIBcmT2QKqL38
 x7aYHV/P7TR4HCakxGKsFYGdpaRr4JWS+PO2g4ZTB8cbjAbdsBAfdYqY0HI64x6aAPy5
 uaQWCycCmuznSQ9uiZj9c9ffs2Y0f/6D4KXrtx4Fto7O1NfRCJWHcWGn8DqEFIgY2ZGs
 uSYw==
X-Gm-Message-State: AOJu0YzgSeYr84Vz4sB252Hvbxg6ysMNTQYRN3AwgWHzh6GKYeIJKHfa
 r/cIWvJGv5W7UOfH7XmuYEs78ySOrFhHx4+N8BFDaiglihkZL1GBD34QaJdfPjPVK1oWg7Hxkgs
 =
X-Gm-Gg: ASbGncs7k5pFgNcm5d7eZYdmzX2bnE1uIOd0rhed8mRtzfvH2kVqF+sNC8jzGiC3MB3
 s/tyuDbzvYuJiC8W+Ixqt62a6gsxue9Cs8DLOW0ftxFIHaY+Ijmrt0JS+od/JPCd0ik2jTJpBPz
 6FBCTHuXMwnfZW1rQ6XsNeaGtdNXiufxCYybKusIxLen6X7P9wyG3F9UfTdQ2+r/KBvhnkdChT5
 MjARRE3gAKPeH5Rkwj+7FP+na7Sl5nwpuht+TszyAkXRe4=
X-Google-Smtp-Source: AGHT+IGd5DYrKAhIRsXt7GXx2YVMc7mOFrhkpF+M0mgPFf8VP5vulNcV2T88Q21ice4EQvPD6j+b5Q==
X-Received: by 2002:a05:6602:4f1a:b0:841:950b:386d with SMTP id
 ca18e2360f4ac-841950b3abemr524428839f.3.1732567521193; 
 Mon, 25 Nov 2024 12:45:21 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/13] efi_loader: Update startimage_exit self-test to check
 error
Date: Mon, 25 Nov 2024 13:44:43 -0700
Message-ID: <20241125204456.1525752-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
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

Check for an error returned from the decompress() function, just in
case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_selftest/efi_selftest_startimage_exit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_startimage_exit.c b/lib/efi_selftest/efi_selftest_startimage_exit.c
index b65a10b7a4b..8d119f054c5 100644
--- a/lib/efi_selftest/efi_selftest_startimage_exit.c
+++ b/lib/efi_selftest/efi_selftest_startimage_exit.c
@@ -84,13 +84,15 @@ static efi_status_t decompress(u8 **image)
 static int setup(const efi_handle_t handle,
 		 const struct efi_system_table *systable)
 {
+	efi_status_t ret;
+
 	image_handle = handle;
 	boottime = systable->boottime;
 
 	/* Load the application image into memory */
-	decompress(&image);
+	ret = decompress(&image);
 
-	return EFI_ST_SUCCESS;
+	return ret;
 }
 
 /*
-- 
2.43.0

