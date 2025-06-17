Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B23C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A33982D32;
	Tue, 17 Jun 2025 12:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TOTEGwTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD5D482C87; Tue, 17 Jun 2025 12:07:50 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C3782C87
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so4483243f8f.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154868; x=1750759668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zZ5v4Vpa7CEYpwxAITHXRuPqXdh/9/ctvBxOwqT1vo=;
 b=TOTEGwTwR/gVOHNjEyGkd5uoqtFDP3zmCO0ZjFOYU92p+VCrynuXCMOPQydKvGJhH3
 gfjbAf64c9LjjvbDfaSwFzd2vJfP5q5ES1LckqGNzYsqvdsb/XpIEXwNXHkisgcvEkBN
 dnGqQ7EDW8G/edKsDYcAyLO8M/Ov4KNnK6W7UT9XPEbaCOyoZ3oXgsb/yxPRGwdaeWvU
 EYuZF9HTpyvMjHrYFTVlTIJ2EdOLhBdRaV+KU5owComgubVmHAugQDjs7U4MyIRyBkmZ
 hNsWLAwtLcW8P7tpEZfPOvyZ1sbK3LEPUQLewwLW9bXsSfXq03w5kp+v43eT3Euwyrig
 CqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154868; x=1750759668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zZ5v4Vpa7CEYpwxAITHXRuPqXdh/9/ctvBxOwqT1vo=;
 b=HBvYlMVwCv3qqNzmsKUNe6a+qLDIJu2T/vtsEfLtw6x7aq75FO9Hsdmi3zqg9i1c12
 xiATpUlne7qW4DqdVWx2paIRbwjk24aF3pRfnehJiB5x9OQm+9nmC+fpD07MUfX3Ml6i
 yjTKDcujDDj/WDqX/zVaBQs/URiO+0QRVy41AOvoajcZFyN+/Mk4lNkGKiIy9QK3r4o8
 dI5pK3QkdebobB9feVwRQfEh7mCA6bBuo1NZ19H8vyypX/PzzpbOwRVTNGiz51CGQi83
 erbfNlX38EsyUFWpJa+96tABG2iQYEuDw0HUE4Lb/09ue7MryIyLGJkP/3SYgh2HH4bl
 46ZQ==
X-Gm-Message-State: AOJu0YyU6hXO11QFxF5Hr2wrRGGR1O3p9NOCvnRPeuJ8Jj/oHOU2UV+S
 lXlSj+J5RHRjeQQFZdS5X/smMArp5PSZuT/dqyMkzUwBasVIxWibNK8YzUGpPrkNj9WbWBsbjfP
 iyvVr
X-Gm-Gg: ASbGnct72rovMONiAoVwleWD2DGzP+E+CbjllsYeWW5wQz54jBRcBFOUkmSYsxetTeI
 xmRmu06ScaGncxmOYFF72UsZNM5yxH+79SD1OfmJ86hJXTZqEto3SmN29nhFSZ7+rn2hZbcNWrR
 2WzackCHcgkgkx8EUGS6M/9Q/tAYh2uLS1usomeWIZ2wKthd4wXZq8tO9cqN7dNGp7P0F/0RV5R
 iayIPE2qJRTF0xy7h5NR7Sa9QIXBZ0e/Fia/YsvnF9PRzIj81dgZXIQTaljSRGslX8+5HJPT7Zv
 s7PdcGwX74GPTD4yZtKaq94ZvSGgwc6x70CV7h8PAtVPQrRyDbs6x/uzy7jaTDUi90hYv7M=
X-Google-Smtp-Source: AGHT+IGs+L5fOWKrAHT5mZWSc5DLm3ZOma7+5tmBLZArDr0qp3LJGMAOPsnq2tOdKRwnriDf3npFiA==
X-Received: by 2002:a5d:588d:0:b0:3a4:f70e:bc25 with SMTP id
 ffacd0b85a97d-3a572e85b35mr11015526f8f.27.1750154868057; 
 Tue, 17 Jun 2025 03:07:48 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:47 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 06/13] lwip: dns: do not return CMD_RET_FAILURE on
 successful resolution
Date: Tue, 17 Jun 2025 12:03:56 +0200
Message-ID: <20250617100720.2544758-7-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617100720.2544758-1-jerome.forissier@linaro.org>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
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

The DNS loop checks for a non-zero IP address after DNS resolution, but
the address is in fact never copied into the context. Fix that.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v2)

Changes in v2:
- New patch

 cmd/lwip/dns.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
index 13da52b59b9..4689ecce513 100644
--- a/cmd/lwip/dns.c
+++ b/cmd/lwip/dns.c
@@ -38,6 +38,8 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 		return;
 	}
 
+	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
+
 	if (dns_cb_arg->var)
 		env_set(dns_cb_arg->var, ipstr);
 
-- 
2.43.0

