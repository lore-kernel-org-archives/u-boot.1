Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD28C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB81880FB;
	Thu,  9 May 2024 16:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lykeHA+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A34088054; Thu,  9 May 2024 16:38:05 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D8858810E
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6ef98eee195so253179a34.1
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715265481; x=1715870281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2u+JFr48lqQW3khtQN88692erGm8L+75uAfk9fXF1TI=;
 b=lykeHA+wpda+k4+Pbzt7Whqg5Wfv27Q8RlA2sfVQZBQPCvPwq6zDUmzYND4XzWzPgZ
 7WtdXDZagkEXs3dg7HCMIFSGFqXjKgoIOHrnNr35KqxRQxZHV18NIEps190NATJ19l9Y
 JjzEvzPsvAgy8QgqGWasrhukwgQwmkVTI5BJf9LO6gyog34iza9tnR46DtVPNpBz0Iu+
 i0yZrKC7AeOVUfU5cwE5VGDxQd8fjrWDGlhGVu6WJimLEQyjm74RfULAWiWsAH5S/EbX
 KxOWdkssVkV/LqJvSqR37JMEqOtR8go8I0UdQOHegfBstfMI7yZX5XauUtN7+h0A4xgB
 SXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715265481; x=1715870281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2u+JFr48lqQW3khtQN88692erGm8L+75uAfk9fXF1TI=;
 b=vMHsA/ePoZ6k8nLrLyX+ycQzb05QBz8ZpIQlPh+rpLkeDVDQPbyulk+KQ2JTyLRAkW
 mB36hPj3DtARXSr2jBGLefk4QNrRAXay/OHOZnVi0IdacVbaamVlYSZAxAU7izjHpIKH
 FkFOSoCL7Mo8zBiMU0L6u+8syrrXKe4g6xR0rXgehO9E8zhZMRa36OIi92VtVmk8N0Pd
 vyC6QZBMKXN30uxAHS3X3HLHbSKTu8gcX/89weXV6Ad0u66uu4BNaVWmAAdthEssWD2r
 ESMvUdTIJ7UHKrO0aA3EmtPMcxKzW2O8gSL6+gqkZIm1ZwXO+MLRsQFaGbBBRIZSXlFB
 1UPQ==
X-Gm-Message-State: AOJu0YxQWAio7/iKaeyKaBtGlFtSIXwTZ5McChXPcWfLIj+/Jov6Ts5I
 mVTWHOcZvOZ/D8xHzakl7seriMDOaLAMoyxP7g8c2HuCIoYDogldN+SoVoMPZTiUAQvAYmegFKl
 5
X-Google-Smtp-Source: AGHT+IFJfmaqd5/SEueZuHCmHbFcKw7HxvQ4e40Ks1fVukwcVuFjFr7CEPwHh8qT8gM6nusD545OZQ==
X-Received: by 2002:a05:6830:1be3:b0:6f0:396c:86f0 with SMTP id
 46e09a7af769-6f0b7939545mr6031735a34.12.1715265481658; 
 Thu, 09 May 2024 07:38:01 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf275b07sm74563685a.24.2024.05.09.07.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 07:38:01 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/4] image: remove redundant hash includes
Date: Thu,  9 May 2024 07:37:38 -0700
Message-Id: <20240509143743.1496210-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509143743.1496210-1-raymond.mao@linaro.org>
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
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
index 89e377563ce..1efc39f4408 100644
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
index 073931cd7a3..e57d6eae52d 100644
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

