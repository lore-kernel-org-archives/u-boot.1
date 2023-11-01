Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FF2C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE2A87D31;
	Wed,  1 Nov 2023 17:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KDgXyv67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1948D87D24; Wed,  1 Nov 2023 17:28:39 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE6B287722
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67089696545so156396d6.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856110; x=1699460910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z2jCkeSxIyLV4mc726R5Ozie51Ukuj/NBuwya7y+8ds=;
 b=KDgXyv67hFIQ6Zrg6KxEpXrgmr3rxeTT27t3S+iKXErmyG4jy/aX42vpoQtlgzSC5F
 N5SMjQhbl//TtOgVae249Lyin3nCoV1tcBFUW7aCg0eCYhl8PeXT2Z6rb0yt48g50jMs
 MdD/hh1zrEWhNuEI2whUlA5BdXUO28/L404k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856110; x=1699460910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2jCkeSxIyLV4mc726R5Ozie51Ukuj/NBuwya7y+8ds=;
 b=gb/9cOTW/0ZDDZcrcIouVUqilbQq7ahNFbs/WDxiaDIcTtRrhtsQ5H+57wYn4qKdpd
 QPQ2XLm3VXZb5yugKn9MdKfTJVy2A7M3lYjkeZOwss9zfnLflIczdASdmBuzOFj7TOJa
 F8cXPDkO8VkoZJRy72vKkA3Gag4cgW2kgcDMTs5hX9uDoANyE2RUlna26iiLvK9habdc
 GU8gQht/ZYNhaJwJbhFIhi6a4w0MIf5TmlECZeZ2bEiWlMr1IYpUKNYPeCaBxZBJ8L9y
 KPLHcF3v1jSuaYZQSqeV3uUrNRBTldq8mbfMdD2fBUKeTCsIQ9y/85nlwU5FSEWH9fl0
 06GQ==
X-Gm-Message-State: AOJu0Yz9elZifhc4hw6m6yLar3288fi6buM0w9lSDWtYYHEHx5sI6tfs
 oeFRr3SiiewGpBd/FcKSLnO+66i/NJoLlkQAwFzppw==
X-Google-Smtp-Source: AGHT+IFm4Yu+hEeeeV5BscoApEiSp53YopWBnCVdYn0/MasxHb1Dr672A0+u2r6Z+TkpgFdCitws1Q==
X-Received: by 2002:a05:6214:e8a:b0:66f:e3d4:2145 with SMTP id
 hf10-20020a0562140e8a00b0066fe3d42145mr18744742qvb.46.1698856109888; 
 Wed, 01 Nov 2023 09:28:29 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 05/20] omap3: Add <asm/arch/omap3.h> to <asm/arch/cpu.h>
Date: Wed,  1 Nov 2023 12:28:09 -0400
Message-Id: <20231101162824.3755579-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

The include <asm/arch/cpu.h> references values in <asm/arch/omap3.h> and
so include it directly here rather than rely on indirect inclusion.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/arch-omap3/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/arch-omap3/cpu.h b/arch/arm/include/asm/arch-omap3/cpu.h
index 3f0182e7665b..d2fbf919a5bb 100644
--- a/arch/arm/include/asm/arch-omap3/cpu.h
+++ b/arch/arm/include/asm/arch-omap3/cpu.h
@@ -7,6 +7,7 @@
 #ifndef _CPU_H
 #define _CPU_H
 
+#include <asm/arch/omap.h>
 #if !(defined(__KERNEL_STRICT_NAMES) || defined(__ASSEMBLY__))
 #include <asm/types.h>
 #endif /* !(__KERNEL_STRICT_NAMES || __ASSEMBLY__) */
-- 
2.34.1

