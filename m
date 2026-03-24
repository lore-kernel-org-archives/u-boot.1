Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E2FFEC107
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 19:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1232C83EAC;
	Tue, 24 Mar 2026 20:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kXa3Kg7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF46A807C0; Tue, 24 Mar 2026 20:43:37 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28BB807C0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 20:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso1019854fac.1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774381414; x=1774986214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/Ah/ME7wNstJI9FjXlNGsbMV8rfHuBUOYXo8B63KbU=;
 b=kXa3Kg7KRjpB/wSzBuJPU6uaA3nxX9OrDrJGOaQFqhPB+uesm1AjSn01PpWXqU7WXl
 8RW6YTGvqEuWtA0JiwkbaKzCADeIfaNpuZ0DOa86c83zfZmlq2qB9euS/EK71fSv646C
 1YuwZIv+qYGnDxR0NEVfpGJFDS8rULUAjOdTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774381414; x=1774986214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s/Ah/ME7wNstJI9FjXlNGsbMV8rfHuBUOYXo8B63KbU=;
 b=l8kTDdZSB//w/J0QRZG2fdMd1j3sAQMGYRAYCCJmVpFUEQ5CIB9qmoB7/VNdU5yHnV
 aA4KNF7S4BPAHyJnTbHB/28xNw4BI2Whbtnlm5HaUwtF2kdnCHkKWXOX/PTO/e3WjDd9
 PAr9fMQO5B4V4twx467Pghqf6gmfwvxk60364c4AU77RUZnO1VcwLS2MNCY5PGuNLwO2
 F5MhqAQg20+DYwrdLhfsogGRvK391tLDWroswRbsQm3/8eLEtUiwYHo00hLdG744/5YE
 5x8BAUadZdTr1wCW7pslBFKGuwPmVZgMadlkwSifcJ2LvlccrXJu0aIqr6FIxSKzQyw2
 ymZg==
X-Gm-Message-State: AOJu0Yzf9ORkgJZHvDpOGEwHpV1c4DqHghLnlVM/dZbYE4HDMldWyQMU
 +dssA6geG4vkVbDdRnXWBf9bx1yq9iMvKi+3+URKpd7nKRkcYj9598rBgRX0fJYkR21tNnfX1ul
 l3Kc=
X-Gm-Gg: ATEYQzzV+TTQopvaj9qJwTJLiHQQ/slLSfr8SYqNypiDSO5yRFRAdPbgbPvjKNsRuB0
 rnU+uPZw4NMlmdL9iBI74nVkywYJRBI49ZiSq0lwTmDt66oqbs3UZEw01TYSIZpJm5d47fXKvWU
 nI0CFWXyCiGixzmHSTAuws23SMudVF/83rrdIoA7CJmnaCwTeAZiUW4JEhQRw+VPobaj/igwGdP
 ItaeRJ+2B6xlQ4thnwtYpYlkkFjc/XSp0tA6F62e64ppOJxI2ufqcjMLuKs1f3fzz0kQzWg6+yN
 XgWTx8QOpN7tkpkxWbOXHjne6bwSvPPIrWxUYZ0U0DVft9LZTiER+czyeyiPUzO8khch4ynUTLD
 ZvW7UDGXzfvvhaZr8yacBnlAhYRHaamfcj1szEgAIEoZEw9/h3ol6XFstazSVxMNtz18spI8stM
 lGOiEAJ7jRc++YcdUisQ==
X-Received: by 2002:a05:6870:9110:b0:3fa:aa1:5b1c with SMTP id
 586e51a60fabf-41ca6fd5895mr579094fac.30.1774381413827; 
 Tue, 24 Mar 2026 12:43:33 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c88218654sm3714784fac.17.2026.03.24.12.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 12:43:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] test: Add a check for a missing kernel
Date: Tue, 24 Mar 2026 13:43:18 -0600
Message-ID: <20260324194323.2335679-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324194323.2335679-1-sjg@chromium.org>
References: <20260324194323.2335679-1-sjg@chromium.org>
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

U-Boot should complain if the kernel is missing, so add a check for this
in test_fit_base()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_fit.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 5c0e74ff81e..811bafaf94d 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -70,7 +70,7 @@ base_its = '''
         configurations {
                 default = "conf-1";
                 conf-1 {
-                        kernel = "kernel-1";
+                        %(kernel_config)s
                         fdt = "fdt-1";
                         %(ramdisk_config)s
                         %(loadables_config)s
@@ -281,6 +281,7 @@ def test_fit_base(ubman):
             'kernel_out' : kernel_out,
             'kernel_addr' : 0x40000,
             'kernel_size' : filesize(kernel),
+            'kernel_config' : 'kernel = "kernel-1";',
 
             'fdt' : fdt,
             'fdt_out' : fdt_out,
@@ -389,8 +390,16 @@ def test_fit_base(ubman):
             check_equal(kernel, kernel_out, 'Kernel not loaded')
             check_equal(fdt_data, fdt_out, 'FDT not loaded')
             check_not_equal(ramdisk, ramdisk_out, 'Ramdisk got decompressed?')
-            check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdist not loaded')
+            check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdisk not loaded')
 
+        # Try without a kernel
+        with ubman.log.section('No kernel + FDT'):
+            params['kernel_config'] = ''
+            params['ramdisk_config'] = ''
+            params['ramdisk_load'] = ''
+            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+            output = ubman.run_command_list(cmd.splitlines())
+            assert "can't get kernel image!" in '\n'.join(output)
 
     mkimage = ubman.config.build_dir + '/tools/mkimage'
     run_fit_test(mkimage)
-- 
2.43.0

