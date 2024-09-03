Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011BECD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8901288D03;
	Tue,  3 Sep 2024 10:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v0iRQh7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6145B88C8A; Tue,  3 Sep 2024 10:39:03 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3B888CD0
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42bb7298bdeso56241475e9.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352740; x=1725957540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47/RH3dhOQEQUdlUxl7YjuTDLYbsddTLJ33keJnBwME=;
 b=v0iRQh7vimPebWdfEpFgqGsuWlHw6Tr05s1J9B4pCPpHV6Ejk1bfXAnD8D63NkwgXm
 dgF8GSbN3qJ+BuzgY3bT6z5P3PBhhLKAgD70B54bB6qpIJYsH/8u2ZcgBmM2EEFQS88t
 GlFq3Rz6vwJlEGwIaySlPYlhT1V4+jheJbZxuALNQEyEUFaYrr29hPSpezxxmdQq8Bfl
 jAcUhvEjQ+592pY0pWt39KKiAKS0IB1leJKAPZEnnecDexZGvqCU6ysB0tLsONz7jiXx
 a9j9+O/SiLa4RaROQJXqtJRHFwMuTT4jqbCNcH0Ca3wfFf/1j/juOuMoNezVSjQCqhQ4
 a9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352740; x=1725957540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47/RH3dhOQEQUdlUxl7YjuTDLYbsddTLJ33keJnBwME=;
 b=MjMd8HxH4XGmRMfe0JDt6Nup6VQsZ56QSGUTD/zZIw8EDbCp1zDp6IGKLl4nFXnBBy
 Q4PcGx6ZCje8EX0DJIWEL3zIv2iN5FT5HwelwT5JiZS3ceq8Ejmvsflg8/H685SgR/YK
 CvoYejDaNlhAObyymgvg1OQIgdceyJWavJenYpPrEfw/0MJKMNxZsNiEfqeiSPy1Eo4w
 92Z4xwVZVsnL30Z+jVrxUlnPDVH6EKlxSrCSjaJiJLOsWFutGWrHA7XewrF2noDqXgj6
 S56Hjb9T8TpR7n0ctX0a01AVbp31ByG05h2F845SYPKBCbBEQe3A4hxuRcaAzKWUo31z
 X7Lw==
X-Gm-Message-State: AOJu0YxN7D0lhJEt69kvWyekZjDTeVPULEBhgjQWDcDQQqEKGLwrKxcf
 et1pr/KUlcdEgYRSsB4q42MZqm0xoasSrPQHxOW6oZuJQr1olNhmS03VzARa9i5WEHDgysAMTll
 aGwk0HQ==
X-Google-Smtp-Source: AGHT+IHn/42OJpaXobyqYxO7E10Yy83BF+NiKENArSVubUJeUzxlBr6EJ+XPtmsI54ULm3+kDpZCLg==
X-Received: by 2002:a05:600c:4ece:b0:42a:a6aa:4118 with SMTP id
 5b1f17b1804b1-42bb01c1b92mr161989835e9.18.1725352740556; 
 Tue, 03 Sep 2024 01:39:00 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:39:00 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
Subject: [PATCH v3 12/16] test/py: net_boot: fix comment
Date: Tue,  3 Sep 2024 10:38:09 +0200
Message-Id: <936c0b76708897f9d23e20e18e8abacf8f150998.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

If env__pxe_boot_test_skip is not present, it defaults to True not
False. Therefore fix the comment.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_net_boot.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index 63309fe82e1..d7d74356928 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -75,7 +75,7 @@ env__net_pxe_bootable_file = {
     'check_pattern': 'ERROR',
 }
 
-# False or omitted if a PXE boot test should be tested.
+# False if a PXE boot test should be tested.
 # If PXE boot testing is not possible or desired, set this variable to True.
 # For example: If pxe configuration file is not proper to boot
 env__pxe_boot_test_skip = False
-- 
2.40.1

