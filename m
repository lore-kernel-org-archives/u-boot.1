Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17EBE64019
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 11:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1477184106;
	Sun,  5 Apr 2026 13:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lEkdJJkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C8C84105; Sun,  5 Apr 2026 13:12:35 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F2C840ED
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 13:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4042fe53946so1258375fac.3
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 04:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775387551; x=1775992351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZP3cEdp5tuFD39RdYbKTOiJH5T0HwxarL8EsOAFcnho=;
 b=lEkdJJkk+xIdXl/Q19TEk5bKnLkJqPNCFeWTUQuKiWesCS36nb2EqtlNRWyTih51fP
 yjsOfWmcLviHRfJFH7qsfUllFtmK+g7DUNl7NXArwcw43OYHbUcfK6WgFkek6nH9gqj+
 u8eAIDPLcRfNKcccpt7ax/sGZsvIhRbCft6G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775387551; x=1775992351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZP3cEdp5tuFD39RdYbKTOiJH5T0HwxarL8EsOAFcnho=;
 b=BpxNbznZaTPR0Sc0My5jz+C4kcaNVSD3r6SljNPISDoKfVX3EZpXxoETuvfTLUedR3
 KTYmsem6rZJLoyCJeOTdIZGz67TI3u7C4rdaJMf8YBKIClLJs1Z54HaznnL9t43HdDll
 KWhh1WVWdZZO9VM5nrDWpaU/bJYRmTEZV0W1Maku3EkJR5/DzEmA/lVQLtRl0llRlV9p
 z+lHCd4MZY2/HKg6CCIfy9L8Gq9M3mDBPwl+cG8asKLwsmpeE7ro+dlTx4LT0Rl3mxNn
 iYiBxa4TzfUlPX4Oe5V+KjjOp7tnfjVnvSpIYTG8bYfrGdd7m8r2ZBetytepxvHA1Iij
 JMgw==
X-Gm-Message-State: AOJu0Yxm7kXDDNoGxo0NobRvfDCE5guHwwqNUQJi5c268dgnq2ksS2Ag
 /EiIEPOXfDgv+pXoODAjArEezwhQTa1IcDti+LbaRUqx7s3FlfxpWTumawJblP8AuLANYb72H9T
 pQerslw==
X-Gm-Gg: AeBDiev7qjleecLzLm/aByrR28D/WASGlYJeCCQnxlquV+sOZvKy+QQKt/kK392YqQP
 NxfPFvzDn+vbuPCJCc7+Dg6nHe5MW2ie84wNm4o0bpccTa6A1Fs4U28aS+AOM0xga6w7PGKoXvO
 p8/G71hKyWkTSwe37VIIsiXblZtaR1fi65g+LWBDCruf1vvlswEHoQ2dGfmOFJoE3V3ExyfjSfa
 a3NptOQ6qb3yGHRd9UJ/nOm84Pp0TTYLsU/6Hiu09vkxjKslaeGTndnIFT1PTXpvcQND1Hw0vKQ
 8Ofg9JCnSxBGvEYWi6sW3rPNOKaGL6293rDrC/niQk9ebWQD1sE6HQosnFd3wkmXDQXJUE05Dts
 79dTu5LkWFTWodw5Lm44EO5pQgjAwo6yFhFn2FL8ff5QqUCb8F4IVn0H4xEC5ts7jgNUQ3Wr15/
 u7NA8dUZby8hRT/wnA6g==
X-Received: by 2002:a05:6808:1b23:b0:467:2a6e:adad with SMTP id
 5614622812f47-46ef4f05067mr4416233b6e.11.1775387550822; 
 Sun, 05 Apr 2026 04:12:30 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d8d109b69sm6414382b6e.0.2026.04.05.04.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 04:12:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/8] test: Add a check for a missing kernel
Date: Sun,  5 Apr 2026 05:11:49 -0600
Message-ID: <20260405111206.945185-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405111206.945185-1-sjg@chromium.org>
References: <20260405111206.945185-1-sjg@chromium.org>
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

(no changes since v1)

 test/py/tests/test_fit.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 4c7d400bc6a..9bfe25c0a51 100755
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

