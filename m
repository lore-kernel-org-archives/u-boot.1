Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E66C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B2A82F85;
	Thu, 22 May 2025 01:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N12CDvj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D727082F8A; Thu, 22 May 2025 01:01:29 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C079B82E31
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c09f8369cso2821103a34.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868486; x=1748473286; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5jmGhrrArKKgH70D5O8GK7UYmQxk4XJaRSuQJXbPeZQ=;
 b=N12CDvj1FUDYKXxmd5kPTgcKobl5NdyuF6sq/0qfoGsEJRcPpQXrafS/1Ohnjukj5F
 7uxhHIviCjNaDRzm895fIxnzjzQeiETgxDv3T1i30XhjdmDxWk/JErGeaI4d70d+CNdv
 47jCEEXK6rO0J7vT99vwaqE+e7WcHsaEdrf+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868486; x=1748473286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jmGhrrArKKgH70D5O8GK7UYmQxk4XJaRSuQJXbPeZQ=;
 b=VLbrfb9/H6kIyD/E81pXtrmgIFoqPUcnUzInLJT2jPjfmqK//f+exIvtrvF8fu4uKr
 XVLsvMkte0oEz6QfcO+HpigeBpx+mx687OfUi7GxiDVUZ9JPrLv21LArt4wtv6fXDm36
 XFMWheqxUgCAF67MVDmq44xnXML9LkA99GKncWh1YX7N8fcz4f8cD0/EpsPOMDb/ZZkn
 gXXvzdCBiowdNCEK5yxnE8brDyUvXoOW/2U01P5RRxCGgkDS5kCX26AqugZA8cyxFGZV
 Nu3vSxN/ex42Cqc4zwYWfXv0jZqsrim6I5KDWIiow+lVq1Mjcd2vlO+GkjpjEAWlHB72
 x9iQ==
X-Gm-Message-State: AOJu0YwU40L5kSs5CbNakTb+/IoJGNeI6tyByPbkQ/cRAkTwXrkqRUpZ
 YQtVOQUx+S7DrP8loogAH2cOHkojBMGr8jscielfWCSdhaVDnzyetFRO46LhKOUid8wm8y78jv0
 3hbgstMo=
X-Gm-Gg: ASbGnctz4dn8bDg5filgeMEvITI4xR2KwAflNKtRGC6sxYj0qpl7QtPb/SIHZgfYXtj
 5IP4yJSKiuTSV5aSQg3ysMWgtetqBrPbUZRLfG0+aFHMw9zfHn8er6BmWmtR/Z4PUmnCjNAMnlP
 NTB75LuPXeyu5pRRFJhankZPlzqApyhLb2RawDlez58kHvU1y7efQKAwm6DE+LFvHif+2pIcfE+
 o7/HJUQKGTOmGrQAQi2W7ONH6VubKVkbqCGk2FUiWj9Rq432KO7EKNwERghuJ/4S1glix/la1iq
 1GFyo2XpRr0V0SKY0Tunnk56gq/tSFJLD7wCDASbc3MRMBORxaQumnPNGibHSaaKmLHB1YBJuA1
 UCS2TqB1T1q/G8H4=
X-Google-Smtp-Source: AGHT+IG6RmmhnkLt/gno21AezbfTOn1BexQZv4R9DZJ0jvMDkK1DpW8d7Vg3ousNGV7X+W8S9yR+Tw==
X-Received: by 2002:a05:6808:1b0c:b0:403:43c4:f434 with SMTP id
 5614622812f47-404d86af8d5mr12819279b6e.16.1747868486511; 
 Wed, 21 May 2025 16:01:26 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 02/17] include/arm_ffa.h: Audit include list
Date: Wed, 21 May 2025 16:51:07 -0600
Message-ID: <20250521230119.2084088-3-trini@konsulko.com>
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

This file does not need <linux/printk.h> but does directly need
<linux/types.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/arm_ffa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/arm_ffa.h b/include/arm_ffa.h
index db9b1be995e6..2994d8ee3ae1 100644
--- a/include/arm_ffa.h
+++ b/include/arm_ffa.h
@@ -9,7 +9,7 @@
 #ifndef __ARM_FFA_H
 #define __ARM_FFA_H
 
-#include <linux/printk.h>
+#include <linux/types.h>
 
 /*
  * This header is public. It can be used by clients to access
-- 
2.43.0

