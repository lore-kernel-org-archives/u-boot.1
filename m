Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7907AC9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C8B741322;
	Wed, 23 Sep 2026 21:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s8906dlU2RqP; Wed, 23 Sep 2026 21:31:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6A2BF4130A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790199067;
	b=BQkMGcq2iQS7/t+z88VsJPRGqa0SGMCrUrjQcff8wgzKxXdH8o+lv/IZM8ZsDlqoZQBS
	 LpF6p+hbTMoIiWwO3kIqu30vtGlRLbvLxA8o4qTZBGBKaXJq2ErYEJh4kzQVq2lI4ne28
	 N3RFz72vjD/v/+fmBbD59KA3vSeXYLy1vbSPc6hSL/F3zpAFITmUWoOgrxiQLtJX3whMj
	 JPs3fwEx47e92lLGbJfPuywBBCaApV0XCIkPXYIOaCCtybKF5PiPqbY2otPRUdF636G1p
	 jiks86FukCBfCPVU/mtNzJW+28Sgez/tdc55YaUMcO+GpK/8Z+bEPGDXAlqJlR/hbig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790199067;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1oXxOxidCQdcTFiNiS0dj5MZ1O2cFwweQgykEGCvQuI=;
	b=K+NJCfQQz3GCyf8BbuDBO26AuOKuXYbsWMVyBs2vFqsMgBaHXhbExsxh4AQxU2zvpuej
	 s6BSX/jlqcXvAQqBKfPQTz1INY+sbFpXlmwr7Bqa5caX5UQcxvTrJHqX2YXJonxf8wQWF
	 /seU7jY4UBNm3PyxD7dif6AQIeghSIMuwKkkH4Sssnf4PXmP8mCR1anD3ISyAdVlC08yi
	 /THqSehe4gTZC7dIdC1854IgUPxy85uCi3YMC3eZTABtblhsRe8qe/e3beNCcNo+umYjk
	 bq56z2nfmDn6s5pteH3znvgosxlw3l2ipt7QtwvKh85uCmaIUIY5mIBknUdGJ+FnsGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790199067;
	bh=1oXxOxidCQdcTFiNiS0dj5MZ1O2cFwweQgykEGCvQuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SjEH8/LwEZZ4BEMUY3aqdDGI+ruXzQErdQRn7+BrSVu39ybH7Zg08qSgaNCC1tLxj
	 xf6R5vxtc1qspH6+yhgoE8tuJuIJ3OSu9iTvL/ZWMgmwDVutd6baRaEKK0LD4ap5F5
	 TXvm2cG7ffUvGFcAqlQLmRb4J82qj+BkiEDnHyDbubUDswD/NJFhKwBgr8fbnDvAUZ
	 IpfhjiLXY54W58UyDM1fAFF1iSQLmuEg23628pxoKLMr7abeCkLXWJlhfycL75vqWK
	 K7EkiXByeGBl5pRLGhKWrPLyLngfpicTRZRwoZvjgw9+IMY8nh86Rtv2qS2/28B+Bj
	 56V20lmJmRX3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A2BF4130A;
	Wed, 23 Sep 2026 21:31:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4F0028C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2CE060B85
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X2DlrlOraT6V for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:31:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E9F4060B83
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199065;
 b=YLuLScLRj7HxQGHL4T401rft25aKpZqRQCQF5PzgVgqgXgKkITSiQU3lr1dGTUYBu2QJ
 i+APMls4unBHHAvVCIt5sgDo3lseqpukknZz7HhDqfDB3i6shwuU8eWfLO15UV/46zGkO
 IQ0Cs56ZWo+sYz0+XeqIxOqNHYmXvQRbbI9VC6NijshrC+D4R5M6Q4EAQq09Kd6Qt0wd5
 yxGf4JhhfK1KKOzdHScrHZtViXxRCsevIagO+Wis+csHm/F+xEg94xcKg3pKLmtcZimeA
 QXJPqAscuAIdSWgovGtRy5kngFOu2jgYsheQ28wqoEPuH4YBmAwHvDiqjrDMj/G9WtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199065;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=1oXxOxidCQdcTFiNiS0dj5MZ1O2cFwweQgykEGCvQuI=;
 b=m5K/SMqZa72FX8CVCqKZlvt1XNetkDD3t7YrMpKDamljGZJ/8iHMElGKJReQhlr4fbFs
 jzvRJRzUaT7VSiUfY6BokmwwDpv0GqqYiXaAZttmDoP6CpDGX44TQyja42MnE4xccbr4i
 kzGJ9B6kWVYOJZvM3UsFqYk9eVE/ZNdAbC+jhhiCAUL/jXtl5+aNYIRHXX2byTPY5cDXy
 B8W4+i2Amv8QvQ3ewawqU1+Sd8/n2w1PCB5QRQ+lVy1p8q3JTdTu3fZ+NgWFAQpakdZHt
 UwRXg2fOTPjDzp2A3TLFk573Uh/9yYVZxZNal6+VeBrkcOW7j0Tif2A5kzOkjTpGRMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=g9iQEt2a; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::c;
 helo=mail-pz2-x0c.google.com; envelope-from=visitorckw@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=g9iQEt2a
Received: from mail-pz2-x0c.google.com (mail-pz2-x0c.google.com
 [IPv6:2607:f8b0:4864:3b::c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9F4060B83
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:31:04 +0000 (UTC)
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc750a1482fso980356a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199064; x=1790803864;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1oXxOxidCQdcTFiNiS0dj5MZ1O2cFwweQgykEGCvQuI=;
 b=g9iQEt2aECWs8uA4/GrN39NcP3KvkAVvTeBy23H4lSM1ef39FVtRxq9V2a6e5WNslW
 EkM+ewO36wua1n/tVTj50FYVfYSwTuMOlYegq/bPjYcj91EMA5mp39k2wEmEMu2BA6Yj
 KdbO1B0gFG+Vy1e6ZbUs8mpAQMFu8EKwqsRZKq7N6OX3AnbyopT9sGo/GCfFzzGjEQWN
 1XWvPK2PwTIY99EMjfQoHHcEp6eR0Q2wMo7km42F046RpX8ayfyC43pWg1ee6cnx5LHX
 58donbju1m14xVykj31SLa9svVnoM1zqeY8Fu7qK6ltqnhe9glNDZChEdoVMuZK2rPiq
 SLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199064; x=1790803864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1oXxOxidCQdcTFiNiS0dj5MZ1O2cFwweQgykEGCvQuI=;
 b=Evlb5aZit/tI6jGCKMjXCzZsgn6NXRRvDpIatTOF0W7JvfkyJMRbkRX10xuQ8HOPt5
 Luwq+vTxRpfbG/rxtLPOKLWIxlgNl2Cc5fuXlioMtrJu9OlN3pzO+OeJdSqSQy82oM2A
 H78PK7g82UEaJHTNhxOOdilkCtWLSm2zFJw8psNuQrr7xlBFx63Xl4IqtiefEZwqd6R7
 ZbCIm88Qk3MdunfiQmwK3jvGDfjo0XJJHVmm/hak5dADckKFdbFcyuhBeO9X9e1EzmGK
 cczC6DR5IUSKVo+8JMXroWTqXn61ERl+MjlZR4hIXi9jocY7lZhVhIa9zZKFmuFgkDJi
 Iw6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPyBAwFY1FYZPo3AarmXbAN8ETOO1sT1cShFcGr01hPTC5SV7Nuv9jajLEiDeyfSKTLhwfp2U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mSg2vA5fmzZsOD2mzHbc+tQ3GdmvJAtfo9J/r5fwC8kBPaYzB/
 GaD3qBWV69jUmEhL9nX/HFVkD7n4G3eHqOTLTOmbTlZTrNkvavUQGvcK
X-Gm-Gg: AYBFou1XNTfcmLsnzgWL6X3s8R2AKa28Umu+2o1njbWQUgh5QM/6J7oHL3L5hwHQ6J6
 Kuld7nem5Bxb9vqJFthNqVHIEKDzZBaRMzmutia3Zg1izILvA7dJ/wJGCU2szdK57TWy+Q825/o
 668BeCEKHWipUhlY8PdVDHk6Pj3bZhMHJkb4LrZ3j5zKdXorDDTUko0XKT+blvNXuSDia9VJ1me
 xDigIiWr5bncAo/yF8oMO6WVrICVgdT/bOORt6SkzPraWx7f3BbJhD1kyldc+bLWu5bIxexVbyw
 IKbvo2+VR+WaOZoKJFz9upflGWskCb+dJfZZo1ZAASuR1Y+Nq8eg0ro9sOYZXgI3iW8sD1LY4KU
 Pc1FBwOoOqsXg+AvnP0d+Ipyz14yIY7v0NwKAUeiPul2A+FxlQ69NvAGScC+TzO9s4oJRXiQSZr
 7LgfP5HuPuIhhzEUi4Hp3jHXEfAivm2VRQfe9foSU/QKWy+ygUKoGTSy5DH6YD6PIoJbZ465J9a
 oQOaeh0bNRY8eYbClqBE0ebU7Is22eSnlp3YcNDJlDIdpe6FPNMyRoJnqBJO61np7O8aJNcNOF7
X-Received: by 2002:a17:90b:57c4:b0:39d:f2a1:3a with SMTP id
 98e67ed59e1d1-3a0985b696emr333218a91.15.1790199064047; 
 Wed, 23 Sep 2026 14:31:04 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0973c4fb4sm909513a91.17.2026.09.23.14.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:31:03 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 5/6] test: 9p: Add test for 9P filesystem
Date: Wed, 23 Sep 2026 21:30:01 +0000
Message-ID: <20260923213002.1070404-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923213002.1070404-1-visitorckw@gmail.com>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add automated pytest for the 9P filesystem testing directory listing
(ls) and file loading (load) over virtio-9p in QEMU ARM64. Also enable
the relevant configurations in qemu_arm64_defconfig.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Assert expected error strings in negative test cases.
- Add doc/develop/pytest/test_9p.rst.
---
 configs/qemu_arm64_defconfig   |  3 ++
 doc/develop/pytest/test_9p.rst | 10 +++++
 test/py/tests/test_9p.py       | 82 ++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 doc/develop/pytest/test_9p.rst
 create mode 100644 test/py/tests/test_9p.py

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index ae6dd770f3e..75b50eeb5ea 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -40,6 +40,7 @@ CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_SPAWN=y
 CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_NET_9P=y
 CONFIG_AHCI=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
@@ -73,6 +74,8 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
+CONFIG_VIRTIO_9P=y
+CONFIG_FS_9P=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_TPM_PCR_ALLOCATE=y
diff --git a/doc/develop/pytest/test_9p.rst b/doc/develop/pytest/test_9p.rst
new file mode 100644
index 00000000000..9c4d18e66fd
--- /dev/null
+++ b/doc/develop/pytest/test_9p.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+test_9p
+=======
+
+.. automodule:: test_9p
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_9p.py b/test/py/tests/test_9p.py
new file mode 100644
index 00000000000..a2c32d6e694
--- /dev/null
+++ b/test/py/tests/test_9p.py
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+import os
+import pytest
+import utils
+import zlib
+
+@pytest.mark.buildconfigspec("fs_9p")
+@pytest.mark.buildconfigspec("cmd_virtio")
+def test_fs_9p(ubman):
+    """Test the 9P filesystem commands."""
+
+    test_file_name = "9p_test_small.txt"
+    test_file_content = b"9PFS_AUTOMATED_TEST_CONTENT_1234567890\n" * 10
+    test_file_size = len(test_file_content)
+    test_file_crc = zlib.crc32(test_file_content) & 0xffffffff
+    test_file_path = os.path.join(ubman.config.build_dir, test_file_name)
+
+    with open(test_file_path, "wb") as f:
+        f.write(test_file_content)
+
+    large_file_name = "9p_test_large.bin"
+    large_file_content = b"".join(bytes([i % 256]) for i in range(128 * 1024))
+    large_file_size = len(large_file_content)
+    large_file_crc = zlib.crc32(large_file_content) & 0xffffffff
+    large_file_path = os.path.join(ubman.config.build_dir, large_file_name)
+
+    with open(large_file_path, "wb") as f:
+        f.write(large_file_content)
+
+    sub_dir_name = "9p_subdir"
+    sub_dir_path = os.path.join(ubman.config.build_dir, sub_dir_name)
+    os.makedirs(sub_dir_path, exist_ok=True)
+    nested_file_name = "nested.txt"
+    nested_file_content = b"NESTED_FILE_DATA_OK\n"
+    nested_file_path = os.path.join(sub_dir_path, nested_file_name)
+
+    with open(nested_file_path, "wb") as f:
+        f.write(nested_file_content)
+
+    ubman.run_command("virtio scan")
+    addr = utils.find_ram_base(ubman)
+
+    output = ubman.run_command("ls 9p - /")
+    assert test_file_name in output
+    assert sub_dir_name in output
+
+    output = ubman.run_command("ls 9p rootfs /")
+    assert test_file_name in output
+    assert large_file_name in output
+
+    output = ubman.run_command("ls 9p 0 /")
+    assert test_file_name in output
+
+    output = ubman.run_command(f"ls 9p rootfs /{sub_dir_name}")
+    assert nested_file_name in output
+
+    output = ubman.run_command(f"size 9p rootfs /{test_file_name}")
+    output = ubman.run_command("printenv filesize")
+    assert f"filesize={test_file_size:x}" in output
+
+    output = ubman.run_command(f"load 9p rootfs {addr:x} /{test_file_name}")
+    assert f"{test_file_size} bytes read" in output
+
+    output = ubman.run_command(f"crc32 {addr:x} $filesize")
+    assert f"{test_file_crc:08x}" in output
+
+    output = ubman.run_command(f"load 9p rootfs {addr:x} /{large_file_name}")
+    assert f"{large_file_size} bytes read" in output
+
+    output = ubman.run_command(f"crc32 {addr:x} $filesize")
+    assert f"{large_file_crc:08x}" in output
+
+    output = ubman.run_command(f"load 9p rootfs {addr:x} /{sub_dir_name}/{nested_file_name}")
+    assert f"{len(nested_file_content)} bytes read" in output
+
+    output = ubman.run_command(f"load 9p rootfs {addr:x} /non_existent_file_9p.txt")
+    assert "Failed to load" in output
+
+    output = ubman.run_command("ls 9p invalid_tag /")
+    assert "No matching 9P transport device found" in output
-- 
2.56.0.rc1.310.g51773c2048-goog

