Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E88C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0ADC8848F;
	Thu,  6 Jun 2024 15:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="orXMkhJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0EB88444; Thu,  6 Jun 2024 15:37:14 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79908844E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52b7ffd9f6eso1108832e87.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681032; x=1718285832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnvqlAEbho+IzIup+Qq858vYmcqDE+ViS7jBu54Zv0c=;
 b=orXMkhJJKxsHY/D+wCIFa+LhAAXfnbLLiH4wMzMmC3RgCrWCUst5i7faLfZ5Kql+Ig
 CC8J+pHtFHJTNVFH0awzNd6l7PuC9SX7ITlfjFKwpT6XbcrthDBIAE9ySsQJhhm/nkIj
 NxpBG4zlXH1yGTAofpGskomM1uEGII9UdNg9y4FtroQjdeXjlG8RjI1NLbTw+c6PYFy7
 IeJ9qiDV09Rs2lC9XOyxMEiGqcjWYAs+0+fcj7skjSl/tpy3v2UReGvbltzpsPwTtznU
 LnI6bRYH5K6zxD8I8I69fgvscfmoFoow8ygi5mEtD70H1xrJoWkIlKtdsqDsuYJ0Cv9P
 5Kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681032; x=1718285832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnvqlAEbho+IzIup+Qq858vYmcqDE+ViS7jBu54Zv0c=;
 b=kCdZBA7XPJWQV9dA26wVD8pcVaCyQX66jywNFnqzttPDERKv8DMfEgAFuM3bi+zWKJ
 arT5au40edtL+mWRpeu4T/VOJxxJzAfFl1CxfBRG2m1oj6OlSQ2FTzQmMd7akSbVXH1V
 0xfwiqYXNrFNpjrfsmn8ZflwClu4SNcTXU649aa2OTKewIGCMKzARuQ8TzAqCHQGuzVo
 Fc883lCfgXok3leSusMoMMHZdiHCNUSsQo1hBoFntpP99Z8jp0eFt5uih8iHGZn4gllh
 2OHFAQmMSsHzZ40R/lMKodnQzWc9C3A8Inj/lCSncEe73uUbDCI/ioA0cC+3kQh2Wdpy
 z1Zg==
X-Gm-Message-State: AOJu0Yw4Nlq8HWTfrE7Me+YjzA8Woe04+Dzg8ltF9UgqHjVK5Dr1uTOh
 wECxhdNMuUou8Q+PZYZ2ljq2dsnffau3cUhFZSuRej9/fo1pxK7XeMBIlXEhKQ1PlIib4aBnee2
 k1Agjk1mY
X-Google-Smtp-Source: AGHT+IFQEHqSHNC/nRJnSlU8ZaT3Lu5Yg88QO0HBjZIjytV1jo5Fnb+7BbQ0ZKNOgZxXF8sJwcPPtw==
X-Received: by 2002:a05:6512:b92:b0:529:593f:3f3c with SMTP id
 2adb3069b0e04-52bab4f4c6bmr4686858e87.53.1717681032046; 
 Thu, 06 Jun 2024 06:37:12 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:37:11 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 08/12] test: dm: dsa,
 eth: disable tests when CONFIG_NET_LWIP=y
Date: Thu,  6 Jun 2024 15:36:03 +0200
Message-Id: <43003c415732cd195239697c936ce080141a4573.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
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

Some sandbox tests make strong assumptions on how the network stack is
implemented. For example, the ping tests assume that ARP resolution
occurs upon sending out the ICMP packet. This is not always the case
with the lwIP stack which can cache ARP information.
Therefore, disable these tests when CONFIG_NET_LWIP is enabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/dm/dsa.c | 2 ++
 test/dm/eth.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/test/dm/dsa.c b/test/dm/dsa.c
index c857106eaf4..147e2a4afe2 100644
--- a/test/dm/dsa.c
+++ b/test/dm/dsa.c
@@ -59,6 +59,7 @@ static int dm_test_dsa_probe(struct unit_test_state *uts)
 
 DM_TEST(dm_test_dsa_probe, UT_TESTF_SCAN_FDT);
 
+#if !defined(CONFIG_NET_LWIP)
 /* This test sends ping requests with the local address through each DSA port
  * via the sandbox DSA master Eth.
  */
@@ -80,3 +81,4 @@ static int dm_test_dsa(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_dsa, UT_TESTF_SCAN_FDT);
+#endif /* !defined(CONFIG_NET_LWIP) */
diff --git a/test/dm/eth.c b/test/dm/eth.c
index bb3dcc6b954..cf97b1c1ab3 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -170,6 +170,7 @@ static int dm_test_ip6_make_lladdr(struct unit_test_state *uts)
 DM_TEST(dm_test_ip6_make_lladdr, UT_TESTF_SCAN_FDT);
 #endif
 
+#if !defined(CONFIG_NET_LWIP)
 static int dm_test_eth(struct unit_test_state *uts)
 {
 	net_ping_ip = string_to_ip("1.1.2.2");
@@ -298,6 +299,7 @@ static int dm_test_eth_act(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_eth_act, UT_TESTF_SCAN_FDT);
+#endif /* !CONFIG_NET_LWIP */
 
 /* Ensure that all addresses are loaded properly */
 static int dm_test_ethaddr(struct unit_test_state *uts)
@@ -332,6 +334,7 @@ static int dm_test_ethaddr(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ethaddr, UT_TESTF_SCAN_FDT);
 
+#if !defined(CONFIG_NET_LWIP)
 /* The asserts include a return on fail; cleanup in the caller */
 static int _dm_test_eth_rotate1(struct unit_test_state *uts)
 {
@@ -616,6 +619,7 @@ static int dm_test_eth_async_ping_reply(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_eth_async_ping_reply, UT_TESTF_SCAN_FDT);
+#endif /* !CONFIG_NET_LWIP */
 
 #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
 
-- 
2.40.1

