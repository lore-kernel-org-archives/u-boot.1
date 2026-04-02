Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D7DD6AAE7
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05696841A2;
	Thu,  2 Apr 2026 17:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SIzznWGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2BFB84099; Thu,  2 Apr 2026 17:29:11 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D93383CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8cfc3ca1922so216080585a.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143748; x=1775748548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2DYyt7uEVwCnP84l5G8RvHRS5XSBJMzriRwtU/iMoI=;
 b=SIzznWGXgi3MVrYGJQGrKg8HLMiGbdZj4/6SvcX0kAAg3753RyCqtfVnIWhn6+XsMb
 O8iYjmnGAbmozfPCHm74a15nwKJa1t9/GrxRYuqLIydeRURjqk5Kmtzq3Mx6igUYj3V2
 tbYp/JBFaa6bOPGNPwiXjVhlR1FCwkD3Kl3JHvSErrBFnvMmeRoPWPIkYbg6+hHHedyc
 OImO9rFcmRW5M/ZyLjWc2+yyGEVfWpZUTJMZ718Aud+aRESx0dRPTZn1/bRZQTA+lHko
 GaKKY7K1lW80DvEmkWOB8ghUVIeygqbD2GDIPfXO0eyJ4kyLyDSzDDWPpnmVq+XTAWer
 IJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143748; x=1775748548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z2DYyt7uEVwCnP84l5G8RvHRS5XSBJMzriRwtU/iMoI=;
 b=hy6WaSpl29ax8fX5YgeAivTNuteBkXCqutLlFZrqnR+XxW9KLxXJIfh4vjrPrMqLXL
 K9Lb8J8SWRiF1yuJGTxCl7pv/UDkrqFJ4xw2ReZ1aS5naJO+VXidrMc1GIz1LdZZ1fkx
 1/M1VvM5LHeHBQ/8KW2197xOTHjsPWgGZ6zLXmW9qQxxZEpSTRs6xS7Ll+st+4RFa2TD
 w3g0g1XLeOH2j1C9KkLtaQ+vioIRc5yXxcGosOT+lQhfrM1M8OTrp0j1F/Mx/OQtRsyH
 o4SWeiN48WcX+azjALFfLeI7vgLkYL5UZgq+wUggMLH0s4qbk8uAwOaBXFopPuvBbWvZ
 jW9w==
X-Gm-Message-State: AOJu0YwuwJFZO0A8uP/Fp4aIv1VqXSB7d+dRYYa5rWYQUL7d67Pes3t0
 AyLIcPX4UizxpX5wj6E9ANm+ylJJLLVftL/dheiCstamY7Z7oR+976K9CRihFc6Y
X-Gm-Gg: ATEYQzxdgsrkmvrj3YMJ05utzhuhDkbrI3TvGH/TQQqjoxfhIC8qtKoJ1hqd8UjiTzA
 HHTrj8YLOVWplkdJe/b7f1uGRxZOstoKNOG7NvapV1LR6qfCTn9mTKnAxnw+2CZtiQmhI4SABhd
 9Z8BkNucH+NhBuB7a82dWMhXKkXEvAImuhOT6C6atXp8ON0/9svFXJV6U5OqAchY6abEALRnble
 8F3TYunHfv9pYSoYo+dvfhu0WyXcI1pjvl47Upe/iGl9lkKTuTV2b0r/O6bjJ0HL9Yhcf43gLOg
 Hvsc/rstOp4SL/RMYppT7BCc1HHVTzX6HwhKXZZ1rPR1xVnXB55pG5xLz7fYQbgXQ8waMoPexiY
 jZiGTnawCDnqukA0iIGPgtMSEfGYidtVDpdqGWeRXTXbC1QQFFDqJeENx54Tu+bv2tfJdpn+Hhl
 +zXpWae2qHla110kfigWJI18BFtrJBmxjezw==
X-Received: by 2002:a05:620a:1789:b0:8d0:a0e:c7ee with SMTP id
 af79cd13be357-8d30380231fmr339190785a.29.1775143748285; 
 Thu, 02 Apr 2026 08:29:08 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:29:08 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Ozan Durgut <ozndrgt@gmail.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [RESEND v2 13/13] arm: sc5xx: add missing boot env selectors
Date: Thu,  2 Apr 2026 11:28:36 -0400
Message-Id: <167f577421fe8fb53fb86000f7b32eaf667a0d29.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775143241.git.jcethrid@gmail.com>
References: <cover.1775143241.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:48:00 +0200
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

From: Ozan Durgut <ozndrgt@gmail.com>

Define the boot options for SC598 SOM EZ-LITE so the shared ADI boot
environment includes the expected boot commands for this board.

SC598 SOM EZ-LITE board environment utilizes the shared ADI boot
environment, but it does not define any of the USE_* boot mode selectors.
Without those selectors, the shared env does not generate the board boot
commands such as `spiboot`. This leaves the default `bootcmd=run spiboot`
without a matching environment command and breaks autoboot.

Fixes: c9e893d ("board: adi: Add support for SC598")
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index c7d7932064a..ab1acabef53 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,4 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+#define USE_NFS
+#define USE_SPI
+#define USE_RAM
+#define USE_MMC
+#define USE_USB
+
 #include <env/adi/adi_boot.env>
-- 
2.34.1

