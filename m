Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A267FC5B543
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8202C82C15;
	Sat, 31 May 2025 10:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TEyQksXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D92682C15; Sat, 31 May 2025 10:45:22 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CD38003E
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4dc0f164fso2619551f8f.3
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681120; x=1749285920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0bphLIhg8HqKko1DfWbWx6s0jqmKrqePAs571WITnA=;
 b=TEyQksXmFo1AmkXWkB1xoQKR9pXxgwmHKI5shuIJIoXUjPcLWNeT+oPpiIEBQr4US5
 ccLNP03g3gToklTl0W/syHwggnztzanmziZWJaQjlavdBuyorwO4TLI8y7+rE2W7DuEQ
 B0E0gPGvEL4O5stGTtIeZWk1t5laMB3cA2U3dFeKpQeKEZMVynKXXtw7Qu3ZB4+2unoo
 NapmIA5I8+/KYtXuaxFdHyJhzhaVrp0gf7XmE3kpZyWus8jDvNWc2GYkSFPZYONNOh8t
 sHqPAjzlW/d2QQ1FUcRyo/Fx2myeLuuZKwEWH1pMoj67ieOjG3Htj1Xcwe+trKxX2OZx
 24fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681120; x=1749285920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0bphLIhg8HqKko1DfWbWx6s0jqmKrqePAs571WITnA=;
 b=GZSD2xozgKBzkIcsyfn+8HO0j2ECSt61y8FJ9nFAPoZpjXBO5UAQYPXj/5dyJ/cwBq
 1lN1wyxCK6Hsvxqd5vW5Ty7DSEsth00CDVNqnxOEyebd65E+bRYFLraAzdQ+O06qVDEd
 XFI70+8nbtw/n9FOGZLcOmYCN7KuZsqotAOC89WaT49mC6OIknCCQxOz4WZSLZBWCAqI
 owHdyKxHBhcCbyU4mRIIaE37Xwiz4t+NR5YbwzAxtgk5qk1ubATzspF1d4nugpUjIK/R
 zy3rENCUhtsOXjQDtG9YhToBJOEX9dke8khOehcSrVT0Q0aOzE3nm8kg4xVk8r8gmScy
 cOfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViIEHUEY3y5anrijt7zoq0rVfC7y6ExT9gf2A25Df+BevpBrvNTNRbk0fzUXzBVoPYEKH5vhA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/hbgL5F+ro0MA7zsK8lrQ7FZmIHqWR30MnfDjM54jcwjDNtwo
 iLYLFc7cYfEK3lwjOYvJSmvYECgK4tvViyRWXZ9C13C3YRz0sqRl7PJBBYWsoVyXHJY=
X-Gm-Gg: ASbGncuQb4L94bezc7cZhaoZ7tua3yZTilym66ZPXbasmihx7Spha1Dt+ZNBudWUpfr
 7+J5ddc4lTCRkltO2WzPek8G3KDzT2laVRgw468H5SbHlDijXwWvlZoW3EnBr+vEbbMy4ogMpNi
 BtO+Lss36lyUhzZDVr0NsDQ6dyukjz1DqxMijd5txbcNSfepfGKbzAcNwTPZNN6Rn4qipJD+PC7
 UethZTJ7ygSUftjo3Ogs+MeFJuN4//TdV5C+vVPvmj3IjH+WjCvlRd2QaURvjOD2Yk8VaDjdCKN
 hAU5+jRzxokDB3B5p7k2QwojQ0K9ouz18aTbqPsxlTvSBWQJdnRebEHs3kIV4pA+iTV/a24clDP
 ebAZcu71JakiUvynYEBYq16ks9GEKv5qwISc+nJuCfTeHt2dOTVw=
X-Google-Smtp-Source: AGHT+IHEKffLVVY1rB9qjFjH/QkfdnZFOgWUynJGxVGvhgntZ8YuxuT5wpNnP5npIKdFJrmMCWHH9g==
X-Received: by 2002:a05:6000:2409:b0:3a4:d2b6:3121 with SMTP id
 ffacd0b85a97d-3a4fe393626mr921111f8f.32.1748681119883; 
 Sat, 31 May 2025 01:45:19 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:45:18 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 13/13] kbuild: fix single target build for external module
Date: Sat, 31 May 2025 11:44:41 +0300
Message-ID: <20250531084449.4125187-13-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
References: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit e07db28eea38 ("kbuild: fix single target build for external module")

It's worth noting that crmodverdir is empty for U-Boot.
Just backport it to make diffing easier

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index dbf1edc39ac4..9b4b686d9467 100644
--- a/Makefile
+++ b/Makefile
@@ -230,6 +230,9 @@ ifeq ($(KBUILD_EXTMOD),)
 _all: all
 else
 _all: modules
+PHONY += prepare
+prepare:
+	$(cmd_crmodverdir)
 endif
 
 ifeq ($(KBUILD_SRC),)
@@ -2503,15 +2506,12 @@ endif
 
 # Modules
 /: prepare FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
 %/: prepare FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
 %.ko: prepare FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
 	$(build)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
-- 
2.49.0

