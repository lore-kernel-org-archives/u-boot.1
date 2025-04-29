Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FFFC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DE18277D;
	Tue, 29 Apr 2025 15:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jlIynFld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E9C982A55; Tue, 29 Apr 2025 15:27:23 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7DF8215B
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so3782440a12.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745933239; x=1746538039; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2rhJc8pjHgkvMTbm9Bz39NNl5ABXMl0rIjpqX3qe/s=;
 b=jlIynFldVDlRkPnOAfDTASqFTG0N104ZKqTDpAMxKGqWVKsD9+bVIA1DrQ+SFSQ93G
 dO3Ka6MPSXCIQT7EJ0+poX6sxUvJ3kqz8tA3x59RdafVUGExRL0IFY8TfGM9PWYnFDm0
 f/Pc3wfCkw53tPHxgstVjLluWR2Q9VKRGRfFOkYh3in8tUwXfw5fPnknlqWQFjgnVwZi
 OP/Z7Ll5RxS82mfC3xkC9oEfiNd+oWaQcvUtWtpOpBGEZO2IsBiava/rYGIZCvnPeZpb
 NNj/bGaduawJfZUfiRuk7a0pjNOmcUi6gjJvN6w2eUlafFP3+09fJUAb/rkpY7tQh/z2
 Kzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933239; x=1746538039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2rhJc8pjHgkvMTbm9Bz39NNl5ABXMl0rIjpqX3qe/s=;
 b=AGiCRIB7vUxVSmSZWbbKja8FhyJJtCF/xaAJnNnQX0SbOwKU6Ey1wsDjzreM3a9Twy
 bnxR6T/7VgqbnmiUbkBn8jDGvyX5lqskG2j70LxL7ELT+leb6TlekjhNpPZRgs+Agxgv
 YfKgVpOYli5Ar8ZPMmdVEusyUFSv6HMKT0C8Ah05ovHl2r8oSRylCTyPA5KZ3ppm2AV1
 yJUCRP7cBPK9AaKG2QhnUtpRJ4jQswHb83bZgKluCmQfu62jmQqn3AEHydDiU0WK6hNi
 lpGwWmegscoc4Ys+KMxDmmUjbP5sv15tCXKgn6jtMd1imc2WP2SXCMp0zD3z642+bftJ
 MPGQ==
X-Gm-Message-State: AOJu0YwhYR8AMcA7pxUGYVWYZAJrwZRu/lckjv+MRGnkyWRhcvYEJjMP
 S3CQsQ/pEsXD90ZpaUuXQ/xsOSPg+f9i+Mzl9bFHIjDmQqnEQO8ZMZd73YhLATk=
X-Gm-Gg: ASbGncvfD+M7zEZDJwiA2JVs4ft/b1mHJpmthEvXrTdxD8lfuaFePnhfgu9i9+RDE5O
 vMD0VVRePVHzIcA73up1WiGeD+NZ2bLkNimPl/Q99N0+ZCFzF79f6lkzM6jI0J3YinaZxDqIfz7
 J9bl5mVWTxUS08pQ9Q6wSbyNViN3g5iym+tK/ksvbssTynk5THsmj13+cONRoQhOj7Oi1rYww1m
 SC0sRddyTYeiiMxJFJ0sh7YBQj4KquqlW4nyEikamMiVp4ZKA6Aq/rhbWJhJj+EB6qgglkAzWi0
 bf60gt48ByLwQKOKYaq+gYn7nhUH8eCQzlfUDDIwzuGiOAjEsA==
X-Google-Smtp-Source: AGHT+IHKK6JFQWug9vYvFBJ4a8Rk+0C+sAm3DKxclpu0Scvx3hqayHzrC1bAJzvTYE3VVJlq3ANt+w==
X-Received: by 2002:a05:6a21:920b:b0:1f6:6539:e026 with SMTP id
 adf61e73a8af0-2093c7e7570mr5050493637.15.1745933239392; 
 Tue, 29 Apr 2025 06:27:19 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15faded711sm8892333a12.66.2025.04.29.06.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:27:19 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 2/2] efi_loader: fix typo initd_sz to initrd_sz
Date: Tue, 29 Apr 2025 09:27:56 -0400
Message-ID: <20250429132756.2105309-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429132756.2105309-1-adriano.cordova@canonical.com>
References: <20250429132756.2105309-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

No changes since v1

 lib/efi_loader/efi_bootbin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 6a189c31ffa..94ba7c5589b 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -215,7 +215,7 @@ out:
  * Return:	status code
  */
 static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
-				      void *initrd, size_t initd_sz,
+				      void *initrd, size_t initrd_sz,
 				      struct efi_device_path *dp_dev,
 				      struct efi_device_path *dp_img)
 {
@@ -233,7 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	ret = efi_install_initrd(initrd, initd_sz);
+	ret = efi_install_initrd(initrd, initrd_sz);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-- 
2.48.1

