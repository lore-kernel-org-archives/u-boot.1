Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A234C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14EF1884C5;
	Thu, 25 Jul 2024 14:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wSysDVxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B01788370; Thu, 25 Jul 2024 14:59:06 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9EEA87C38
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so11418775e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912344; x=1722517144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdlA2YFu75qIRcOboRUVZHumardm4s8P2fupehOThlg=;
 b=wSysDVxhdOsivDeW5n8rPlB2U20/MSgvAyqNk+KgaCb9gIZ4lrCiLDilWnxQKL+mJK
 XMyDglGXy5QkDDaqlcqFV3Z4D57uWFslJ+3AZyJsxmBBldLst0opoxEGR4OHAHVCcGEh
 0unrw9tXmTlBHKs2p9KRGC99Uegxqksyy8POIb/MgBd0PaLdEfKV9BfZLMayWC0pBzTo
 TNX/tVzK7ZQnB07q8nN6IADxvCQOUlCawmAYGdiy4KA4ehEYjYuttjXKJoFWR4LU9LVq
 Et9m0Z/PsJMiZs6ieZrg1fbULZqR/cvSwgc7/fvuo75S/P5qYnsoKT8Swd3RrSlEBfwd
 AhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912344; x=1722517144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdlA2YFu75qIRcOboRUVZHumardm4s8P2fupehOThlg=;
 b=KtRHipPRKnUzKiD5z8HrYWiVYlAq0XXWOMZjq8M7goaTZ17tNWJvUyJPFu4BlxXFgi
 TtI+5cI2uFoNU+imzeaXdOw9opj9iOYc7o/FfikJ7QOKa9KzstaYKKQ95KLPIkF6q3HY
 1MwJwQLZ9wzhWERPobwSpb/UTFZtsSypY+D/swi1posBVLdSDSuU/GmB8bSYQALV4cwV
 GA7ZmFx7jqQh1F1zmohZViuRutlj+n+RmPfj1ycMMo9A1p9VLbPkFeNhCioVzO9xrbNW
 ApV+sfpHaX2gdE39V2jk+0UkP3lurCOqfkOXVVNCm9mxl9Fsa2t/ohDxyM92/xdN+H5b
 rmQw==
X-Gm-Message-State: AOJu0Yz1BquIh45G2yN/04LbXgI52GJg9bo4s8piBaQjrVpcbNtontRE
 eCc+nl4r+hPQe2u3o05HF+sE9obHqETbSItswB1fi+bo0ILn8GljhV54Pj/Me+zFrDpBEgYCHtv
 FP71hgw==
X-Google-Smtp-Source: AGHT+IGF/rq6MJz7DTnj8AkpGJycGgCWBK+rdKpC5GapCSNgsQLBU9Pw+6P3z7AJi9skIqNDng/tDA==
X-Received: by 2002:a05:600c:4707:b0:426:62a2:34fc with SMTP id
 5b1f17b1804b1-42803b482abmr19253495e9.11.1721912344077; 
 Thu, 25 Jul 2024 05:59:04 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:59:03 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 14/20] net-lwip: lwIP wget supports user defined port in
 the uri, so allow it.
Date: Thu, 25 Jul 2024 14:57:35 +0200
Message-Id: <04c0aedde61c2c130d4e59d49a79cfd0f8ada60e.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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

From: Jonathan Humphreys <j-humphreys@ti.com>

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/wget.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 65a69fab6e8..bd1aab499d2 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -264,12 +264,6 @@ bool wget_validate_uri(char *uri)
 		ret = false;
 		goto out;
 	}
-	s = strchr(authority, ':');
-	if (s) {
-		log_err("user defined port is not supported\n");
-		ret = false;
-		goto out;
-	}
 
 out:
 	free(str_copy);
-- 
2.40.1

