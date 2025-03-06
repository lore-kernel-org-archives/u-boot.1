Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFC6C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E641681433;
	Thu,  6 Mar 2025 17:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JPYvrPBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABAC481433; Thu,  6 Mar 2025 17:05:53 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A9781CAF
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3ce868498d3so2616985ab.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277149; x=1741881949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/IwPMTHvj5FFLQjRCi1R/eOx1mnSecd3HaStxBi8D4=;
 b=JPYvrPBiKjmwVS/0MEffC2JDBxeZu2Ex26ZMTcQnuVfz9zXFtgNrrjTXaTr06z12RJ
 DEtSdDx0z+Nw+cY9Iv8LVbtQqUbvi3xfdD00RBYw5ZujmSIEtuGziMoVJ7DWvW5AB1tI
 JQR2b/I+MzA2iS0bhgzPv52kubeFExSI6Xs+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277149; x=1741881949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/IwPMTHvj5FFLQjRCi1R/eOx1mnSecd3HaStxBi8D4=;
 b=n6Nb3gQr85/+3av+jDPq+Kt6uMKDxa6G9NRDqH6q56JTgmt/savXXv40Pk3E2M+ewd
 MOCv25Pq03do/yRXi5CHIootQv5Cyb5AJBUA+mwUtbgKrJPwcwzMhGIatG96lTLZOOvX
 uia1OJggLqIOP8dz7UnwxFdZdm4A0gAinbb5nKt+OGZsGUsyS6sKr/y2ddvCoIJ27bxQ
 12Jyze4Wdg64jF9HQGnD4pr7/V9jETLm477dX8VFQrbCTeOAb/4tO24PxoIzKGr8dNOE
 qTga5aSfmdJ8N5fKfO0Lk3WD1530VA3eu/6u9GZ1sE9mRxG+CdbKd9qt84++Ud3MQBF7
 MhQA==
X-Gm-Message-State: AOJu0YwJVxRNwAca0eocTsK7OQiMbB0Y7pQU3dQRvBz4YDa4a8ZUq2XF
 t63cLD8cBaaQeSLIot08p+LC8xCY0sCgFlO8whkPOxIcx0kUxhyKHMen0/oQ+OJCyrK31OU2tVc
 =
X-Gm-Gg: ASbGncsr+CZI1zQl8UfXfjaaoSqu7cPxBhRsxb0YdI7S+HptC5f/I5JiWNBxvQR6Bdz
 Cpu1TJ8wzBijdrbH1ct1xYv2yXmfGs46fLwmg+dlByh6+2xWBBP7eegUps+1Twtfdb6Zec/KgwP
 jWJxY83oz1f919g+kRHPDUM5iIGXi6F1uM4L0K9xB21XiesMshatCtTu9GYpChZuF/dAdvblazd
 kPOj2ULbqeP7BJeiPAe0Tg+yzuInE/UGyR8i382xbu10L3ZOgStaN4TRxVWrckPr9faEcDezVAF
 dQ7lTbDmmM98gwLANoULMzqNV7EubnW8A9i6uAZni0yxKRtsv+qpsKdGWTgc2poViHdG/20JaLD
 vYClIhg==
X-Google-Smtp-Source: AGHT+IFF+w5NTp57/PkUepD7fSrNTt14Y74N9G1u1uLIJQRLgRRTXn9Mb/EaDPESAIyTl345UL/lHw==
X-Received: by 2002:a05:6e02:1f0f:b0:3d3:fdb8:1799 with SMTP id
 e9e14a558f8ab-3d4419b2bdemr229275ab.22.1741277148912; 
 Thu, 06 Mar 2025 08:05:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 29/47] test/py: Correct sizing of created disks
Date: Thu,  6 Mar 2025 09:03:56 -0700
Message-ID: <20250306160428.3041057-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

