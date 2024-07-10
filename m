Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B19C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 14:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3269D8870E;
	Wed, 10 Jul 2024 16:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LylNxxdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A4D6886E8; Wed, 10 Jul 2024 16:39:01 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7203588709
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 16:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-36799a67d9cso5104503f8f.0
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720622338; x=1721227138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JVXHRWgqR2GbHaS+79FxLbSVDx9o4QqzSRGvXQy4Bh4=;
 b=LylNxxdQEbfYB1V7sF72KzcN6ZYKYdXGRjmoHD2xrStgbOUSIoISwwYgtkVdTaUpYl
 23aFC9XAes+l9sD9hiwMG8KSkTRs/q8agC6ifAmLNZ+cboUqvRSyt77dkGhn/pOkH40E
 Iy5s6JQECcGA44eQ+r/IKh9AaaiPczEOWOXiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622338; x=1721227138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JVXHRWgqR2GbHaS+79FxLbSVDx9o4QqzSRGvXQy4Bh4=;
 b=qpp25sPBDTvGk7xlRFTvSau0uqNuhUoKzgSMDIZpQlBlkYBRg06vtl9Ed4FS4O4zbQ
 14Jwya66YFfUyxOw5c5G98G0NDuOKdpPL/5ScmIYsjjv4Yo29Pz38FZDkoXBheG2cZbn
 HHkKLOfyCdlNUteklTfg5bW4y3MAzr/c2qRTM3du5gvdmhcoyZ6pBcUns8wmCOgk6aHK
 4Bs6e0unqELcjIMqRveoOO8Nn+05FMaWBpc+2eeJ0GSsCCAeADQE8+lR33hMH1hBZQMW
 dsSztFmoSumMxENtoGyXmXxamxBtYOQA0O5jAAow1x7qUMuOU27xxl34BM8LAJ9apb/i
 kAPA==
X-Gm-Message-State: AOJu0YyqK0lgbV8T0IKtBifmXdssuPMZlL5X5EAOGKsQ8K5+N38WYuGb
 EoMTY/m9GVOXrEaPW/rkric7a49bvM3p1QEqSTJJkK01V+4RdJFZKedxwMlvLLY2y028FQUB65k
 =
X-Google-Smtp-Source: AGHT+IF8LXd/gr3jMCzudWXpkmYCFs0WhxMiXUvBRr4Zclbvt+ErFuQPRvBOf5HHerrrNvoFqyP02w==
X-Received: by 2002:a5d:64c4:0:b0:366:efbd:8aa3 with SMTP id
 ffacd0b85a97d-367cea46767mr6585994f8f.2.1720622337520; 
 Wed, 10 Jul 2024 07:38:57 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa07dasm5471374f8f.87.2024.07.10.07.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 07:38:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/4] alist: Implement a pointer list / array of structs
Date: Wed, 10 Jul 2024 15:38:50 +0100
Message-Id: <20240710143854.3905259-1-sjg@chromium.org>
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

Example:

 struct my_struct obj;
 struct my_struct *ptr = alist_add(&lst, &obj, struct my_struct);

 // now ptr is in the list

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=371258&state=*

Changes in v2:
- Fix 'typeee' typo
- Make alist_get_ptr() take a const alist *
- Make alist_add() take a struct rather than a pointer
- Declare alist_expand_by() as static

Simon Glass (4):
  malloc: Support testing with realloc()
  lib: Handle a special case with str_to_list()
  alist: Add support for an allocated pointer list
  lib: Convert str_to_list() to use alist

 common/dlmalloc.c |   4 +
 include/alist.h   | 205 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/Makefile      |   1 +
 lib/alist.c       | 154 ++++++++++++++++++++++++++++++++++
 lib/strto.c       |  33 ++++----
 test/lib/Makefile |   1 +
 test/lib/alist.c  | 197 ++++++++++++++++++++++++++++++++++++++++++++
 test/str_ut.c     |   4 +-
 8 files changed, 582 insertions(+), 17 deletions(-)
 create mode 100644 include/alist.h
 create mode 100644 lib/alist.c
 create mode 100644 test/lib/alist.c

-- 
2.34.1

