Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DC2D12678
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 10:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A1788DE9;
	Tue,  5 Nov 2024 11:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QhyGKBq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B3BE8903C; Tue,  5 Nov 2024 11:25:15 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BD788CF1
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 11:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so62576325e9.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 02:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730802312; x=1731407112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9bHw7K9BgH5k+SryguSsfvzZySLmUUR4xk5OTHD6sEw=;
 b=QhyGKBq39MeJj7vUC4xc7cMqivIdlKd1aNtiwcsAJ86dpSMBOhChZnn9P2OYorVpZI
 Nk0ntKYgDJN9aOaKdZy2vKbpOhPY9IAYbwtpYcuwrFMl3W7qxAVKsR+pd3EEq11+6HTk
 I9K1pw8BvMPZMUQT0qF4UQvgVdBelbtLkO+b2DrKO2H5bgwmtUAcpjp8wMlO+If11c1U
 /GnJKWrEjjUXcpN2uitgmaLymkQdFPLvlHENCsEewnMzl9tY2m1r1oJ0i7sn9xdLufXg
 VJ/sSjvgtzMrw+VyhJWraHNJCj+eAxiy9feZu/IRFE/gV/pEDLGR7pttBmkHe+ETDmd6
 39RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730802312; x=1731407112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bHw7K9BgH5k+SryguSsfvzZySLmUUR4xk5OTHD6sEw=;
 b=iI5S6PWD1KRR6x6k68HTEr7kkQNCm2uw9V6WA17qECWDI0wjABisSw9cxJb06/Dro3
 /VzElYWs0HbUtDjxgcuK6neX3skFTBRmdpC8vOM6tTOMKlyiPfiPD8bOzvoYn9HFcIsG
 wRdXPVtQEWJUc6pTq7+0BAzWILeMqDR9+OSnxKITPzMODi0lGJaYIs02hPz7yevUNjIA
 p8xnINqqJN2l0qFIb+U/OuW0vCfWunRhVtQ9PLwnAgzLEv0UuaZmrkUPcARPE7LgyYnr
 0TeeZbUDNJaqnOgB9JDGZpl2DY7TLrCxMb8VQb/F+oMocXxNvmUTuJkHp/p9NU/96kDq
 6P+A==
X-Gm-Message-State: AOJu0YyOXnhGaIGnEIvLTHUANlDUjmBmTdsFU4OmYE8NXbazGnHAQZ4J
 2kMOXmeYIS63Y9q0LF4QN4J/VtoSorbZAr2C8+1qgP9M26D9xBiuBu4Z+7U2ExDQJOBZzy47/WQ
 f/fO4Q1AK
X-Google-Smtp-Source: AGHT+IFsgNNIabfX23AvS57DLOLHxz3dhQhZVSp/xv0n7OTsbewl05T7fme4AEgKiM6n2PWNUQtD2g==
X-Received: by 2002:a05:600c:4455:b0:42c:b508:750e with SMTP id
 5b1f17b1804b1-4328324ae6cmr161445835e9.11.1730802312571; 
 Tue, 05 Nov 2024 02:25:12 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd917fefsm209675835e9.16.2024.11.05.02.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 02:25:12 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] sandbox: net: lwip: use EOPNOTSUPP not ENOTSUPP
Date: Tue,  5 Nov 2024 11:24:53 +0100
Message-Id: <20241105102455.10141-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

EOPNOTSUPP is the recommended SUSV4 error code that should be used
instead of ENOTSUPP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/sandbox-lwip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/sandbox-lwip.c b/drivers/net/sandbox-lwip.c
index 3721033c310..5c9a0cb1b9f 100644
--- a/drivers/net/sandbox-lwip.c
+++ b/drivers/net/sandbox-lwip.c
@@ -27,7 +27,7 @@ static int sb_lwip_eth_send(struct udevice *dev, void *packet, int length)
 {
 	debug("eth_sandbox_lwip: Send packet %d\n", length);
 
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int sb_lwip_eth_recv(struct udevice *dev, int flags, uchar **packetp)
-- 
2.40.1

