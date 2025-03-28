Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85417C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5236E81DCD;
	Fri, 28 Mar 2025 16:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cy1OkG5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 548DF81DCD; Fri, 28 Mar 2025 16:44:31 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E7B481E47
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85de3e8d0adso40909339f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176666; x=1743781466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRwbzYnfli6BUUI7qOqmRRUXnRyk6x4BVl359yabxgk=;
 b=cy1OkG5AGyMYxFhkWOkJSZLQJnpZHhRxCTBGnK5s9zmhGR/Lt1xtqYZBVSLKzsIUTY
 ypwKc8HlwOKqswv/LAXeAfIa4j4CAqWt5pnCdxgxuvJ8IhhXbe+QT1T3sC21rDwZmfrj
 uXFMFHUDyG7+mF/6uWRrLrABhfnfOaTzap/UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176666; x=1743781466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRwbzYnfli6BUUI7qOqmRRUXnRyk6x4BVl359yabxgk=;
 b=djbLpvly+qBcE4gujH4OVmpQziwMEuQ1zx8y/VKus32k5nmk4sAOAKsC2XEx+lNWEF
 RcwMXen0+k8fRx2q1eL91nmO9er9AFuiWFuZo5p69U7qDUG64CzwFyTWrRmYi+nuAa1o
 TFwDoBGUh73urzS+jh/J1SbrgGaHDvNAKr9HGbWJNjT5lqovmzZXF3EgVyTYZIJ7Yynf
 kmq/FgvenbL4LFo6bVuIXY54GW+xRvZ40Er8suD8jb4YGGsDjrj5foefsPaR16PadgcU
 ke99gLhnY+sBSfIGxsR4MBwWLDFMbyo3rz217MYKE1O7wWEmnDZ+qQ9NnC3mBKgt6HE7
 B9sg==
X-Gm-Message-State: AOJu0YzBTUWOQYbtRL4Yr+BNhAnIqNu8Pq9KgdW5P7m/+jUOTD0Pif+9
 gIWkINdPx2bWmntqqzU1Uy3SAG1XKggbqlTz1mh4K74SdCh3iBw+ED/obZ0JaJyPTaaGL3dMz1E
 =
X-Gm-Gg: ASbGncs3rlURTlnqQQCuhTx+CYRf5h5Bh/9zXBSD/ueI0K1MR/IvCRG6OX6lL47VsjK
 7wR/XDgsprU6x/72/4Mh2ilSphklRwSHOLsoqgY7cBFE3CLJw6Ao7VPmaSjLcQ8YwHTQd72bhBm
 4/EdwNNqX2i1xC0iC0gvKc1RFTyqJZNLCmdaMCKInuoKdQkwfqM03muRzy2jTXXMVu/qfyneC1B
 9tHVjFzBDzNZOGeNTKsqVYBvazqcVn+CaPBhOU7qMKPlG+0n02U3fq25WoU9UyysYlGIn2oTfrg
 qA4r2ZY7dfhw86xXV33zm8174S6YcuyCHsfVkdZ5hGVM+F6Gmv/EBzOIKXnJpOM5Zmn2AaWGIih
 dq9PPoVbh9Qn55hfP
X-Google-Smtp-Source: AGHT+IFprVWTFamQwXwkY1b6es0CllYEIJAfL2qSGXQfbrhtCrvRPimCA8CDMKjdeqZ0hd0pb/A2uQ==
X-Received: by 2002:a05:6602:4806:b0:85b:476e:ede2 with SMTP id
 ca18e2360f4ac-85e82177d50mr891840139f.13.1743176665762; 
 Fri, 28 Mar 2025 08:44:25 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85e8ffd6b56sm42174439f.17.2025.03.28.08.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:44:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] bloblist: Provide access to the FDT address
Date: Fri, 28 Mar 2025 09:43:57 -0600
Message-ID: <20250328154401.3563921-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328154401.3563921-1-sjg@chromium.org>
References: <20250328154401.3563921-1-sjg@chromium.org>
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

The firmware handoff specification provides for a devicetree pointer in
a register. Provide access to that so we don't have to parse the
bloblist to get it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/lib/xferlist.c | 6 ++++--
 common/bloblist.c       | 5 +++--
 include/bloblist.h      | 5 +++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
index 6425936d354..16c28e34604 100644
--- a/arch/arm/lib/xferlist.c
+++ b/arch/arm/lib/xferlist.c
@@ -8,7 +8,7 @@
 #include <bloblist.h>
 #include "xferlist.h"
 
-int xferlist_from_boot_arg(ulong *addr)
+int xferlist_from_boot_arg(ulong *addrp, ulong *fdtp)
 {
 	int ret;
 
@@ -17,7 +17,9 @@ int xferlist_from_boot_arg(ulong *addr)
 	if (ret)
 		return ret;
 
-	*addr = bloblist_get_base();
+	*addrp = saved_args[3];
+	if (fdtp)
+		*fdtp = saved_args[0];
 
 	return 0;
 }
diff --git a/common/bloblist.c b/common/bloblist.c
index 135fb149626..83d9de2749e 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -505,7 +505,8 @@ int bloblist_reloc(void *to, uint to_size)
 /*
  * Weak default function for getting bloblist from boot args.
  */
-int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
+int __weak xferlist_from_boot_arg(ulong __always_unused *addrp,
+				  ulong __always_unused *fdtp)
 {
 	return -ENOENT;
 }
@@ -536,7 +537,7 @@ int bloblist_init(void)
 	size = CONFIG_BLOBLIST_SIZE;
 
 	if (from_boot_arg) {
-		ret = xferlist_from_boot_arg(&addr);
+		ret = xferlist_from_boot_arg(&addr, NULL);
 		/*
 		 * If Firmware Handoff is mandatory but no transfer list is
 		 * observed, report it as an error.
diff --git a/include/bloblist.h b/include/bloblist.h
index f32faf78560..7ff70e9554c 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -509,9 +509,10 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist);
 /**
  * xferlist_from_boot_arg() - Get bloblist from the boot args.
  *
- * @addr: Address of the bloblist
+ * @addrp: Returns address of the bloblist
+ * @fdtp: If non-NULL, returns address of the FDT
  * Return: 0 if OK, else on error
  */
-int xferlist_from_boot_arg(ulong *addr);
+int xferlist_from_boot_arg(ulong *addrp, ulong *fdtp);
 
 #endif /* __BLOBLIST_H */
-- 
2.43.0

