Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49DFC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F3B88877;
	Wed, 22 May 2024 18:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rSA0gKnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277778888B; Wed, 22 May 2024 18:04:45 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD28588836
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a5cdd6cfae7so166977366b.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393882; x=1716998682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E99mTY1c0AroBm2ufOR00hDQkAaE2MYUs3uC34eLhG8=;
 b=rSA0gKnLp7bYMdCcZ70UojyLnDJ7VoJHpxA9GaWeAra0nO+T/AEu34oITNCEGhVKL1
 y4HClW+e0vdevfdRy41eNwhEun2lAMUP4NTnSlA0JWKYfgBdhj/WuJ8+OjWJ/HPPI+Cn
 CqM3ghyAykaVonr2oUXKwTA86ymlwlj5BiV1MEElU+u+uhuyo91mWehE/cpqpRIszdWP
 h4+F3lma7oYqKeu0vfJTUsErguuEeVeYhDwG5Y9ivImte5q9fZ8x+KJm1kUWsNNl01Wd
 q55n80dwZAXldZylKjhuZ8t9BiPVizJ3+Kui5sj/1ype4Bl+eRiN+h+PZsqR4iiqy5EI
 rWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393882; x=1716998682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E99mTY1c0AroBm2ufOR00hDQkAaE2MYUs3uC34eLhG8=;
 b=K2lAnam8HUgOpyW7Iq7kN/pRTGNvlml6dTBfEGzDeF6cNYDUnU+6CcIn1lFWnzRvWU
 P4CK5RWGz66lYN0rx9A0fbVzWj9bQ5IDeY2AOSr7/f8X7TRL7F/jE8AO4KOrFBAZ+2m2
 zQDB7GUojkM0kjoLinLZFTHmR9iZvC1uhxmSsyZkVcdn28DautA69cMriSwmq0S/Eh3X
 KNaWIgSN+JEWF3EZ6FmKIdtu7c0LfVvvEWh/9tAVtham+mG0elc57sVzWM5y8LQvyXM0
 mJIl6rMeGRaIi/0o8YVYz9fqui3O2DvuyixLOq6IPbzD4r83rqD/ymb3oYi7I/lVvWLy
 4yFQ==
X-Gm-Message-State: AOJu0YxGYQAZYxNtBX8tRkEHwOB/HoVFWjbXZtc/ToZA0HXce3aqI6T/
 0xQkXcIozbmhjug1gvjsNl4NIGnvdlgVghyb4IrgiNaPaBZyEtB8OrZJPhkLCdOS9lYTdwONL3C
 0RSOtkLpU
X-Google-Smtp-Source: AGHT+IG67EE+se6X0yWz9ZqsWC1lyLPYmgkhKMRtwXro9U0BAtkGX92Hw9B/dJb7TJ9MmxEcatxaHA==
X-Received: by 2002:a17:906:a184:b0:a59:efb8:28ca with SMTP id
 a640c23a62f3a-a5d5fc61df9mr1224978266b.32.1716393882029; 
 Wed, 22 May 2024 09:04:42 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:41 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 10/15] test: dm: dsa, eth: disable tests when CONFIG_NET_LWIP=y
Date: Wed, 22 May 2024 18:00:10 +0200
Message-Id: <52b126477a39fe8e0bdea9fd9ec70b0951aab88b.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
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
index c857106eaf..147e2a4afe 100644
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
index bb3dcc6b95..cf97b1c1ab 100644
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

