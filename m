Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C90CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD35288EA3;
	Fri, 27 Sep 2024 00:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LxfVAt6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF4688F55; Fri, 27 Sep 2024 00:39:51 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA78A88966
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-4582c62ee33so11604751cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390388; x=1727995188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlarxktd/LNz7AExz1dWmtLza3B9iL933L/7IImcDfo=;
 b=LxfVAt6P87knzqaBW9KnYN9EwCOtQ4FcQYTWB16hqR2VAwo+FUvx7GS26V6gL+IJT2
 UsoT/8G/5tyRXco7Rf7FINNede0ClIJw8fmV0WYNqDIBftHAjyh2ZzaUmmE7xKDIpilq
 YMmOPrmNcsyQ+JWCXXGyJhsJZSzXQXlnR7xDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390388; x=1727995188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlarxktd/LNz7AExz1dWmtLza3B9iL933L/7IImcDfo=;
 b=u9VOtEpAnpUfnFxsh2UwWVSL8a5oqtU7KatDvnsKCIgYb2ZfQgpk7OAfsM4kb5xY7Q
 QOFK45Y03ccyxcFTeQL3CGcs/goIhM4ZFPMOtz8biHrlQqcVWfRh6yovyIzK86sOBt9E
 rfiQBqKILYYFqAkgz5oJS6lETm+Yad2ZAvYZ/AjIi3bkPJrKkU2kpG9PCdxapak9fmjo
 +jxICNyplRNPoGFOr9QFfeZDjH1Lgd0MvCc1kGDYDkRpA17JDHuxODy2G2Ip7jh1UJlH
 ByeHy95MyoGNgQgDUIwG52cGEadGrT2mqJjY1ELsKzmaFKIaoqEtbqekIjWePvvMIKTV
 S1tA==
X-Gm-Message-State: AOJu0Yy+C3k8mhjt2RY5jJBj1Pbc6t+Sj3j9Qqpz4tdx5CRmADa7KV8P
 UkQaoiphTcVwUC83mkSS7pYb6lmwb/KMpY22Ugt9bzcbs2FU3xh9VdRK+DrkGXGUiXezXDzsiy7
 p135y7VRGFQ==
X-Google-Smtp-Source: AGHT+IGC9UchE/90ERtPQFQIVFQyoos2LOMSNAn9WvpefPAngP1QvdBj1oQL+KZZWsURInb5fPBn7Q==
X-Received: by 2002:ac8:5885:0:b0:458:5d27:8527 with SMTP id
 d75a77b69052e-45c9f2a46demr13600211cf.51.1727390388565; 
 Thu, 26 Sep 2024 15:39:48 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:39:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, Nishanth Menon <nm@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 03/42] scripts: Add some comments about autoconf.mk
Date: Fri, 27 Sep 2024 00:35:28 +0200
Message-ID: <20240926223814.1276764-4-sjg@chromium.org>
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

Now that the conversion of all CONFIG options to Kconfig is complete,
these files only contain the xPL_BUILD defines. Add a comment to make
this clear.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/Makefile.xpl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 1868f1beef6..3091311a3d2 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -20,6 +20,12 @@ _dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
 include $(srctree)/scripts/Kbuild.include
 
 -include include/config/auto.conf
+
+# This file contains 0, 1 or 2 lines
+# It is empty for U-Boot proper (where $(obj) is empty)
+# For any xPL build it contains CONFIG_SPL_BUILD=y
+# For TPL builds it has CONFIG_SPL_BUILD=y and CONFIG_TPL_BUILD=y
+# For VPL builds it has CONFIG_SPL_BUILD=y and CONFIG_VPL_BUILD=y
 -include $(obj)/include/autoconf.mk
 
 UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
-- 
2.43.0

