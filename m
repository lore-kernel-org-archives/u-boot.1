Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136D9CDD541
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D3988FC5;
	Wed, 18 Sep 2024 17:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Q4/8sU/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3279C88FC9; Wed, 18 Sep 2024 17:23:10 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BFA88FDB
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d2daa2262so727425866b.1
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672987; x=1727277787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GKGe/hWzpQA7CxmPNU6MTXkgQYFW9SlpLsnQTn498s=;
 b=Q4/8sU/oiG1q15ARfb+wu4/4QcIJWGYWfX5BAIo9diIqEEWv8XHH8ZWF85A2qKta3Z
 wL4yb+wXAewv/8oNTi7Vz7BxOI9HrIyuwkF+3BMwhCuvi2lQGU9VGWWTMh6KmJ0o3G/Z
 I+b7KDGNsmoOr2mKxi4KH7MrFFOiIXKBZOTC3CcrYKrDSDloHDctp/aVI0ohI/s+Dk4H
 rH7qG64Dz0qeH+cSYNQTuG3jJxZmS+ge9QyPd/8WgiqF7B12lhXdd7RcRbJJU1gzUQ1Y
 mAM6+LkGyC+RrbvKkvAhHIAGb2j3KOWT4J7C+GaSvBPsXQKvsXfxYBy8KxHb6rJ8xCug
 8k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672987; x=1727277787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GKGe/hWzpQA7CxmPNU6MTXkgQYFW9SlpLsnQTn498s=;
 b=AiOrQS3IZc8ijNpo4SRTZo75PzS3HmGjDznxXMq17C22UuPTMadtFhpWY1dbRz5Dct
 Wz26LpCY4Yc37lu2ofVswkUPSKHHccEtBmjFU1QAggpAHDH7qNSmJqGk09IIW+yW1/zI
 qLauI7EuTH90qEDoWprmA+Fx4i/xuiy0cZiY4y1M2A9ng/lcTZG6hIxma4kn+TAOeTx6
 CZRS3D+H7S+J9Cg3YKJ9izdxEd7y1zWG0TXpd+OCD0nO1+91FuO8RhfhN2l+KHQrqtgd
 q3zIKEXUsIjDy+9IHTo7C47pbhhDumzLVTiMd0aSIbuvjlAdnivTmfA6+Yzk0auwNfGH
 SNEA==
X-Gm-Message-State: AOJu0Yz66KnI7eCKt3FWoP8i4D6KPidgQDiz0+JL8yCrgVgdAiG2Dfes
 V/k1t6Ng5I/iZ3T42Ae68Av/Va2RHEYZdBbrPEXtrx4nTA3ont1A9FkGe/ukgMkcTddsFwm4Pz8
 +
X-Google-Smtp-Source: AGHT+IF27oxPM4gwWIjWaGLhEuTY+DzoBkiUWe7zvlHUcynBEODFEkD9+WkQ+qhTyttimMbGk2RgrQ==
X-Received: by 2002:a17:907:e9f:b0:a86:8953:e1fe with SMTP id
 a640c23a62f3a-a904810755dmr2029019966b.47.1726672986922; 
 Wed, 18 Sep 2024 08:23:06 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:23:06 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 34/35] bloblist: Fix use of uninitialized variable
Date: Wed, 18 Sep 2024 17:20:38 +0200
Message-ID: <20240918152136.3395170-35-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.0

