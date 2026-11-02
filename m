Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A27606ABAA
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pOpzp0om;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=MJCdp46b
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 534D760822;
	Mon,  2 Nov 2026 16:21:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YVcS6_L5EE26; Mon,  2 Nov 2026 16:21:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7412B6081E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636466;
	b=mYKhfDcQ8T5h431HveKNTjcVjQmn3Q/gIZCm8X2FDdF7+L106+KR8CaszAEjmlI5oOVl
	 ZU7cW7/UYT1/WfMmJSem43u/5V+d1fmKa+ws5IC6bno0DjtylXm+/Oo1IYulErds9vBal
	 jvbvZz1X6Imlt4gm57tmqBBpsmgfh+ihvPQRkLeU6in8rB8DCNaX8UWe3OWC7ibVD/csf
	 /uew+CkQYhX2hAeLJdLaPbjRET1Zx9svwOXJ2Dm8aQMJSZDfzca8m0k+YhHESdoVNl7Yw
	 odAE/ixiMY4NGoRlG7adq4dqMrgDhTWW8axyQyYuiinQd2sVD1nAfh4HRYlNvcwa6cQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=evy+D9nUIsg/D3zOGpefk/eHt7i0d/VYLMBKKVsVKLA=;
	b=aWziscDj7V3tmJ0Urf5Mj2/YoxEPHm+5o1SOAXxdsvxqR5JcouZyrM3aqVGHGvHigsQq
	 AGOmr0J9BYf9e7+tXZ4ohcVhwHfKH98TLaZL0OtS116DacnjeOosct3SASdEDWKrVCokG
	 RYVv9Wp1yHDj/3M9ahOB5jNeIHpBJ7Q5HQJK+kl9C4BWlM4fa7gyJCejRbvzVmjEIyJ3T
	 87YCgOdXY4ivO8OUbbXKZORx0iw/azxLo6CrZIHufSxBxURcFILUd0xRHixdMHgzPZEI6
	 AEJL/tJbgVBM3YtLouMwltpIb0b+j4XcQF5AXI77D3UC7wYOj+1AcBlvC+epKEBXAgw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636466;
	bh=evy+D9nUIsg/D3zOGpefk/eHt7i0d/VYLMBKKVsVKLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pOpzp0omrP+w6R1aaOreMz+rlJkUZjsLwD6nTrcupvcrXm7mjKz0Jgl2qbMnJ2Wkd
	 EEAxzvIj8FAo5kzIu0l6aakyZ9BsUhAuxSF1yKcpCYKuJ1R/AMnldjjAysGNeQGma5
	 NECLwwNYr56rK/QavWW+kjIUhsQFfByJdFpDqfcFUD9BgZ50C0xVDDPQtjtQQ5hp1r
	 JN63uto7I+wfgEisB6m+BDt5kYZXh0Q+tAv+IrH98M1mr4OqzN1M+1YJn8lAL9jOZ3
	 M3YJRyjXq0Zd061Bo9bzXeZcEomVL0yGYNrTV3D6VehIWe1IfzZ12h4Dw7eJOA67wO
	 MsEXKBB9MfBuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7412B6081E;
	Mon,  2 Nov 2026 16:21:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 45540D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 370A48100D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iTxDq-k9tAyU for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 530E881090
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636454;
 b=AS2l33Eff1smbVBqEQSxKLGw/Rv5h3+4ute3WQS7H5C31Fl8PfzrR27gEyCjE9GxlUN2
 0+kOx9QFN1qDuw9VjzHwCFMJQ1RHBXeEimNg+9VULvtyfc2cLwZjcisaGaJzGuRpL6Zh1
 HqS5AnQcywrD2R9g270v9x9Nz0mxJ+vPr16x/J3vLCt7fH4cxAihS15r6vVG/stP3YlLk
 BWFmNgnNoZai9fSYlRtX23PxZPwSCRf8vll8iZ54lDjOfKG11b2/ki7gHjlDs0zG8vdj2
 zZY9829XSSAnuuBjvZX1SHxl5fa2cKQT7FuMOchcwTkx5BZLVWDCaiUrETpeKpjP9Iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636454;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=evy+D9nUIsg/D3zOGpefk/eHt7i0d/VYLMBKKVsVKLA=;
 b=Trrrg4TN99h/uDrCatcNmQuNuu9N9vhCAm1CFj1rOkT0wAceMmgOtvFiL6ApKWH6Gzyj
 dPyVKSwM+s6R/nyehGeOIwx6zsK25ysVZTnKfmMjWH5Wn1ay0bjevXANSAlfdCGHoPmiG
 5U5ZG7UJxkHv6nau/Bx7rYVutXQ0ErpbuumA7Nbx8xQSxrJiFJoo+BD/MC/G6i2/H1RAV
 VUICbiGibvrn4gGKcWj9REEX50JVyHKofDgUoEMLpA34Oiv7l0VwrZvxr7qvX0DkHAL+Y
 EgJmAplHpohv8xDM7Cj0Cs8ZwlBdK72WOkK4m7v9t89kKpvgpyMzXf9jcHfV8cam9/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=MJCdp46b; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=MJCdp46b
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 530E881090
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=evy+D9nUIsg/D3zOGpefk/eHt7i0d/VYLMBKKVsVKLA=;
 b=MJCdp46beOUevlxoZ4l9NGXrvzbQ7ItXWaUV/509uGDpxqRraGY2dfFSj+rRRQRA4bHOKJ
 ivfdGzNTenU2eb17J7WdN/p+0GotVCzAzZmMyR2+VlNuWQJlh8XsOZ13uDzCSc+/uw44b8
 OP67REPH9cCNtN7K8aQ7ImbJ+b568HWILVBkm0UAZ95cZJgV8ptzl7lTMT01cp3fjYykFr
 HsK2OAB/MOEacT10Kd2zh5vBrX07oeznkzXT0VvdnQGowH/vsv02lHIZFQuIln6dJpp44a
 i8JIowiQWG5fVzU86KIf1H5RsTdMrScwMgEzdrj6gtf3gzBCf/UGfuHK5bfUvw==
Date: Mon, 02 Nov 2026 17:20:27 +0100
Subject: [PATCH v2 10/12] test: fs_helper: Support GPT in DiskHelper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-10-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4288;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=IaYUYPQGDsRF5vC/vsDfkl3VyXQecwRRWyHfO7/n9nw=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjjjFgx0ixa0Z0SHaRzcyrBFXX3zJ3Xt2r6mTSfL2t
 e+PyjztKGVhEONikBVTZJHit3htaxbrI3+sOgpmDisTyBAGLk4BmEjPV0aGbZFH1lX/WJJpv7Jn
 +9d+jYa73NEbG7s2GN76v/F+JMOEDYwMH3klF0tXfnjJGhCXfn7jKi/5p+rzL03VNQ6YPn/+8oe
 XeQE=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

DiskHelper can only create disk images with an MBR partition table, so
tests that need partition names cannot use it.

Add a gpt option to create a GPT partition table instead, and a name
argument to add_fs() to name a partition. With GPT, the 'bootable' flag
is set as the LegacyBIOSBootable attribute, which U-Boot reads as
bootable, and 1MB is reserved at the end of the disk for the backup
GPT.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Add Reviewed-by tag from Simon
---
 test/py/tests/fs_helper.py | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index e3824b2c1fd..d6e0f5e65d7 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -124,7 +124,13 @@ class DiskHelper:
     VFAT  = 0xc
     EXT4  = 0x83
 
-    def __init__(self, config, devnum, prefix, cur_dir=False):
+    # GPT partition-type GUIDs for the above codes
+    GPT_TYPES = {
+        VFAT: 'EBD0A0A2-B9E5-4433-87C0-68B6B72699C7',
+        EXT4: '0FC63DAF-8483-4772-8E79-3D69D8477DE4',
+    }
+
+    def __init__(self, config, devnum, prefix, cur_dir=False, gpt=False):
         """Set up a new disk image
 
         Args:
@@ -133,37 +139,49 @@ class DiskHelper:
             prefix (str): Prefix string of volume's file name
             cur_dir (bool): True to put the file in the current directory,
                 instead of the persistent-data directory
+            gpt (bool): True to use a GPT partition table, instead of MBR
         """
         self.fs_list = []
+        self.gpt = gpt
         self.fname = os.path.join('' if cur_dir else config.persistent_data_dir,
                                   f'{prefix}{devnum}.img')
 
-    def add_fs(self, fs_img, part_type, bootable=False):
+    def add_fs(self, fs_img, part_type, bootable=False, name=None):
         """Add a new filesystem
 
         Args:
             fs_img (FsHelper): Filesystem to add
             part_type (DiskHelper.FAT or DiskHelper.EXT4): Partition type
             bootable (bool): True to set the 'bootable' flat
+            name (str): Partition name, only supported with GPT
         """
-        self.fs_list.append([fs_img, part_type, bootable])
+        if name and not self.gpt:
+            raise ValueError('Partition names need a GPT partition table')
+        self.fs_list.append([fs_img, part_type, bootable, name])
 
     def create(self):
         """Create the disk image
 
         Create an image with a partition table and the filesystems
         """
-        spec = ''
+        spec = 'label: gpt' if self.gpt else ''
         pos = 1   # Reserve 1MB for the partition table itself
-        for fsi, part_type, bootable in self.fs_list:
+        for fsi, part_type, bootable, name in self.fs_list:
             if spec:
                 spec += '\n'
-            spec += f'type={part_type:x}, size={fsi.size_mb}M, start={pos}M'
+            if self.gpt:
+                spec += f'type={self.GPT_TYPES[part_type]}'
+            else:
+                spec += f'type={part_type:x}'
+            spec += f', size={fsi.size_mb}M, start={pos}M'
             if bootable:
-                spec += ', bootable'
+                spec += ', attrs=LegacyBIOSBootable' if self.gpt else ', bootable'
+            if name:
+                spec += f', name={name}'
             pos += fsi.size_mb
 
-        img_size = pos
+        # Reserve 1MB at the end for the backup GPT
+        img_size = pos + 1 if self.gpt else pos
         try:
             check_call(f'qemu-img create {self.fname} {img_size}M', shell=True)
             check_call(f'printf "{spec}" | sfdisk {self.fname}', shell=True)
@@ -172,7 +190,7 @@ class DiskHelper:
             raise
 
         pos = 1   # Reserve 1MB for the partition table itself
-        for fsi, part_type, bootable in self.fs_list:
+        for fsi, _, _, _ in self.fs_list:
             check_call(
                 f'dd if={fsi.fs_img} of={self.fname} bs=1M seek={pos} conv=notrunc',
                 shell=True)

-- 
2.56.0

