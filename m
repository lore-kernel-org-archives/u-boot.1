Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66872C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8FE087549;
	Sat, 18 Nov 2023 22:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EqjtB3eA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3DE874BA; Sat, 18 Nov 2023 22:06:32 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB11F870F9
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7b05e647c09so108817539f.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341572; x=1700946372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnT3zu3659M8ZdHPDHgPo9FZtGhyMsCFfvLUC0/oi4Y=;
 b=EqjtB3eAnLIINJWkUHDBAVqsdQzGB0m7JV3+ZhS/hOsKrC4kuDqYjry8Ev2U01bVQf
 Blzy6f/ongBPGbctQZ/INRvrhjUqWR1CyyJZ1KZ/k7ni3s1rwbLQ93ijCOuc7ObH30Ix
 ivplVnf8NWLbKnT1OeRHuWYe3kM6Newq9SaXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341572; x=1700946372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnT3zu3659M8ZdHPDHgPo9FZtGhyMsCFfvLUC0/oi4Y=;
 b=Th5umNguG6vMxvAt4rdi6lveBVCHuVi3IErx3rBJCuIgrkb3qV6grhyvx87orrabUi
 jEmYHOyf2pN3f4ihTb1OySWlU8QbaIohWhznnJOk5B8cs5iGj2GHVo/ll/7ZaLNt89Sf
 tU/Q26ZyfjHR3MxY3hOJ9BJJ7hSk8KfKW+Pt3S+XDJsr2K9F0z/OTfmOqUU6szm6ywX1
 XWly3LHra7dS8MFPp6EhFvU5uhg22nEue8A8LY5CiJrsCJOe0SryJPwhh9Yn4nzZMXWc
 xmUTYUcPTiJj6UdHcbdef/5piSTWIS4bVELsjztEJttOw1oQtcZzqJMlIlECq/5FQFT1
 0A8w==
X-Gm-Message-State: AOJu0YxmSDRvlYJO3V55mdp6BgZrGedJlHGpQ3yFS5tPemhOmxGVxpB+
 4rp/UZBFdT0HyQ8+7fOP9VEmbdx/ys/pfaMwYtRV0Q==
X-Google-Smtp-Source: AGHT+IGrRXvg4Ewsltwl+JxoOrpanNBkYuTK8jZ3rqg4TbFuigCcaUPyVMT5b2LSVjRy/PGGhmwoow==
X-Received: by 2002:a6b:5107:0:b0:794:d7e8:d239 with SMTP id
 f7-20020a6b5107000000b00794d7e8d239mr3376545iob.17.1700341572745; 
 Sat, 18 Nov 2023 13:06:12 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v3 19/32] fdt: Allow use of fdt_support inside if() statements
Date: Sat, 18 Nov 2023 14:05:07 -0700
Message-ID: <20231118210547.577026-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

