Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E58BC35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F1C81760;
	Sat, 15 Mar 2025 23:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kSLc/85z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA6F8193A; Sat, 15 Mar 2025 23:18:41 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D0881CFD
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22403cbb47fso57332665ad.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077118; x=1742681918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQ7mnDBDbgZOiTnkjKcoY3/F8/AyNnuWGOxNKxKG6f0=;
 b=kSLc/85z/4DJTO+frdCivHe8eMRtw93sAWz5RI7EWz4tNqUZLZV8mEfevL2XUfazji
 PjvYpWDIJ/RI1nKrcWl9jD7krt/n57IxCQstt/veFyPGg3JEfp5J6s8LIxRThQb8UdGE
 HeYEKslqcYUqbpohJ3ZlR8k9yCKnCo2rTrfp8eTfC/08YW9N4N0Hl7il82xgJei4ux77
 PFmwLMyWH0KeEgKVtWMMqfAVfBrWvF2iREHsjNr4OjJyAqMWFSG0B00XSehGLiybv8Vs
 qyozU+h0HpYgMlqcrYQ/AN2tB+7r+WAiulKAJwbDKwqS1uW51Nb+iUbaU+jZ+hwRp35B
 vkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077118; x=1742681918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQ7mnDBDbgZOiTnkjKcoY3/F8/AyNnuWGOxNKxKG6f0=;
 b=rxy5X3F4wBqrDFZQ2zQ5A9JKJn6Q/+eK6kqcfZVctmKxNYgE1Lb/kUiHjvvD51RCLp
 UnCL672ZRK0719E1tURRYMN+sYasrsknZ1aR3bGMMDW4KnUBMyiWXDBq7aC1qhXUNYIu
 XLW83n9H70NeokDhauTjSeEIB60CMbhY3fB5U30y++XwgXSAzU1A7u0u+Fm1Nyd2Y0Px
 84xLk6A6ng1WxNdSL170V6szkgrSUwWQqGPu5LvDg42oODdKgEbKhDGs3x3Wk/mWKEvO
 OSn43TLbu6HYPv/dX6SY/dke5LrPYJYST5QcPMYPWoCBWbIQV4mp4J1q1YerqENV14r7
 dpCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVARUcLoVr4j26r+otd39YVVPINEJ1pu8Xwu4ZCd8DoF3BhUZu3ZQhlZIvWpQYChhKu1uI5oh4=@lists.denx.de
X-Gm-Message-State: AOJu0YyQtVthYTzrVMgozgPirPh5XHUPTKGq1PPL81S2IQvZpxM11HC8
 B7ghKgwLWQo2Ieqmtbkt6CPS/6PJ5hM7Cc20Tm/MPtkSNLaFY2uH
X-Gm-Gg: ASbGnctUScyuVmzRTUGySzvd1IfYM//pU302DMcLd50O8LDpEYreqRMqutkpU6eNYyp
 lAyCAXC3nUp6zgALo1V6adNIlwXFQpjp2b9Icvo85pBCCkTa3j+kegk7RH+DjR6qZ6/2+G2FLVk
 5LDGAy8txZmCRgKgWEIckfFofvxr8R59bD7NF21FWFNPjQWkP7PAkO/7rYZ1NqMlt1ELAIKd5M/
 ZxjZAMZrLLX/x2ftZnP62j+94xS9SgybuZfh3+ndeOLKkMA6T6n1pfUNpwwkHOBtLRkHPpOhQ+q
 ZC+PRhiMRSE2iP/3HFqrOSmLuh7FJjuezUint1nKPq7uUqAFmKneEtY=
X-Google-Smtp-Source: AGHT+IEwp0GAZMmRisfldNGMSeF3wF4NIEbCU/1DctARKsCEp/bNatndVfhnmA4fxpfezKYbUEM8ow==
X-Received: by 2002:a17:902:dac1:b0:223:5a6e:b20 with SMTP id
 d9443c01a7336-225e0a52d83mr76201305ad.7.1742077118303; 
 Sat, 15 Mar 2025 15:18:38 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:37 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 15/15] spl: Align FDT load address
Date: Sat, 15 Mar 2025 15:18:13 -0700
Message-ID: <20250315221813.1265193-16-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
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

While the image size is generally a multiple of 8 bytes, this is not
actually guaranteed; some linkers (like LLD) will shave a few bytes off
of the end of output sections if there are no content bytes there. Since
libfdt imposes a hard rule of 8-byte alignment, make the SPL also be
explicit about the alignment when loading the FDT.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 common/spl/spl_fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 49b4df60560..86506d6905c 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -397,7 +397,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 	 * Use the address following the image as target address for the
 	 * device tree.
 	 */
-	image_info.load_addr = spl_image->load_addr + spl_image->size;
+	image_info.load_addr = ALIGN(spl_image->load_addr + spl_image->size, 8);
 
 	/* Figure out which device tree the board wants to use */
 	node = spl_fit_get_image_node(ctx, FIT_FDT_PROP, index++);
-- 
2.48.1

