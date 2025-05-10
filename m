Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093BFC3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED83C82B44;
	Sat, 10 May 2025 15:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c7GqXG+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 968AD82B32; Sat, 10 May 2025 15:43:49 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A439382AA8
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso4799764a12.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884626; x=1747489426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtVEWTaEhcdi26ANWFOalN9+UtwW0THDh9KdOFc58CA=;
 b=c7GqXG+ow/+d4HPVJJL7FHRkFy5B5NY+fZw/V4NuIknGY0/ItKkcpRlpDRHUXD1Ipk
 7MtBh0ITIndV1Fsz5rsXQ8r9xT8yYEymldpbd/erWv5kKRYeGpbHcoe3hksWZ1Lb3N4x
 +xMJerc50x+HLk2yIR5fZbifzZp809/dd46Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884626; x=1747489426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtVEWTaEhcdi26ANWFOalN9+UtwW0THDh9KdOFc58CA=;
 b=YQqOAF/269t/E52y5KgVHwn9H+8wopW3O4OwSiblnBb/kvySzwvIrMhkcF+7yGaF1P
 3doSRd3t6CCT1Dm7laL8OXFy9lfheVpnJMUwka/ZH7jkm495rNVDVMy+Gwga3s9s6G/Y
 j+qOP3SZsM37YZRyqSeN781EtTvi6ct2F2RBaQa3HLkY71Z0jP1IsY3ioLDk2LZwo6z8
 j8gO3b50KPSqk/LqA9EMt+RDkeuzuipFCBBoLNE4yWyuAubUlNuaZBpIuYrHbVJcFZNm
 3QldqlOTtDJZayDN0QClZMg6gQCp6R5gk4zAqNPuu23MkI80ylq4YTzM/OQwSnE2gEj8
 X42w==
X-Gm-Message-State: AOJu0YxBQ1NVZGocnjJJwwv6rtsl4Ln4mosHfhVy5P7jM6rVhq81ZkHE
 FMBb/33keEyjcz63R8OnEvS4JSCdBNUnnUiq5dTTNQk9IUmyNQnPVdUmJv+WZwDYlf6LcQ8eZH+
 1MWZwwCKnjQ==
X-Gm-Gg: ASbGncsgSbZsPxk+SRQH+zv04bFiOVm93XeBjs1ZRsZH3tkfIT3cEHrSTggUKAp1x2y
 WyMdvuFGU0krW1CpFRaeBUPNevep8IddcU0GBPjIG6aVvu0CiODZRjS0fFHM9VK5OzXEwMQnxI/
 +pNYbwgZyTEQBnD9Bp+CE8zrv468MYm0I1BvYLb1zH6cYdKq66PuvGkRPXV3H3qpcUFjjwuMpgT
 Hcc4oM8bwGmiCulggEA+xkMUbmJr+YJQCWTjYftrBIMSUPtkbwwY/FG6ZL3DSvjr+ieh+pCnTNv
 Q5rI4OIOcL63UD6+4nUtZz08wHIkpYdQq4OIJUoOMhiRdcPqckbGatSn3wMFEQFxt85Y
X-Google-Smtp-Source: AGHT+IHuHmGnnvjhdOoAvvHwUXce8jFfDUVZdHxO4TPGXvJUR17f0bPih21ZZqOR3ftK8T5bO9ALQQ==
X-Received: by 2002:a17:906:c4d:b0:ad2:2146:3b64 with SMTP id
 a640c23a62f3a-ad22146451cmr427725666b.39.1746884625914; 
 Sat, 10 May 2025 06:43:45 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v4 08/22] bloblist: Adjust how the bloblist is received from
 passage
Date: Sat, 10 May 2025 15:42:06 +0200
Message-ID: <20250510134253.1581164-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

With standard passage we can read the bloblist from global_data. Update
the implementation to handle this, thus simplifying the code somewhat.

Shrink the log_msg_ret() string back down to a more normal size.

Note that if OF_BLOBLIST is enabled, this code should never be reached
unless there is a valid bloblist, since the devicetree is processed
first.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to adjust how the bloblist is received from stdpass

 common/bloblist.c | 70 ++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6e4f020d7c4..c7322b96bcb 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <passage.h>
 #include <spl.h>
 #include <tables_csum.h>
 #include <asm/global_data.h>
@@ -513,47 +514,37 @@ int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
 int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
-	int ret = 0;
-	ulong addr = 0, size;
-
-	/* Check if a valid transfer list passed in */
-	if (!xferlist_from_boot_arg(&addr)) {
-		size = bloblist_get_total_size();
-	} else {
-		/*
-		 * If U-Boot is not in the first phase, an existing bloblist must
-		 * be at a fixed address.
-		 */
-		bool from_addr = fixed && !xpl_is_first_phase();
-
-		/*
-		 * If Firmware Handoff is mandatory but no transfer list is
-		 * observed, report it as an error.
-		 */
-		if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
-			return -ENOENT;
-
-		ret = -ENOENT;
-
-		if (xpl_prev_phase() == PHASE_TPL &&
-		    !IS_ENABLED(CONFIG_TPL_BLOBLIST))
-			from_addr = false;
-		if (fixed)
-			addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
-					      CONFIG_BLOBLIST_ADDR);
-		size = CONFIG_BLOBLIST_SIZE;
-
-		if (from_addr)
-			ret = bloblist_check(addr, size);
-
-		if (ret)
-			log_warning("Bloblist at %lx not found (err=%d)\n",
+	int ret = -ENOENT;
+	ulong addr, size;
+	bool expected;
+
+	/**
+	 * We don't expect to find an existing bloblist in the first phase of
+	 * U-Boot that runs. The only way to receive the address of an allocated
+	 * bloblist from a previous stage is with standard passage, so without
+	 * that, the bloblist must be at a fixed address.
+	 */
+	expected = (fixed && !xpl_is_first_phase()) || passage_valid();
+	if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
+		expected = false;
+	if (fixed)
+		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+				      CONFIG_BLOBLIST_ADDR);
+	size = CONFIG_BLOBLIST_SIZE;
+	if (expected) {
+		if (passage_valid()) {
+			addr = gd_passage_bloblist();
+			size = 0;
+		}
+		ret = bloblist_check(addr, size);
+		if (ret) {
+			log_warning("Expected bloblist at %lx not found (err=%d)\n",
 				    addr, ret);
-		else
-			/* Get the real size */
+		} else {
+			/* Get the real size, if it is not what we expected */
 			size = gd->bloblist->total_size;
+		}
 	}
-
 	if (ret) {
 		/*
 		 * If we don't have a bloblist from a fixed address, or the one
@@ -567,8 +558,7 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("BLOBLIST_FIXED is not enabled",
-					   ret);
+			return log_msg_ret("!fixed", ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
-- 
2.43.0

