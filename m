Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21908C88E64
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 22:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A312880C8B;
	Sun, 13 Sep 2026 22:41:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XbpqECsNwTqz; Sun, 13 Sep 2026 22:41:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 38C4480CB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789339261;
	b=Bt7eAVn1xIFazstjGd0jCicSb2i1OH4nzGS5suw8QMDXPFediVp/6ygj6NHfEXqFjyuB
	 MD/VxQuAnVU5EGmMaVKIasJXt3O6W+F2Z+0GCnnuUCdPEnCAAsABDrCy7/3KM6yh1wYqV
	 KZQdNaXMUs6lwh2KjfG8Og1KRjSdEN2EIikvp5reQLKA12CUdlDUh+XBdSN96IZ6GOxAz
	 i4tnOXdjNlQ4ghWC4Gg2EaWT4n1m1AVCEKyTmRNjn7K9XXvQHdW8U3cGXf0jpRMitFyF1
	 gqnnx6byr6zg9QyuniuZJpPE7YdLL7et6nkDy2/cg+8VnYpPXQ/bCrazKrJcOCBreSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789339261;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LnutXa/Ra9Ic1E9IH4OpgHvR6JvupkgpAMOZBAnoWLw=;
	b=UBWb9mvVXVcP4m96pOLtzeISVshNDMzcG5vXoo0lF1GwTEqPP2MOek6mZEvyZH2Xlcj7
	 YdYMiP9ZqEzRnh/3OwTK+g0DqlMoNqEEJE+NM+eZvXWAC3CO0i8HgzjXEbjBh6Bhxs2bH
	 UN5oT4Za27FA/1loanX+z2WZNc68kKCLH3snsBBT8/NQrQxyijkkmpmxj6PlboQ6n+vHZ
	 lOUeMQjDK/DwoFq458nTm+sSZX/d0eEqZeXdA+eC5vsgGm1R9Dmo838F6HhPHFMU6G5r6
	 yt4zwGrfpeHNC082QYGxxtwUfu+b2QZuYobaQzxGkyktq9eNvYVbb+PcBWu4RwOM7eA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789339261;
	bh=LnutXa/Ra9Ic1E9IH4OpgHvR6JvupkgpAMOZBAnoWLw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VvZP5YNn5DeV5QEYRPheF0bYq20I5ZhdHqWRqwEli5WtwvyKeAVvLMybV/ImDyur5
	 zepLXRNkWdGOgYyS5zFxnkQiz9xksMh3eafk4ZTHDZ6DrPhD0aE5fTgMOLZ3onFnE7
	 cugIj47Do4U+rnLdJUuJTqqcnub6fxR7H2BaZstlvr9HVV4QnQ0dEFPDy8rf72eTBs
	 6kjHvAk2hsDDj9vRo2rgDWK/mwyol66mZVrJUgS6ARjEJGxjvXRajXo4oNpuXtE4Aw
	 GQXWVrYm6gYPhY/Bn0nuXiwX5F2IucU/5+yQbOmE259N09ZsJdXnjhCJx5bXik9vri
	 CL8JgGTnDBN3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38C4480CB6;
	Sun, 13 Sep 2026 22:41:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DB5829B
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 22:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43D5D40076
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 22:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YjEQnhW9Q-uu for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 22:40:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C083240063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789339259;
 b=cEebdCSAyYPIPrBhSFo9O6MOPtquFkQwz9iGQ98jbH+2z4MsMhH2c1JZFxQQ30KonQKR
 SgwUNbdcCJ4MPhJe20a3jsLD0UxNPDh+bz65rJ3iIRHRAG2PRtPdyY+NGUwwvHcST11ZA
 63+vR4q3EUBSAH3ZO6p+RVxx9RryLxcnZsOcAxAJcL1UD5DS53mIJTqBquyhmMdWi02wW
 RSDPf0RUvSBAW2Fcv7c2Ya/mpXFH+a/1CBFrnVV8yWfIweFbqY6RbC668xBnNbmTwB67I
 aKMwVNzl45+m1Ys/lsrstkK2rVZ5VvOL/yFiJvRufYE+bLOgiJGlnd5KQQZKQKgTL9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789339259;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=LnutXa/Ra9Ic1E9IH4OpgHvR6JvupkgpAMOZBAnoWLw=;
 b=f5t4EZcXOy+/jJJ6zCPgeICGDPNPtqbeDIHufrRrtbJ5Ga2H+i5oo9e7/BTRk4F3mK/G
 5BHWl80UMHHSxQQoT21S7+EQHNwvIrz2InisSmKE5hVzJT3Lvt0D/nqecn1lRJYipcFnU
 H6ouJtCMHxln76Ztp7kEhDjcwnSu4l+Bn1nm/6hyLg1vRnKD/auMA3psWRw+97F8BAVqF
 F9gcADlsPHC0aXxBkoavbcG+PzUuXDIy5NoFRqq5UVxsDa4SCeR86z5SxBMgqhYwdigyT
 hT1d1SExN6Q4D7Pev6w/XMYCrE7oLdlVf22oL8Rb5OulWzC+H24PqU+iu0nLEozHwlg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mzYvhnK+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e30; helo=mail-vs1-xe30.google.com;
 envelope-from=rogerio.borin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mzYvhnK+
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C083240063
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 22:40:58 +0000 (UTC)
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-782af6c753cso2965908137.3
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789339257; x=1789944057;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LnutXa/Ra9Ic1E9IH4OpgHvR6JvupkgpAMOZBAnoWLw=;
 b=mzYvhnK+/Vh7BMWhZY8otzFHNhCz6H9Y9hQhjupDTkmcoVV/fw3ZdJ3/AWmkFgGBMt
 UrLoJ2KNca+5z+HPYvE3ODGE55gMaOB0dNyDCxUniFbLkp9NU3tPt6zDL0JZOklggyem
 vLm8eeI/INU8Rh3bZBzuNMCRtdoLqxelJzmT6mDVRM1z7Wdo+y2/1pkY2vVbPPpCsW8I
 YqvETJeTYnhBByxIv2QWaed0WZ+fkUkBqjEzxEx8srb5E+M1Z07SsFSEOSWmTd84cbAn
 bpPSIarzd8LO/xzcWBeQAGABH5c/QazsHDPQaujlUp1pEesFQcuUbnMgvqpnTMkUuk0w
 dMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789339257; x=1789944057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LnutXa/Ra9Ic1E9IH4OpgHvR6JvupkgpAMOZBAnoWLw=;
 b=R5pNRavc9i4FbglQEhkXLBNkejzTssbK+TTCZAoNvZwviY/ORzCGqEzHukfh++HPXv
 cTOlYTLy6kINDUaT/h+EveKb6y77LE+RYGWqesLHWIREdeNx8k5Sz/QhemxMKMPueqnC
 18sJCTBvnAsHpIkK/5xwhB1PFrAK36yN7tEI3WSWg3sDtZyWIfDVfcTxzaGlYZzD42Bu
 nd5hl7xPNcx8Ifba//SK28bE4iMOKsfyDJSHhjy54gp2WnKpiFxfZnEG2QogyEu7Ijv1
 vBUmQKHGuPKLG5xgowxoQ76YEAGkJOtvgc5TfOHu0Wbg1Zt/Ny8ONxRBGr5Z+UDR++Y8
 5nOA==
X-Gm-Message-State: AFuF++kS8nMGCnobdUz0wSa/Qjz0VuMXyuvSIDO+Z+H40tNqIgzVThjf
 xkSfuxWXo+xWFyL3BTrZq+JOjQzGMgXaga640Lb9xRQopTAr55Ybg18lsDIk8qxY
X-Gm-Gg: AYBFou0RyDQJOixqPxbBatYiHyQseX8aFi355ApzzID1CndGVXCsmdHEmgCcoaz3Mxz
 awtRytfKn+b36zmCcPgnrztQ2UI8ph6uk6QENv9LRHc6J0iupaKcaZVpe9R8kgNfUt0nUYVa//Y
 nGJCn9M6OubdDk36wRV2s5jEU+jbLZpkdXFrQqwgW2+gTxIOT72+lAnXn3Oc8vxUkvRZGJ3c/cH
 /H/jpHNPuz2euBTj4W4OTUI+rMGuISGCbSerogkENigklS+gfHvf1xI5+MFSPrRDK0PmP1JwQW6
 toadnj+oYM1is80Xnzwu/n2GPrwvNe9PB23zOYkPTCOcAByW19PGmSPJMA7snroz+JpZOjJI3x3
 Kr8HDKo3QJ0Ve1wCRXyY1ohZG6khGv/a/0l90MiMcGpWNdi96mrkb44MkpWb5BLqttlPEqjhcAP
 DeSK5a7C1iu2JDuHgiPc2OdP7rqaSKmzTsdo27LgsWF+B5nJkToLa9Egv5YIWB4B86XCaWmGRRk
 Nrt2VEovUQ8uHI=
X-Received: by 2002:a05:6102:f88:b0:796:1ed:ba3f with SMTP id
 ada2fe7eead31-79601edbb2bmr6795893137.0.1789339256927; 
 Sun, 13 Sep 2026 15:40:56 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:211:8d94:682:7fd9:38c:8693])
 by smtp.googlemail.com with ESMTPSA id
 ada2fe7eead31-7928023a9f6sm9538544137.12.2026.09.13.15.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:40:56 -0700 (PDT)
From: Rogerio Guerra Borin <rogerio.borin@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Rogerio Guerra Borin <rogerio.borin@toradex.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] binman: openssl: Make TI K3 certificates reproducible
Date: Sun, 13 Sep 2026 19:39:51 -0300
Message-ID: <20260913223951.3945168-1-rogerio.borin@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Rogerio Guerra Borin <rogerio.borin@toradex.com>

The three TI K3 certificate helpers invoke 'openssl req -new -x509'
without setting a serial number or validity period. OpenSSL chooses a
random 159-bit serial and a validity period based on the current time,
so otherwise identical builds produce different tiboot3.bin, tispl.bin
and u-boot.img files.

This prevents a re-signed boot chain from being checked with a
byte-for-byte comparison. It also leaves these images outside the
reproducible-build support described in doc/build/reproducible.rst, even
though their FIT wrappers already honour SOURCE_DATE_EPOCH.

Here we derive the serial from the hash of the signed data, keeping it
at 159 bits so the encoded certificate does not change size. When
SOURCE_DATE_EPOCH is present, use it for notBefore and set notAfter to
20491231235959Z.

The K3 boot chain does not enforce the validity values, but the ROM
cannot parse the GeneralizedTime encoding required for dates in 2050 or
later. An AM62 HS-FS device does not boot with a 9999 or 2050 expiry but
boots with a 2048 or 2049 expiry. TI reports the same limitation on
AM64x [1].

The validity arguments require OpenSSL 3.4 or later. Older versions keep
the wall-clock validity and emit a warning, while still using the
deterministic serial supported by all relevant OpenSSL versions.

Keep the generic x509_cert helper unchanged. Its validity policy is
outside this K3-specific constraint, and it has a separate
reproducibility issue because its Common Name contains the output path.

The full binman suite passes with OpenSSL 3.5.7 and reports 100%
coverage. The OpenSSL bintool also reaches 100% under OpenSSL 3.0.20;
the reproducibility test skips there because the validity arguments are
not available.

[1] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1491915/am6412-ti-supports-for-tiboot3-certificates-with-validity-beyond-2049

Signed-off-by: Rogerio Guerra Borin <rogerio.borin@toradex.com>
---
 tools/binman/btool/openssl.py | 71 +++++++++++++++++++++++-----
 tools/binman/ftest.py         | 87 +++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+), 12 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c447..f360864da6d 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -11,9 +11,12 @@ Source code is at https://www.openssl.org/
 """
 
 import hashlib
+import os
+import time
 
 from binman import bintool
 from u_boot_pylib import tools
+from u_boot_pylib import tout
 
 
 VALID_SHAS = [256, 384, 512, 224]
@@ -22,6 +25,12 @@ SHA_OIDS = {256:'2.16.840.1.101.3.4.2.1',
             512:'2.16.840.1.101.3.4.2.3',
             224:'2.16.840.1.101.3.4.2.4'}
 
+# TI K3 ROMs reject GeneralizedTime, which OpenSSL uses from 2050 onwards.
+TI_K3_MAX_NOT_AFTER = '20491231235959Z'
+
+# 'openssl req' learned -not_before and -not_after in OpenSSL 3.4
+MIN_VALIDITY_VERSION = (3, 4)
+
 class Bintoolopenssl(bintool.Bintool):
     """openssl tool
 
@@ -35,6 +44,52 @@ class Bintoolopenssl(bintool.Bintool):
         super().__init__(
             name, 'openssl cryptography toolkit',
             version_regex=r'OpenSSL (.*) \(', version_args='version')
+        self._version_tuple = None
+
+    def version_tuple(self):
+        """Get the openssl version as a tuple of ints, for comparison
+
+        Returns:
+            tuple of int: (major, minor), or () if the version cannot be parsed
+        """
+        if self._version_tuple is None:
+            # version() returns something like '3.4.1 11 Feb 2025'
+            text = self.version().split()[0]
+            try:
+                self._version_tuple = tuple(
+                    int(part) for part in text.split('.')[:2])
+            except ValueError:
+                self._version_tuple = ()
+        return self._version_tuple
+
+    def _req_args(self, cert_fname, key_fname, config_fname):
+        """Get the common 'openssl req' certificate arguments"""
+        return ['req', '-new', '-x509', '-key', key_fname, '-nodes',
+                '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
+                '-sha512']
+
+    def _ti_req_args(self, cert_fname, key_fname, config_fname, hashval):
+        """Get reproducible arguments for TI K3 certificates"""
+        # Keep the serial number to 159 bits, matching the width and the sign
+        # of the one OpenSSL generates, so the certificate size does not shift.
+        serial = int(hashval[:40], 16) & ((1 << 159) - 1)
+        args = self._req_args(cert_fname, key_fname, config_fname)
+        args += ['-set_serial', str(serial)]
+
+        epoch = os.environ.get('SOURCE_DATE_EPOCH')
+        if epoch is not None:
+            if self.version_tuple() >= MIN_VALIDITY_VERSION:
+                not_before = time.strftime('%Y%m%d%H%M%SZ',
+                                           time.gmtime(int(epoch)))
+                args += ['-not_before', not_before, '-not_after',
+                         TI_K3_MAX_NOT_AFTER]
+            else:
+                tout.warning(
+                    f"openssl '{self.version()}' cannot set a certificate "
+                    f'validity period, which needs '
+                    f"{'.'.join(str(v) for v in MIN_VALIDITY_VERSION)} or "
+                    f'later; TI certificates will not be reproducible')
+        return args
 
     def x509_cert(self, cert_fname, input_fname, key_fname, cn, revision,
                   config_fname):
@@ -76,9 +131,7 @@ shaType                = OID:2.16.840.1.101.3.4.2.3
 shaValue               = FORMAT:HEX,OCT:{hashval}
 imageSize              = INTEGER:{len(indata)}
 ''', file=outf)
-        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
-                '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
-                '-sha512']
+        args = self._req_args(cert_fname, key_fname, config_fname)
         return self.run_cmd(*args)
 
     def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
@@ -146,9 +199,7 @@ authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
 numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
 {firewall_cert_data['certificate']}
 ''', file=outf)
-        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
-                '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
-                '-sha512']
+        args = self._ti_req_args(cert_fname, key_fname, config_fname, hashval)
         return self.run_cmd(*args)
 
     def x509_cert_rom(self, cert_fname, input_fname, key_fname, sw_rev,
@@ -231,9 +282,7 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
  coreDbgEn = INTEGER:0
  coreDbgSecEn = INTEGER:0
 ''', file=outf)
-        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
-                '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
-                '-sha512']
+        args = self._ti_req_args(cert_fname, key_fname, config_fname, hashval)
         return self.run_cmd(*args)
 
     def x509_cert_rom_combined(self, cert_fname, input_fname, key_fname, sw_rev,
@@ -342,9 +391,7 @@ coreDbgSecEn = INTEGER:0
 
 {dm_data_ext_boot_block}
         ''', file=outf)
-        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
-                '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
-                '-sha512']
+        args = self._ti_req_args(cert_fname, key_fname, config_fname, hashval)
         return self.run_cmd(*args)
 
     def fetch(self, method):
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a0e8bde7901..7e4c84e2976 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -33,6 +33,7 @@ from binman import fmap_util
 from binman import state
 from dtoc import fdt
 from dtoc import fdt_util
+from binman.btool import openssl as openssl_btool
 from binman.etype import fdtmap
 from binman.etype import image_header
 from binman.image import Image
@@ -7296,6 +7297,92 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                 entry_args=entry_args)[0]
         self.assertGreater(len(data), len(TI_UNSECURE_DATA))
 
+    def testPackTiSecureReproducible(self):
+        """Test that TI secured binaries are reproducible
+
+        With SOURCE_DATE_EPOCH set, building the same image twice must produce
+        the same certificate, and therefore the same image. This covers all
+        three of the certificate types which sign a payload.
+        """
+        openssl = bintool.Bintool.create('openssl')
+        if not openssl.is_present():
+            self.skipTest('openssl not available')
+        if openssl.version_tuple() < openssl_btool.MIN_VALIDITY_VERSION:
+            self.skipTest('openssl cannot set a certificate validity period')
+
+        keyfile = self.TestFile('security/key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        old_epoch = os.environ.get('SOURCE_DATE_EPOCH')
+        os.environ['SOURCE_DATE_EPOCH'] = '1234567890'
+        try:
+            for dts in ['vendor/ti_secure.dts', 'vendor/ti_secure_rom.dts',
+                        'vendor/ti_secure_rom_combined.dts']:
+                first = self._DoReadFileDtb(dts, entry_args=entry_args)[0]
+                second = self._DoReadFileDtb(dts, entry_args=entry_args)[0]
+                self.assertEqual(first, second, f'{dts} is not reproducible')
+        finally:
+            if old_epoch is None:
+                del os.environ['SOURCE_DATE_EPOCH']
+            else:
+                os.environ['SOURCE_DATE_EPOCH'] = old_epoch
+
+    def testOpenSSLVersionTuple(self):
+        """Test parsing and caching of the openssl version"""
+        openssl = bintool.Bintool.create('openssl')
+        with unittest.mock.patch.object(
+                openssl, 'version', return_value='3.5.7 9 Jun 2026') as version:
+            self.assertEqual((3, 5), openssl.version_tuple())
+            self.assertEqual((3, 5), openssl.version_tuple())
+        version.assert_called_once_with()
+
+        openssl = bintool.Bintool.create('openssl')
+        with unittest.mock.patch.object(openssl, 'version',
+                                        return_value='unknown'):
+            self.assertEqual((), openssl.version_tuple())
+
+    def testOpenSSLReproducibleArgs(self):
+        """Test openssl arguments for reproducible certificates"""
+        openssl = bintool.Bintool.create('openssl')
+        hashval = 'f' * 128
+        env = {'SOURCE_DATE_EPOCH': '1234567890'}
+
+        self.assertEqual(
+            ['req', '-new', '-x509', '-key', 'key', '-nodes', '-outform',
+             'DER', '-out', 'cert', '-config', 'config', '-sha512'],
+            openssl._req_args('cert', 'key', 'config'))
+
+        with unittest.mock.patch.dict(os.environ, {}, clear=True):
+            with unittest.mock.patch.object(openssl,
+                                            'version_tuple') as version:
+                args = openssl._ti_req_args('cert', 'key', 'config', hashval)
+        version.assert_not_called()
+        self.assertNotIn('-not_before', args)
+
+        with unittest.mock.patch.dict(os.environ, env):
+            with unittest.mock.patch.object(openssl, 'version_tuple',
+                                            return_value=(3, 4)):
+                args = openssl._ti_req_args('cert', 'key', 'config', hashval)
+        self.assertEqual(str((1 << 159) - 1),
+                         args[args.index('-set_serial') + 1])
+        self.assertEqual(['-not_before', '20090213233130Z', '-not_after',
+                          openssl_btool.TI_K3_MAX_NOT_AFTER], args[-4:])
+
+        with unittest.mock.patch.dict(os.environ, env):
+            with unittest.mock.patch.object(openssl, 'version_tuple',
+                                            return_value=(3, 3)):
+                with unittest.mock.patch.object(openssl, 'version',
+                                                return_value='3.3.0'):
+                    with unittest.mock.patch.object(
+                            openssl_btool.tout, 'warning') as warning:
+                        args = openssl._ti_req_args('cert', 'key', 'config',
+                                                   hashval)
+        self.assertNotIn('-not_before', args)
+        warning.assert_called_once()
+        self.assertIn('certificates will not be reproducible',
+                      warning.call_args.args[0])
+
     def testEncryptedNoAlgo(self):
         """Test encrypted node with missing required properties"""
         with self.assertRaises(ValueError) as e:
-- 
2.43.0

