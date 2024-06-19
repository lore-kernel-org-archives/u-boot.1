Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6A3C2BA1A
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172F3884A4;
	Wed, 19 Jun 2024 23:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jW2zAq5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE898884C5; Wed, 19 Jun 2024 23:28:07 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A0C87F5C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f980c89db8so96619a34.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718832484; x=1719437284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RzuRkIYFz61ZF2oK0c42uSn5uw1Tte6uFfxNeEEGO4E=;
 b=jW2zAq5qZDbM/4R3sKiLVR53I4oWluvERaCbEvG3xwhDnFbfvuYMRa/MjSEHbXWTXm
 GsqOBp0f5T8cLrdysdnFm0thitPL8KSUtIrFyzGOuf20OkJAvRKwcmSu8AV3eEU5Sarp
 JcrpkS79EJhXZbIJbK78olvw0VkxK4F0v1FWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718832484; x=1719437284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzuRkIYFz61ZF2oK0c42uSn5uw1Tte6uFfxNeEEGO4E=;
 b=Iwt1FhNVVx/PS1GrzbrpRMT/VAlWNUCG49IxshxFqhexsOP8PeZ7Jx6r1eX52/Jolu
 NrT6AwA2AuNWoBL2WDwL5iFJmCCDkIh6yx1CUXgGmh58uRg/5f9Mx/Ffwutb5oLL6LTX
 TN8gzdrP0vcLUZ6hU50GOrzVg+rwxsW1IqC8P2uFCSTIvMm3xppk4W0SsMH/dRiahuFn
 iHB4D3kO1/92AW2qvTG1YsvwA3tlyQoNBvI1M5fQTQMI6etBnnlCRFF1t3mVV/o8kpgg
 5yWeXrGN3q4L0bhMSiaiVlKOjpf9rodEUymEsp+Nzl8HvTunAcbiEu3IBuPCzRqC5T9m
 L+1A==
X-Gm-Message-State: AOJu0Yw6CK8vEPTbfXlMLekCd1kdEqBdgYLXCvfkKlbMGOeZyoAdT71c
 2It597L0/wmSogc6+5p4qTkfdx9rn/Q9elGtSpZ0OYnGOJ0Hol6KhVF2zp77t5u9Nsh8LimIn5+
 lHeuV7w==
X-Google-Smtp-Source: AGHT+IHmLhKdB5nrTUggVUg/wNHBASEKp4vG/xasS+jGQvws8JgeOp10J5aN85iNdA40Vxe7urVLKA==
X-Received: by 2002:a05:6830:22e3:b0:6fc:33df:f4f4 with SMTP id
 46e09a7af769-70076729adbmr3570517a34.32.1718832484254; 
 Wed, 19 Jun 2024 14:28:04 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7008a5a34c9sm338654a34.73.2024.06.19.14.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:28:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 1/7] m68k: Implement a default flush_dcache_all
Date: Wed, 19 Jun 2024 15:27:53 -0600
Message-Id: <20240619212759.3456158-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

Implement a weak default version of flush_dcache_all which is based on
the ARM default, which is to flush the entire range via
flush_dcache_range(...).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Huan Wang <alison.wang@nxp.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>
---
 arch/m68k/lib/cache.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
index de04124404cf..dab834c1cbd8 100644
--- a/arch/m68k/lib/cache.c
+++ b/arch/m68k/lib/cache.c
@@ -134,6 +134,15 @@ void dcache_invalid(void)
 #endif
 }
 
+/*
+ * Default implementation:
+ * do a range flush for the entire range
+ */
+__weak void flush_dcache_all(void)
+{
+	flush_dcache_range(0, ~0);
+}
+
 __weak void invalidate_dcache_range(unsigned long start, unsigned long stop)
 {
 	/* An empty stub, real implementation should be in platform code */
-- 
2.34.1

