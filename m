Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDF6D49200
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 11:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9EFA839A5;
	Fri, 12 Dec 2025 12:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jy2/SmiW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CBC9839E4; Fri, 12 Dec 2025 12:32:34 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A9FF835B3
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 12:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso4499985e9.1
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 03:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765539147; x=1766143947; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9jHlF4RU3VygYpdibfy2spEXBtvNrky1F9vR5/RKFYc=;
 b=Jy2/SmiW+IbGxz2taF+SsahE1MC0KRGhcwGLblP3i0Bpj2rssl3+rHsrHS84YHIzHj
 H9d96hJyhjYX62H++h+lIQuK7B+yu2vcd5Cnk0pb8bwkMwSY0yiAU7BXdrWC6qDokp9Q
 SWw+T5oYbUQI+OyAwvLh6ILDkQKJ5aIkKVhC9qLAflPLDbiTtX2hQHTGbjblJQQ2J4AJ
 o2uY/TUM4lf8HsAa5GwHLa4o4iGPyCiw8WGOvCiSF6bMycPRtxeK1IP1XSb8bIhT1cUo
 ZzIAfRQ3Fb9w7p6oftG+OEwdnnLPoXW0TBg8hXQCeQxiQsvL+EjGDBjTKUsgGK/5FAHq
 CTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765539147; x=1766143947;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9jHlF4RU3VygYpdibfy2spEXBtvNrky1F9vR5/RKFYc=;
 b=PUylVXYwnaI/N2K56hmq8jkVpWh83fgg9R2KQUBOqlWg3WDAf5tIbAG2vj3k7ZQ/wA
 HpmMno+wrE0SuItt0JBxnWhDwXR1QVsWgHJtdHGMdnkSIfs/2/TP13GPkFnVkRhctEnO
 M/G9vWy69kPuTxltfvn0e9B+HWnuCBtrdJyx/Xmnm9IoYNozvbxOHgg26YCL8F3hMmtW
 PWZqMNoaTjRxbzPQYA/xUBYroSjy4H6vhNJbXGhWYudEj6S5KVehdph7Z/r8tcM5bKVi
 1zgWYJabd74LUBqcQdrRZ4GnelC45q+/W9UVyeFbxsu3DT8ZLQP3cMQwLgEJXa9OWB7E
 iF7A==
X-Gm-Message-State: AOJu0YyZmpMntBix89weqvMhbS5l1BKUVDkIoHygEwgUh4aggh4L6mJj
 CLlr4qJAwTnDbNiI+cd4BQKJbYZzJQPmPV4npXadlTNUQqshb75OzpPoKuoygnSH21Q=
X-Gm-Gg: AY/fxX4EmbMPlR6jlK9c4t+EL8BB/cXH+6KrrfUHglCipNye/WkJemSAz7G9Qwzsm8V
 EBrKc6CjCMnw8mWLlILVRNQwKYPA3bLW/GU8F76B60YLolR/wx2sjLeIGyeavv1+LT0dImLk+as
 aiCZJZdk+Hz+lxoTQeMrX6DRmKx+ekgidNwNz3fMxh3eWSopSweUm3O34XBXPiVSoRqM1BqFRPi
 oh3jUFLzM9PjMjuh9tXR+ZwWnDRAP7xC1r5gDPZq3IXHIk4fHcCGaw5dDHNN+7QYricQWQuhHpM
 Huwe8INdkOsbZSiivCM4UrUXudOpQW+1ScKSpDzJebA/zuf2I5W2XFBUvcn/xnaM2FMRteekX7n
 6WJlF5Xlg+WTskbSxcnTuo3C4aPIUMpR7QxWb7kFTy8uQ/exjZ1D1/0Keik/fgLkCRT1Q3qyRG8
 pcWmae/lllCLCX1mgTHcuo9gD++BctYeGTtEw1l30=
X-Google-Smtp-Source: AGHT+IGtWj9muCxyH68qRNUJQnSv84Y7ayvWi1j1b68XnWJ7qiWa85I0Qt8CGgYF8v2gxEjf/8s10w==
X-Received: by 2002:a05:600c:1c89:b0:479:3a8e:e490 with SMTP id
 5b1f17b1804b1-47a8f2cb09dmr21473585e9.18.1765539146640; 
 Fri, 12 Dec 2025 03:32:26 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:3801:9287:1e8a:f239:8d00])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8f39c6sm26277235e9.14.2025.12.12.03.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 03:32:26 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 12 Dec 2025 11:32:24 +0000
Subject: [PATCH v2 1/6] net: move net_state to net-common
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-lwip_nfs-v2-1-9cb5a60520d8@linaro.org>
References: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
In-Reply-To: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
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
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
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
either the legacy network code or lwIP. This is needed for porting
across the NFS support code for use with lwIP.

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

