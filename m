Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB930C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 00:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8651887859;
	Sat, 11 Nov 2023 01:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jDlJaYIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B54987857; Sat, 11 Nov 2023 01:29:38 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D10C86F32
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 01:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-66d0760cd20so22174846d6.0
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 16:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699662575; x=1700267375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMe27PCpSGrpKy6akin6UXrBQxmCtSQz/w0mkm8+aO0=;
 b=jDlJaYIahhIfJsPm2m8UMTqabVrX13iV/6Xw5zHxLJGwuAGZLClDh2feaqdJ+TNEIS
 A2bg9kUquyrpvNoAbnYSevY5PqCyCo0cnbrRsxG0r39Qu/zpQk4f02jyZ6KW0plfHkFo
 msiRjh1Yu/5yoVgD4kPEbEGvAKcJru3ZfgVt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699662575; x=1700267375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMe27PCpSGrpKy6akin6UXrBQxmCtSQz/w0mkm8+aO0=;
 b=PJ7T9UEeqNz9PjX5T/qp6ECu4bfBrztsYb7al4ASuelpJi1Js0p+fxGj/cHbfoMh28
 gd3AsDKDaxNiSSBFCMTkldKqetYEdSGPKQqMtnNDJqvdXQpxleglvPjz70HBurhj+Kef
 ap7ulruXOsrImYalLis2iVjQpjWLRtz6Rxr3M/k3uJDBlJMhY0dhS2f7xl9WbZJS7zBa
 +zIGTJnPOrdYE0pJTjuAk1wGQjDja1WuV3VrqgKKq2mxn01NkQzFmJTSBVhfOEG6K0ZW
 G/UNe5hRMtxXF4JeeBBOV6T8UWvqU7hPA43Eegi9WGYpyYRAhXVehEKvftdiciWoJZTY
 qSsg==
X-Gm-Message-State: AOJu0YyQUrdurH9shnybf8oPeqTVgFKFAu7dU4qqWBfEz2+jmBjoHbM8
 byfFr2mjZFd/gczun1tRRUl70g==
X-Google-Smtp-Source: AGHT+IE0a/VdrtgvwTmIbRQLeoUJHTOtRwQJiuZK5PAG5tzmD5AD8V4FRMa71Q4svxolT1LcdUmEbg==
X-Received: by 2002:ad4:4e6d:0:b0:670:ba7c:938d with SMTP id
 ec13-20020ad44e6d000000b00670ba7c938dmr1203791qvb.25.1699662575054; 
 Fri, 10 Nov 2023 16:29:35 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5104:5a27:f95d:21d1])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a056214029000b00677adcfd261sm55898qvv.89.2023.11.10.16.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 16:29:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: lkml <linux-kernel@vger.kernel.org>, Tom Rini <trini@konsulko.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 2/3] arm: boot: Move the single quotes for image name
Date: Fri, 10 Nov 2023 17:28:01 -0700
Message-ID: <20231111002851.1293891-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231111002851.1293891-1-sjg@chromium.org>
References: <20231111002851.1293891-1-sjg@chromium.org>
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

Add quotes where UIMAGE_NAME is used, rather than where it is defined.
This allows the UIMAGE_NAME variable to be set by the user.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Add a patch to move the single quotes for image name

 scripts/Makefile.lib | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..1a965fe68e01 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -487,14 +487,14 @@ UIMAGE_OPTS-y ?=
 UIMAGE_TYPE ?= kernel
 UIMAGE_LOADADDR ?= arch_must_set_this
 UIMAGE_ENTRYADDR ?= $(UIMAGE_LOADADDR)
-UIMAGE_NAME ?= 'Linux-$(KERNELRELEASE)'
+UIMAGE_NAME ?= Linux-$(KERNELRELEASE)
 
 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
 			-C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
 			-T $(UIMAGE_TYPE) \
 			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
-			-n $(UIMAGE_NAME) -d $< $@
+			-n '$(UIMAGE_NAME)' -d $< $@
 
 # XZ
 # ---------------------------------------------------------------------------
-- 
2.42.0.869.gea05f2083d-goog

