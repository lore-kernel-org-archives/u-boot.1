Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42528C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C9DB60B9C;
	Fri, 31 Jul 2026 12:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2wn2gYHHXShF; Fri, 31 Jul 2026 12:40:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0901460B9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785501659;
	bh=bKqP3BY7ulwuTrubsvWSwjNDMuyrpaoxEio4kwR5EVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3qPVzR3BvcEenYrHk+r0nlVahc5Ynt8zpnGTx0Cc3nXzr4YxJ0FwxKO8+idLccUv
	 P5T/EUO8Wd3x3ex1FP6McyEUZ43fAC7Sdu6XwXY4bvNUJx6meyxUci1POzLc8YlRt/
	 hhmcprqw0ECe50vliGsQLukAWESnuUYAj1BDctmhq4eZ7+21l9p2QkOTLSjPuaeXfm
	 rykQRKR2OvZz2E6C/Xxv+mqE9PzdxCqXwnFedgSB347if2Hkfo71JSL3XdNTYINcMQ
	 CYlDivAVjaOLmc/TFmLmMcCEE8gN58Vgmr4RVnwbdi/R1UR3FQYm1O7Mxa20Y9pooj
	 qdIg3hXmsAnwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0901460B9F;
	Fri, 31 Jul 2026 12:40:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A36236E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20AF14112A
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_obWsjOL9_w for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:40:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D116D41128
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D116D41128
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D116D41128
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:56 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so473798f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 05:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501655; x=1786106455;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bKqP3BY7ulwuTrubsvWSwjNDMuyrpaoxEio4kwR5EVs=;
 b=tQl/SekJ0oQDvueG3wE3mRM+hCuwDv83dg58nI8UxIqDq5n1J6Z3Plar2PvxKpbUPU
 V/Svj6SaDrWfNbJ4cgg6TCR5tPcO3lVhmz5OQ976HjObBDpSnXuzMYrF/Y5xhz5rl8s1
 efhV4iVX5dThCwnOsCdniO9s2d50GDANaCK3ZO0foC/HHHxlm9BtasuqZlF2xA8l8lEG
 14V+nTnG1JUaKK9QS90hdyAWs0PWxbq9vSnjkEgleHEBzpf5Has+DvYWUGhAs3XkTM+w
 jw3OB91NBuaKqLFOyS0Y7M+aNcsACJqxP5pS+RutZktEafcehPAmjfXayjNN+GF/n21I
 AVfA==
X-Gm-Message-State: AOJu0YwAFEZyFvw07VDXKtcN/IXFQ8AUTzFB+g5YWBo0yHf0jC+2ctMz
 3Vh8WfpQ54QRTApwOhNZC00jZYJTp3vxzza/RExNJ99CWs7iZ8j3aPA5lsmxiqRnETQ=
X-Gm-Gg: AR+sD12AawplUb9eQP7ZIgoiYFtwVJE1Kc8WTSQt5lkVUa6aZpbcPf4jtPQBCLj3l9y
 MKaa0C7nCK1u+cRKXFlMw6fWbhfn2ZaTJ3KSeDrGtgaC0/Fpm1xn4AfDQ9ep5FNO8v3YA2x/49r
 Ryfnrk/2gf1oShxTTI8aR1xqK6Mh90hs+2sw8Wr03oTBLenluAB3eZKVVuZbPwuunb58wKXHwu6
 mpkxrYnop8HmvS8YyEh2coPLxEyDzJl4f6uPeXEy6aApeadFtb1gc79K5zQdkQUzZAdH7I/aJQZ
 5R0nIBJJ7JcgrF+mxI391uugBb3EspYXHxqeZ1oS3ifRAqJdGSxgIccGza6/pkSR4wCwLoVh+33
 73EL6EwLIpCeVuxYX2OraG1IonNbRfxgtmp71MKfLOUf62yJ/HBBHx3MntxWvMOB3WN0G4em7x8
 YcUAp/OM5SAuyPXtUidpqcbkGAcdLlwRRc3GzQcAQhfHjaMLeWCaq2WaOaABd5Iie6kl3ijJzEn
 eN8AZ0isg6xA5EGBoZz4AFdFkfrYo9rGfha/ULJuQ==
X-Received: by 2002:a05:6000:2311:b0:47f:9441:51b5 with SMTP id
 ffacd0b85a97d-47fd2abab70mr4241704f8f.5.1785501654669; 
 Fri, 31 Jul 2026 05:40:54 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm4493682f8f.12.2026.07.31.05.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:40:54 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 16:40:05 +0400
Subject: [PATCH 6/6] test: py: gpt: Test the GPT layout on a device with
 4096-byte blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-gpt-4k-v1-6-a3f1f16b53ae@flipper.net>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6471; i=alchark@flipper.net;
 h=from:subject:message-id; bh=H9HI8pDo5Y3qGerN5eIfQke7z2j25N/Zv5gJUQ+Aftc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlTN+dc8uuR2Dt4rSjotMsbv+2W8uh87WhxoBd2vrW1
 eLDuzU3d0xkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVLscY/gotyBfzvHK28EqOmJXgYkFvhYXdN7pe/mcxms2+JCdmUijDXwl1vye
 3jppc1+vQKTnxslGZ3UE85sUKu8vXt0ibiC5VZQQA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785501655; x=1786106455;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bKqP3BY7ulwuTrubsvWSwjNDMuyrpaoxEio4kwR5EVs=;
 b=0VUlizXWc+wdbNuU3xqx9OW5f3iPEAIVVj792ChwFjtULJCcTDDRWS4yLVBn34IiRa
 LTvBnT+uiStnySGQtePCTJo2yXyFnwvfVsGvIwyAI7o+alr3bl/oINURCszcDn0pOvJc
 KWtlP1pOZrJwhvUZwoVL12Dej8KQe51tWQIJy8pCYzaKeDx0bOnT5s4VJ+p5wFo+8gE6
 CUdn60D0AMwUlu2VDovV8pKENa2V0GGhTuyLOrQtiyZatbGghrT0CBUfpce+99FMtOOO
 JAmweVpUlYrb2YtdXMNDanSB4R18aa8thUSaKiVAvl0WNnfIpM7ZCB2L8EJN1mbBQH1G
 YHpA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=0VUlizXW
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Bind a blank image with a 4096-byte logical block size, let U-Boot write a
GPT to it, and then check the result both through 'part list' and by
unpacking the primary and backup headers straight out of the image. The
interesting assertion is that the backup partition entry array ends
immediately before the backup header in the last block, which is what
regresses when the array size is computed with a hardcoded block count.

No sgdisk is needed since U-Boot creates the table itself, so unlike the
other tests here this one has no requiredtool marker. The number of entries
comes from the build config rather than being hardcoded to 128, so the
expected LBAs are recomputed for builds that set
CONFIG_EFI_PARTITION_ENTRIES_NUMBERS differently.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/py/tests/test_gpt.py | 115 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index fb4c8ba67d48..823fa40a9295 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -6,6 +6,7 @@
 
 import os
 import pytest
+import struct
 import utils
 
 """
@@ -45,6 +46,28 @@ def parse_gpt_parts(disk_str):
 
     return parts
 
+# Layout of gpt_header from include/part_efi.h. It is __packed and
+# little-endian, and struct.calcsize() of this is 92, its header_size.
+GPT_HEADER_FMT = '<8sIIIIQQQQ16sQIII'
+GPT_HEADER_FIELDS = (
+    'signature', 'revision', 'header_size', 'header_crc32', 'reserved1',
+    'my_lba', 'alternate_lba', 'first_usable_lba', 'last_usable_lba',
+    'disk_guid', 'partition_entry_lba', 'num_partition_entries',
+    'sizeof_partition_entry', 'partition_entry_array_crc32')
+
+def parse_gpt_header(blob):
+    """Unpack a raw GPT header.
+
+    Args:
+        blob: Bytes starting at the first byte of the header
+
+    Returns:
+        A dict mapping each gpt_header field name to its value
+    """
+    size = struct.calcsize(GPT_HEADER_FMT)
+    return dict(zip(GPT_HEADER_FIELDS,
+                    struct.unpack(GPT_HEADER_FMT, blob[:size])))
+
 class GptTestDiskImage(object):
     """Disk Image used by the GPT tests."""
 
@@ -93,6 +116,36 @@ class GptTestDiskImage(object):
         cmd = ('cp', persistent, self.path)
         utils.run_and_log(ubman, cmd)
 
+class BlankDiskImage(object):
+    """Zero-filled disk image with no partition table on it."""
+
+    def __init__(self, ubman, size=4 * 1024 * 1024):
+        """Initialize a new BlankDiskImage object.
+
+        Args:
+            ubman: A U-Boot console.
+            size: Image size in bytes. Must be a multiple of the block size
+                the image is later bound with.
+
+        Returns:
+            Nothing.
+        """
+
+        self.size = size
+        self.path = os.path.join(ubman.config.result_dir,
+                                 'test_gpt_blank_disk_image.bin')
+        ubman.log.action('Generating ' + self.path)
+        with open(self.path, 'wb') as fd:
+            fd.truncate(size)
+
+@pytest.fixture(scope='function')
+def blank_disk_image(ubman):
+    """pytest fixture to provide an empty BlankDiskImage object to tests.
+    This is function-scoped because it uses ubman, which is also
+    function-scoped."""
+
+    return BlankDiskImage(ubman)
+
 @pytest.fixture(scope='function')
 def state_disk_image(ubman):
     """pytest fixture to provide a GptTestDiskImage object to tests.
@@ -330,6 +383,68 @@ def test_gpt_write(state_disk_image, ubman):
     output = ubman.run_command('gpt guid host 0')
     assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
 
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_gpt')
+@pytest.mark.buildconfigspec('cmd_part')
+def test_gpt_write_4k_sectors(blank_disk_image, ubman):
+    """Test the GPT layout written to a device with 4096-byte sectors.
+
+    The partition entry array takes up fewer blocks on a device with large
+    sectors, and the backup array has to end immediately before the backup
+    header in the last block whatever the block size is.
+    """
+
+    blksz = 4096
+    entry_sz = 128
+    nblocks = blank_disk_image.size // blksz
+    entries = int(ubman.config.buildconfig.get(
+        'config_efi_partition_entries_numbers', 128))
+    pte_blocks = -(-entries * entry_sz // blksz)
+
+    first_usable = 2 + pte_blocks
+    last_usable = nblocks - pte_blocks - 2
+
+    ubman.run_command(f'host bind 0 {blank_disk_image.path} {blksz}')
+
+    output = ubman.run_command('gpt write host 0 "name=all,size=0"')
+    assert 'Writing GPT: success!' in output
+    output = ubman.run_command('gpt verify host 0')
+    assert 'Verify GPT: success!' in output
+
+    output = ubman.run_command('part list host 0')
+    assert f'0x{first_usable:08x}\t0x{last_usable:08x}\t"all"' in output
+
+    with open(blank_disk_image.path, 'rb') as fd:
+        data = fd.read()
+
+    # The primary header sits in block 1 and describes the whole layout
+    prim = parse_gpt_header(data[blksz:])
+    assert prim['signature'] == b'EFI PART'
+    assert prim['my_lba'] == 1
+    assert prim['alternate_lba'] == nblocks - 1
+    assert prim['partition_entry_lba'] == 2
+    assert prim['first_usable_lba'] == first_usable
+    assert prim['last_usable_lba'] == last_usable
+    assert prim['num_partition_entries'] == entries
+    assert prim['sizeof_partition_entry'] == entry_sz
+
+    # The backup header sits in the very last block...
+    bkp = parse_gpt_header(data[(nblocks - 1) * blksz:])
+    assert bkp['signature'] == b'EFI PART'
+    assert bkp['my_lba'] == nblocks - 1
+    assert bkp['alternate_lba'] == 1
+    assert bkp['first_usable_lba'] == first_usable
+    assert bkp['last_usable_lba'] == last_usable
+
+    # ...and its entry array must end immediately before it
+    assert bkp['partition_entry_lba'] == last_usable + 1
+    assert bkp['partition_entry_lba'] + pte_blocks == nblocks - 1
+
+    # The backup array holds the same entries as the primary one
+    pte_len = entries * entry_sz
+    bkp_off = bkp['partition_entry_lba'] * blksz
+    assert data[bkp_off:bkp_off + pte_len] == data[2 * blksz:2 * blksz + pte_len]
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.buildconfigspec('cmd_part')

-- 
2.54.0

