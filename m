Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4D60A2612
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZsEQCMoN;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PGzCls3Y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BD2F81161;
	Tue,  3 Nov 2026 16:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8oLnUQjBR_Bg; Tue,  3 Nov 2026 16:13:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA25B81180
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722400;
	b=DT16zDNzIiZkfwRG+DtRXEFlGtE8QzxP5u1eOfx0y3TTNya4bNfqDFRKgpUVOLKPFxYf
	 zBbeQXKOpgQhtYkpJmb0J3Ejtb599tWS6agdeZoZ3T4kQixpXoFkLTDELK2biwDcuNQg1
	 fkZaLTrM47lut6p07meaiQcy3JKkS0sEB+Qji5vGaTGyucWBPkuLkKKRPIKYiJ11vy47E
	 Fs/rNjfqct6DQfnqDYPPzOfaMilWSlz3WPxrK4ny+kGMNBHPra/duF4JWohpCCRc+FHY8
	 f1Po6ifNqPQcyrsn/6aDW/+cHjurGx0yRdo7YybKKZuJ5E1phxh5BipP/9KrHZQoz3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
	b=I/AF4z4dX9IG8o/Fx8O5fYIHKuZN29+56wwFyn80TXC1YYZ4obyWpaJLG+kq1Bxnssms
	 EUCc79KipNm4jO54u2X6smlP6bsK982SBPVpsPI7/F+NvJ6l/vU3s8N/lxATWuGMDnsu7
	 4rgSmzc5RVq8YLVZ7eLw4nHBmkv8aOfFWeexfzHXOiCOIAc0uj4FEbtvUpVZBMslkbCU8
	 IR57Adzd2PNQ3gu8A4w/L6gdhtfe2lV1s/KGeH/CMrWVehAoeXNT6G+FwjXN4+ExgSCuh
	 TQGnW9Q7nhKzcOCUhUGUSHxARGgQz3NOQDpciUxRuSVpVMk61KC8Yh5tLtEjdntbmpg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722400;
	bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZsEQCMoNv3Kp/8pitiUjKj8FMEL+2sjByP3GosTpujpPxJeOmjq0fE/m/gasJ18r7
	 Jvopb0+uIu4VSev2HHRfJiFKClM85nGhcBLWBFew99Yuz5LYpliRpQ/Jgolb02IZ9s
	 q1Ae2jhjatSA9+hStKbiDuYz3WS7Kvs+qEnsvxF1cghoin/W8rggp7M/8UmK4JhXYs
	 y1lIWqStEeTNHJGOweyJWivxRvjJcXobpNWM8b3iLtL2aFm4ECaRSpJhxoQx7iF4uE
	 OQRC3NdH4RXgqG34d1v33nu7nzZdjUR3GV9//Asf1AHRqZXCcGvjp5Uv0zbBJ3vcMD
	 q6oCK94prHyUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA25B81180;
	Tue,  3 Nov 2026 16:13:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18C1CA5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09C736084A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NPsYTTDeEzGS for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:13:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0530F6083F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722395;
 b=BKAsgVML9DVVkS5LUrRRMmTPvOZJ2N5mEFVSgY0uLiw2p0MLBRSrCVsk6qCgmIqNJR1q
 mb+8VQWCLnBgJcO9zorGj4z/n3zgamXZs6UNOnoX/Oc7e+IWVUYwUACfrqIk2M2iScB8s
 +m6O0koaY8ApzOVxW1Oor/ik92pOOeFkV5VkvnRHkH4crOvMu/239jqlBkDum2yGeHSya
 A4b/KDk4Lr4qqkWuOVrLzeVXzbcb9BTVxrp+gxRky0UogfyHEOCOscqydleR+ETNGVpCK
 uXPITy9tZ7OU2wBfoAtNCQE7Fn1kjZtOq8QoO79Akdh7OQtEZX+AarfVbj2vkPHlLLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722395;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
 b=BFAdec3rBQrdCAzX8nQeRGjAxKppnv7oj4WT9wEIJRujaKy+n3lrvNi/b0w4uPvYq33v
 ml2ujUtFUKplmK77IK3l+P3F1FXvphTcqCb5fHtQ4QEoGZrgwu5c4IQM1HrwBdiD6DrR1
 IApi5O7cD+ow/3vuCAfW1GxOE4wVhX4SXhKGQqlFtlE3BfA7DrCKhr9ELI7u4XK9CTQS9
 zrdd2k2+COQA8ntoD+PtZ8lgrkCvhreJHcjOzFkugVPUQHEgA4Sq0eKY4eLwQw2BfUrge
 VtSM7/19AvYn9DwiEx8vfNqGvlMGh5ImdV1jPSj/P20T9V48H/Vd6MsutEfmKZMwm7Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PGzCls3Y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=PGzCls3Y
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0530F6083F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:14 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso531032f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722393; x=1794327193;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
 b=PGzCls3Yv75bSsLG3WRj8U9uHxRgtnT/yliaA2CgdAJ9aPKchBuRFlR/akxTo9JCgd
 LddHgv23j5x43tRPG7VozD747uTo57vGWA+HPsTtBik7f3V1qe9T6UxcShquRBjYsFp9
 zZz0+Ns3BPoIjjeK7nzIPdY0K0DY1wxo8RrLoFzjmvQeTkpd8d1p036+RWHrJga/s7yS
 H0ItHlruOmgBp8Ecwv/Xj7zdfw4Frh9JWFF623tVtHK/TqB/36gbh+qOn6sPuFFLkmsC
 UarDwVOuAN2ftxHZOIUYlt9qQmcajeWdB9MzXCEpRzmKBfKA5wGcExN2xhDvZr9rCdZr
 EtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722393; x=1794327193;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CfBkS+tIwarh5YmKFwnOzcmi9pU3CJVcbzuDxUEzLyw=;
 b=R9tIiHl65hh+74M8utcww6xmyoOWcPQwfEwGVk8dad4XUojeLmbRahr+9nHwQX62pq
 /0n8I85GBpb2G5t/NHmbxT+GjnzPFbXm6NuFwzlnjmqMSH0yYCi4lbDh9CtTlbX7N11q
 vyqzl5MdLdhda2yoqtU9kCtLovxhdOfguNMwBMle4V5mPClO9F50TTAuoYdZ2Krc458p
 usPme8yvCD0Eo/3wdBcRPh3kNImiBKyKF8wQbxHlGmCgTiodUslJ3dAFn/W7mRVIo3Cu
 y4ZTKA14oB6KFK74ZTNPrynD+PxxqxnxIFpUCVMJGcVybO6OfiRe2A1tWa/x9b2Dz2Fy
 LhuA==
X-Gm-Message-State: APuU4Z8Cv5BpQTlQAMh0rEmA0ggjQLZ25YHYAjuO8jaA+N3PwXXh1my9
 cM6QqcXzNIdg9JkxjC9w8yPq1DvAWYURgaH1S2qDrQjaa5d+C5JK/ZhSugM67JsiawhPvJP4
X-Gm-Gg: AYBFou1r9CYkgfQQgkdwQhi3zblKSsjZrSh8CHRCqusnGHAWcCA1MGLCct0DBi9U6yN
 NplIFT94seBIKlcgEX7penc4HadIcB339NBx6mZoXEIamr78DpN4fzChvebYkUTEh9AxVRuODyk
 LQHvUZeL48+uUYzeHQoQ6Xpx0LYYLrBmiNxrZ1a9fVIl0yDXCb7qC43fC4YVLB5JztErua1W2C3
 tRGFjmFe82RVtp97OgbDye5V/4+RtK4P7YytvGD5mYXIHliWB39IR1vGEGZqMVT2AQ0+g7ABQxW
 bJsqIJXr7SE9OihBpaxGfcUg/Vc18+GrCxVp/S9W6q+zIRNaqwwqxTox0lwNA5C256SBceqqJTa
 z74VQ2LGwsOs73Ii5B3JinR6NBhspxTo5Ru6W6UvRqm2jqr1gTSQIEHzuXtYhPu4b1yXYr/QArt
 2XsOIBdEO00I7m6XQLq1EoTITeUitfiRgk4hOXKHG9NOX6aSY2YHMs4JLk1sF0DCG56sREFUPQM
 eqyhHNnYXwQIvsqcgT3C0Aet6kwEAMRFy9CzsuQub+0GpeaHIf+w0BLv+fzwrmFrzZV9NPEBlop
 9imYevd6mbM4UdYSRiDmC8neB/3K2S0=
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4ac1793e81cmr327621415e9.13.1793722392591; 
 Tue, 03 Nov 2026 08:13:12 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a0a3495sm277548145e9.4.2026.11.03.08.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:13:12 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 11/11] test: py: test invalid certificate lengths in signed
 images
Date: Tue, 03 Nov 2026 16:13:11 +0000
Message-ID: <5abe1930-3c34-47b7-b3f6-7e8bd78da46f@gmail.com>
In-Reply-To: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
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
