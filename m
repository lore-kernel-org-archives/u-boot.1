Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63C9C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 08:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF31E8186D;
	Fri, 14 Mar 2025 09:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gMopR9PW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A11A81951; Fri, 14 Mar 2025 09:44:35 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCDB81760
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso12440925e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741941872; x=1742546672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pw9X+Y5X/erdPczz6VGYcNjee8wP/w0c60tn2vgGJY8=;
 b=gMopR9PW5q1Mr0mPiuu8BHaF2h4/fjZsekHlqulc85niWd3ZhIoIZeQfYd9iliQU/x
 wjutWsSKOcD5fJbrv83MyQP9IBhMRQshHL/9aLsv1U+RxHPd7Av9+WOfJ5OXvlzf52WB
 iGlaQkdiNLvTIzpv/nOC+27eIdXa7RtOYuyj9/DqQBql/VyeSTxB0odI+WrbP9U75rHN
 CXQqGF/g6moZaPYJfECuKj6Kxp0T9JdNGw46mW+YP3Nny8H9rrReE7tVIXxdMZkMC1Ja
 b93WwpkBHg80BKzr5ZpqIooTPUThYCKNr0d8zuaT1BYPjO8mW4+G2EESUtcwXNVEJd8v
 Zo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741941872; x=1742546672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pw9X+Y5X/erdPczz6VGYcNjee8wP/w0c60tn2vgGJY8=;
 b=A/bs/y70zsOJib3CVIgwlo1Ilaav+6JSPiw196cVYkzoEwJ4cUCvSl/fOUDR34y3mA
 CfJfEtJe2lrkCydmo50NApyLvrmY7hIJ58ng6UCFPjCPNpJpxyKzNqAp4dvsbuDFxr0y
 uWeOEgUUsJOSD25bi0d9LWHOoqQwvhekeZ7tqhQN9P+nCRXyGxFkYCV3+xPqRNxhoGUu
 cLk2g0476DcrnjkQuy4AM7fktGIcBEYlPOgjHDmt1xG4sCgMbuzh1F6zzXEeDLbobzfh
 V/ma70Xa8JeSxTbsftl1yWHgUYlyz96fZdPlX3MXcYb0mVZ/RJaJ2y4twM1LUe9PNLWZ
 wofg==
X-Gm-Message-State: AOJu0Yw4ck5HZkePGX+qH5eOmHQbvzvaR/E5K+FY2J/fyLKl2pZZUdtg
 GDEhI2ztRtMyfc/J2ALvPRmzAj5FdV2VfzD3NQaEsqpWnANPb3DOfFJjZatJIBeijt2oKd+3m9R
 KE6E=
X-Gm-Gg: ASbGncsLYJ0YGY4mS/TXvafV+3AAg4MM/88CR7dG4CGi/dgKoCDkvpRC4Bn5fGl7s49
 flkbD6SiCYyN5GEk4KVUoWJmDzeu6NxcNZhPt7rwPgrvWTme4ZzECNsvUKYjxxwN6rKTlQabBjg
 FkO46pLZb675+xmq+zehxmOpf43uZ1CdXB+mzYQsRsLBkalE0zcTXksZBS8BST0Trf9V9SkUbs1
 CGW7in6qVffxwZeCi8MlM6VcYC4UkzAW/e9hsvtcrqS9ZzzLtrhGARHJkHFCVJdnzHa44X6NjvU
 GpktFW+upFnVungwtxNLYDLc+ooqvQw1E6jnkGV9pkSt0y3Z5A4k4Q==
X-Google-Smtp-Source: AGHT+IFgE1iiIjRieTCtNsmL1aBJR73pqsUyc6DthbIjdOPFBlUM9dQky+H71AZ3253PUjMQOvhIOw==
X-Received: by 2002:a05:600c:154c:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-43d1ecff43amr18227455e9.23.1741941870422; 
 Fri, 14 Mar 2025 01:44:30 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:74e6:8b31:6e12:36a6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fd6b2acsm10691675e9.0.2025.03.14.01.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 01:44:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: lwip: do_ping() should return CMD_RET_FAILURE when no
 device
Date: Fri, 14 Mar 2025 09:44:10 +0100
Message-ID: <20250314084411.4165751-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

