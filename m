Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635FDC28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF2C81DCC;
	Sat, 15 Mar 2025 15:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BMYyEAQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56AF081E47; Sat, 15 Mar 2025 15:28:14 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 523DE81D1F
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so6900145e9.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048891; x=1742653691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/IwPMTHvj5FFLQjRCi1R/eOx1mnSecd3HaStxBi8D4=;
 b=BMYyEAQZ/DYPdmbx2kwqZ3BxHKnAljmxY+EA9xRLUZRe6ukp1Nz1a4Uo+lFajvKQkM
 M8WPRSIeTocaOBktZLBIoclo+BGbPBoYmgsOG/IKl6Zjm8mv5t+RGLn2zSgc9WZSb3Wu
 AQWm8sa5d1dHPBLzNz5coKw8yYzvwsMRcPVWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048891; x=1742653691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/IwPMTHvj5FFLQjRCi1R/eOx1mnSecd3HaStxBi8D4=;
 b=ZEaRvqGjLNuDrItkm/hLF3VocMn19q46GBVqJFNzMUVSU6zT0cuIjUVzDPmnqc07H2
 ig/A1ySIGQ2hASYLMPkTOdcrsa5SNdT2jeYuDxprb+2S/kamWo64qdTn1t0vVaE7TGjR
 8hJ3vu9sse3Cn3bQy59GXaUMR0AhuaRtUdBZCJ+6p7HiNt8YTM308p9OaSFAQ5Yo3WX6
 x1rTS9VWif21Hbvi/gehFkggtZMOSX8pNISChoYdUr9H75TAiM/B7YDFw06ipCyHGtf0
 zAiwTe1tJ3OnGhPBUATCZo72EQMTFEAJViChvBnejtBrdskdMgy0vX0Wu9i9vE18VEc3
 5kbQ==
X-Gm-Message-State: AOJu0YxZiFyZgTe8pTvOENlDWOJOWIDSU2S/HJHn8LgFUx0n+nHHRNKg
 ZZf1NptWymXSRlkKHsMz57qKcXGM0euM3nolY+KOinKQl7T47eRBkyzBMFnL1Vw1t74PEmpFfab
 Epg==
X-Gm-Gg: ASbGncsLE8Lq3+fxdAIu30QQk6AiZQaA7lStcjo71Yj5JW/QJpOOlLpOEH412LK67TO
 Nqts4DodNGxremOpejG3hxwjRdSxicafVGKnWyAecXjM5gmXvjTIkc5jbhMwGTg9aLBgd9xKLcV
 OkwgrNcGSvvXDscYoN3skiu3FhIEmyWn8keSpcqyK8w0f00uVDhlm0NhQml8yDb+x4TOCMeeLJi
 0mvrzlLZWFW+QeGgqJ/azhckVFArNAhEnOB8UMUqVe0Dh9BqZPxyU93KOEvJAO0bRyLoN5p80yX
 hb4qBncNWlN7881J+bCFlu2tIxQKpWm+QEiZvejw/Q==
X-Google-Smtp-Source: AGHT+IHG17zFIRFIfUL1m4scu5LgiK9sqxrda1uojFbxTvU08ekM4koXY5GhQ6/VIGN72CyK9YCZlw==
X-Received: by 2002:a05:600c:1392:b0:43c:fe9f:ab90 with SMTP id
 5b1f17b1804b1-43d2565453fmr30735165e9.28.1742048890910; 
 Sat, 15 Mar 2025 07:28:10 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 29/46] test/py: Correct sizing of created disks
Date: Sat, 15 Mar 2025 14:25:49 +0000
Message-ID: <20250315142643.2600605-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

At present the disks end up being 1MB shorter than they should be,
since dd truncates by default.

Move the code into a function and update it to avoid truncation.

This resolves various warnings when running sandbox tests, of the form:

   mmc_bread() MMC: block number 0x9801 exceeds max(0x9800)

caused by the FAT partition being scanning.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to correct sizing of created disks

 test/py/tests/test_ut.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index ea0c43cd4fc..b8adb597e11 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -57,6 +57,17 @@ def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
                              stdin=spec.encode('utf-8'))
     return fname, mnt
 
+def copy_partition(ubman, fsfile, outname):
+    """Copy a partition into a disk iamge
+
+    Args:
+        ubman (ConsoleBase): U-Boot fixture
+        fsfile (str): Name of partition file
+        outname (str): Name of full-disk file to update
+    """
+    utils.run_and_log(ubman,
+                      f'dd if={fsfile} of={outname} bs=1M seek=1 conv=notrunc')
+
 def setup_bootmenu_image(ubman):
     """Create a 20MB disk image with a single ext4 partition
 
@@ -172,7 +183,7 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     fsfile = 'ext18M.img'
     utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
     utils.run_and_log(ubman, f'mkfs.ext4 {fsfile} -d {mnt}')
-    utils.run_and_log(ubman, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    copy_partition(ubman, fsfile, fname)
     utils.run_and_log(ubman, f'rm -rf {mnt}')
     utils.run_and_log(ubman, f'rm -f {fsfile}')
 
@@ -224,7 +235,7 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
     utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
     utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
     utils.run_and_log(ubman, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
-    utils.run_and_log(ubman, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    copy_partition(ubman, fsfile, fname)
     utils.run_and_log(ubman, f'rm -rf {mnt}')
     utils.run_and_log(ubman, f'rm -f {fsfile}')
 
@@ -562,7 +573,7 @@ def setup_efi_image(ubman):
     utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
     utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
     utils.run_and_log(ubman, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
-    utils.run_and_log(ubman, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    copy_partition(ubman, fsfile, fname)
     utils.run_and_log(ubman, f'rm -rf {mnt}')
     utils.run_and_log(ubman, f'rm -f {fsfile}')
 
-- 
2.43.0

