Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82044C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 109928081A;
	Thu,  1 May 2025 03:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AM6AbrNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE0C828BC; Thu,  1 May 2025 03:06:14 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F8F8081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d9189e9a06so2052105ab.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061571; x=1746666371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/xGQyxEwCnvqSO8SpyZIpAaqhRXjISnCfTXAZnkxMo=;
 b=AM6AbrNErXYbTEUyYFZzdpNa8GJwd1070aY8FnD+OJtxDNhGMYF6opGtSuhERsKdZh
 FlaVxm8MCYVYgmIGEHydGX1gt2Rbe9+fcndODLK1t4DHQi61sAgMe0Nf7F57d22J9OgN
 1z6QQu8yQGooDfUf+3pgA10xS1BPUNKQufu2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061571; x=1746666371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/xGQyxEwCnvqSO8SpyZIpAaqhRXjISnCfTXAZnkxMo=;
 b=qYAwxScmH3b95BxK+V2Pb1W8+jXev2nUL0uabOBMlikmBDdnbrU3Gmz7r0rupgUt80
 rJRca/cPnMeuDTMNYUM4jznfW14ZQCVDL1rS955wfc1/8+oQriGjXIucIrAQ+/igHcRn
 3YnVrBE7k1/SWgnQDNmHYwsc5zydBLI4YdAlmDc1Yg/x51x/1+s9R95FZclkMcwpHOOu
 Nj36DKN+6RMHBPtMGi0uKBQ+Z6NBnyAJGNclm3ElN1pUw2c7tYL12PRT+h0p7S7KVnFH
 O9YIfNYt1hpF0YNol1iYp0ccbZghp+bz//18wNXJPYj0SJUPYr8tZfkZ4XvE68AmVLgy
 i6yA==
X-Gm-Message-State: AOJu0YxNkro0ySwkomP6/nNLwKC0z/Se3MkEBm0sA3KB+czKVRyOsbyT
 jLtnCoj01dNxcpRr0gmbod5XCnI2o/dMrvaZChHpT8HrWSAHDZL80BXrfZwdKGuEyeMK6sgstas
 =
X-Gm-Gg: ASbGncuS0/3ULo4bfEmzs70RdDQGe6gghLfPvh3Wwdhuuw6kBf1/nlpfE/OS0BR9M2s
 ycOoK/V3YkbI7ah6oJ7yj6jSzEm85UZ/L0uAa54Esa54CqXSxlhm61pMaI8Yz9xpTkE0b3Gup3W
 c0OnqRgzLuULF+f896mOH316jc1MjKhtQDhkC+z5vQTLq/fxK0O9JHnLBRIpemqvonWPkNpJCM6
 3K32afCPK4KuuivMspBMd12a3g4Ep+B7i2Dp43orSn42xOVgv3Jrke4h2g4D2AmulXqD4j23j6N
 mWtgQ9ySalonH5rpxFFF4JL3HE8b684VoKJ4NjzfF+270hw0KBUG5mWb5N0MwQhsnRAX6glg4z/
 JLw==
X-Google-Smtp-Source: AGHT+IESvkbUudxnsG8Sk0sF7U8XeydhuTVWFDRW8Kf4HuTvNP4fuDqjvB9wEBd8hiwOke5DJ07Vow==
X-Received: by 2002:a05:6e02:1a0d:b0:3d0:4e57:bbda with SMTP id
 e9e14a558f8ab-3d967fa17f0mr60841125ab.1.1746061570704; 
 Wed, 30 Apr 2025 18:06:10 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:06:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 20/22] net: Include env.h in pcap.c
Date: Wed, 30 Apr 2025 19:04:45 -0600
Message-ID: <20250501010456.3930701-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file uses the environment but does not include the header file.
Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 net/pcap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/pcap.c b/net/pcap.c
index c959e3e4e51..d1d6f705cda 100644
--- a/net/pcap.c
+++ b/net/pcap.c
@@ -3,6 +3,7 @@
  * Copyright 2019 Ramon Fried <rfried.dev@gmail.com>
  */
 
+#include <env.h>
 #include <net.h>
 #include <net/pcap.h>
 #include <time.h>
-- 
2.43.0

