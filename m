Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D81CFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7F089384;
	Fri, 11 Oct 2024 12:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="I9Gk2nro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3E58939A; Fri, 11 Oct 2024 12:35:35 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7CD389387
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c928611371so2616211a12.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642933; x=1729247733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
 b=I9Gk2nro0CAwCYtTvDs4O5cS/VkeMfmwtLmi+kO/CzTNkc0NAYiLwIwW6wgdzk6yDO
 EPAe5Uba/bqglWUSfsKeAvZoa0V7rF8+QRUlI7AxzQrDILSRvObEjxyZ0zS3WkGXle4O
 tUdZoZ28gjySOypLAFSAD9VqIaAo5jm1/7FWDcwmhBQEBFSQxy7HHOoWus9RzC5bNctH
 byfXvO96lIEoxXIdg9/YFuERb5607Uqab3Ze/nII43b4d7aihIn02Pk/91qmiklsDn3T
 l9ockqKfV+SZB5Piw8m9lD4WdN8ZQPtI78tTueCAh6q2kp6waFLMzi5Y8lEwbD13u2VV
 p3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642933; x=1729247733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
 b=VVB3DYEtFMHruYvT35ZhA7IcdTse6U3fGD4SQ9SZCC+IUNVo60l3pDEp7Fq8jQTFsf
 09t1bW2YfkIQQPOJjYo4xv7Q3okLhM4HMF/g0rdbQ4Skwf2e4G1Nr1ucghuKGtp9S30X
 fq6rcH9pK7OylZOWokC9tWS9VbZDThSfLJYZzYgE+Rf28VUcPRNbHvJexXvU9gFU3Qym
 PMqQnJ74Zzjs1sosHtmQZZyNa9hX78TtAUxGZ6DDF9DiQjKv01085kEXPm3AeRf9iQ5V
 8Br8xNcRza+o53W1bzrO8qXeZ7FT6/qTT0fiK9gys4mQd52fmiP43WI1pVHor71P0D29
 uHFg==
X-Gm-Message-State: AOJu0YwwkV/lP5iEFpwutEuJOmJGOOja62DXcuh0zE+UqcU/rMpYVsLc
 DviT2zIPNqtLtChg+RImicZJA2TxzJRqNp9r54G3aR//54GGCV67+XM0a/5L3TDIrXtchto0B/N
 iBbs=
X-Google-Smtp-Source: AGHT+IEWku4cnKDqq8+sEC5b+rV5vE8pgHZmbSfpqorU/XvE+cyGXVrqZWvhJWGUPU4OX0LOOxg6oQ==
X-Received: by 2002:a17:907:f796:b0:a99:5cb5:6175 with SMTP id
 a640c23a62f3a-a99b9436b1dmr182178466b.35.1728642933155; 
 Fri, 11 Oct 2024 03:35:33 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:35:32 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 35/37] bloblist: Fix use of uninitialized variable
Date: Fri, 11 Oct 2024 12:23:16 +0200
Message-ID: <20241011102419.12523-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

