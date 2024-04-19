Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AFAC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 02:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26029886A0;
	Fri, 19 Apr 2024 04:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aeciGdsl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B13698866E; Fri, 19 Apr 2024 04:36:39 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE32885BD
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4349bba0ba3so10486491cf.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713494195; x=1714098995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqJv7fkbPBtOWGZVHdqZMoboqLGmhCm2bZE6jXhXCfw=;
 b=aeciGdslQ4+t3hQfxoMOp9lIn6mORK+7gu7AiOtDCwo7OmjRPzXrAAo/iS4Gu86rw+
 oPaQJMbEP4mD0QI1rzEYdAL5K+bGq3sBEvWZqD17DsSAK/TI+opDaZBtvgzLA5hfHivf
 L41X/5X4OIvDN4mL2bfpviDOoZeSW9RXo52Sde9n2DcjL5FrIGzs/qKjRdaDeXt/JvkN
 hieDxvNcJQ8ezpTR49aN6836vKMo8FhDPc/T7N1i5wX6ALGSeslC9VvFhYhUiy56G/gd
 rOaKnr+d6U99mClV6X0vqRtmRlURBAxBtctdLwJjp+2Nckswm0HgEySUFLNE+LZljS3R
 cnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713494195; x=1714098995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqJv7fkbPBtOWGZVHdqZMoboqLGmhCm2bZE6jXhXCfw=;
 b=Q1LqwHRSn8z0osWvRz2EUgPhSTyEmU678fDuxUCQuAZ6xoYNQh5lupy4iMnz3Wiujv
 F+rwAA3FGTcSnqoEikzlPtkkWlim17PKnI2Gc+WKCKVWTRdlPzzfCrCFXwIUMcTCxNlX
 9YYeYw1BR3RtfCv+fdchCSc9XLU6ACQTInI8XeJkxY/kTSjQQhDr/cJghBwVmK1xLuXo
 /xfZYD/ExyWxARfWMPxqUvVcY9GnecJrUSH2OMQFLGKz2892U0ooGb8wH5fcWeAh8Mef
 WP+kBgwrSHg1pchTVRscBZ/Ak8mySCacRWmku3uI406MZ4qBdMAcn/g4qTAKKZ2ju3pP
 zstA==
X-Gm-Message-State: AOJu0YyuSMIDhhnurKzSEjsx3OYNiZ+GdjpSZJAxwjU/4+cxVb+Lxr5x
 BBoK86DdOXIUOF1a9jIbYTFSvXwKKEQqD/M8fYPQmCkkfOwJbGZ7YrppLg==
X-Google-Smtp-Source: AGHT+IGDpPchgT6Sd0NVW01nBZid0VWDR8oF1MbM06hNMi0H0yxei8YD85tuIIZFh/aLInPPut36pQ==
X-Received: by 2002:a0c:da0f:0:b0:6a0:5528:9594 with SMTP id
 x15-20020a0cda0f000000b006a055289594mr729007qvj.64.1713494195697; 
 Thu, 18 Apr 2024 19:36:35 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 g2-20020a0cdf02000000b0069b447066bbsm1181155qvl.78.2024.04.18.19.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 19:36:35 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 1/3] patman: Fix tests if add_maintainers is set to False
Date: Thu, 18 Apr 2024 22:36:30 -0400
Message-Id: <20240419023632.29078-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240419023632.29078-1-seanga2@gmail.com>
References: <20240419023632.29078-1-seanga2@gmail.com>
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

If add_maintainers is set to False in the user's ~/.patman config, it will
cause the custom_get_maintainer_script to fail since that test expects
maintainers to be added. Set add_maintainer to True in the .patman config
to prevent this.

Fixes: 8c042fb7f9f ("patman: add '--get-maintainer-script' argument")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 tools/patman/func_test.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index e3918497cf4..9c016fb5e9a 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -540,7 +540,8 @@ complicated as possible''')
             with open('.patman', 'w', buffering=1) as f:
                 f.write('[settings]\n'
                         'get_maintainer_script: dummy-script.sh\n'
-                        'check_patch: False\n')
+                        'check_patch: False\n'
+                        'add_maintainers: True\n')
             with open('dummy-script.sh', 'w', buffering=1) as f:
                 f.write('#!/usr/bin/env python\n'
                         'print("hello@there.com")\n')
-- 
2.37.1

