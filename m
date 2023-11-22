Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4B6C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B941E86C31;
	Wed, 22 Nov 2023 14:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tadcY1eA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25A80875B5; Wed, 22 Nov 2023 14:12:02 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B597D86F83
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-da37522a363so6314197276.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700658717; x=1701263517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XyaJ7vvMA3H10SLV0/5ISIpxEkyLI82xmSBBf5MmOeM=;
 b=tadcY1eAaTyIT8KT3euBojfCPeoxCH9gySLCKoxUfQomcn4oGiNihxc4rCUV4ZNVNF
 WsFfSBGNV1taEm6u1QsilI/L2eyA7+b5kdiMt3n3kDL91XjE0e4P2o2ujXjA/2pJFuD1
 DiTeU9N4mp6IXFWYQC80Q4stVcKx7Z+KnDgK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658717; x=1701263517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XyaJ7vvMA3H10SLV0/5ISIpxEkyLI82xmSBBf5MmOeM=;
 b=inmuJvkB1rM39XnOCZzcFBe3pcY9K3WGSLDaW3GVMweAVGWHHfGf6oIpfJbdBziSsc
 GKKoVRe1uBjMV/W1FSQ4AmRtgYb/9+ZN6fs1wS0C/4LDmOPlceW2BHvugN0sCIAvPcYB
 6TCagVsnRgDeytfY7+EyRy0C/0IJHLebFH3orDbVW4ySTB71v1zA6558ryVfcYBkE5B1
 f7Hf3YULg35R7vPoTb0r3PXgGxUN91nlyydbP8YaJ8oTjAlExlAkPqoh+zf4ejSrZhiI
 6OifaFvo93oYUDGSEZhNzF3Uh9CMqxL5BoK30MuKi2GzBeTPS1G/I95fxjMN+ZMed6Se
 CmVA==
X-Gm-Message-State: AOJu0YwcLrtUUQq4ESvWpRRdeEih5+hWkmD0sbreygzR4cw4zNreII5g
 KOtcEmGiUXkLesUaxgzEmlHIaVQowFVxyGGWqkwQ5g==
X-Google-Smtp-Source: AGHT+IHKSk9K/wZjC6cpOD/uy3k1wOdqIiOkBbozhguX4Yawmm+mHFO3LuEjD7mHz4WkqCl3/+WveA==
X-Received: by 2002:a25:8241:0:b0:db4:1dc5:7a83 with SMTP id
 d1-20020a258241000000b00db41dc57a83mr188283ybn.52.1700658717052; 
 Wed, 22 Nov 2023 05:11:57 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a254a42000000b00c64533e4e20sm1367511yba.33.2023.11.22.05.11.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:11:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 02/11] arm: Remove <asm/types.h> from asm/global_data.h
Date: Wed, 22 Nov 2023 08:11:45 -0500
Message-Id: <20231122131154.2444690-2-trini@konsulko.com>
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

We need and include <linux/types.h> and this in turn already includes
<asm/types.h>, so drop it here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/global_data.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 75bd9d56f893..2bb978d66839 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -11,7 +11,6 @@
 
 #include <config.h>
 
-#include <asm/types.h>
 #include <linux/types.h>
 
 /* Architecture-specific global data */
-- 
2.34.1

