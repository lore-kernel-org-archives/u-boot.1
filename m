Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4C9C54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 11:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCF4875A7;
	Tue, 21 Nov 2023 12:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DKuVC4sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03549870BC; Tue, 21 Nov 2023 12:36:11 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3918E870BC
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7a956887c20so215168339f.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700566566; x=1701171366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnOVFeMdlhE3pzwNFmBI72VrRkwcs0KKzj9SGXipPJI=;
 b=DKuVC4sd2HsbdonRTxidDwEzm8P+x349QVC3MlcLuRWfZ6nTF5vInKtfrm/x3zAARd
 QFQoEQ200lZfIM5iDvakHM8P2CKhR1ayCUzdbYEdcCpNxm6RJeVlONmaGt4lEEP3ECFY
 qdl9E/Bu8/teF25YdblqbJfxxggqoMTZJQuho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700566566; x=1701171366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SnOVFeMdlhE3pzwNFmBI72VrRkwcs0KKzj9SGXipPJI=;
 b=Iyv1QbFUqKuOsQWEKkaQ9x5JI+Zy/nohOcyHQTUvDLnbJoBVWp45Wq90zMtUIgT73S
 TH53g1M12afFq5oiAfzVLyCjmp/09QSChzplte4DYXoFXzYA2YjtjIIOOjMHPG0OV7G5
 wHrnlbYRSOJpKxM5VkeiXW1nUJtpGUfdPnPnGHQZMJ3e+jReL8fYhf6j0U0Tot3so0No
 Cpn1GVDGumC191ZHP9dLb3KDeBtVh1D1As3wq1hoQF7uVkgMTw50e9Zsp/PmDuv6mB96
 e7QBBrcMi9rIqdYy4LVjpCnuAUlONIb5c0fmol4EzEYyHDWZhUWkMUfwwoZWA2ugpEoR
 HDng==
X-Gm-Message-State: AOJu0YxsqJifD85nbrt/JOwQ4w4CFatYsIiPBfLyK4MwrB6RJ8DT+ME+
 hpIrakPSOULLDiEZqtmbpx9krwjWYspQeFvuC9ODfw==
X-Google-Smtp-Source: AGHT+IHWSMzE7qOB0Pui+0dM5j0e1Y2duZd0jNAog3mp/4FLd6fvbzzbg3tUKzcifKokPTfWLIKjyg==
X-Received: by 2002:a05:6602:d1:b0:7b3:4b1a:e414 with SMTP id
 z17-20020a05660200d100b007b34b1ae414mr987795ioe.11.1700566565806; 
 Tue, 21 Nov 2023 03:36:05 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a0566380f8a00b0045bb982a3d2sm2559190jal.60.2023.11.21.03.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 03:36:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/7] efi: test: Create a disk image with and EFI app in it
Date: Tue, 21 Nov 2023 04:35:49 -0700
Message-ID: <20231121113557.800353-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121113557.800353-1-sjg@chromium.org>
References: <20231121113557.800353-1-sjg@chromium.org>
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

Create a new disk for use with test, which contains the sandbox
helloworld app. This will be used to test the EFI boot bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_ut.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 1d9149a3f683..f6220c05238a 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -468,6 +468,37 @@ def test_ut_dm_init(u_boot_console):
     with open(fn, 'wb') as fh:
         fh.write(data)
 
+
+def setup_efi_image(cons):
+    """Create a 20MB disk image with an EFI app on it"""
+    mmc_dev = 7
+    fname, mnt = setup_image(cons, mmc_dev, 0xc, second_part=True)
+
+    loop = None
+    mounted = False
+    try:
+        loop = mount_image(cons, fname, mnt, 'ext4')
+        mounted = True
+        efi_dir = os.path.join(mnt, 'efi')
+        mkdir_cond(efi_dir)
+        bootdir = os.path.join(efi_dir, 'boot')
+        mkdir_cond(bootdir)
+        efi_src = os.path.join(cons.config.build_dir,
+                               f'lib/efi_loader/helloworld.efi')
+        efi_dst = os.path.join(bootdir, 'bootsbox.efi')
+        with open(efi_src, 'rb') as inf:
+            with open(efi_dst, 'wb') as outf:
+                outf.write(inf.read())
+
+    finally:
+        if mounted:
+            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mnt)
+        if loop:
+            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
+
+
+
+
 @pytest.mark.buildconfigspec('cmd_bootflow')
 def test_ut_dm_init_bootstd(u_boot_console):
     """Initialise data for bootflow tests"""
@@ -476,6 +507,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
     setup_bootmenu_image(u_boot_console)
     setup_cedit_file(u_boot_console)
     setup_cros_image(u_boot_console)
+    setup_efi_image(u_boot_console)
 
     # Restart so that the new mmc1.img is picked up
     u_boot_console.restart_uboot()
-- 
2.43.0.rc1.413.gea7ed67945-goog

