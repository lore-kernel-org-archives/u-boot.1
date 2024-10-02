Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83E5CF31AF
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C70E892E6;
	Wed,  2 Oct 2024 11:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="YvRSX8Lo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6AE8909E; Wed,  2 Oct 2024 11:53:06 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C35B88F64
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cde6b5094so58117135e9.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862784; x=1728467584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
 b=YvRSX8LocO8oHGtMTRMgAVPBf72DKAs3rDiaoBCtgRKxxExUwDczimuMA8N4ccXry0
 pK97tjHVSu7JX8sXk2dABgoSlAvcy5l65YJ1vnz2ox4+g3d0WLOAlNlZpagyL8t0g2bW
 nst7VSAaMhQizUbkfbKQqwFrRi7bmM7/1Gp5MknzubSkM7cJJcvV7AvGW9Unauj500bS
 O8NV/tZ/Xr1Q+4/lVxhL07QsI+0CzWKsgPLKw6wdtA1DwYrIvxs4Q7gaISlK0GFkp0DB
 5L4nmKZg+G4s7VYkMsQNPOIc/iDE+O1AhmFSS00Lv+n29Xfk+A8QKUbzWASIFvtNWWDa
 PQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862784; x=1728467584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
 b=RIRSvbzcD+WH1qv/ZOyR59nsfwOhkU7Piq68E/HyF/DPvKQLtpbOKcSNMkDLtrWITV
 ER1pbDaPEARDiw9OII3LQuLwiQdPdC+gNI8RQQph16kIEbUQSXIJST8nc9NBjNILIjbH
 mqA+qpdyPMXtaOEPPKReHtj4mHyqH+07UWtE63iIpxrIJ8EUYcAvqE1GUOxbRUBjPDjq
 kFmdD2h38oPQqMnMHwblg9LKXsrDvMKDR6K7xdfc+a6WiYtWyrMt3Y4Pgl3khteDC809
 j4XokUbgFcHIz5BybctTTJSrpLQMsEqvBQmOie2Zx2S3wz5F5e53grTAdqjCdsYHJ9Lb
 NEew==
X-Gm-Message-State: AOJu0YzmsGHaqqe5A5glHqRz+f3u0WmjKxlnzN9EL89NmZ1eLvObTg0Z
 BGQPoHQOI6aL4j3Tu7Yw+fcOKjwbVmo2uMmzuScIINHa99DZtXRM43B4ojKvXplS4PoH9/1lT1w
 m
X-Google-Smtp-Source: AGHT+IF5ENllhob4HVuzWBT5I4b1Fpp6RnDUCZA83Vl5cMB0AyC0sOUxg+PT5HXx00IekSQKVstslA==
X-Received: by 2002:a05:600c:3595:b0:42c:afea:2a10 with SMTP id
 5b1f17b1804b1-42f777c8559mr18958795e9.21.1727862783976; 
 Wed, 02 Oct 2024 02:53:03 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:53:03 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 35/37] bloblist: Fix use of uninitialized variable
Date: Wed,  2 Oct 2024 11:47:26 +0200
Message-ID: <20241002094832.24933-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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
2.46.2

