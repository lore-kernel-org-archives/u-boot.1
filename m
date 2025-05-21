Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96970C54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC0D082F8E;
	Thu, 22 May 2025 01:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lgQM8Dis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E20882F70; Thu, 22 May 2025 01:01:28 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B4F82F5A
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3fbc00143d6so5615764b6e.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868485; x=1748473285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ihe+FwogY1w7T+gPKgKIqkRyIdt6Xzz8wG7MDTQLPLg=;
 b=lgQM8DisLDTFEJCwDpYcRDwmrUubsLKq6Z0crbK7eqO17FCuMJ9TItO6COAh/jZora
 q44QqO2zG2lkIxDDiEbu/gidFpeXCDBUPF/TiytzhazgXgxEWR4lIkMKw4n7V41C1MQC
 ymqZOu8jxvlksBrZMG70AK9pd1Uk0/C4r7VIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868485; x=1748473285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ihe+FwogY1w7T+gPKgKIqkRyIdt6Xzz8wG7MDTQLPLg=;
 b=pou45gXwjaneYAZtNS8o3gqzoDf1EFGy4sfywh/OPtrY+58dyrK+vepswFMW3ptL5w
 p2YrtvUJYwWpoxcOai2NMp1xP9ZM8ZH++NGyepr0+wh6VwHAgG/H03YRd4ts1Y/y4xaA
 /alxcIIR82su4xndorEDfAa9STN/JCLVF32mwJipMDtlUgJk/lEO9QOCbQrUVvNM8NMe
 CnKyW1XkmkuOF7gPStUggvVfFBWI5GbSCm78zO4Y5jP5Y95cGmnKe2rBSk7/XaYi5PCK
 2a616PK9ED69YD4nXsABXr9mNXmlhK3ZAKaOhnMfdf7VW1N+dvRVTxdX5SLBOrnjHZtM
 aaCg==
X-Gm-Message-State: AOJu0YwNhBjMoKl0TmBs078BBrKq42HkZq+Mny8k/hBMDbWWI1JJKN9F
 DXZ4pIB62Rv7aKa6GbE3U3Fg/dwHdK7sjdRgzfzOmD9SVsjYOO6FCB/rvbH6tWxG7G4UqnXm0SS
 a2nsjHzs=
X-Gm-Gg: ASbGncsJOLRD/bThnxDFSq9rh6ZeheWUcQB2auznNq999Cz3Z+/nW2LcPjy4Gt6uVwe
 dQPJR0Mynr9LWyUhEu+B92xDcJo2Of+OhFagXk/BymnLWjgby2ROS4Y2YqYVKXp41iuWajszBaX
 5za0yTYqs/jYUs7c8+MOVB5NXah9CKuJmvn5J+h6L1iMHln8B6QCZVYrO9uJZc/+rVEQvmZFawa
 hDeJl3FqOM3dhqMHW70MHffwsPERfqY2swVPqN5eSNZ9l6PjNh9sNXlEMqzdJfK0s2VEdJ/kuFf
 6zA7LBZVRU/kumrZuRROrQy1D/LGQ6E24mOdl3uMIjqKiDvaJEg5o4qQFNLQcL/K6+wdn31B9U2
 BJxR+rHqagJgU6oE=
X-Google-Smtp-Source: AGHT+IHrWuvY7dCBZqOyqWlt51TaCQ7wIlewXirRe0zOiAvhZP7Ao8wXO/A74WsDWaAjrsQrolvpHA==
X-Received: by 2002:a05:6808:3307:b0:404:ed12:453 with SMTP id
 5614622812f47-404ed1206demr9983039b6e.19.1747868485079; 
 Wed, 21 May 2025 16:01:25 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 01/17] include/ahci.h: Audit include list
Date: Wed, 21 May 2025 16:51:06 -0600
Message-ID: <20250521230119.2084088-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need <pci.h> but does directly need <linux/types.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/ahci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/ahci.h b/include/ahci.h
index eb05cc687f64..470cda006de9 100644
--- a/include/ahci.h
+++ b/include/ahci.h
@@ -7,7 +7,7 @@
 #ifndef _AHCI_H_
 #define _AHCI_H_
 
-#include <pci.h>
+#include <linux/types.h>
 
 #define AHCI_PCI_BAR		0x24
 #define AHCI_MAX_SG		56 /* hardware max is 64K */
-- 
2.43.0

