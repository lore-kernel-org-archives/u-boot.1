Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD60BCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 053218484F;
	Tue, 26 May 2026 15:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZVkAhe3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16DC0846D3; Tue, 26 May 2026 15:10:09 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00AD7846D3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-69d8f70cb0cso2259215eaf.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779801006; x=1780405806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aK6ie2l9EKjOfIJUBi2gzknb3UGs7cIxapvlDAvkKNM=;
 b=ZVkAhe3AcBbthQAeFHGs059Qx93LU50Qz5Srz7IsgLUSm4G9LVSLTtm+GhbnJ+xjTD
 KzYfz2sPNTcutIfCMGHNE1DWoCRRaVouZS9/PMzTMqydeAcICvXYYLSYM21PhRnO6BfJ
 NDKYmOVTfJ+dZoYt4mNl5crkQ3zbgiqkts27o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801006; x=1780405806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aK6ie2l9EKjOfIJUBi2gzknb3UGs7cIxapvlDAvkKNM=;
 b=azaK9YWS/2ulWNacSzoNp8JqmVMTlUWz/tsEwv6IeD7Mtb3aurMFHfzK+2nBc7FHar
 GhgoJJWMP/WyFOcrssvmPjhO+sC6YrIm3vVkhKHjSHyVi9iaaVoJ46ilrGsN75GQw+jF
 w/tEUu5WMtOtH3GCoNnTe8mqdyw/OG2Bv32A4FBDuchDBMp+Ck1QjZIwZORiCjISOLTb
 J6ZqTva4NNKPA5q7mec1iGbCneZOgz7nzKj3NfG4P5hk4vie4BKcvPEKOGym3L0Q2BYj
 t+zkZkShGe4Y6X2exT/ZJ5ApBeWfZ+pwjcjVIP0y3wWUbVrahFC7l4sW62q5Bwqd7T1H
 ol3Q==
X-Gm-Message-State: AOJu0YzrHxt9pxQAiwley6M2XrN5+4Q+E4uE4hG2sLtWqNbiWGsDhIgG
 sFbNgFREj5SGhYvHbAN8VsRUuUH+ApU8Ul0iRvTwjjz/zMlPJ1Px0WA7d2gb8F7hWaWhaK76H/m
 5lHtwx2L1Dx8=
X-Gm-Gg: Acq92OHFjJ8S/gWUBtX1eZecf3oeiai6hgirBNMybzNGbZo0wVuRKxhjxOR3v3Djgc1
 e0Nsbx2qs9Gd5fuMBS1nk2z1sXScO65sdzdbQVdQSSTuCl2cS0NO+aKq+Om5kd3y6Yb7kBCCD26
 7lhjsEuTXcpakoZGljyB2KDksWKw9tpSryVOaIpAuYgdBuYvmzCDLEjlrZSuSAnvmWXRex05ham
 G2EGkMm9tG0oHrcQ1Hn22oodJg3LZADN37l/Okis8Wkg2Ag7XQ3m9eT7iivx4g6plPIgikiNnuC
 wMPHhjuAg3Y8J0eFm6Rg0QVebS2KMs0D/9HBjRx2OAd7UxQbAD87W2y5aaTcXmKcT2rNAx3jXyv
 4V6KwR7WslhkWSy9F3nXex/lb+nCKqDww9FniPzlyrOXkmgYtIfHIucH2KoOCGeDtD3Iz17aPth
 sFIvy2FaxljxcOeqEp86iDF6jAz6Zl
X-Received: by 2002:a05:6820:f08d:b0:69d:7f0b:49df with SMTP id
 006d021491bc7-69d7f0b4c33mr7697452eaf.54.1779801005714; 
 Tue, 26 May 2026 06:10:05 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aafca2sm6974601eaf.15.2026.05.26.06.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:10:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/9] x86: Make do_zboot_states() static
Date: Tue, 26 May 2026 07:09:07 -0600
Message-ID: <20260526130931.2103552-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526130931.2103552-1-sjg@chromium.org>
References: <20260526130931.2103552-1-sjg@chromium.org>
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

This function is only called within zboot.c so make the function
private.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/zboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 3876d163236..ede6c1448cc 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -120,8 +120,8 @@ U_BOOT_SUBCMDS(zboot,
 	U_BOOT_CMD_MKENT(dump, 2, 1, do_zboot_dump, "", ""),
 )
 
-int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int state_mask)
+static int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[], int state_mask)
 {
 	int ret = 0;
 
-- 
2.43.0

