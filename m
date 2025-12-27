Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03CBE8FDCD
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 15:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF6F83C6E;
	Sat, 27 Dec 2025 16:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="lO1iRnvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0654283B91; Sat, 27 Dec 2025 15:21:48 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DCE483B8A
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=manjae.cho@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20251227142139epoutp03f3cc76264d70ab9cf38a927e3506c8c8~FGHBOMRFO1691616916epoutp03F
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 14:21:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20251227142139epoutp03f3cc76264d70ab9cf38a927e3506c8c8~FGHBOMRFO1691616916epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1766845299;
 bh=IqpMu3YfBTj8kmqChHBfhmYSuDcBM8aquHV4sw3Uugs=;
 h=From:To:Cc:Subject:Date:References:From;
 b=lO1iRnvQam9+fGvm/3Rf+WQKQBo8Yr87l4QXtKK36zg7INAR1BFLFv+qwUGrN9fQT
 /LnfyuS9Y/gWUcQuiE6qKO43z6tgkg5DK6134llzOMx4YnBxE+AtPqIye1Ljdf3iXw
 5hX9VbIHpwvkEd7MEiGdfTCTwQit/Ca11dYB8whY=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
 20251227142139epcas1p3f1f5865463455c57abde504fcca90c5d~FGHA9WgpD2541425414epcas1p3q;
 Sat, 27 Dec 2025 14:21:39 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.190]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4ddl6B4kYPz6B9m6; Sat, 27 Dec
 2025 14:21:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20251227142137epcas1p4115a7a2e7519bbddc095c9d3baf760f4~FGG-jDkXC3266832668epcas1p4r;
 Sat, 27 Dec 2025 14:21:37 +0000 (GMT)
Received: from manjaecho-VirtualBox.. (unknown [10.89.15.251]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20251227142137epsmtip2fb275592c9cacd15021cd8945fc82afc~FGG-hEyFJ1522315223epsmtip2Y;
 Sat, 27 Dec 2025 14:21:37 +0000 (GMT)
From: Manjae Cho <manjae.cho@samsung.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, xypron.glpk@gmx.de, sujin.u@mobis.com, Manjae Cho
 <manjae.cho@samsung.com>
Subject: [PATCH] Fix typo "addtional" -> "additional" in pflash section.
Date: Sat, 27 Dec 2025 23:20:36 +0900
Message-ID: <20251227142036.10661-1-manjae.cho@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251227142137epcas1p4115a7a2e7519bbddc095c9d3baf760f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251227142137epcas1p4115a7a2e7519bbddc095c9d3baf760f4
References: <CGME20251227142137epcas1p4115a7a2e7519bbddc095c9d3baf760f4@epcas1p4.samsung.com>
X-Mailman-Approved-At: Sat, 27 Dec 2025 16:08:33 +0100
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

Also add network testing example using virtio-net device, which
should be helpful for users wanting to test U-Boot networking.

Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
---
 doc/board/emulation/qemu-riscv.rst | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
index b5948d9affc..25fe7beb43f 100644
--- a/doc/board/emulation/qemu-riscv.rst
+++ b/doc/board/emulation/qemu-riscv.rst
@@ -43,7 +43,7 @@ qemu-riscv64_smode_defconfig instead. Note that U-Boot running in supervisor
 mode requires a supervisor binary interface (SBI), such as RISC-V OpenSBI.
 
 To create a U-Boot binary that can be utilized with a pflash device in QEMU
-apply these addtional settings to qemu-riscv64_smode_defconfig:
+apply these additional settings to qemu-riscv64_smode_defconfig:
 
 ::
 
@@ -205,6 +205,29 @@ Invoke QEMU with:
     qemu-system-riscv64 -M virt -nographic \
     -drive if=pflash,format=raw,unit=0,file=u-boot.bin,readonly=off
 
+Testing with Network
+--------------------
+
+The QEMU virt machine supports VirtIO network devices, which can be useful for
+testing network functionality in U-Boot. To add a network device, use the
+following QEMU parameters:
+
+.. code-block:: bash
+
+    qemu-system-riscv64 -nographic -machine virt -bios u-boot.bin \
+    -m 256M -netdev user,id=net0 -device virtio-net-device,netdev=net0
+
+This will create a VirtIO network device (eth0) that U-Boot can detect and use.
+You can verify the network device is recognized by checking the boot output for::
+
+    Net:   eth0: virtio-net#0
+
+From the U-Boot prompt, you can test network functionality with::
+
+    => net list
+    => dhcp
+    => ping 10.0.2.2
+
 Debug UART
 ----------
 
-- 
2.43.0

