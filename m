Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F89C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2C0C86EEE;
	Sat,  4 Nov 2023 20:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SA7KRw59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A71F386B7A; Sat,  4 Nov 2023 20:42:36 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CEF086B7A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a6889f33b9so112043339f.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699126951; x=1699731751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDtk6Lut1ZOMIQsv1zjp0Y23IQKARp0A3/De87KmLgY=;
 b=SA7KRw59glKpembs4HzflZrAmLgMVHPDXnQGtRJF8ERpgcg50+3rutFV+xhCqGVFWM
 Oro1J2ebrt7D5xHRaV9Bpx9Fea1n2gqCXdfgTgS00XaeUtgvJr81+0Y8AE/O1uQi1mUw
 iuygyxw2mehZYWwWenJ6JxIEJk3bnPKL0rFIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699126951; x=1699731751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDtk6Lut1ZOMIQsv1zjp0Y23IQKARp0A3/De87KmLgY=;
 b=ffhqnGGmHX7u2acil4iAitYjqPmOLFgb/BQ5dYuIfFDj2xot1Mzbg85IRI5+IrqqwZ
 5Vb8PUqDZhfoV15axkJtQCpz7SOEHpyBpfp2EmYiaTQysBi7rGIuk1WRDh5U4k99F0do
 sr2gF4e9L3EOfCqkBo0Wc7RMSb6yFMMXvKDI8gq/IzVf+qxzdlvXiLU4K6m0cJBYBf3K
 MI5IEksz6TOmCGh3wycr4p+pEdpUQ8vnJVZbvw7cUs5o8+REJ2upPji1l9kOBSU9rROq
 C2cErnbwM2zt4abo+yaZT+y2o1dUHwSDyUWCUicyWsYX3Mrq+mrp1SyOoBemocvTDD/y
 qJQg==
X-Gm-Message-State: AOJu0YxrFGjHz6kbIcH7cgBChzJnPrvpFUZuYIVObZCdZtbpp7JDBR8w
 Nu/UZN3boSOmotwuAO98ThqpTg==
X-Google-Smtp-Source: AGHT+IEkiV/L+zZOUgXKbxHpPIMnh2+xClRjkIjMd/Rr13wzWxBt87VskJ6FsVRSe4kr9OGL6oYpkA==
X-Received: by 2002:a05:6602:2d87:b0:783:4bc6:636e with SMTP id
 k7-20020a0566022d8700b007834bc6636emr31219991iow.21.1699126951160; 
 Sat, 04 Nov 2023 12:42:31 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a6b5a04000000b0079fbb834232sm1293318iob.19.2023.11.04.12.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 12:42:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Simon Glass <sjg@chromium.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm: boot: Use double quotes for image name
Date: Sat,  4 Nov 2023 13:42:03 -0600
Message-ID: <20231104194207.3370542-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231104194207.3370542-1-sjg@chromium.org>
References: <20231104194207.3370542-1-sjg@chromium.org>
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

The use of single quotes in the image name causes them to appear in
the image description when the uImage is created. Use double quotes, to
avoid this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split double-quote change out into its own patch

 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..03e79e319293 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -487,7 +487,7 @@ UIMAGE_OPTS-y ?=
 UIMAGE_TYPE ?= kernel
 UIMAGE_LOADADDR ?= arch_must_set_this
 UIMAGE_ENTRYADDR ?= $(UIMAGE_LOADADDR)
-UIMAGE_NAME ?= 'Linux-$(KERNELRELEASE)'
+UIMAGE_NAME ?= "Linux-$(KERNELRELEASE)"
 
 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
-- 
2.42.0.869.gea05f2083d-goog

