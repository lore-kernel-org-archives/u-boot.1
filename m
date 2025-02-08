Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B700C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE7DF80EE5;
	Sat,  8 Feb 2025 18:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DOV5irdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1C080EAF; Sat,  8 Feb 2025 18:13:09 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E31B8082A
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-84a012f7232so121793939f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034785; x=1739639585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1Rp0FsdFFw0i+QGrqFf3TguYwTXCiGcYk1+kU7AmkY=;
 b=DOV5irdfcCxCnkSBf1radChIz7QsVT9yoUeNCyRGbJreGN197ss8zuVF7IrIR/aJLn
 /truzTIqlym8iX8AKwUYlbcdpLsQAO7XiSArznpEOXeeE29TOLYUfcQ+Lrs7JCXi4bNR
 uaUhRbFsdFLmN9JSKKDKdNeeYZNIYDJj0TG6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034785; x=1739639585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1Rp0FsdFFw0i+QGrqFf3TguYwTXCiGcYk1+kU7AmkY=;
 b=NGCU2/ViQ0aA7WwNxAvZusPh5I6mqHBPhwVaW69TA0+Usv5OpMMPDgbKzx7iT2QlLJ
 6Lox7L5VCw5E4Gxvi0fBdAgW5T+HaNs8ygagibVh58ZLDTLo/ZNV9jGKYJX+VfvZn5Jf
 6x6cneh/01QlFVBXn8WycGmJf6ochCJAg7t9K/qKRBpxBBO/BmYIXmCb0osTpf9J7/5y
 l5i+gaNbLUIkCyY1jqyjIYbQ6vS3xMGXLUFyb9t8yQf85AMp4Am9eSPaoLqNe6KQtP2p
 /L5WZFJi6DYX06HklQWoxjWeuUmZXigaAdCjikOwTay7KuhB5y7kVv53jh14EfAfj3qb
 /s8g==
X-Gm-Message-State: AOJu0YwEnUcKcVJA0oi88XtgWbHkC8nYtRC0QfSWAQEBttFj/NAKaRW1
 ZEH6O4Ad6LToZBeXcVZzaFFlvVd1R+/n3+ZQS5M2G9cskHEcffdFrc5CBDNjxIXKq5Yoh2TQLBI
 =
X-Gm-Gg: ASbGncuSdQjhwsGpagCgkW4AnDGVqqgkHXZwXMbl4zCA2j0MLDjK18AwtuF7Uv4IBCY
 XrUOttDn9aCS7jVXgDoduz1sX8/lOSNSGJBn0VdvYDvPzX+boNRPD1vJk97fXFyQ04e7cll6F/p
 ngtHG35U6HsXGUtWULgbNQAofFEHaDY03CCXuGhXEzdZqF9/XLXq7bIYIHpWDUs8pEQlp4E3jqW
 Vg8PmcGkFQpQxBjFBYF6V+jbliVP4FWckoziPkAyyAiQe6imvdgK5/5gvF3SAoIE7mtzPGVAgNP
 u8q7yqEYxTVlKx9SeaenyXJ5yibxE3nxdVTp9Cd1k7+T4vFIm9kj
X-Google-Smtp-Source: AGHT+IFdjyFT29jhvLV9kn3rdgLA6KtAomp0TMxZtM70tcfktXCVsrp2SqhxhrPM1Lxxe1Hu0GyHwQ==
X-Received: by 2002:a05:6602:4802:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-854f3a4cadbmr1203895639f.5.1739034785415; 
 Sat, 08 Feb 2025 09:13:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:13:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 25/29] efi: Generate the app as a shared library
Date: Sat,  8 Feb 2025 10:11:45 -0700
Message-ID: <20250208171154.1305761-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

