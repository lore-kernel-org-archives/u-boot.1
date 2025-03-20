Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2071C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF91981D4F;
	Thu, 20 Mar 2025 15:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I+i40rCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E731181DFA; Thu, 20 Mar 2025 15:00:47 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91AD080540
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff797f8f1bso1331038a91.3
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479244; x=1743084044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T54nDIwoA8JCDbRvlzJtmniu0+agTsuro45ra6icFcU=;
 b=I+i40rCnlbUhP2scIHfPWPGPudMewFlGWMtNa67HcZ5ZG3Tu3jS1QxPKNeu/LH8aj+
 J0gMtg8P3ZmUPRp5RbhhC/3Wes6iH502H038Gtkz+uQR30aVCqfW+jEO8hdGUpjUK0Yw
 bpk1rM3phnnFszPCfI7T93q5ivM+KoWlEurWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479244; x=1743084044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T54nDIwoA8JCDbRvlzJtmniu0+agTsuro45ra6icFcU=;
 b=KdqgUdOUSMFtHCUgEYXMhNyBG5Gj7jPLSeRZD93ALxlwgK/PBaQPe0ybH5O/YJ2mri
 uWNCJqRIPSIRN2YZ8i+cZ3cf0/gWYsdLm9EehoTOTUB12RBEypE25uOfb5DQnwlnJ/YB
 uc9j6nnPvX5/WjOKwqszycTnOxO+BYhcNTb5CtUg98/pHFE6o2pwHOFt2n6V1mrNXV4g
 zFKGXEOK0OYRqEH3MKGqwJLK6ApcXLD69l7dOBD3l6cVIddb+ouFiBvNyW25y2/5VSlk
 vIbRdwKzhVzCZQX0i41ZxpYMUR57RoKqpRUB6BqFABrw2siXS797RBpLQFCxuHltXela
 ajCw==
X-Gm-Message-State: AOJu0YyF/SM0GrRVN1S/sp9QTHGniJXUolV/t2jZnL79Mqe5aplkV+Wt
 RGHySnDzMVkg3oIgekNKpDIVaTpKkDuXBsU9j9baDjmAdQ3vl1DKMLp1rxOj+y5n5fMltd1L/db
 +
X-Gm-Gg: ASbGncvSmurW0XqKjqFiiH8LtbiWAgss3HF97bUn/1Wl1+onkA6SLB8ZhlhTu872ZFy
 srywcotRxTeqY22zuDlwe+kCdgIoD0i/cN2UdeHD4Ngi6IQzV5uNQmYOm/norvXuat7GgAF+9/O
 e5jfHE0uDPp4lRiLnZ7Rq9RjlFbmcS3Jb9L+wV/IRXzCVZv8eiwSbKTxsHjXuxCQt3GB8xTr6hS
 jHfIejr2gOmRxRFNvr2t8xdf/FLZThha4Tbga7Dc/GRw97uBok7L+q1LDgFnI1B7S1HEfpI+0dh
 kjPw+DAq+sX/mZDHI+azHo07tVTnYmyikeTCe2OP/dJ8X/sR
X-Google-Smtp-Source: AGHT+IF1RJg13ZrAhADbgT0aeWr2OrrhrcOcVAejCsCwEkjE8zLoonwdNozWUbm5vWcoRdflQCDbWw==
X-Received: by 2002:a17:90b:4fc5:b0:2f6:d266:f462 with SMTP id
 98e67ed59e1d1-301be20750dmr10618407a91.35.1742479243579; 
 Thu, 20 Mar 2025 07:00:43 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 09/10] doc/develop/py_testing.rst: Update section on
 filesystem images
Date: Thu, 20 Mar 2025 07:59:30 -0600
Message-ID: <20250320140030.2052434-10-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140030.2052434-1-trini@konsulko.com>
References: <20250320140030.2052434-1-trini@konsulko.com>
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
Changes in v2:
- None
---
 doc/develop/py_testing.rst | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
index 40a85380343c..502053f09fc4 100644
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
@@ -64,23 +62,12 @@ The test script supports either:
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
+The usage of the command 'sudo' is not allowed in tests. Using elevated
+priviledges can lead to security concerns. Furthermore not all users may have
+administrator rights. Therefore the command 'sudo' must not be used in tests.
+To create disk images we have helper functions located in
+`test/py/tests/fs_helper.py` which shall be used in any tests that require
+creating disk images.
 
 Using `virtualenv` to provide requirements
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.43.0

