Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD058606A337
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lRAFeQMs;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UijfZMr2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AC38406A1;
	Sat,  7 Nov 2026 16:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 124aTUBcnuT1; Sat,  7 Nov 2026 16:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E6421406AF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794067486;
	b=G90WCi0PKPZmP7M+gGEbOtCZm4gyaOcdWMcFgF9bc7qUZmr9os6tFj0YDqeTUemwMJWu
	 r650nUfCxZ719b/4onNSkznpmTE1cLbYsoVlP2ojtgQfnyAhNHPGwWpAoDMLZyPO0GdSK
	 rNJrxgb0lQCUTwrVhhhhr0h0Sb55vqH7HbZimMzO9+p9sNwxRfVRxfRVSXIEcsdDTEXNY
	 pPK4UeDMbOZXbOB+wGf21Hf4RHXODEMmGAP2H35zTNwqSv0C7LBUyg/wNSIwNmxQw5Aro
	 Wz/oGPGH+xJMgk4aQ/c67qlFmgstXibkn7YSsVCHIqm2OQe0YSil/Oxz19Oj4y90PZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794067486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L14fIkF5Z/tN1SUN2KgmY2zDM02JJAK+qynE4EKx64s=;
	b=I18s3dCPZ7d23EO9vy+e8oQAFc8fhkXu1HRVFDmG0xds33vfHtbDdaiGZR8H0K/iKu3U
	 Kptu9ClfdxRzVz5DutykhcRwBBQFw1izC8OQ0F+d5a3Pqx8Lkg3YOMlZUxJVKBIZDWrLX
	 KKDrAAG+Ri08LDows7AM0PPONj//Bw5NrxyRkNcbGZDoCXprbnHWDaPdlHTtWQ1mfx4O4
	 d5fhbT+i2gnmWXBN2yodQdGc3eKVEV/4QsgRUlGloO5wZEbLA71nYcXT9rdadQutNbVRD
	 fcLoReMVk0vR4+FdJzaMFFQfNiYrcNFzH6WvlhHkc206C8BFwymCT/KAHNR8OH6JzXQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794067486;
	bh=L14fIkF5Z/tN1SUN2KgmY2zDM02JJAK+qynE4EKx64s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lRAFeQMsRI4zvcJfjyM3FwI0g9Dqv7nq4vRCWM/mO2QvBzYKLlpquU8OUBZVuJt3K
	 R7d7MeUm0dBmnEAN/Ay/lPE2kzaligL9SR78ZOEgkZ1eep9/T0ha/RDtf6b6OcfReX
	 AMMfuR3aWpuXYkyAVc5YFCQ/c69p4Td/iCX4r5qI1Z4XYMSzZ6qRDh0nXhzcclsHhF
	 vcu9O3HC7N0lt1Y0lXtDYB0BnJ0LEBY9YmtxnnXwtUPjQF3sGevNUTQpuNSq2aYMzi
	 CAgMBYmacNOvDj4YgWzsPLub3CCVRx/xZv0VeY1h8VIwzE+LYB2cdozipmIuLJ7Ss8
	 nSqJW1x4rYaDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6421406AF;
	Sat,  7 Nov 2026 16:04:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7495D1C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65E7660669
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v9a-mrsBadcB for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 16:04:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14EC46065A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=117.135.210.3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.3;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=UijfZMr2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14EC46065A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=L1
 4fIkF5Z/tN1SUN2KgmY2zDM02JJAK+qynE4EKx64s=; b=UijfZMr2HAN7gAbXji
 yMa6wqwZRUFGWd+nvZz+fmSwFMkDvHFh21b4akbZ/me9FQBeByIruwSiyPfhq3Db
 VRLDvhW3vW6eSjPQMZy0oopsux8PRa7ww0K575e2rNZqHGK0tyhmO7ea/rF8T++1
 EnKulB/1QXaDEzPHR4oCHJ9o8=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wA3FCH3S+9q+f2SFw--.1483S6; 
 Sun, 08 Nov 2026 00:04:09 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: [PATCH v4 4/5] test: py: Allow custom partition specs in setup_image()
Date: Sun,  8 Nov 2026 00:04:05 +0800
Message-ID: <20261107160406.3943071-5-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107160406.3943071-1-hyyoxhk@163.com>
References: <20261107160406.3943071-1-hyyoxhk@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3FCH3S+9q+f2SFw--.1483S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr47Jw1Utw43JFWkGrWktFb_yoW5AF47pa
 1kXw4qkrn7GFnIkrySgw1kJr1rGFsrZFW7Xry5Ja4vyw1Yv3W7trWSka4rXayUW39xX34U
 Zay29w1fA3Wjy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2ZXOUUUUU=
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC0BmnemrvS-nXrwAA3b
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an optional part_spec argument to setup_image() so that callers can
supply their own sfdisk partition specification, for example to create
named GPT partitions. When it is not given, the existing layout is used,
so current callers are not affected.

Pass the specification to sfdisk with subprocess.run() instead of piping
it through printf in a shell. The shell would mangle quoted values such
as GPT partition names, which the new argument needs to support. The
default specification contains no characters that the shell or printf
treated specially, so the partition table it produces is unchanged.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
 test/py/tests/fs_helper.py | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index e3824b2c1fd..7c9577e28b1 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -8,7 +8,7 @@
 import re
 import os
 import shutil
-from subprocess import call, check_call, check_output, CalledProcessError
+from subprocess import call, check_call, check_output, CalledProcessError, run
 from subprocess import DEVNULL
 import tempfile
 
@@ -262,8 +262,8 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False)
         raise
 
 def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
-                basename='mmc'):
-    """Create a disk image with one or two partitions
+                basename='mmc', part_spec=None):
+    """Create a disk image with default or caller-specified partitions
 
     Args:
         ubman (ConsoleBase): Console to use
@@ -272,6 +272,8 @@ def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
         img_size (int): Image size in MiB
         second_part (bool): True to contain a small second partition
         basename (str): Base name to use in the filename, e.g. 'mmc'
+        part_spec (str): Optional sfdisk partition specification, overriding
+            part_type and second_part
 
     Returns:
         tuple:
@@ -281,14 +283,17 @@ def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
     fname = os.path.join(ubman.config.source_dir, f'{basename}{devnum}.img')
     mnt = os.path.join(ubman.config.persistent_data_dir, 'scratch')
 
-    spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
-    if second_part:
-        spec += '\ntype=c'
+    spec = part_spec
+    if spec is None:
+        spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
+        if second_part:
+            spec += '\ntype=c'
 
     try:
         check_call(f'mkdir -p {mnt}', shell=True)
         check_call(f'qemu-img create {fname} {img_size}M', shell=True)
-        check_call(f'printf "{spec}" | sfdisk {fname}', shell=True)
+        # Pass the specification directly, including quoted GPT names.
+        run(['sfdisk', fname], input=spec.encode(), check=True)
     except CalledProcessError:
         call(f'rm -f {fname}', shell=True)
         raise
-- 
2.43.0

