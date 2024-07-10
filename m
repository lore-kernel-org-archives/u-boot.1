Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6E0C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 14:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D3DA88719;
	Wed, 10 Jul 2024 16:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hc/Vhm7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341EF88702; Wed, 10 Jul 2024 16:49:39 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C964F886B6
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 16:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ec1ac1aed2so68769601fa.3
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720622975; x=1721227775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9E0JMT6cj2PIMFLADV2UzwQGIpCukNxRWCSXo39eUdo=;
 b=Hc/Vhm7auKyge5uKFxFRb5dF6EQXqkxhLWqa1Zc8cQ9IneDDUQkNXQpmvaKmNWchRK
 g34mJPpvTRmNxz89vV8sHhoTw/uyn3hq9d0YqGjXEn90X3RTmmGn7uonShkweetrOfRK
 kUhT/4l67dHskPhV0sZYPuvKZu9WqKUaslxyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622975; x=1721227775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9E0JMT6cj2PIMFLADV2UzwQGIpCukNxRWCSXo39eUdo=;
 b=U3X5vEPaBwDliAcfoLu7t5ymi9O7fTTp8hPeBSuP9xFoBh3iq6ZpUYnbv3V/Il8qkp
 Agu+rJNtmxXQzgrRWGTND6tqRHyo23hdVCMwAVlg7baxVFFKwUwHqjd0JfgaB0nD00yH
 Puvc8UaxiQCYLGW4RcxpQsGoJvrrbKu2Xs1kOzcDo2us5+lWv6zXZmBbzG71AqZNROFT
 nIIG+z5CQihJumRpG/oqoovt/bbX7sFf1vZlHyuSp8zvVEh1oHGCOYWcVPBjWfj8WDsq
 wQVFxGgCN4Yz0KDLwmBWwYZNhpYsoN1EIgz6LEUgCmI6KvtYMnOYYvn+JXBaZR9RBD7I
 otPQ==
X-Gm-Message-State: AOJu0YyZatI7uj185QP0jzXrSnJLivO1Oq6Ii8F3X196LId1kdlE6Puv
 H6WPyE14ZVWDtvq0ih5fnclqZSS7bc/BiH/mRKoCDH2OMids1x/Rdo3El9uuOu77Eqv9j7zXKJA
 =
X-Google-Smtp-Source: AGHT+IFwe1Aa3TrPrvV04yQav/3NdQEfnU+pzPBJVXmkSpDMqqQ/YgGlUfaCZPEwGSs+9atpou3LLg==
X-Received: by 2002:a2e:8710:0:b0:2ee:6cda:6380 with SMTP id
 38308e7fff4ca-2eeb30e3cbbmr38946961fa.18.1720622975558; 
 Wed, 10 Jul 2024 07:49:35 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-426615876bbsm171534355e9.6.2024.07.10.07.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 07:49:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bo Gan <ganboing@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/4] alist: Implement a pointer list / array of structs
Date: Wed, 10 Jul 2024 15:49:23 +0100
Message-Id: <20240710144927.3940789-1-sjg@chromium.org>
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
  lib: Convert str_to_list() to use alist

 common/dlmalloc.c |   4 +
 include/alist.h   | 214 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/Makefile      |   1 +
 lib/alist.c       | 147 +++++++++++++++++++++++++++++++
 lib/strto.c       |  33 ++++---
 test/lib/Makefile |   1 +
 test/lib/alist.c  | 197 ++++++++++++++++++++++++++++++++++++++++++
 test/str_ut.c     |   4 +-
 8 files changed, 584 insertions(+), 17 deletions(-)
 create mode 100644 include/alist.h
 create mode 100644 lib/alist.c
 create mode 100644 test/lib/alist.c

-- 
2.34.1

