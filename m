Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD290C3ABDA
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 22:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7917D82B18;
	Thu, 15 May 2025 00:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wc9RyQD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5A082B18; Thu, 15 May 2025 00:50:14 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDF482AC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 00:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3fefbbc7dd4so349746b6e.2
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 15:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747263010; x=1747867810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2Z73iDKFnHHqq/En/Pf1v5WPOnXRmMfq+LIJqiTRup4=;
 b=Wc9RyQD9HTsi7Y30v35QTrXESjSWE+2yr6DdBazOXymd24JcJnpdo/2EceGhV0t6rF
 bYdhIVUHgw/JYUEgLqi0fHyqlm3RdCOIXxgPfn3l4UpxpraRJikUtPObRJ9bxGV9JN8r
 73EfkjPhkH0eI8JGkkLLTGUpSASb7l4fY0cdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747263010; x=1747867810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Z73iDKFnHHqq/En/Pf1v5WPOnXRmMfq+LIJqiTRup4=;
 b=fXzymIIPp4JL7X8+0QmJS1Y22FP+o37Zrtr0sLax9rqmOhBSuIHFiLuP2VltghykSY
 sGXvsQ01JXOnG/wtbSoZ5QaxGXu40QBzYGqqrBj5SN3IB3ZE0f8oa6HaX74IUQGtLSv3
 IVkME70CLi0cnu5PK6VolVh64GmFWtnf9ehQ/A78uhI4PrOwl47xirL9VtSklJDZ3YbZ
 HiecD5y3FA98T4RZWDO4lb7NnvVEs7mH9kgGm9JUqhMgXKVqODRKTBqJJJvN9NWEno15
 o7dDiiifb1fx3wZmwd5As9oWLREhTy+m0LlE1VvzkgjCX0IyieEr5uUYxcQKQzd2bXLO
 TC/g==
X-Gm-Message-State: AOJu0YzWZEVT1RjH5ENUmdRls7exY5XGsDrUt0frTQkaGhRVPKHrshVO
 cghUIku45aof274tVMkXhHTRCukE85/KnGIDoF6PWc2TU+9ZtEjIG7a+l/3JMt/N+VklO7sSskV
 Q
X-Gm-Gg: ASbGnctuT/PcbMIehb4/0yzyqFaC+A1rKZwUhwybwh6eLbebnSr6YbZPx0ZSGmN/zJJ
 CW3q0/m5fFn16S/E8vaNwcZZ85nA1c7NKeDx5IT/sKR86L/brNwgH0jYUaYv5rpnzCBgd1bKV8K
 I6fs4eUPipd0UbmG1lYP6ppgYchsotXi03t+Dhfv24MTbew42tj0hKN+sU6w7Ln5IGuWBIzkJO0
 XStI30voQHB5J/yS1jwZrIJZLIpR+YghakCLptJaD0qtzC1wu/q3Tu+2wger2x1u8taF+UUDaAG
 jGa94oq4vZ8j925/q7hWZCVfyDvkuRmBacNXaJb+WVBk6kUi1GaR68abRbSnJqInxYDkeE+89Fp
 I5nsm+1qSXOEUZr3fw4BbOTKOzg==
X-Google-Smtp-Source: AGHT+IHqHLF+7RT9KxqwRGUIYc6Ri15WagIE0r4FPF19WzjJNMN9hFHhuot5BE7u8jdIPwBJvTo3OA==
X-Received: by 2002:a05:6820:2003:b0:609:d83f:125e with SMTP id
 006d021491bc7-609ebfa8107mr160985eaf.0.1747263010116; 
 Wed, 14 May 2025 15:50:10 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6083fe52271sm2636530eaf.21.2025.05.14.15.50.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 15:50:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/5] cmd/mem.c, test/cmd/mem_copy.c: Add <compiler.h>
Date: Wed, 14 May 2025 16:46:01 -0600
Message-ID: <20250514225002.15361-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514225002.15361-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
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

These files require <compiler.h> in order to have MEM_SUPPORT_64BIT_DATA
be defined but currently rely on a long indirect include path to get it.
Add this directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/mem.c           | 1 +
 test/cmd/mem_copy.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cmd/mem.c b/cmd/mem.c
index 9e716776393a..e5b9cb293491 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -14,6 +14,7 @@
 #include <bootretry.h>
 #include <cli.h>
 #include <command.h>
+#include <compiler.h>
 #include <console.h>
 #include <display_options.h>
 #ifdef CONFIG_MTD_NOR_FLASH
diff --git a/test/cmd/mem_copy.c b/test/cmd/mem_copy.c
index 3e904fc4e4ba..8e551f18a852 100644
--- a/test/cmd/mem_copy.c
+++ b/test/cmd/mem_copy.c
@@ -4,6 +4,7 @@
  */
 
 #include <command.h>
+#include <compiler.h>
 #include <console.h>
 #include <mapmem.h>
 #include <dm/test.h>
-- 
2.43.0

