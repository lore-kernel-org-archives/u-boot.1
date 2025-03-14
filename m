Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B70C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C93AB82051;
	Fri, 14 Mar 2025 22:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hXGOru51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D40382012; Fri, 14 Mar 2025 22:55:57 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC1482045
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso1126585e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989354; x=1742594154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMLWgywAHFcHbwiGXV5JqudcSZvy0UIXqie+KljbLV4=;
 b=hXGOru51TAaHxzG2WYMgTZ3xolMEN12yC7Wf7+P4XHOKnAx7/PDw9Rkc1XL9rH5Vgs
 vX6Oj1xLIWlZtcmIzMAkaS1qInNapa1feQcvccyu9wXp8DJ8yPcgnU1p8W3nzApqGM9e
 0jlWTyB7dD4BDL5FQC1QRskOJtLPDZ/T0xERUOTteFoY1XddV7d6o7QxS/Y7z3O/UxDK
 4Xr1Fuxilqi+o+LL79lNza5xO1PUhMl7hm+UvDJZTO/Col7t24I8p/xSdpAsboOLasrc
 +HT1gPN+eQgwRWY/XphAGZGoCqdeUQf5bM7w161QM3bSvLqqgN/sMloyQp+wwT/VPUQa
 d0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989354; x=1742594154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GMLWgywAHFcHbwiGXV5JqudcSZvy0UIXqie+KljbLV4=;
 b=P6Tojjd5ORwUsIQergg/U0v4OU/+CzfEuaaD+NuFMEj0bnyZvyECLLy1+U/uj7FYsP
 f+KdSbSABf2WWfhxZ1Et50nt7lf/q4YHHKR8qtMP5h4VGXwsFGTwSIt/4pp9CsREWtdF
 v584vf6N9pensYmm+sDwLWmr57w8lJ3W50P5MHu68XtJzfBP3HrqGLFy488Fa0b+JYxT
 fLEDdppUA0Zwg2BT+Yex5V0mBlXUguD9MG6s5sId9V1dsVHfLyNKxXjfnPfnWVUSegMR
 ZpswgFb+h3qRQ8M2l1kLnCYNDQs5cv1f6TaZfqJubsb4kmOfJRg/o5m4mvghlX3DICXo
 +arg==
X-Gm-Message-State: AOJu0Yz4l9aaFHJX2Yn+AsKSoXWURnPrjDBTFEdtSyojqt3qOovg6vcN
 e9HGKPNUMqpyHy5EPq1xJuhxNyjAxFWGOtRrAqVOxwaDudg5HU9A1tTRZj3A0+g2iylfM//Dm7Y
 5vxo=
X-Gm-Gg: ASbGncs61kF0YvGXVtu4eN1X1UzYbhkprlYCilObjZYx89mGBZNAaMLHJqU87wngcdw
 bG9V3mfPdiy945hBZvT3avOKuK/7p8Rd+hliR4aS46Ut6wVZuPahLfERpVvZEEIoNhCwaww1uIq
 2/nzR6MAOGbibvqVguIKxMgB57eIZbgqXsdGSA2SRsCmRJVgwVjTczykjFxciBouGJuGbL0PhKD
 e7s+8NT0misUp4cMb6WURTbKPjUcQbiDR3+exQmL2MBUD426UedV83PiPyooLgRQRnEYZxJIxPl
 61SGMEhOm9ZRzB644T9Ff5YtdMGhozUYgN8RZUE5sNQf+XGBGJCy3xuXA9mvVGQH
X-Google-Smtp-Source: AGHT+IFXlDFnW9T52YU0c3N/qnFDDvKhSgdnAEFS3qmXUCFgas0E6FednMDReNQdFxmwvPxcXNzVyA==
X-Received: by 2002:a05:600c:3108:b0:43c:fe15:41e1 with SMTP id
 5b1f17b1804b1-43d1ec66daamr53303725e9.4.1741989354321; 
 Fri, 14 Mar 2025 14:55:54 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:55:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/12] net: lwip: add restart support to ping
Date: Fri, 14 Mar 2025 22:55:06 +0100
Message-ID: <20250314215525.579655-5-jerome.forissier@linaro.org>
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

Use net_start_again() in do_ping() to determine if a failed ping should
be restarted on a different interface.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/ping.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/lwip/ping.c b/net/lwip/ping.c
index 542ef2cb148..d8042ceecf9 100644
--- a/net/lwip/ping.c
+++ b/net/lwip/ping.c
@@ -168,11 +168,13 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (!ipaddr_aton(argv[1], &addr))
 		return CMD_RET_USAGE;
 
-	if (net_lwip_eth_start() < 0)
-		return CMD_RET_FAILURE;
-
-	if (ping_loop(eth_get_dev(), &addr) < 0)
-		return CMD_RET_FAILURE;
+restart:
+	if (net_lwip_eth_start() < 0 || ping_loop(eth_get_dev(), &addr) < 0) {
+		if (net_start_again() == 0)
+			goto restart;
+		else
+			return CMD_RET_FAILURE;
+	}
 
 	return CMD_RET_SUCCESS;
 }
-- 
2.43.0

