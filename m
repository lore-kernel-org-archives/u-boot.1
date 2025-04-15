Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D20C369BD
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 19:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8663982B3D;
	Tue, 15 Apr 2025 21:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZrLvDttE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563DC82B3D; Tue, 15 Apr 2025 21:34:52 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BFE182A27
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 21:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso45355275e9.3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745689; x=1745350489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W1h5b16QTIYZyya3n51BOaw9+qGTKuF6uRQJIPs/x8M=;
 b=ZrLvDttEQN6erP8n4OLH3oaCM6awXpJ42IgGWkleCLhyjeRT1ZHJgGlV8bvW/6ZXvW
 WAVYIorksa39XEe2RDqWNEeHs/TXfuSVObChKOFpWTo2M4yqS+8kUdbYPzFXris3cAZv
 X/TdQhfQJa/lb66Tp4QCswGFerinH9o6oGzhF1d6XLhl/ntAzt0beq/w/siwXv28LmvS
 Uft8nohJSdG22WrUSCoStS9d5+Ktlhl2CRheWEuYGIS3kKf+lccJbkkPSUAEy5FhPBv3
 TuIyEnMar/GlNnnMO9M55r3R1vtJocta9LPrumTz9O618QdnmuTeCCnpQPQIarR3wdH4
 ORaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745689; x=1745350489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W1h5b16QTIYZyya3n51BOaw9+qGTKuF6uRQJIPs/x8M=;
 b=sZoCAVDtEPLtbJvqBjBwJlRT3ndP1AVFvg3N7HAZht0Is6zjMHx92BooGv1i+luETM
 J8l3sU60vwGSTmf0jya22KgTsNoGG4vy+kE/ZQHk9QzJYspn/BYUimU3fOdbN0Z55cFs
 0O6HXTEsY8jt8Eip+ptif7hSr6puJDrN3VCFCoXIeCznw2vqNfkGqHWQ94zjv7mfXLfB
 +SNy06uoZf0kmB4MYFYs/mPhhFRi50rbkHrYf2Rc5+yTVXLLPOxGq2uJpcs37ovpXB66
 mbksXdc1vTjhPs4s4oLtMtt6xHZHXeihaXKeUCPoZEfuuxMqWiJ3ZP0J/6EHu6xPejF/
 4Khg==
X-Gm-Message-State: AOJu0YxWCvjhqXzWhM0/48RCOZGbj4pp2uXmLtEuODpZS/opUQ5p6o4p
 GTwKmoFAaMRyIBEq/oxRm0nKssM8AdozomaJx9qhllOH8wLRvCuZbWAjrw0R1E+8k/VVCZ800n1
 0VQQ=
X-Gm-Gg: ASbGncsp+WQa3wZzMgg3D0hXRN4XbCXvehhjs2xTNtSqnAp5CvxAYC2h9xq26A3k/r+
 FXmxPgccuq9F6gkYV1aozfjcqAa5kFI1UJP03LVV2dvgPP2ZfeiXmmPM9/wV/hn9dZ0wnTj4MJ0
 2IILcTLOeeRqbUfBpnapX7YKYEu0lwGbYf6+dXIwS0Tbeal/FAKJ61hI/+x6P45q++t+YAi8lz8
 QX2SDZ8le2hOCOoT/tAHIE2g2eXXOIbfVxmMmpQ0m/vJc+hA5Ajy4UhJS0Ls2miUGn3dEIjjq3f
 l1Yq23A3dGpwnukPRvUQ5fe6eV9wkwjEvnl4Dlnk+ui8iWPQ
X-Google-Smtp-Source: AGHT+IGvQXbot/at6dje3BHvio4RQo7HFtkMREzg74gvuY+I5Yq+0byq+G40D4D+Juszk7UX7h8mww==
X-Received: by 2002:a5d:5f48:0:b0:391:4674:b10f with SMTP id
 ffacd0b85a97d-39ee2760552mr633721f8f.36.1744745689483; 
 Tue, 15 Apr 2025 12:34:49 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43d046sm15520484f8f.63.2025.04.15.12.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:34:48 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 0/4] NET_LWIP LMB fixes
Date: Tue, 15 Apr 2025 21:34:25 +0200
Message-ID: <20250415193436.1240804-1-jerome.forissier@linaro.org>
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

Two small patches fixing issues with tftp and wget when the network
stack is NET_LWIP and LMB is enabled. Plus one prerequisite patch
fixing a problem with wget that does printf()/puts()/putc() when
called from EFI which is not allowed (messes with the console output)
and a small refactoring in net/lwip/wget.c.

Changes in v4:
- See changelog in the individual patches

Jerome Forissier (4):
  net-lwip: change static function wget_loop() to be wget_do_request()
  net, net-lwip: wget: suppress console output when called by EFI
  net-lwip: wget: add LMB and buffer checks
  net-lwip: tftp: add LMB and buffer checks

 include/net-common.h     |   2 +
 lib/efi_loader/efi_net.c |   2 +-
 net/lwip/tftp.c          |  56 +++++++++++++++----
 net/lwip/wget.c          | 113 +++++++++++++++++++++++++++++----------
 net/wget.c               |  23 +++++---
 5 files changed, 150 insertions(+), 46 deletions(-)

-- 
2.43.0

