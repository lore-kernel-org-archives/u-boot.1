Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2403C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8281407CF;
	Sat, 12 Sep 2026 13:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TycDxTkWr9xI; Sat, 12 Sep 2026 13:26:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 614DF40623
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219610;
	b=Uzx1jlDmZm1Ku2v7AiE4mwgXXxlz4kEO1mT15XysWlXeuKAEr9fpLMrLLDGm9lrQ69Mr
	 18iatagaktYYBIj5XhhdoBo34HB2RaMvRiQLmqFQt3wXi6IUQxFzAr6FyoIcM/TkDmSBR
	 1nVTBkTTlaPaEAs75eH+NOmKPsAm9Hzfy0ueCbTa0cv2CeZWr71L9UzPT5xDXH3sEjjfE
	 IY64xLyZMHRUr3snub+esLoSyWIPXwes/R+l2Jh2jeBVisTrE25mOzjACiliV59luTjQX
	 +L/nl1LRtH6Y8SM+YkGlcsx24JKRMD/wc05I5Gt/OhL6trVxiOmwoKeiAPWI9/HQ1jA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=i0RuKv1m9xjoCUCQ866zvYdINqcZYRReMV2qdo13WTY=;
	b=i8waZlOihciHl+ulYMfA6M1T4qKWLncuIi+IOqEKba8++dj5YwMcGztLaAuFbRCBMa0J
	 Qn6fbC1cHkihXnmVKrS5CnwrwM0qVxkMQeAWtxCZm2RpbKBzzQpwvqAq347AnHbe90BWC
	 fpekfpKgdGlvRqYH4UMddlWqmOTJCr6jCNNALMJe3NMUy846gZjf3b+9UwvdtLdXpju2U
	 6ECKOYtugvSZZ7OlmeaeCYBASfA9R3UDJkr8hUoBu+AxawBzQC8SJD43tX2QOoXcLf7Di
	 NZDSx8y+JlPjOWaGVys4JF4UAwSrZHW4Db++INF6ALAWC/Y9XN33ZPCjexjgf9EZ06g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=erhXX8fU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219610;
	bh=i0RuKv1m9xjoCUCQ866zvYdINqcZYRReMV2qdo13WTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mMwQjhb+4cWKwo/+ZuHSyoqZlv923wcjUa+jSi3ThvF8OwFl0sQTpkT7sdYK/LGYV
	 U3zjm81eGm2qfWKar+GDh/IlEjyOwHeVs5SEYxfb/0q2R5jv2SoYe5dBjK96AcGqLC
	 3Sm5a4dyoVCcGcKVBdMo5QN0KwGg6fmNaGuuOb4KuKOU4MwFW3Hs82gtM1QbDwaVB5
	 IcbuQnqsVKFxpqppM6McVHioAmsOuZ7zgc+3Qycu4I0j2NsQpmSKt+j/fYoFmzkbyb
	 Cl65LW6t5lyMVGPZbdxsPZTzt0VDFs9lrGSpLRK9N+dI6kXJojox6tvycFlv/lFRnh
	 2itE/TX+SxaCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 614DF40623;
	Sat, 12 Sep 2026 13:26:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3D522E3
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA23540718
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mQd3X6X2OmnR for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:45:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1B0F540702
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789217122;
 b=nZqZ9B94njXeguaqGK3NzHqdiife+UsMO+n8ZEbr+D2L++5bg9E4gJgwkwvcaaw1SORL
 TD7zcwn8UIkC74appeuPPC/cPuQvp5rr8p34JiJX0eEkoU/LAc+eUiX9I4SaPfJeKeGFM
 /++k5MLsYBTUdbPgWCDa+Q2vOklpIX8juv3rAHlm2gz6xdWQHKSI6Y3GgPRl5/+hKoo+k
 QKnahExejf/eajvQL9s+sfQQuFoVvUP4Rkaq1KSz2IWXPdSwjV9nBXoYeRUHA46BGH1Qe
 hCqiJcLsv3mAhGMEHunPClm97dkpdM83YiOhcVJHbLJmJxisOdfTAX5+wrcwhQgKBjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789217122;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=i0RuKv1m9xjoCUCQ866zvYdINqcZYRReMV2qdo13WTY=;
 b=Igo3ZOG5RWiu2QlJ0bza7Mq91lz8oPWarcStOtiASaZVYgpc+V8Lm3oTZEE09FY3YZHz
 0cOn/1sql1ti7iIYlB6u+jAtggsoa0L8UyTRfE7a8/jtZDCAqdZz/mziVWexRQ4YitV5M
 gOgktdXlrRuLQD/xIs8tuHdXQauOqW8l8CVb7FB23UPWNCjWcNY7vonVm8clBxa3CCAIn
 1T3jPGmAvS/RpkIvYxfMoRR4HjHOGVjRE5LaRhIeu0je+yAqBr5H9Oaj02Q9NZ28AWEOt
 z8o3IXN1ME6oT3msSjqlmAhkMKW04qQk18EXel8wf3SeIfIZeEI7YbY4qOPjo+UPkbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=erhXX8fU; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=erhXX8fU
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B0F540702
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:21 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 44E383FE32
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789217120;
 bh=i0RuKv1m9xjoCUCQ866zvYdINqcZYRReMV2qdo13WTY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=erhXX8fUByBTD1wyTFblZgipUTS6TPnlG1Aj2BsJ5CSHcsdgQJe7Fo4ogNx8vxGTK
 r3XtiaUfo2olG/PN0Xwfg/xIG4B2q/igCZ2MzUudUwymixTYLDFVNB+8BQ9I1RX9QU
 I5+oJUOS1O2QO9f1qxzBSoNdHOKUzN4aJ46lNkme3afn6udb4R75XzdshQqoAR9V0x
 CzwvkNChM/TN69wnqkGMMzT0XFUSaPAgymUmAwltwakDd8ikuQIKPzibYJra2HOtBY
 0kZsj/OW8yYHIR2bJH5WCa/FwvXbCnAryN+/az648BZJpffQGz+bZPDndQekEYW7Di
 fP8wbkr+Y6kwiJUtM/iL+wWu4ZAd/o4+49762mUdq/ESAgdbV/nSIHUgp38lzvNYnp
 r6ZDkjm8cDiOEjkWYf2hnWWx7w18RZzfCTKBFIG++BgPRRu5NdTFSl6vbaVaNXVew8
 x95nKviVheKO5aUkBI+ncjfvEdOnIUrAdfXHYbQ+JlE7go0ChN/iIkuW8bhUZX8SWT
 Nq1Sp3mmCYPgdB2E4f/WdmSMVtT8HI/3UK8RJ4UDNVBTFZB4py+v4DuM9ZFgi7GWI2
 UFhog90QbmkjeTQH4kWL2vbn/xTk2xc1sixU6Lxq6buM7byBPMwklWmZ7CssTsiXQf
 FoYN7ShcEN36zDnXO8Zdykx4=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-86a7bb1dd95so2079200b3a.0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217119; x=1789821919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i0RuKv1m9xjoCUCQ866zvYdINqcZYRReMV2qdo13WTY=;
 b=gKAJF8jcpY60E0iMeXdqzkh1dyxYlJ3+I2NGt7jodv3qZiiOyals5gFVQxrJQgoh5w
 wsqMZpY3YLOaXqasG7qwGXhmXbInaeARdruCSql9L5Umcf8QO4Si1uhKBzF3r4Dems1z
 hxpUEMbICiUqogxfcUck/qmDDbYyr6djMYe3xXpQjaELxwM62e6zmH6WdvcLR7HwqGag
 RviS3k9C3i/336tLn3YQw8gsrMFo1UBxVwJ0bkKhR6ZjmNLN5/datD9gEPI5l3MhMk4U
 z/2soWEquaR+R+xg58G4AdM23kxFG4cDa6CAdq2+YND2wpVK5exhoLMZL8mQcbYQug0B
 YlCA==
X-Gm-Message-State: AFuF++mgIp4ksMsxZOSUhP8ioEnujMkrRNStf5tosgkPamt8Anrak7nt
 cqAbMwisFseDillAzRlTdPoMu/fFMQEc++Tj04AXDf9vAYR/hWxpMaTIURy4pUQNibNUEZzHszv
 SEf6TJojK7wFQQ41192NiQKCc2VHxU/HpYSjBq/SnsR338EF3JFAVCDHz8ptI+Mbeqwsh/eFOyf
 O3vw0CWw70Ylunnfh1/Q==
X-Gm-Gg: AYBFou3tnOeQBDpSQHVv54X8a9i8OSAxPKZunIWPlWodr5jnUZxm6e5C+GQ0sbQG4IM
 DO15FiTVnOd2xUaZeD8JlmDk8lKUfTfz+Sr3mkcdRlDYsHjxZFxC59BfypcV1YfOnBnoVIR5uAE
 ecFz81yzp3GybSGvjhqBuaXRFFp9NoI1Efs/93wTMH29K9glPhqQnY953zerS3ZVXWdogv4lJQC
 4V7uctr7GdFNoanl+QVhS/LV69vyixMXIZUeOoWcUuSR3FNU/6jyUZpu80pCh9BmVCn/7edQFmy
 HCoivRSDMzESir74maWZL3sCSxyZjLvXRZbM9dqjfIdYkgCxaj3STdZCB/9pCOJmc0mmovBKDYf
 Kwyz/aoyH1Ne+23sLpm6VLrn4QfvyyKZdrFnWI/Npt2ui/Ja4jym7gqDIrRpS1wQDrQ==
X-Received: by 2002:a05:6a00:278f:b0:861:295:2d78 with SMTP id
 d2e1a72fcca58-869b107a28bmr11934172b3a.3.1789217118435; 
 Sat, 12 Sep 2026 05:45:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:278f:b0:861:295:2d78 with SMTP id
 d2e1a72fcca58-869b107a28bmr11934138b3a.3.1789217117976; 
 Sat, 12 Sep 2026 05:45:17 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b291c5e8dsm2272101b3a.32.2026.09.12.05.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:45:17 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 5/5] test: py: add tests for the FIT image-data property
Date: Sat, 12 Sep 2026 12:44:51 +0000
Message-ID: <20260912124454.13578-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912124454.13578-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:26:38 +0000
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
image-data combined with external data properties, a configuration
whose image-data sharers have overlapping load regions, sharing where
only one node is encrypted, and encrypted sharing where the nodes
disagree on the IV, through different iv-name-hints, different explicit
ivs or no shared IV source at all.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit_image_data.py | 373 +++++++++++++++++++++++++++
 1 file changed, 373 insertions(+)
 create mode 100644 test/py/tests/test_fit_image_data.py

diff --git a/test/py/tests/test_fit_image_data.py b/test/py/tests/test_fit_image_data.py
new file mode 100644
index 00000000000..b74ba1c3f5a
--- /dev/null
+++ b/test/py/tests/test_fit_image_data.py
@@ -0,0 +1,373 @@
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
+    # image-data combined with external data properties
+    result, itb, kdata = build_fit(
+        ubman, 'image-data = "kernel-1";\ndata-size = <0x10>;',
+        '', 'idata-extprop')
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

