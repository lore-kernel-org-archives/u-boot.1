Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7FDC982FF
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 12:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D38C140CB9;
	Tue, 22 Sep 2026 12:47:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A8Dy21xXTB_m; Tue, 22 Sep 2026 12:47:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E41740C03
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790081265;
	b=osDzRDcS9ZutDd5x/iF9Q5WM3eEl6iyGIs6vTUgN0DYgO8dRm//PeOnm0qqhw7Dt7WLI
	 2x5r3tOmq8PYDOOTE/VuF1H/h+5F235aUdXNUHNJZ9DO2Rtc7BoX51Z22nb9QNDBesvcj
	 HJfwlymscMixFZXK/vMmP7F8PucpY0dC7gvRiBj+0OSlje5w01eXvrQ0w/0Thrxm+JnO+
	 biUc9of99gAxApcePvpp0OPUXAZeRTIFlLQMvneFY/HaMbh9ZoDavaj0muIZiP/NhqcwC
	 7vXN5ZF7ZbpxB1geO7VoutFwDoarYEdjdV4sxo2jR8IU/0V8TRFd77d+74t5sgk69rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790081265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fjUrT4QL5gYpsbhd/fYkJwe8r4xtkrb2SHi6UmJIbKs=;
	b=tIpjy1x8GTW0mYFsP1EBGqQ5ZeijZnq3Pl2neyzyGJq+ntOm9JelBY7vHmjg+gEpjuKl
	 mzYyeNrzfW5WM4l8U/mM24sR2Qi9f/YauVJwbK3wbO+Pgm44IwHgrIzvW3rDcEFKtkX0H
	 ss5GacY8fnVeQ0u1m3vgtSAXy2P4mDCC3knk6ln2F9SAFXx+Ef+QCq4lSn47LXqjFhAaq
	 zhTHnzxWfqf92p9ZUhDasPj9sHILjES/6I0Nq6i/pH/2dX2eClF0S0XU86SaVrNFwRnPS
	 EaTxHXTO4XtlnEAkCm+wus6V8QAhtpsmV6Mp0TcNah/tLkUfXp3qiFO91JV1DFNQ9hQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790081265;
	bh=fjUrT4QL5gYpsbhd/fYkJwe8r4xtkrb2SHi6UmJIbKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CFbEXmFf3WXT5RnPiOqO5nRB0GSrjpt7fIx6HKSY0ZSyPErfB1ATuDcO5SHNcSAvC
	 xASMTdVEYfoMFnD4m+MPXp8CNDQqTZZpoHPTmxqIbVrX1IwF+6LsxScniMhSW80ojd
	 hrs+DhSnwC+9w4r+UfXcM/Y2GnpVFw11LnT1X6U3yXt8SP04CsGfgiqcdn1F6S3AKw
	 lKFXk/yR0B8a/aNVKhKTGFXjBiiZ5UUEGToC3m46iRmV9j5HF8oN0XLd8sWLbDYSeZ
	 aqMLd4ve3zRKAB/nZr/BfhC6jXjuhmC3Th89KFYvLuM2RnyEQ1a3aj9O0VUgYBPcPa
	 7qbkICK8A2tZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E41740C03;
	Tue, 22 Sep 2026 12:47:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 38F0E3A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F08C6077D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 77HW7tSeyc9G for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 12:37:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0BCB660737
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790080632;
 b=dVsQZvc3k18Njw0rI1tNVXDoqbCY1r6uKeBYfGui2VspAxe2mFP3/ZGpYYg2aNaZVKl/
 DZHNXmpj7AC8B7baYxXEPKS/LUUfjij3oU/v+SuE3P13YJskrqjVc2s4RDUDqX+aJz36Q
 mRyc89q71bQ+iageGghA6CCkHHzZCOj6CMXn7h923j9r5VJuffqBQLbjC4Pwf0btmfarr
 syuv5Wd+ceZA62itrXPbTy5/ix4zNCyr8wtrTduZ8/yUlD55xlbcFVL5kYlGB7tD+H1bI
 f+maVKECHzgzyUJVF836kYo1Jl8yRZCZKt9T+C5zQM0Hub+Grel9LomAY8JJ+LzhZKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790080632;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=fjUrT4QL5gYpsbhd/fYkJwe8r4xtkrb2SHi6UmJIbKs=;
 b=RLNEWK9RtF4Mjkv01r3+6J3I/NB4C45MZ9YD0u8RjcJC7ZPWiVvmtJgNTFs5cb/oW6Fz
 inEScVNJxjbToM5q3HGpAN6dTvsJuN9iG050UWkFv5g8B+wG85FbQ/r415BEvlwkpY4HV
 o+Dz84ZebnWJ1tbRpiJ4Y9mDa079HBzO7CQp2V9mn0uFAoC78plxl0ylEBt3HG3XeLHvL
 Qxl4qKnACkn8hPhUXylBnNsnsZ9nTgvV1mOPjwDeJvGPPd5h1rCRY+WaUG6I/945VXYlZ
 Qy8KI9LH0ABSFBOEWqgt8BYsmjKKO3kM3yS3zww1YHxcNV/StSBtlIaWmmMQfZGtcIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=ozI5+BQj; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ozI5+BQj
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0BCB660737
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:11 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D47833F2BE
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790080629;
 bh=fjUrT4QL5gYpsbhd/fYkJwe8r4xtkrb2SHi6UmJIbKs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ozI5+BQj1yZ8/ICGuRIrKFh3RYkZuHEbfE+3BxuTCGctBJQf9hHVjjvHmwr7oqPBf
 OA2rs/7utyZEf8N6Xq2QjgMxMRibxFkPU/hZebKFHNtawGFxIeIrnGGqsEoJc8TB5a
 9faj8+nC0liBoj+9Wj+bQcrPnwV18ZafYYXORj5Iw0bLo9ezmz1NQFwsjcTtuwgom+
 BHD4No9uhy+ZmyYQBEaAxADw4v1mr3A/plAwFyv8IEogV4a3fnihxNRebjV8JZECFS
 fm90M7+y0z8sgK2AVqXp0zN3AgAHKqfCJR+73nCnHifa4+3V5dK+hG7j1WMlMK5vII
 CzBWDVDFFnWD4pi9goqWx4+c0YXCNVDT2U8I7uyxceY2zKwn9x21Azpy+sDRb8n22Y
 48RVbwvnk6LuQV0C6PYEZOnLjOnmOnBXf+hmLrPr1QCAPkriD4Dzw0flw5NFrt/P8U
 2ZYeapD2qkCxPy2+JkfA1ib8j7Jimqb6U8ZGSK5xHjos3hG+5YTHOvhj3T6vWcM/wK
 Y7TLbkzeUuA6iXIlQdA5GIqAPqW3oO4UGv+8tyA7CS4c35OHPfsW5SUKY4d6rV/M86
 2aMbZQbl3qKsycz+0sDnI7sZ773xcPb3XZJVr1GpFP1O18EOw/gkqlOYa9BtrLdSo2
 NP523zJe7CYD37VOguS/PYEg=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d9336581a2so70190045ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080628; x=1790685428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fjUrT4QL5gYpsbhd/fYkJwe8r4xtkrb2SHi6UmJIbKs=;
 b=P/GAUT+TxyoBLJ/lEqEAwAjWgtHcBSIzMp5gn3UM46YUzod0LwIg40shd1ZJWIj3hx
 siVhzkCaOrHATMnSagNIEj31x1ujrkvsTbCNvxLB8anxvN59hilW6XWsHdvY6m5tpKcf
 qeH6R43pRhG6JSFqCPX/HcPSpuLKfTJTSWg77DxL4e2ubAcKKsDIXehpUCXxgHOIAjdU
 iyuGBYUkTwrNrX5ZSUUHCeBtk0W3oUYybb8DBkz/oPoO7IWQ3gIyfDARPd7QwdKarNe3
 iFiqQC6dIgF5T2egfqH2EAPWESgC5je2ADFUqdKqxUJ+cy2bGTGVig5YqzJKGqW4i5Cs
 7xaQ==
X-Gm-Message-State: AFuF++k9vJWC/pjjR3h+sMorUdLI2fP4HAu4182zM1Xa4YtfxRXNVsu7
 SuHz0+NVQDytV2FCbxDYfCOtkOx6A9qiV9LmdMLLSNYKKaZ5lW2LvWn3DTunPikxbvGG90ROq9u
 9HCBmg9kD9bIT4/VDQ+Qtyc8LZNQFNeAspltEh0erqUeQhQ3+Xl5o5TWTZ67i8agHhg3M2os8Ru
 oLThZbkwlh0Sx5YkrxaQ==
X-Gm-Gg: AYBFou0NzVwZdiJL3xPQxjeDPKs6TMkZ268jMWSyEVk5+4hqnHed3LUmCU7lKZ+sJzf
 ZY3TLpPpz3t2nw3x5gqQg5ZfYRwYn4IJNndHGq42/2UB6Im+RJdQVoD1R+VMJUnE9zV7/3I+8s7
 yje9e71MFVC2qX0yK00SlF9D7b8Cinc5i9QuzQy3MzcdI8O5lFm1MPr50ulKaX21L+C41F3gf7i
 7T9MmeSCPZbWOyoFvvi/qw1oO4Ym5evI08H3pAMNwkNoIJjC+1ZWfZAzlAl3Aeps9INFQOA2R4D
 nNpdNhOaALzeGPzrWb8OFeTOv+djG3X8EhfScDy2HDiXn9jELOSctQ7fKWYVkWvmlRAIuc9vzL1
 3f/MczTiC0fehZD3tCdoDZI1BcpascFXnDQ5z4/aOKyS4fm0mFJmERH2CHP/4vg==
X-Received: by 2002:a17:903:94e:b0:2db:2413:87d2 with SMTP id
 d9443c01a7336-2df609ac3b4mr12477455ad.4.1790080628025; 
 Tue, 22 Sep 2026 05:37:08 -0700 (PDT)
X-Received: by 2002:a17:903:94e:b0:2db:2413:87d2 with SMTP id
 d9443c01a7336-2df609ac3b4mr12477145ad.4.1790080627594; 
 Tue, 22 Sep 2026 05:37:07 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d058116sm9054105ad.77.2026.09.22.05.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:37:07 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 6/7] doc: fit: document shared image data through the
 image-data property
Date: Tue, 22 Sep 2026 12:36:26 +0000
Message-ID: <20260922123630.608961-7-aristo.chen@canonical.com>
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

Someone trying to shrink a multi-board FIT has no way to discover the
image-data property from the U-Boot documentation, since the format
reference lives in the external specification. Add a worked example in
the style of the other FIT example pages: a kernel offered at two load
addresses by two configurations while the payload is stored once,
together with the rules the producer enforces, the resolved form,
the interaction with hashing, signing and encryption, and a pointer to
the specification.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---

Changes in v2:
    v2: new patch

 doc/usage/fit/index.rst                  |   1 +
 doc/usage/fit/multi-with-shared-data.rst | 114 +++++++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 doc/usage/fit/multi-with-shared-data.rst

diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
index d17582b1d64..ada69d3adb7 100644
--- a/doc/usage/fit/index.rst
+++ b/doc/usage/fit/index.rst
@@ -21,6 +21,7 @@ images that it reads and boots. Documentation about FIT is available in
     multi_spl
     multi-with-fpga
     multi-with-loadables
+    multi-with-shared-data
     overlay-fdt-boot
     sec_firmware_ppa
     signature
diff --git a/doc/usage/fit/multi-with-shared-data.rst b/doc/usage/fit/multi-with-shared-data.rst
new file mode 100644
index 00000000000..f7413dd98f6
--- /dev/null
+++ b/doc/usage/fit/multi-with-shared-data.rst
@@ -0,0 +1,114 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Multiple configurations sharing one payload (image-data)
+========================================================
+
+A FIT that supports several boards often needs to offer the same binary
+at different load addresses, for example one kernel that board A loads
+at one address and board B at another. Each load address needs its own
+image node, and without further help each node carries its own copy of
+the binary, doubling the size of the FIT.
+
+The 'image-data' property avoids the duplication. An image node names
+another image node under /images whose binary data it shares, while
+keeping its own load, entry and remaining metadata::
+
+    /dts-v1/;
+
+    / {
+        description = "Kernel shared between two boards";
+        #address-cells = <1>;
+
+        images {
+            kernel-1 {
+                description = "Linux kernel";
+                data = /incbin/("./Image");
+                type = "kernel";
+                arch = "arm64";
+                os = "linux";
+                compression = "none";
+                load = <0x40200000>;
+                entry = <0x40200000>;
+                hash-1 {
+                    algo = "sha256";
+                };
+            };
+
+            kernel-board-b {
+                description = "Linux kernel at the board B address";
+                image-data = "kernel-1";
+                type = "kernel";
+                arch = "arm64";
+                os = "linux";
+                compression = "none";
+                load = <0x80200000>;
+                entry = <0x80200000>;
+                hash-1 {
+                    algo = "sha256";
+                };
+            };
+
+            fdt-board-a {
+                description = "Board A device tree";
+                data = /incbin/("./board-a.dtb");
+                type = "flat_dt";
+                arch = "arm64";
+                compression = "none";
+                hash-1 {
+                    algo = "sha256";
+                };
+            };
+
+            fdt-board-b {
+                description = "Board B device tree";
+                data = /incbin/("./board-b.dtb");
+                type = "flat_dt";
+                arch = "arm64";
+                compression = "none";
+                hash-1 {
+                    algo = "sha256";
+                };
+            };
+        };
+
+        configurations {
+            default = "conf-board-a";
+
+            conf-board-a {
+                kernel = "kernel-1";
+                fdt = "fdt-board-a";
+            };
+
+            conf-board-b {
+                kernel = "kernel-board-b";
+                fdt = "fdt-board-b";
+            };
+        };
+    };
+
+The sharing node does not include a 'data' property; only the binary
+payload is shared and no other property is inherited, so type, arch and
+the other fields must be spelled out. The target of the reference must
+not itself carry 'image-data'; chains of references are not permitted.
+
+mkimage resolves the reference while building the FIT. With embedded
+data the payload is copied into both nodes, so sharing pays off
+together with external data (-E or -p), where both nodes point at a
+single copy of the payload through identical data-offset or
+data-position and data-size values. The 'image-data' property is
+retained in the resolved FIT as a record of the relationship, and
+re-processing such a FIT with 'mkimage -F' keeps it intact. Each node
+carries its own hash and takes part in configuration signing like any
+other image, so verified boot needs no special handling.
+
+Encrypted images can be shared as well, with one restriction: both
+nodes must describe the same ciphertext, meaning the same algorithm,
+the same key-name-hint and an explicitly shared IV, either the same
+iv-name-hint or, when no hint is used, the same iv value in both cipher
+nodes. mkimage rejects a combination that would produce different
+ciphertexts, such as leaving both nodes without an IV so that each
+would receive an independent random one.
+
+The full description of the property lives in the 'Shared image data'
+section of the Flat Image Tree specification,
+https://github.com/open-source-firmware/flat-image-tree.
-- 
2.43.0

