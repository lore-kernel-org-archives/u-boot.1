Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB0606A322
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k2jRtaYF;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tx15oSGl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 757AC406A1;
	Mon,  9 Nov 2026 08:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xjcen2R4PCPP; Mon,  9 Nov 2026 08:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 109F1406D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794212058;
	b=cFlqrBd26ipRUD1HuHmrAHzqx3YUL+PwAfc5IQiGvvZYz8DR+mS44+Bwp8tQGigloE0f
	 UKtATkWL8oSiV47ysMNm4M7gvyg8PvvszB8oaeJPufCXZ8fRqqIP8LiRAVL9TNIY/ALEM
	 e8ulk1hJlYf5tdXkHkJwl90nFFS2fbQ3PXCTWow46L+kKUfovKyV55KNN9K00vayIEMyQ
	 aOLeVO+uZQU/TPrXLyLbuTssvki7Lh4KS/svumC+ZqgtuCCXZzAMdgtmzo1fEPVN5w5pG
	 sN4vaT3NYf8ovuxHN/BVqp3yuJY9W7XKtx/lNsHK55LPJ/C7lJ1jaZp+1tjS/nd5hHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794212058;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aldPxWUIWWL3jEMkM0rAy7z85Yn39LbvkXox+SMXMoc=;
	b=QYjscx0WzA9HqWkAWgK03ms7ezmZXQOOJD2JsT79veCvFh7DtXPeYwt772X1jzu+/vat
	 L6cM1PiEoAYrA5VkCYaLKGimPzY6BMmY/X5jLhMBgqX0gesdBP0wUy1oeXcwrpx5c/jYc
	 6BJmUYe6WZ3ZY+BR/B8xjzwpy0a/XzkHHSPMdh3LLD6hIsOHgvZILGKgMMhw3sRYJ4NBF
	 KisgTs5sUxaHdGYYoJfbzd0tlfFAfcYIYpxCK+6xUwq/uHM8z+ymIXIuUvvh03dBE4Xp5
	 gT+y5H/FUN7TsC+lmgItGKj1ruECVpymMIU62IBktbVjI6+6YWGQHDEjevh9albqeUA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tx15oSGl;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794212058;
	bh=aldPxWUIWWL3jEMkM0rAy7z85Yn39LbvkXox+SMXMoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k2jRtaYFO0FHj2++ZTXsWJ/kqaCt7EJtrKTrD9sljStffAD1SzciYM11dATZJFhog
	 hSEHhIExrxConPAD0pN20oq08CBzEslIQHz48F7r1tYEn4qhPqB4lLS6TfMFaENxEB
	 TmI5lqTACHZRcfWDe24sLuKgRBsclu9Y8lacFmaDNhkIGmBfL4NPCPOiZeHhDGiY76
	 Y2vLEB2PzT1DDF0raLyIiVNNWOZrU4DAQg1FCHR773jpTx8JCHy5I+nfoXH1wrOyWW
	 fg02/lDEQwnCj6l4azmR8kGzYq4U5PPJs1OzULpeKUBaAiFIPeYO2cKsSDtAJbZ++P
	 RMu2lHBwX4yag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 109F1406D1;
	Mon,  9 Nov 2026 08:14:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BB6B5235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD23E405F0
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MOBDUD1XG4Qm for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 08:14:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B1E33405ED
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=tx15oSGl
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1E33405ED
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:13 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6f5a0893610so381646eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 00:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794212052; x=1794816852;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aldPxWUIWWL3jEMkM0rAy7z85Yn39LbvkXox+SMXMoc=;
 b=tx15oSGlbib1EVEDuBW89hE8PteO6XKWmLwYrgDBbdO1O39e2m40iBaI/+8OhdnbIw
 hvxpollEKIxUBErCJ8bNZTAIVOrkl5ONsVWYc2MfEW5VwC0u0phDtec5Jz1vdcE/VM6U
 oCKRYsEKv+gTsy9z/7FLZnqEOqP1Q/+lXxWdCu3A3HuQmlc1KRVE4uR/S+QGsgtRQFSy
 z/iosa/1E4PdxNrLD1tBZ96XI2jbim+lJmf8hre1Zy9fQPFx822hCuKZiAUEj0K9g05F
 NQ2EEI7id2FuVU31k19+kymMLAqrx3SIaqX+DhlTejalGh4gyPjKnrSlWInYA6TAr2MI
 SWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794212052; x=1794816852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aldPxWUIWWL3jEMkM0rAy7z85Yn39LbvkXox+SMXMoc=;
 b=lT8dCvptj7Nwp6hV1gQyph72f0ttzqT+jIEWeZOSD0U4MTCpKvoz55eMtAvxzpFuZ7
 PaJ55iolfHrTfAwQUQFa+N6ybTbpTT1KE9TELNZWIYyKFW82xWvTSd9yVux7s1YlVmxL
 vLUttTtxnXSw7Q/ocv0Q61bugVOalRttOyszb01XEix9haYQmmGFKqSglma4xOxuKhby
 libDyb/RMXXIHAJUqhiwhUFTLBJdVU5Gv+IzuO7MH0wHxMd84C5cSmKx7Cb8ZQeOuWWk
 MvFdU0ZZwSVzGa7Misggq59rfnhnprnV35kYl1fnbUz5vcSOXwgDlnLydMXL/OV2JxUf
 BUmg==
X-Gm-Message-State: APuU4Z9EHuk6j4wF4zvFkQ0TE45oLXhHKdOL1vGh1V5hgKw1dsjXBBaf
 A0cNSbiCY9psHerXqfNXJNF/7Ts3S+ODHDO3kI26KLQNi/oOlwhJvSo+CDNsyV8U
X-Gm-Gg: AYBFou0IMaiX0U7/x7rWCPcDFpiQ87k+tn5oBYIQNDdwVul5QYHbusQjn8/s02WfbDQ
 eKXejOsAFH/S1S10cg3v8KfSpdmgBwlJofcql3CRWGvdIdX/EbkMKaNUiiLAil1NwtqC6bhol3v
 n3HujkD4hRPhH12ukdhbSEIaGslVewa+dRyeWpXEkCSPyDhMhwpkJJ7hcHi/kNyw+9BJWhSK3yP
 WbenI/CgtIxoygkdPqMq/cmEQk2gjz7UnfoyyFCRTpCtZCJpFMR07bDWMkNLKSAhEHhLPXhzmOT
 naoU4Lmj1f1AdKOakDWTEHfXJnTOKrwsddMRsAkrcx+rgmVrd9Q+E9Auo8kqR/VxN/QKokzgseN
 dEhK6bNA5vosse9NB81unCRE+PcEPbGjUlJ2SOCq7/VsBWRc6es7PYmy4dbt8tBVQBeKUP/To1T
 UXaU1yXDel0NjZgWZcCY6NB5MgZ61KtAzcOXbKNouk3/XvvjG0WUXKMNlK+PiR04sNsAX3fx8CM
 Fw06w4TP0mMccSMV4eu8deGPnZ8RxEYtepVWC8p2T5+5g3vp1AGqxc2QU1vYQ+0ZBCW6JyW4cvl
 BZE7DkwruRlS1uYDa1FM4wO0Q/UYtsbIWTJD6MZ9/RIvDGY1padiwEJ/DVJwbnxvNQjEKZB6hs9
 V3VY56ff30E2vX5KG2gDQ6ygp2tDXm6HGrUyNGIgF3JjwzqkxaUK4vt2Ij57Tf0x9FKSxRorJl3
 Rq89c7NB3oSI+QuyNN0rfDA13SseWaA3Q2Qsc9uJJuZ/SwIBNpLik=
X-Received: by 2002:a05:6820:806:b0:70a:4053:52e6 with SMTP id
 006d021491bc7-7170f1bff84mr1590367eaf.2.1794212052178; 
 Mon, 09 Nov 2026 00:14:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7170f8cbcb9sm2816766eaf.6.2026.11.09.00.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:14:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 01:14:08 -0700
Subject: [PATCH 1/3] net: wol: share magic-packet validation between
 network stacks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-submit-lwip-wol-v1-v1-1-d11961f7666f@gmail.com>
References: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
In-Reply-To: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the magic-packet check and optional Ethernet password handling into
a common helper, using the receiving interface MAC address explicitly.
Copy the four-byte password before formatting it so packet alignment is
not assumed. Store six-byte passwords with env_set() instead of treating
them as write-once MAC-address variables, so repeated waits can update
an existing password.

Give the command a stack-independent wol_wait() entry point. Keep zero
as an unlimited wait and reject malformed or overflowing timeout
arguments before entering the network loop.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/wol.c                  | 20 ++++++++++--------
 {net => include/net}/wol.h | 22 +++++++++-----------
 net/Makefile               |  1 +
 net/net.c                  |  2 +-
 net/wol-common.c           | 46 +++++++++++++++++++++++++++++++++++++++++
 net/wol.c                  | 51 +++++++---------------------------------------
 6 files changed, 77 insertions(+), 65 deletions(-)

diff --git a/cmd/wol.c b/cmd/wol.c
index 45d4ae3f719..a00b4c9511e 100644
--- a/cmd/wol.c
+++ b/cmd/wol.c
@@ -9,18 +9,23 @@
  */
 #include <command.h>
 #include <net.h>
-#include <vsprintf.h>
-
-#if defined(CONFIG_CMD_WOL)
-void wol_set_timeout(ulong);
+#include <net/wol.h>
+#include <linux/ctype.h>
 
 int do_wol(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	ulong timeout = 0;
+	const char *p;
+
 	/* Validate arguments */
-	if (argc < 2)
+	if (argc != 2 || !*argv[1])
 		return CMD_RET_USAGE;
-	wol_set_timeout(simple_strtol(argv[1], NULL, 10) * 1000);
-	if (net_loop(WOL) < 0)
+	for (p = argv[1]; *p; p++) {
+		if (!isdigit(*p) || timeout > (ULONG_MAX / 1000 - (*p - '0')) / 10)
+			return CMD_RET_USAGE;
+		timeout = timeout * 10 + (*p - '0');
+	}
+	if (wol_wait(timeout * 1000) < 0)
 		return CMD_RET_FAILURE;
 	return CMD_RET_SUCCESS;
 }
@@ -30,4 +35,3 @@ U_BOOT_CMD(
 	"wait for an incoming wake-on-lan packet",
 	"Timeout"
 );
-#endif
diff --git a/net/wol.h b/include/net/wol.h
similarity index 74%
rename from net/wol.h
rename to include/net/wol.h
index ebc81f24b6e..c604c000045 100644
--- a/net/wol.h
+++ b/include/net/wol.h
@@ -9,8 +9,6 @@
  * Copyright 2018 Lothar Felten, lothar.felten@gmail.com
  */
 
-#if defined(CONFIG_CMD_WOL)
-
 #ifndef __WOL_H__
 #define __WOL_H__
 
@@ -21,7 +19,6 @@
 #define WOL_SYNC_BYTE			0xFF
 #define WOL_SYNC_COUNT			6
 #define WOL_MAC_REPETITIONS		16
-#define WOL_DEFAULT_TIMEOUT		5000
 #define WOL_PASSWORD_4B			4
 #define WOL_PASSWORD_6B			6
 
@@ -31,9 +28,18 @@
 struct wol_hdr {
 	u8	wol_sync[WOL_SYNC_COUNT];			/* sync bytes */
 	u8	wol_dest[WOL_MAC_REPETITIONS * ARP_HLEN];	/* 16x MAC */
-	u8	wol_passwd[0];					/* optional */
+	u8	wol_passwd[];					/* optional */
 };
 
+/* Validate a complete magic packet addressed to @mac. */
+bool wol_check_magic(const void *packet, unsigned int len, const u8 *mac);
+
+/* Save the optional password from an already validated Ethernet packet. */
+void wol_save_password(const void *packet, unsigned int len);
+
+/* Wait for a magic packet; a zero timeout waits until interrupted. */
+int wol_wait(ulong timeout);
+
 /*
  * Initialize wol (beginning of netloop)
  */
@@ -52,14 +58,6 @@ void wol_start(void);
  */
 void wol_receive(struct ip_udp_hdr *ip, unsigned int len);
 
-/*
- * Set the timeout for the reception of a Wake-on-LAN packet
- *
- * @param timeout in milliseconds
- */
-void wol_set_timeout(ulong timeout);
-
 /**********************************************************************/
 
 #endif /* __WOL_H__ */
-#endif
diff --git a/net/Makefile b/net/Makefile
index 7745607248b..5a04852a4de 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
 obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
 obj-$(CONFIG_CMD_NFS)  += nfs-common.o
 obj-$(CONFIG_$(PHASE_)DM_ETH) += eth_common.o
+obj-$(CONFIG_CMD_WOL) += wol-common.o
 obj-y += net-common.o
 endif
 
diff --git a/net/net.c b/net/net.c
index 43889bba63a..f46cfee7129 100644
--- a/net/net.c
+++ b/net/net.c
@@ -117,7 +117,7 @@
 #include "ping.h"
 #include "rarp.h"
 #if defined(CONFIG_CMD_WOL)
-#include "wol.h"
+#include <net/wol.h>
 #endif
 
 /** BOOTP EXTENTIONS **/
diff --git a/net/wol-common.c b/net/wol-common.c
new file mode 100644
index 00000000000..2f86b9439d5
--- /dev/null
+++ b/net/wol-common.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2018 Lothar Felten, lothar.felten@gmail.com */
+
+#include <env.h>
+#include <net.h>
+#include <net/wol.h>
+#include <vsprintf.h>
+
+bool wol_check_magic(const void *packet, unsigned int len, const u8 *mac)
+{
+	const struct wol_hdr *wol = packet;
+	int i;
+
+	if (len < sizeof(*wol))
+		return false;
+
+	for (i = 0; i < WOL_SYNC_COUNT; i++)
+		if (wol->wol_sync[i] != WOL_SYNC_BYTE)
+			return false;
+
+	for (i = 0; i < WOL_MAC_REPETITIONS; i++)
+		if (memcmp(&wol->wol_dest[i * ARP_HLEN], mac, ARP_HLEN))
+			return false;
+
+	return true;
+}
+
+void wol_save_password(const void *packet, unsigned int len)
+{
+	const struct wol_hdr *wol = packet;
+
+	/* Ethernet padding may follow the optional ether-wake password. */
+	if (len >= sizeof(*wol) + WOL_PASSWORD_6B) {
+		char buffer[ARP_HLEN_ASCII + 1];
+
+		sprintf(buffer, "%pM", wol->wol_passwd);
+		env_set("wolpassword", buffer);
+	} else if (len >= sizeof(*wol) + WOL_PASSWORD_4B) {
+		struct in_addr ip;
+		char buffer[16];
+
+		memcpy(&ip, wol->wol_passwd, sizeof(ip));
+		ip_to_string(ip, buffer);
+		env_set("wolpassword", buffer);
+	}
+}
diff --git a/net/wol.c b/net/wol.c
index 96478ba5751..ba4644d7c11 100644
--- a/net/wol.c
+++ b/net/wol.c
@@ -4,38 +4,10 @@
  */
 
 #include <command.h>
-#include <env.h>
 #include <net.h>
-#include "wol.h"
+#include <net/wol.h>
 
-static ulong wol_timeout = WOL_DEFAULT_TIMEOUT;
-
-/*
- * Check incoming Wake-on-LAN packet for:
- * - sync bytes
- * - sixteen copies of the target MAC address
- *
- * @param wol Wake-on-LAN packet
- * @param len Packet length
- */
-static int wol_check_magic(struct wol_hdr *wol, unsigned int len)
-{
-	int i;
-
-	if (len < sizeof(struct wol_hdr))
-		return 0;
-
-	for (i = 0; i < WOL_SYNC_COUNT; i++)
-		if (wol->wol_sync[i] != WOL_SYNC_BYTE)
-			return 0;
-
-	for (i = 0; i < WOL_MAC_REPETITIONS; i++)
-		if (memcmp(&wol->wol_dest[i * ARP_HLEN],
-			   net_ethaddr, ARP_HLEN) != 0)
-			return 0;
-
-	return 1;
-}
+static ulong wol_timeout;
 
 void wol_receive(struct ip_udp_hdr *ip, unsigned int len)
 {
@@ -43,20 +15,10 @@ void wol_receive(struct ip_udp_hdr *ip, unsigned int len)
 
 	wol = (struct wol_hdr *)ip;
 
-	if (!wol_check_magic(wol, len))
+	if (!wol_check_magic(wol, len, net_ethaddr))
 		return;
 
-	/* save the optional password using the ether-wake formats */
-	/* don't check for exact length, the packet might have padding */
-	if (len >= (sizeof(struct wol_hdr) + WOL_PASSWORD_6B)) {
-		eth_env_set_enetaddr("wolpassword", wol->wol_passwd);
-	} else if (len >= (sizeof(struct wol_hdr) + WOL_PASSWORD_4B)) {
-		char buffer[16];
-		struct in_addr *ip = (struct in_addr *)(wol->wol_passwd);
-
-		ip_to_string(*ip, buffer);
-		env_set("wolpassword", buffer);
-	}
+	wol_save_password(wol, len);
 	net_set_state(NETLOOP_SUCCESS);
 }
 
@@ -71,15 +33,16 @@ static void wol_udp_handler(uchar *pkt, unsigned int dest, struct in_addr sip,
 	if (dest != 0 && dest != 7 && dest != 9)
 		return;
 
-	if (!wol_check_magic(wol, len))
+	if (!wol_check_magic(wol, len, net_ethaddr))
 		return;
 
 	net_set_state(NETLOOP_SUCCESS);
 }
 
-void wol_set_timeout(ulong timeout)
+int wol_wait(ulong timeout)
 {
 	wol_timeout = timeout;
+	return net_loop(WOL);
 }
 
 static void wol_timeout_handler(void)

-- 
2.53.0

