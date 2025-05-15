Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F2CC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F8D82B8E;
	Fri, 16 May 2025 01:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zr2thkDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1B382B37; Fri, 16 May 2025 01:42:28 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F9F82AFD
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c0b4a038fso1149506a34.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352545; x=1747957345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iv1vUeT4VpUp6fqs93ab5yzkKeZSQe5pAYTuBHIpkuM=;
 b=Zr2thkDfwLpao5wxpYHV9x++ESYs5rKLe9GQ/x2n2InPMh0m1l22T9lZAfxdZ4BKXF
 LXrIwcnwLPyeiTLG2G3yzeibUUTwndE3vjnJwKDZIG5VogH3W+HSwDs/46VEzVvrBeFf
 TkanNOoDp129JXgaDp+isuomZlFblQdFGCxcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352545; x=1747957345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iv1vUeT4VpUp6fqs93ab5yzkKeZSQe5pAYTuBHIpkuM=;
 b=OanBsWcfKTde8CP/SfgabvSv3Uik8/DFZHdFGMgtRL/7+veOX3APi1Od2vIH2KR/Yy
 PJeo7V30AhSwowJyuete1SsZsiCerXypq8ANsFtusOIf9CGsC1xAX7dXyR2bUCCShjWI
 WlOF8NFLZB9y6OyRmF7ZPk++wXDpRYM/3qH8wuvLMae1KVu64OzPG9Uy2/EJ3X/hS3o6
 aEqyL5DFw6f2vb5Vf1vNCLpnDxjqC6uv5Be9N7mExoCYbTDoNeDkpztlUw73oDFmmC3S
 txRliJAyrDF28qKl8QfBuaxyflpbaxaYsGhAqNtmCrRpzzdZng/e3Kfypj1yRC3IF4Vr
 7DCg==
X-Gm-Message-State: AOJu0YwxshxTIIQn8eu1iifcBTzW9FE5+oQJU/OnxsAyUHvA0T4sHptD
 cCGRzHOr2FNnnNOxw6dnmsUu+H6uPtGxzAM2E8HkKLplcyJ4QGITLX0l8W5f47Pzg7kgeV81PHz
 ALLrOXSc=
X-Gm-Gg: ASbGncv1OxwjevzoDzsHZyZ+sInXl7jHdexenxrq+I60ybJcB+q8SQAQ3I8wlKNLDO0
 /cU/4waoRRxP0Y0EMWw9FqhYquWn8Rbi9yi7MKWGoaO3U5Od0OMF2AM4rq0msAAz7/MFe78+b90
 zahcspnqMg0iAJw5ugablWDDpWtxqIow7eCdBQK4b9yeTy9Umo2DS/YloscuRfLLZ5Iv0v56Wo+
 8dqQ91+BxEUwGwGIGqi5PwnPGXgA+FRbrEl/nRPfiCOhpVR/sHb3YlovjPOey+VhON/GCcbGpil
 2oBlEUFOvci7senugjetzkXFywlHERXxhagdyCU6j9bsFPQBQB+R1x1pB9zK6YdmLDVYkryGwje
 uyALk6D/IqkYK07/CMPa+Cd/iaw==
X-Google-Smtp-Source: AGHT+IE+/gPCMXop1hjFdz6ULO/7jf6pSQamD+VZBtRLdZsqp0z3tLjgxz4xSjKAwydMpelrHTxDmg==
X-Received: by 2002:a05:6830:2b2a:b0:72b:81a8:dea5 with SMTP id
 46e09a7af769-734f6b6bd72mr875733a34.17.1747352545066; 
 Thu, 15 May 2025 16:42:25 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v3 22/22] include/net.h: Drop <env.h>
Date: Thu, 15 May 2025 17:31:51 -0600
Message-ID: <20250515234154.1859366-23-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

Now that all of the cases of code that relied on <net.h> to provide
<env.h> (or one of the headers that it includes, and so forth) have been
fixed, we can drop the include from here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- New patch
---
 include/net-common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net-common.h b/include/net-common.h
index 2ca565fe4edc..9e82b280df2c 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -5,7 +5,6 @@
 
 #include <asm/cache.h>
 #include <command.h>
-#include <env.h>
 #include <hexdump.h>
 #include <linux/if_ether.h>
 #include <linux/sizes.h>
-- 
2.43.0

