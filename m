Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8A8C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F203983285;
	Fri, 23 May 2025 15:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UXckkG6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B5783108; Fri, 23 May 2025 15:08:00 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7301483108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3a36e950e41so3742181f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748005677; x=1748610477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmhl0qBBb5KVzhEg+3TX9DwiMenE2I6PV1axrSxRMn0=;
 b=UXckkG6SSEHlS+Be7ez9d65UHEZDBSBVzNdN1uer5jSIdw7XYBptBBayinvkHeUEw3
 ZJZ/th1PNZrPsWV+8jncXz/mxf9ruCP7PLg3Bwwx8yzW1f4uItUBqZKpSWpEdTw3HfiW
 GkBsNyzMXPOgFiR1qUCNMbmFA3IfgyPEGMCAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005677; x=1748610477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmhl0qBBb5KVzhEg+3TX9DwiMenE2I6PV1axrSxRMn0=;
 b=OHBY3+uYSbYJSVnqTdXe0K2srw2IJD0YbW71jg5XdbqVlhWACkRb/1fricQkSEePF1
 tgvrDRtTpxfhDc4+CjR1fu66UBda+NAw7PNkcuM2lvDijeFwYYxQ0ywbFPkUg0XkE5IT
 2jMDfTTBlnKTmavh0perUuXrvIi2ZMENQCmCcWhrgHhV/2usKVtDI1HAguyUlQR3AyBq
 jwYzDLa0YaRPSAz8LkIFrcEW9AiYgxXmzrHwkUbDiYZhpo/qvgXrwMDrohgPkUAEufyv
 O0ZJ2/mf5Z2xcB7k5wu4bcHykwPazNEX3Sq4XisS+kwbXVc6qsXC4ujcXgm8HNgh7Hkb
 WoQA==
X-Gm-Message-State: AOJu0Yz6NwUTl5Q5ukKVcqJ3qOezBQ8FRsehTcXTIr6vFjJ9kLKpSKkM
 Kp2AnyG9kp017AfpK2GiOotAzh06oAmh1nG0AmVfGEzbmYX7B9XRRZVIpi/eaS+sLdXes+S3kTo
 gPQbUwp/+/To=
X-Gm-Gg: ASbGncsQrOcpIasQnfNYkoV/r6uXqxyBfSyqyKVwEnyGj65CiVVGUbf+ZU5EWmUXwph
 reFTeztMIrmIY4sJ1XCSxnpc5MmFGpot19cMHA4a9BKNYwNZqWaWYzB++z9Vab2ZJwvmMYRVBLc
 PBgRLlmWDRSxhNa4koNcIyZq1Soyz+SUQ9loYNnIpH4E3sBGYAAin+dgbCujZDdGgowaoIJioi3
 n4loJdMfLKdWVrf2wxTSpPdl9Z6G+HM9BfIygCOe8F/eYZ9bPGEKO4WydkrxaP3AAA3U/e3Axro
 4vHdJAlQb2b5rc6MJehp9jqSpuSvqJ0RrUxCie6QtFl85e0+ApyKicj/Ek7IMbdPNNSmShE=
X-Google-Smtp-Source: AGHT+IFZFb9vlbpoRxNe2PeszzSHM0q2O8BCwf61Fd0QCGjih/eUtJ9doMl8jUABhfXPcGqPOnJSEQ==
X-Received: by 2002:a05:6000:40cf:b0:3a3:581f:9af9 with SMTP id
 ffacd0b85a97d-3a35c822085mr27846803f8f.7.1748005677338; 
 Fri, 23 May 2025 06:07:57 -0700 (PDT)
Received: from chromium.org (82-132-216-100.dab.02.net. [82.132.216.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm12109241f8f.100.2025.05.23.06.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:07:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/10] efi: Adjust copyright and mention constant source
Date: Fri, 23 May 2025 14:06:44 +0100
Message-ID: <20250523130651.1329593-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
References: <20250523130651.1329593-1-sjg@chromium.org>
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

While the file where the basename.c code came from is marked as Linaro
from 2020, commit [1] was based on Heinrich's email. Also, [2] and [3]
were my patches. Linaro is not the copyright holder and none of the code
is from 2020.

Update the file accordingly.

Link: https://lore.kernel.org/u-boot/2175cecb-a392-5107-b932-b099ec21d62c@gmx.de
[1] 4e65ca00f3a ("efi_loader: bootmgr: add booting from removable media")
[2] 3e18860e3f3 ("bootstd: Allow reading an EFI file from the network")
[3] 7506c156699 ("sandbox: Report host default-filename in native mode")

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---

 lib/efi/basename.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/efi/basename.c b/lib/efi/basename.c
index 4d6eb41cd90..a01cdf1f5fa 100644
--- a/lib/efi/basename.c
+++ b/lib/efi/basename.c
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2020, Linaro Limited
+ * Copyright (c) 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
 #define LOG_CATEGORY LOGC_EFI
@@ -12,6 +12,12 @@
 
 #undef BOOTEFI_NAME
 
+/*
+ * The constants below come from:
+ *
+ * https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml#processor-architecture
+ */
+
 #if HOST_ARCH == HOST_ARCH_X86_64
 #define HOST_BOOTEFI_NAME "BOOTX64.EFI"
 #define HOST_PXE_ARCH 0x6
-- 
2.43.0

