Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2C3C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5807187874;
	Tue, 26 Dec 2023 16:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mW7uyOr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31AD186F56; Tue, 26 Dec 2023 16:48:43 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2427878FA
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e77a2805fso1294159e87.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605718; x=1704210518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTm8Qd5DwjmGgajInF0kr8Xif9qyGlQgw/tpF6k1o9Y=;
 b=mW7uyOr5Vz6BPuzvP7g+qavZ8r7aHN+xkYPoHQGzKLNm3L4LBx3/RsQYN1M4K5Mmv0
 Z0UiVZ2MLCAlgNncxM2V50Uf4GuwdAJoOOUWoC2iIxL1dmIKuBs1aVxFUQ94HopFsyXW
 LGkW4Y/BW0OqsrZg6DOJqpQVLBg8vVAXMC8XbkqxcJ2zePr4MOBr3Ub46xYnpueS9WAv
 EcTC3FAcWQ4VekwwmH46NTL0XhrZemRsoXrm/a1B56imYBk2e4MT2JXj9lNkeQ2+r0o+
 8hfWtt5oQ2wo5n4UFXA0HoIRTRS9s7Bl/NDCumTjSWsHvvubgK4Rq4XtgL8TyvN4j2m+
 0P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605718; x=1704210518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTm8Qd5DwjmGgajInF0kr8Xif9qyGlQgw/tpF6k1o9Y=;
 b=e6Lix6VGMsfyLTgSNekvHDP0l788HRSG5Y8meiPQs5ZkeHQr6GWcG/9YmHr7AbAA2S
 dsdc60fcCWgCWr7u9TaMPySQdroJFjdkAeLQ62P71K4ElalWUIX1RJjIUum9SHuIYJcl
 YFrZxUa8itWOnVIIyxBX6yKuzeqM5zeVCSeltuhZpQru5Y/WvQGf5lcRnV8XtXxcF1oy
 nhwG19pVGM2hmAjsvULfKO4drPv0fnsHOLDf4zmbhjAoGai7QT7KPN7EtlHBcDOk/r0l
 0e1YPt9ADEF6NonODNPMkVRHZkTQ7sC43c6ujaUIPiotp9GN41iqv61ZKEKlvVIFf0H/
 5qLw==
X-Gm-Message-State: AOJu0Yx6N2Hn3Z5dfvBqNJpSFbgFztLJMboqQluS+f24EjBeYTi+syxZ
 52zhQoweN4VgrBf89pNfeX4VSNhvF4uhrfab4ujMDDwdaC4=
X-Google-Smtp-Source: AGHT+IFmuNrnf26eVZ5Rh8Y1S9XLch8mpmLq/xNuPHPTJRmIcrX5NTSEw1uydEAP5tkEMY9zcdWZyQ==
X-Received: by 2002:a05:6512:24a:b0:50e:6ed9:445 with SMTP id
 b10-20020a056512024a00b0050e6ed90445mr1211083lfo.28.1703605718547; 
 Tue, 26 Dec 2023 07:48:38 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a0565123d1900b0050e743b0b2csm1089336lfv.34.2023.12.26.07.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:48:38 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv3 2/8] net/smc911x: fix return from smc911x_send
Date: Tue, 26 Dec 2023 21:46:13 +0600
Message-Id: <20231226154619.5071-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231226154619.5071-1-maxim.uvarov@linaro.org>
References: <20231226154619.5071-1-maxim.uvarov@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

