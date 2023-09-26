Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF3BE7D270
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFB686D55;
	Tue, 26 Sep 2023 11:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J36iaq0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C7686C2D; Tue, 26 Sep 2023 11:43:47 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB35A86AF7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c038a1e2e6so130073051fa.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695721424; x=1696326224; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwduQnV1Xu5joMM1MS5p9PsJ9ckh8zm2EZunCj9up6o=;
 b=J36iaq0OAviDTlfakx60CTMbEWWIjrRLOiXpuwsNAeg9zvBj97/eEIH4IG5/c9NlrN
 mzlMRKy92fpS+ZgMHaSxyzPUqvikPIShqNKUCv0ShDzBWRyqCuMiTMlzHyC9dZB2lgyA
 Q8FdzRBNZHyF+NcJ2VQVCjMtKz2qpMNaEYJA5StF2gf3ixkYR9nhY84zBk1vjap09g8X
 lrMMAP97Xvswtj5ggh/rzBN4+8ALlbdkfMbBwjLEhHWU7Gea0MScKgMnegG93jZ2cUep
 1W4vwnxgOwXxie+QaeCB1emDfJEueze1yiqmjkOFADzcf9N80k4cwq4Llbb1PIf3HlOC
 RTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721424; x=1696326224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwduQnV1Xu5joMM1MS5p9PsJ9ckh8zm2EZunCj9up6o=;
 b=dMb+Mhl2MzJaTxX04pXmFDUuGL5p4FmcWZaQZaX5HNHFUCyEF5hU94yBVx69WtS9Y/
 jRqxaYbMBrNfb8OoIdk1978DgR0AxPHBYm1Uc4EgUvzck5+P0fs7qxgdkh9ZZxzhfpfY
 3Zd8HEx5SqRHuZ+nbkdTgh60JXdwC1GqmF/C5twoMZUPQ4yf+oVEb31830S9NdRGF3Y3
 IASjd1a5yEVsv7EDou5mCYRi+BvQkZ79559MbqVf05YLAcVc6edVLk+FO9MZRDuBlpaM
 CDiPXOwIL0eHGwQpzpuXXqwpj5CR92vZ0IpzyZKGQNwj9o+XYtFaE2wWK9oKInskfSyC
 lNLQ==
X-Gm-Message-State: AOJu0YyA4kfViwwn5L0eSh52J+Zmxeu9o/+g0R48VUQhHlYy1Ic4aURx
 Lwr4W3fD4QYCKssGzLIj4W49ejmnoN6rYOgrvkMZ8Q==
X-Google-Smtp-Source: AGHT+IHzXrM+H2sILr+347YL9Vy9D68/qyZ5BR+yhdmyBBycZZbLy2ZnU5+SHMMe+IRgcw8j/UTDBQ==
X-Received: by 2002:a19:e015:0:b0:500:8f66:5941 with SMTP id
 x21-20020a19e015000000b005008f665941mr7232401lfg.50.1695721424077; 
 Tue, 26 Sep 2023 02:43:44 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 x6-20020ac25dc6000000b004fe09e6d1e7sm2131131lfq.110.2023.09.26.02.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:43:43 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv10 02/15] Makefile: init submodules
Date: Tue, 26 Sep 2023 15:41:11 +0600
Message-Id: <20230926094124.7024-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926094124.7024-1-maxim.uvarov@linaro.org>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
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

Make the make command automatically clone git submodules.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9be24c4ec6..3a3cda2365 100644
--- a/Makefile
+++ b/Makefile
@@ -1871,6 +1871,9 @@ endef
 include/config/uboot.release: include/config/auto.conf FORCE
 	$(call filechk,uboot.release)
 
+initsubmodules:
+	@git submodule init
+	@git submodule update
 
 # Things we need to do before we recursively start building the kernel
 # or the modules are listed in "prepare".
@@ -1895,7 +1898,7 @@ ifneq ($(KBUILD_SRC),)
 endif
 
 # prepare2 creates a makefile if using a separate output directory
-prepare2: prepare3 outputmakefile cfg
+prepare2: prepare3 outputmakefile cfg initsubmodules
 
 prepare1: prepare2 $(version_h) $(timestamp_h) $(dt_h) $(env_h) \
                    include/config/auto.conf
-- 
2.30.2

