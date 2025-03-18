Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4FCC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 13:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C276C8193A;
	Tue, 18 Mar 2025 14:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nAItLjuu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F4428197F; Tue, 18 Mar 2025 14:23:46 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467C38197F
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 14:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225b5448519so104524765ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742304223; x=1742909023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lhQbtuvXZEHfiKoT58Wd7jpqAX80TEeVtk3pJPiXX4=;
 b=nAItLjuuAsuhEj4gf6GPDQBmXoXZtU+noFafL/DGgR1aXXXuXVSpRDYEOX9UJkogoW
 W0rCaLVIoBB4szTXh6ce+PZB841k9wyxG7vCkveSPrElpGBZpw4J76PdeDUk0V+ehTOe
 WHDOkJ6wx5S/aZQb6c9zGmEiidUMf5jAEYAzwXvrSkWRXzyzgtVJ5v5344ARZpJpZkvd
 N+/hTcAUhZNcqusBtJuXyaJC02QwgkoHNaaJyoA1c382ytjQGuDyXCWFlEL3yfXqmgv1
 xc/3BYt9A5GmAXcMMchj9ousPAyMHICwAJBQiVukHenQzl3lI1qizXvLQUz4hOWY+Aeu
 m4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742304223; x=1742909023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lhQbtuvXZEHfiKoT58Wd7jpqAX80TEeVtk3pJPiXX4=;
 b=I6n5YRowoN1eawQCuKGS9jOmMtSXtZZd/UW+gtYUaQl3KHow0XtKnDR4F1Iqquxo73
 N/nIIE3KLh9wqo6mzRbddawAMQT2KoXe3IDpHmb8ZWx4V+5S9gdtJk4gkC0+TFH3959M
 6tCMTR7YhoxCSILWzbiVd0+KjVocwmSzhV8HriCEMHe15dKHpNjK+oghZ1XW6PNoyFO8
 lyHrC+cUcLVsBrovUwU1xkEdfaV3nOd2z8fz7D6nvvGws6ndXL6TynYKF+VwnIjN2Q5N
 w/YKJS7T9zrqX5gTVGNV01mHiGfpOyIuis6r+67cu+JVuaYDz7znvKOTamZa9s03j4GL
 5nmg==
X-Gm-Message-State: AOJu0YyF8ZYZ0a1Ney7Ag9lKGB1nxXJN+PjmJ53CImkTqaVFfMp8sHHh
 dsegHPYyd6x5hED5Fmp0xW7ADoIR6QtN7oq2M/xlznvLh9CWw1C8SJrWeyrB7Ts=
X-Gm-Gg: ASbGncs+BjyipbV/hLOg1RXC+uL8de46PHVxuqPPKt8TyJ3IhcvCcVOPMf3MPoiTQ8X
 mHW00RyOEtQsqahsBJzr57EfADFhXIwxO8bWobFAPTKnacvGIDRGiuiZagHAk5kIEO0K9YT9Dnv
 Np5WtZQ7ey8eFLVi0WscBq6jiP/t28aihF/Yik/6eq4yrBf7t5LnoP5MLtIF0h7IhXR8sWeF5St
 46v86SGdh+3qd7OvFx+Al/mdXNZ2VtFbYlt+1ZU9DrjifxB1DEUEJlxFBCc8GFplklBYIwhJvUS
 zuTh5E50wqCaCYkmbB8EBUhy/IPwjFepP2d89MjF1Y4MY3hJjcd6HfoSdTrQCMyiq7s=
X-Google-Smtp-Source: AGHT+IFV9dUrWwhSubZ/LlQSEYZVsNKVDkJqkIGHY5Zvo8UdaE5QegQDhjpeWlzHyQzjxeHH/0jpBA==
X-Received: by 2002:a17:903:fa6:b0:224:194c:694c with SMTP id
 d9443c01a7336-225e0a8f166mr211591835ad.28.1742304222678; 
 Tue, 18 Mar 2025 06:23:42 -0700 (PDT)
Received: from adriano.. ([2800:300:6f53:4a50:2bbd:7872:4328:2b1c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba70f3sm93685945ad.157.2025.03.18.06.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:23:42 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 3/3] bootm: add support for initrd in do_bootm_efi
Date: Tue, 18 Mar 2025 10:23:47 -0300
Message-ID: <20250318132347.646703-4-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318132347.646703-1-adriano.cordova@canonical.com>
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
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

Pass a pointer to a memory mapped initrd and its size to
efi_binary_run. The EFI stack will register an EFI_LOAD_FILE2_PROTOCOL
for the next boot stage to access this initrd.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 boot/bootm_os.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index f403f352be1..35a32f8c912 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -508,7 +508,8 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
 	ret = efi_binary_run(image_buf, images->os.image_len,
 			     images->ft_len
 			     ? images->ft_addr : EFI_FDT_USE_INTERNAL,
-				 NULL, 0);
+				 (void *)images->initrd_start,
+				 (size_t)(images->initrd_end - images->initrd_start));
 
 	return ret;
 }
-- 
2.48.1

