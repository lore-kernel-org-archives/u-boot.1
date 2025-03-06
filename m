Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1DCC282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C148681760;
	Thu,  6 Mar 2025 17:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JPHdROS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D230681951; Thu,  6 Mar 2025 17:05:21 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9E081760
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d0465a8d34so6882435ab.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277118; x=1741881918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwZftk/aTnNkPL5O9M5ktbrIo6H+d1lHm0/nJzAEbYo=;
 b=JPHdROS7O7/P8fuD+Wu4s7tisSm5vOlUktrnR7N4+CAFWeRJMpoG235qgOhUwANCMF
 3FkxJhYzrzRWtRdrvvKxARMCqo49iOx84C+ym+ZmSG7xKE1aOChiD2T60DsfqYhDysBE
 s3t5UYhdiCxeIe+8aE64RI56J1rgSIjHJkUNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277118; x=1741881918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwZftk/aTnNkPL5O9M5ktbrIo6H+d1lHm0/nJzAEbYo=;
 b=sCgbOKrliZaCuJ3TLc1I3mar9YkkFx9QbJQMZMJ6BIX3fQCvw6ffmLZ2303rZHOOqk
 R4WFHcBK3VOcjClph9dzmncuGXB/nJ/YT/H8ly2ZQ3w6l46S45svY1dqa60jHYd1lsnR
 EMoyg+CQvLcddUya2f6K3UvVzKpvWVgsdfS6dws54+ltbzJAwl9gywv4OnRY6LgGTW55
 MPMgOwww62h1Ee3HWKgBZ1yGbS9/2hH9eJ+6vrVDzROqKTsNASTDzoPxu51EufbrsJuw
 lYjma/VyXTOj3b6gJAtp8VoFaIWcetaptA6HZbWwbNntEwKRRodKQDKGUXEVkv5Jr94B
 l43Q==
X-Gm-Message-State: AOJu0YwBf8taFFKexH57EbnIWqBEeye3Ke78unkrMRZYjeWTFANDE5Sp
 ESHSbjOY3cC2MR5V180ERbpr6oB/ND8rcZ1cG8hFs6Dw9m1gRPDfyWF5T4pCMCEWaud+9OWPgVk
 =
X-Gm-Gg: ASbGnctKlun+Q0ELULBcTVbFunmGDbf77Wd7Zfs/6cUXKiVmkMi4QWJpi1YdNmHxvC6
 2FKlgSGPQVCdmkVut06S75ei+IMJ5fX6cmN25HwksAc7vhhb4g9Qo5vKa5f83yblFJoUwJwGGAT
 0O46tCjIaep6qATMmHqQxiMfxuCjUHmQaUrqJTUvfbIjBTCwDhCHR1sRQ50+pdrtDcAUEleRPSM
 0skD5cK9rS//APuJZ3o3AN0J2U/6p3oG86bhAH1SUki0DuRhdTCi4DoKYTzZRwXrwsFKZiPcgJ3
 t6Sh+p+Vg6rBBitzl+BZaYnnXcpWt01hX0tsM8J6lpybIJknx0gfjLB8PHPiSUQo2TLYKKyy820
 mtHMKUw==
X-Google-Smtp-Source: AGHT+IFgzNFmaSn16YFGz9mcQYCz3aYIw1J7i/sR1y5N3aq2tr2eP1+at4tNAQf+0gkmwQIgo+NtvA==
X-Received: by 2002:a05:6e02:1d1b:b0:3d0:4bce:cfa8 with SMTP id
 e9e14a558f8ab-3d44192658amr548215ab.3.1741277117794; 
 Thu, 06 Mar 2025 08:05:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 15/47] x86: Include stdbool.h in interrupt header
Date: Thu,  6 Mar 2025 09:03:42 -0700
Message-ID: <20250306160428.3041057-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

This makes use of a 'bool' type, so include the required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/interrupt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/interrupt.h b/arch/x86/include/asm/interrupt.h
index e23fb2c8e72..c689fc23d08 100644
--- a/arch/x86/include/asm/interrupt.h
+++ b/arch/x86/include/asm/interrupt.h
@@ -10,6 +10,7 @@
 #ifndef __ASM_INTERRUPT_H_
 #define __ASM_INTERRUPT_H_ 1
 
+#include <stdbool.h>
 #include <asm/types.h>
 
 #define SYS_NUM_IRQS	16
-- 
2.43.0

