Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB41C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 15:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DC3877CD;
	Mon, 25 Dec 2023 16:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="soqaoj3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C180A877D3; Mon, 25 Dec 2023 16:41:56 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C600787767
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 16:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3368b1e056eso3461103f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 07:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703518913; x=1704123713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RT7RsSzsdLSxuFFY+pzbV0GIbjwfPtWfJC6y2Apj2w=;
 b=soqaoj3sJN/jw9wPQVETqwkSAa7pehL9JwLHPvTg87fspRJy26QDFyuQEZz9B2LH8v
 fVHRmAUqUgj8cdSHidYCqR52J1OmSgEVA1Nu3pxcsxrUj/GKcLbXFtRoEQQRUKtVOjsh
 ApKJx+XjWInrwHgTF5fQPvMJntqrpgRKFLYIWH9hm+Fu2D6tk87+/9Vj9Q2Bk3zvq8fE
 BVcjcX7VhfZPVFgLbJOZ27ijYtJPVea+xS2EoDHXbcsMsgVTNX2bjBJbZVBUO0PeXJW6
 HlYO3QkdEvtyMva9x3FB2M+fpwjkGFKFnPdaMnfHGQ0DfZjOWLvJGwgudqrzLnZe+RWD
 K4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518913; x=1704123713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RT7RsSzsdLSxuFFY+pzbV0GIbjwfPtWfJC6y2Apj2w=;
 b=vnk6eu1nyLG4q1XOi/MkcmOIvOUY7bjCLnuh+NoI9V6aKN03BCrF6e43nVXBWGhDSC
 +TUvebKCQ6YJtH7AmB6P7t6fKW5rccClofL/FTJpgQn7x8tXFUdVTon6VK7P/x9kVk4C
 l/uM8qOl1jzICQ6eRY+ZQ0B9osLKfa6mkHZI7H4BptMjoi1e3+6UCvf/EfbSo93wa9uR
 4LKDf2xCBDYJCmTk2Bdq9W01Wu6nnvcN1Ps5hMAuZ/HUMOcTaVeiUjuL0RWLvfTgpmLt
 2OrV8HEpHwxzNvIpjHIPNrzV7ym5ou+XiGPLMtbsNaeYTfXTHPb/vR5IxcaSZX0fQCZ0
 6C/w==
X-Gm-Message-State: AOJu0Yw1OaHgjYE+G4TStQt1bkty/kx26/Tui1XAMIYQEDBzC83u0w/J
 g/gKc7ysZqyQoshy1/PLyDKJjAjmFxgkbQAYaXWEyyud1NU=
X-Google-Smtp-Source: AGHT+IHiHB7c6JN8eDIz/Y9wgvBgiHywlUVvYYIE5PmS0vf5atAN7Fqk3sHJqskczxQcVEBSaaWKRg==
X-Received: by 2002:a05:6000:1369:b0:336:74e1:455f with SMTP id
 q9-20020a056000136900b0033674e1455fmr2754270wrz.38.1703518913519; 
 Mon, 25 Dec 2023 07:41:53 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a2ebe91000000b002cca6eafc44sm1425644ljr.113.2023.12.25.07.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:41:53 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv2 3/9] net/smc911x: fix return from smc911x_send
Date: Mon, 25 Dec 2023 21:39:23 +0600
Message-Id: <20231225153929.8284-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225153929.8284-1-maxim.uvarov@linaro.org>
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
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

return value of smc911x_send is ignored, but on sucesseful
send we need return 0 and or error -ETIMEOUT, not opposite.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 drivers/net/smc911x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index 5c5ad8b84a..616b7ce174 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -403,7 +403,7 @@ static int smc911x_send(struct udevice *dev, void *packet, int length)
 
 	ret = smc911x_send_common(priv, packet, length);
 
-	return ret ? 0 : -ETIMEDOUT;
+	return ret ? -ETIMEDOUT : 0;
 }
 
 static int smc911x_recv(struct udevice *dev, int flags, uchar **packetp)
-- 
2.30.2

