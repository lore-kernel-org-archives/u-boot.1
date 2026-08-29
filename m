Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2041EC61DCB
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 19:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D67086062D;
	Sat, 29 Aug 2026 19:21:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pCXDgoDUq7Z9; Sat, 29 Aug 2026 19:21:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788031316;
	bh=qBMW/HJWdL06vL5OSvwdPWOr1AxYoUVmmKU8biaoED0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jm+xC2F6ouxbj7vxwvq2hyWRQkW9Qol+/bOveTh+GApz5abPrEfYZoCVZS0Z0TSAW
	 FLXI2YHM/VWTQ8ePwwEslHuiJlNfl9tnjc33pJd8eRog3M6cPXvRNUZURt4PQFz47Z
	 F6Bbl6OVyhnFtowlMQjK8u/QSmqNbDMkfYCAgx/A6u20NwrguoQqajuL8m8CwK+UZe
	 ZBhFPi68ky/TfJvwu3ZG6eU+xRtL4ERuM7n5tjzzldWJrabCNncPQ52LK5hoErvlRl
	 llcpmAPUgOhBoS528VDcuyvvdfYHpstMHjDmokcjjSDZ8e4LgcY8+IhjZjd4x7KmjC
	 vCVkzJD4+5e2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A28F16061F;
	Sat, 29 Aug 2026 19:21:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29421118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BB9680E59
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WzmELrpZ56kH for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 19:21:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YRmoWJ7a
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5324280E53
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:53 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-398a4dcf289so1007222a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788031313; x=1788636113;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qBMW/HJWdL06vL5OSvwdPWOr1AxYoUVmmKU8biaoED0=;
 b=YRmoWJ7akvSJR6Wjurf3WjyKj3PiHCXPGodwxVbuugtefchd4IpcjRaaCPLLNiGYs5
 jmF9CGouWCaWA4TAcBIA7kw1N0vrAar6sCPuSehkP+mgVKgk568V6KErKYxD8aKChfQ8
 fDuhJD95VCPD49qxp1A1Yv4gBGFofOpA21y/kbBBuYGDLzJenngkDvW4C+6YQCDcAaFg
 41+Onuq4a61oxPBkomiBH2IEukhur676DOGYKDzXbycywABiWtUr0eDvbffPopWBzQ82
 7syO8HhyDEmUG7O2BNbB5xGcpPA0Fgmh4knX/37Lf9CQduIYQWVV5eUKxRymtKAefALH
 m2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031313; x=1788636113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qBMW/HJWdL06vL5OSvwdPWOr1AxYoUVmmKU8biaoED0=;
 b=VFlQYjmWw4p9KzZVjFc54p368gRO9QMKQvgi3oaSAAeR4i4zuQq5L3k01XK3Bqu+bn
 pWm0w/N3N6rsejc4NHpvZitMFJ0yphhxLfFqS4K3a4geOWBs16qs8QtPuNr9hKMdBLRV
 fXjdX9r+O7yv6Me0XJ8gLgUjuKuOjqSGKS4wP5NJC4/4uZXlDkPOYLvqXrDCUrqRqJMv
 Ijn24FakoEDEvERsE9Do6YNU2whnp46RyETZOQp8wU6a+XbryLJBZLVdbBI27Q8UQuMU
 O1VOImvmFG+UlBEyVlNYkAwPrfiZ9OBR7YUicfPHziZx3fA51/By+txehk8WdND+XQxW
 hWRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/TJdweEZ0Zp1CAYwqWgp7KAwI/QpBMDxehVOhiSoheKVSAoZTjH72pJjv81O6bZaNR73++oo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k86two1ZJFW5NVFQe0s6jIVfPzo2EUrkN65ZIKJqpuvA3uNNDi
 rWloRRVrEw6a5DpeVTRRmfljAq4ehXDChsNjhbH9pJjVQkYom+1a++SQ
X-Gm-Gg: AYBFou1et57f91bSUKXpNFV71uS1bI3BKuWsvDuo8VtgUgPRDLC2g2anB9PA7C0/cbD
 cV0B/kQVGyeBnBFaImJvP8+3cscmX+ZAlGE130lI6DcKIhSakMTNiqs6cpf7Awqj9ztQxIgmnfh
 A9yYfEbRGIhlZpMvpk1nNh5YZzpWRXzP2la86sV1kPlYUfRwagqBFDDBH88NwEHdQsEfckqY6SV
 WuPgMrTMvg89J+eGb1ACSVQBW/VbDCa6Ab8vrJTIItTbao4b66WqIsfq01RWtA8AmL0NCbpJfWz
 2QDUr62vBgVuGSJZzu+COIp6YZb1swpSGitsFphHsPidu2YgDDKYTxXMCfeKExwGHpz4TlOFWa2
 PZijInt10F1dAEnP1g5YXQoOhaNCf5MNv1/exGp7quqh/fvcT+OG/SVPSYhZCVVU3ABw3QTBirr
 TMfir/cY4MhhmKbI1KvJ5MlTpXkU3tMDKbYLqXZdDZC4X0z9km04J58HVWPhLPbX3lNQI5zZmoi
 wNrLiFGMHZEWJyrnGWGYW83ZjZYNHq5xbGIFwKz+bmEkUt5V2+tlXq7YXp3KDKbNw==
X-Received: by 2002:a17:90b:518f:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-396d0ff2eccmr27462978a91.16.1788031313238; 
 Sat, 29 Aug 2026 12:21:53 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (184.247.229.35.bc.googleusercontent.com. [35.229.247.184])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm12837034a91.4.2026.08.29.12.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 12:21:52 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 5/6] test: 9p: Add test for 9P filesystem
Date: Sat, 29 Aug 2026 19:21:18 +0000
Message-ID: <20260829192119.2658328-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260829192119.2658328-1-visitorckw@gmail.com>
References: <20260829192119.2658328-1-visitorckw@gmail.com>
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
 configs/qemu_arm64_defconfig |  3 ++
 test/py/tests/test_9p.py     | 82 ++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
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
diff --git a/test/py/tests/test_9p.py b/test/py/tests/test_9p.py
new file mode 100644
index 00000000000..7b3b17c8366
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
+    assert "bytes read" not in output
+
+    output = ubman.run_command("ls 9p invalid_tag /")
+    assert test_file_name not in output
-- 
2.55.0.897.gb25b4bd76c-goog

