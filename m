Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C39C61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC2F87617;
	Wed, 22 Nov 2023 14:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tjrJ/myi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9135D86F42; Wed, 22 Nov 2023 14:12:06 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF5B87097
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9caf5cc948so6325889276.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700658721; x=1701263521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LmQl4T3hSNFLEDqQtaz6kiwsS9fwlqq7wH5Wez33+L8=;
 b=tjrJ/myiK8f6wWwrjO+IJi26XbRqX1Ay5BBlnX0ecNijklNrmOFG2VX/fH8xOkdzIe
 Fu3X2SASJ3BTXLNh8ExI76FcGJNZ2WJ1v8XCBTmThl1sr9AAkbk+NURLERHKDTdAvYmA
 K61Eq2O4EyWG9wI6OB7v8hMUFM8ezGLyv+ZeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658721; x=1701263521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LmQl4T3hSNFLEDqQtaz6kiwsS9fwlqq7wH5Wez33+L8=;
 b=FAgUYl7+JWQ+n9gJfgtAvirUaH9lzuDApogxpuDqtEhId/84eDchtj1S2Ga1QGD5F0
 t9CKU/WSXcAm50bjCUa1086WacCpLAc90i5Tzj7xhGsYs62Tjgg53LdpBQruEYv/tGBO
 4IVMgDoGuMwPXwKSC5UeV8Bs8d1jnaQAKoV3CMYQWyE1DL5jAXDha8Ft+stFO9AZmalK
 cv5k1gX5oJUO7wu2Nc/EvvyjIbeuJXzgkHveEP7c4OILVWrwfB8YtHWnyP6TE0DWsoJc
 R9o4skDpa1OcMDVjXob/Kfaa+Lzz2y8tPeOEBakgMbyDkNO1g8EdR4gd+W+Qt+tiXwzO
 x7Uw==
X-Gm-Message-State: AOJu0YydX3bJ8RkPt5oSNQqKe6wHQgSBr8K11b/0azt19jJoh41M/Rgu
 SshkkNSuqA94Dfskqigw4nCjX3HPlDYlJobkjJLqzg==
X-Google-Smtp-Source: AGHT+IFway0eevzLAN7cUFAPKKHOEfPGBsBAp4p8lCe//K49RrH6FPwTfwkkZPEw3k5vsGbfMEqrYQ==
X-Received: by 2002:a25:aac1:0:b0:da0:514a:8f42 with SMTP id
 t59-20020a25aac1000000b00da0514a8f42mr2239026ybi.32.1700658721471; 
 Wed, 22 Nov 2023 05:12:01 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a254a42000000b00c64533e4e20sm1367511yba.33.2023.11.22.05.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:12:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 07/11] rmobile: Add <mach/rmobile.h> to cpu_info-rzg2l.c
Date: Wed, 22 Nov 2023 08:11:50 -0500
Message-Id: <20231122131154.2444690-7-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122131154.2444690-1-trini@konsulko.com>
References: <20231122131154.2444690-1-trini@konsulko.com>
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

In order for RMOBILE_CPU_TYPE_R9A07G044L to be defined we need to
include <mach/rmobile.h> here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 arch/arm/mach-rmobile/cpu_info-rzg2l.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rmobile/cpu_info-rzg2l.c b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
index f69649dc7eaf..bd3146fb011f 100644
--- a/arch/arm/mach-rmobile/cpu_info-rzg2l.c
+++ b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
@@ -4,6 +4,7 @@
  *
  */
 
+#include <mach/rmobile.h>
 #include <asm/io.h>
 #include <linux/libfdt.h>
 
-- 
2.34.1

