Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1737AC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E078852E;
	Fri, 26 Jul 2024 16:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fcxQyftI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3CF688599; Fri, 26 Jul 2024 16:00:50 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E45878ED
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-396db51d140so7686345ab.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722002447; x=1722607247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kwsPJi4hFv2YfbGhn2DBN/QxqcmAPQ85aPkjZkfeCB0=;
 b=fcxQyftI6XstgCKfk6nzAfea/pNEqUpU5oFTgpxWH/Mi67tCjH/5UkmJwJ7IyL5hu2
 fgum0+qKS3nI/NCmPZUfjSGUx9R8f7mUZVj1K7Cok2ngVK19AykJ6yMw2YqN7I8ssij6
 MytBhgGLG+h8QSijnDNJADHMAiDCr+aeDc6h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722002447; x=1722607247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kwsPJi4hFv2YfbGhn2DBN/QxqcmAPQ85aPkjZkfeCB0=;
 b=mda3eM8m1ZLq1i905OLpwUZnw5woJeU90iAAn+1snzEWMkCyicQh5kt+2l/u36ZJlN
 T0wEqTv+3PhzBS7Z2pD5ECKDV5eI+ufZN4iAvOmFWjTQ+Xa5y4VegzU+vCSGBokaNFIS
 300v14fnmg7nnFt1D7S3iUF7+Jr43erG46So/1dN06aRlplj9FwH4PshLEJDTM3MoshE
 y/1mLysT939k9uIv+h8oxazr8M/GOmu0fj3Z+bVk5v9hziAL6WpOSjPZNci8cJvXVSUC
 yz3m2UUdhMiuLdsZPxcm9+X/ZMu8kRzmJxUNIyTf7+Tgln1AHRl3Ztw4h/Vnu4EzfDq/
 d3Qg==
X-Gm-Message-State: AOJu0YxewkSg00/dbh474DShbiEjPrrTIpiYV8XNOCAjtl6E0llQGUss
 N7bt6tTEaPcm8t4wsSFuvxVIqJA0kYI373hdtU/4XFPj3fF88zMs5/jyITcl9RQFEKpEnX2Lm3Q
 =
X-Google-Smtp-Source: AGHT+IHZs04viBOdgJSU3ycYgEbcBCnv8oP0WRWMqwqt7edp3KNYgbcU/BO7mBt9KQt2QcM/4N7Kcw==
X-Received: by 2002:a05:6e02:1885:b0:381:3989:214a with SMTP id
 e9e14a558f8ab-39a23f5b915mr70569235ab.10.1722002446023; 
 Fri, 26 Jul 2024 07:00:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a22e7ec25sm14411905ab.6.2024.07.26.07.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 07:00:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Anand Moon <linux.amoon@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Shengyu Qu <wiagn233@outlook.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 0/4] alist: Implement a pointer list / array of structs
Date: Fri, 26 Jul 2024 08:00:34 -0600
Message-Id: <20240726140038.194946-1-sjg@chromium.org>
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

This data structure provides a list of pointers / array of structures.
I was planning to use it for the lmb restructure, to allow it to
support any number of entries, but then I gave up on it.

There are quite a few places in U-Boot where such a list would be
useful, since it supports growing the array.

The series includes a patch to convert an existing function to use
this.

It adds a little under 300 bytes of code with Thumb2.

With this version, use of realloc() is option and off by default. This
reduces the size growth on xilinx_versal_mini_emmc0 (aarch64) from
1765 bytes to 636, for the str_to_list() patch.

The str_to_list() patch is marked as RFC since I beleive we have decided
not to apply it.

Example:

 struct my_struct obj;
 struct my_struct *ptr = alist_add(&lst, &obj, struct my_struct);

 // now ptr is in the list

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=371258&state=*

Changes in v4:
- Avoid using realloc() unless specifically enabled by Kconfig

Changes in v3:
- Add prototype for alist_expand_by()
- Update for alist_add() API change

Changes in v2:
- Fix 'typeee' typo
- Make alist_get_ptr() take a const alist *
- Make alist_add() take a struct rather than a pointer
- Declare alist_expand_by() as static

Simon Glass (4):
  malloc: Support testing with realloc()
  lib: Handle a special case with str_to_list()
  alist: Add support for an allocated pointer list
  RFC: lib: Convert str_to_list() to use alist

 common/dlmalloc.c |   4 +
 include/alist.h   | 214 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig       |  10 +++
 lib/Makefile      |   1 +
 lib/alist.c       | 157 ++++++++++++++++++++++++++++++++++
 lib/strto.c       |  33 ++++---
 test/lib/Makefile |   1 +
 test/lib/alist.c  | 197 ++++++++++++++++++++++++++++++++++++++++++
 test/str_ut.c     |   4 +-
 9 files changed, 604 insertions(+), 17 deletions(-)
 create mode 100644 include/alist.h
 create mode 100644 lib/alist.c
 create mode 100644 test/lib/alist.c

-- 
2.34.1

