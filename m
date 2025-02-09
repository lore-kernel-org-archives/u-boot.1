Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4862DC02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3081280AE3;
	Sun,  9 Feb 2025 03:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m3NyjrTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC56880805; Sun,  9 Feb 2025 03:02:55 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C90C80050
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844e9b83aaaso264477539f.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066571; x=1739671371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1Rp0FsdFFw0i+QGrqFf3TguYwTXCiGcYk1+kU7AmkY=;
 b=m3NyjrTNw9QJ8DXqHkV7T55Gskll6Lx0AKA3mr5woZ/agwx1IqxeIWEFLKW/6XC566
 HjShhRuXAiOzcQFuY1BxnB05nFWOiE6ouiEuw1UhD6nK6h+F9wFyF6ilTJDTyee1ZUm8
 iWH2FJ43pwRk1eI+L5X8ALxPjYxFBxqx1bKSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066571; x=1739671371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1Rp0FsdFFw0i+QGrqFf3TguYwTXCiGcYk1+kU7AmkY=;
 b=WS+leciPFrqu8YkuTOO0QheoUHKfLQgKgDaJ7ICuhGvDTaPngS6G8GgKAAoRHtzMTP
 8Y9zUycb6pWii6VJEWR7P8I4haDM4f/0PIOhuakacLYy6dp4V0Zkp6vdiWdz0+Hsc/SU
 IzGXjw/9klCduL9rbiQQ4sWbMLnPzH7ba4dKoTBEla58X3pMN4c0kyaYAJl+zY6fADVp
 bys6Xirj4Gxlohar0YFpL23WSpeFsOvK7+aSHShxal3QJdYy9g3dBWx/KoQ4JQ1UPFiM
 83Q8p9L6+vh+j2zfVbkpGnEJ5ec8Lw/NSoXeLoV3/9sBB3I9iLJ8wp2c+C3ZdijpVt3o
 bOEw==
X-Gm-Message-State: AOJu0Yz5XgJ/jjdXbNKlVkXOvRFCs5uF8ofvIsLX5FnpW1/chmdQbKNl
 Z4Jxih5pinVtVOI3H4yWC05xcqSqdgV4OSdj4mhJ821TKwHygdGoBvLRa6Nb2vN0HNYPLqzIMhI
 =
X-Gm-Gg: ASbGncuucsGKv/pJwXX5oaHgJt7tefGY91BcS53UeUg1/UL/lIPTPfblAVLnwZripEJ
 Svq4R6qbzRvYZLgvBIXoZmQ+WHZJgDWl4BuWCdFFxNQZ730sZcXDzVEBeolI7XL5jMM85EdXH2k
 xKOTpQtdVuScdSoJnteYkFU02/XGWs0bMqb0UdItt2YalPCLhrWhmU0DjOJ/lUZG/CjVGNGxL0g
 GLKUtO92cKo+l799QvZgGUszqTqMJ7Set7LAIWalyXfkpZ+ocF1J+P6bg9NHDJc0+q+Cn7eeCZi
 4kUD3H/4PiJdwNx6i6lsmmH3ay/e0hpTZQBF9OLXWFuaC2FH/qYN
X-Google-Smtp-Source: AGHT+IHDdtSR0GuAsdpyCvLOxtr3iiz36B402vQpYcUQC2fXvw0z9sjJXkmupDumd6oCBH3PIQ67RQ==
X-Received: by 2002:a05:6602:7289:b0:849:c82e:c03a with SMTP id
 ca18e2360f4ac-854fd8f508fmr779961939f.10.1739066570950; 
 Sat, 08 Feb 2025 18:02:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 25/29] efi: Generate the app as a shared library
Date: Sat,  8 Feb 2025 19:01:24 -0700
Message-ID: <20250209020136.4108987-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

The app should be built as a shared library, with position-independent
code and the -shared flags. Update the Makefile to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index f989c31073f..b3b13e29c26 100644
--- a/Makefile
+++ b/Makefile
@@ -452,9 +452,13 @@ KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
 KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
 
+ifdef CONFIG_EFI_APP
+KBUILD_CFLAGS += -shared
+else
 # Don't generate position independent code
 KBUILD_CFLAGS	+= $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS	+= $(call cc-option,-fno-PIE)
+endif
 
 # Read UBOOTRELEASE from include/config/uboot.release (if it exists)
 UBOOTRELEASE = $(shell cat include/config/uboot.release 2> /dev/null)
-- 
2.43.0

