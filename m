Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A698CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFFA488EAF;
	Fri, 27 Sep 2024 00:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UpCOBQcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0400388EAF; Fri, 27 Sep 2024 00:39:29 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE4988966
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-4582face04dso14069381cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390366; x=1727995166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fX3m9PH+iHUhZ4CbhWz9WCW97V4EP8uw5fdPsEePvQ=;
 b=UpCOBQcO/A2FZyW+ramDV6EBvv8LOYbs42K6NKg2rWv9KD0iPmKx+fKQJsgn2B+7JG
 1sgVV1NruN7SXj6vzklgW35vjHUMv99XE3pi6AMYTNJpAZo/1zovEb2sIaipsO8PBVqR
 1Wtqr4kBH0AeHJxfEG5mj8vi1kl1ELun73EjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390366; x=1727995166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fX3m9PH+iHUhZ4CbhWz9WCW97V4EP8uw5fdPsEePvQ=;
 b=PWrzwRv6lwdX7phZNfXOwPmBaBRAjx/jOVSAwX77CSESaLzOJoB0mTxJWiaKWe4Vri
 DDLiN0v0lYnduCiLJ+rCgkUdQUznqOn2jrQn1Y0gGzSPRbbw3ggKQPe6gRMHQdI1a8/3
 Dj+uSd5j2BTVLrETaDSJkM8UZH8t50fH67Ut3P0+Or9Ap8QQzm0iAB9hBBqzzDSjWYBZ
 7bhPfPoGxVG2S5BjM6z1Ne9C7irr+sFqQJ5bm27uIFAu/ehtTkXAHQYSKSPKsNrKfGsM
 wE2deqsymu/LoEe/09Xd52lrZWK5DqfxL6R1HNUyObuoSz9QS9BeBDdQdGRYHYonlSWf
 QYfQ==
X-Gm-Message-State: AOJu0YxS+i/ZdZxebk3sJhiEkW5SKMTLszrvAdFSWeREtT716Xo6dCbr
 J1ZiE3bcJpDLs5F1daTtFBHJh5HybhPb7bFSiu/aFsnpu8vTFlXr+N2Lx83CB9svLnwgx8+CMQh
 16ooAPQK33w==
X-Google-Smtp-Source: AGHT+IHVD5OKLch0ypagXUi68XJzotM5xW8DBOOKRcFsoeaNknh1MIO0A+IQkIScoc/WA2UOTfjEcQ==
X-Received: by 2002:ac8:5854:0:b0:45b:16b:6755 with SMTP id
 d75a77b69052e-45c9498f690mr77294511cf.16.1727390365716; 
 Thu, 26 Sep 2024 15:39:25 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:39:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Masahiro Yamada <masahiroy@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 01/42] Makefile: Add a u-boot.cfg file for VPL
Date: Fri, 27 Sep 2024 00:35:26 +0200
Message-ID: <20240926223814.1276764-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Create this file for VPL as well, for consistency.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 525576f987d..300cee2e7f6 100644
--- a/Makefile
+++ b/Makefile
@@ -624,7 +624,7 @@ include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
 	@# Otherwise, 'make silentoldconfig' would be invoked twice.
 	$(Q)touch include/config/auto.conf
 
-u-boot.cfg spl/u-boot.cfg tpl/u-boot.cfg:
+u-boot.cfg spl/u-boot.cfg tpl/u-boot.cfg vpl/u-boot.cfg:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.autoconf $(@)
 
 -include include/autoconf.mk
-- 
2.43.0

