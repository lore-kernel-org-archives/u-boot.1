Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ABEC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 19:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA89186AF6;
	Fri, 25 Aug 2023 21:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JQS7HPKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4460086B1E; Fri, 25 Aug 2023 21:38:52 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE9386AE7
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 21:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bd0c953fd9so905241a34.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692992327; x=1693597127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98kf0iWvDH9WFfK3fJg3AhDuENFziaXM4CuHJDNp6R8=;
 b=JQS7HPKJB86xQAQAVnwPmi6YkSDyXv1gjN3PZgkRVqaaWVeQZy61BmtTmtj9BZ5DCD
 noWic/bqApNuitwzgB4uAjo6mcg5IyryIhHuwTmikg+kb8ECp11nDmi63ytr9ba5pFSm
 fE+TKQhWiGl5AqIGGNGurVg6s/w4Ir6HxvVtEzsKaVgF/+hwMSAlAgWQMXFNVdj7w1UH
 2bTAOrzokNsQGK1Wi5h1W870VJJ71z80ziguBd9WmwrxizGFw230igAhtJ3/tnnl056k
 IrXKbWfSzHeKe2hV//QHMA12LOvrs0nYtxO9kb9I3CIUzDCU2oJACRgd4NJoVYf68K6w
 pN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692992327; x=1693597127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98kf0iWvDH9WFfK3fJg3AhDuENFziaXM4CuHJDNp6R8=;
 b=KuFtLkcAH2E/nQKVYS5A7M4Ia0F6rLs1j+Qwxosg903iL4/JkWXbToJ8BS+RPNbc7w
 RjN0B3TsJZeJ/zCIINBwAUdVEfw3aRYdgM+n3Ft96bP1zGUyXybEq+fmBYUwrcECrmkj
 Bfr/G5Qphg5FuwKtYYajCHL2NOUtEfoyaOvmwAdzycizZnkJa1H26LoBs5xKGY0QiW/r
 OzvDeGDqDn237C9myas+/u57nwg+9pl8QO+w4D5tulukCSmpXUkFhvc1gdT0fjHOM4O4
 mmCreBuY627mg7hrY2XZHUNAkInR1UVZ/BH2At5V+xBR/nfcRDsNuicJSOMHoDm7L/eC
 M5aQ==
X-Gm-Message-State: AOJu0Yz3BGNmz/2WU6CLh/UuwYIBNJWBIjLnW/lgitV/0ISack1WDEj1
 Xno3Rh0UQg65AFbNBNzubtlG98i5Ma8=
X-Google-Smtp-Source: AGHT+IGPV+lrvGhoQtFVjNXvUKkXaoz6EAt9xPxmmY/U528Tbq2UGWwkOB5S9BNUJurW1vUVADEonA==
X-Received: by 2002:a05:6830:4781:b0:6bc:de62:86b with SMTP id
 df1-20020a056830478100b006bcde62086bmr6342015otb.7.1692992327322; 
 Fri, 25 Aug 2023 12:38:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a9d7e8d000000b006b871010cb1sm1171022otp.46.2023.08.25.12.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 12:38:46 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v3 4/8] cmd: gpt: Add gpt_partition_bootable variable
Date: Fri, 25 Aug 2023 13:38:20 -0600
Message-Id: <20230825193830.2753640-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230825193830.2753640-1-JPEWhacker@gmail.com>
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
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

Adds an additional variable called gpt_partition_bootable that indicates
if the given partition is bootable or not.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c                 |  9 +++++++--
 doc/usage/cmd/gpt.rst     |  3 +++
 test/py/tests/test_gpt.py | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index e6f7b0319a..7a8990e400 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -723,7 +723,7 @@ static int gpt_enumerate(struct blk_desc *desc)
  * gpt_setenv_part_variables() - setup partition environmental variables
  *
  * Setup the gpt_partition_name, gpt_partition_entry, gpt_partition_addr
- * and gpt_partition_size environment variables.
+ * and gpt_partition_size, gpt_partition_bootable environment variables.
  *
  * @pinfo: pointer to disk partition
  * @i: partition entry
@@ -750,6 +750,10 @@ static int gpt_setenv_part_variables(struct disk_partition *pinfo, int i)
 	if (ret)
 		goto fail;
 
+	ret = env_set_ulong("gpt_partition_bootable", !!(pinfo->bootable & PART_BOOTABLE));
+	if (ret)
+		goto fail;
+
 	return 0;
 
 fail:
@@ -1057,7 +1061,8 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt setenv mmc 0 $name\n"
 	"    - setup environment variables for partition $name:\n"
 	"      gpt_partition_addr, gpt_partition_size,\n"
-	"      gpt_partition_name, gpt_partition_entry\n"
+	"      gpt_partition_name, gpt_partition_entry,\n"
+	"      gpt_partition_bootable\n"
 	" gpt enumerate mmc 0\n"
 	"    - store list of partitions to gpt_partition_list environment variable\n"
 	" gpt guid <interface> <dev>\n"
diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index f6e082fb94..88839b8e1b 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -87,6 +87,7 @@ information about a particular partition. The variables are:
 * gpt_partition_size (the size of the partition, in hexadecimal blocks)
 * gpt_partition_name (the name of the partition)
 * gpt_partition_entry (the partition number in the table, e.g. 1, 2, 3, etc.)
+* gpt_partition_bootable (1 if the partition is marked as bootable, 0 if not)
 
 To get the information about the partition named 'rootfs', issue the following
 command:
@@ -101,6 +102,8 @@ command:
     rootfs
     => echo ${gpt_partition_entry}
     2
+    => echo ${gpt_partition_bootable}
+    0
 
 The 'gpt enumerate' command will set the variable 'gpt_partition_list' with the
 list of partition names on the device. For example:
diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index 339468bc12..946858800d 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -49,6 +49,7 @@ class GptTestDiskImage(object):
                 u_boot_utils.run_and_log(u_boot_console, cmd)
                 # part1 offset 1MB size 1MB
                 cmd = ('sgdisk', '--new=1:2048:4095', '--change-name=1:part1',
+                    '-A 1:set:2',
                     persistent)
                 # part2 offset 2MB size 1.5MB
                 u_boot_utils.run_and_log(u_boot_console, cmd)
@@ -117,6 +118,38 @@ def test_gpt_guid(state_disk_image, u_boot_console):
     output = u_boot_console.run_command('gpt guid host 0')
     assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
 
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_gpt')
+@pytest.mark.requiredtool('sgdisk')
+def test_gpt_setenv(state_disk_image, u_boot_console):
+    """Test the gpt setenv command."""
+    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
+    output = u_boot_console.run_command('gpt setenv host 0 part1')
+    assert 'success!' in output
+    output = u_boot_console.run_command('echo ${gpt_partition_addr}')
+    assert output.rstrip() == '800'
+    output = u_boot_console.run_command('echo ${gpt_partition_size}')
+    assert output.rstrip() == '800'
+    output = u_boot_console.run_command('echo ${gpt_partition_name}')
+    assert output.rstrip() == 'part1'
+    output = u_boot_console.run_command('echo ${gpt_partition_entry}')
+    assert output.rstrip() == '1'
+    output = u_boot_console.run_command('echo ${gpt_partition_bootable}')
+    assert output.rstrip() == '1'
+
+    output = u_boot_console.run_command('gpt setenv host 0 part2')
+    assert 'success!' in output
+    output = u_boot_console.run_command('echo ${gpt_partition_addr}')
+    assert output.rstrip() == '1000'
+    output = u_boot_console.run_command('echo ${gpt_partition_size}')
+    assert output.rstrip() == 'c00'
+    output = u_boot_console.run_command('echo ${gpt_partition_name}')
+    assert output.rstrip() == 'part2'
+    output = u_boot_console.run_command('echo ${gpt_partition_entry}')
+    assert output.rstrip() == '2'
+    output = u_boot_console.run_command('echo ${gpt_partition_bootable}')
+    assert output.rstrip() == '0'
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.requiredtool('sgdisk')
-- 
2.33.0

