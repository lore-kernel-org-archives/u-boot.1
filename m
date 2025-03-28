Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9E5C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91179810EA;
	Fri, 28 Mar 2025 13:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mhEQhj0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713F0810F4; Fri, 28 Mar 2025 13:08:13 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 353568082A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d445a722b9so8984065ab.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743163688; x=1743768488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qabbAamFREZL8fIIsbMdv4kuhBzw8/5fyVqS+QBg+rc=;
 b=mhEQhj0XYYl4qCfQPtsk/hp92FG/A8B9usbPYt71wKI+aCZb1FDE1ogc5wHsBA1RrL
 3C6u9BYM+I7pGeE69YIV4SMgl659Ef12pn2wOTrWFYOUqKWVzouv7i36jKpl8xw4AEYg
 X8AhpA/OKAl1Jpr4k0/jbVZzut2SVMLfz0L24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743163688; x=1743768488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qabbAamFREZL8fIIsbMdv4kuhBzw8/5fyVqS+QBg+rc=;
 b=SLfW0D91G96KKYkkOZawkP0iKTJ2do2GvJe+BFz2g0m0bOA3RIKzysj2p2aaLR0xX+
 QwN3wVOftZ1TeJk/FCELYyfwRTZcw1QH+ua+DcuQQMqLgGQtbp66J/8a1xCxRaO/QOkG
 mh3ow+Co0Z5FPf6RH0pRDcs5ZNUbIVBrczHAPlMqmuCsEqaQGl4zbSgDI+dkX2UkiUkU
 fe5euRqtwG472FMvkb2Oakn/0LiKetxOxY5DDWXiKuKZ5jJix1wyrDl3C8pxM4cle2La
 jEheeBLT0kKJhRr73Cj0Kye0JXuG5HBmzZnJLsXxQC2cWsf4vJBR/CaWC3M/zzvFIX0N
 Fyow==
X-Gm-Message-State: AOJu0YwPY7LNhA0/3Syau56yBtftPFJw4LvsiVsQPOf/Y5r7nwklUfpt
 xK6aqBrCyfMAL13BxJ/yQF2OiQc5/FGrNFgrtoE7pJKZTwAsZ7w8RaLiq7Jz/MaxIsSdlNG8BNw
 =
X-Gm-Gg: ASbGnctVHp/fJUQfS3NrRJbrhWnf9lkkzgr5+3DeX8/FJYUzUwpJCTHygIEu++8AIGY
 k7uEvMu0mCcwWyWszsofr82VuQqXI5jG6f52QFcZg0x994H7JE2R0/LxwSQQ8SK8jrmC0Fe4xgd
 F0QPGFi1+MihcZMFaJxBH0gfU+/v8O6Odnvn17gRbHviyJHHpXCwMT/t7vXyp6l0GCEYTMt2PvL
 gMBjL1Iy72Rt3o/BzyM0DUlNc9kUuPBl9F2U7SSlJBoKRnc0dvtsIw4ZvtGLYlpKCKl968+LX3i
 9RrNpWcLkhKWwUOvYSFi/tiQ7OCnC/X4rhFIIMfvuf8r7xrtWdxEWiQck/CtqvfQ7qI1elxCBfC
 X/6+B6Q==
X-Google-Smtp-Source: AGHT+IHubIb9y8AsoWAIEgAQUQhjHVJSTzoVf6RjaMXgcZACF+VXYJBDuui9HcSsfplAyUgBVDUn6Q==
X-Received: by 2002:a05:6e02:746:b0:3d3:fdcc:8fb8 with SMTP id
 e9e14a558f8ab-3d5ccdcaccfmr80972715ab.10.1743163687993; 
 Fri, 28 Mar 2025 05:08:07 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f464871894sm406344173.91.2025.03.28.05.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 05:08:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH v2 0/1] efi: Tidy up nits in the ARM64 EFI app
Date: Fri, 28 Mar 2025 06:07:41 -0600
Message-ID: <20250328120802.2562751-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Some comments on the ARM64 EFI app were not addressed before it was
applied to my tree, so this series provides a fix-up patch.

Changes in v2:
- Add a cover letter so the base commit is provided

Simon Glass (1):
  efi: Tidy up nits in the ARM64 EFI app

 Kconfig                           | 2 +-
 board/efi/Kconfig                 | 6 +++---
 board/efi/efi-arm_app/MAINTAINERS | 7 -------
 3 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.43.0

base-commit: 794124b3258831768a6b8ef069253374b877d59a
branch: efir2
