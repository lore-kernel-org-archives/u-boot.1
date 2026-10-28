Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFEA606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EZDQWAWY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pgzd/9cf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6A8380F1E;
	Wed, 28 Oct 2026 05:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0bxtehvaEMM; Wed, 28 Oct 2026 05:51:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5AFFD80F3D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166685;
	b=SCPXyUIEgxZMgMEqc+QyHc4UZDMbWx0fB7vo/7Qx4vATQU17Qf+KVLJWwBDM7W0o1oCn
	 dHSFNOcM6viA85fRmt+bHWr3Wz7kp6+veNJwqzJGDvV7V34BO/GXpGvrOGEaFQ+SrXkzM
	 ITvo9FsL5tV0AQ2rOXKGVHt0uu1uI8DmL6iId4ezsP9OVdAB9fRJ2Tp5QI2cv9M2amAk3
	 i/xGo0tVPbj6DB0iLNc7vF+yYp7yzVEQNMVcpv8oQhfdkMduO5m6SAlFUdlQmJuwz4Tdw
	 FsiV3CGb+xbiYYcdv/FzJCbA0gt9edjyY+oZAnYglnX8m1veqVn4zB61nMLrEXZ13FA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/nyuYFtjwVd+F943mjZBxxaistO/TJ0cypvzCWey8RQ=;
	b=lv1AiwxMufBpEa8jU9MV27izogUhvKPzICNeUWI0kEoHuP0tsbNlHvA/jd1BcpSxqZJK
	 WOfr2Dyg9iPGcoBu7akl58cEYZMB/1Zn0IGV9nw5ysQe72C11rZx+ZI41oZyOsBNQKgx6
	 gmRATkpcrE8OwOR7kGFzpRPv1I/N3RebqGu6DVEWDA54pJR0OatSgWB/3TLC7dq8XxnOV
	 L4bW+nD54Tj+2U2JCmSCiRmF/yJEckgNymDoflz4V6iKdBj9kC64ynDHnAgeKCwHDRHFN
	 z6aH6VxMNxijQNNzgn9LvOUJdd+R81G9ErNRi9C7xbbZOoNYnvSFukrFhDtWJzlRr2g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166685;
	bh=/nyuYFtjwVd+F943mjZBxxaistO/TJ0cypvzCWey8RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EZDQWAWYz9G+AI+VidVUe3BqjpOqCTlRygVe2zMP3uTLp3xwH+0kQlCjLjhHLD9Ve
	 Z8PxIaqBw6CljXBB6R4H1fi8Op0zaV9gL3yle5/mT/ZpLIHS6g774OigCN8WtHYKXN
	 bVV5vtLcMcGd8UgaLlAbCmhAmiTsFbvJYnrJpnmox8F2LPm3RQDoALmKSV+XJBqOfH
	 VVc0CH+nEkJrFtsiktDo/kOpo7R/fWUX89X2bZu3flCnxfDufSTpfLA4D2gGOASQvH
	 +DmfRmuIJwGB/HTsdMK7OslWAvVSHxmrDhTtvSfEDSBqH/8Y1XUuTrQGFZgdYfPc3D
	 4OEfsqGprSvfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AFFD80F3D;
	Wed, 28 Oct 2026 05:51:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B39014D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98769606E3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsDNqIWz74oO for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F409960770
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166682;
 b=pGBTPYxM5LVD8gij9jS/6//ytLVxSgpUKEoVo9LPb0zOp8U96d1rswEjJU60nsyHnoa6
 v/yJK7CWS8OD/iemKTYgN+nkmk9ZPpv7ddzYSstYO2tl0llWD4iF0XTYDQDsIAmyeUph+
 zbj64H1iIx0HRl2IMksxWW2dwjtNv7Y8AO3pZJ2wtZY0Djsw8NbWFlErG5tggbX0uC0fq
 R+L7ed4SyBTBMYBH7oUfmJs6ARqYIFnn0/551ryDYRGqy0f8WLgAJDM4uUS/gomciRcHB
 WdiqrsLI9UtnMD97rp88MMWNtdkL5Y2FaRyeW8FmyormDHF3rI1YAchznrNEynSKF8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166682;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=/nyuYFtjwVd+F943mjZBxxaistO/TJ0cypvzCWey8RQ=;
 b=bygvE5Txcm5WSA8u+rZswtzo29YbhIqwUn8JUx5VjVhFhdm27OGJFZML7ewZmxFTjia5
 x6NeP/r8kMPHhEL1KgNk0Aek5npXbtCYvsk2D+WPyyI5yA2jDDEa4XA9HO1WQULzjTVHC
 yTFmemZ44ex0RTJb1WJSvJ39NYddgTOUhYpPzqGbtr+Xn+67kD5ZZSkuJFbiEB0MUxBtp
 usGdctfUic6kNB+ZQmXYHwLBr98GdXL/Kw3J41AO28KY/PB0jOoNwgW3L1j9zu76rh97W
 dHFx733d1+oUW/H0I8ImrzAS2vi/axZghPqbUd9XyjBIuFAE13wOr+iHKDvL57Tylxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="Pgzd/9cf"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Pgzd/9cf
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F409960770
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:20 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so5724855e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166679; x=1793771479;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/nyuYFtjwVd+F943mjZBxxaistO/TJ0cypvzCWey8RQ=;
 b=Pgzd/9cfNATqQXR/k3jtcRvheF+hST9cZZgouRWyH2T2/3HnSBfIbSGRLgXTfrGLci
 xKdU9nQXW0kjPgK48T3snFkMmi71RC6FzzksHJLULItT8CG+Eayh4ofsHHoBcHq6Eh7a
 wsuyuAVHyf9a1v1hcI3wMliSF+lAW9+yRGbuixbUctmR4zbViZ4AtwG7gwSHcvbrF7Tt
 xH8pUs0WOlPiCMSxeJek5odl5baEX69J/z/H+bDfTkAp6ZTjGs36N+y+pEz0Yrt3NoTF
 0iUSRWggE24/mZVx9yODWM0Za4RbFIiaX+RwShTvnZ9eUcWEhIKRcwrsZRUtiuqPIkyP
 TTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166679; x=1793771479;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/nyuYFtjwVd+F943mjZBxxaistO/TJ0cypvzCWey8RQ=;
 b=nI+yloOm38y8FKWcaPrebfL8jUngQz1MfXBiECxos3LfnaqMvnEngSj0pnD8DZrGds
 17hSAwrXNr++VINJVk7p3g71d1ktpr8u+MF82/O8uC5H9+PduVHEtxbtAnEX1HfR+jDy
 miPfqGDebJiYmoLtpM7FYHZq3j1zxk1L9k1G8EVkLmCllrvTErnRMFMhTgqDnygUSRYh
 OPKsfF1IBRkc50tDYHMNdiCJ/ZA6WEAZFGU30683iOc/OYOWGi6TQdPaB75oKEe7/PCs
 Mn5DSbvBqhKvjqneWqjGKS0KbYVvDVElQyg58RSJ7sIDqPh/XaKazNqRAg41fRWZissI
 SIvA==
X-Gm-Message-State: AFq9FYJ5SYXokADgmX3KIfkS9XsCNWcviDw5I7x6rb5IMkjcXe69RkX9
 hVP+cuV0bew8rHXw0jHXPsvhd7FZ74FEQ1jY3hpePXneSJ88cq4ZNRpi
X-Gm-Gg: AYBFou2VSIM+TyPZfx04KQPE9eKqZdLf/VZAYi7JN80vFM5rkwy22WEd7gQ5kSSzI7K
 1jr1MJXU7WZu335wmTROufoTtX1lQ39rRZ+vah/aR7QY37CqnpcL2yHV/631eZTubmFca+mOlLD
 efAVI64GUbPlQf9jcrLPS/4wbZ7eTP+xJqRyub55zJv4RJH8ew0sqBRiFQhhpztPdv6DKWaZ2LP
 E+8W8ah5PpW+DHlelBijzJjbJnYiGv7JUcBHoM0fXmOG0wqXqbSh/9xJMzpIL7Y4DJXAEooE+/H
 Ou2pahlGQQxOBjStoHV+iXD6BXqrlPaBX+Mh6zVZCTPE65F8yUfbxNiKP+yzFTxixNmfGGi58W3
 qkUQS+B9WNvIZnppVKfqY/T2V6BVXJDA4ASm0KzqDR8XCrSQVjPbl9Ta8cF1jhL/KBy94J7Kggf
 /WNQ5li+eU5v5qH+GRuJZZYJb8+1riqlUhb8vgHI0fMpTwMcoUU9jPUlHgeey8yTgVr1pnqy4dg
 oua7uqeTGzdeVzQqBzpZsHAcp7ht61hqN8xag4Yu9caLZM0lVL2Od7e8mgw/L461QsAHBOtlZYL
 atGfWuPhNfiYdGnXy02fcBb/e/Hz9Bg=
X-Received: by 2002:a05:600c:3510:b0:4a4:7a8d:c436 with SMTP id
 5b1f17b1804b1-4a96667dd75mr21955545e9.11.1793166678810; 
 Tue, 27 Oct 2026 22:51:18 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94f5311bdsm21832325e9.5.2026.10.27.22.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:18 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 6/6] test: fs: ext4: add tests for corrupt on-disk indices
Date: Wed, 28 Oct 2026 05:51:17 +0000
Message-ID: <497901c9-56b5-4e94-9f9d-7430c7cbafa1@gmail.com>
In-Reply-To: <78892543-03de-412e-831f-de840765be59@gmail.com>
References: <78892543-03de-412e-831f-de840765be59@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Add tests that make a small ext4 image with mkfs.ext4 and check how
U-Boot handles the on-disk indices that the previous patches check:

- test_fs_ext_oob_extent_header: an extent header with more entries
  than the inode can hold must give "invalid extent block"
- test_fs_ext_oob_extent_loop: an extent index node pointing back at
  itself must give "invalid extent block" rather than loop for ever
- test_fs_ext_oob_triple_indirect: a sparse file must read back
  correctly through the second and third entries of its triple
  indirect block
- test_fs_ext_oob_group_layout: writing to a filesystem with
  s_blocks_per_group of zero must be refused
- test_fs_ext_oob_delete_block: replacing a file whose indirect block
  lies past the end of the filesystem must fail with "Invalid block
  number"
- test_fs_ext_oob_delete_inode: replacing a file whose directory entry
  names an inode past the last block group, or the journal's inode,
  must fail with "Invalid inode number"
- test_fs_ext_oob_last_inode: replacing a file whose inode is the last
  of its block group must work and leave the filesystem clean for
  e2fsck

Each image is removed and host device 0 unbound even when a test fails.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- Say that some tests patch the image directly rather than with debugfs
- Replace victim_field() with victim_has(), using DEVNULL
- Remove the image and unbind host 0 even when a test fails
- Use f-strings and record the new file's pylint score as 10.00
- Add tests for the extent depth check, the triple indirect lookup, the
  last inode of a group and a directory entry naming the journal's inode

 scripts/pylint.base                   |   1 +
 test/py/tests/test_fs/test_ext_oob.py | 310 ++++++++++++++++++++++++++
 2 files changed, 311 insertions(+)

diff --git a/scripts/pylint.base b/scripts/pylint.base
index bc39e2385a3..1905e32588f 100644
--- a/scripts/pylint.base
+++ b/scripts/pylint.base
@@ -50,6 +50,7 @@ test_tests_test_fs_fstest_helpers.py 4.29
 test_tests_test_fs_test_basic.py 1.90
 test_tests_test_fs_test_erofs.py 8.97
 test_tests_test_fs_test_ext.py 1.48
+test_tests_test_fs_test_ext_oob.py 10.00
 test_tests_test_fs_test_fs_cmd.py 8.00
 test_tests_test_fs_test_fs_fat.py 2.50
 test_tests_test_fs_test_mkdir.py 3.04
diff --git a/test/py/tests/test_fs/test_ext_oob.py b/test/py/tests/test_fs/test_ext_oob.py
new file mode 100644
index 00000000000..12f4095c6e5
--- /dev/null
+++ b/test/py/tests/test_fs/test_ext_oob.py
@@ -0,0 +1,310 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+"""Test ext4 handling of corrupt on-disk indices
+
+Most tests make a small ext4 image with mkfs.ext4, corrupt one on-disk
+field, with debugfs or by patching the image directly, and check that
+U-Boot rejects the image and is still responsive afterwards. The others
+check that U-Boot reads or replaces a valid file whose blocks or inode lie
+at a boundary that it used to get wrong.
+"""
+
+from contextlib import contextmanager
+import os
+import struct
+from subprocess import run, check_output, DEVNULL
+import zlib
+import pytest
+from fstest_defs import ADDR
+
+VICTIM = b'victim file\n'
+
+
+@contextmanager
+def ext4_image(ubman, prefix, opts=()):
+    """Make an 8 MiB ext4 image and remove it once the test is done
+
+    mk_fs() takes no mkfs.ext4 options, which some tests need. When the with
+    block ends, whether or not the test passed, the image is removed and
+    host device 0, which the test may have bound to it, is unbound.
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        prefix (str): prefix of the image file name
+        opts (list of str): extra options for mkfs.ext4
+
+    Yields:
+        str: path of the image
+    """
+    img = os.path.join(ubman.config.persistent_data_dir, f'{prefix}.ext4.img')
+    with open(img, 'wb') as fil:
+        fil.truncate(8 << 20)
+    try:
+        # U-Boot does not write to a filesystem with metadata checksums
+        run(['mkfs.ext4', '-q', '-F', '-O', '^metadata_csum', *opts, img],
+            check=True)
+        yield img
+    finally:
+        os.remove(img)
+        ubman.run_command('host unbind 0')
+
+
+def debugfs(img, cmds):
+    """Run debugfs commands which write to an image
+
+    Args:
+        img (str): path of the image
+        cmds (list of str): debugfs commands
+    """
+    script = '\n'.join(cmds) + '\n'
+    run(['debugfs', '-w', '-f', '-', img], input=script.encode(),
+        capture_output=True, check=True)
+
+
+def add_file(img, name, chunks):
+    """Write a file into the root directory of an image with debugfs
+
+    Args:
+        img (str): path of the image
+        name (str): name of the file
+        chunks (dict): data of the file (bytes) by offset (int), the rest
+            of the file being left as holes
+    """
+    src = f'{img}.{name}'
+    with open(src, 'wb') as fil:
+        for offset, data in chunks.items():
+            fil.seek(offset)
+            fil.write(data)
+    try:
+        debugfs(img, [f'write {src} {name}'])
+    finally:
+        os.remove(src)
+
+
+def read_at(img, offset, size):
+    """Read size bytes of the image at offset"""
+    with open(img, 'rb') as fil:
+        fil.seek(offset)
+        return fil.read(size)
+
+
+def write_at(img, offset, data):
+    """Write data into the image at offset"""
+    with open(img, 'r+b') as fil:
+        fil.seek(offset)
+        fil.write(data)
+
+
+def block_size(img):
+    """Get the block size of the filesystem in an image"""
+    return 1024 << struct.unpack('<I', read_at(img, 1024 + 24, 4))[0]
+
+
+def file_block(img, path, blk):
+    """Get the filesystem block which holds a block of a file"""
+    return int(check_output(['debugfs', '-R', f'bmap {path} {blk}', img],
+                            stderr=DEVNULL).decode())
+
+
+def victim_has(img, text):
+    """Check that debugfs shows some text in the inode of /victim"""
+    out = check_output(['debugfs', '-R', 'stat victim', img],
+                       stderr=DEVNULL).decode()
+    return text in out
+
+
+def load_crc(ubman, size, pos):
+    """Read part of /victim from host device 0 and get its CRC32
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        size (int): number of bytes to read
+        pos (int): offset in the file to read from
+
+    Returns:
+        str: output of the crc32 command
+    """
+    ubman.run_command(f'ext4load host 0:0 {ADDR:x} /victim {size:x} {pos:x}')
+    return ubman.run_command(f'crc32 {ADDR:x} {size:x}')
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_extent_header(ubman):
+    """ext4fs_get_extent_block(): an extent header claiming more entries
+    than the inode's i_block area holds must be rejected"""
+    with ext4_image(ubman, 'ext_oob_eh') as img:
+        add_file(img, 'victim', {0: VICTIM})
+        # i_block[0] = eh_magic | eh_entries << 16: 255 entries, eh_max stays 4
+        debugfs(img, ['sif victim block[0] 0x00fff30a'])
+        assert victim_has(img, 'Flags: 0x80000')
+
+        ubman.run_command(f'host bind 0 {img}')
+        out = ubman.run_command(f'ext4load host 0:0 {ADDR:x} /victim')
+        assert 'invalid extent block' in out
+        assert 'alive' in ubman.run_command('echo alive')
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_extent_loop(ubman):
+    """ext4fs_get_extent_block(): an index node pointing back at itself, so
+    that the depth does not drop, must be rejected rather than walked for
+    ever"""
+    with ext4_image(ubman, 'ext_oob_loop') as img:
+        add_file(img, 'victim', {0: VICTIM})
+        blksz = block_size(img)
+        blk = file_block(img, 'victim', 0)
+        # Make the data block an index node of depth 1 with one entry, which
+        # points at the node itself: eh_magic, eh_entries, eh_max, eh_depth,
+        # eh_generation, then ei_block, ei_leaf_lo, ei_leaf_hi, ei_unused
+        write_at(img, blk * blksz,
+                 struct.pack('<4HI2I2H', 0xf30a, 1, (blksz - 12) // 12, 1, 0,
+                             0, blk, 0, 0))
+        # Make the root an index node of depth 1 pointing at that block:
+        # i_block[1] = eh_max | eh_depth << 16, i_block[4] = ei_leaf_lo
+        debugfs(img, ['sif victim block[1] 0x00010004',
+                      f'sif victim block[4] {blk}', 'sif victim block[5] 0'])
+
+        ubman.run_command(f'host bind 0 {img}')
+        out = ubman.run_command(f'ext4load host 0:0 {ADDR:x} /victim')
+        assert 'invalid extent block' in out
+        assert 'alive' in ubman.run_command('echo alive')
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4')
+@pytest.mark.buildconfigspec('cmd_crc32')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_triple_indirect(ubman):
+    """read_allocated_block(): blocks reached through the second and third
+    entries of the triple indirect block must be read correctly"""
+    # With 1 KiB blocks an indirect block holds 256 block numbers. The file
+    # blocks after the 12 direct, 256 single and 256 * 256 double indirect
+    # ones are reached through the triple indirect block, each entry of which
+    # maps 256 * 256 blocks.
+    per = 256
+    tind = 12 + per + per * per
+    # The first block of entry 1, the last block of its first indirect block
+    # and the first of its second, and the first block of entry 2
+    blocks = [tind + per * per, tind + per * per + per - 1,
+              tind + per * per + per, tind + 2 * per * per]
+    chunks = {blk * 1024: f'{blk:08x}'.encode() * 128 for blk in blocks}
+    with ext4_image(ubman, 'ext_oob_tind',
+                    ['-b', '1024', '-O', '^extent,^64bit']) as img:
+        add_file(img, 'victim', chunks)
+        assert victim_has(img, '(TIND)')
+
+        ubman.run_command(f'host bind 0 {img}')
+        for first, count in ((blocks[0], 1), (blocks[1], 2), (blocks[3], 1)):
+            data = b''.join(chunks[(first + i) * 1024] for i in range(count))
+            out = load_crc(ubman, len(data), first * 1024)
+            assert f'==> {zlib.crc32(data):08x}' in out
+        assert 'alive' in ubman.run_command('echo alive')
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_group_layout(ubman):
+    """ext4fs_init(): a superblock with zero blocks per group must make
+    writes fail rather than divide by zero"""
+    with ext4_image(ubman, 'ext_oob_geo') as img:
+        # s_blocks_per_group is at offset 32 of the superblock at byte 1024
+        write_at(img, 1024 + 32, struct.pack('<I', 0))
+
+        ubman.run_command(f'host bind 0 {img}')
+        ubman.run_command(f'mw.b {ADDR:x} 41 1000')
+        out = ubman.run_command(
+            f'ext4write host 0:0 {ADDR:x} /newfile 0x1000')
+        assert 'Unsupported block group layout' in out
+        assert 'written' not in out
+        assert 'alive' in ubman.run_command('echo alive')
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_delete_block(ubman):
+    """delete_single_indirect_block(): replacing a file whose indirect block
+    lies past the end of the filesystem must fail before it is released"""
+    with ext4_image(ubman, 'ext_oob_del') as img:
+        add_file(img, 'victim', {0: VICTIM})
+        # Make /victim a block-mapped file whose only bad field is block[IND]
+        cmds = ['sif victim flags 0', 'sif victim size 4096',
+                'sif victim block[IND] 0x00ffff00']
+        cmds += [f'sif victim block[{i}] 0' for i in range(12)]
+        debugfs(img, cmds)
+        assert victim_has(img, '(IND):16776960')
+
+        ubman.run_command(f'host bind 0 {img}')
+        ubman.run_command(f'mw.b {ADDR:x} 41 1000')
+        out = ubman.run_command(f'ext4write host 0:0 {ADDR:x} /victim 0x1000')
+        assert 'Invalid block number' in out
+        assert 'written' not in out
+        assert 'alive' in ubman.run_command('echo alive')
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
+@pytest.mark.requiredtool('debugfs')
+@pytest.mark.parametrize('inum', [1000000, 8])
+def test_fs_ext_oob_delete_inode(ubman, inum):
+    """ext4fs_delete_file(): replacing a file whose directory entry names an
+    inode past the last block group, or a reserved inode such as the
+    journal's (8), must fail"""
+    with ext4_image(ubman, f'ext_oob_ino{inum}') as img:
+        add_file(img, 'victim', {0: VICTIM})
+        # Point the /victim entry of the root directory at the inode; debugfs
+        # refuses to link a missing inode, so patch the entry in place
+        blksz = block_size(img)
+        blk = file_block(img, '/', 0)
+        data = bytearray(read_at(img, blk * blksz, blksz))
+        off = 0
+        while off < blksz:
+            rec_len, name_len = struct.unpack_from('<HB', data, off + 4)
+            if data[off + 8:off + 8 + name_len] == b'victim':
+                struct.pack_into('<I', data, off, inum)
+                break
+            off += rec_len
+        else:
+            pytest.fail('no /victim entry in the root directory')
+        write_at(img, blk * blksz, data)
+
+        ubman.run_command(f'host bind 0 {img}')
+        ubman.run_command(f'mw.b {ADDR:x} 41 1000')
+        out = ubman.run_command(f'ext4write host 0:0 {ADDR:x} /victim 0x1000')
+        assert f'Invalid inode number {inum}' in out
+        assert 'written' not in out
+        assert 'alive' in ubman.run_command('echo alive')
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
+@pytest.mark.buildconfigspec('cmd_crc32')
+@pytest.mark.requiredtool('debugfs')
+@pytest.mark.requiredtool('e2fsck')
+def test_fs_ext_oob_last_inode(ubman):
+    """ext4fs_delete_file(), ext4fs_write(): replacing a file whose inode is
+    the last of its block group must use that group's inode bitmap and
+    inode table"""
+    # With 16 inodes per group, fill the free inodes of group 0 but the last
+    # one, inode 16, which /victim then takes
+    with ext4_image(ubman, 'ext_oob_last', ['-N', '16']) as img:
+        out = check_output(['debugfs', '-R', 'ffi', img],
+                           stderr=DEVNULL).decode()
+        for num in range(int(out.split()[-1]), 16):
+            add_file(img, f'file{num}', {0: VICTIM})
+        add_file(img, 'victim', {0: VICTIM})
+        assert victim_has(img, 'Inode: 16 ')
+
+        ubman.run_command(f'host bind 0 {img}')
+        ubman.run_command(f'mw.b {ADDR:x} 41 1000')
+        out = ubman.run_command(f'ext4write host 0:0 {ADDR:x} /victim 0x1000')
+        assert 'written' in out
+        out = load_crc(ubman, 0x1000, 0)
+        assert f'==> {zlib.crc32(b"A" * 0x1000):08x}' in out
+        assert 'alive' in ubman.run_command('echo alive')
+        run(['e2fsck', '-fn', img], capture_output=True, check=True)
