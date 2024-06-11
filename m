Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90962C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B784D886FD;
	Tue, 11 Jun 2024 20:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S/wbyDgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF63888655; Tue, 11 Jun 2024 20:51:00 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 621F2886DA
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-7eb699def37so5308839f.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131856; x=1718736656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jsgJ/i3yBJnC5Kqu8XhawIZ9nADjtVwBmpo4eaLeKh0=;
 b=S/wbyDgygqKQLsyk64kjevsMc2SEgXrVPIC0ppKtJy12DjpgrtAn6q2PEvbyi5LPnA
 4PX9yI7ML702PuIvq17grdR8fLLlmudrvdqcLddE1vLnqJ/LvMqm22BBIOVf4KHE4n9x
 K3G4+saP+PUB324BhKy54pJlGSAvsgy1h93aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131856; x=1718736656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jsgJ/i3yBJnC5Kqu8XhawIZ9nADjtVwBmpo4eaLeKh0=;
 b=fLDXHh8LhWQV/yX4MOcX5koQk72pIMiUPjAPNoyTyHgD5HWKgjXspb0M3UKVOqcl8Q
 BT1AaWbSYWq2hJg1QhrtIftSfOuf/owitclxnPF5DfaBEmw5DwmY0+INFvSUqjAm286f
 K+0l55mFfxBqDq0OcRCtnTivYBDoTWFBEPFLAD16NBW6dVM9bONo9NhqDYq7pvFtlenP
 t/BFg/J9acGamyi/6O0cSp3pY39FfxlOY53EMzEPnyt6/Kqnn0ylcYCt0KpcPnXsjGuE
 qtWJepTt7PyJKxlxvjnUmuRHepHK8kgQJAyd+86ZfwPDkUytFrMmWz715cAffwRDgHY8
 1MCw==
X-Gm-Message-State: AOJu0YzdKh5PQXHIbeQ952Vi24KQQdMlAiaD//zNn3TJjClJEd48VmDq
 18PVZQz6ipYScB9f44eBSj+LJqkDonqzZy6Modhhf53FLnnRo5CQ2hUvgasg9zdmtWsQNVHEJSw
 7i8Kz
X-Google-Smtp-Source: AGHT+IHKcqdDhw14K1yYDHVylds7Co86L97RW9GBLu/0dQPApoKFInBuNInzeqB6WEnIRTPpClRgDg==
X-Received: by 2002:a05:6602:1602:b0:7eb:a640:c724 with SMTP id
 ca18e2360f4ac-7ebb36efdabmr252343139f.4.1718131855973; 
 Tue, 11 Jun 2024 11:50:55 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-37594285ca5sm19645715ab.42.2024.06.11.11.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 11:50:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bo Gan <ganboing@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] alist: Implement a pointer list / array of structs
Date: Tue, 11 Jun 2024 12:50:47 -0600
Message-Id: <20240611185051.2223452-1-sjg@chromium.org>
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

