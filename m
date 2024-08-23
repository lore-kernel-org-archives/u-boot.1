Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D93C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3140088B5D;
	Fri, 23 Aug 2024 15:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UAlXL8nl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB4E88B13; Fri, 23 Aug 2024 15:49:24 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CCF488915
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-371afae614aso999816f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420962; x=1725025762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5c54Y/Z1u+SJekYUfgCqCf8R4TK+obXabSgR9vSpbY=;
 b=UAlXL8nlBpzpTSxbyHk3oZaOt8xGBMpGx22+6Rc602lcVFmGJecfNQ7o3EuGfh3Fok
 ykDpkdPJhBNWxIfOWX+UDpKBtMQa2C0Ov7oezdhDIUG2QfeKrYPIxBkrdLx0X8Gms+AS
 WXfqKWPzFRnautmg9CxlCn4IAnWoMTZkUHy55ZG+SUj5RYRLJ0Kil9dH/lF+QEbTAnRc
 QvUhmQfA8tc0i5zTszRgd7mJUZykhCpg1ewgZCiHcJnawpqDnLNQ50YtfwqELXBTTao1
 bUqUVPsIsxJLYch3yqR8iMzlM7WGwMAJWsqE3yCmfGd7ODOOuQmVtmTGjyBTIXL6+BU1
 qXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420962; x=1725025762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5c54Y/Z1u+SJekYUfgCqCf8R4TK+obXabSgR9vSpbY=;
 b=ANZrTTrBWpAY2FHCdy/As7L1ZUK7VuMW40i0C1nNCjAq5yaKk2oPAYkzvip+GURHIm
 AET1uaU+6yfynb0a4tFcR2c8Ei0yQ2ugX7CTxIKhX52oUzHU15HtFp69/f5btdvFRMoe
 ef3+G3DgWjNYkEPQtfBVBy6IkReDp7gdubNKztfLZjHUGY+qkyf50Ht0Zh2h0cMbCyMd
 Pb/ZP2z5jRPB5W8ehx0pBqO0Up329seAQXaR+NiKNKPMMXdhaJb6jq/EtG7JD26crL+E
 XinLEQ/YYKNq2O+kZo1+8uv+g539hm/H+7L2+3srVKF6df9TruKLT6qxI/q0onP58REW
 pX9Q==
X-Gm-Message-State: AOJu0YxUJ5p7t5P94S8lC4MBEO+dv0VOExWwGhW+h0Hl0ti0gLafnpz4
 ZFrBvCoZWoauAiXVcmqKlG8G/byCs/Dr2/IvDq0gqKDZGXA1ClMi2s0q9ztRyu5WJfxsXqbJkJO
 HolKA3ZyT
X-Google-Smtp-Source: AGHT+IFLbcNs+g2AiNJybdUQNf8misCFDodGMmj6sQdHG13YXsli4QDgFDpRs4W7bFcMVMfyTiyYMQ==
X-Received: by 2002:a05:6000:11ca:b0:368:4634:c419 with SMTP id
 ffacd0b85a97d-373118e40eemr1583879f8f.58.1724420961817; 
 Fri, 23 Aug 2024 06:49:21 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:21 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
Subject: [PATCH v9 11/37] test/py: net_boot: fix comment
Date: Fri, 23 Aug 2024 15:48:15 +0200
Message-Id: <1c773c44fcb7c4e792fc23f1d0f5bd19dc4ca6a1.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

If env__pxe_boot_test_skip is not present, it defaults to True not
False. Therefore fix the comment.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/py/tests/test_net_boot.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index 63309fe82e1..d7d74356928 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -75,7 +75,7 @@ env__net_pxe_bootable_file = {
     'check_pattern': 'ERROR',
 }
 
-# False or omitted if a PXE boot test should be tested.
+# False if a PXE boot test should be tested.
 # If PXE boot testing is not possible or desired, set this variable to True.
 # For example: If pxe configuration file is not proper to boot
 env__pxe_boot_test_skip = False
-- 
2.40.1

