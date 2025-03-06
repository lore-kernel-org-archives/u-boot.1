Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED52C282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4FF80F4C;
	Fri,  7 Mar 2025 00:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pcvliPc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E3308141E; Fri,  7 Mar 2025 00:23:22 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8803681335
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6febf391132so3906757b3.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303394; x=1741908194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxVRtUFCgBWay5y8zGiO/11y1pj4zz5L5t9hvv6mBJo=;
 b=pcvliPc5rVqJxWjCxqTavog0uSHd239b1T6SN6ei1tZU+DJMDdhwhbMx/gfQjVFlFq
 XjskvrjvSeQmVU3QueJzjNamCzlpYsmGudVaAGuUqUJiC7wEAAQUJtcvCFI/rtiZ8AN0
 D0Z3iyI9DJEWj1cME0QJFKQYWYEz8C7IdUehk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303394; x=1741908194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LxVRtUFCgBWay5y8zGiO/11y1pj4zz5L5t9hvv6mBJo=;
 b=V/eX+qNKgyG9D4I6Y6xtftoLTACf+PShi/MYGzbZRdfwcyFLckBx8VX027SMwZjYtp
 Bf4K4CYkEEBAPWMatsQsbnFHJz3jhr7M3scQQD9yX2/EbJa43Zzv90i093wbCfpTv77a
 0nRNuc2kKp9X99UIKnRqNvEdK+OMj1mTXpHuhUqbu9/pq00xvMOhUMZQdHCd1OlXHcZb
 crlmxExSx3+8ZVgqW0x8XfRfjPGZp+/16FDBjNJKHrcpni9k8M31fIwvupJ7jA2ib/2a
 btrY7UGjmDpBNjBD4zgzjITpQIdFWx53QTN5e20FLIyuLfY17n5Gr/DjmvyNkeQ77qLp
 kh8g==
X-Gm-Message-State: AOJu0YzuSmWk6xy7xVR2cn3pV7GroIasX3t3AnBLezB9mdm+ls7sKoc3
 DcGbo6RPXZp8iS0ZlbEqm5EZ8E9d8hSIFvQkz44t8piw2S8D+29iolCmDgvk+JeTlHcn+Jprl2x
 x
X-Gm-Gg: ASbGncv44wCdLYUPXy6s7YoNkkUa2/GnSiBGb1a32rKDKJx4ar6WjL0ErTexGh7vl8A
 vPqn5L3ctWMIsyHbU9vPF2jA+fUhzKfMSkGJYQSIQcS5N7FUi2AOKgnaotVcCUzXvyop5vkhgj7
 v5w6y0ehQRnaNpltl3IXLoZ1/tUnzJiJoPkH618yiocwcf9gdPwiUdK5BUKkXCq1JfMXU+XonsA
 AAPPo7I5OE4HxTdMxRVNOvnzlbvCKHOGHE+f2OOGN6cGLRkW0WfrhFKvA64UcCVOB/fTEuz2bYC
 iI0/z88ADWCNfJnkOxS0oI8AZwM8BPJ+YakYUSOt0oc6pumk
X-Google-Smtp-Source: AGHT+IEf5l24Ri6ShLKpVF1ZYzMTtAtycbhSyGbpIH1WUnL7QsH6tludU6gZvsz56+t7IdFo8vJEuw==
X-Received: by 2002:a05:690c:4c09:b0:6f9:7f1c:5390 with SMTP id
 00721157ae682-6febf35d000mr21112737b3.26.1741303393946; 
 Thu, 06 Mar 2025 15:23:13 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 09/10] doc/develop/py_testing.rst: Update section on
 filesystem images
Date: Thu,  6 Mar 2025 17:17:11 -0600
Message-ID: <20250306232256.4150882-10-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306232256.4150882-1-trini@konsulko.com>
References: <20250306232256.4150882-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Now that we have no users of "virt-make-fs" nor users of "sudo" for
creating disk images update the documentation. We remove packages that
are no longer required (and related text) as well as be firm in our
wording around not using "sudo".

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/develop/py_testing.rst | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
index b50473039be4..ea1329c44b17 100644
--- a/doc/develop/py_testing.rst
+++ b/doc/develop/py_testing.rst
@@ -41,13 +41,11 @@ will be required. The following is an incomplete list:
 * dfu-util
 * dtc
 * openssl
-* sudo OR guestmount
 * e2fsprogs
 * util-linux
 * coreutils
 * dosfstools
 * efitools
-* guestfs-tools
 * mount
 * mtools
 * sbsigntool
@@ -64,23 +62,9 @@ The test script supports either:
   physical board, attach to the board's console stream, and reset the board.
   Further details are described later.
 
-The usage of command 'sudo' should be avoided in tests. To create disk images
-use command virt-make-fs which is provided by package guestfs-tools. This
-command creates a virtual machine with QEMU in which the disk image is
-generated.
-
-Command virt-make-fs needs read access to the current kernel. On Ubuntu only
-root has this privilege. You can add a script /etc/initramfs-tools/hooks/vmlinuz
-with the following content to overcome the problem:
-
-.. code-block:: bash
-
-    #!/bin/sh
-    echo "chmod a+r vmlinuz-*"
-    chmod a+r /boot/vmlinuz-*
-
-The script should be chmod 755. It will be invoked whenever the initial RAM file
-system is updated.
+The usage of the command 'sudo' is not allowed in tests. To create disk images
+we have helper functions located in `test/py/tests/fs_helper.py` which is to be
+used in any tests that require disk images.
 
 Using `virtualenv` to provide requirements
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.43.0

