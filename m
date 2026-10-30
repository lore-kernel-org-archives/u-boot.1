Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E6606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iBK4a9Ic;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fMLT9nhD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BADA40A58;
	Fri, 30 Oct 2026 06:14:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xinEatYNZ22u; Fri, 30 Oct 2026 06:14:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ADEC140A5B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340880;
	b=Ns2UuZkEd5vZmMsWUo/tA691xAb8bDrSy3rWUNqQlP/G7vZMOZ2A8uu5DRiJFfOcbCKp
	 d3fheX5VcOp0837UdymUHqj5IGAy+wvhy0gPRZC6VVKALiR2BR5DTHmxgYPBfXqmUWmLW
	 UJDp0O0p6wveYqZGUvw9gHao3VCjbp6kr+0VLdQ9ApsyJR7rE6EzZ8JD0qYWPQ6RZOOpt
	 AIl2GwbNUqFHXyraZGkJFaOJrTZdfd8BR0mCS3lV3u+eUPGNPiBoFdtGll+jwqisnvT75
	 kG8l5nH6Mu5b8ICTy9NZvlC8zzGzDLipTFy9yl9W/TwAJbBi3n3zi7M7zxlgrOXwkjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
	b=Z96/Jky2uPEuXbFkykrayfC8W46EZ9Zg46aXq2HyzlbJtR/UMZL+R/GMRWRnqTEHtlrS
	 H6qmMXcCM+TUcb4biWyaK5hti0zkvABnn3I5uFW/pa2yOX929UvCnhdCXS0u6jjKR3p8q
	 VFmRT/emwyMJQiioLOo/9VA6XfuCEpGD/F/WPElpCP+ZyGPbSTXCDr692JHR6Obabtik4
	 ETJe4P+LRKsJmu6V4JALVwfcT9GgorTATtz2/8YMmLEK975f6PY+lBYmwjClbtKujb1K4
	 leq2D/JQqY+oXJgn12Xxm5oZqfwS5o3RtT59pYjc7+xW0o+qrGeQuPjAaGSjUAJR/uw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340880;
	bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iBK4a9IcxuxS7FINLEEeMeCveBz1V4R2SzwmkeKrW4p60jLDxqa/NUVKIs0n2Dl0S
	 JKL976IKE9Yy3FiMXqvr3UeE8Pvr1uHGNp+oUQbd21/V2k03+FPcU+ZCfL5zajN+z6
	 5at5tOpA5t2EiNTESLNOofIozqOWLNqSoxSI68CrXoLoP3HArOZn5VKBr5tA3W9Av1
	 UBBra4W7Iw5FNZKxAT4IZIWxam3jc641sGgHBDlxY/mqFSjssRfEU9wVmrq0Ih5OJr
	 zb1z0N692Ms+JCaibCS1nRqY9B6HhFKNh/CoDaXIErlK5uKw7i1HD7/Ycp1+0hVDdf
	 K9nZJ5soPHbRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADEC140A5B;
	Fri, 30 Oct 2026 06:14:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 85D30362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A58160AA1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i0f4nl9LstK5 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:14:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AFB9260AD6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340877;
 b=qFqJRrbvVJNu9ylwng1c9xQ6u6YMOWOBi/WcP6UqYHAPhBZNQ8+WgEHrVrn+bUTJCyyy
 Pitx/nDxWnkKQw+SQm6Ad0zNRQ8+lizQKoqGQypXGMLdH4DIzo7S6d7DMnPjZZrXO4n1a
 aeQ/AD7wWvIrNNWEXzbjgNwFoYuCxKEfDM03wHPLKTl4PLpugWFvrf9QzrBdRToLc8rwY
 mDE6Xs45BdGeTCapAJl5Nhv1hrPHiHslYE2jTfiquvSCjD/8WXZOyZ/1pqc6sfqzBsIMY
 GsRm1J0TsOPUM5cdqtQiA2/+WkHNly91gf6dqoHXI7wAZxwTqHuafzYLaXnh3GGaS4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340877;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
 b=XMk9lMPkVqCi+P2p1xrUfaq3PJoxstsW9SehkyaU8h87ORwtzn5/kDmLSdNfMzziDvYH
 mpV5aVSziA+F+ZlhAbDhecEwX973cDYeWZ+FaZb4K2BoCL3TR2GtIG+rh8gpXgxdIRByS
 iIbq2/ZsbSU7xF2VBx4cUXQ8AB320IEH5+356GyCzqkuciDZ6oGmAsej/YYg2LZB7kdRw
 MaQXf6Gd2itOUJTsyYGXq4SPukULU/XzhOCPkLY1rTRYgs7CAl9jC4LEHembWt98A7oZL
 Bf4epeOow/1prcUrsK1j3lSlFkdJGNOyU+WbfpeA+FsyoDFIug95JHJfp6kqptBdGHA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=fMLT9nhD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=fMLT9nhD
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFB9260AD6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:36 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so1763375e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340874; x=1793945674;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
 b=fMLT9nhD179P9HTsjqZcHei2mAhvE42qlDFySa/cjwv4+pyA2zSfpnUyAUM9OXp5r0
 0iB+A2bAIcZyw0/WRIkeZZlXJZAR7krk8CVTdVdJpdoLHABeTdhytbpB/N9h92WRhCFX
 Pgrj+m1UYYz0dub4YqiAw9ojwH7tmbb4djPadE52WgNAMHIfDeQSdnEc292tlWvMmn+M
 D0rjY4uZYQN38U8lvy8jzXIn7vlcWlM23E5KXbd0HTqRY73ocb0slnI3lFNw/vKpkptU
 tzfEdxXz+Ma26Mkwh2q7cmbTu5xq3/gCF9UZLqD/iZFztX/UZk9U3N5QygBpvVTIPxUs
 tetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340874; x=1793945674;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
 b=YedWJZxf9YSlusi4o7lsmEMEfLcY594K4KHMsxyCDPBGoBWYr7wTD9M5fo1JH++eil
 /JZUgZwMnfuZk++UuHShdrJ25n7Bn2IDvvm2dW912gbDI7KgsMZBs6aYQ1hG8HbnC1yg
 tSk+WJh7liU57dJgDvg05GStoPIPBa9mThrKYSQFB2XMRMgLQscPJNA303CJNJnd6bn6
 WF0tFoHtxZQI6vPLEum60caMDb/jn8+SW1cVp5ESBXLD5FDC4TD0og4CY8ZR3Mxc6eZK
 BotfTYvr2Gctk4TglaUoY+ylTLYqsdNda+Lb78mNI0KLM97gvSldUxDH8pF+FbVuRYJg
 GQQQ==
X-Gm-Message-State: AFq9FYIXWOInLlxiJoz4YxkWX+XvRHQXxASkXTjx0GBCOaOrGgOkcs2T
 Iodvfl7HM7SapwTjX6ssv7Q/GhUsXy9dI7bKepYN2AzwR7ucz8oHqm7Eh3T1em/MSJU=
X-Gm-Gg: AYBFou3Fbw+ZxUQ2G0NJIcdojwm+yYlqmXd189PJUi1pYFxltrVHIf5j/eakBthC2l9
 CxmnkZIx/ciyYYqZN6LFxBM7VILAKFxpqNXq4TS40IC+kB+T5f0PW5JFo3XqMrkRLYACd76rYHj
 4Ef+1nBrIPlG4Q1HmgFt/ETbyS0kVtIHxz2Lp42jDJqT6ly01CIkmQeA/CZiuMLsCOg6zQnL0Ex
 D8RaCEso+9JpOunDk5nLOyClq1tr+F1JFGHa0VR6iFTIzQr/cV/7N0hfn2wsCC8uA0un8rAsI2a
 ZdVIQc7R0E1XOh8uoiZpz/r1IHTvPUtC/jMPkKAaSQgFGeBVUMiQKO7IYCMsP/MxyJmDUXVcGNx
 AiZDdQ4j4MyoEqWV/oQ0kgHPBocrCEt8jcVG0UVqWbd4sLrTONqL7nMPukETPOyVwNza1+1C3kR
 Sdlghr+u2tEHzaLNSy48Mx+2Z0yDjK9v5yOimupHh61yMLJMIMfGwp8R3c38Afrz6CUDS272U4v
 e07sjjgP1h0nb7UcsXKcLAy4TTbgobNjXkJPD54+7OelM80DrugigsnLPF0ltZgfSym8DUr5Gf9
 0flBXYRcPbhbqzJa029k+lLu0Smrwk8=
X-Received: by 2002:a05:600c:8b63:b0:4a1:f688:a5d5 with SMTP id
 5b1f17b1804b1-4ac187a7655mr22406145e9.23.1793340874420; 
 Thu, 29 Oct 2026 23:14:34 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf396dfdbsm38707535e9.1.2026.10.29.23.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:14:34 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/10] test: py: test invalid certificate lengths in signed
 images
Date: Fri, 30 Oct 2026 06:14:33 +0000
Message-ID: <b6c14bf1-b883-4891-8717-786bb5ec4e5a@gmail.com>
In-Reply-To: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
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
