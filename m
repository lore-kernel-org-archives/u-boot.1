Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124F6C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 06:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25DE788033;
	Wed, 21 Feb 2024 07:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z0d91q2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1862788034; Wed, 21 Feb 2024 07:26:35 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 565268803F
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 07:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a3f3d0d2787so29021066b.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 22:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708496785; x=1709101585; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bHberb9gmaFx0f0LhlBmn21j5qZt6WtRLgiOAN3YIDw=;
 b=z0d91q2YDroGpuDrMOo50KkSNO86w00HycZJp4aZq+/4jas117DXDTY8s+v3FRSlRc
 epUZqivoQjNqSmTIZwtR5W2EMQaxBIERp0aA7ec/RQGcxpUDZqLiSisS2fAJLx0Xue8Y
 d+85IDhlKb3E1LvNuXeVrIp31si1HiTCskz9NFfsI1v8ChErY4efC3utdGL/eKRndNPb
 zR9MFd8k61yfBaJa/4RlRHMjGJAu/3bUVVwvmTdhxxudYS4Vu3KJA7+1HMA4I1oD7Kdl
 +LqLf4RvWsXwVJfV+NBaivDNb8+1iQFl5n+YIdm97RQ2tPZ96XuDPzQ/NzpNaNHVKv12
 iLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708496785; x=1709101585;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bHberb9gmaFx0f0LhlBmn21j5qZt6WtRLgiOAN3YIDw=;
 b=hC+3iHDlPFio+UkRmgcHeS5joK35J437xAApT08qiq/NN/mo5oPBAoArhT7K/bjFWM
 oGkMBIcLPQEOGQpHAPr4cHUZoB7uIlRG0e7uvGX3PP7vwUY3G5h2rfp/yZpJ6gVfhYuN
 DDo90MWHF/wapqqy3XlMJjoMJU580Ye1cGeKP3I/ZuAwXck/ETVxzvMr50GZQ8V7Z6LX
 YJ2DMMMthqMdWshS7SWgRf/IjWZKUDWq77NU9uQm09DQ6QZI3dGQkMDKTaDiVjT2m5aV
 CE6NxsiKDks0UHlu9RtAMOwcSodeUVU/lWzbOtjDFTrEhkglqnu39fRZPZp6Az++9DNz
 OwtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH4gWLf3S/mrt2FQzfzapVp5IWWEmqBU7aMUvtwjH6TBZrSuO5q2qpHmzzxjFeUZTohksQLqQnUjMD9DWCjVBxb9JSHA==
X-Gm-Message-State: AOJu0Yz/uTAR+UJwCw6BFYpcaKMYaHupVOVVCJS/jDyMbT/M4nbkSF9Z
 qknTsbstj0VBg1GMwwGocnPerfSi7auxCUanbcb0LE5j7TuZjTGysAlagCXTNzEb7irULPKSJnT
 U
X-Google-Smtp-Source: AGHT+IFvb8LeQ/Fwfpe9AergWqbKZ2uc9R5GHwZGTd5jP2XKHQoX/BxlzbBqBYdtcT5a8zSpE3wy8g==
X-Received: by 2002:a17:906:6057:b0:a3d:caa4:2b88 with SMTP id
 p23-20020a170906605700b00a3dcaa42b88mr10641773ejj.27.1708496784714; 
 Tue, 20 Feb 2024 22:26:24 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 zh11-20020a170906880b00b00a3ec216ec6csm2179197ejb.45.2024.02.20.22.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 22:26:24 -0800 (PST)
Date: Wed, 21 Feb 2024 09:26:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] bootstd: fix build error when CONFIG_MMC is disabled
Message-ID: <e910bbd4-e509-4e6f-a458-d2e00741aec6@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

This code assumes that CONFIG_MMC and it causes a build error when
the config is disabled.

aarch64-linux-gnu-ld.bfd: test/boot/bootstd_common.o: in function `bootstd_test_check_mmc_hunter':
test/boot/bootstd_common.c:83:(.text.bootstd_test_check_mmc_hunter+0x70):
    undefined reference to `_u_boot_list_2_bootdev_hunter_2_mmc_bootdev_hunter'

Fixes: 66e3dce78750 ("bootstd: Allow hunting for a bootdev by label")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 test/boot/bootstd_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
index e71a2975c53c..cc97e255e5cb 100644
--- a/test/boot/bootstd_common.c
+++ b/test/boot/bootstd_common.c
@@ -74,6 +74,9 @@ int bootstd_test_check_mmc_hunter(struct unit_test_state *uts)
 	struct bootstd_priv *std;
 	uint seq;
 
+	if (!IS_ENABLED(CONFIG_MMC))
+		return 0;
+
 	/* get access to the used hunters */
 	ut_assertok(bootstd_get_priv(&std));
 
-- 
2.43.0

