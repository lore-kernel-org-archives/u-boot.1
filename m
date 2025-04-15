Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520AAC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5909282C49;
	Tue, 15 Apr 2025 23:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ajrblWOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6891B82BDC; Tue, 15 Apr 2025 23:18:38 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D3181E1F
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so3665713f8f.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751915; x=1745356715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErFDwS1/r/w248TiTv9376n3jwj/iLkxpAWYvgK53Js=;
 b=ajrblWOnIx5a7rlf2db8D593WVD6WL4BPxGHeqYPUa5Rw37TAsdkEp3JIxA8BE8YLp
 7l6WUJcMfJHtSZE7/P9Ors65PYNEk9VDFcqgcvCCZSvKskIYOU2TLkI5yCSt8vMP0FnZ
 J8dK3fAMpLnJG2Pt6KwxEWQnLRH+r7znw8+1YTRkiN1TaJuaEVBLo/tqDrjLuWKcdYPC
 +50yx6MQr/dYoEn1KYKqdYh3EOD6w8UljAM4Rqka82shx1Ondy2k/P0sPxQnkPZ4mByK
 xMwvzQE5Rgm69HWK7ZT1QS/OFphBAIFdcX4PxvW64GVAevzWxibj2LhNbmJaHudtsJM9
 4KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751915; x=1745356715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErFDwS1/r/w248TiTv9376n3jwj/iLkxpAWYvgK53Js=;
 b=YgqpcxE2oV6hNfn/tvsjJ74PC7vOl42tglBkIL5WUyainPdZYtxrBd0K0TvhSo8bgN
 lVme5L77L0bjAzRVI1uN4Zra+bGFKNEzupwPqdXLPZ9n7hDWlhNsiMRSNVVGCPwhvTIg
 tz0HmXDcTLwtUPOooriG7Ug/EwL+hcF1xGNNJegF9JtcF2dDk9t9LpOPNzEDMb19q6+7
 8a+6oCqiSKF5q75Cn9yuygRx/JCoQhfBjm6TorBYOYoCKMkJLIddyVJ8H2yfLCZt9No5
 OnLORV4qNLwJrf8xrGGNUwiD3ainJG4tp6ND/xzrhm/z2vNheEXaCURjN5i3JMaXqrwQ
 4/LQ==
X-Gm-Message-State: AOJu0YyGfDAyWjzV/kaLgnp7ID3QlBtf6q3AHA7zXDAuyxwTNbl02/RS
 VC9+1wwPCPkgkqSisXl4RkDJSDGchf8+d9txOhNBx9xtqio4k+tjI1n+jvysd7loYnvdP3UXK/f
 o8Ec=
X-Gm-Gg: ASbGnctXSWGgcexkHb54aNti8PWl2kCpb9WOTxxJTC6mKvPLcrfnedrv8/zCQwqoQeN
 bVLjAKTNnPqpDfIkBnWEMosYglJn+NsWrotKqmLTTqMgfG68VwkJxM0BTjZVVc8Azn9SoI5iZOF
 0GU+msei2nu3ZJ52lrYDxTehVDTGmGyDzXZu4p542QW4orjlhV8iw+JC9XQo5c1uRRA/daK6nzG
 Xx2/09UHthOmX7jxFbv33BqPaRusErkOsJA8TmBFtNjIwYbVoNwlMJEY7PuNzZONh0qiewqpayF
 AOLIhOWS0l+mafDckRpVK8uUEsz4wU2+AddL9PSu795/7AUT
X-Google-Smtp-Source: AGHT+IEHaIKs5k+28R5VptqBC583N5T3rvXkx0dAn3+BNnTtDnVLcNvhjMOwCZcqGpszY/CZcX2SVA==
X-Received: by 2002:a05:6000:2913:b0:391:3094:d696 with SMTP id
 ffacd0b85a97d-39ee27706e6mr827274f8f.54.1744751915290; 
 Tue, 15 Apr 2025 14:18:35 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:35 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/11] test: dm: eth, dsa: update tests for NET_LWIP
Date: Tue, 15 Apr 2025 23:17:43 +0200
Message-ID: <20250415211819.1254435-9-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415211819.1254435-1-jerome.forissier@linaro.org>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
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

Convert the tests to use the do_ping() interface which is now
common to NET and NET_LWIP. This allows running most network test with
SANDBOX and NET_LWIP. A few things to note though:

1. The ARP and IPv6 tests are enabled for NET only

2. The net_retry test is modified to use eth0 (eth@10002000) as the
active (but disabled) interface, and therefore we expect eth1
(eth@10003000) to be the fallback when "netretry" is "yes". This is in
replacement of eth7 (lan1) and eth0 (eth@10002000) respectively.
Indeed, it seems eth7 works with NET by chance and it certainly does not
work with NET_LWIP. I observed that even with NET,
sandbox_eth_disable_response(1, true) has no effect: remove it and
the test still passes. The interface ID is not correct to begin with; 1
corresponds to eth1 (eth@10003000) as shown by debug traces, it is not
eth7 (lan1). And using index 7 causes a SEGV.  In fact, it is not the
call to sandbox_eth_disable_response() that prevents the stack from
processing the ICMP reply but the timeout caused by the call to
sandbox_eth_skip_timeout(). Here is what happens when trying to ping
using the eth7 (lan1) interface with NET:

 do_ping(...)
     net_loop(PING)
         ping_start()
         eth_rx()
             sb_eth_recv()
                 time_test_add_offset(11000UL);
         if (get_timer(0) - time_start > time_delta)
             ping_timeout_handler()  // ping error, as expected

And the same with NET_LWIP:

 do_ping(...)
     ping_loop(...)
         sys_check_timeouts()
         net_lwip_rx(...)
             sb_eth_recv()
                 time_test_add_offset(11000UL);
             netif->input(...)  // the packet is processed succesfully

By choosing eth0 and sandbox_eth_disable_response(0, true), the incoming
packet is indeed discarded and things work as expected with both network
stacks.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/dm/Makefile |  2 --
 test/dm/dsa.c    |  8 ++---
 test/dm/eth.c    | 77 +++++++++++++++++++++++++++---------------------
 3 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 3afcc26ca57..917dafe7d22 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -46,9 +46,7 @@ obj-$(CONFIG_VIDEO_MIPI_DSI) += dsi_host.o
 obj-$(CONFIG_DM_DSA) += dsa.o
 obj-$(CONFIG_ECDSA_VERIFY) += ecdsa.o
 obj-$(CONFIG_EFI_MEDIA_SANDBOX) += efi_media.o
-ifdef CONFIG_NET
 obj-$(CONFIG_DM_ETH) += eth.o
-endif
 obj-$(CONFIG_EXTCON) += extcon.o
 ifneq ($(CONFIG_EFI_PARTITION),)
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fastboot.o
diff --git a/test/dm/dsa.c b/test/dm/dsa.c
index c6b4e12a758..9a31ae39d95 100644
--- a/test/dm/dsa.c
+++ b/test/dm/dsa.c
@@ -63,15 +63,15 @@ DM_TEST(dm_test_dsa_probe, UTF_SCAN_FDT);
  */
 static int dm_test_dsa(struct unit_test_state *uts)
 {
-	net_ping_ip = string_to_ip("1.2.3.5");
+	char *argv[] = { "ping", "1.1.2.2" };
 
 	env_set("ethact", "eth2");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 
 	env_set("ethact", "lan0");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	env_set("ethact", "lan1");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 
 	env_set("ethact", "");
 
diff --git a/test/dm/eth.c b/test/dm/eth.c
index 467495863e1..1087ae9572d 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -171,18 +171,18 @@ DM_TEST(dm_test_ip6_make_lladdr, UTF_SCAN_FDT);
 
 static int dm_test_eth(struct unit_test_state *uts)
 {
-	net_ping_ip = string_to_ip("1.1.2.2");
+	char *argv[] = { "ping", "1.1.2.2" };
 
 	env_set("ethact", "eth@10002000");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10002000", env_get("ethact"));
 
 	env_set("ethact", "eth@10003000");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10003000", env_get("ethact"));
 
 	env_set("ethact", "eth@10004000");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10004000", env_get("ethact"));
 
 	return 0;
@@ -191,22 +191,23 @@ DM_TEST(dm_test_eth, UTF_SCAN_FDT);
 
 static int dm_test_eth_alias(struct unit_test_state *uts)
 {
-	net_ping_ip = string_to_ip("1.1.2.2");
+	char *argv[] = { "ping", "1.1.2.2" };
+
 	env_set("ethact", "eth0");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10002000", env_get("ethact"));
 
 	env_set("ethact", "eth6");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10004000", env_get("ethact"));
 
 	/* Expected to fail since eth1 is not defined in the device tree */
 	env_set("ethact", "eth1");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10002000", env_get("ethact"));
 
 	env_set("ethact", "eth5");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10003000", env_get("ethact"));
 
 	return 0;
@@ -215,18 +216,18 @@ DM_TEST(dm_test_eth_alias, UTF_SCAN_FDT);
 
 static int dm_test_eth_prime(struct unit_test_state *uts)
 {
-	net_ping_ip = string_to_ip("1.1.2.2");
+	char *argv[] = { "ping", "1.1.2.2" };
 
 	/* Expected to be "eth@10003000" because of ethprime variable */
 	env_set("ethact", NULL);
 	env_set("ethprime", "eth5");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10003000", env_get("ethact"));
 
 	/* Expected to be "eth@10002000" because it is first */
 	env_set("ethact", NULL);
 	env_set("ethprime", NULL);
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10002000", env_get("ethact"));
 
 	return 0;
@@ -249,6 +250,7 @@ DM_TEST(dm_test_eth_prime, UTF_SCAN_FDT);
  */
 static int dm_test_eth_act(struct unit_test_state *uts)
 {
+	char *argv[] = { "ping", "1.1.2.2" };
 	struct udevice *dev[DM_TEST_ETH_NUM];
 	const char *ethname[DM_TEST_ETH_NUM] = {"eth@10002000", "eth@10003000",
 						"sbe5", "eth@10004000"};
@@ -258,7 +260,6 @@ static int dm_test_eth_act(struct unit_test_state *uts)
 	int i;
 
 	memset(ethaddr, '\0', sizeof(ethaddr));
-	net_ping_ip = string_to_ip("1.1.2.2");
 
 	/* Prepare the test scenario */
 	for (i = 0; i < DM_TEST_ETH_NUM; i++) {
@@ -281,7 +282,7 @@ static int dm_test_eth_act(struct unit_test_state *uts)
 	env_set("ethact", ethname[0]);
 
 	/* Segment fault might happen if something is wrong */
-	ut_asserteq(-ENODEV, net_loop(PING));
+	ut_asserteq(CMD_RET_FAILURE, do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 
 	for (i = 0; i < DM_TEST_ETH_NUM; i++) {
 		/* Restore the env */
@@ -334,15 +335,17 @@ DM_TEST(dm_test_ethaddr, UTF_SCAN_FDT);
 /* The asserts include a return on fail; cleanup in the caller */
 static int _dm_test_eth_rotate1(struct unit_test_state *uts)
 {
+	char *argv[] = { "ping", "1.1.2.2" };
+
 	/* Make sure that the default is to rotate to the next interface */
 	env_set("ethact", "eth@10004000");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10002000", env_get("ethact"));
 
 	/* If ethrotate is no, then we should fail on a bad MAC */
 	env_set("ethact", "eth@10004000");
 	env_set("ethrotate", "no");
-	ut_asserteq(-EINVAL, net_loop(PING));
+	ut_asserteq(CMD_RET_FAILURE, do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10004000", env_get("ethact"));
 
 	return 0;
@@ -350,14 +353,16 @@ static int _dm_test_eth_rotate1(struct unit_test_state *uts)
 
 static int _dm_test_eth_rotate2(struct unit_test_state *uts)
 {
+	char *argv[] = { "ping", "1.1.2.2" };
+
 	/* Make sure we can skip invalid devices */
 	env_set("ethact", "eth@10004000");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("eth@10004000", env_get("ethact"));
 
 	/* Make sure we can handle device name which is not eth# */
 	env_set("ethact", "sbe5");
-	ut_assertok(net_loop(PING));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
 	ut_asserteq_str("sbe5", env_get("ethact"));
 
 	return 0;
@@ -368,9 +373,6 @@ static int dm_test_eth_rotate(struct unit_test_state *uts)
 	char ethaddr[18];
 	int retval;
 
-	/* Set target IP to mock ping */
-	net_ping_ip = string_to_ip("1.1.2.2");
-
 	/* Invalidate eth1's MAC address */
 	memset(ethaddr, '\0', sizeof(ethaddr));
 	strncpy(ethaddr, env_get("eth6addr"), 17);
@@ -396,6 +398,7 @@ static int dm_test_eth_rotate(struct unit_test_state *uts)
 		/* Restore the env */
 		env_set("ethaddr", ethaddr);
 	}
+
 	/* Restore the env */
 	env_set(".flags", NULL);
 
@@ -406,26 +409,28 @@ DM_TEST(dm_test_eth_rotate, UTF_SCAN_FDT);
 /* The asserts include a return on fail; cleanup in the caller */
 static int _dm_test_net_retry(struct unit_test_state *uts)
 {
+	char *argv[] = { "ping", "1.1.2.2" };
+
 	/*
-	 * eth1 is disabled and netretry is yes, so the ping should succeed and
-	 * the active device should be eth0
+	 * eth0 is disabled and netretry is yes, so the ping should succeed and
+	 * the active device should be eth1
 	 */
-	sandbox_eth_disable_response(1, true);
-	env_set("ethact", "lan1");
+	sandbox_eth_disable_response(0, true);
+	env_set("ethact", "eth@10002000");
 	env_set("netretry", "yes");
 	sandbox_eth_skip_timeout();
-	ut_assertok(net_loop(PING));
-	ut_asserteq_str("eth@10002000", env_get("ethact"));
+	ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
+	ut_asserteq_str("eth@10003000", env_get("ethact"));
 
 	/*
-	 * eth1 is disabled and netretry is no, so the ping should fail and the
-	 * active device should be eth1
+	 * eth0 is disabled and netretry is no, so the ping should fail and the
+	 * active device should be eth0
 	 */
-	env_set("ethact", "lan1");
+	env_set("ethact", "eth@10002000");
 	env_set("netretry", "no");
 	sandbox_eth_skip_timeout();
-	ut_asserteq(-ENONET, net_loop(PING));
-	ut_asserteq_str("lan1", env_get("ethact"));
+	ut_asserteq(CMD_RET_FAILURE, do_ping(NULL, 0, ARRAY_SIZE(argv), argv));
+	ut_asserteq_str("eth@10002000", env_get("ethact"));
 
 	return 0;
 }
@@ -434,8 +439,6 @@ static int dm_test_net_retry(struct unit_test_state *uts)
 {
 	int retval;
 
-	net_ping_ip = string_to_ip("1.1.2.2");
-
 	retval = _dm_test_net_retry(uts);
 
 	/* Restore the env */
@@ -446,6 +449,7 @@ static int dm_test_net_retry(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_net_retry, UTF_SCAN_FDT);
 
+#if CONFIG_IS_ENABLED(NET)
 static int sb_check_arp_reply(struct udevice *dev, void *packet,
 			      unsigned int len)
 {
@@ -511,7 +515,9 @@ static int sb_with_async_arp_handler(struct udevice *dev, void *packet,
 
 	return sb_check_arp_reply(dev, packet, len);
 }
+#endif
 
+#if CONFIG_IS_ENABLED(NET)
 static int dm_test_eth_async_arp_reply(struct unit_test_state *uts)
 {
 	net_ping_ip = string_to_ip("1.1.2.2");
@@ -529,7 +535,9 @@ static int dm_test_eth_async_arp_reply(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_eth_async_arp_reply, UTF_SCAN_FDT);
+#endif
 
+#if CONFIG_IS_ENABLED(NET)
 static int sb_check_ping_reply(struct udevice *dev, void *packet,
 			       unsigned int len)
 {
@@ -613,6 +621,7 @@ static int dm_test_eth_async_ping_reply(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_eth_async_ping_reply, UTF_SCAN_FDT);
+#endif
 
 #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
 
-- 
2.43.0

