Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85281C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 11:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC97788745;
	Fri, 19 Apr 2024 13:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cvNC05wF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C7BF880E4; Fri, 19 Apr 2024 13:38:03 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DFA880D5
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 13:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AB6B73F1CC
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 11:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713526679;
 bh=7Ma7vbyK3nmgle7GxU32OA5z6dzFwdvAB/zsfSGD5co=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=cvNC05wFpJBRAOb9oXbPYNpHA7CRFRCfqdtXUCaFyjw/LtlHJdfiNu02Fek0TCKsg
 ob+L3JGo5XgNqvic/E/x4RAFMxf0pdq1+boAt4kTiAfvk8Yd6ta7QErs1l1KXthBMU
 T7JoLb124O6K9bkJyaHQ0JNyb2pB0oBeASfcR17OG95/tBoBx9ggigErMTCqypjpTA
 ZnXwEt+FjxJp9jx2YOhQblYRO5nwbQ/fA+34+oZC+fHPDpM9ntgSNf3bf+KyGoebcl
 sbPGkboOm1arV7ZlNujZBgONJ3hcbYCWBE5BbP+eomIrqfZSZwRA2DqNgi28oInlKI
 hHqGbcGoEJXOA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-416e58bdc0eso10005495e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713526678; x=1714131478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Ma7vbyK3nmgle7GxU32OA5z6dzFwdvAB/zsfSGD5co=;
 b=LFTujgLI7pZezhRLRIR9g2574pwbiFgaWZrCnIMMI6C9xpBYOqvw3JQrAMd+TXR4tJ
 91rd36nCKSQrgLCxbl4ir9NHRAFzdc1aYeI7O4xXELwwLBYfyqsppn6HvnbyNmJSXRI8
 +DNeobLX2BSqt6oFsWhKo96zYyTjqI277jmJXSsy5B66foq41OM8ComOgN4g83iZf/7Y
 W7xabaS8ExmRqIVQgNiFmzkUUFg9BN7QGHLRNJpLrB5EnIeKOCPtyGOfHfaM0olCz+xo
 TdxR61mM9J0GMwAX/Zcp2M+H42NxgCZLaZDKcj1jBQE/bUBJiNXMQf2/quKCbgSt0KKT
 0Fhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLYYWDOAuxCeiEJZ2OyD3+Mx4wR1J56tB5hgyPsmf+1sDclReNnvTs2c9UIg7u3ieUeFT2KyV4PJVLwETRDvvJgZXfvQ==
X-Gm-Message-State: AOJu0YztFDcUbHYvCDeLQ47reXP6T9BlHKa9Ys6ewPoYiSxPrWQh/6C9
 eifqw+knSn50/3OYs7gRxmvh3cTo6WKwNRCXgVhSUcHcRnXZiNGW0Au6QfkCmVZuLtcQouwMuH1
 3lw35FPo4RHdGJBz4IrJZSUWD/ix3p4E8KHMqvLxlmt2Vx3r8zi66Uz4PI+uffuZfxMQ=
X-Received: by 2002:a05:600c:310f:b0:417:f6ce:3353 with SMTP id
 g15-20020a05600c310f00b00417f6ce3353mr1051940wmo.11.1713526678792; 
 Fri, 19 Apr 2024 04:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNkF8lIu5QaFlvXPwtsVofV2NRu24KM6sIQ1K/1fo49K39Sw8ltqpeq1Nxd6cHzqXqNFoeWQ==
X-Received: by 2002:a05:600c:310f:b0:417:f6ce:3353 with SMTP id
 g15-20020a05600c310f00b00417f6ce3353mr1051929wmo.11.1713526678402; 
 Fri, 19 Apr 2024 04:37:58 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a05600c4e8b00b00417ee886977sm10060458wmq.4.2024.04.19.04.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 04:37:57 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] event: typo arguemnts
Date: Fri, 19 Apr 2024 13:37:45 +0200
Message-ID: <20240419113746.73110-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

%s/arguemnts/arguments/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/event.h b/include/event.h
index a8f046da3c3..fb353ad623e 100644
--- a/include/event.h
+++ b/include/event.h
@@ -316,7 +316,7 @@ static inline const char *event_spy_id(struct evspy_info *spy)
 	__used ll_entry_declare(struct evspy_info, _type ## _3_ ## _func, \
 		evspy_info) = _ESPY_REC(_type, _func)
 
-/* Simple spy with no function arguemnts */
+/* Simple spy with no function arguments */
 #define EVENT_SPY_SIMPLE(_type, _func) \
 	__used ll_entry_declare(struct evspy_info_simple, \
 		_type ## _3_ ## _func, \
-- 
2.43.0

