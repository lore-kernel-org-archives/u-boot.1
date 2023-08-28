Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13C7C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B21D86505;
	Mon, 28 Aug 2023 23:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LJPNunsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD864864D7; Mon, 28 Aug 2023 23:56:49 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82F18645F
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a7781225b4so2627162b6e.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259805; x=1693864605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFDKCJF64epJOF7AgGAuGTvFD6k+IwBKiBpPP3txyQ8=;
 b=LJPNunsOmEZqJaftFbI8veFWMXoj3sn5S+k1tAmNa0jq1dY+AF6zDscXgUfl3WM6Fz
 zUmrTOAWxF3PKsBDUPDOzwVYDzcRTFiVCIFL86Bvbz688Q0+bl9aLajgvBhRejuz1Set
 R0nfcr7BhR44Sylo7LX8+72zi00CI9Gjj6f2dCTs+CaNBc8lK2FEM5w1uG8npXLrdce6
 HoHF+ah1v9/4gOo7y8yPqmXl7tuDGsWEJpjlIsLQ238AAN/SYzEYfsndb3qqleA+8bBx
 STdSJmTQfslzQzKw4FYl6T276DEHcIFHii0VLRMUuEM8/BwZiNKXmAvxRu++m2KSwmpK
 YNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259805; x=1693864605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zFDKCJF64epJOF7AgGAuGTvFD6k+IwBKiBpPP3txyQ8=;
 b=QizK+NBBQZuHBtcbpWS4KtKTAuXeHXfIzGnX3LMfTYLsx6l7VOk+JANXf2Mx4BRn82
 NXeSpkieDSNpqNo7sRRZcO8wLimaub/ryh60D2QMI/udMsq6acBVHsEa9Vf7YH2QjXKP
 F5Yafj8MBIp3DDgEl9LjZ9m+DLvJlmduOeyYlpkVxRIxUdMqjy/jAQxva0Wm8fVDkITv
 GD6aoNitahxT+ZdplAc/2M86DWI0Mzuv6n/YDFaxveixq7MWGo9ql3ngkoORoXe9v+Nu
 iYKjXnXsSzcEshwBrNeydM/Qgl5vtdmAvIViYT13BpjX62iUhUpYNXs8uEstUOJCJJNJ
 UScA==
X-Gm-Message-State: AOJu0YyEYo7DVlGNwQ1kI1JbcWUsGDQhcT4LV/WQD7fcji+xdrU7VZdV
 5QHomYmTo5WB33GZTr0u6PfIcQ1a1Nw=
X-Google-Smtp-Source: AGHT+IFuR4gYxminf1+rkFq44blUAaOMDL7ocYySOEXD6CE092Y5u1hvZp4uIw4+YCtvNo9t53t7fQ==
X-Received: by 2002:a05:6808:1153:b0:3a9:e8bd:8510 with SMTP id
 u19-20020a056808115300b003a9e8bd8510mr183475oiu.49.1693259804933; 
 Mon, 28 Aug 2023 14:56:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a0568080b2800b003a7527207b5sm3856298oij.7.2023.08.28.14.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 14:56:44 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v4 4/8] cmd: gpt: Add gpt_partition_bootable variable
Date: Mon, 28 Aug 2023 15:56:11 -0600
Message-Id: <20230828215623.3727536-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230828215623.3727536-1-JPEWhacker@gmail.com>
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
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
2.33.0

