Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B974CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5460388FFD;
	Fri, 27 Sep 2024 00:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nGGPBzGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D29EB88FFA; Fri, 27 Sep 2024 00:43:34 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D248C88FED
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-45826431d4bso9597131cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390611; x=1727995411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+Q5Tl/VjJPDJ5g/bZZgsoRdOLsJkgIK40nMzJhDIOo=;
 b=nGGPBzGiy1Peg50WqQROVRrYJxOPR3S4pyMrn+4XTc4mUgsLOFCspGtKY9HnR7dbri
 YfZD9xQjgCkDkFHOKjwiOmAfVSG3TDwzRBmMhjteXbDUA7W5ILih6cxQSVWF38qPPCFO
 XevjAIMwD73w+VK4D9lNDRNiP0WGVRg547GGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390611; x=1727995411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+Q5Tl/VjJPDJ5g/bZZgsoRdOLsJkgIK40nMzJhDIOo=;
 b=ebrLVLkuG5CoDawVGmTck4CYIDNhfwSuiP0/SmHyukoWzLLoq1eGpE/dT0yqU11F1Z
 LQhLBmXfPPy3NBr1ZyNWc/UFEsCZlmFdGhTYrYOFO6G8N/+K1NR6Y0DheBkQ4gVzoFXH
 56+o8Kwq/HDDxBZBPg9mAw8MJOP2tKzIwXVT+ndltG4V6L16eBv5j8SaW7UC6Qny15Ab
 6Pinm5tr2G4AavVXL9wAkbm2fXmIMkLlkxRTem8w2+GMmORZhP0ZyFP7QcfOoWhovqP+
 RLUf+ltZWZbr1tFlCNsijxOEkLBhXegVZG9fkM+3QVjwMWsnXC4lxSl645YOCr75FVX+
 IxSQ==
X-Gm-Message-State: AOJu0Yxu18rLwN7H4kQW2IdR99+8a8LRgSLN3n9nWZe3Ttz4eRunfG06
 /2oL1DAV+PML6q2/ntG5SwE1III/7a9R1xJ/57rYjO3NeCGcvjOKZPsVYmF1ULysCWjcdHFgTQu
 /ISzfDjs=
X-Google-Smtp-Source: AGHT+IGmejgc3vNmUGjIJqx+7UgtL24bw6N+femVYxcC4errdbI9us4wB1QauF0sQ8s3E4Pgpq+nkQ==
X-Received: by 2002:ac8:5f87:0:b0:458:2ff1:6a4b with SMTP id
 d75a77b69052e-45c9f221c71mr18700011cf.36.1727390611667; 
 Thu, 26 Sep 2024 15:43:31 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:43:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH 24/42] stdio: Make use of the SERIAL define
Date: Fri, 27 Sep 2024 00:35:49 +0200
Message-ID: <20240926223814.1276764-25-sjg@chromium.org>
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

This is always enabled for U-Boot proper, so simplify the condition
in the common Makefile.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/stdio.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/stdio.h b/include/stdio.h
index 56609b846ff..d42fdd2728c 100644
--- a/include/stdio.h
+++ b/include/stdio.h
@@ -9,10 +9,7 @@ int getchar(void);
 int tstc(void);
 
 /* stdout */
-#if !defined(CONFIG_XPL_BUILD) || \
-	(defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_SERIAL)) || \
-	(defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD) && \
-		defined(CONFIG_SPL_SERIAL))
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(SERIAL)
 void putc(const char c);
 void puts(const char *s);
 #ifdef CONFIG_CONSOLE_FLUSH_SUPPORT
-- 
2.43.0

