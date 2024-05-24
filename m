Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CFCC25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AACD888DB;
	Fri, 24 May 2024 18:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UKVAcdIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5A9888CF; Fri, 24 May 2024 18:22:26 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A0C2888B2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-354be94c874so2454384f8f.3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716567742; x=1717172542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnvqlAEbho+IzIup+Qq858vYmcqDE+ViS7jBu54Zv0c=;
 b=UKVAcdIEYfeLUIl/TD5r6qhdtL5qC1DOo7TjSDyWXsXyrDCPdCcC6vREUo4c/XistU
 e4mIycjXGMuk+IfSUSACItzBm/h9V9r3gBicCtO4oDUGp5PX2Y6duerbYREAx9J9nrY1
 O2CVlBbWfan0u5sWd+UCE/OhCAYMDU62knwIsYmfM+NVZEu5cerhLpy1uC7n36DGaHK/
 qvHEHBIMLoaULfTNGdT2TRQPm0T7YO5RDi+NRdVZMhGaBUose/hKal+MUjAkqrBJ1VVj
 vN+H+b8FCrrpwT60e67UNRoI0GfG8dAvofVwF6HzSUeGczlYYwo9REoNonT0KCA5u63x
 DDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567742; x=1717172542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnvqlAEbho+IzIup+Qq858vYmcqDE+ViS7jBu54Zv0c=;
 b=b9Y1q4y9Yd7rzglRzf+N8RJs7yAe+66YgXsR1ZwdR0FQl8PqjyaXgYM/UkSd0kbrui
 4bGANghmDm1yk+BRVWKUDT0OH90fpSErWQ9MGRCc+JBQiT+yEEW7aNZQNFm6iiIkJU8a
 t1uA+r1/txxDa1sNsuUZkKjPoPu1Lo+HJLUmea3rsTd+cXhc4izykF1yFtuswYdSyivb
 zrbCq51osajKVJOjZ89DSxkeS/NRpBa2gW1BPdCis6Kw+DyxuDtIhED/JT0DyKGKT2Zw
 sqZOT2CWUP6f9P4sIUoTo8UYa/0WURPYlf0TU0yM82iy7DBbzPOjHOY8YWgIy6zDV/9r
 51hg==
X-Gm-Message-State: AOJu0Yyf7XBQzBKRi2cLxEnTha/df1HiZ1+CgSN12QqtFlafecrfrlkf
 izKIYs88sRleeMkRKzjDcuM0gjroJeD0yqdOgpmkYaRa+2QStzWtCbiWW/Cl0BX/cTxD9LEEn7b
 l+ytLzhia
X-Google-Smtp-Source: AGHT+IFY2c5S2OxTQl83cWPlKFTWtlnkFmrFafrpCcrToYHImAdYOuY2mhBfiy2AzycfawrKiyaQ4A==
X-Received: by 2002:a5d:4950:0:b0:355:454:12e3 with SMTP id
 ffacd0b85a97d-355245deaabmr2524993f8f.11.1716567742512; 
 Fri, 24 May 2024 09:22:22 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:80fe:af01:c137:b43b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c918csm1928465f8f.77.2024.05.24.09.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:22:22 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 09/14] test: dm: dsa,
 eth: disable tests when CONFIG_NET_LWIP=y
Date: Fri, 24 May 2024 18:20:03 +0200
Message-Id: <e2f595d52fb0d4619245334bb0d98b40c184f9c5.1716566960.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
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

