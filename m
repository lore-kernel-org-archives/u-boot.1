Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35858606A331
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nrGuogrd;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dO2+QyI3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 053496086B;
	Sun, 25 Oct 2026 13:04:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G2Eay5sJS5OE; Sun, 25 Oct 2026 13:04:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 29B1E605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792933484;
	b=PtMo1rMY5/rEj2pfH8XL02BkozKw6pNe7BSAZRnBWUDiCcJO9ykoNHCd43pWCD8y9ssu
	 r24FIJZA0q7MpsWSUJ1uasxxlwleDGYzu26swNgQ61ZqxplFsm8wnk5lQwOvXtMjTCafr
	 bKsfrACw5tAe+Eqw8JWbaE/udzuYy4XsZLGUV1DuLrFI1/rX0Vmu2Jbrfr41d439xMnsx
	 qtvc5lAfhh/ZdKFVDtj1vOisyV1NtmCJt0kCE2B7XuA0bw8V4hOcB7I//kaGNso4h21T6
	 seBV3yBXfJ4UgZXAAqLV04CnMmh4twOb3BFurBo7upYmB5R4y1+WXcGIQNNMnXRWMKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792933484;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aoz27QjDwhFQMAb1F9s4XrXfnxvZbd2rB+d4u8ZxARs=;
	b=Sog64KsG3JI5OePiCU8nPT/jkAv8O8AWrQ3KlLMU6XurkgQrLq+fkFyOagtaWbjL3CIA
	 qR3JhddXpW3j4Z4mG1P90AqZdvikgoxJSSOt9OhONhgfoRoHtXHWTQT8sM+gctGEC4gIx
	 EaAR7bA7kGHV7MEHAfe678AFXKPQkpi/5wE7O+kxDfYh/CcMTX98jh7fJ1ZLLA+mrIa3m
	 gkDgBTkbuWeZSRQ9q2fl3Kxg61TzfRQU6KE+XGtq1OKKS9/Jh8Nw8n7EQ1P2g36MSyzYQ
	 mVRVBS/HCdRxKmOv0DF8uwV4Yt9GqQ4sGurBQ61SV5BL810lLyNOI9CzTSW8Om/kEtg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dO2+QyI3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792933484;
	bh=aoz27QjDwhFQMAb1F9s4XrXfnxvZbd2rB+d4u8ZxARs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nrGuogrdV1NF5SUPhK4RRSHq8dXrkO8bZzv8TICdNRpAaT9VNxvBqeMx05IKxtqxG
	 lkMiMT2Uunx9i5h/289z4afLvlZIrkRhNDgqWnWo0BtOgAPjlFnYPRPldqggNTMlMd
	 ywe4xO/Z5hCzmGCkFyKKeTI6Oz/LRosJymvw0t85cpVV3hpkPCtNpBbG7Pzgl9St0s
	 AufZkqf2ZCvZslvlrvgFDINd3nsIVj3BlcvgyQ4DG/gO4OHrAKtAKCucZ8ZvIeKiWJ
	 x70tTshegqjC84qQ1e3sC0iUtHVFXGiVgzcqbmp41kbVnuEOu1d9Z1XCbo7W6CztC8
	 8ksKJDWDSgdtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29B1E605FC;
	Sun, 25 Oct 2026 13:04:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5F302C7
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D798460782
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWVN0coF8xWk for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 13:04:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A27C4605FC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792933482;
 b=gkaETZFH/KS9QiQDcJ9FIzCXiHzYfnH9i0jRLI1uBVrLqXBPfMZHw/KqNgFMhzWi3CGB
 +SvL8tO8z8ZVz1MsAlxdnwGykhsi5BRQpMfzhdRDrtJTV787mb8C9sjepNniOeVlCd42p
 5warDSWqhmXTTLZpbd4hyWjbBTxHUzMlf13KnYHo7EN8rZMcUxKp7CzNReWRq1kUHmDZS
 ks2AkQlPV9OsyZ08KHDIFXYUQ+C5cHk2+yzDDLCWyN7gj6iZCpMj21oza+fTrfEhq1L6S
 qFph36HA19VHwuLP/Ih0w5Zp5/E+z0NrY6ykqv1ps27bqpPmZ3XxFIgj88kq0fZuF2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792933482;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=aoz27QjDwhFQMAb1F9s4XrXfnxvZbd2rB+d4u8ZxARs=;
 b=iQrRLj329a+C2D2UjFH20jWn2DdivgBKVV4zl4cBh4PIe2PUF3Wmt5cEnHiO38Awj0HV
 ap+JpcIPA0ErwYYdIwFMVilLheRjt9OjdNNoz7xUzU9W98e/Z21ZY1d1QrENICwFgRegq
 9Vkr4Zyp94+ku2J1+fxYOZ1ge33fHRXAJwKLBrAuEuM0qQm/7+oosNKntA3CuNSW2OGYq
 1Egyt7B6SELdVGYN/7ERW+MaU290PJkzamRn7h3qSSF1nDwmsUbpmH+L7dPwg+HdorwT6
 cU0CR2YuiUJg2ewXQryIyCCQee7AjaFrvix0ArYKoaC9e2HznHTDmrXRsOeGGjXC2sg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dO2+QyI3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dO2+QyI3
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A27C4605FC
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:41 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso8530365e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792933479; x=1793538279;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aoz27QjDwhFQMAb1F9s4XrXfnxvZbd2rB+d4u8ZxARs=;
 b=dO2+QyI35njPkcKaukxOm8y9veQdhRmBInwhtdVQLYmWmQqoUOuuHq+efAExWiSIvH
 d3QX/OvMw3jhYK1gS9xEBBCDyRDSHRC2kXfLRFPJviCHc5AJJKnhQUnltDaBj9bO7uxJ
 AV/wxmfVi55r5CCvqsop6T9DqsEKk2d9S5Mt02uDU4kH/aPiD3iooSmECjZ7jFJ3xRyb
 cJ5rsA2qey2F2y/1sMQCzzOL9mWOuiv0rGSkvqM/NbvKShp3j96EnMAb9xiuEzXyaomc
 Ag/gpJ+jsoYGlneg2WY1Xm9zzHZNBbaG0g3UIuDHYrapa5e6jexTbX/EHJzOMgTvddCy
 uwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792933479; x=1793538279;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aoz27QjDwhFQMAb1F9s4XrXfnxvZbd2rB+d4u8ZxARs=;
 b=0SkuNlXOkY73IBbLYLTEFAvUMTQXcXiowHnwxEjXIIe1nG6r4RrJOwnlbphgkQSBOB
 EgoIw4mz3xtezZnsU/cRoJXT9QSg24nWssAwyyodxLYyjmrRtOo9N6st+3H8mS8SZ7Da
 6RhY/TnTn+UHdaVQrIt01lvI4oVvcGAg0/2qEdqPbeD3WKCoexC9CMLk6vIiXj8+gC5i
 sk/L15VvgJB7m0mn6EIr/1fpIUB4XxUAporrukcPWsV3Dh7apGKRUk2srDISqNKh3v8s
 qVSlmbpvdhwjYRVkPOAwjAXD3jdGYpe3UAWnlBrKiENh0TW/W9YiS0sZDZdNT9WtA3Hc
 1G0Q==
X-Gm-Message-State: AFq9FYK7jX5FwBBEcSxlsxHq44NNgWbVyqYECY9Cj9govSOVp8ocP0o/
 Hq+qN54hQCCrxbhut28dcVUwFiBdySFXkT2gqmaopws8wCsg+f6364/R
X-Gm-Gg: AYBFou30z3oCHa2gAad6lk98LC2nudfDG6pkT1tiiN2RGpqbxmaDp/CaUOomWAVUykA
 rI3CagI+G/bQJysbp1mDxcnTlnX5w2GrBAkDX+3dEC2Qwm58OGEO8b3veOc7DIBm2t+VGYwEnAw
 kS6AzVgE3rLp85XupDevSycggxM8THL9D6TzRJxH383b63Lcqa14V0HlOIeIa46lUydNLgHjy6f
 uDYpef86BgEAUJeNomAAa49qS9D05tfi4UWKyO67ZOX86/VUvhDCvyms9QGFr4/eRJQjQ/xZUo4
 3FxTMht0vm45Wf40P+SqsWzHcA+Xr3hA5CGf76hPV93FSKM5GHXrIdz8VVNuljltt9fkPpDO3R3
 PLymRaFVEUugZOGwkvp47Nvpnq73WSthAiwNcYtnHvPxyt1TB5AnroPSeLRkNr4OQ9g8+FU+ZBA
 xOUcy+Zq3j9TaAylan+XOm5o3ngSlTNS2nxxV+fkqIZN2gZHuVk1f1H453YHPgNozD7EGPmL1Nh
 shMh94lc+JG9B6B9D7c6gEZ1d4J6I6t85kVTM/+VxICAyDNAoUau/tWnQoGTX0DDU5+5LoAXm+G
 vQg=
X-Received: by 2002:a05:600c:46c3:b0:4a2:fd2:9855 with SMTP id
 5b1f17b1804b1-4a35acbd173mr75223665e9.13.1792933479166; 
 Sun, 25 Oct 2026 06:04:39 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a55e9aasm122415545e9.5.2026.10.25.06.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 06:04:38 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH RESEND 6/6] test: fs: ext4: add tests for corrupt on-disk
 indices
Date: Sun, 25 Oct 2026 13:04:37 +0000
Message-ID: <74259e58-8ddd-4343-83f3-b25d792d754c@gmail.com>
In-Reply-To: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Add tests that make a small ext4 image with mkfs.ext4, corrupt one
on-disk field and check that U-Boot rejects the image and is still
responsive afterwards:

- test_fs_ext_oob_extent_header: an extent header with more entries
  than the inode can hold must give "invalid extent block"
- test_fs_ext_oob_delete_block: replacing a file whose indirect block
  lies past the end of the filesystem must fail with "Invalid block
  number"
- test_fs_ext_oob_group_layout: writing to a filesystem with
  s_blocks_per_group of zero must be refused
- test_fs_ext_oob_delete_inode: replacing a file whose directory entry
  names an inode past the last block group must fail

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 scripts/pylint.base                   |   1 +
 test/py/tests/test_fs/test_ext_oob.py | 147 ++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 test/py/tests/test_fs/test_ext_oob.py

diff --git a/scripts/pylint.base b/scripts/pylint.base
index bc39e2385a3..4c618e4d032 100644
--- a/scripts/pylint.base
+++ b/scripts/pylint.base
@@ -50,6 +50,7 @@ test_tests_test_fs_fstest_helpers.py 4.29
 test_tests_test_fs_test_basic.py 1.90
 test_tests_test_fs_test_erofs.py 8.97
 test_tests_test_fs_test_ext.py 1.48
+test_tests_test_fs_test_ext_oob.py 8.00
 test_tests_test_fs_test_fs_cmd.py 8.00
 test_tests_test_fs_test_fs_fat.py 2.50
 test_tests_test_fs_test_mkdir.py 3.04
diff --git a/test/py/tests/test_fs/test_ext_oob.py b/test/py/tests/test_fs/test_ext_oob.py
new file mode 100644
index 00000000000..a540c8200e1
--- /dev/null
+++ b/test/py/tests/test_fs/test_ext_oob.py
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+"""Test ext4 handling of corrupt on-disk indices
+
+Each test makes a small ext4 image with mkfs.ext4, corrupts one on-disk
+field with debugfs and checks that U-Boot rejects the image and is still
+responsive afterwards.
+"""
+
+import os
+import struct
+from subprocess import run, check_output
+import pytest
+from fstest_defs import ADDR
+# pylint: disable=E0611
+from tests.fs_helper import mk_fs
+
+
+def make_victim(ubman, prefix, cmds):
+    """Make an ext4 image holding /victim, then run debugfs commands on it
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        prefix (str): prefix of the image file name
+        cmds (list of str): debugfs commands to run on the image
+
+    Returns:
+        str: path of the image
+    """
+    img = mk_fs(ubman.config, 'ext4', 8 << 20, prefix)
+    src = img + '.victim'
+    with open(src, 'wb') as fil:
+        fil.write(b'victim file\n')
+    script = '\n'.join(['write %s victim' % src] + cmds) + '\n'
+    run(['debugfs', '-w', '-f', '-', img], input=script.encode(),
+        capture_output=True, check=True)
+    os.remove(src)
+    return img
+
+
+def read_at(img, offset, size):
+    """Read size bytes of the image at offset"""
+    with open(img, 'rb') as fil:
+        fil.seek(offset)
+        return fil.read(size)
+
+
+def victim_field(img, field):
+    """Read back an inode field of /victim with debugfs"""
+    out = check_output(['debugfs', '-R', 'stat victim', img],
+                       stderr=open(os.devnull, 'w')).decode()
+    return out if field in out else ''
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_extent_header(ubman):
+    """ext4fs_get_extent_block(): an extent header claiming more entries
+    than the inode's i_block area holds must be rejected"""
+    # i_block[0] = eh_magic | eh_entries << 16: 255 entries, eh_max stays 4
+    img = make_victim(ubman, 'ext_oob_eh', ['sif victim block[0] 0x00fff30a'])
+    assert victim_field(img, 'Flags: 0x80000')
+
+    ubman.run_command('host bind 0 %s' % img)
+    out = ubman.run_command('ext4load host 0:0 %x /victim' % ADDR)
+    assert 'invalid extent block' in out
+    assert 'alive' in ubman.run_command('echo alive')
+    os.remove(img)
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_delete_block(ubman):
+    """delete_single_indirect_block(): replacing a file whose indirect block
+    lies past the end of the filesystem must fail before it is released"""
+    # Make /victim a block-mapped file whose only bad field is block[IND]
+    cmds = ['sif victim flags 0', 'sif victim size 4096',
+            'sif victim block[IND] 0x00ffff00']
+    cmds += ['sif victim block[%d] 0' % i for i in range(12)]
+    img = make_victim(ubman, 'ext_oob_del', cmds)
+    assert victim_field(img, '(IND):16776960')
+
+    ubman.run_command('host bind 0 %s' % img)
+    ubman.run_command('mw.b %x 41 1000' % ADDR)
+    out = ubman.run_command('ext4write host 0:0 %x /victim 0x1000' % ADDR)
+    assert 'Invalid block number' in out
+    assert 'written' not in out
+    assert 'alive' in ubman.run_command('echo alive')
+    os.remove(img)
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_group_layout(ubman):
+    """ext4fs_init(): a superblock with zero blocks per group must make
+    writes fail rather than divide by zero"""
+    img = make_victim(ubman, 'ext_oob_geo', [])
+    # s_blocks_per_group is at offset 32 of the superblock at byte 1024
+    with open(img, 'r+b') as fil:
+        fil.seek(1024 + 32)
+        fil.write(struct.pack('<I', 0))
+
+    ubman.run_command('host bind 0 %s' % img)
+    ubman.run_command('mw.b %x 41 1000' % ADDR)
+    out = ubman.run_command('ext4write host 0:0 %x /newfile 0x1000' % ADDR)
+    assert 'Unsupported block group layout' in out
+    assert 'written' not in out
+    assert 'alive' in ubman.run_command('echo alive')
+    os.remove(img)
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_delete_inode(ubman):
+    """ext4fs_delete_file(): replacing a file whose directory entry names an
+    inode past the last block group must fail"""
+    img = make_victim(ubman, 'ext_oob_ino', [])
+    # Point the /victim entry of the root directory at an inode number far
+    # beyond the inode count (debugfs refuses to link a missing inode)
+    blk = int(check_output(['debugfs', '-R', 'bmap / 0', img],
+                           stderr=open(os.devnull, 'w')).decode())
+    blksz = 1024 << struct.unpack('<I', read_at(img, 1024 + 24, 4))[0]
+    data = bytearray(read_at(img, blk * blksz, blksz))
+    off = 0
+    while off < blksz:
+        rec_len, name_len = struct.unpack_from('<HB', data, off + 4)
+        if data[off + 8:off + 8 + name_len] == b'victim':
+            struct.pack_into('<I', data, off, 1000000)
+            break
+        off += rec_len
+    else:
+        pytest.fail('no /victim entry in the root directory')
+    with open(img, 'r+b') as fil:
+        fil.seek(blk * blksz)
+        fil.write(data)
+
+    ubman.run_command('host bind 0 %s' % img)
+    ubman.run_command('mw.b %x 41 1000' % ADDR)
+    out = ubman.run_command('ext4write host 0:0 %x /victim 0x1000' % ADDR)
+    assert 'Invalid inode number' in out
+    assert 'written' not in out
+    assert 'alive' in ubman.run_command('echo alive')
+    os.remove(img)
