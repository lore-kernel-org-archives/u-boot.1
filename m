Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381FDC04FFF
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9FE88447;
	Tue, 16 Apr 2024 21:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u/i79VJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F4A88441; Tue, 16 Apr 2024 21:01:51 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E438843C
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78d5e80bc42so402974085a.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294104; x=1713898904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKsemSYec8nbeZrYdOQd/Bjd0bqAzMcohprE2stx8Bw=;
 b=u/i79VJp9VNGH0PSes3mxpOseLIhnsngOT0ni+2ey0yEh21W4etw79fYA4A4KEmjne
 XyrBSiZ1B1LfyK5zTbHXC33MRF2vC9uOt+odMdjMS0/p6tNMt0XMAaoMX+Hh5sjrYlkf
 TgLUZ5QTtA3SVSQ9o2ALWH90q5zozS9NOK+GYHCWFvw3aqw9kQbV+bWbsPk85wMjNzSY
 4K4Sg4WHuawP1hMQD0kO5p17GKJ5K/VEZbe9Vs6yw98ZXFTlKKnyOt4OMbjyBrL18MB2
 wmAzLMSw/TZLa1yNfdoWyw4AM6zp+b0nalTEZ3yJzQTSeILnw1GKoTNVKtB2gCOW1BTr
 BvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294104; x=1713898904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nKsemSYec8nbeZrYdOQd/Bjd0bqAzMcohprE2stx8Bw=;
 b=KjMseK5kQ6ANatY711bwTWcro60jlom1WWciDhB+WUGD6yPOMFe21bFfldpQtLehj9
 voQdrbOUgqXMwS6ieF+3hWDYI2QKgJFO/xA+EKCmwGJO0UxEjTSkotJWEtjp6J5ISk4S
 gNRMED5AcRx1C9vyntA8qsVnOBqqFyXftYwOIl4vHPXxi8jkxmFtS7BSEPBe7Ea3CM84
 OEgdqWmct9B/g8RcWhm+YO6xmtBaPVM5HXAPvKW1Xl9CPq/u+sO1sjdIIMLZEe9BsxHb
 w1HoDY2FZV4TasQQsOYTlaOVnydfIfhQR0K04kSRL63oRdnithWU88gmvQyGjLA28Gtr
 9n0w==
X-Gm-Message-State: AOJu0YwRItSNuyr33Y8kE6dJTOJ9i5Xvv47AyIt1Iru+Tea14hiFlYAh
 9N0q6jW3LDuYd4NhTG96rQS+aVq+CrUJpVh/uaXXi2bPAaQzzE5WthaaEFYz3SicpQO91J/Lskd
 r
X-Google-Smtp-Source: AGHT+IG3jAlkTB/7aWljYMxUkCUBRJxyDBpvNaBwmRMLQH+mQut1QHi7yle25DOeWCsb5x64spgFvA==
X-Received: by 2002:a0c:fa84:0:b0:69b:5e44:59e8 with SMTP id
 o4-20020a0cfa84000000b0069b5e4459e8mr12226971qvn.37.1713294104535; 
 Tue, 16 Apr 2024 12:01:44 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:44 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 06/23] image: remove redundant hash includes
Date: Tue, 16 Apr 2024 12:00:02 -0700
Message-Id: <20240416190019.81016-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
u-boot/sha256.h and u-boot/sha512.h

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 boot/image-fit.c | 4 ----
 boot/image.c     | 2 --
 2 files changed, 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 89e377563c..1efc39f440 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -38,10 +38,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <image.h>
 #include <bootstage.h>
 #include <u-boot/crc.h>
-#include <u-boot/md5.h>
-#include <u-boot/sha1.h>
-#include <u-boot/sha256.h>
-#include <u-boot/sha512.h>
 
 /*****************************************************************************/
 /* New uImage format routines */
diff --git a/boot/image.c b/boot/image.c
index 073931cd7a..e57d6eae52 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -26,8 +26,6 @@
 #endif
 
 #include <asm/global_data.h>
-#include <u-boot/md5.h>
-#include <u-boot/sha1.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 
-- 
2.25.1

