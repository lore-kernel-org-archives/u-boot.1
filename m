Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D13606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ooxvojn7;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iV/uQC5D
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6C8260DBB;
	Wed, 11 Nov 2026 20:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85gT7w1VmxDe; Wed, 11 Nov 2026 20:11:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2CB3760E23
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427903;
	b=e8zSUbqjL7/JbF6c85U6qwsZanJGv+wkw37bulM6RLfXDrGm71c4LBTyugrLL93RksN8
	 Dw6B9aHbzhqifK02IzHiX/pr/XEEqrJaP9XSMv1BWtN0fVuSv3GKQN/SdO7KOLlyA1nki
	 +gWWLgeTm4ahw+bOaowYMQX18YRBQb7oGl889AZUbtgmbKL25mZgdP6VPNWSjHuicAuN8
	 ndkKJAFjbJKlfNF1wVeAR64dBxNFywdl4nFDqVLmni+PoNirtVi3cWo88oGadew//XuT+
	 aIuaVDEj6npVCa6ihaWUZ5zG8AQmS4XB+9FHD1I/AX6wJwTCF+eCjjjZvgKM0lbI/Pw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427903;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WejIToGv+CMa5zrlc3D8sbE2kqK9lb3YZw5Lh23rwCM=;
	b=DDcabDoEcDmhZDsHSebfa3jvoF5NaY+1sIiVGaoKc+lwjAuqqe/5PophCFOz9x3ywQB6
	 eSaK7IRZxL9O2OhIQNEFICg7Wtlp+YrUP1If0ynOf4EsSigRwTjMR2/zfjV8rLskxEOsV
	 RpWovlJ49L4V6sYlwT/SiXhLka9gldhvzJCBnRzpE+ycKAPVNg/MMymjTHjy7ynYhsNyl
	 3Z3bStzZXH/55ADHVft9wOOKqI/sBzTbmsbXbux2xDtufxJGcV/Lmo//eLlpeyBHMEYyN
	 OdZBWQLvznCSm+v/6aG6FOj1PJ9sjWZ6RjFpALz1Xz6CviW2VAG/x46E5kX5NX91Twg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iV/uQC5D";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427903;
	bh=WejIToGv+CMa5zrlc3D8sbE2kqK9lb3YZw5Lh23rwCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ooxvojn77ko0+M3hZvst0X4kk+D8njkk3NiHXTs2jPW2D7EjEUwyNvBPyb3QBhBpX
	 emikTOJus/KzQZ+tE3H8/QmMxs3oWhlI3yoMg9LGAqmD3oprpKEjR+r1+d4/mNjf8V
	 R4roi1mFhKyxJxYcTR5ODkTlbUztgtvFT6ReDaqE6MNBuV8hWiPgZOhelBbNpeark+
	 RuCWdNB2TvtkzMcsjwkGKgJFGRVCI89ERV28rJKyE4RX8O9mRPAENZdYjaXFDacxwT
	 Fy6CaZbx0Ipi8esAi52b+cXrKdjqXbuAZC9XBFFER8lDykpFGP6mAZB/ZCPTqxG/4s
	 3Fk0T5EWwCErg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CB3760E23;
	Wed, 11 Nov 2026 20:11:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE189E09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE0B860E15
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m91lY5QmbIUl for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C923560DEC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=iV/uQC5D
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C923560DEC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:30 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4f48d91ba7dso1930722b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427889; x=1795032689;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WejIToGv+CMa5zrlc3D8sbE2kqK9lb3YZw5Lh23rwCM=;
 b=iV/uQC5D8Php7QPzkds18/FmeumEXJYaC0VPxsJ4XVu+ZHVSNWCFHKvyIXAOBH3BCi
 FFUTXbSrP+rXq9MfoN7dhp8Hoo/2xW/1I3uslQU66RnhTnC7GKD/5Xp/iF7Z9mfIzOjY
 y538SLmqLWlqrXc/RFa8wIUiaHw/sz+r2TSRDvfvOZ/fb0ZdkjN+lPLToZpfQavFaUMx
 8EnMetlhkNjug6gsLmxKCKu58B7B2Mc6BQfSgm7oFlbEFDRyulycGmbZqy5tmEFdWnBt
 kJo1ZH4vloGekQp3UhZcfxRwkk5g03zSlBxTQ0SDAI3v0144KJhjhU8vs+TwxNANrXVS
 jKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427889; x=1795032689;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WejIToGv+CMa5zrlc3D8sbE2kqK9lb3YZw5Lh23rwCM=;
 b=f248UuqUh0sUb+luDMz7rCvAdf1vksMB6u8HOVANGXgp2O7VKWYWgyf8GuUL+iqS6O
 eC1+ymEsOZ9KUjy8n6921WXPh71+TmtxTt1aqk9+Wr6W/Ng9wJ/JsE76sSLAaEV5g1p3
 PwTwCWrU8j0NmAA8O5m7z/kH1gC9YE9jIghh7zHB27uin4JzqZFcBE+nf1gw1NAa+RPh
 W7j7GN1mjAkcXcEpvKIbIsSrijA/QNSEXiXnWTCYQ4Xrl2sAwUwMTJtj7EL0D0NpM3TL
 8fVw1eN2dmzR4+h6CJkTrSeaa6xqQEDYdfa5MwYhwJlytZF0W5NbfSUSFHdiiYObjBil
 gObw==
X-Forwarded-Encrypted: i=1;
 AL+hErGtG8jl3qVimnf9+5QbuVKKDUxcm05VDs+etbbOA/PL7fmP+PuJV8uoTE8RinO6RJsDsF+s46A=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9WDe0+SVvUjSFP12/wza3mDGcxlyd7oxCu9xSyxFTa7zUENGMr
 pirp+ZHypZNFx3OMtAtIgGRx8iapiVGej+NO81PA03suFo+TMTUL/pWi
X-Gm-Gg: AYBFou1z3f179fqSiaZx8yvHlqqLMw5d3rdUsB93V5GEifxs1+Kv3CZ6Gu4atOaKhcy
 AwX3KAWFXl4UB0K2NY8LVbAPWc7EMURVX7whlsxxPzXUnGEK+0loHJCzOb4yDQ8bHgsvvgWDUVd
 sCzGYA2e81STHZIeFIAPbHKnlovOxDkFaM8KOmv+iSQ7PGjZrpCVK58CFxGfXTU84+PD3JNLHGD
 rzqp8vQ+tzzHaCmfZUYlfkoJ+J75Ev0yavLmBunfbMoF/XgZNKWmXTrkAD+U6uSk5pbwyrPr6vb
 T4IUOoGoceEay/7txd4dNQqNp0CSvzJatC0n4yqA4YOpv+aaIyNW3TI+JbcwWNFKgrpvFjS940O
 RlAnvRkXHsqKr64WP9uHTC/ZSftwuCwGO2d7u+l2tBV487VunLyzioUlshI2V31q0y/CfVgInM1
 iyIv58uxX7V9DZa0C11l8RCnN/Pohhb4onI271Tga/CEwF4XxqdNhq0nQuyv3H/ybxDZLvbU6Q8
 4LocZWJOKc/BdRAul8iHRRSQ9fCVLDKSBtubQqRWVNMQem8oAIcA5uv4xonnmXOO2fEjfb6peDQ
 Jn8WUcT4EBZIE5LFXUS3n0syV3XYF0V7m0NuyZZ9H0hvhwx4JJbKa30rMzO7SFpcVPl7T2DUHi7
 xocCyVB78NMA9tf/o/dh2iMe4ulCuEBurmcJUqPOgiE6roeW5HVRMnTkHSFSo+BA+XdBvBoyDBO
 giRMnRlKZdFK9KN1y3W1UokR36v/7HYP4yr9Mb8vTt5CA57kuWHi4=
X-Received: by 2002:a05:6808:2388:b0:517:dd67:aeb7 with SMTP id
 5614622812f47-56b97e2b6cbmr3241084b6e.56.1794427889095; 
 Wed, 11 Nov 2026 12:11:29 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:28 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:16 -0700
Subject: [PATCH 09/19] net: lwip: resolve hostnames on IPv6 networks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-9-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
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

Resolve names in the existing runtime context so address configuration,
DNS traffic and the requested transfer use the same Ethernet interface.
Support AAAA lookups, IPv6 DNS servers and router-advertised RDNSS, while
retaining IPv4 servers and A-record lookup on dual-stack interfaces.

Select configured servers with a usable source address and route without
waiting for an unavailable server in another address family. Poll for
address configuration only when none of the configured servers is ready.
Provide a nonblocking refresh for changes to the network configuration.

Keep explicit environment settings ahead of RDNSS and cancel asynchronous
lookup callbacks before returning, including on timeout or interruption.
Expire and withdraw advertised servers using their own lifetimes,
including time spent without network polling, and check expiry before
resolver setup. Skip empty resolver slots for new queries and failover.
Match refreshes by address and interface so reordered advertisements
cannot duplicate a server or leave a stale lifetime behind. Replace the
earliest-expiring entry when the table is full. Validate RDNSS options
against their wire length even when receive buffers are chained.

Transfer DNS ownership when explicit servers are installed, including when
an explicit server has the same address as a learned one. Keep learned
lifetimes active until that replacement occurs. Clear a withdrawn explicit
setting before accepting a new advertisement so a later resolver refresh
does not discard the newly learned server.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/lwip/dns.c                            |   4 +-
 cmd/lwip/ping.c                           |  24 ++-
 include/net-lwip.h                        |  10 +-
 lib/lwip/lwip/src/core/dns.c              |  28 +++-
 lib/lwip/lwip/src/core/ipv6/nd6.c         | 127 +++++++++++++---
 lib/lwip/lwip/src/include/lwip/ip6_addr.h |   2 +-
 lib/lwip/lwip/src/include/lwip/nd6.h      |   3 +
 lib/lwip/u-boot/lwip-hooks.h              |   4 +
 lib/lwip/u-boot/lwipopts.h                |   2 +
 net/lwip/dns.c                            | 245 ++++++++++++++++++++++--------
 net/lwip/net-lwip.c                       |  96 +++++-------
 net/lwip/wget.c                           |   2 +-
 12 files changed, 385 insertions(+), 162 deletions(-)

diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
index 3eb698b3f82..7eebbb71b99 100644
--- a/cmd/lwip/dns.c
+++ b/cmd/lwip/dns.c
@@ -4,5 +4,5 @@
 #include <command.h>
 #include <net.h>
 
-U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
-	   "hostname [envvar]");
+U_BOOT_CMD(dns, 3 + IS_ENABLED(CONFIG_IPV6), 1, do_dns, "lookup the IP of a hostname",
+	   "hostname [envvar] [-ipv6]");
diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index aaa2204688b..31c9e0ad4d6 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -170,15 +170,16 @@ static int ping_loop(struct net_lwip_ctx *net, const ip_addr_t *addr)
 	return ret < 0 ? ret : -ETIMEDOUT;
 }
 
-static int ping_execute(const ip_addr_t *addr)
+static int ping_execute(const char *name, u8 type)
 {
 	struct net_lwip_ctx net = {};
+	ip_addr_t addr;
 	int ret;
 
 	net_try_count = 1;
 
 	do {
-		ret = net_lwip_start(&net, IP_IS_V6(addr) ? NET_LWIP_ADDR_ENV_FLEXIBLE :
+		ret = net_lwip_start(&net, type == IPADDR_TYPE_V6 ? NET_LWIP_ADDR_ENV_FLEXIBLE :
 				    NET_LWIP_ADDR_ENV_STRICT);
 		if (!ret)
 			break;
@@ -187,7 +188,9 @@ static int ping_execute(const ip_addr_t *addr)
 		return CMD_RET_FAILURE;
 
 	do {
-		ret = ping_loop(&net, addr);
+		ret = net_lwip_resolve(&net, name, &addr, type);
+		if (!ret)
+			ret = ping_loop(&net, &addr);
 		if (!ret || ret == -EINTR || ret == -EINVAL || ret == -EADDRINUSE ||
 		    ret == -EBUSY)
 			break;
@@ -203,12 +206,10 @@ static int ping_execute(const ip_addr_t *addr)
 #if CONFIG_IS_ENABLED(CMD_PING)
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	ip_addr_t addr;
-
-	if (argc != 2 || net_lwip_dns_resolve(argv[1], &addr) || !IP_IS_V4(&addr))
+	if (argc != 2)
 		return CMD_RET_USAGE;
 
-	return ping_execute(&addr);
+	return ping_execute(argv[1], IPADDR_TYPE_V4);
 }
 
 U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
@@ -218,15 +219,12 @@ U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
 #if CONFIG_IS_ENABLED(CMD_PING6)
 static int do_ping6(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	ip_addr_t addr;
-
-	if (argc != 2 || net_lwip_ip6_aton(argv[1], ip_2_ip6(&addr)))
+	if (argc != 2)
 		return CMD_RET_USAGE;
-	IP_SET_TYPE_VAL(addr, IPADDR_TYPE_V6);
 
-	return ping_execute(&addr);
+	return ping_execute(argv[1], IPADDR_TYPE_V6);
 }
 
 U_BOOT_CMD(ping6, 2, 1, do_ping6, "send ICMPv6 ECHO_REQUEST to network host",
-	   "IPv6address");
+	   "IPv6addressOrHostName");
 #endif
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 3a5a0219f2b..ea5ec8a03ec 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -75,7 +75,7 @@ int eth_init_state_only(void); /* Set active state */
 
 int net_lwip_parse_decimal(const char *text, size_t len, unsigned int max,
 			   unsigned int *value);
-int net_lwip_dns_init(void);
+int net_lwip_dns_init(struct net_lwip_ctx *ctx);
 int net_lwip_start(struct net_lwip_ctx *ctx,
 		   enum net_lwip_addr_mode addr_mode);
 void net_lwip_stop(struct net_lwip_ctx *ctx);
@@ -83,6 +83,14 @@ int net_lwip_restart(struct net_lwip_ctx *ctx);
 int net_lwip_refresh(struct net_lwip_ctx *ctx);
 int net_lwip_poll(void);
 int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
+int net_lwip_resolve(struct net_lwip_ctx *ctx, const char *name,
+		     ip_addr_t *addr, u8 type);
+int net_lwip_prepare_addr(struct net_lwip_ctx *ctx, ip_addr_t *addr);
+#if CONFIG_IS_ENABLED(DNS)
+int net_lwip_dns_refresh(struct net_lwip_ctx *ctx);
+int net_lwip_dns_lookup(struct net_lwip_ctx *ctx, const char *name,
+			ip_addr_t *addr, u8 type);
+#endif
 #if CONFIG_IS_ENABLED(IPV6)
 void net_lwip_ip6_update_lifetimes(void);
 int net_lwip_ip6_aton(const char *text, ip6_addr_t *addr);
diff --git a/lib/lwip/lwip/src/core/dns.c b/lib/lwip/lwip/src/core/dns.c
index 5762647ee27..cfbb6fb6aed 100644
--- a/lib/lwip/lwip/src/core/dns.c
+++ b/lib/lwip/lwip/src/core/dns.c
@@ -1062,6 +1062,16 @@ again:
   return txid;
 }
 
+/* Find the first configured server at or after start. */
+static u8_t
+dns_find_server(u8_t start)
+{
+  while (start < DNS_MAX_SERVERS && ip_addr_isany_val(dns_servers[start])) {
+    start++;
+  }
+  return start;
+}
+
 /**
  * Check whether there are other backup DNS servers available to try
  */
@@ -1071,7 +1081,7 @@ dns_backupserver_available(struct dns_table_entry *pentry)
   u8_t ret = 0;
 
   if (pentry) {
-    if ((pentry->server_idx + 1 < DNS_MAX_SERVERS) && !ip_addr_isany_val(dns_servers[pentry->server_idx + 1])) {
+    if (dns_find_server(pentry->server_idx + 1) < DNS_MAX_SERVERS) {
       ret = 1;
     }
   }
@@ -1101,7 +1111,17 @@ dns_check_entry(u8_t i)
       /* initialize new entry */
       entry->txid = dns_create_txid();
       entry->state = DNS_STATE_ASKING;
-      entry->server_idx = 0;
+      entry->server_idx = dns_find_server(0);
+#if LWIP_DNS_SUPPORT_MDNS_QUERIES
+      if (entry->is_mdns) {
+        entry->server_idx = 0;
+      }
+#endif
+      if (entry->server_idx == DNS_MAX_SERVERS) {
+        dns_call_found(i, NULL);
+        entry->state = DNS_STATE_UNUSED;
+        break;
+      }
       entry->tmr = 1;
       entry->retries = 0;
 
@@ -1121,7 +1141,7 @@ dns_check_entry(u8_t i)
 #endif /* LWIP_DNS_SUPPORT_MDNS_QUERIES */
              ) {
             /* change of server */
-            entry->server_idx++;
+            entry->server_idx = dns_find_server(entry->server_idx + 1);
             entry->tmr = 1;
             entry->retries = 0;
           } else {
@@ -1670,7 +1690,7 @@ dns_gethostbyname_addrtype(const char *hostname, ip_addr_t *addr, dns_found_call
 #endif /* LWIP_DNS_SUPPORT_MDNS_QUERIES */
   {
     /* prevent calling found callback if no server is set, return error instead */
-    if (ip_addr_isany_val(dns_servers[0])) {
+    if (dns_find_server(0) == DNS_MAX_SERVERS) {
       return ERR_VAL;
     }
   }
diff --git a/lib/lwip/lwip/src/core/ipv6/nd6.c b/lib/lwip/lwip/src/core/ipv6/nd6.c
index 52cb997be3c..5117c9c5802 100644
--- a/lib/lwip/lwip/src/core/ipv6/nd6.c
+++ b/lib/lwip/lwip/src/core/ipv6/nd6.c
@@ -91,6 +91,48 @@ struct nd6_destination_cache_entry destination_cache[LWIP_ND6_NUM_DESTINATIONS];
 struct nd6_prefix_list_entry prefix_list[LWIP_ND6_NUM_PREFIXES];
 struct nd6_router_list_entry default_router_list[LWIP_ND6_NUM_ROUTERS];
 
+#if LWIP_ND6_RDNSS_MAX_DNS_SERVERS
+static struct {
+  struct netif *netif;
+  ip_addr_t addr;
+  u32_t lifetime;
+} rdnss_servers[DNS_MAX_SERVERS];
+
+/* Refresh an existing server before considering an empty or expiring slot. */
+static void
+nd6_update_rdnss(struct netif *netif, const ip_addr_t *addr, u32_t lifetime)
+{
+  u8_t i, slot = 0;
+
+  for (i = 0; i < DNS_MAX_SERVERS; i++) {
+    if (rdnss_servers[i].netif == netif && ip_addr_cmp(&rdnss_servers[i].addr, addr)) {
+      if (lifetime == 0) {
+        if (ip_addr_cmp(dns_getserver(i), addr)) {
+          dns_setserver(i, NULL);
+        }
+        rdnss_servers[i].netif = NULL;
+      } else {
+        rdnss_servers[i].lifetime = lifetime;
+        dns_setserver(i, addr);
+      }
+      return;
+    }
+    if (rdnss_servers[slot].netif &&
+        (!rdnss_servers[i].netif ||
+         rdnss_servers[i].lifetime < rdnss_servers[slot].lifetime)) {
+      slot = i;
+    }
+  }
+  if (lifetime == 0) {
+    return;
+  }
+  rdnss_servers[slot].netif = netif;
+  rdnss_servers[slot].addr = *addr;
+  rdnss_servers[slot].lifetime = lifetime;
+  dns_setserver(slot, addr);
+}
+#endif
+
 /* Default values, can be updated by a RA message. */
 u32_t reachable_time = LWIP_ND6_REACHABLE_TIME;
 u32_t retrans_timer = LWIP_ND6_RETRANS_TIMER; /* @todo implement this value in timer */
@@ -105,7 +147,9 @@ static netif_addr_idx_t nd6_cached_destination_index;
 /* Multicast address holder. */
 static ip6_addr_t multicast_address;
 
+#if LWIP_IPV6_SEND_ROUTER_SOLICIT
 static u8_t nd6_tmr_rs_reduction;
+#endif
 
 /* Static buffer to parse RA packet options */
 union ra_options {
@@ -575,10 +619,6 @@ nd6_input(struct pbuf *p, struct netif *inp)
     struct ra_header *ra_hdr;
     u8_t *buffer; /* Used to copy options. */
     u16_t offset;
-#if LWIP_ND6_RDNSS_MAX_DNS_SERVERS
-    /* There can be multiple RDNSS options per RA */
-    u8_t rdnss_server_idx = 0;
-#endif /* LWIP_ND6_RDNSS_MAX_DNS_SERVERS */
 
     /* Check that RA header fits in packet. */
     if (p->len < sizeof(struct ra_header)) {
@@ -673,18 +713,22 @@ nd6_input(struct pbuf *p, struct netif *inp)
         /* no need to copy from contiguous pbuf */
         buffer = &((u8_t*)p->payload)[offset];
       } else {
+        u16_t copy_len = option_len;
+
         /* check if this option fits into our buffer */
-        if (option_len > sizeof(nd6_ra_buffer)) {
+        if (copy_len > sizeof(nd6_ra_buffer)) {
           option_type = pbuf_get_at(p, offset);
           /* invalid option length */
           if (option_type != ND6_OPTION_TYPE_RDNSS) {
             goto lenerr_drop_free_return;
           }
-          /* we allow RDNSS option to be longer - we'll just drop some servers */
-          option_len = sizeof(nd6_ra_buffer);
+          /* RDNSS addresses are copied directly from the pbuf below. */
+          copy_len = sizeof(nd6_ra_buffer);
         }
         buffer = (u8_t*)&nd6_ra_buffer;
-        option_len = pbuf_copy_partial(p, &nd6_ra_buffer, option_len, offset);
+        if (pbuf_copy_partial(p, &nd6_ra_buffer, copy_len, offset) != copy_len) {
+          goto lenerr_drop_free_return;
+        }
       }
       option_type = buffer[0];
       switch (option_type) {
@@ -779,13 +823,19 @@ nd6_input(struct pbuf *p, struct netif *inp)
         u8_t num, n;
         u16_t copy_offset = offset + SIZEOF_RDNSS_OPTION_BASE;
         struct rdnss_option * rdnss_opt;
-        if (option_len < SIZEOF_RDNSS_OPTION_BASE) {
+        if (option_len < SIZEOF_RDNSS_OPTION_BASE + sizeof(ip6_addr_p_t) ||
+            (option_len - SIZEOF_RDNSS_OPTION_BASE) % sizeof(ip6_addr_p_t)) {
           goto lenerr_drop_free_return;
         }
+#ifdef LWIP_HOOK_ND6_RDNSS_ACCEPT
+        if (!LWIP_HOOK_ND6_RDNSS_ACCEPT(inp)) {
+          break;
+        }
+#endif
 
         rdnss_opt = (struct rdnss_option *)buffer;
         num = (rdnss_opt->length - 1) / 2;
-        for (n = 0; (rdnss_server_idx < DNS_MAX_SERVERS) && (n < num); n++, copy_offset += sizeof(ip6_addr_p_t)) {
+        for (n = 0; n < num; n++, copy_offset += sizeof(ip6_addr_p_t)) {
           ip_addr_t rdnss_address;
 
           /* Copy directly from pbuf to get an aligned, zoned copy of the prefix. */
@@ -793,19 +843,15 @@ nd6_input(struct pbuf *p, struct netif *inp)
             IP_SET_TYPE_VAL(rdnss_address, IPADDR_TYPE_V6);
             ip6_addr_assign_zone(ip_2_ip6(&rdnss_address), IP6_UNKNOWN, inp);
 
-            if (htonl(rdnss_opt->lifetime) > 0) {
-              /* TODO implement Lifetime > 0 */
-              dns_setserver(rdnss_server_idx++, &rdnss_address);
-            } else {
-              /* TODO implement DNS removal in dns.c */
-              u8_t s;
-              for (s = 0; s < DNS_MAX_SERVERS; s++) {
-                const ip_addr_t *addr = dns_getserver(s);
-                if(ip_addr_eq(addr, &rdnss_address)) {
-                  dns_setserver(s, NULL);
-                }
-              }
+            if (ip6_addr_isany(ip_2_ip6(&rdnss_address)) ||
+                ip6_addr_ismulticast(ip_2_ip6(&rdnss_address)) ||
+                ip6_addr_isloopback(ip_2_ip6(&rdnss_address)) ||
+                ip6_addr_isipv4mappedipv6(ip_2_ip6(&rdnss_address)) ||
+                ip6_addr_isipv4compat(ip_2_ip6(&rdnss_address))) {
+              continue;
             }
+
+            nd6_update_rdnss(inp, &rdnss_address, lwip_ntohl(rdnss_opt->lifetime));
           }
         }
         break;
@@ -975,6 +1021,22 @@ nd6_age_lifetimes(u32_t elapsed)
   if (elapsed == 0) {
     return;
   }
+
+#if LWIP_ND6_RDNSS_MAX_DNS_SERVERS
+  for (i = 0; i < DNS_MAX_SERVERS; i++) {
+    if (rdnss_servers[i].netif && rdnss_servers[i].lifetime != 0xffffffffUL) {
+      if (rdnss_servers[i].lifetime <= elapsed) {
+        if (ip_addr_cmp(dns_getserver(i), &rdnss_servers[i].addr)) {
+          dns_setserver(i, NULL);
+        }
+        rdnss_servers[i].netif = NULL;
+      } else {
+        rdnss_servers[i].lifetime -= elapsed;
+      }
+    }
+  }
+#endif
+
   /* Process router entries. */
   for (i = 0; i < LWIP_ND6_NUM_ROUTERS; i++) {
     if (default_router_list[i].neighbor_entry != NULL) {
@@ -2409,6 +2471,24 @@ nd6_reachability_hint(const ip6_addr_t *ip6addr)
 }
 #endif /* LWIP_ND6_TCP_REACHABILITY_HINTS */
 
+#if LWIP_ND6_RDNSS_MAX_DNS_SERVERS
+/** Remove the DNS servers learned through router advertisements on netif. */
+void
+nd6_clear_rdnss(struct netif *netif)
+{
+  u8_t i;
+
+  for (i = 0; i < DNS_MAX_SERVERS; i++) {
+    if (rdnss_servers[i].netif == netif) {
+      if (ip_addr_cmp(dns_getserver(i), &rdnss_servers[i].addr)) {
+        dns_setserver(i, NULL);
+      }
+      rdnss_servers[i].netif = NULL;
+    }
+  }
+}
+#endif
+
 /**
  * Remove all prefix, neighbor_cache and router entries of the specified netif.
  *
@@ -2419,6 +2499,9 @@ nd6_cleanup_netif(struct netif *netif)
 {
   u8_t i;
   s8_t router_index;
+#if LWIP_ND6_RDNSS_MAX_DNS_SERVERS
+  nd6_clear_rdnss(netif);
+#endif
   for (i = 0; i < LWIP_ND6_NUM_PREFIXES; i++) {
     if (prefix_list[i].netif == netif) {
       prefix_list[i].netif = NULL;
diff --git a/lib/lwip/lwip/src/include/lwip/ip6_addr.h b/lib/lwip/lwip/src/include/lwip/ip6_addr.h
index 5937fed9f00..abca6e6af16 100644
--- a/lib/lwip/lwip/src/include/lwip/ip6_addr.h
+++ b/lib/lwip/lwip/src/include/lwip/ip6_addr.h
@@ -227,7 +227,7 @@ typedef struct ip6_addr ip6_addr_t;
 #define ip6_addr_isipv4compat(ip6addr) (((ip6addr)->addr[0] == 0UL) && \
                                         ((ip6addr)->addr[1] == 0UL) && \
                                         ((ip6addr)->addr[2] == 0UL) && \
-                                        (htonl((ip6addr)->addr[3]) > 1))
+                                        (lwip_htonl((ip6addr)->addr[3]) > 1))
 
 #define ip6_addr_ismulticast(ip6addr) (((ip6addr)->addr[0] & PP_HTONL(0xff000000UL)) == PP_HTONL(0xff000000UL))
 #define ip6_addr_multicast_transient_flag(ip6addr)  ((ip6addr)->addr[0] & PP_HTONL(0x00100000UL))
diff --git a/lib/lwip/lwip/src/include/lwip/nd6.h b/lib/lwip/lwip/src/include/lwip/nd6.h
index f93fff5c157..96767cac0ab 100644
--- a/lib/lwip/lwip/src/include/lwip/nd6.h
+++ b/lib/lwip/lwip/src/include/lwip/nd6.h
@@ -77,6 +77,9 @@ u16_t nd6_get_destination_mtu(const ip6_addr_t *ip6addr, struct netif *netif);
 void nd6_reachability_hint(const ip6_addr_t *ip6addr);
 #endif /* LWIP_ND6_TCP_REACHABILITY_HINTS */
 void nd6_cleanup_netif(struct netif *netif);
+#if LWIP_ND6_RDNSS_MAX_DNS_SERVERS
+void nd6_clear_rdnss(struct netif *netif);
+#endif
 #if LWIP_IPV6_MLD
 void nd6_adjust_mld_membership(struct netif *netif, s8_t addr_idx, u8_t new_state);
 #endif /* LWIP_IPV6_MLD */
diff --git a/lib/lwip/u-boot/lwip-hooks.h b/lib/lwip/u-boot/lwip-hooks.h
index 0d955277908..a4a22bdaf04 100644
--- a/lib/lwip/u-boot/lwip-hooks.h
+++ b/lib/lwip/u-boot/lwip-hooks.h
@@ -23,6 +23,10 @@ int net_lwip_ip6_static_prefix(struct netif *netif, unsigned int index,
 const ip6_addr_t *net_lwip_ip6_gateway(struct netif *netif,
 				       const ip6_addr_t *dest);
 #define LWIP_HOOK_ND6_GET_GW net_lwip_ip6_gateway
+#if LWIP_ND6_RDNSS_MAX_DNS_SERVERS
+int net_lwip_rdnss_accept(struct netif *netif);
+#define LWIP_HOOK_ND6_RDNSS_ACCEPT net_lwip_rdnss_accept
+#endif
 #endif
 
 #endif /* __UBOOT_LWIP_HOOKS_H */
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 565fea4f4fe..2c07bdd545c 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -63,6 +63,8 @@
 #define LWIP_IPV6			IS_ENABLED(CONFIG_IPV6)
 #define LWIP_IPV6_SEND_ROUTER_SOLICIT	IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
 #define LWIP_IPV6_AUTOCONFIG		IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
+#define LWIP_ND6_RDNSS_MAX_DNS_SERVERS	(IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY) && \
+					 IS_ENABLED(CONFIG_DNS) ? DNS_MAX_SERVERS : 0)
 /* A 64-bit reassembly pointer does not fit in the fragment header. */
 #define IPV6_FRAG_COPYHEADER		IS_ENABLED(CONFIG_64BIT)
 #define LWIP_HOOK_FILENAME		"lwip-hooks.h"
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index e932b3c6965..9c3e8a851f2 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -5,102 +5,223 @@
 #include <console.h>
 #include <env.h>
 #include <lwip/dns.h>
-#include <lwip/timeouts.h>
+#include <lwip/nd6.h>
 #include <net.h>
 #include <time.h>
 
-#define DNS_RESEND_MS 1000
 #define DNS_TIMEOUT_MS 10000
 
-struct dns_cb_arg {
-	ip_addr_t host_ipaddr;
+struct dns_result {
+	ip_addr_t addr;
 	bool done;
 };
 
-static void do_dns_tmr(void *arg)
+static bool dns_from_env;
+
+static void dns_clear_env(void)
 {
-	dns_tmr();
+	if (!dns_from_env)
+		return;
+	for (unsigned int i = 0; i < DNS_MAX_SERVERS; i++)
+		dns_setserver(i, NULL);
+	dns_from_env = false;
+}
+
+int net_lwip_rdnss_accept(struct netif *netif)
+{
+	static const char *const vars[] = { "dnsip", "dnsip2", "dnsip6", "dnsip6_2" };
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(vars); i++) {
+		const char *value = env_get(vars[i]);
+
+		if (value && *value)
+			return false;
+	}
+	/* Withdraw the old override before installing newly learned servers. */
+	dns_clear_env();
+	return true;
 }
 
 static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 {
-	struct dns_cb_arg *dns_cb_arg = arg;
+	struct dns_result *result = arg;
 
-	dns_cb_arg->done = true;
+	ip_addr_set(&result->addr, ipaddr);
+	result->done = true;
+}
 
-	if (!ipaddr)
-		printf("DNS: host not found\n");
+static int dns_server_ready(struct net_lwip_ctx *net, ip_addr_t *server)
+{
+#if CONFIG_IS_ENABLED(IPV6)
+	if (IP_IS_V6(server))
+		return net_lwip_ip6_ready(net, server);
+#endif
+	return ip4_addr_isany_val(*netif_ip4_addr(net->netif)) ? -EAGAIN : 0;
+}
 
-	ip_addr_set(&dns_cb_arg->host_ipaddr, ipaddr);
+/* Install usable environment servers without waiting for another family. */
+int net_lwip_dns_refresh(struct net_lwip_ctx *net)
+{
+	static const char *const v4_first[] = {
+		"dnsip", "dnsip2", "dnsip6", "dnsip6_2",
+	};
+	static const char *const v6_first[] = {
+		"dnsip6", "dnsip6_2", "dnsip", "dnsip2",
+	};
+	const char *const *vars = ip4_addr_isany_val(*netif_ip4_addr(net->netif)) ?
+				 v6_first : v4_first;
+	ip_addr_t servers[DNS_MAX_SERVERS];
+	unsigned int count = 0, configured = 0;
+	bool pending = false;
+	int ret, error = -EADDRNOTAVAIL;
+
+#if CONFIG_IS_ENABLED(IPV6)
+	net_lwip_ip6_update_lifetimes();
+#endif
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(v4_first) && count < DNS_MAX_SERVERS; i++) {
+		const char *value = env_get(vars[i]);
+
+		if (!value || !*value)
+			continue;
+		configured++;
+		if (!ipaddr_aton(value, &servers[count]) || ip_addr_isany(&servers[count]))
+			return -EINVAL;
+#if CONFIG_IS_ENABLED(IPV6)
+		if (IP_IS_V6(&servers[count]) &&
+		    net_lwip_ip6_aton(value, ip_2_ip6(&servers[count])))
+			return -EINVAL;
+#endif
+		ret = dns_server_ready(net, &servers[count]);
+		if (ret) {
+			pending |= ret == -EAGAIN;
+			error = ret;
+			continue;
+		}
+		count++;
+	}
+	if (!configured) {
+		dns_clear_env();
+		return -ENOENT;
+	}
+#if LWIP_ND6_RDNSS_MAX_DNS_SERVERS
+	nd6_clear_rdnss(net->netif);
+#endif
+	for (unsigned int i = 0; i < DNS_MAX_SERVERS; i++)
+		dns_setserver(i, i < count ? &servers[i] : NULL);
+	dns_from_env = true;
+	if (count)
+		return 0;
+	return pending ? -EAGAIN : error;
 }
 
-static int dns_loop(struct net_lwip_ctx *net, const char *name,
-		    const char *var)
+int net_lwip_dns_init(struct net_lwip_ctx *net)
 {
-	struct dns_cb_arg dns_cb_arg = { };
-	const char *ipstr;
-	ip_addr_t ipaddr;
-	ulong start;
 	int ret;
 
-	if (net_lwip_dns_init())
-		return CMD_RET_FAILURE;
-
-	dns_cb_arg.done = false;
-
-	ret = dns_gethostbyname(name, &ipaddr, dns_cb, &dns_cb_arg);
-
-	if (ret == ERR_OK) {
-		dns_cb(name, &ipaddr, &dns_cb_arg);
-	} else if (ret == ERR_INPROGRESS) {
-		start = get_timer(0);
-		sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
-		do {
-			net_lwip_poll();
-			if (dns_cb_arg.done)
-				break;
-			if (ctrlc()) {
-				printf("\nAbort\n");
-				break;
+	for (ulong start = get_timer(0); get_timer(start) < 15000;) {
+		ret = net_lwip_dns_refresh(net);
+		if (!ret)
+			return 0;
+		if (ret == -ENOENT) {
+
+#if CONFIG_IS_ENABLED(IPV6_ROUTER_DISCOVERY)
+			/* RDNSS can configure DNS on an IPv6-only link without DHCP. */
+			ret = net_lwip_ip6_init(net);
+			if (ret)
+				return ret;
+			for (unsigned int i = 0; i < DNS_MAX_SERVERS; i++) {
+				ip_addr_t server = *dns_getserver(i);
+
+				if (!ip_addr_isany(&server) && !dns_server_ready(net, &server))
+					return 0;
 			}
-		} while (get_timer(start) < DNS_TIMEOUT_MS);
-		sys_untimeout(do_dns_tmr, NULL);
-		dns_cancel(dns_cb, &dns_cb_arg);
+#else
+			break;
+#endif
+		} else if (ret != -EAGAIN) {
+			return ret;
+		}
+		if (ctrlc())
+			return -EINTR;
+		ret = net_lwip_poll();
+		if (ret < 0)
+			return ret;
 	}
+	printf("No usable name server configured or advertised\n");
+	return -ETIMEDOUT;
+}
 
-	if (dns_cb_arg.done && !ip_addr_isany(&dns_cb_arg.host_ipaddr)) {
-		ipstr = ipaddr_ntoa(&dns_cb_arg.host_ipaddr);
-		if (var)
-			env_set(var, ipstr);
-		else
-			printf("%s\n", ipstr);
-		return CMD_RET_SUCCESS;
-	}
+int net_lwip_dns_lookup(struct net_lwip_ctx *net, const char *name,
+			ip_addr_t *addr, u8 type)
+{
+	struct dns_result result = {};
+	u8 dns_type = LWIP_DNS_ADDRTYPE_IPV4;
+	ulong start;
+	int ret;
 
-	return CMD_RET_FAILURE;
+#if CONFIG_IS_ENABLED(IPV6)
+	if (type == IPADDR_TYPE_V6 ||
+	    (type == IPADDR_TYPE_ANY && ip4_addr_isany_val(*netif_ip4_addr(net->netif))))
+		dns_type = LWIP_DNS_ADDRTYPE_IPV6;
+	else if (type == IPADDR_TYPE_ANY)
+		dns_type = LWIP_DNS_ADDRTYPE_IPV4_IPV6;
+#endif
+	ret = net_lwip_dns_init(net);
+	if (ret)
+		return ret;
+	ret = dns_gethostbyname_addrtype(name, addr, dns_cb, &result, dns_type);
+	if (ret == ERR_OK)
+		return 0;
+	if (ret != ERR_INPROGRESS)
+		return -EIO;
+
+	start = get_timer(0);
+	ret = -ETIMEDOUT;
+	while (get_timer(start) < DNS_TIMEOUT_MS) {
+		ret = net_lwip_poll();
+		if (ret < 0 || result.done)
+			break;
+		if (ctrlc()) {
+			ret = -EINTR;
+			break;
+		}
+		ret = -ETIMEDOUT;
+	}
+	dns_cancel(dns_cb, &result);
+	if (result.done) {
+		if (ip_addr_isany(&result.addr))
+			return -ENOENT;
+		*addr = result.addr;
+		return 0;
+	}
+	return ret;
 }
 
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct net_lwip_ctx net = {};
-	char *name;
-	char *var = NULL;
+	ip_addr_t addr;
+	u8 type = IPADDR_TYPE_ANY;
 	int ret;
 
-	if (argc == 1 || argc > 3)
+#if CONFIG_IS_ENABLED(IPV6)
+	if (argc > 1 && !strcmp(argv[argc - 1], "-ipv6")) {
+		type = IPADDR_TYPE_V6;
+		argc--;
+	}
+#endif
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
-
-	name = argv[1];
-
-	if (argc == 3)
-		var = argv[2];
-
 	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT))
 		return CMD_RET_FAILURE;
-
-	ret = dns_loop(&net, name, var);
-
+	ret = net_lwip_resolve(&net, argv[1], &addr, type);
+	if (!ret) {
+		if (argc == 3)
+			ret = env_set(argv[2], ipaddr_ntoa(&addr));
+		else
+			printf("%s\n", ipaddr_ntoa(&addr));
+	}
 	net_lwip_stop(&net);
-
-	return ret;
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 9205698d9ba..545efe09720 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -259,40 +259,6 @@ void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport, int sport,
 }
 #endif
 
-/*
- * Initialize DNS via env
- */
-int net_lwip_dns_init(void)
-{
-#if CONFIG_IS_ENABLED(DNS)
-	bool has_server = false;
-	ip_addr_t ns;
-	char *nsenv;
-
-	nsenv = env_get("dnsip");
-	if (nsenv && ipaddr_aton(nsenv, &ns)) {
-		dns_setserver(0, &ns);
-		has_server = true;
-	}
-
-	nsenv = env_get("dnsip2");
-	if (nsenv && ipaddr_aton(nsenv, &ns)) {
-		dns_setserver(1, &ns);
-		has_server = true;
-	}
-
-	if (!has_server) {
-		log_err("No valid name server (dnsip/dnsip2)\n");
-		return -EINVAL;
-	}
-
-	return 0;
-#else
-	log_err("DNS disabled\n");
-	return -EINVAL;
-#endif
-}
-
 /*
  * Initialize the network stack if needed and start the current device if valid
  */
@@ -384,6 +350,11 @@ static void net_lwip_remove_netif(struct netif *netif)
 #endif
 
 	netif_remove(netif);
+#if CONFIG_IS_ENABLED(DNS)
+	/* Do not carry router-advertised name servers to the next interface. */
+	for (unsigned int i = 0; i < DNS_MAX_SERVERS; i++)
+		dns_setserver(i, NULL);
+#endif
 #if CONFIG_IS_ENABLED(IPV6)
 	ip6_addr_set_allnodes_linklocal(&allnodes);
 	net_lwip_mld_filter(netif, &allnodes, NETIF_DEL_MAC_FILTER);
@@ -671,6 +642,15 @@ int net_lwip_ip6_prepare(struct net_lwip_ctx *ctx, ip_addr_t *dest)
 }
 #endif
 
+int net_lwip_prepare_addr(struct net_lwip_ctx *ctx, ip_addr_t *addr)
+{
+#if CONFIG_IS_ENABLED(IPV6)
+	if (IP_IS_V6(addr))
+		return net_lwip_ip6_prepare(ctx, addr);
+#endif
+	return 0;
+}
+
 static int net_lwip_configure(enum net_lwip_addr_mode addr_mode)
 {
 	ip4_addr_t ip, mask, gw;
@@ -1032,31 +1012,35 @@ int net_lwip_poll(void)
  */
 int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip)
 {
-#if defined(CONFIG_DNS)
-	char *var = "_dnsres";
-	char *argv[] = { "dns", name_or_ip, var, NULL };
-	int argc = ARRAY_SIZE(argv) - 1;
-#endif
-
-	if (ipaddr_aton(name_or_ip, ip))
-		return 0;
-
-#if defined(CONFIG_DNS)
-	if (do_dns(NULL, 0, argc, argv) != CMD_RET_SUCCESS)
-		return -1;
-
-	name_or_ip = env_get(var);
-	if (!name_or_ip)
-		return -1;
-
-	if (!ipaddr_aton(name_or_ip, ip))
-		return -1;
+	struct net_lwip_ctx ctx = {};
+	int ret;
 
-	env_set(var, NULL);
+	ret = net_lwip_start(&ctx, NET_LWIP_ADDR_ENV_STRICT);
+	if (!ret)
+		ret = net_lwip_resolve(&ctx, name_or_ip, ip, IPADDR_TYPE_ANY);
+	net_lwip_stop(&ctx);
+	return ret;
+}
 
-	return 0;
+int net_lwip_resolve(struct net_lwip_ctx *ctx, const char *name,
+		     ip_addr_t *addr, u8 type)
+{
+	if (ipaddr_aton(name, addr)) {
+		if (type != IPADDR_TYPE_ANY && IP_GET_TYPE(addr) != type)
+			return -EAFNOSUPPORT;
+#if CONFIG_IS_ENABLED(IPV6)
+		if (IP_IS_V6(addr))
+			return net_lwip_ip6_aton(name, ip_2_ip6(addr));
+#endif
+		return 0;
+	}
+	/* A malformed address is not a DNS hostname. */
+	if (strchr(name, ':'))
+		return -EINVAL;
+#if CONFIG_IS_ENABLED(DNS)
+	return net_lwip_dns_lookup(ctx, name, addr, type);
 #else
-	return -1;
+	return -ENOSYS;
 #endif
 }
 
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index ecbac188f70..be4a4264718 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -310,7 +310,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 
 	/* if URL with hostname init dns */
 	if (!ipaddr_aton(ctx->server_name, NULL)) {
-		ret = net_lwip_dns_init();
+		ret = net_lwip_dns_init(net);
 		if (ret)
 			return ret;
 	}

-- 
2.53.0

