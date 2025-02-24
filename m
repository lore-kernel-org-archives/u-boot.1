Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6203EC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 121DA81250;
	Tue, 25 Feb 2025 00:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YFyfLenf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6EDD80F56; Tue, 25 Feb 2025 00:07:57 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E24C811B3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-855fc51bdfcso61622739f.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438474; x=1741043274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2yZwtyWKKafSbYpOEKEx5PhErMcd+i5hN3K4rEa4370=;
 b=YFyfLenfslooG7gsseQFU9mPur+l9QJLB9VrCRa/4zOrbeptAI6+AKcSaTOx59fGGc
 pJ9ubBvpbgWL1+QXpnvo822iDszq0WiZ98AnyvXo5A0mrBpbb2uKrwZSEOdkKH98chOS
 SN9hmOTe9XGk60OWfJoBVJ2bBWO0EE74Yoc6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438474; x=1741043274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2yZwtyWKKafSbYpOEKEx5PhErMcd+i5hN3K4rEa4370=;
 b=bWv3kT0w2H5mOnFS06JrbiDFaOJGigxoqgXYsELCaDixoHynQLjWbOM2UbYZttffJM
 hh/71dn5bwtI5hGcWPhX+80Vyr/+UPqbjfbTG8E/Yq78YI5g/KUrircnr8Vyeoibl3et
 L2S6ok1aO0/9n2mrjRuCp56VqlvDnlCx40eWZpLbNubz0clCro40jtQc6GUu82tQKcyn
 gMHaUPOLvertDjEEoqZPK/K1CTPwEpVoHrlm/ye6RkI5/Pskwl6nCyu1vnJVGQdX85x8
 gP26751Q6j/62BcJAP3EWbp8OwsPiw8H3uRKfaA66zIeBYUCNJmKRQ6KJoo7m5Y2vlAh
 N3Bg==
X-Gm-Message-State: AOJu0Yxik1xZ3Eog9RRIzvNzXBR5Q5DFXvDY2L9p5eEMT+AhrQsTEJkH
 4/U9a2tBthaw/NO9LWLuq1V/zkPDCZdgz1cz+9k7qpTMi3bemzfTL9ZVRu4h7yxeJhAd0gg6F00
 =
X-Gm-Gg: ASbGncujOb7+39Xo5JQPHmzOznFLqurYRWarwp9MGCZLwBXnfvSwEZ+fQDNYd+qg+oO
 NLtLP6eb+9bTjjPunn8uxtXAzJsFYnrRmrT98romQa07NJqzlcZhJRZZ1BtYixpJ2pHRr72kzyz
 pgETjIxT4EbmZk1Uwc1ReFaMYCuHalnOvkJgsQ/QElhZWWWhLyQgt5XT6Pc/vxc5+HFtUcLYH83
 USRRnJzB+MqrEJKvVz0aPz7n/Xu0SNcH0+eF46QDs/8rUce6zVIVds84ZT6JpG7TxGLIfr4Pn3I
 7O1OTgLUHovV/F5tDVYF955Pb2syDKff9GRs72PJF3sUVV7FPx0BkxsdOfm6oQQ=
X-Google-Smtp-Source: AGHT+IGrsebPuSeRlY2F9DCeU5dlL71PdeeNLd7pli/w+/aofhhvF1wHuPXicx6jGqdSNgNfP499iA==
X-Received: by 2002:a05:6e02:791:b0:3d1:9bca:cf28 with SMTP id
 e9e14a558f8ab-3d2c0239750mr148055735ab.8.1740438473707; 
 Mon, 24 Feb 2025 15:07:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 27/44] test/py: Correct sizing of created disks
Date: Mon, 24 Feb 2025 16:06:16 -0700
Message-ID: <20250224230640.2665206-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

