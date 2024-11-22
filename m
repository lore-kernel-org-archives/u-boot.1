Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D38D75E33
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 12:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8167D897F0;
	Fri, 22 Nov 2024 13:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tsKeGYdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A57508981E; Fri, 22 Nov 2024 13:36:23 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F06989339
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso16799595e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 04:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732278981; x=1732883781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QRpNJEMFpEKsKomU991l22bFsXFhhOTzkVz/b1LCr9o=;
 b=tsKeGYdxojMYI0L07twE2fzfr1M7s9jvKCV0DLyFatCXFajBrUbNO39/ZOPKwVfPNo
 IUlogTxVNESQXR+Tv6TJh/BVf7TpINHjZt8P1UkIezG24suJMpCpD+hmtvSzb2NNFaBs
 lFoQIy54sLIzxA3eyl2B+sYqUAcdVi/9rNhtUmo2NA5ETyUawtwmDBDM9EmkdSxn8MyI
 wX49D21DwcMjwB8mkbexZKyl99Gxysf/FpZbntf2FhSiW9JXAZBK1HEUk6ebg/d9S4IC
 YZktiURkBeaXHDSsIvqSFAcRyI5rbFfF8nKPeBDRFDvlvwP2VaKkHr6kmUb+28wE9gP8
 dGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732278981; x=1732883781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QRpNJEMFpEKsKomU991l22bFsXFhhOTzkVz/b1LCr9o=;
 b=GTTnFKzIkhI55JGrcxQJaO03rF7cfFaxdVxBjBSaxrZ2Ig+0olnL+T5w+w1DpyK9tu
 Q2/Er9cz3RONlZTogll0mbVMo4ikoiRILVhQ2Tfn/M+TJUA39g7pXNH2ipU5Sm7tdwA0
 zuf15GPvrOKFBOgYvbz+x92CGFEDoNpUKYhE/p4V4JnT1vu0qweAD34UBYTPZbREHEvW
 7jhoicpsYeJCTX4ey+eTdI8N/ZrOy6ZOpROBXl4BpkbZJZzhyUh3nDX/Te+OWC1y+b0P
 fKQIcE2iGbkTD0/qHQ/db0hhJuncVxwEJ1Wtvm0VLEh2QvXxN9e0NazMhW457HKJQwfl
 oAjg==
X-Gm-Message-State: AOJu0Yy5QeuRypz1PBAIQLPjxXbJKsKShk3RzB3EBDLpSvB+aisMK/s3
 ymkWaSUJcEHwE+lxWa3jGdPICTCcdHVp2Wv4v7ko3rZo2T1O449SYtEZTYCkMttjfHmGjKZmyWZ
 zKMs=
X-Gm-Gg: ASbGncvHgR6HIjrctj/sskSe0DHNQSR+J4MJS0E4OtyDNRC5rhBObnAksJ68Dgy7TO3
 /8Psw2ushkl8XPDcE2qO3Epcl2Itm5DBFrFvuFG1GszuVBXTpfnNKiQ8OoXN8E6x1ECbAj1vjJB
 nzkbgE8ZagD3bU48f+t73RIwLPDF9+X7nKyk8zXd61NEwF7s49JLJ+ArpcE0ykuKkREkX4KGURM
 NK3XXVqiqVc2LAweXKV4rLvv6sa+BIoVNP1otfdNipXJP8a1uScUdWIlnE=
X-Google-Smtp-Source: AGHT+IEGqx2rCC4SdMM+ATMqUo/RTI8dqtZoESGs54xdWo6GQCqls26li/o9IqVlgMNhR4YUsjm9ow==
X-Received: by 2002:a05:600c:3b08:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-433ce4e9d8emr20735845e9.29.1732278980835; 
 Fri, 22 Nov 2024 04:36:20 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:328f:49bf:6d99:19be])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm2268917f8f.109.2024.11.22.04.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 04:36:20 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: lwip: fix dhcp_loop()
Date: Fri, 22 Nov 2024 13:35:29 +0100
Message-ID: <20241122123558.74702-1-jerome.forissier@linaro.org>
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

The local variables ipstr, maskstr and gwstr in static function
dhcp_loop() cannot be pointers to read-only data, since they may be
written to in case the device index is > 0. Therefore make them char
arrays allocated on the stack.

Reported-by: Ilias Apalodimas <ilias.apalodimas at linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/dhcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 23b56226921..bfc72ca6c57 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -27,9 +27,9 @@ static void call_lwip_dhcp_fine_tmr(void *ctx)
 
 static int dhcp_loop(struct udevice *udev)
 {
-	char *ipstr = "ipaddr\0\0";
-	char *maskstr = "netmask\0\0";
-	char *gwstr = "gatewayip\0\0";
+	char ipstr[] = "ipaddr\0\0";
+	char maskstr[] = "netmask\0\0";
+	char gwstr[] = "gatewayip\0\0";
 	unsigned long start;
 	struct netif *netif;
 	struct dhcp *dhcp;
-- 
2.43.0

