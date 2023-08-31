Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3400C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04888682C;
	Thu, 31 Aug 2023 18:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oG6juusW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A0BF86801; Thu, 31 Aug 2023 18:52:06 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C24F866DC
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1ccb6a69b13so603289fac.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693500721; x=1694105521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVG1aQlIUvYuqAur5+eCgQ1nbsD5ihOdNpaS9umljfk=;
 b=oG6juusW3uvkch3CtXd/Zl4BfNhWB2rHfN88abPnX9dqLft3nNUKM8PrX+cW1Z3DqD
 qqUukm7EatGqM0N+gJwXOMNKjpZ7nEM90Prv+WO45XEekOJEcUYZmY0VDTErdu1cWVmq
 /L0XBu1mybG3V1cmLKV5Np43n7ef5PF9zx3p9vmXQRCChHJslUxCOKf2sddDTaFqFY49
 WueGaMMHZTL8sVOgPbpKS94Tq7QAmPmPAlL/6nyLTiIyiSEYByAfnkCyq/oQ7TKg8/jE
 kYXCpue/EnSLtHUtWwm5ZEXrCc887MRJ/L/7gP4Zec7J+jF8rU9RXp/TFhxz0Y3lKCJu
 NjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693500721; x=1694105521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zVG1aQlIUvYuqAur5+eCgQ1nbsD5ihOdNpaS9umljfk=;
 b=Z16yfBMDCqqHsBB1Fw2j99vem6cDqAHp6LE+5MNzeMhY4rcpdDPND0w8NXW3gdJz+a
 iSfG/EkhEr7ib9x/RLtZVJqR0fGA5OSPPZVIiKcR7UK+AoMcFb9AuaGW9/BwWiVpE/0P
 9V9OajMB9bnwobS4IjKFX3J67BquSo3IIytVEBTI2sY9ZyzDrjm6GBrvxZ/wvZF90BIU
 JethwvDyKzxNCMY6IPfngrgFIOn7ID/ST4N5fqAVsbAO7I7hdX6NM4Bl/vfme/bHKZX4
 oCImADJG2u5yubUcl3I5UZFXyfXcMj3CdgS5q6jrsVmLyJh0pbWoZ+WpNKw+tnQo8cWl
 nZEA==
X-Gm-Message-State: AOJu0YyyeqhYZwK3Hb/f1npfCRLJLyVfoaneoH196TxmPTUv8SCdnpEH
 Ljh+fv48509bIaBvwhnauPHZUNd+zss=
X-Google-Smtp-Source: AGHT+IHWqt8k9Tdj7uI2ljzgA2YAY6kWR32E9DbhceULL6dqfkc2c6ot8I/6ESpMJVHX/kjuCSy8Ug==
X-Received: by 2002:a05:6870:339d:b0:1c8:c803:c28c with SMTP id
 w29-20020a056870339d00b001c8c803c28cmr6235297oae.34.1693500721412; 
 Thu, 31 Aug 2023 09:52:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::b66b])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a9d6b8f000000b006bb334880d8sm867020otq.81.2023.08.31.09.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:52:00 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v5 4/8] cmd: gpt: Add gpt_partition_bootable variable
Date: Thu, 31 Aug 2023 10:51:37 -0600
Message-Id: <20230831165144.592820-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831165144.592820-1-JPEWhacker@gmail.com>
References: <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230831165144.592820-1-JPEWhacker@gmail.com>
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
 doc/usage/cmd/gpt.rst     |  5 +++++
 test/py/tests/test_gpt.py | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index fe9e06681c..c6c8282ac9 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -725,7 +725,7 @@ static int gpt_enumerate(struct blk_desc *desc)
  * gpt_setenv_part_variables() - setup partition environmental variables
  *
  * Setup the gpt_partition_name, gpt_partition_entry, gpt_partition_addr
- * and gpt_partition_size environment variables.
+ * and gpt_partition_size, gpt_partition_bootable environment variables.
  *
  * @pinfo: pointer to disk partition
  * @i: partition entry
@@ -752,6 +752,10 @@ static int gpt_setenv_part_variables(struct disk_partition *pinfo, int i)
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
index 6387c8116f..b505b159d0 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -108,6 +108,9 @@ gpt_partition_name
 gpt_partition_entry
     the partition number in the table, e.g. 1, 2, 3, etc.
 
+gpt_partition_bootable
+    1 if the partition is marked as bootable, 0 if not
+
 gpt swap
 ~~~~~~~~
 
@@ -167,6 +170,8 @@ Get the information about the partition named 'rootfs'::
     rootfs
     => echo ${gpt_partition_entry}
     2
+    => echo ${gpt_partition_bootable}
+    0
 
 Get the list of partition names on the disk::
 
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
2.34.1

