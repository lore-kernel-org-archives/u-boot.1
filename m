Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A046ED7308D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A91841B9;
	Sat,  4 Apr 2026 16:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TopcSAEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F5583B48; Sat,  4 Apr 2026 16:04:26 +0200 (CEST)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA8F8419C
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-4042fe53946so1060995fac.3
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311462; x=1775916262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVocBM7IQcbPlxxWNehuDzdP9lwa2qDFmTrtBFCUSuU=;
 b=TopcSAEaV83mhnZfYAJYvuaaKfeSBHOSAP3/CkwLi4l9VkIekW/SNGrnRLKz8vsSeq
 ENRG2Q3IjVtko06o4LhDg9IZWkFOUvuTYPeYobmhR40BDK+QMeiFAAZj6Fl78i5vf3Mx
 bgFnUVkjeOfpd5astcJ+mH9cDDLFU8PcpTzOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311462; x=1775916262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CVocBM7IQcbPlxxWNehuDzdP9lwa2qDFmTrtBFCUSuU=;
 b=TYFptvzgTefjzHSe7B4YA/rm6f533IL3VE1f2cnVKnS7NKJ1l+C6Q/4np7iZaqG6fo
 fZSe7h4q4OgbAakZlqUvrXEByE6Xa4UkD8VBBt+LFPNBvUzVjfh3Bcwmhvs4FjOTFBuo
 jPppSbYyXkyFPNW2pWTSHLtgAI5iD9aczaeUA1mt2m2Zv7vngAhZshlqIv/H9P55al+o
 g+1z1Nfmdj/QvX8Q8smhVjAwudQJ4q/HNNKL2FyQpkfTOqSqJnouRWkz6Xq1mTsVx+TK
 FTPMRZpqQn1BnR4jghrPV03Tj7/18e48LnB/f1D2wvGB9JxMgOX0ZzGAAxMVw/mswRn2
 x1qQ==
X-Gm-Message-State: AOJu0Yz+Wrkg+XOm5SQvOOHgVaNkQscwH8kHFlzuCTxeEpZXRzNC06Ru
 jaoyO7WaDYC9rRlKczEmInXyFmc2Ntl85B9cC1ZPctRxX+e2SCKK/f3Vu3so4+BlKq6EHedAIsx
 +lp7xXKGM
X-Gm-Gg: AeBDietFRU0M6Odkc7ziLmF2vy7g6QVAY6ttpdrPGTiNnhMFkGMbr7gp9Z8gNpnoJBB
 vE9QgLdgj6PJwn4908COcJJfdIp4bTi+aA5RikEtFtXa+QNpB2pRFYLfb+x2Fy8QB4um0dOmYlh
 DUgbqD0euNeGg9DwrQC6dVZTx/eS0AWtKr5LKx188spywhPMIFcZRuyzcsbLqq9QwL908+ZxeJQ
 wewfFKSQ7kGtflrL/O+rmqiD88K0FvZ0TNEc9biIeinM2IzZLJ/dVnzHNCGLfA7MsS+ivAJv3sn
 PyrdK4MrQa5OP5hwAolxVpc8yTraqGID121eW2Q6lJO33jBEMeq8r0xq1fZpez92I/Zn0LL0vDK
 A0WYh3dPJXlND3CCDxI2PWrhVen0NI1wSOW7EKYCsUgV7Dp3rGCAUA4fMI8F0lyGVfMa9RehFLP
 pXbVXQF9wROruvo21OFGJMQ0tL5xL1
X-Received: by 2002:a05:6870:e087:b0:41b:e72e:c115 with SMTP id
 586e51a60fabf-4230fbf02e2mr3362949fac.1.1775311462472; 
 Sat, 04 Apr 2026 07:04:22 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:04:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/14] test: Convert setup_rauc_image() to use FsHelper
Date: Sat,  4 Apr 2026 08:03:17 -0600
Message-ID: <20260404140328.3724864-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404140328.3724864-1-sjg@chromium.org>
References: <20260404140328.3724864-1-sjg@chromium.org>
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

Use FsHelper and DiskHelper to create the RAUC A/B disk image. This
replaces the manual sfdisk and dd commands, making the code shorter
and easier to follow.

The same boot and root filesystems are added twice to produce the
A/B partition layout.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_ut.py | 50 +++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index a858f2c2d13..dce5a37dd35 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -585,48 +585,34 @@ def setup_efi_image(ubman):
 def setup_rauc_image(ubman):
     """Create a 40MB disk image with an A/B RAUC system on it"""
     mmc_dev = 10
-    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
-    mnt = ubman.config.persistent_data_dir
-
-    spec = 'type=c, size=8M, start=1M, bootable\n' \
-           'type=83, size=10M\n' \
-           'type=c, size=8M, bootable\n' \
-           'type=83, size=10M'
 
-    utils.run_and_log(ubman, f'qemu-img create {fname} 40M')
-    utils.run_and_log(ubman, ['sh', '-c', f'printf "{spec}" | sfdisk {fname}'])
+    boot = FsHelper(ubman.config, 'fat32', 8, 'rauc_boot')
+    boot.setup()
 
     # Generate boot script
     script = '# dummy boot script'
-    bootdir = os.path.join(mnt, 'boot')
-    utils.run_and_log(ubman, f'mkdir -p {bootdir}')
-    cmd_fname = os.path.join(bootdir, 'boot.cmd')
-    scr_fname = os.path.join(bootdir, 'boot.scr')
+    cmd_fname = os.path.join(boot.srcdir, 'boot.cmd')
+    scr_fname = os.path.join(boot.srcdir, 'boot.scr')
     with open(cmd_fname, 'w', encoding='ascii') as outf:
         print(script, file=outf)
 
     mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
     utils.run_and_log(
         ubman, f'{mkimage} -C none -A arm -T script -d {cmd_fname} {scr_fname}')
-    utils.run_and_log(ubman, f'rm -f {cmd_fname}')
-
-    # Generate empty rootfs
-    rootdir = os.path.join(mnt, 'root')
-    utils.run_and_log(ubman, f'mkdir -p {rootdir}')
-
-    # Create boot filesystem image with boot script in it and copy to disk image
-    fsfile = f'rauc_boot.fat32.img'
-    fs_helper.mk_fs(ubman.config, 'fat32', 0x800000, fsfile.split('.')[0], bootdir)
-    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=1 conv=notrunc')
-    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=19 conv=notrunc')
-    utils.run_and_log(ubman, f'rm -f {scr_fname}')
-
-    # Create empty root filesystem image and copy to disk image
-    fsfile = f'rauc_root.ext4.img'
-    fs_helper.mk_fs(ubman.config, 'ext4', 0xa00000, fsfile.split('.')[0], rootdir)
-    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=9 conv=notrunc')
-    utils.run_and_log(ubman, f'dd if={mnt}/{fsfile} of=mmc{mmc_dev}.img bs=1M seek=27 conv=notrunc')
-    utils.run_and_log(ubman, f'rm -f {fsfile}')
+    os.remove(cmd_fname)
+    boot.mk_fs()
+
+    root = FsHelper(ubman.config, 'ext4', 10, 'rauc_root')
+    root.mk_fs()
+
+    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True)
+    img.add_fs(boot, DiskHelper.VFAT, bootable=True)
+    img.add_fs(root, DiskHelper.EXT4)
+    img.add_fs(boot, DiskHelper.VFAT, bootable=True)
+    img.add_fs(root, DiskHelper.EXT4)
+    img.create()
+    boot.cleanup()
+    root.cleanup()
 
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
-- 
2.43.0

