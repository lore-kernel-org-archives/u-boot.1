Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C33CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDB986B37;
	Sun, 24 Sep 2023 21:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BYYMjZfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 459548692B; Sun, 24 Sep 2023 21:26:14 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C7286B64
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34fe2814b0dso17833235ab.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583562; x=1696188362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWydHnPpsnJkESlc/fRDLC9rXV+LdElaPQTCK55Un6Y=;
 b=BYYMjZflnFFHnLfOteBHis9WgzrhVCGTBQm1HDTMMOGSA/W247J8fdZ4svHBl1gn63
 ugVwxD/ysOMwF9Pg94VsWT5d1FgdQkw+xkZ8CU1nnEnPWTB1r4O4EnRJrBj2LFRz+AUG
 RNvxXARgB6w6Jo2HOJW/CyQBwcRJXH8mbqZKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583562; x=1696188362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWydHnPpsnJkESlc/fRDLC9rXV+LdElaPQTCK55Un6Y=;
 b=f8xNV8ZLngPTpX6R//G05SGOfpI/E0pVriKsmmFjHY0qop0WfWzZyrkYxaGcW4onUV
 45TIUemTVSX35mHfORBViNp1R7/3iyEd1CO4/Ee4gSIDh4q+CMuN1LXbHIx8k2W6BbDw
 Dpc7V3RVvJU+YyjX2jQY+GpVJz2ApimsFwRdAc9mEwprMSJCpEIVhTKevUuArUwPO1dq
 0OWtsTxQgg2cbyuDh08G/19XSZtxpNEWWcJg7i4kAKFXg3iVnfhMYzsGGkHfBKt8UinF
 ND9ieAddIR1Aked7kN3diXFhRuo4Ya0EfXUplUdWeMJqMpLiC9jlumTGhrNV8npGNyNv
 pvwg==
X-Gm-Message-State: AOJu0YyXhkMrFSq1akFoLik7tzFh7FmiefQFqL4SVEkXIlRKzIOF3hQJ
 SE7pwKXyhwtnQ953GmB/kKgwu4z2i5t7GPvvy74=
X-Google-Smtp-Source: AGHT+IEXMzPsMdM9mV+wZ+63Vqo3roQkJwyM6RbOhqqPUoiL2O0Mxs29XrNzrjxR+AkNQ0lWhQpJIQ==
X-Received: by 2002:a05:6e02:1c2a:b0:34d:ee49:5114 with SMTP id
 m10-20020a056e021c2a00b0034dee495114mr7393281ilh.23.1695583561909; 
 Sun, 24 Sep 2023 12:26:01 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v3 14/38] dm: core: Correct help in TPL_DM and VPL_DM
Date: Sun, 24 Sep 2023 13:24:59 -0600
Message-ID: <20230924192536.1812799-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

There are copying errors in the help. Fix these.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to correct help in TPL_DM and VPL_DM

 drivers/core/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 4c5a00f6f9c2..fe5c41d57ecd 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -27,12 +27,12 @@ config TPL_DM
 	help
 	  Enable driver model in TPL. You will need to provide a
 	  suitable malloc() implementation. If you are not using the
-	  full malloc() enabled by CFG_SPL_SYS_MALLOC_START,
+	  full malloc() enabled by CFG_TPL_SYS_MALLOC_START,
 	  consider using CONFIG_TPL_SYS_MALLOC_SIMPLE. In that case you
-	  must provide CONFIG_SPL_SYS_MALLOC_F_LEN to set the size.
+	  must provide CONFIG_TPL_SYS_MALLOC_F_LEN to set the size.
 	  In most cases driver model will only allocate a few uclasses
-	  and devices in SPL, so 1KB should be enough. See
-	  CONFIG_SPL_SYS_MALLOC_F_LEN for more details on how to enable it.
+	  and devices in TPL, so 1KB should be enough. See
+	  CONFIG_TPL_SYS_MALLOC_F_LEN for more details on how to enable it.
 	  Disable this for very small implementations.
 
 config VPL_DM
@@ -42,8 +42,8 @@ config VPL_DM
 	help
 	  Enable driver model in VPL. You will need to provide a
 	  suitable malloc() implementation. If you are not using the
-	  full malloc() enabled by CFG_SPL_SYS_MALLOC_START,
-	  consider using CONFIG_SPL_SYS_MALLOC_SIMPLE.
+	  full malloc() enabled by CFG_TPL_SYS_MALLOC_START,
+	  consider using CONFIG_TPL_SYS_MALLOC_SIMPLE.
 
 config DM_WARN
 	bool "Enable warnings in driver model"
-- 
2.42.0.515.g380fc7ccd1-goog

