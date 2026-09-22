Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06730C98302
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 12:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C26F580A50;
	Tue, 22 Sep 2026 12:47:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5pW6SRVV8DWf; Tue, 22 Sep 2026 12:47:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 53CAE80DCC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790081267;
	b=TYLigKR7d7ZUWZBRr571kVhosOO9H2WuhhWTayaeCac7NXGwyx7YO04nVsA1zFscyVcz
	 t78fCnbhe7kGiZzkfTGlKd4JW0mno2+icxemAhClVx+Gkhi7AjEvzcgrBW6T4U8HTNvQM
	 Fk0ZidsBzgLxxkhGrZUfcdrdSDvLco/6oLSumGV7nccIKEiwrT61HtKn/4lSZ8emaY9G5
	 9dg2oV9KvFTFo9FyG78Gkw1PCUtQZ2/rkPMc5s88M0U9v1cENmyzkXt1BrfpZNTuTpjBv
	 n+XHLEl5VVdw3274e8qOF3MfhFOhvgiw/OiAvks5R8hzvHWyiOCB7Y5xSWU2LGwx4Sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790081267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4qSnykv2b3ZISEsDthEhxVBXeNVA5HZBn7/7WJpcx8o=;
	b=PWn6DajWu0K3HzFcQyLBRzszA2fS2PrhHgjlekmgQn5INuZjWHU/gPDHA3tlGtS/FaF+
	 +FFRnevxffSHXSQ1MLMI8XM5JL5cYAyXriPy7q624ZTp8DY0PkZPkh+yV6x7e1mkuK51K
	 aAdxYUX55X1F/vu6Q2mHb6KUEZhXRWEOVgJJuXAolNXmyOd7XurwGkLz3H7lexvcoXmoS
	 4rC6LifUC8D4Xf47P6EP2cAm+LO4wTlKUf03OYTGTNmUrS+bkeEnGlGQU9lACh6axJgaF
	 UD4w2T6goFV50uGnRvo+iXouUcssclHPpVL7EuJNmD397jnLjvX4dl4mozu0KV2+mHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=N+FWL+3i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790081267;
	bh=4qSnykv2b3ZISEsDthEhxVBXeNVA5HZBn7/7WJpcx8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s8woygeHFeBL5dD6YWHSA28IrK0GA1OtKrmklZLsu0Q5La2STHBXbFhWO2ObE9eaC
	 6C5WkK2Ehw0EbGJFJSk7xHbc95W0+dDdVY0aNxSlz3z3fzVV6CXcV45vcEG9GTKz0y
	 8dmbLGC/y37ab1jsT9C7kRPjC3LCaPu4HK0bhTKkD6SJoXVb/E+23m6YxQfnzD42oy
	 6BOt87BC9LPiq6nojGYTDuycNN6ZKOhveC4VNiexeLp+QgR6JagonNboww3xr007WH
	 /4ZcBdxsyHXFwsFlg5EN93Dl09oAsaIAhw3HeLVfCrhhqtyFFur2fwj9UN79aPv6c5
	 7FbdzmXvyIhyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53CAE80DCC;
	Tue, 22 Sep 2026 12:47:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7FDA13B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA0B9807AA
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nu1SaLjXSrXB for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 12:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 400358028D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790080634;
 b=GDpZWGrtQRqdo3uYA2fUN1RRnYTH63VDZ0y5X9YjNIlXx7J3UOi2zoMano3VkoXW3tdz
 2JpVzP5Fej/hJxTyLriLsx7wWkEg56LCpZ/ovAqGXcanTy6VE5One6QOxYKUJfn0SIlKr
 RZ6V7ND4tDGcfYLx/7OXGC1tNiw2cbXbOg2YqJkXoqITErDGzcg5VkGZ4UptiPznYLgh3
 FRme/qdW3a3HjVSjT3K54Tr+Ro61LM+HifpnEtj0jD32+2GOkHO+Q60YEPBmAjIVBO9tm
 8k4DollHI6C/SMGQV3NQdmRNSnDzUNQcBbRTU1SUizhldS3bFRDSnpw0XLaQjytJbbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790080634;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=4qSnykv2b3ZISEsDthEhxVBXeNVA5HZBn7/7WJpcx8o=;
 b=DFU9ODQeTPu+GkqOdCnwjAril7pvm+InP5q6RVcbp/O8TH4hJ9UKxhYGMD7WOtp7IqmP
 IEH9S8urxQYQPgueR1GuVBN0LciRowoHY/N6XGVIwfzL2W85fhalUQV66M8E00THlwZMU
 f/gxvUwUqilc/PPkKcNjnE0IOyMT8uzlIISE4zW15RdJYJPNh9/6shUWCX9YaFC39PR25
 PgL0HsOR4KF0YZGCoe8Q/HvJX3xyvL7ar4Ju2lph5U5x6Jqk9sEqlLE/YfnlwqMRGYvjn
 aIxfOZKrAqU9mAOZroXmD1NaJ5WrG/RkxAPVVNjSl15snHuNr2YfSMbAT9+08DwJimQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=N+FWL+3i; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=N+FWL+3i
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 400358028D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:13 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5AFE03F781
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790080632;
 bh=4qSnykv2b3ZISEsDthEhxVBXeNVA5HZBn7/7WJpcx8o=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=N+FWL+3idY9uFrZIuNUNO7RjapJhWUhKzW1KIAueJw3c+/jprzK1EW6ESxMFZybLU
 sPp7saa1KmZ1XhFCx847ymFmD1vx//HPvR0448jkWUpsg8hmF+Xx8cWCDyU43HbcxM
 C4hu53h4NQhMyqM7M8Pe0roH9m+/1bonmBsEFcdOAulI7fcwQfDTpc/LAa/Tpk4HVg
 CVh+TB2BvPkwd0rqPa8ZELEbqElfAAI6z0nehSGAID7dYEBdaMwznmiz012Q0vk2eq
 XbXTK1CLIwlUXACYT0oejzaLkuRNwYCP0BfQ+eMm+XI2tHJWSqBkKW93qt+ghywMos
 jxhLlShlecvIfSWmGISvClncM9UPFj+4H1m/2bnVXwrbwty1akgFA7BkRSPCk/KZ2u
 pkiLX+6qOWfhoHx5gesZAF4F6RzmCemsFqGvfSSIi36hIiZ9fXQIrwGvlaoy6T0DS6
 Bl7/OF14dnmbNu9+B5woAB0Ia2D9+7PnoWERZVeJIpMJZnHxYuUnxnCr5Th27Um1wa
 NRt8rBK+M5fa2QNg6hM8WqAyiwsqt4fFr5ss/w+DbVjB99GaaDepvc4AerI2ztwqJD
 xLgzCIsu59evcciwgmTGUOZALROIDhCk7VzBI3M1CDKKFw0P+f58C5WlQLEKWg6n3u
 uESg0GODEwkszpNnI0ADH8cY=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so57964455ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080631; x=1790685431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4qSnykv2b3ZISEsDthEhxVBXeNVA5HZBn7/7WJpcx8o=;
 b=zaGGveE/KKvPhMnZzD1GKcK/00F4xticQovlgZl/QnHY+rDxrBgskCVOVoVdkJUS16
 3+7EoaGvzEDWpT61QDDaVQS9u7vKqJaUpo+w9t4cszZGnO8N0Nbxp4twKNxIq7hqpJE7
 mWAFTWxb4/wjAVR0b2o3YJMoUDAuHBeCugfh0vRoTqriTbL7RQ8G76850yUWyhommE+3
 AGi6iqAcgLHc1EuCC/7+wptZaOWX3c/yh4/Zx4myj7gQ80d5lM6Fdi95O9rDiWRHFe73
 MIGZMRT/yIRvLMzHPyVG7ptz8XbYa2NocoUvV9kmcl+iK1BGS/XXJfpVBbZCfy+RTUJx
 /A1w==
X-Gm-Message-State: AFuF++kj+ZADh4MsoS+5a3jPrl8figps/WhnabYuitDMR9s6cWF4Rfou
 CXJRMpkm5cbcTWRrGiu5iJqNr8/JMI6aQ63sO3ow3y25c/w7ZEbxN7OoF69/NsZv8z5dmDsQO6y
 PdoQW0DhwfZ1x1ZK8C+jAAcU9+a48qROo6I3xF6x6NkENJq34hsassAC19lILsVjmvOX2bAkCEf
 /DmXgcgS165ir2C+CjqA==
X-Gm-Gg: AYBFou1gfPvTJNO7J92yFxZRSvW85xu7/lt85oeDVnOhSEUraO2OA/UDEh0BR2715G8
 VSuWDF2NgZm6lfWbkiDVq5UxqvPLyC230OKRu4OohfJ2uT4bxqfvub1a/EXDnZRKlIq9SCqXnGv
 Lt9c87oL/Oj9KmGvQlQ0h2m5y0XktwaG2QitmB9EF39uCOXjcsAPhnvu6K++bWoyMnhXb8gNNeU
 paVm4PzINdzY+pSCIqAm9JQc1d1g2WdnDHUwvuM0Vk3mbcAkdguLHK+T9jpbwjt5BZxpF3aZOFV
 r4HznwijbFutKiejPgmtGlTHGy0D/Xr8f97I1wtkO8NE0bxe0qtga5EkYX+loy987eOWBz2RsED
 IcJVQbC0gGaYxoe18xcJwKbTr3reV5g/98zqE/wmKGkMramUoGbI=
X-Received: by 2002:a17:903:3c2d:b0:2dd:c100:425a with SMTP id
 d9443c01a7336-2df60b7c908mr12598105ad.62.1790080630415; 
 Tue, 22 Sep 2026 05:37:10 -0700 (PDT)
X-Received: by 2002:a17:903:3c2d:b0:2dd:c100:425a with SMTP id
 d9443c01a7336-2df60b7c908mr12597755ad.62.1790080629894; 
 Tue, 22 Sep 2026 05:37:09 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d058116sm9054105ad.77.2026.09.22.05.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:37:09 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 7/7] test: py: add tests for the FIT image-data property
Date: Tue, 22 Sep 2026 12:36:27 +0000
Message-ID: <20260922123630.608961-8-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922123630.608961-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260922123630.608961-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 12:47:32 +0000
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

Cover mkimage's resolution of image-data references between images. The
positive tests check that an inline FIT carries identical data and hash
values on the sharer and the target while their own properties remain
independent, that external data mode points both nodes at a single copy
of the payload, that a resolved FIT can be re-processed with -F
including conversion to external data, and that two nodes with
identical cipher settings share the same ciphertext both inline and
external, whether the IV comes from an iv-name-hint or from an explicit
iv that is honored and retained in the FIT.

The negative tests check that mkimage rejects references to undefined
images, chained references, data that disagrees with the target,
image-data combined with external data properties in partial and in
complete form, a configuration whose image-data sharers have
overlapping load regions, sharing where only one node is encrypted, and
encrypted sharing where the nodes disagree on the IV, through different
iv-name-hints, different explicit ivs or no shared IV source at all.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---

Changes in v2:
    v2: add cases for the complete offset and position forms of the
    mixing check; Reviewed-by dropped because of the added cases

 test/py/tests/test_fit_image_data.py | 391 +++++++++++++++++++++++++++
 1 file changed, 391 insertions(+)
 create mode 100644 test/py/tests/test_fit_image_data.py

diff --git a/test/py/tests/test_fit_image_data.py b/test/py/tests/test_fit_image_data.py
new file mode 100644
index 00000000000..934d9a482e7
--- /dev/null
+++ b/test/py/tests/test_fit_image_data.py
@@ -0,0 +1,391 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 Canonical Ltd.
+#
+# Test mkimage handling of the 'image-data' FIT property
+
+"""Tests for the FIT 'image-data' property.
+
+An image node may name another image node under /images in an
+'image-data' property to share its binary data. mkimage resolves the
+reference by copying the data when building an inline FIT, and by
+pointing both nodes at the same region when building with external data
+(-E). Invalid references (undefined target, chained references,
+mismatching data or incompatible cipher settings) must be rejected.
+"""
+
+import os
+import struct
+import subprocess
+
+import pytest
+
+import fit_util
+
+BASE_ITS = '''
+/dts-v1/;
+
+/ {
+    description = "image-data test";
+
+    images {
+        kernel-1 {
+            description = "test kernel";
+            data = /incbin/("%(kernel)s");
+            type = "kernel";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x40000>;
+            entry = <0x40000>;
+            hash-1 {
+                algo = "sha256";
+            };
+        };
+        kernel-alt {
+            description = "same kernel at another address";
+            %(alt_props)s
+            type = "kernel";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x80000>;
+            entry = <0x80000>;
+            hash-1 {
+                algo = "sha256";
+            };
+        };
+        %(extra_images)s
+    };
+
+    configurations {
+        default = "conf-1";
+        conf-1 {
+            kernel = "kernel-1";
+        };
+        conf-2 {
+            kernel = "kernel-alt";
+        };
+    };
+};
+'''
+
+CHAIN_IMAGE = '''
+        kernel-mid {
+            description = "middle image in a chain";
+            image-data = "kernel-1";
+            type = "kernel";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x60000>;
+            entry = <0x60000>;
+        };
+'''
+
+CIPHER = '''
+            cipher {
+                algo = "aes256";
+                key-name-hint = "kern";
+                iv-name-hint = "kiv";
+            };
+'''
+
+CIPHER_NO_IV = '''
+            cipher {
+                algo = "aes256";
+                key-name-hint = "kern";
+            };
+'''
+
+CIPHER_IV = '''
+            cipher {
+                algo = "aes256";
+                key-name-hint = "kern";
+                iv = [11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff 00];
+            };
+'''
+
+CIPHER_IV_ALT = '''
+            cipher {
+                algo = "aes256";
+                key-name-hint = "kern";
+                iv = [00 ff ee dd cc bb aa 99 88 77 66 55 44 33 22 11];
+            };
+'''
+
+OVERLAP_SHARER = '''
+        filler {
+            description = "second sharer overlapping kernel-alt";
+            image-data = "kernel-1";
+            type = "loadable";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x80400>;
+        };
+'''
+
+
+def mkimage(ubman, *args):
+    """Run mkimage with the given arguments, returning the process result"""
+    tool = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    return subprocess.run([tool] + list(args), capture_output=True, text=True)
+
+
+def fdtget(itb, node, prop, ftype=None):
+    """Read a property from the FIT, returning None if it is missing"""
+    cmd = ['fdtget'] + (['-t', ftype] if ftype else []) + [itb, node, prop]
+    result = subprocess.run(cmd, capture_output=True, text=True)
+    if result.returncode:
+        return None
+    return result.stdout.strip()
+
+
+def fdt_bytes(itb, node, prop):
+    """Read a property from the FIT as bytes, returning None if missing"""
+    value = fdtget(itb, node, prop, 'bx')
+    if value is None:
+        return None
+    return bytes(int(tok, 16) for tok in value.split())
+
+
+def build_fit_text(ubman, its_text, basename, *args, alt_props=None,
+                   extra_images=''):
+    """Build a FIT from a full .its template, returning (result, itb, kdata)"""
+    kernel = fit_util.make_kernel(ubman, f'{basename}-kernel.bin', 'kernel')
+    params = {
+        'kernel': kernel,
+        'alt_props': alt_props or 'image-data = "kernel-1";',
+        'extra_images': extra_images,
+    }
+    its = fit_util.make_its(ubman, its_text, params, f'{basename}.its')
+    itb = fit_util.make_fname(ubman, f'{basename}.itb')
+    result = mkimage(ubman, *args, '-f', its, itb)
+    with open(kernel, 'rb') as inf:
+        kdata = inf.read()
+    return result, itb, kdata
+
+
+def build_fit(ubman, alt_props, extra_images='', basename='idata', *args):
+    """Build a FIT from BASE_ITS, returning (result, itb, kernel_data)"""
+    return build_fit_text(ubman, BASE_ITS, basename, *args,
+                          alt_props=alt_props, extra_images=extra_images)
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+def test_fit_image_data_inline(ubman):
+    """Inline FIT: the data is copied and the reference is retained"""
+    result, itb, kdata = build_fit(ubman, 'image-data = "kernel-1";')
+    assert result.returncode == 0, result.stderr
+
+    assert fdt_bytes(itb, '/images/kernel-1', 'data') == kdata
+    assert fdt_bytes(itb, '/images/kernel-alt', 'data') == kdata
+
+    # The reference and the node's own properties are retained
+    assert fdtget(itb, '/images/kernel-alt', 'image-data', 's') == 'kernel-1'
+    assert fdtget(itb, '/images/kernel-alt', 'load', 'x') == '80000'
+
+    # Each node hashes the same bytes
+    hash1 = fdtget(itb, '/images/kernel-1/hash-1', 'value', 'bx')
+    hash2 = fdtget(itb, '/images/kernel-alt/hash-1', 'value', 'bx')
+    assert hash1 and hash1 == hash2
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+def test_fit_image_data_external(ubman):
+    """External FIT (-E): both nodes reference a single copy of the data"""
+    result, itb, kdata = build_fit(ubman, 'image-data = "kernel-1";',
+                                   '', 'idata-ext', '-E')
+    assert result.returncode == 0, result.stderr
+
+    assert fdtget(itb, '/images/kernel-1', 'data-offset') == \
+        fdtget(itb, '/images/kernel-alt', 'data-offset')
+    assert fdtget(itb, '/images/kernel-1', 'data-size') == \
+        fdtget(itb, '/images/kernel-alt', 'data-size') == str(len(kdata))
+    assert fdtget(itb, '/images/kernel-alt', 'data') is None
+
+    # The payload appears exactly once, at the shared offset
+    with open(itb, 'rb') as inf:
+        blob = inf.read()
+    assert blob.count(kdata) == 1
+    totalsize = struct.unpack('>I', blob[4:8])[0]
+    offset = int(fdtget(itb, '/images/kernel-1', 'data-offset'))
+    assert blob[totalsize + offset:totalsize + offset + len(kdata)] == kdata
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+def test_fit_image_data_reprocess(ubman):
+    """A resolved FIT can be re-processed with -F, including to -E"""
+    result, itb, kdata = build_fit(ubman, 'image-data = "kernel-1";',
+                                   '', 'idata-re')
+    assert result.returncode == 0, result.stderr
+
+    result = mkimage(ubman, '-F', itb)
+    assert result.returncode == 0, result.stderr
+
+    result = mkimage(ubman, '-F', '-E', itb)
+    assert result.returncode == 0, result.stderr
+    assert fdtget(itb, '/images/kernel-1', 'data-offset') == \
+        fdtget(itb, '/images/kernel-alt', 'data-offset')
+    with open(itb, 'rb') as inf:
+        assert inf.read().count(kdata) == 1
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+def test_fit_image_data_invalid(ubman):
+    """Invalid image-data references are rejected"""
+    # Reference to an undefined image
+    result, itb, kdata = build_fit(ubman, 'image-data = "nope";',
+                                   '', 'idata-undef')
+    assert result.returncode != 0
+    assert "references undefined image 'nope'" in result.stderr
+
+    # Chained reference
+    result, itb, kdata = build_fit(ubman, 'image-data = "kernel-mid";',
+                                   CHAIN_IMAGE, 'idata-chain')
+    assert result.returncode != 0
+    assert 'chained references are not permitted' in result.stderr
+
+    # Own data disagreeing with the target's data
+    other = fit_util.make_kernel(ubman, 'idata-other.bin', 'other')
+    props = f'image-data = "kernel-1";\ndata = /incbin/("{other}");'
+    result, itb, kdata = build_fit(ubman, props, '', 'idata-mismatch')
+    assert result.returncode != 0
+    assert "data does not match image-data target 'kernel-1'" in result.stderr
+
+    # image-data combined with a partial external data reference
+    result, itb, kdata = build_fit(
+        ubman, 'image-data = "kernel-1";\ndata-size = <0x10>;',
+        '', 'idata-extprop')
+    assert result.returncode != 0
+    assert 'must not be combined with external data properties' in \
+        result.stderr
+
+    # A complete reference is rejected before the import when compiling
+    # a source file, whether it uses an offset or a position
+    result, itb, kdata = build_fit(
+        ubman,
+        'image-data = "kernel-1";\ndata-offset = <0>;\ndata-size = <0x10>;',
+        '', 'idata-extpair')
+    assert result.returncode != 0
+    assert 'must not be combined with external data properties' in \
+        result.stderr
+    result, itb, kdata = build_fit(
+        ubman,
+        'image-data = "kernel-1";\ndata-position = <0x1000>;\n'
+        'data-size = <0x10>;',
+        '', 'idata-extpos')
+    assert result.returncode != 0
+    assert 'must not be combined with external data properties' in \
+        result.stderr
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+def test_fit_image_data_cipher_invalid(ubman):
+    """Sharing encrypted data without compatible cipher settings fails"""
+    # Only the sharing node is encrypted
+    its_text = BASE_ITS.replace('entry = <0x80000>;',
+                                'entry = <0x80000>;' + CIPHER)
+    result, itb, kdata = build_fit_text(ubman, its_text, 'idata-oneside')
+    assert result.returncode != 0
+    assert 'only one of them is encrypted' in result.stderr
+
+    # Both encrypted but without any IV source, so each would get a
+    # random IV and the ciphertexts would differ
+    its_text = BASE_ITS.replace('hash-1 {', CIPHER_NO_IV + 'hash-1 {')
+    result, itb, kdata = build_fit_text(ubman, its_text, 'idata-noiv')
+    assert result.returncode != 0
+    assert 'must use the same iv-name-hint or iv' in result.stderr
+
+    # Different explicit IVs would produce different ciphertexts
+    its_text = BASE_ITS.replace('entry = <0x40000>;',
+                                'entry = <0x40000>;' + CIPHER_IV)
+    its_text = its_text.replace('entry = <0x80000>;',
+                                'entry = <0x80000>;' + CIPHER_IV_ALT)
+    result, itb, kdata = build_fit_text(ubman, its_text, 'idata-diff-iv')
+    assert result.returncode != 0
+    assert 'must use the same iv-name-hint or iv' in result.stderr
+
+    # Different iv-name-hints as well, since a hint drives the
+    # encryption whenever it is present
+    its_text = BASE_ITS.replace('entry = <0x40000>;',
+                                'entry = <0x40000>;' + CIPHER)
+    its_text = its_text.replace('entry = <0x80000>;',
+                                'entry = <0x80000>;' +
+                                CIPHER.replace('kiv', 'kiv2'))
+    result, itb, kdata = build_fit_text(ubman, its_text, 'idata-diff-hint')
+    assert result.returncode != 0
+    assert 'must use the same iv-name-hint' in result.stderr
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+def test_fit_image_data_cipher(ubman):
+    """Nodes with identical cipher settings share the same ciphertext"""
+    keydir = fit_util.make_fname(ubman, 'idata-keys')
+    os.makedirs(keydir, exist_ok=True)
+    with open(os.path.join(keydir, 'kern.bin'), 'wb') as outf:
+        outf.write(os.urandom(32))
+    with open(os.path.join(keydir, 'kiv.bin'), 'wb') as outf:
+        outf.write(os.urandom(16))
+
+    its_text = BASE_ITS.replace('hash-1 {', CIPHER + 'hash-1 {')
+    result, itb, kdata = build_fit_text(ubman, its_text, 'idata-cipher',
+                                        '-k', keydir)
+    assert result.returncode == 0, result.stderr
+
+    ciphertext = fdt_bytes(itb, '/images/kernel-1', 'data')
+    assert ciphertext == fdt_bytes(itb, '/images/kernel-alt', 'data')
+    assert ciphertext != kdata
+    assert fdtget(itb, '/images/kernel-1', 'data-size-unciphered') == \
+        fdtget(itb, '/images/kernel-alt', 'data-size-unciphered') == \
+        str(len(kdata))
+
+    # The shared ciphertext can also be made external
+    result, itb, kdata = build_fit_text(ubman, its_text, 'idata-cipher-ext',
+                                        '-k', keydir, '-E')
+    assert result.returncode == 0, result.stderr
+    assert fdtget(itb, '/images/kernel-1', 'data-offset') == \
+        fdtget(itb, '/images/kernel-alt', 'data-offset')
+
+    # A shared explicit iv works as well: it is honored by the
+    # encryption, retained in the FIT and yields identical ciphertext
+    its_text = BASE_ITS.replace('hash-1 {', CIPHER_IV + 'hash-1 {')
+    result, itb, kdata = build_fit_text(ubman, its_text, 'idata-cipher-iv',
+                                        '-k', keydir)
+    assert result.returncode == 0, result.stderr
+    ciphertext = fdt_bytes(itb, '/images/kernel-1', 'data')
+    assert ciphertext == fdt_bytes(itb, '/images/kernel-alt', 'data')
+    assert ciphertext != kdata
+    authored_iv = bytes.fromhex('112233445566778899aabbccddeeff00')
+    assert fdt_bytes(itb, '/images/kernel-1/cipher', 'iv') == authored_iv
+    assert fdt_bytes(itb, '/images/kernel-alt/cipher', 'iv') == authored_iv
+
+    result, itb, kdata = build_fit_text(ubman, its_text,
+                                        'idata-cipher-iv-ext', '-k', keydir,
+                                        '-E')
+    assert result.returncode == 0, result.stderr
+    assert fdtget(itb, '/images/kernel-1', 'data-offset') == \
+        fdtget(itb, '/images/kernel-alt', 'data-offset')
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+def test_fit_image_data_overlap(ubman):
+    """Sharers' load regions are covered by the configuration overlap check"""
+    its_text = BASE_ITS.replace(
+        'kernel = "kernel-alt";',
+        'kernel = "kernel-alt";\n            loadables = "filler";')
+    result, itb, kdata = build_fit_text(ubman, its_text, 'idata-overlap',
+                                        extra_images=OVERLAP_SHARER)
+    assert result.returncode != 0
+    assert 'overlapping load regions' in result.stderr
-- 
2.43.0

