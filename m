Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5023CE8FDBE
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 23:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C167983B4B;
	Sat, 27 Dec 2025 00:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g4tQcexk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80345839E2; Fri, 26 Dec 2025 18:55:26 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C17838FA
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 18:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7baf61be569so7716279b3a.3
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 09:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766771723; x=1767376523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rh7gudSFuPfmQzeA7ZOkJGax7cWs0jx6PVo8zTUOtp8=;
 b=g4tQcexkrzyD1NdbfCAaXKchXW72i5HI2/v0ysA9m02uBSyEECaQy2hhjPXyt6u0gA
 4vN/yNsgoUG+6N/7uyd51rAvgxeaJ/VOtI7qmgXlsfgKT7Y15MiSGIO/hSXzTTYqFg2i
 33NNgv1QzmJR29rrrAbeVga9biS/vRom9pyPgHswTmUvlPVu5x4nZXwkyJuqHo3dtj6J
 02QCFYI3VWCpZ3zhbqhMYcZK9+B+GGIBCU50oJCxkod+mvgNCBiVOFFeJcC2S6omZjzR
 bNkuPDBB99ZlXjhrJ/j3Y1UsQPptzaa/y92Ajxl/04HEv7cauzkv6TNiw5F41nNCqiAo
 8Hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766771723; x=1767376523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rh7gudSFuPfmQzeA7ZOkJGax7cWs0jx6PVo8zTUOtp8=;
 b=o2VaDdAVrzP18raqGMnbQDkTL3h9d0pepPYkIeQn6fCKw3yQo97ZGwFuEJOaP3PaYl
 WLR5C71chIH0MGSZabaijHWLAiby457E5bzq5qDGyDg4DczSyffgo4Ph/uOzitlDwM4a
 LT8WxfjRqc1niYhLgqSkxuZTP74MDXX2DkeQZtpmQcm8bpehxMyLIFp6FnMwyF7aAlUf
 +il4y9zfNOGDNA3m0muSDqA9ifSy653aG8wWUdtxWyypMQwokU9gMHjEFJkhuW1Pi61z
 hcxuIvjwUOQSlJWRkORkkukcDHTkbs8VfE59hEz9xP/SLhFNNjR4PM3Fa+0gyXFndnV2
 LP2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwRQOL6y5h1m9gH/ad8BXrFJKzBGQ8XHG4M/4fv6zN03oVherzzCegLbSDB+zdT774xK34WDw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6hLbFodUbRlUkl4prfZBBbH9GvzVJeow/veF1vX7vGSMbv9dD
 ucGyt2galcHdvR+dfR/KTR+/fvKcdGE4q0B1K0/hzytIzX5n2NHRFPNR
X-Gm-Gg: AY/fxX5KOfRHxU36wNY7IfBKRBIswQf5Czs6oua11CLh+bNhm0YSGe1PGmMTpxtT3s8
 xNjbta8krG58NpOMcHEVdiLdbx/UeSF+eeTR2eRkKKYeVEXKYbv+fc45Y67OEBh0cOIcmsTEZOC
 FVEHKInq9a8UBHwWxtqXwH54fybPP++OrHYpMYm/Gs+vhVFSL30BbzclXg+7y8CRtyboIATQ3Sz
 mYlCNCHb0GjZzsRN3Lm5xpwOzHL0X8/ibDF+JlLae7g/+3nXMh9C18AQiaznYqlq9iF6IvOcgR0
 61GjfQiUC+ESqOc5wdj5mztPZ6Mpy9X8SDeNISxqNQqsGSjomUwVAwl3K7U38lpqBFqMe6wuefQ
 6yjptVeaCiiu+g6we/c7jorWc9AqEVgP09tLe4FiGx4SxUXRmMtbpnkk8ROtLorNtgfDbcth6Ek
 45yqJ1F86HwrDTaPcjaVAnBeCWJF8rHUWYPZhOWblJr+MhkVv6PMG+juSb2ft8JZI3Exu3w94Y9
 WNhp1SZsRBVpUMjbP2Z5g==
X-Google-Smtp-Source: AGHT+IHF7j0hOA8IdlnA2t3GWb/KbAQ/AhwQUVQiUxWjCfeNjhorDT1Zj9GfoNZttBH5xltX0+JmUw==
X-Received: by 2002:a05:6a20:748a:b0:340:cc06:94ee with SMTP id
 adf61e73a8af0-376aacfe565mr22044175637.60.1766771722763; 
 Fri, 26 Dec 2025 09:55:22 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70dbc9d6sm23853898a91.10.2025.12.26.09.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 09:55:22 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org
Cc: trini@konsulko.com, me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [u-boot-test-hooks][PATCH] travis-ci: Add config for QEMU m68k virt
 machine
Date: Fri, 26 Dec 2025 17:55:12 +0000
Message-ID: <20251226175512.1154919-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Dec 2025 00:03:47 +0100
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
 bin/travis-ci/conf.qemu-m68k_qemu | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 bin/travis-ci/conf.qemu-m68k_qemu

diff --git a/bin/travis-ci/conf.qemu-m68k_qemu b/bin/travis-ci/conf.qemu-m68k_qemu
new file mode 100644
index 0000000..311177e
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-m68k_qemu
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

