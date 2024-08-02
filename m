Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC700C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19BB488BD2;
	Fri,  2 Aug 2024 15:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Njo9JoxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A532488BF6; Fri,  2 Aug 2024 15:15:10 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAB5D88BDF
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-368380828d6so5245663f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604507; x=1723209307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdlA2YFu75qIRcOboRUVZHumardm4s8P2fupehOThlg=;
 b=Njo9JoxHmG2uYzGezA1DOuDwIntfO0aBz4fR9yLaL/DwWAhB0pYSZTegf8Vo9XdJ4j
 0YJ4Cr/JqyAo8WxaRjeVb2WI7Ie4maoBEj5UC1T1Fw3AgZN79RbrH8UhW7kKavEAsg3n
 mRDp3BALFHQgzTxWahk9y6Fqy4sGHi2BAJoyrlwwuA1lOCxKO+uTKSRJuvkTUHSkM64z
 cdNhG5NV5eCy1O7PWO4bisPtRPinVf5xT41/80KNGFQGTi+UD/0SbuZXjNZVI++rZe6i
 KIwcCL9hX6d25E90ewnO0lTxjUFlkN9BkqsJp6FTUVbFzZbJhpKrkcDSa+e/2Qm2IDpC
 Xw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604507; x=1723209307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdlA2YFu75qIRcOboRUVZHumardm4s8P2fupehOThlg=;
 b=fKN8Ws+BoTpTMhtWrn7IN7omF8dy+BZG5HdCDJQyg3ax6bZCtDjHUlbMViVH6eJOSH
 xVJyMk7Rp8yoOQUKBtesDQwYyOZfONhgewTKy02HspnWSJLRLk8558aJgK5HeD/XnxAZ
 DvNPp5PzisL+aWuXN3pLiWXLS61sBqNLqKu2T0N7uFEDKBBaRF6BxIqq+pW28sso+7Hy
 ajvcZ9tSsssvGbBnuCPhtsx5wohOdBZGEdP2nz2tO8m7k5Ri32sa9bpSpdXEZFjiruJ9
 qifYj3WqtW+oCMNGGtLGArLg0zq5rMsPmjO0qLYAL+iQOthI5kCDfG/WZcU7JbWJ12BD
 4rNw==
X-Gm-Message-State: AOJu0YyvwO5b4ks1y23ZZSBFHvXD6CVOUyJ0nbNiDAMhj2lm/9jEuHel
 NXLt06Dbt1A3UxTG19Snp46xCnPgZl/nbl4jcoUcPpKQCatY0TCtD3Ph7D6gkAPBLRBYamV1nUb
 TP4mk/9AY
X-Google-Smtp-Source: AGHT+IEcYJloY7zCG+qeX2U/i88KfWgxj2xBlc5sPe2ZVlyp4EB4wXs9ldkfeUV3ivUsTpfANvnVKg==
X-Received: by 2002:a5d:6a4a:0:b0:368:4e38:a349 with SMTP id
 ffacd0b85a97d-36bbc0e3428mr2295076f8f.22.1722604506972; 
 Fri, 02 Aug 2024 06:15:06 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:15:06 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 14/20] net-lwip: lwIP wget supports user defined port in
 the uri, so allow it.
Date: Fri,  2 Aug 2024 15:14:01 +0200
Message-Id: <1de83ca544fd59d30d25dcb8ece60d865923721e.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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

