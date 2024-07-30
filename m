Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52088C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F72888868;
	Tue, 30 Jul 2024 16:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZWkKwpWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CB688860; Tue, 30 Jul 2024 16:40:02 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5B28882C
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3737dc4a669so22259675ab.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350399; x=1722955199; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qlaVoTHn0JIJYDAUSxXCgLxOaeuXC3sTfhLozA+txD4=;
 b=ZWkKwpWxH4O6KpXth0wojTPC9LJiPXVmcH58ebF03xkXhqjfvEEq3yg4UQGEG3hRlx
 lEEfRzapanX4n5Uv2641gjovh3o/2Bh4K/mlBNURXJ1ewXwWW6buQz9ZSsaSt6Cqb8ta
 Si/578BF7jiRr3ug0RzLo2pJCcGnWm3I1MmBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350399; x=1722955199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qlaVoTHn0JIJYDAUSxXCgLxOaeuXC3sTfhLozA+txD4=;
 b=oqEBoxfgtHRM5klUiLiebQryqKCxVwBhaqH+J8IYcD5xg+RUCI0JxPzrHlp9G7nb4Q
 DXEK8vYSAczcNae6qUSRsflmgxXHzjhCGpkJlzD3eIx35IB08PSQ/by6A8sv9Zy6UcAK
 jK8FjhsC7aQAV4n92F/JKGo6slmnX7pQ0i2XjgoTKa5xvc1mlA7EfY5kW4yc2fpuf4mH
 FL8sKrogpRkjU5I7qqLz0H5lPk5P9yzxSd322t5bXUNxzZyVSjVZFwC1V1Ske2QZRVQc
 DQaS56UHqL3YB4CDI4ixOvi280jhCz9N7N2FlX1Gq9cvJs9++bYCpGd6TScVvUVxyVvW
 MVgw==
X-Gm-Message-State: AOJu0Yz4p61rk9ABhEDYQYAFoTHeSSvSxK4yPw4Q7rbvoWtCJz0FnDba
 4kJFs+ld8jfZ3XlUQugW44Tf6/edMZawCGiOqtgNR/Syo4o4IwWlTsRKZ7yD/ftnE9cmB3KQW+I
 =
X-Google-Smtp-Source: AGHT+IGW1oDPrnaSqjc+Rc1B2wWiMvNaes3j/R6t/O7UnkXz/gJjv3YqN66GQcBkZobvjEkHO+174A==
X-Received: by 2002:a05:6e02:12e2:b0:397:95c7:6f5d with SMTP id
 e9e14a558f8ab-39aec2d866emr150044315ab.11.1722350398861; 
 Tue, 30 Jul 2024 07:39:58 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39af4bb209fsm23369925ab.5.2024.07.30.07.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:39:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 0/4] alist: Implement a pointer list / array of structs
Date: Tue, 30 Jul 2024 08:39:34 -0600
Message-Id: <20240730143938.3991937-1-sjg@chromium.org>
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

Changes in v5:
- Drop use of realloc() altogether, since the benefit is small
- Add alist_add_placeholder()
- Drop type argument for alist_add()

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
 include/alist.h   | 228 +++++++++++++++++++++++++++++++++++++++++++
 lib/Makefile      |   1 +
 lib/alist.c       | 158 ++++++++++++++++++++++++++++++
 lib/strto.c       |  33 ++++---
 test/lib/Makefile |   1 +
 test/lib/alist.c  | 242 ++++++++++++++++++++++++++++++++++++++++++++++
 test/str_ut.c     |   4 +-
 8 files changed, 654 insertions(+), 17 deletions(-)
 create mode 100644 include/alist.h
 create mode 100644 lib/alist.c
 create mode 100644 test/lib/alist.c

-- 
2.34.1

