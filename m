Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AC8D3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 12:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216C083B55;
	Mon,  8 Dec 2025 13:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IBg9jcXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2981A83B4E; Mon,  8 Dec 2025 13:52:13 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F1683B32
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 13:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so57437835e9.3
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 04:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765198330; x=1765803130; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x58j6eNqlaNi5vfFnoUz9VMOmumGq+ig6InZvzrW0vY=;
 b=IBg9jcXWSIc3Dc+GVIRiI42eiLi+mQh1asmPYuSA1asCfpFo1Q2dlHrLFi3osOAAGI
 iUEY60Fd79+p6R94xTBbOsFxMWYRciFAfXkxVQDWY7Z7ag1wzOmdteHdoNLemn1fUbVV
 MkqJskKrFWOSYnidN3cWwr32QotVHWuH381/6PQNpAPNPz0fx2BeTVlnzxR85/t19Lcm
 7SiMPgsJjpUS/aR4/J0BOwlXVVGRhpSSNpeS3rwXGHntPitCydCZxWrawyWXOSZ/QVTC
 LhdXEGEW919rQZY0dVRHTUbvWLIYGe8BIip4C9PzFxjIK6WgsvLaZ690huLw+bhhx0/h
 4Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765198330; x=1765803130;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x58j6eNqlaNi5vfFnoUz9VMOmumGq+ig6InZvzrW0vY=;
 b=OhfQ58ECNhyQfdPJbiY/AceLDeWomUSZHAz9DAqoTXNSlhKt6cMPMHHHNIdRUKf/j9
 2TNhtzS7lBNSAoICysK/gCSVqX39A/SagaPp5u+lCFzoy7kE3IjDNsOdnU1/USlmtHzq
 pSKZ4TJ7uVJYfuYv5Z3ZN9t1AXZyM86D5uyhdCD6f8xqGoYxJ5d+/cWOWL9AL1Cqcayx
 xDP1hYKn7xowSRD1vxDguCoGnGFZwfwx6ACRiZgjFohmqAOiVBp9k/c/40+npf46Emr+
 ps49txUBo7EEw+Z16edOVPLWnq6VGz6bbNUXd1MRVfn9DmkQqmtl/Zjo/pHoMheFRaT5
 CX3Q==
X-Gm-Message-State: AOJu0Yz2oHLT4ctFwXn4LA/sQAiE6AEdJZ7hMyIsPpTpS9UE8ukYJZsb
 EbXIaLzKpuMrk5z9TAJ0SXeaGTfzek09ilWMgzD3NCSuc1R+AGwtiq+6bmNF3q8FfnI=
X-Gm-Gg: ASbGncuReNUWsaQ6Fm1UAYtf2frJkwAiNjATg3Btg1uSewTBO+x1hZBnADfaEhn6vQB
 ShDkK8cPoD95GbgKfXuPTnWKCAsUkRiXgTBS1SwEJLY8l51Qi9pyqB67Ma8cUDc7EG/DUgRplu7
 jRlkomW+d2L5P8aBKujTwyk/RkW2IRtHDueWEBxXJk0xvz0r/s+1zZ9eNwuVSRBKsXIdJE/RRNK
 D4olMvXoY9/3WoIhF+uznmYspGvhQZEtXYbsJLOK3vbD7IulF2WazvmUrRhnZZoLSPZCnpejDz0
 z4w08B6pY0VSSTLi1Mk6pWsA/k5SHYtdmyQpY4452edkgImCUtVMEj1SyxuzzEI00Os8cWzfJq5
 BoloL1l4nXewntHhYX6GUv+gAxLz2Trg5UcF2Gwq//9IqPvkedlHoDWW63iaLfGDa7sObyv6xnw
 0g4j559HksFrJ6klb8+Fi8M0Hc1giPrC+KvnM7DVk=
X-Google-Smtp-Source: AGHT+IFtyOyAK5tyISxulNvS6jPaukTVOfEcX03iWvmY5hNE/GZRV7YpvEVOLzSmqVRIDstmgrFOnQ==
X-Received: by 2002:a05:600c:6209:b0:477:9aeb:6a8f with SMTP id
 5b1f17b1804b1-47a7b1b053emr2747915e9.9.1765198330509; 
 Mon, 08 Dec 2025 04:52:10 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f7b:b001:fd05:11bc:5c24:a865])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930920b6dsm260113645e9.1.2025.12.08.04.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 04:52:10 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 08 Dec 2025 12:52:07 +0000
Subject: [PATCH 1/5] net: move net_state to net-common
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-lwip_nfs-v1-1-1f5d31e15d00@linaro.org>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
In-Reply-To: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Move the net_state variable into common code so that it can be used by
either the legacy network code or LWIP. This is needed for porting
across the NFS support code for use with LWIP.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 include/net-common.h | 17 +++++++++++++++++
 include/net-legacy.h | 17 -----------------
 net/net-common.c     |  3 +++
 net/net.c            |  2 --
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index f5cff3e7c0c5d25f154e7730fad52cf03f71b875..d7a0f7dff7e50527e77419ead9a9ff30deeea545 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -13,6 +13,7 @@
 #include <time.h>
 
 #define DEBUG_NET_PKT_TRACE 0	/* Trace all packet data */
+#define DEBUG_INT_STATE 0	/* Internal network state changes */
 
 /*
  *	The number of receive packet buffers, and the required packet buffer
@@ -114,6 +115,22 @@ struct ip_udp_hdr {
 #define RINGSZ		4
 #define RINGSZ_LOG2	2
 
+/* Network loop state */
+enum net_loop_state {
+	NETLOOP_CONTINUE,
+	NETLOOP_RESTART,
+	NETLOOP_SUCCESS,
+	NETLOOP_FAIL
+};
+
+extern enum net_loop_state net_state;
+
+static inline void net_set_state(enum net_loop_state state)
+{
+	debug_cond(DEBUG_INT_STATE, "--- NetState set to %d\n", state);
+	net_state = state;
+}
+
 extern int		net_restart_wrap;	/* Tried all network devices */
 extern uchar               *net_rx_packets[PKTBUFSRX]; /* Receive packets */
 extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast address */
diff --git a/include/net-legacy.h b/include/net-legacy.h
index 9564e97d238daa2ce919ebaa60bdaf4466d76b14..0a10121b0cf50898a90bb1179966f01dbdda65ad 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -25,7 +25,6 @@ struct udevice;
 #define DEBUG_LL_STATE 0	/* Link local state machine changes */
 #define DEBUG_DEV_PKT 0		/* Packets or info directed to the device */
 #define DEBUG_NET_PKT 0		/* Packets on info on the network at large */
-#define DEBUG_INT_STATE 0	/* Internal network state changes */
 
 /* ARP hardware address length */
 #define ARP_HLEN 6
@@ -369,22 +368,6 @@ bool arp_is_waiting(void);		/* Waiting for ARP reply? */
 void net_set_icmp_handler(rxhand_icmp_f *f); /* Set ICMP RX handler */
 void net_set_timeout_handler(ulong t, thand_f *f);/* Set timeout handler */
 
-/* Network loop state */
-enum net_loop_state {
-	NETLOOP_CONTINUE,
-	NETLOOP_RESTART,
-	NETLOOP_SUCCESS,
-	NETLOOP_FAIL
-};
-
-extern enum net_loop_state net_state;
-
-static inline void net_set_state(enum net_loop_state state)
-{
-	debug_cond(DEBUG_INT_STATE, "--- NetState set to %d\n", state);
-	net_state = state;
-}
-
 /*
  * net_get_async_tx_pkt_buf - Get a packet buffer that is not in use for
  *			      sending an asynchronous reply
diff --git a/net/net-common.c b/net/net-common.c
index c68e19fc03e64a740d05b998ef0efb9fce311543..ec1e179f7d9cdd459dc3b8c2d13f6e478ad4ce87 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -6,6 +6,9 @@
 #include <linux/time.h>
 #include <rtc.h>
 
+/* Network loop state */
+enum net_loop_state net_state;
+
 void copy_filename(char *dst, const char *src, int size)
 {
 	if (src && *src && (*src == '"')) {
diff --git a/net/net.c b/net/net.c
index f579f6ac5bcced5a05a340b000a1ca9c2651c6da..03a39419d10817aff5f12badc0f604a403fe7fb2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -163,8 +163,6 @@ const u8 net_null_ethaddr[6];
 #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
 void (*push_packet)(void *, int len) = 0;
 #endif
-/* Network loop state */
-enum net_loop_state net_state;
 /* Tried all network devices */
 int		net_restart_wrap;
 /* Network loop restarted */

-- 
2.47.3

