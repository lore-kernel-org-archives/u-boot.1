Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71909CF64A0
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D0BE88F3C;
	Mon, 30 Sep 2024 14:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="efyRG8/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3083E88E2D; Mon, 30 Sep 2024 14:44:49 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90A988E63
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso38185845e9.2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700286; x=1728305086; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JeLKja+MavrsLxBtauv98C99CzvsjKPwivvG+QizMjE=;
 b=efyRG8/gTcJzCX+48zhg2Y3cWUoskIk9QosPXJAudNVg3Bkp6Ka9WUL5WgYDRjwWJm
 YfM0z9m/GdzSEWZdezQQewKfnWNdVOkUHjqV/A4HES+53MmCPkFwUAVcrq0Y/UticcZ8
 ApP23NQWcANpRz/Gqb/4Qx6ufMszSje3FouSkFIGps1SAS75Z8xJcRl85exrCg4ZG1Vf
 nSRy2dCM2k4UmWjveVKAeOm/yBEbqEQUuSGV0alHOS9aZZUPCsER0rkvpsQNbabqxaU2
 3m91EAu5yx9C7qUvEPQDA7zAm6zWQdou5+V2AowWexMH8BkzMhou3bceLoapeSR1pb9A
 TAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700286; x=1728305086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JeLKja+MavrsLxBtauv98C99CzvsjKPwivvG+QizMjE=;
 b=Ifcq99kDNzfNKTdVGWVHmKVjlU3px/VFlnY0geBUoYx1/R06cWusshFH4eK+ZVQFo5
 shBt3Zme+N3SiC6r33FSuIW1kzqcQZYJmTHESmOaPbFpMZ+bC7l4e8bwkhUKhu5Sc/8M
 GpIMAD+0wM5kqte8Ov4IR7/06hCfnAb51WAP7MVOSrIkTGfj9AknxCiJEhjkVO2kvZWW
 5qF+s3spP/tEtJMbp7HaL+Zfd8yCx8dEd/E8VALTY0MQE717WtUaZzFfU6P+yU7VNE9c
 KSqJfOxvmAhi508oO10yqyc6LtcmDDC7V7acc2yYO6tx67d3+Krm5VZ9HnWfT0iiLCjH
 0Tng==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9dJdI/PC44Ee83pv2xSS0PSrS2E5rLMIPWEQ1T63+TeyOaNFee6hT0VBR1fhEb2cCwaSiAy0=@lists.denx.de
X-Gm-Message-State: AOJu0YyG/OVYF7nx0YzFSTFNl8DyD43NI5Kahwjo8qs0QOgOyGLJBbxC
 tzuXS4Tgvji4eBdLdhU3KVPjmzriidJmtVQaeCwhtUWg9NfZ5N9BKktZneWE8fc=
X-Google-Smtp-Source: AGHT+IE9s3TorGmBCRF2iiAsXa1+Sn9spHShjO4yO0voMON96YBVyecxCUGQ2c2ceGL4Yx0xpCQRFw==
X-Received: by 2002:a05:600c:224b:b0:42f:5ca3:d784 with SMTP id
 5b1f17b1804b1-42f5ca3de33mr81510025e9.14.1727700286362; 
 Mon, 30 Sep 2024 05:44:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Sep 2024 14:44:35 +0200
Subject: [PATCH v3 13/13] MAINTAINERS: Add myself to the list of UFS
 maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-13-58234f84ab89@linaro.org>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=815;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=teMxOUDq733hig/kyMWLnRxRkGZD1mGA8yJ2cdp3EP8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0tE8kM1kM5SaB8jqKWZSv+gqJmHPdsxYwrCoSi
 sytRIV2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdLQAKCRB33NvayMhJ0XngEA
 CBUQBpop4DftgfX7HjtPsQTQvZ7udq9ilQZd9jujFrL8AK9RfiRxPrvpQzyDJUUqnevrj3jCOncgCS
 RSmeN6vN8KgU7b1N/hSkBSLm5TunRygPRmDuUoOdUVIB16LKMzfD4SvJ3YeXmROi0OwL/CuPe8SEOY
 SxmsZFWt9WV/e9leahat9B5sIW+M0vm7pLFzSbZYi+ye0l/AROYgYnxhJhv9+dpAMcWTee9fSaEZSM
 0ZwPhkGnCRxSo2OXpdMQXU0xh7rYcq7sGQcF7wJu5Rk1xgrfNeIRiMmn+wJoj1/YvGQaFKwDtb0KsZ
 TvM0Fn6GCyAGYS8KPQcPLQLQS/JAmk6S7JcNawy7Okp2TDhA448F/Fx5ZjZOTwQmwkASJSUtqsXmQ/
 UBn7sCwP4UIryfKbtu4MyN7wF2/lKFiR3R0nXWlWty85agRVNWHALTD3Js5Xfd7Lja9dop2VsESlYi
 5iEpbbPZmrIDasRu1DZYpakKCUfwxkHqIUFqSFK8FEwmUVCkGKFF3WP2iuaiK3MYD3HuaQIfYFfPCb
 4pP8FGXV6Y1P13FVar4Czp+SIGKW14Alri8cxNNhgHAc4+LffN07Ar/8O3tg/6jWAMlMyVv6PRKjy4
 4E3Q/asG/B9DrT25LMpJzmwkZjbDfcJyH4JTuJnRKdDgr6Wqcg16WQz72EzQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Adding myself to continue Bhupesh's work to enhance and fix UFS
support in U-Boot, especially for Qualcomm SoCs, and help review
patches and maintain the UFS subsystem.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ab39d91a55..14809c057c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1707,6 +1707,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
 
 UFS
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
 M:	Neha Malcom Francis <n-francis@ti.com>
 S:	Maintained

-- 
2.34.1

