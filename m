Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3839C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC5681FC0;
	Fri, 14 Mar 2025 22:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xC4vpx/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC5682012; Fri, 14 Mar 2025 22:55:49 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511FE81F7E
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3965c995151so1585216f8f.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989346; x=1742594146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkEy+yYpDiWI1xn9Iqd6bWhKPoRVgufqD0gFZd7roZ8=;
 b=xC4vpx/VGRhmPYcaAqrzEMvIvshOGTsD8YfSq5ZSyXmL2VJD69NVAREkgQPMrFhLUM
 yXpB7DQbgJLf0EbjsxSKZl1o1U0XWe5OAJnCjyQ137YhfcpXGRXeZzaaJFxRapoTIr6+
 rs4isFP2MOlSUukCtgdLd8JS5ZV9kvo7q09i0BUwGrJnSZkZn/GK6WzxfmI0zw+7nrNL
 61DeC1LfPpRknkOWwA9m4FB3jUY0AO3dUV5DJ+IdOIgjGLtEVfwQnnCuvOIWNFn0OLBX
 zzTK8grsvezKJ6OqAQEfuEzFyJaACMxrrYpBLNpeV3zTLAneUNeR+pood1TsxPVhHlwL
 MpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989346; x=1742594146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkEy+yYpDiWI1xn9Iqd6bWhKPoRVgufqD0gFZd7roZ8=;
 b=WwxzqGuzbXGFecjBsjRqbm2BDWx8173KtC6N2E5Hus/wO1r9YWslwV/7XBnWFBgHVh
 Oro3jNgaDTU+d/b9N+XQhD43xn6lfPRmOl7IpRk7d20p6zAGY4tBC+Z0/QXssTmEjtrP
 vWxgt83xzKbxO6CbEO4LlAwkf2Sv/zgwSMmEzEWwOLQxJVet52vOHvkuGDgpys6aM8zP
 yqFHZhCfoRz0nNYwnNmTtQR6LkWEmKnr7ZrCyrcAWUTMH35ma1j9Ys9TDlk0SQLU/lad
 n6Zsu8WUnjcYfZBtQeOSn4Uicb9KxU/J6haF7eWs+FqCgVN9bU9VjqFIQ/FFIY30jwLe
 +e2A==
X-Gm-Message-State: AOJu0YwnsfgDGhU6ezeK5z2Won7Fz32aYQg8sdI9k6dy6UzkAP1ggMWb
 MbFfCDMjbmBxRiCHqZYUjUIXd5XaFPHgN/7f7zpJQCT9N3wS6XiK876d538sJmEWoR6u5y3xxHp
 LeJc=
X-Gm-Gg: ASbGncvx+FqvVotD8X4M3THn+9Vwe0alnr8tXqZNMvt4JhkmJtyZaTxnVYwdaJQ8aYk
 zmOHcGOwoIQrz6qShzIBwz+R6SCwxqZdyEEjMntUMw4kAUn6xXHAQBxWBlVgHwrbIWUIAPuIxaH
 d3zRsquhaJVOFq79sZMh/1lCZHUhVdqKwCtr4NZrML5sRCQGWbirs2yr5wXjFZHvREUoF/6elXt
 jgl4V5pNyr2UIoBiLoite8sbbngaf5Up9rpo3lEi7kB+v+v2z+RXOaE7lVOo6vT8ZkClPkP3X73
 mK+dGAKaCrJfivy/C/aC4wKJvTjXbEHTFAVgILyOXQg5RN6C75eo0Q==
X-Google-Smtp-Source: AGHT+IE85y+NPtpEWXRLZ4+oHExm80dAJFrcvLztkhf3hXSqdZGI5+r1BAhNjLFulfOLZsxHUmD3nA==
X-Received: by 2002:a5d:64a2:0:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-3971d23799cmr5968286f8f.19.1741989346671; 
 Fri, 14 Mar 2025 14:55:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:55:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/12] net: lwip: do_ping() should return CMD_RET_FAILURE when
 no device
Date: Fri, 14 Mar 2025 22:55:03 +0100
Message-ID: <20250314215525.579655-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314215525.579655-1-jerome.forissier@linaro.org>
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
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

do_ping() expects ping_loop() to return a negative value on error, so
that it can propagate it to the caller as CMD_RET_FAILURE. This is not
the case when no ethernet device is found, so fix that.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 net/lwip/ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/lwip/ping.c b/net/lwip/ping.c
index 200a702bbb5..c586a96806d 100644
--- a/net/lwip/ping.c
+++ b/net/lwip/ping.c
@@ -121,7 +121,7 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
 
 	netif = net_lwip_new_netif(udev);
 	if (!netif)
-		return CMD_RET_FAILURE;
+		return -ENODEV;
 
 	printf("Using %s device\n", udev->name);
 
-- 
2.43.0

