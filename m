Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B25C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB4C864EE;
	Wed, 23 Aug 2023 18:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XgB+4MTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8058864E7; Wed, 23 Aug 2023 18:48:25 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 908EA864CE
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1c4dda61eb0so3590407fac.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692809301; x=1693414101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=th2280Ymj/VK87JGf5/nSN1z1p5M1P+f3nqaDAeWLQo=;
 b=XgB+4MTezj1SRDR3bxDAMygTEs45ndEIM4fQDZJ0yq1ZhMGK4zfSDL6bD+c7hnM+8E
 XB9wIBV3vSGwyV7XTEZS2qS7NoN50q7eJt3xkZL28qc8hQL18B1mGdsXKemlWWNmD5MK
 9OyVVBMORgVe1pUO1CGO7yCx5istFqEw74c5yyIuNwJ8GmsZp5MulYW6DWB31HTNwMdD
 OxFAIaLILA4Hgt4CdqhzPwGVHQKSKahc48o5etDGC+Ws3FuM79OxYQxK0kCXVoyOl/M4
 4Tcpq+vVCQXOwjR5jzCTpFMtdqZrTC49OiNX1YCf+m6lCo+0wntLHFbp7LhP5KV3r8gc
 B9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692809301; x=1693414101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=th2280Ymj/VK87JGf5/nSN1z1p5M1P+f3nqaDAeWLQo=;
 b=lWKsU+CFIEZPRm31GrTk6e4RfOU4eIU3c200bw9xnwpVGVkN7WVIOhqK7hzh6iJObK
 SVsqnqeRNLOIOnE9E+KwyIDkaXG9kZXFC9lG8CfPSt5nMQ4FHxradlC1/+XbTzPxettl
 40zpRhGCsgC+vtogEN+UTaTxyQ63ebFGKymVB61M5tCPGFZqt6Qvj8KVIj8JdSl+3imL
 6Q810bRmbeQYvARyEg4hbtm2DMCvWHaE4Oeo/9wa+Dqo+O/5XrqIQrMu6XxsO3mpwrt4
 a2cRItJAOX1FNQdKcAU8u/Qys8ILjpb0JRFILqc89lqA2z8SQSJ5ZTK771mBOwQiZqLv
 kPEQ==
X-Gm-Message-State: AOJu0YzMG9fR38OZsaY2rqHyvamvGiQ4IhpWphTe5tIxv0BPuh0iAgT4
 sB7MBaySvSk6vaZ6J+/dvRfHWDhtn0k=
X-Google-Smtp-Source: AGHT+IF1B9l2R7lKKPEi9O+dCsseiCR8wH7ntd1/17Sma//YOdVf8Y03N1fLdVI2o3rz4tu/gqF+Ew==
X-Received: by 2002:a05:6870:b291:b0:1c4:d735:38e9 with SMTP id
 c17-20020a056870b29100b001c4d73538e9mr15838113oao.57.1692809301463; 
 Wed, 23 Aug 2023 09:48:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::751c])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a056830205600b006b9cb784553sm5794042otp.36.2023.08.23.09.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:48:20 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v2 4/8] cmd: gpt: Add gpt_partition_bootable variable
Date: Wed, 23 Aug 2023 10:47:40 -0600
Message-Id: <20230823164755.2874792-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230823164755.2874792-1-JPEWhacker@gmail.com>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
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
index ea2cf73a60..c9d15b2cba 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -85,6 +85,7 @@ information about a particular partition. The variables are:
 * gpt_partition_size (the size of the partition, in hexadecimal blocks)
 * gpt_partition_name (the name of the partition)
 * gpt_partition_entry (the partition number in the table, e.g. 1, 2, 3, etc.)
+* gpt_partition_bootable (1 if the partition is marked as bootable, 0 if not)
 
 To get the information about the partition named 'rootfs', issue the following
 command:
@@ -99,6 +100,8 @@ command:
     rootfs
     => echo ${gpt_partition_entry}
     2
+    => echo ${gpt_partition_bootable}
+    0
 
 The 'gpt enumerate' command will set the variable 'gpt_partition_list' with the
 list of partition names on the device. For example:
diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index 339468bc12..1537ceb8c8 100644
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
+    assert output.rstrip() == "1"
+    output = u_boot_console.run_command('echo ${gpt_partition_bootable}')
+    assert output.rstrip() == "1"
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
+    assert output.rstrip() == "2"
+    output = u_boot_console.run_command('echo ${gpt_partition_bootable}')
+    assert output.rstrip() == "0"
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.requiredtool('sgdisk')
-- 
2.33.0

