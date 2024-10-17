Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A32D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44CF089112;
	Fri, 18 Oct 2024 01:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ad/zhgw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E269891C6; Fri, 18 Oct 2024 01:24:42 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99A3890C2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83ab5b4b048so42009039f.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207478; x=1729812278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0IgTpcuEI8KSXL9aH2c0R0imh3puEIs0q8ZO+mPleE=;
 b=ad/zhgw01yaN/OhuBIq1Ml0Xmk2s+j1bVlCjjfRVgTUiBV4cddt/JpL7hkKp8bCeh5
 lHkOZmdzuTcXbVwZ30OzTxebuEFNLR5RBCDujv2Vn/3ghn4625FsqQet2QnAGpJ/a5zZ
 geowb3HSwzTeFrd8S/2/IfYM9uZkPwHoMp8LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207478; x=1729812278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0IgTpcuEI8KSXL9aH2c0R0imh3puEIs0q8ZO+mPleE=;
 b=YM2d7tC0jAS//1T0DOCQXf4cc9DvitBJoPH2Ed0aPvVquxJzQAikTEvmdEH3w8ldhC
 y0qzQVt/enZLnEraMBIKgwSuJO4lSI7baEJ69D1SyR8Vvm6Wt+IwHQv0XuRtF9yT+ChK
 AHqNct2H38Pk9JtB71Ej3SUrFxOcGumHqeCcjnj03SNmq4mprHtTzpVuWOPADW3jUhlJ
 i/r/9tAtE851zm5UarmBeOYciN5w3nuZiY3eju7VhivqNtSqxUIJN/bgFolDn8+9SHXG
 0iOgaFTC/u8XqZUNfHeNv8e8k4+GPo8z3Z6mA0AurhthxMxrcVaHtLRYxm91XZZEvsJF
 1ZoQ==
X-Gm-Message-State: AOJu0YyEX5k8jOHJMbp7WoISx7wsExsQ6+hFMk6C5ptwEFPQQPQ2qt35
 nVFHksyfBnWOdM2FoL6C9vvLmCNSgIbyAXWikulOr9GvKeut9w15lpYAagUFIfBZRAcvRI5gVcs
 =
X-Google-Smtp-Source: AGHT+IFf9U7cYKgYmDHzsI5yZiBrKA0T2CsPD7XlGzjtKTd0iqXOutft5O35uesh0b9q14wMkM+5gg==
X-Received: by 2002:a92:cdae:0:b0:39f:5d96:1fde with SMTP id
 e9e14a558f8ab-3a3f4045802mr4659245ab.3.1729207478571; 
 Thu, 17 Oct 2024 16:24:38 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 02/34] alist: Add a comment for alist_init_struct()
Date: Thu, 17 Oct 2024 17:23:41 -0600
Message-Id: <20241017232413.724808-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

Comment this macro so that it is clear how to use it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/alist.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/alist.h b/include/alist.h
index 0343946bc4a..a727f1c7dfa 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -198,6 +198,12 @@ bool alist_expand_by(struct alist *lst, uint inc_by);
  */
 bool alist_init(struct alist *lst, uint obj_size, uint alloc_size);
 
+/**
+ * alist_init_struct() - Typed version of alist_init()
+ *
+ * Use as:
+ *	alist_init(&lst, struct my_struct);
+ */
 #define alist_init_struct(_lst, _struct)	\
 	alist_init(_lst, sizeof(_struct), 0)
 
-- 
2.34.1

