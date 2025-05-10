Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF35C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF26E82A4D;
	Sat, 10 May 2025 15:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DZgeB/Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBE282A8B; Sat, 10 May 2025 15:07:06 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D2D082AAF
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac34257295dso497521966b.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882423; x=1747487223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sg87mglEj4rc7a+N++Qg2NGhpRnYV/SV87GfbbcTYpY=;
 b=DZgeB/XcD1UKrAd6y5TzmRtLTrlmU5IoCOIL1L38fQWFc+NVI2B2lYpRs7L8182OzE
 YbG3l+2oC0nUuBraDUSdDwQ5p2E0fMc/OL4czKJDMrw79iBuP6ER95x9hbjY1qpfxYcl
 et3W0ohcXewkvk07DYz0JHefpaCzSrwRG728g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882423; x=1747487223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sg87mglEj4rc7a+N++Qg2NGhpRnYV/SV87GfbbcTYpY=;
 b=f6RDTtPa9xdqX7vEsEjK9ck9UGJq4femktVnoVIBS+V29BzLVIoUtjUCc9UufGRWfU
 /o/MuWnR6XgPt61eiShdwK0/s7YrD1vjUYHj5VTTJnkpkBvlMeK3/+3YNA1QlC5YpX3Z
 7ECFrwihp6GSVy6Vk/BXWOy1rCNCAvCWXt1ealCuAlXZ1DvzoGOV0VFtwk1NJveymxZx
 8/OE4aTcaKjJK47SWbj0O3vjaX6v6E7Ts8unoXtYm89H7J3WL4sxPImro1fWQ8oJ5CVT
 lk34BDhFB6gnsGvUbcZm+CGWU5iAAg21NXk0na1/3gbLI4Oc7oPCPtwMO7MpFo6qpzFK
 P90w==
X-Gm-Message-State: AOJu0YwFkX8jlYTifrEFpRmmoPvThGtTDe/iAhcOMSpcZp8Lsb2eJoWd
 gT2NAxLFe2uZMtDOCACe1yiHJJ6P5u4el0oYuy16zN+6ZpF0/ANlFQpk07h4KxtIVNG1GSuAl0S
 FnjlTGxXxtA==
X-Gm-Gg: ASbGncscwglM8bBXQA44foVcJsgPN+cTuRP+WCMF2mGyOkZORbGmNE6flv2+mkDssXx
 jfguxxd0K0ISPrA4GKg2qd4wy83hdbQ5nIw9sm5c/hoQiN2FFqWb/NhaY537iIA2UMXHpfR5u4g
 MgVlS2aSQLnfOFxcdVfk2kbcqDFdb2T9ZI+2syXWM+cI0iGMGlblDq9nzIYDaLL8BpATjg8nyqE
 87wJI9bvCXzB54xOGhGf4L+YQnLH4Cpl2NVpLDrQJaz/80o1J6N5iWfhasl4dfXNVrMgMcRrhpD
 Lj93fpd+/x0Ws8fHSxsLi4IJy5o+XZEyZefd+eWJjWEIiwk=
X-Google-Smtp-Source: AGHT+IGoWqsE4/fKDoHaxXJCYkssfNkG5JzF7MilSt7x+DfWsnIRmzwASx8j0m7KieIUu6ds/braKQ==
X-Received: by 2002:a17:907:7ea0:b0:aca:a688:fb13 with SMTP id
 a640c23a62f3a-ad219057ff1mr715433566b.36.1746882423275; 
 Sat, 10 May 2025 06:07:03 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad24085b44fsm52272966b.149.2025.05.10.06.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:07:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH v3 04/10] ext4: Create a var for the number of blocks to
 allocate
Date: Sat, 10 May 2025 15:06:10 +0200
Message-ID: <20250510130642.1575114-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510130642.1575114-1-sjg@chromium.org>
References: <20250510130642.1575114-1-sjg@chromium.org>
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

Since this expression might overflow, put it in a variable.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 fs/ext4/ext4_write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 8e6179c4a99..86420d1c9d7 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -108,9 +108,11 @@ int ext4fs_get_bgdtable(void)
 {
 	int status;
 	struct ext_filesystem *fs = get_fs();
+	size_t alloc_size;
 	int gdsize_total;
 
-	gdsize_total = ROUND(fs->no_blkgrp * fs->gdsize, fs->blksz);
+	alloc_size = fs->no_blkgrp * fs->gdsize;
+	gdsize_total = ROUND(alloc_size, fs->blksz);
 	fs->no_blk_pergdt = gdsize_total / fs->blksz;
 
 	/* allocate memory for gdtable */
-- 
2.43.0

