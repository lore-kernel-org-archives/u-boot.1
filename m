Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5794C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D9281253;
	Thu,  6 Mar 2025 15:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O21hCrh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B336D81417; Thu,  6 Mar 2025 15:32:59 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A1681298
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390fb1b987fso851005f8f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741271577; x=1741876377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ee28FhEf25536IDI2P8UUaLe9iDNhY9Qahhb75ESx7w=;
 b=O21hCrh1aXtRplK/nq3cAdT/XpWPl+qXCveCCev5MWBVhCJstTGKpNjxBZV2ExfrfI
 JiMhFW1zi4POZWNeghocTRd7/ZOOy648W9WfzRJRd0pvo1x+/0tyFZvBys2uIsyC/Srj
 cyyF8e/fqIn9KKhDpigSb4q+WXVVoJCrwWUJ9xu2KLv1dxjbKX0czrqc/1rYGp5qcE+I
 CE/WXcxAQ+sz/kFYiA8IlBZTOD5er2CuNtvJfuJuyXgdAP/6uyr8hi7mUUGZBvKOCVdJ
 /4JWth5EShOrqp3shDf/DCKg0uOjN3JLSnu9Dm+OHjVThHWoxnUC4Bx0cZBNu2vXJCtB
 xzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271577; x=1741876377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ee28FhEf25536IDI2P8UUaLe9iDNhY9Qahhb75ESx7w=;
 b=odDwwqUKxglG2f3WhVLhGD3R7+9rGjVoZbITy/5UwBWPXdPEHcSEyWr4VLP7lBpZtE
 zM9EcMSAVNGzwj6VHNAoBUP26w+NjbNLmr8M9226b5Jz3NReQYOMJpadKzrNuGYcxQGA
 4maN32GzKUoOMncBh3Bb+38g5OlJDLLxdmBt3oLbYJtDzidWgFrR/wc1xfXigJccpzx3
 bAXVi0jFTwHxSif9zMyJPyE0XyAxXxM+EqBp1e+DLhDiY1kEYC5QcNcFJzmhykjU4LGA
 0MmtLJ5LHBCKkgGEy/FDoXrZTq5huCuqqP5ZS2QnLammIQemC3nnFN4/zLNP4L9iJHSX
 Hj5Q==
X-Gm-Message-State: AOJu0YxZ7pxcR/JPTOptbRfK7qUjE8W4SieAky038559uwmb9fa2EMse
 MbJea7fE3QJcZX0Ee0ska8eFJSbj0FCSxG85gqlRGX/nk2vBGpYC0tS5NmdE62Xk1zjDxT63eU9
 q
X-Gm-Gg: ASbGncsb/QQpiFE609vOXp5tCfgs6d4i4lOzvlvBsyAXRgWlytC+XmAEJ1KqseWPqk3
 /lHWfMbsRDsUEnfeuG1IdIMd4C0DtTNO+OMlc/yxra4/HUVKiwn+7JEgr7VPs5dPlYKIV8djcMu
 gZ4zEXGIhq0CTrlJ3jir6XZ4afcAKUpqQLSTVjJLKy445fvKRUXiZduPIQwdjLpbrukdSCox6JX
 xBxd9hmPoJdgHpX51n8MqMSx3nXD8HpWsezY/mXhQgWnzOXT9j86L6tr1zJRzWwe2Fsr7JUc9xn
 grDxVYkwrX29XYuLKBysz+f9Xyndk9z2BKBa1LxM45R6iSaIvpOYxA==
X-Google-Smtp-Source: AGHT+IH+sSI8Iw/2OUYhJWkkXu19/fMpsiUdz+K8cBeVW480VrNW3XiudmGEz21LRFuEWXfeidao9A==
X-Received: by 2002:a5d:6486:0:b0:391:12a5:3cb3 with SMTP id
 ffacd0b85a97d-3911f726f35mr7415586f8f.3.1741271576869; 
 Thu, 06 Mar 2025 06:32:56 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd9470e2sm21561065e9.33.2025.03.06.06.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:32:56 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] net: lwip: rename linkoutput() as net_lwip_tx()
Date: Thu,  6 Mar 2025 15:32:21 +0100
Message-ID: <20250306143224.3080316-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306143224.3080316-1-jerome.forissier@linaro.org>
References: <20250306143224.3080316-1-jerome.forissier@linaro.org>
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

Rename static function linkoutput() as net_lwip_tx() for consistency
with net_lwip_rx().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/net-lwip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index cab1dd7d483..5a2a86686f4 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -30,7 +30,7 @@ char *pxelinux_configfile;
 struct in_addr	net_ip;
 char net_boot_file_name[1024];
 
-static err_t linkoutput(struct netif *netif, struct pbuf *p)
+static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
 {
 	struct udevice *udev = netif->state;
 	void *pp = NULL;
@@ -60,7 +60,7 @@ static err_t linkoutput(struct netif *netif, struct pbuf *p)
 static err_t net_lwip_if_init(struct netif *netif)
 {
 	netif->output = etharp_output;
-	netif->linkoutput = linkoutput;
+	netif->linkoutput = net_lwip_tx;
 	netif->mtu = 1500;
 	netif->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;
 
-- 
2.43.0

