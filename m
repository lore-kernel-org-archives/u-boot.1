Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631F5CF34B6
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABDC88F0A;
	Thu,  3 Oct 2024 17:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kMqHK3W7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 331FC88E7A; Thu,  3 Oct 2024 17:47:25 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4545788EFA
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso9380935e9.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970442; x=1728575242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OU2VUMRGCTc+MvFx1Y4JV6qJNct5kwe7bvtCsqQAkio=;
 b=kMqHK3W7c+OpAPM5MklH60oUf08xss+mUhEVs3x2jAWgQijaBLPXxSJ13Md5C7JX7F
 yqp+U7Nmbph5rSbOepaCeyIRislv2IfwsVbB2PNgdFrnBHWMiewZFifg2SUeOrUcsV9O
 E9FwNiET94Ln9LSYinyMB4gM2ORdwNXwXVNl36x4ZN5jJQ6s0XGY/S6jyNw87Jf4Lr2L
 tl41A1+AryQBJQiArnMASYHkiXVJNY5avAauWumu0Zf/yQ0iaK3ojCFASBArsD0RrjxP
 h77ZtNq9D+u2GgzegOJwITUXCPYYn8wV1jhdLZ/VGqmzjdZ4Fsa4fLjUkAe/Y0O8ycng
 zXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970442; x=1728575242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OU2VUMRGCTc+MvFx1Y4JV6qJNct5kwe7bvtCsqQAkio=;
 b=mXhmtZXrxqANSVTDFdpnVEsnZ0ndBfJjYM329QbuXMI6ZRAtKc6nNtXs3t6o9T5GoW
 NJoUM4P+XFntmE+dIqTj3GAPZN5cNq7P+9r9RsivkkQUCccQRAQ2y9i6iBfcrYhOLIBS
 slw50Qo3BOsLevrYRzY7hbtpVgt7bbfGigtw/W53zx2taP2IatRWVbWK8WxepjcuvQk7
 3MOPq4q/gjyJm1Bl+SSqpecpksIxzggb+s/F2SKG5LzhfLUnDz7Tg4/AVS/MtdTUdm+F
 57fu5DQOAA4kPU28lfqLbMaXog7mkOFd2tGzahjx1JAstLMN3MmDd9JlmsTpovrihUr4
 Kqjw==
X-Gm-Message-State: AOJu0Yxxw2N3B9IV113AddE3gxay7YahUJ0/skm0/rxqOI+wbJwfTfhH
 N0z4S/YMdW3qwRrYeBDuPGc24PKzdq2JlahqGCd4IZ/+HOg4/iWE6rmRDGoMX83qAq03DsWXNZd
 GgA4TuU8n
X-Google-Smtp-Source: AGHT+IGHFiFjZIGqzuEMCgaszGqF5KrBpVUZDGj/PUm6z4gm/kiFEnMYUDTvcKfXJnvTHyUno7Tj2Q==
X-Received: by 2002:a05:600c:46d1:b0:42c:bf0b:c489 with SMTP id
 5b1f17b1804b1-42f777c27f1mr53152185e9.18.1727970442011; 
 Thu, 03 Oct 2024 08:47:22 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:21 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 20/29] net-lwip: lwIP wget supports user defined port in
 the uri, so allow it.
Date: Thu,  3 Oct 2024 17:46:24 +0200
Message-Id: <c14ec8b9788c30c205f7b605c9d2b46ebdcdcc91.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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
index e8768fc2acd..b495ebd1aa9 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -349,12 +349,6 @@ bool wget_validate_uri(char *uri)
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

