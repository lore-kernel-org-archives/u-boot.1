Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057B2EE498F
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 16:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4442283FBD;
	Tue, 30 Dec 2025 17:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iBPuQsyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D0D83F82; Tue, 30 Dec 2025 17:07:11 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD79383F69
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34c30f0f12eso6847551a91.1
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 08:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767110827; x=1767715627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PYgUqLmn6sTf4SxDzcFMCi7Vj82DksOCe9o/8Em+Xno=;
 b=iBPuQsyySfHBzAt+r+WplLPq5Z2Lfb/WOS857pY3XEWrfYj6jOqM1fGR1alvA8Kt5y
 IACfSEjwEli/4aikMoW1oVndCnY2Qdqq8IZC8KXup37XKCoPupqHIXXCYU2YvKk0onAb
 yodK1Ykk2ccjlBIK0s9HHXRqJjeQi1cwZ4TN5ZgehFFQN4UKnBvNnlxOHNhSo9AxRMZW
 26n0mZDAmsjTFMsdPgu/1aps7S8Kj4kH98DoRJY30JGd2+TPHvQVdu24NpMVj8ZGCRZp
 WinxRRHXYofkN+Z//1UYGxcqHGOwDXkL59FufRzi+hoEhlPVzwDw8qPiZwC0bNBxIFdx
 9bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767110827; x=1767715627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYgUqLmn6sTf4SxDzcFMCi7Vj82DksOCe9o/8Em+Xno=;
 b=t4968ECozdx8XUJ58wMEIgrBxsHke8efJ39Ja4Tq+hlgs11YQq6MeoO5ceyHLrYDi9
 FWGsUGn6oi5OEQzZ+tH1TdERfkm7OPrQZHlXop/f/7YCUJhTCl0rulie0bQgZsAqOXgp
 w4NJQrmLH4oLmb0PlkX+mMp4gPp/NYSHza8hsgnHufuLwEJS2FfJhOMt32PvBabRcHB6
 Ye3MQZKje6Dty2xZb9pU/JnA+VQVkFHx5tobS9AnKxoPH6oPHD4ifJA99/Z0nXbGe1KI
 WXis3ikfxD+zZIrYnmAgY9xx/+0LYePjtRXBBYUE1p9RKyW5z0C53t2QmQ4JkhE9oIu0
 5NQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1npg1FdBnJtlsJ9+lVL235tJHiChbq1PURP1SepmuSik45WT2tpZzRmZK2NGz+nK6xGWLY2M=@lists.denx.de
X-Gm-Message-State: AOJu0YxF04pa0UYKZPIFTGK03kanQb4IBYDnIl+Xf7yA4AbXmWaTHyDI
 J4jqKvk+le24l+UQskkpFQDUuRqc66w19irFp72pjU80ft1vAQtbrml5DWEqcg==
X-Gm-Gg: AY/fxX6wRL1RqcmG++8kLX4hq4z+UwQZz8YFNsC1/R60uEQAGQN52NykRfsmeDVj2E5
 qwgR53qLHiVEWaoYtAB8hi/FjcDtHn90oNvomiDOZQ/bm3Eg9RE1p5osxVytXsXe1pY4T4wYWoN
 6Z5ltZJdLVUgf9c+bI2T3G9WKOPDStwA/d0VW4FpCIG6FPhSlbIQnuyT12olnVtY8WXwUhu/WFH
 6dn4vrsVhi9lSq1sm+I1coUv/sKc2e465K2dRsdW0fAo2bfrf2sqBjxZWOVYHBruw/CTZY+8C0t
 iLuwc+wAa0qzrmrcTaKGcH10H2e7X+NwALB5gdvbzSAkVAzvGGP6igiDLuPIY/KOKd9Oo4A0hF2
 ilcdsbdWj1HuXFMVD4sKijTQ7OWU9QddW8B7iqEWhdkkM7GY4t1JWEvHk+EzGBVCUnXpBmtTz+M
 02m5hrjIHaZ06UD/DZdcfj4DFxH9Fk46VdhF+yzPtrkzeS2nvgqm35mc0nRUWFP8h5hnoUGhdFu
 6o2buHR3HfxIzfIShWMsQ==
X-Google-Smtp-Source: AGHT+IE4hjig6Q1YjJC+/sCI7J5vtJMpDwPUF46sP50N4UnYrRiCR/QB+aNVM6gbFi3EE3iLWDcbGA==
X-Received: by 2002:a17:90a:d890:b0:34e:5516:3fe3 with SMTP id
 98e67ed59e1d1-34e92129ad6mr28445841a91.11.1767110827224; 
 Tue, 30 Dec 2025 08:07:07 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e92227da0sm31113193a91.9.2025.12.30.08.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 08:07:06 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [u-boot-test-hooks][PATCH v2] travis-ci: Add config for QEMU m68k
 virt machine
Date: Tue, 30 Dec 2025 16:06:51 +0000
Message-ID: <20251230160651.3049301-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Dec 2025 17:55:53 +0100
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

Add the configuration file required to run tests for the QEMU m68k
'virt' board. This setup uses 'qemu-system-m68k' with the '-M virt'
machine type and '-cpu m68040'.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Rename to conf.qemu-m68k_na

 bin/travis-ci/conf.qemu-m68k_na | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 bin/travis-ci/conf.qemu-m68k_na

diff --git a/bin/travis-ci/conf.qemu-m68k_na b/bin/travis-ci/conf.qemu-m68k_na
new file mode 100644
index 0000000..311177e
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-m68k_na
@@ -0,0 +1,28 @@
+# Copyright (c) 2025 Kuan-Wei Chiu <visitorkcw@gmail.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-m68k"
+qemu_cpu="m68040"
+qemu_extra_args="-nographic"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
-- 
2.52.0.358.g0dd7633a29-goog

