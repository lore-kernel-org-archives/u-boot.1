Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC70EE498A
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 10:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E13DE89243;
	Wed, 11 Sep 2024 11:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XTX0F4r0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE41589243; Wed, 11 Sep 2024 11:59:04 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1097689264
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3770320574aso4129194f8f.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048738; x=1726653538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47/RH3dhOQEQUdlUxl7YjuTDLYbsddTLJ33keJnBwME=;
 b=XTX0F4r05Q3rF552qgXnlGiR2z0UCZPUyloOwlVArk86Ciuqc1heeUMi7lCgZwWwhj
 /J8wl78EIaE8DyZwWEKKVrGKz7O0SzeWHW3XwgtNXrsQ4Ty77sVK6ECQ1VxGfIMB/YRn
 goiEb8AAzR20szpyDHT2scaAyEBt+y+LbjU73o/49t1PqDWEzcHEKS2ndoCTP9Oc+GYP
 AnYAY5+9aExy6qWOl2nyf1uY49w6A4zolVL6eeL8kreKZDYKBCHQeiqrALq58276QSZb
 uo/tekuIV2n9En7TMMVBy5m/7iqOUB8ldH7bwqHjPOPNXumxngiFs1plfmGa2lHxCNWQ
 nJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048738; x=1726653538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47/RH3dhOQEQUdlUxl7YjuTDLYbsddTLJ33keJnBwME=;
 b=OpURCYFvEpSgsIf8meRBFlJOApeVZP859ukSIB3dhQJ7Pz0gu9+ThTM/aWHmUPNDET
 Zqht48gKWYwaJJvjJKqzek+1V6WULPFEnqO6Xv1OUDDpbPBcQTZxVC+mmHVzKP/MhQgP
 Zj46zQ+N0XA2E99Ih5cBMPGlVAwB1d7NCEHhHbhXFwwMYKUPDao4Tw6shiwRWTHg6iTM
 n8gKTK3R9lTs6JFxd6CkzXzyP/VtnLcj91gmzS1L2mrfNnmoV9jhV7/EBQv2V9mxlDpS
 Rraa075ataAT8XY2Ezxld/8H9RfehCcGhWkI381G+mv0xpcgqjxtWRDN3nG0EEcBQzJP
 fSMQ==
X-Gm-Message-State: AOJu0YxjnCWfGmc976O48GvPvRNU7dZowAgQ3HWljoWG4nuz5jYR8afo
 Szs9dEfl9JKv9bixw+G74an2mgeZVmkpEqLOTESMp+ymzuiVT61jBgdV8JoMVdET/BtkNqpcMKE
 ZjmtwkQ==
X-Google-Smtp-Source: AGHT+IGQ5J4HfcmaDmDQqXxxa2lVz5LYsVA67HdoB0pDYwfkEnzyI64t2lA2PcHOspfP/auujh22MQ==
X-Received: by 2002:a5d:46ca:0:b0:377:9867:9028 with SMTP id
 ffacd0b85a97d-3788967aaffmr10792979f8f.44.1726048738319; 
 Wed, 11 Sep 2024 02:58:58 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:58 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
Subject: [PATCH v4 11/15] test/py: net_boot: fix comment
Date: Wed, 11 Sep 2024 11:58:24 +0200
Message-Id: <be0a63c3f424b1dcda0508ea2aaef7cfe0447a34.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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

