Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250D606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JCvGLmsb;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=3uyWkbUp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B20E81067;
	Thu, 29 Oct 2026 16:23:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jcMOtY7beaVq; Thu, 29 Oct 2026 16:23:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40E9481008
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291026;
	b=YCdEYJislDZgk8oMmipaiJ0g0N2DhpdoFmAW2L67Qt+K9pWQvQMSrMWgo3+WewFDkrHQ
	 wj5c58OsUYylU6hRSu2/yDOTXMX+nWEcG/qsHEX7YzXks/HldapvVPly1u1GVkOFwep5f
	 k7l7iqkvuJwLcLkbvZsvmLW1svApZlPsqO8jSpIDAyD00rZlI406qxsmEahufJcAMGeNu
	 1isml1nhz9ZskCCIp28O18o/j3Bfe88GW7NfHM7A7r0WSl/BSfltkuI264knD8WpzKEyT
	 jcYFAxZbrO0QVssvUY7VXN0c2GG2vVJQga8/Cd7khugVb/nzPlkxRta6dpy8WW07wqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Wnz96JMdK+GVers+ILfKyvHCza4+SlF+PUeXR6e+IaQ=;
	b=irSx7gMqy7m3w9E6CbCDaKxFmd89z6EDeQ2eWFqiEh/7hy/0pNM9YIXxD1vCoMZsVK9V
	 H4v/+s11+RmXWcaJmTePugQ8egLPIU3kTpPAxg8/G+C9I/qb+V2kTcRQm2qAyAqro0CBk
	 ISbCXHj82YFfN+ChBl1v13tv+1z/isq6TX2rzji3PqLM+e3k4eEmkC3N5/5SU3gAU5t3s
	 8J6ihaQSI1IPOna9t9G1Wfu8Cpa/w0aQ/LTPqzPRr7u3zu1JICpqy3Sq+gfSGJxvli5w8
	 s72Mc0sQXGi6oAonI5KoAaaGeEQKUY5EC+VYw4S4K1+ozb+zI1omUwlJ8kbMKSR0eqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291026;
	bh=Wnz96JMdK+GVers+ILfKyvHCza4+SlF+PUeXR6e+IaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JCvGLmsblebKUaEBsp1yvO/hLICa1TxpH9BGxFQYx1wv1oiwk8hGsU62w9BtxlUam
	 gq2boGvALylFwkfBHX5V771JjwejJFWp0N0E867q1b7UhQAun3ESYqgMldOQgH44NF
	 ntdcbMT9VsGcZXEicPYZv3+72oaO3B76qZOLZOIo+42RDCW8hzbcwLW3R4GXundPPQ
	 aB9riPgvNJUT28qU2EVf4QI8sHq42D6bntv/Ap0hhhxro3NA1bMGPAmMUzg4xpAyCI
	 AMO0E6ZnPJXgVsLWCT/8bwcc3Rmffi3PATUFCRXSF9SHf8y+tiYkP9kc+Yin8F7PQ5
	 Cosaq1U/RJJ/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40E9481008;
	Thu, 29 Oct 2026 16:23:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4518B362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3731040764
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T8DjjWoRkdIU for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B52740744
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291011;
 b=LmFRMYyo75I3cJix2Zbldf+ST8KA9gWr/iwC2ZBmTdtsQ3APn13Uyesf+zMQVLgWn9Hi
 h7XirE1RgC4GiKCuJSPDJkiOZyc14D1Dmw1ode4x7y7qBGQnpa4E/mtESTkDkqvD5lguW
 f/CA6lbzSTXjfU/N8PjtHDK86hC+nE7sVCb78Khc8CD1tqRXvLBFeRT56XVILLN0iQOZK
 CNYYJhc/F+DAwNN5vb9zzZ5l1ZkUKSdFkUnsZHmMniPTWRgdYHdnvF90mniJKD9XOxIxY
 OddUPhYIbpGHOQBJHAzGmWbY1bkb7xasmStkUNXaSXeuiQ0xVAPC/ZqWV4BzuON5Rsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291011;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=Wnz96JMdK+GVers+ILfKyvHCza4+SlF+PUeXR6e+IaQ=;
 b=TfMzt2BymlY7sWDuSQKfg7cccb5/1Ksn6LtYHdndwjiepYpB5ATlkgjpW/39FKdTJeBe
 Xw37oQrqfkjZGV4CXW6gb/bYmJzsjp0bVmJCUN+vkWuIzfjDnba6gOz9yp9z3wYL26hfX
 tT5NRkDi7/CHx3fN1ETvsG3+8Rxgsiq1i9DzDl2Din5JvQ0OAKevjCGYnXG5IAjm5kJt9
 DKUTTR04WrZLV9PNhDHmsvbJnpuFoHC/+7RyEzDxct9GpzEof2qS8ryefCivA+kdOlHUt
 OGdiIbkci3JKQiiiafQ2zZM6DNWHQNe9baPdEgSuKidqlGmybqOAUCe6gsYeNbPQnEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=3uyWkbUp; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=3uyWkbUp
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B52740744
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wnz96JMdK+GVers+ILfKyvHCza4+SlF+PUeXR6e+IaQ=;
 b=3uyWkbUphkQD6TJLprBqeE9dRuHlD9AFH1ASpLKB3xQytc5thCHMLgobZM3AfwNH1IG+ju
 xrBHCMztj9D5gMO7pil7sw/0IlgwpNtFLhOXLxCQxUc/K6h8AGQCgq5AwPv1ViBJcCvwc+
 GN6TkVidGu000ztJA+RFGN+OrVY7NlD42D7kY6j3wOHLHLHaMH/CAU9l5E6sOtuQm7mXqr
 GGnw1j3fOK7MNnfK6mBBVRHHy9wpZAHMGyE+TOVO0zIOPnMQjWXen5h3LaIxgp3ZZNrpY1
 oMS1bzr6pw8K70730tsdm3jlvR2bI9VYJju0ahFM+1De/oRVhvU92Uk+JNeWEg==
Date: Thu, 29 Oct 2026 17:23:14 +0100
Subject: [PATCH 08/10] test: fs_helper: Support GPT in DiskHelper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-main-v1-8-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
In-Reply-To: <20261029-main-v1-0-b5a878627107@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4188;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=ZKaNCyxPkU2zTIaMaitAzt/ifPtQaB+3D/rIwYbL/vc=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0a9SlnSfbYkFnteTTgc5JjilS21zPxq35HlFSUPR/
 kSVzoyOUhYGMS4GWTFFFil+i9e2ZrE+8seqo2DmsDKBDGHg4hSAiZytY2S4XTzz1NTNcYv+OYht
 9xcJvXnnveOp+Vd+sO/Vv5p7Za2dPMM/3arn1awnav+06kjsmHcvfs7Hv3yv3uiFc5mvOFu2Zao
 XPwA=
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
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

