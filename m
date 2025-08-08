Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A896C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3763846F0;
	Fri,  8 Aug 2025 14:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kCtKJUsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8410E846E7; Fri,  8 Aug 2025 14:00:28 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B5F9846E9
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-459e72abdd2so11851605e9.2
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754654426; x=1755259226; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=al8Lgc13iQtE1nW9oGF/yMUdXDNzPmoqqjTs3/qBMCI=;
 b=kCtKJUsICYMdJG4mQJpKa2hsl0yHL0bGiKgKpTGWuzCwgopIJPGQroqhy7nvIZcL45
 G4zUJA6JPEsAgWIjsyp0XmTBlUq3ElfborCPfrwKh9w/pxUvLYf6HEYDmvOuoI+v2WxB
 QpmBjOM86VzV046bCUpnkKF/j4SjTgwEG9WODgbTjSdDXpaoFTqeM1VExe4MU7d1lRfz
 UEQ0yu9Z2b1UP1NGRaD4K/xoRk6ES/bPKlknn/8xxY/Uy0LvFiKTMl9FDZ09a9tWfsDi
 GLrD4DTzjc8xSdn+P4G1jGappf/JT8EE/WZRvrmHY1IBFFx5zIg6ZowfWNCyIVWw8j2f
 rmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754654426; x=1755259226;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=al8Lgc13iQtE1nW9oGF/yMUdXDNzPmoqqjTs3/qBMCI=;
 b=rWQj+tpKeQoFfXstFHzN5uQnK21vrRBOdKhQFTcK8XyD3zlae8gzd2uKyLJhZ4qFm8
 XyPK3Jr2MESAWz6f202sBdSV75e9TT0e/a6F5J5aKQo8oUJV6o6k1bp4RQdlLtRkdC1+
 4z9KdDMFimGotYfO9XRsaM9kjet1pap4xXPgqxzTJXbvqz7aBRT6ygIh6/LUkR47nAGS
 gt//+R5sAAERs28DGeRLOLkRvvGk/QfZlohuaZyEg0NBwyE4pmutRS5t+mICnZ5jlvZR
 Ftw3xN7RW0/P4SeTN59vpI5xJpasFDATxDmEskwrIOhX7iNOFPXvUSXifuFJ24StSz0j
 NjWw==
X-Gm-Message-State: AOJu0YwdmZdHmgOYUiqEGoj2DrpwLp5gOMArEnx5cJk1tJUATOopQe25
 kETTL3w0N2Yz9uiNJkBm8OvvaKbl/yNiDblej5ju2vgg2Dwr18u8d5G7CNXor7QJwkY=
X-Gm-Gg: ASbGncsy265D2tG4BmRQ8sG5oruTbZK9A2lmxAzfKm4TRxSpH6NvCxSZAMGWvSokaI/
 oMIDxFa8Rhl1y1TW3HXulDQVspkG73Yi6G6idoMODVTrD49l5Dmce6/RdZh1kjZxPHkGkWzxXuf
 4+w+ffFiSCeuIc+5pmISvXNVDRDJ6euTU3tJOCgfRsGhFOeR93TrZuL9eK25IqSOYmz5NsvyRl5
 3mn4+aingIJQvcJr5tecYrq9jFt9vSgvFNpr98tc5vVdvLEYz8Ym6G9WJbMEIUoEdJ67Fbl/H0n
 VFT4mZZ8NXtiO485fOFJGX0mzjcCsxlK32e3ijbFnGMAPqzWqFmFYPIYwKHuqqI5Ttu4MAF6gGo
 KY2nwZ+gQC8Yj1hOMWKgTqiKTonP4oKpjHJt1KkJWtnStUBfHdjU=
X-Google-Smtp-Source: AGHT+IEhS/IOEUvjVwyW7iF75fDL0dk3IGQmDaYeC0ifSn4g5OeUY/sq5hEBLbNZg7M2B/MtIq/hrQ==
X-Received: by 2002:a05:600c:4e86:b0:459:db5a:b0b9 with SMTP id
 5b1f17b1804b1-459f4fb05cfmr21403625e9.28.1754654425540; 
 Fri, 08 Aug 2025 05:00:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e7fc:9a8d:4024:d186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5c84b8csm69962645e9.4.2025.08.08.05.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 05:00:25 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 08 Aug 2025 13:00:22 +0100
Subject: [PATCH 1/2] remoteproc: ti_k3_arm64: Cannot set or compare u8 to
 16bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-remoteproc_tik3-v1-1-f7dae0b177b2@linaro.org>
References: <20250808-remoteproc_tik3-v1-0-f7dae0b177b2@linaro.org>
In-Reply-To: <20250808-remoteproc_tik3-v1-0-f7dae0b177b2@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In the struct ti_sci_proc the fields proc_id and host_id are declared as
u8 so cannot be set to nor compared with a macro defined with a value
using 16 bits. Change the macro to only use 8 bits to make the code work
as expected.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/remoteproc/ti_k3_arm64_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_arm64_rproc.c b/drivers/remoteproc/ti_k3_arm64_rproc.c
index d3eb957b2e4..403c6bed2e8 100644
--- a/drivers/remoteproc/ti_k3_arm64_rproc.c
+++ b/drivers/remoteproc/ti_k3_arm64_rproc.c
@@ -19,7 +19,7 @@
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include "ti_sci_proc.h"
 
-#define INVALID_ID	0xffff
+#define INVALID_ID	0xff
 
 #define GTC_CNTCR_REG	0x0
 #define GTC_CNTFID0_REG	0x20

-- 
2.39.5

