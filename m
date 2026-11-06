Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3C606D811
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uue/7Hll;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PViuOkrM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7048C60DA7;
	Fri,  6 Nov 2026 21:57:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lejBFBwRkc5t; Fri,  6 Nov 2026 21:57:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C6A960D61
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002254;
	b=hViA4CmmBOoGFDwT5uob/70U8ELWlxB8e5olO2eyiWyIaZLUCj4GEc2i88hp3pVDvpEJ
	 W8636sC/i/8EIl/JHBz8saDTHiBojUDts4zwgyh5ipGnBCgdZyj3nUA337r+tlXda2UDu
	 kTwlSdZhhphwMLdzo/+MCVPHffAm+Mv42wTnL5qafsTU9zVmv/z06ezCzG55j9q7DD8Ct
	 E+Edu7/JcXgTN2CA4k3bwAKIwXUY8YiXD3GAejlHuNp6iSYjXTXR+bfIIsCp++rpMSBLJ
	 JHMBnz00ZJoCGCWHkD1VsKXV/Y0SY7n9we/85Ijut76pHk/cBYefTPvInbPU6QpAsdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
	b=dEryWzQgzajGfPupYh6yihpa6fJwSJKLfPU1wUSQdA0XJb26kdZYT2T7sBGj4a8r0cOJ
	 cjw19Rhx3HX5b5KA7LN/fKzBIHDEbtMIT1GXg24qq1xO1QBcFw+2RG7ejOsGRo3Gddm2F
	 ENjLVL89jtbu3c8J8zC9mkMgPp+BJweIvjDJv8lxDAjXxoS4kmLSD3AgoH5xau61VXjC0
	 HGzgTEA1c0QI93uKFDbAhKjCVsXvO96KbtGFoAWEpTqGP54KQ1rb6adUJhfgFycUstq/w
	 EIgPk5asPJ5V1GsDU6Bq9eZmXWAw/3qHeBjlk0EC9NBSNXeWOprVCnols7gp4M+Sxsw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PViuOkrM;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002254;
	bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uue/7HllMWNBg/35zyNOE9lautMT5EAQN3/Y4UaTYWy2K0nYi462Ej4ES1KyQXJkQ
	 k5r3sfB+qgBrIivk0uf7r8wa3cqlIVG/rRrbOtEHsyfkTPRdZF8r/uHkaYbCEm/5/O
	 hEoyIm9vhLlFSLCRoWeJjOa8uTVUwmlPXLo3hVGjSHDwJTZCMTKOr45Ryb5l1XP50q
	 LGHYIVsXzTxKPVuygx+q1XehbVoHss6ohPQm0GylVYln52UIyAJESEZAnbXtZBJlUP
	 3Apkeaf3MD1/dD1wSxWFmPdWZ3te6C6bucBSvh4QZmOkii4NZQOdZ1m67Zs0LdCkkr
	 D4Db8GZ9TqAGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C6A960D61;
	Fri,  6 Nov 2026 21:57:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EFB11C6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00A9D60DDD
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 86xaQ_V-_9ex for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:57:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C21660D94
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=PViuOkrM
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C21660D94
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:29 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso46387f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002248; x=1794607048;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
 b=PViuOkrMaJd/Zg+/rvm6dOdu9+Ff9g8Hkc/odkorN1NqK6/ggrhqBXl9ztQ2In3RMp
 BnytuwCdnRK4FOEO8BGYiyCHlq0e1X5Hiawh4rtZWYOVyj7WbXDKSzZXnv5faDWMd+EJ
 dcY0SUHnxsQV6K7L1UdNizuzq/bWoktedwAxlP+hFSeiY0sERjply443fdZGnuIE8mck
 QAjdXGRhKr/48itsGkt4V87yMw7Q3D86s0RuzrEWvomNZ5s4jWLcKcMWISGpQmKuCpUj
 Qjd6RyKqmgPYchTpoPdy6je3wtvh7VHZbJ9TG9tn4fULa0TbIZysOYpIXEXoh2Wyt4aq
 aJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002248; x=1794607048;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
 b=eH9PdRD/q+t2rWjwwmItft1eUS/aEca17bdsbltcGv9x+TRrTq3XxvQ15ImlPosQvd
 aG4L383RTXiS7rMGQ1ysyxiHwbucD+xJGQaYcitlb/pkz8Fd6NrBMcuaRF7fOuzaU4RF
 KJzcomCUUHai4QlQ+rpo48iEn5/KWR3/VwDXcXBiBlneGccv4nq9nytLS32eOyLMr2S3
 QRQda6xCNEz9VeqniKUvwkIE7jo9MeV0YKS/2iTzq5Cc5Y6BINYfM1L6SGDYg6hyjy+c
 ZJuX1oFC+MHpF+tpsqB7thOjdaMN/Ihc/njAefYpThiHrpxUJGuB+Vr/ba7b1Jw3yGKE
 g2FQ==
X-Gm-Message-State: APuU4Z/pV2N+pIfEIkAR5Uhh85pFuSLtaA9uKiSuir7GLJKsD3oZ6DhT
 KnZ88/lFnLoCL3NDhxGPoY3rAKdV/zeixoNbLDJ38oPXdSCMIZROWckaxyqgEJF67u0=
X-Gm-Gg: AYBFou0OBpeQWcfu/EIFHi2CMucrzJvhe8cbPd7vS++C+48UAU1dOLb7CvPhjdevnMy
 RANhvrF+PiVGF2JRmC+ENp9nVCCZ0M4oJLZf9Ryop71Bk5Unadttk7dqYUpR43tF8qMpIG0Vudw
 50VQBPSLXElexBCv7R52esvnDLbHhiSiDdfr5UX/5deZ1WqwXHmuEaBMZ8ohWy5S1HkQgNWmLkX
 OdTJ++BANzWWI1toqzGMktykDTMpvYm6jA0LhK4GvGg/E0wZXAiGySsdrzjI5gPVd56YHIh73bU
 f1W8zUZb0Gg/6SWB7QOLqjyJeHn5gXf429QpEL8WaSgrRV9nhmp+JzvzoVliB9/Pf/2CMnFs6NY
 pju7DdaHxIAjrwWDs8OUl77v0ZN21oZ/2ym446+kJn53X1StW40UceCMDyb5ktbZyni2lCe8lFR
 HZQxG5fk5R7HJ3Tas49ePtX5/1jb2R5NVaSOhzqTuUxckSbgUxzmx6Zv6OD1yd14gdo/XqLRFuT
 YqiFnJaW05Y/GpdYzw/2K/NQe84njbkS24ha7qDjCEn7ljl3xJV0POcPLdsQecf2JXe4bD7UZWx
 Siw+pnDRKs0sKdMdl6Qm6HGOJs6JdVY=
X-Received: by 2002:a05:6000:250c:b0:48e:6669:fefb with SMTP id
 ffacd0b85a97d-49421fb5055mr508712f8f.22.1794002248013; 
 Fri, 06 Nov 2026 13:57:28 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7233297sm5992646f8f.27.2026.11.06.13.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:57:27 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 11/11] test: py: test invalid certificate lengths in signed
 images
Date: Fri, 06 Nov 2026 21:57:26 +0000
Message-ID: <e26b56f1-6766-4b7a-80f5-811f6d14e35c@gmail.com>
In-Reply-To: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
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

Add a Secure Boot test with two signed images whose first certificate has
an invalid length: zero, which made efi_image_authenticate() loop
forever, and one larger than the certificate table. Both images must be
rejected.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 test/py/tests/test_efi_secboot/conftest.py    | 31 ++++++++++++++++
 test/py/tests/test_efi_secboot/test_signed.py | 36 +++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
index 0755497d46d..9858dd36f17 100644
--- a/test/py/tests/test_efi_secboot/conftest.py
+++ b/test/py/tests/test_efi_secboot/conftest.py
@@ -4,11 +4,36 @@
 
 """Fixture for UEFI secure boot test."""
 
+import struct
 from subprocess import call, check_call, CalledProcessError
 from tests import fs_helper
 import pytest
 from defs import *
 
+
+def set_cert_length(src, dst, length):
+    """Copy a signed image, setting the length of its first certificate.
+
+    Args:
+        src: Path of the signed image.
+        dst: Path of the image to write.
+        length: dwLength to set, or None for one past the certificate table.
+    """
+    with open(src, 'rb') as inf:
+        data = bytearray(inf.read())
+    pe_off = struct.unpack_from('<I', data, 0x3c)[0]
+    opt_off = pe_off + 24
+    magic = struct.unpack_from('<H', data, opt_off)[0]
+    # The data directories follow the PE32+ or the PE32 optional header
+    dirs_off = opt_off + (112 if magic == 0x20b else 96)
+    # The certificate table is data directory 4
+    cert_off, cert_size = struct.unpack_from('<II', data, dirs_off + 4 * 8)
+    if length is None:
+        length = cert_size + 8
+    struct.pack_into('<I', data, cert_off, length)
+    with open(dst, 'wb') as outf:
+        outf.write(data)
+
 @pytest.fixture(scope='function')
 def efi_boot_env(request, ubman):
     """Set up a file system to be used in UEFI secure boot test.
@@ -118,6 +143,12 @@ def efi_boot_env(request, ubman):
         # Create a corrupted signed image
         check_call('cd %s; sh %s/test/py/tests/test_efi_secboot/forge_image.sh helloworld.efi.signed helloworld_forged.efi.signed'
                    % (mnt_point, ubman.config.source_dir), shell=True)
+        # Create signed images with an invalid certificate length
+        set_cert_length('%s/helloworld.efi.signed' % mnt_point,
+                        '%s/helloworld_certlen0.efi.signed' % mnt_point, 0)
+        set_cert_length('%s/helloworld.efi.signed' % mnt_point,
+                        '%s/helloworld_certlen_long.efi.signed' % mnt_point,
+                        None)
         # Digest image
         check_call('cd %s; %shash-to-efi-sig-list helloworld.efi db_hello.hash; %ssign-efi-sig-list -t "2020-04-07" -c KEK.crt -k KEK.key db db_hello.hash db_hello.auth'
                    % (mnt_point, EFITOOLS_PATH, EFITOOLS_PATH),
diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/tests/test_efi_secboot/test_signed.py
index 9e6d3fdf8d8..d14f9b795d5 100644
--- a/test/py/tests/test_efi_secboot/test_signed.py
+++ b/test/py/tests/test_efi_secboot/test_signed.py
@@ -378,3 +378,39 @@ class TestEfiSignedImage(object):
                 'printenv -e -n PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             assert '\"PK\" not defined' in ''.join(output)
+
+    def test_efi_signed_image_auth9(self, ubman, efi_boot_env):
+        """
+        Test Case 9 - Secure boot is in force,
+                      the length of the certificate in the signed image
+                      is invalid.
+                      Must be rejected.
+        """
+        ubman.restart_uboot()
+        disk_img = efi_boot_env
+        with ubman.log.section('Test Case 9a'):
+            # Test Case 9a, certificate length of zero
+            output = ubman.run_command_list([
+                'host bind 0 %s' % disk_img,
+                'fatload host 0:1 4000000 db.auth',
+                'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
+                'fatload host 0:1 4000000 KEK.auth',
+                'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
+                'fatload host 0:1 4000000 PK.auth',
+                'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
+            assert 'Failed to set EFI variable' not in ''.join(output)
+            output = ubman.run_command_list([
+                'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld_certlen0.efi.signed -s ""',
+                'efidebug boot order 1',
+                'efidebug test bootmgr'])
+            assert '\'HELLO1\' failed' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
+
+        with ubman.log.section('Test Case 9b'):
+            # Test Case 9b, certificate longer than the certificate table
+            output = ubman.run_command_list([
+                'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld_certlen_long.efi.signed -s ""',
+                'efidebug boot order 2',
+                'efidebug test bootmgr'])
+            assert '\'HELLO2\' failed' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
