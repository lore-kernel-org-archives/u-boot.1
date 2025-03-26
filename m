Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08F4C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 08:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CFF280756;
	Wed, 26 Mar 2025 09:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ybPoyjRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507FC808B6; Wed, 26 Mar 2025 09:29:12 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2DFB8070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 09:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so1101144366b.3
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742977749; x=1743582549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y8hiHCkxq5NHxn0NGFD7/BPoVtNE3UGSlwZhwLR3f0Q=;
 b=ybPoyjRfw2PoxSc2x82Vcy1QfZvjBT5oIdhqc+ePsBA4Dvqd+3XozI4qHbHMpyYO3A
 8iztZaqhKQADDbgHRKEygFCId7csSzAgPAirUzEmqE3ZOm5PFRwGIjaLPp0WswVs6KPx
 uYPhACKhGkoIOC2PVs5UU5tUPXClPTVspkflzODLZQsLf8vQPB9mYpfy/cDbRwzd+tja
 FogPKguo6mKlvWDjYSPakXLdLE1HnT/phYl8ZwuwKlcG2vhz2x7+H8l6carJsDYvI+/7
 tedqfthfBvP+wnGdy3dRYx4TLiNbHCEwA80PDucImM+ZXAn+Zu0FFzupOcZSiJClO+LU
 HvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742977749; x=1743582549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y8hiHCkxq5NHxn0NGFD7/BPoVtNE3UGSlwZhwLR3f0Q=;
 b=hLMSrhk1cKECPbbSgh5wnNP7iL3N3xLhbCFiU69dq6ABrPeg+I2JocM6twh3IIfOPM
 m6NN3ahlFpsRuyvEKLMSMwkuSBeInNSzC2zkvPftRk8BnJL4nfvU9Kx6G7jqMfjL3PH5
 k9MFchqkINbVOJZTlEL7znBpceDZTIdq0GIUmd8QSBidsbgPvipG+V24NnY1aMRoDovc
 YUlJDBDsrr+776oGWdsetbsNe2rI3xw78J5mUfPvv9XFd70S9/LD0Jz7y3c6z/82U4eX
 N7Fz6s3l/ZJHJuL+tqz7Wph4sdJ/ZXVnKHpQOs1nAqjKoP6ozRZ1FqQCTM2N6p9V7Q1q
 7odg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlwnfeZ6vZ8sDDFeTr79vp5qUkeSGwWRM+v84hsHbAsFrEYDJa4FW+Wo5Z+Afhs49Ap3en/Lk=@lists.denx.de
X-Gm-Message-State: AOJu0YzMWLdQJyVeCog0628UkKFCUKy8j8eZ4/SOwaqCmEaCulrVmCXy
 CP3RBu3EmJmRp0HgZ9ZUtcbHcMq4yP5rXzCyjhU1WS3/ZSMEgKMc8YJ4TN6K0uw=
X-Gm-Gg: ASbGnctY6MhEuqS04b2bvFNqjhNGHn2g2EpDhwOusaQwRk3Y7zBjPFFzE638ohozo5z
 E3gnhkIKAhU+cXxGTx+fHsZpBvsySZwKQ7ve/oC/62n/Xf5Lk1IV6sjVVJIrk51Bepx4gWWpo8K
 eLZhNeKcPwm3cDJvUca+0x4tcUDUucNeVrC04124L42z6j7iPnmEJFPvoou2aSPt7RgObMxwQfl
 eR54+u1zdc4LhruYP6Y0EqLvqIvMNL6LuPXAoWwFWTWG/1Unb4JHqYtrTlQB+7BOwWMfh8dJUKI
 cknCecGh+33ykblA5wZeZBbGJKYfrxUvCFFz0elJcrnX9GhtHedg1SBQQvXMF2Y1yt+1b7uTmRS
 ydnl4jhXUgZ7lWwc8qMeBCs0=
X-Google-Smtp-Source: AGHT+IFL3K3OKmGuGewcwRdOgTAUoFdbIvjk9qHe7OAhDNVbqMjiCchHNmLK73orcWUn2NAalRrxTg==
X-Received: by 2002:a17:906:d7cb:b0:ac2:cdcb:6a85 with SMTP id
 a640c23a62f3a-ac3f2110c2cmr1914404566b.22.1742977749306; 
 Wed, 26 Mar 2025 01:29:09 -0700 (PDT)
Received: from localhost.localdomain (ppp089210242125.access.hol.gr.
 [89.210.242.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd23c7bsm1000140366b.150.2025.03.26.01.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 01:29:08 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] net: lwip: Remove error print on failed tx
Date: Wed, 26 Mar 2025 10:28:58 +0200
Message-ID: <20250326082900.870861-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
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

When an ethernet driver fails to send a frame we print an error in lwIP.
But depending on how often that error is it might significantly delay
transmissions.

For example downloading a big file with the rpi4 spams the console with
'send error: -101', but removing the print makes the file download with
an average speed of ~8.5MiB/s since the packets are retransmitted.

So let's move it to a 'debug' in lwIP and expect ethernet drivers to handle
the failure if it's severe.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 net/lwip/net-lwip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index c00a7fe97cd6..6b7b696dbf0f 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -57,7 +57,7 @@ static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
 	err = eth_get_ops(udev)->send(udev, pp ? pp : p->payload, p->len);
 	free(pp);
 	if (err) {
-		log_err("send error %d\n", err);
+		debug("send error %d\n", err);
 		return ERR_ABRT;
 	}

--
2.47.2

