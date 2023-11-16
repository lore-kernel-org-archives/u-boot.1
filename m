Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C4EC47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ACE7874E9;
	Thu, 16 Nov 2023 05:11:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WqPVSpkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6708D87463; Thu, 16 Nov 2023 05:11:40 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ABF887478
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7a6774da682so13864739f.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107897; x=1700712697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnT3zu3659M8ZdHPDHgPo9FZtGhyMsCFfvLUC0/oi4Y=;
 b=WqPVSpkvTvvKDqyjS2weL19gwvkFiX0tN8932bzd5kMFrELP1D+aRLVMU3anFxiU7K
 3QxtG5bpqo+KMpfpujoxILtxECKS3hyLwkyyMyxkBP9YB/4xA1Aymy23+FlQ+OntyRQx
 dhVfR9eubefbdDM1BuSTVO491J9OKad0TqZnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107897; x=1700712697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnT3zu3659M8ZdHPDHgPo9FZtGhyMsCFfvLUC0/oi4Y=;
 b=YESCjl7WkiKLUIduKMw5nxgivnE4fZ/4hoFoM8RZgwnwxiQDipsFs5OriTYm7e59a5
 aeenEaErrIPFNf1ZANT6yyt0RrcYlHcpb/uOkBLDTj+PhRH5XkErfhnJT9nTbtE8nzds
 vYKg9SqTTQRvosdHzwoFobIY6D/Be1b1x8Cd3lusVHUBgpqEEgLAoOW55zoJ8q0wds2S
 4j6Ew0KLQLITSeXb+rhhhyk4BgPzK4Aq8zAXlogw/lPW0yeVFPsw9UA3Lxyxt6fd69Cq
 lrg6Bwjd//C3CHBYfR0IXdC4I00+OwrnHyGgHQZ24jeVMgcfo9VAc4bXltuYJkXzFylu
 0dTw==
X-Gm-Message-State: AOJu0YyAbjQ0prkrnilP2u6X8TCKGmuuQUYsC6e0RNuUuXdLU03yKN+f
 SwVVV5CblwVTLTgzwN+U71crwOzIP3T//dkFZ1xnCw==
X-Google-Smtp-Source: AGHT+IFKfc7nPHncG4uCDKC4QCm9Y3G9x898Wb1ju5+PkI4L1C8lBqq0qxW/U9napg3a5nZ3u89M4w==
X-Received: by 2002:a5d:9506:0:b0:798:d82b:7b02 with SMTP id
 d6-20020a5d9506000000b00798d82b7b02mr16184709iom.4.1700107896890; 
 Wed, 15 Nov 2023 20:11:36 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v2 20/32] fdt: Allow use of fdt_support inside if() statements
Date: Wed, 15 Nov 2023 21:10:20 -0700
Message-ID: <20231116041043.362055-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

Most of the fdt_support.h header file is included only if OF_LIBFDT or
OF_CONTROL are enabled. This means that calling functions defined in
that file must happen inside an #ifdef

This is unnecessary, so reduce the condition to just !USE_HOSTCC

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 include/fdt_support.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/fdt_support.h b/include/fdt_support.h
index 2cd836689821..feda0d997409 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -7,8 +7,7 @@
 #ifndef __FDT_SUPPORT_H
 #define __FDT_SUPPORT_H
 
-#if (defined(CONFIG_OF_LIBFDT) || defined(CONFIG_OF_CONTROL)) && \
-	!defined(USE_HOSTCC)
+#if !defined(USE_HOSTCC)
 
 #include <asm/u-boot.h>
 #include <linux/libfdt.h>
@@ -418,7 +417,7 @@ int fdt_valid(struct fdt_header **blobp);
  */
 int fdt_get_cells_len(const void *blob, char *nr_cells_name);
 
-#endif /* ifdef CONFIG_OF_LIBFDT */
+#endif /* !USE_HOSTCC */
 
 #ifdef USE_HOSTCC
 int fdtdec_get_int(const void *blob, int node, const char *prop_name,
-- 
2.43.0.rc0.421.g78406f8d94-goog

