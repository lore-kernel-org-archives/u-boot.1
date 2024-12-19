Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024F5E77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96F080291;
	Thu, 19 Dec 2024 03:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gWxUZVe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EC380295; Thu, 19 Dec 2024 03:39:03 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 169108021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a7e108b491so2269395ab.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734575939; x=1735180739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NElKRjBXT7IO/dUzlPhtwPjH9yQt+7Rf+JeNFz4MYZI=;
 b=gWxUZVe+PkMzbP7DkvFWV+GWHb0mrrWZQA5Yo7L6+JH1rrQ2ac96tZcCmo8lixv0aC
 LMA8GuFcP/b9LrJ3/ZWSZTeXeBOBugB7aksU7/NEb8UD73R3IfU+mEcACXkALr0fF+It
 7z5KJAoNO56uLA5khZMtnnxCpIp6gce+hi82Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734575939; x=1735180739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NElKRjBXT7IO/dUzlPhtwPjH9yQt+7Rf+JeNFz4MYZI=;
 b=pqGuJ/O/9JzCHdrTvD/hz5Ok3PguN0NMeWb2o+XTM4olodUAr20/qfh0wUXuEmffTu
 rwjzI34aYjp+BKj9zylpLTk37lVZRBUQ64jyWd1skzq4oLLq9VJ0g2Gv0OO8Gl51uDxx
 3yJfDgZvQxrW/Hqe3vI5a+X6h7zqTKKkBhnDmao2d4PiL37brUHNDldMo4PAtj02xLWx
 ao2OJly6OQmjcZM/UO3ioxXdjQml+KRxD5EH+8G6JBxw2nWCPkwY7Kr3S0QXwk8aKDBL
 JAD2g9yjQSi+cF4kxKkH88pSZ5hlfGyDg5N33uwuXDDY7o4gNKmCBFTjjX7cvppQDwjp
 Oe/w==
X-Gm-Message-State: AOJu0Yx5pWXHseMI4Q1dNf1sbEhN4w08/V6Xk8ewc7lK7hruK5IPGuEe
 WbUQuuRsimsnRPeKaN/95+WF0uEdlpWuiieXiaQLo88u2/qKRmsuG3tlHIJVH8FGBCyDI4uraRk
 =
X-Gm-Gg: ASbGncvY8CO29oGdzYTBkVMQnjPWkzVuFd1a4mUK2bXk4eWfs2T6lp0uuh0kiX4ifQT
 o3E574+teaiDhdluxPcsImY7zdAGcj3zzyoVKCkEydMGs1QQHhwxyueCqZW7pYjPmMaUIxftZsA
 VSMvxNRpVYeaSb3kNYHVxnhAehsvE0ooC2KA+jJ1vBUHtS0axr5pQLzO4Q/O4UGWMRpg9VKh6Wa
 FFvY3zPSsc9Bjeq8wI7Y2nePpANLD9zof3c3tehU++LxI1hyJYhZXLgFRcjX9xFjTDxmYet0uoD
 33Zkn0+3EjjVTMu0zg==
X-Google-Smtp-Source: AGHT+IFZNFN8xJovv6mNg7AlGknATqf9SC2KFQxP37PHu5KeTe1xA2oL5V6fW8fTnPJ2AmQ9glLYmw==
X-Received: by 2002:a05:6e02:158b:b0:3a7:e286:a565 with SMTP id
 e9e14a558f8ab-3c0148947f4mr23092035ab.23.1734575939285; 
 Wed, 18 Dec 2024 18:38:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6cdcsm712125ab.71.2024.12.18.18.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 18:38:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 0/7] efi: Start to chip away at the EFI workaround
Date: Wed, 18 Dec 2024 19:38:25 -0700
Message-Id: <20241219023832.1098689-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

At present there is a function, efi_set_bootdev(), which is used in
various places to tell the EFI loader which device a file came from.

With bootstd, this information is available in the bootflow.

This little series provides a way for bootstd to provide the bootflow to
the EFI loader, so that it is able to select the correct paths.

For now only the EFI bootmeth is updated.

Changes in v3:
- Make calculate_paths() static and add a comment
- Add new patch to support PXE booting
- Rebase on Tom's tree (i.e. without the pointers/addresses series)
  https://patchwork.ozlabs.org/project/uboot/list/?series=436241

Changes in v2:
- Adjust argument ordering for efi_run_image()
- Use efi_loader tag instead of efi
- Drop unnecessary path removal
- Fix 'require' typo
- Move calculation of dev-name into a separate function

Simon Glass (7):
  efi_loader: Refactor device and image paths into a function
  efi_loader: Make efi_run_image() static
  efi_loader: Update efi_run_image() to accept image and device path
  efi_loader: Add a version of efi_binary_run() with more parameters
  efi_loader: Move the fallback code from efi_run_image()
  efi_loader: Pass in the required parameters from EFI bootmeth
  bootmeth_efi: Support PXE booting

 boot/bootmeth_efi.c          |  64 +-------
 include/efi_loader.h         |  10 ++
 lib/efi_loader/efi_bootbin.c | 276 ++++++++++++++++++++++++++---------
 3 files changed, 218 insertions(+), 132 deletions(-)

-- 
2.34.1

