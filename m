Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDDE606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vQmXMbsx;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gff1U4lj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 170A360E2C;
	Wed, 11 Nov 2026 20:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MzMNLYltM3E8; Wed, 11 Nov 2026 20:11:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3D7A60E06
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427897;
	b=nICzGmESLg5k6dgZYf8JnszOn8qclnW5Fpd6oRuKfT5gCpyeMcK0S74P2YE6r6hpOfVc
	 yG1XtK/KxMpC/uBZTITBXQXFw27ClWq9gcElLgrbsW8oTxSkIdEtigpYCuuVTdJZiEkmZ
	 j2xUNX3by6dHJaAudoakyYjFdz36BHf/+3hD3qdLy6HyK1Ezh66LhdTTeTQpXTQwJOdtC
	 ogtVzQgZ7cL4uS/gIYfL0LbOO4H/7EP0YrSWoAiJ5TZohwr3FMUULET8P9lj98DikT9QR
	 k/iv8pPVTarFDa2PnOvGqJ0jxbPxnDmrwkdf3VYJaiFYMXbl+frUUnG+J+ilL+A1X6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EAey+V6P45pULXrw17daI5EcS4G5mB606BE1uohZdMs=;
	b=dbsia7zuiDXQLIhol7VRHRvLvI675va3E9WBjdQrK+u0gjzxXX3oF+zy9rl0Dps6MO+P
	 VPV+bycTBzVqOGi3J8DRkJL1lr+7ZgwgnOm1h6OLWfA241Qa5Gn17l+GuAdIVGEHYj/gf
	 R5CGpeBZuiILcjgX+RgOddZvub/eI9KTF2rBh9BiwcnTzGsaCt17CSOaN7Kqy+qpJzyO7
	 dBvBOzqtmLJJAcdymay8FpbbY/08MrY3Lm++f3X4s33bHCmjHQ3QKS9PhMS80PzabIxsH
	 YSJ8CmUWpx//yInlXsFZ2DLhsZstMa+Pt2mt3P/1yyTnMTq4WkFW6KodHDkMkBr83+Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427897;
	bh=EAey+V6P45pULXrw17daI5EcS4G5mB606BE1uohZdMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vQmXMbsxajRl6x4gCpyZPqs2lQmr8bLuXs9ZlJtkPDcBS+xjBhYBQuRdt30FOtn12
	 E1WJ+2ngx/2lCs/POUJojw2AnEtsvYhDhq+6ikNSrzFDV+YB/g1QyusTZg/5uX0KbU
	 reGPkhZ9iYC0ZAuSsmhOjDIziDNJaPMlAO6pewqWVTot2svPwP17l4EnWsMBpqrYiI
	 8KNSG6H/RqiZ71hiqoJi2VxNCZCHRa/51Yu8t/uWMw2N6ddWKl6Usq3ce9+3X5mi0A
	 jNdzpKGnxM95G+tty6Y/UU+3Htdtd9KMI1DWNc+2aDeKuk/LGCLSxXnqmlDRDrNeZ9
	 VD89ZpgKVgGKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3D7A60E06;
	Wed, 11 Nov 2026 20:11:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB4602FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7A6F403BB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xaDVv93nI-Cw for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D6F6840336
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=gff1U4lj
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6F6840336
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:26 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-5641f26ce05so1456930b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427885; x=1795032685;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EAey+V6P45pULXrw17daI5EcS4G5mB606BE1uohZdMs=;
 b=gff1U4ljZ4maNG9rU12wtTxoK7rereD5Ez0qPnaWb1LCJVGkX3r6YVC30AyyeNFgCG
 5AJqx69uuD2N4DihnwJKS1avZAlKLTxr79eWeyonCraDwR0kKM+M0v/m1Ez76z4v/mGv
 cz0KIiDlRPR0Osn+9EpQwLYvJDJVQTVRFu4763PTKjBpdSeby1GCd2rDO6Fm85mEhslw
 SX+kQQdsHEE0fn517IbOoq67IiS242U/GdIKvadOi1IlWGBn4f+nTNHBC9T5ENevNhFc
 7U2Fy2w+xiK5fEqPMXMmIq6qOhOGB5w+VvdsHjzHNKN5zs9NkicilE3qBc2sK2TC2tPh
 qJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427885; x=1795032685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EAey+V6P45pULXrw17daI5EcS4G5mB606BE1uohZdMs=;
 b=KXsJUas5NORQZBdeW0W0kITswxM8F8hOPUiS620ZUdHku4nM0wZoFZ/0MVCFLvn3o1
 zht84pIw7P6oQOe2m9CWJy/FRD3a+JHaPiXJlEVSR1SE3R81OEqa2GsOC97beMXKHY+l
 SKf6Cbc54ReIxqioM2mStsC7p+8E1JlYEyOhZ6Fy/TUPnIBDlGl8N+ADordA6OJcAng3
 TL9rIk5ChHixQRJt3umqtmCxbsvrzq+ApucnYgrc2bOYnooSMa5WDBiy142c33uKudxo
 dab1X+0M8mGR+vWFSwAf3TEh3so57CbUVKiRId2ZpJ/qSu00WsytwxKGg5MJLQ1i1XqP
 r+WA==
X-Forwarded-Encrypted: i=1;
 AL+hErHKWUon0OmFtENVGxBkvyMcvF8ioJUvu4J+USyag5rXHUla5i80uovkqulXvKTuBYGu/umDv7Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/JqQQfo7Y2VN/PC0i7Xj5YUQqwgIkZVhBwYlyZzL4OuBoAtlXB
 TE9r1Db2MU3P8C4sh95Q791xJz+ASZu+66DTSP9V01z2XN1lkfYlEuhy
X-Gm-Gg: AYBFou39IJaUcrMa0TYkqu5Q0Xwmuz/MJiEYejMi4/dG7BGXuZF231G6MSNLOASlPRo
 6TOw52y8rbLHzHvl0BIloLjMAPGcPdv2G5+bWQkKaDrkeltqErdin4EVRNEpzGA/6+1rpbV8YTT
 tC9bA8vizRpZ5QOhV28scPP48iLS2dKd37VBWR0Ng3PJDvjxM+M+TiY1N6nNoMHDDzs/PcdfKNm
 krF9XwD6mcIL3aQqTh76dYrMlGjnIgVr200yrdJjxxfxPoRypMCjz9GTjU2t5iH1EnFGv+F5A8w
 lPdANTAyKOwVNzMz9gaeRzbLo4wi/Kyex9pU1c+LvLHtou1Wl8QVerScorgHEVbMWUvTRiWtoX/
 kK3nzUaUE/fBeRH5+OQioM8dNwkSx9te8u1R5UCMz7xXccSVmy0FxhL2dZYblIXKW+ZjJAfZlGA
 olCajBVWjKhHKjjyO7oGGkF/4dhtQhxZ8m8cLA5YKj18c7Sagl2VhXj6t2RxRL7vdElex3Xybdc
 vWfG6HHqcGl9iytcpjSkvACvzYBE/IBhMZn+mzFn+D0JpOecIwWRWjQGc1nkw0DMwffonK0n+bL
 lWFFA3ZL9056Ep0bY6V3GlXjbG/n3OI/G6sIO4dx7j2E5ZKGi6GPMVLQ6QiU73/ONB5NHGIKB70
 BWlQOz4dnvzlY9qLXu1B9y1Yl4vDJ5Jp5pRjzNht6xB60BF8HiYuG9JRu9PiF64M6rUOwowVHoR
 KF7IHNigB3ghkfcpXw44o1HBldRsEupDIRsObU5Vv4FoIClyrC1ehGPEB2Bh8BpH71WgIQFSS4
X-Received: by 2002:a05:6808:508d:b0:4d3:6be7:c5e9 with SMTP id
 5614622812f47-56b958805dcmr3025653b6e.24.1794427884608; 
 Wed, 11 Nov 2026 12:11:24 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:13 -0700
Subject: [PATCH 06/19] net: lwip: configure IPv6 on the shared network
 interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-6-eb0ee8f8da1a@gmail.com>
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

Enable the bundled IPv6 stack through CONFIG_IPV6. Configure it lazily
when an IPv6 client starts, preserving the IPv4 configuration used by
other clients on the same interface.

Generate a link-local address from the Ethernet address, or use ip6addr
for a static address with an optional prefix length. Validate complete
IPv6 groups and compression, and bound decimal fields before arithmetic
can overflow. Install multicast filters and wait for duplicate address
detection before sending traffic. Support an explicit gatewayip6 and
optional router discovery with SLAAC.
Use the configured static prefix when selecting an on-link next hop.
Select a usable source before reporting DAD conflicts, so a duplicate
global address does not disable link-local traffic or another valid
address.

Retain configuration and learned neighbors while the interface is shared.
Age finite address, prefix and router lifetimes by elapsed time before
checking readiness or polling. Cyclic timers skip missed callbacks, so
one decrement per callback would retain expired configuration after an
idle prompt or another command stops polling. Separate lifetime aging
from DAD and neighbor probes to avoid replaying those protocol timers.
Preserve static and infinite lifetimes. Reject environment changes while
the IPv6 configuration is in use, and discard it on final release.
Provide a nonblocking readiness check as well as interruptible address
and route preparation bounded to 15 seconds.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                          |  14 +-
 include/net-lwip.h                   |  10 ++
 lib/lwip/lwip/src/core/ipv6/ip6.c    |  14 +-
 lib/lwip/lwip/src/core/ipv6/nd6.c    | 214 +++++++++++-----------
 lib/lwip/lwip/src/include/lwip/nd6.h |   1 +
 lib/lwip/u-boot/lwip-hooks.h         |  28 +++
 lib/lwip/u-boot/lwipopts.h           |  10 +-
 net/Kconfig                          |   4 +-
 net/lwip/net-lwip.c                  | 334 +++++++++++++++++++++++++++++++++++
 test/dm/eth.c                        |   4 +-
 10 files changed, 514 insertions(+), 119 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c64ca1807ef..b48c2bbdd02 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2206,13 +2206,6 @@ config CMD_NCSI
 	  Normally this happens automatically before other network
 	  operations.
 
-config IPV6_ROUTER_DISCOVERY
-	bool "Do IPv6 router discovery"
-	depends on IPV6
-	help
-	  Will automatically perform router solicitation on first IPv6
-	  network operation
-
 config CMD_WOL
 	bool "wol"
 	help
@@ -2220,6 +2213,13 @@ config CMD_WOL
 
 endif  # if NET_LEGACY
 
+config IPV6_ROUTER_DISCOVERY
+	bool "Do IPv6 router discovery"
+	depends on IPV6
+	help
+	  Will automatically perform router solicitation on first IPv6
+	  network operation
+
 config CMD_TFTPPUT
 	bool "tftp put"
 	depends on CMD_TFTPBOOT
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 8fd1c094dff..3a5a0219f2b 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -73,6 +73,8 @@ static inline int eth_is_on_demand_init(void)
 
 int eth_init_state_only(void); /* Set active state */
 
+int net_lwip_parse_decimal(const char *text, size_t len, unsigned int max,
+			   unsigned int *value);
 int net_lwip_dns_init(void);
 int net_lwip_start(struct net_lwip_ctx *ctx,
 		   enum net_lwip_addr_mode addr_mode);
@@ -81,6 +83,14 @@ int net_lwip_restart(struct net_lwip_ctx *ctx);
 int net_lwip_refresh(struct net_lwip_ctx *ctx);
 int net_lwip_poll(void);
 int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
+#if CONFIG_IS_ENABLED(IPV6)
+void net_lwip_ip6_update_lifetimes(void);
+int net_lwip_ip6_aton(const char *text, ip6_addr_t *addr);
+int net_lwip_ip6_init(struct net_lwip_ctx *ctx);
+int net_lwip_ip6_ready(struct net_lwip_ctx *ctx, ip_addr_t *dest);
+int net_lwip_ip6_start(struct net_lwip_ctx *ctx);
+int net_lwip_ip6_prepare(struct net_lwip_ctx *ctx, ip_addr_t *dest);
+#endif
 int net_lwip_tftp_download(struct net_lwip_ctx *net, int argc, char *const argv[]);
 
 /**
diff --git a/lib/lwip/lwip/src/core/ipv6/ip6.c b/lib/lwip/lwip/src/core/ipv6/ip6.c
index 2c25f8addde..54b787c4471 100644
--- a/lib/lwip/lwip/src/core/ipv6/ip6.c
+++ b/lib/lwip/lwip/src/core/ipv6/ip6.c
@@ -191,17 +191,21 @@ ip6_route(const ip6_addr_t *src, const ip6_addr_t *dest)
    * with RFC 5942, dynamically configured addresses do not have an implied
    * local subnet, and thus should be considered /128 assignments. However, as
    * such, the destination address may still match a local address, and so we
-   * still need to check for exact matches here. By (lwIP) policy, statically
-   * configured addresses do always have an implied local /64 subnet. */
+   * still need to check for exact matches here. Static addresses default to
+   * an implied /64 subnet unless the static-prefix hook overrides it. */
   NETIF_FOREACH(netif) {
     if (!netif_is_up(netif) || !netif_is_link_up(netif)) {
       continue;
     }
     for (i = 0; i < LWIP_IPV6_NUM_ADDRESSES; i++) {
       if (ip6_addr_isvalid(netif_ip6_addr_state(netif, i)) &&
-          ip6_addr_net_eq(dest, netif_ip6_addr(netif, i)) &&
-          (netif_ip6_addr_isstatic(netif, i) ||
-          ip6_addr_nethost_eq(dest, netif_ip6_addr(netif, i)))) {
+          ((netif_ip6_addr_isstatic(netif, i) &&
+#ifdef LWIP_HOOK_IP6_STATIC_PREFIX_MATCH
+            LWIP_HOOK_IP6_STATIC_PREFIX_MATCH(netif, i, dest)) ||
+#else
+            ip6_addr_net_eq(dest, netif_ip6_addr(netif, i))) ||
+#endif
+           ip6_addr_eq(dest, netif_ip6_addr(netif, i)))) {
         return netif;
       }
     }
diff --git a/lib/lwip/lwip/src/core/ipv6/nd6.c b/lib/lwip/lwip/src/core/ipv6/nd6.c
index f7b5f56361d..52cb997be3c 100644
--- a/lib/lwip/lwip/src/core/ipv6/nd6.c
+++ b/lib/lwip/lwip/src/core/ipv6/nd6.c
@@ -305,6 +305,10 @@ nd6_input(struct pbuf *p, struct netif *inp)
   s8_t i;
   s16_t dest_idx;
 
+#ifdef LWIP_HOOK_ND6_UPDATE_LIFETIMES
+  LWIP_HOOK_ND6_UPDATE_LIFETIMES();
+#endif
+
   ND6_STATS_INC(nd6.recv);
 
   msg_type = *((u8_t *)p->payload);
@@ -959,91 +963,24 @@ lenerr_drop_free_return:
   pbuf_free(p);
 }
 
-
-/**
- * Periodic timer for Neighbor discovery functions:
- *
- * - Update neighbor reachability states
- * - Update destination cache entries age
- * - Update invalidation timers of default routers and on-link prefixes
- * - Update lifetimes of our addresses
- * - Perform duplicate address detection (DAD) for our addresses
- * - Send router solicitations
- */
+/** Age finite configuration lifetimes by elapsed seconds, without sending probes. */
 void
-nd6_tmr(void)
+nd6_age_lifetimes(u32_t elapsed)
 {
   s8_t i;
+#if LWIP_IPV6_ADDRESS_LIFETIMES
   struct netif *netif;
+#endif
 
-  /* Process neighbor entries. */
-  for (i = 0; i < LWIP_ND6_NUM_NEIGHBORS; i++) {
-    switch (neighbor_cache[i].state) {
-    case ND6_INCOMPLETE:
-      if ((neighbor_cache[i].counter.probes_sent >= LWIP_ND6_MAX_MULTICAST_SOLICIT) &&
-          (!neighbor_cache[i].isrouter)) {
-        /* Retries exceeded. */
-        nd6_free_neighbor_cache_entry(i);
-      } else {
-        /* Send a NS for this entry. */
-        neighbor_cache[i].counter.probes_sent++;
-        nd6_send_neighbor_cache_probe(&neighbor_cache[i], ND6_SEND_FLAG_MULTICAST_DEST);
-      }
-      break;
-    case ND6_REACHABLE:
-      /* Send queued packets, if any are left. Should have been sent already. */
-      if (neighbor_cache[i].q != NULL) {
-        nd6_send_q(i);
-      }
-      if (neighbor_cache[i].counter.reachable_time <= ND6_TMR_INTERVAL) {
-        /* Change to stale state. */
-        neighbor_cache[i].state = ND6_STALE;
-        neighbor_cache[i].counter.stale_time = 0;
-      } else {
-        neighbor_cache[i].counter.reachable_time -= ND6_TMR_INTERVAL;
-      }
-      break;
-    case ND6_STALE:
-      neighbor_cache[i].counter.stale_time++;
-      break;
-    case ND6_DELAY:
-      if (neighbor_cache[i].counter.delay_time <= 1) {
-        /* Change to PROBE state. */
-        neighbor_cache[i].state = ND6_PROBE;
-        neighbor_cache[i].counter.probes_sent = 0;
-      } else {
-        neighbor_cache[i].counter.delay_time--;
-      }
-      break;
-    case ND6_PROBE:
-      if ((neighbor_cache[i].counter.probes_sent >= LWIP_ND6_MAX_MULTICAST_SOLICIT) &&
-          (!neighbor_cache[i].isrouter)) {
-        /* Retries exceeded. */
-        nd6_free_neighbor_cache_entry(i);
-      } else {
-        /* Send a NS for this entry. */
-        neighbor_cache[i].counter.probes_sent++;
-        nd6_send_neighbor_cache_probe(&neighbor_cache[i], 0);
-      }
-      break;
-    case ND6_NO_ENTRY:
-    default:
-      /* Do nothing. */
-      break;
-    }
-  }
-
-  /* Process destination entries. */
-  for (i = 0; i < LWIP_ND6_NUM_DESTINATIONS; i++) {
-    destination_cache[i].age++;
+  if (elapsed == 0) {
+    return;
   }
-
   /* Process router entries. */
   for (i = 0; i < LWIP_ND6_NUM_ROUTERS; i++) {
     if (default_router_list[i].neighbor_entry != NULL) {
       /* Active entry. */
-      if (default_router_list[i].invalidation_timer <= ND6_TMR_INTERVAL / 1000) {
-        /* No more than 1 second remaining. Clear this entry. Also clear any of
+      if (default_router_list[i].invalidation_timer <= elapsed) {
+        /* Clear the expired entry. Also clear any of
          * its destination cache entries, as per RFC 4861 Sec. 5.3 and 6.3.5. */
         s8_t j;
         for (j = 0; j < LWIP_ND6_NUM_DESTINATIONS; j++) {
@@ -1057,7 +994,7 @@ nd6_tmr(void)
         default_router_list[i].invalidation_timer = 0;
         default_router_list[i].flags = 0;
       } else {
-        default_router_list[i].invalidation_timer -= ND6_TMR_INTERVAL / 1000;
+        default_router_list[i].invalidation_timer -= elapsed;
       }
     }
   }
@@ -1065,23 +1002,24 @@ nd6_tmr(void)
   /* Process prefix entries. */
   for (i = 0; i < LWIP_ND6_NUM_PREFIXES; i++) {
     if (prefix_list[i].netif != NULL) {
-      if (prefix_list[i].invalidation_timer <= ND6_TMR_INTERVAL / 1000) {
+      if (prefix_list[i].invalidation_timer == 0xffffffffUL) {
+        continue;
+      }
+      if (prefix_list[i].invalidation_timer <= elapsed) {
         /* Entry timed out, remove it */
         prefix_list[i].invalidation_timer = 0;
         prefix_list[i].netif = NULL;
       } else {
-        prefix_list[i].invalidation_timer -= ND6_TMR_INTERVAL / 1000;
+        prefix_list[i].invalidation_timer -= elapsed;
       }
     }
   }
 
-  /* Process our own addresses, updating address lifetimes and/or DAD state. */
+#if LWIP_IPV6_ADDRESS_LIFETIMES
+  /* Process our own addresses, including tentative and duplicate addresses. */
   NETIF_FOREACH(netif) {
     for (i = 0; i < LWIP_IPV6_NUM_ADDRESSES; ++i) {
-      u8_t addr_state;
-#if LWIP_IPV6_ADDRESS_LIFETIMES
-      /* Step 1: update address lifetimes (valid and preferred). */
-      addr_state = netif_ip6_addr_state(netif, i);
+      u8_t addr_state = netif_ip6_addr_state(netif, i);
       /* RFC 4862 is not entirely clear as to whether address lifetimes affect
        * tentative addresses, and is even less clear as to what should happen
        * with duplicate addresses. We choose to track and update lifetimes for
@@ -1098,35 +1036,115 @@ nd6_tmr(void)
       if (!ip6_addr_isinvalid(addr_state) &&
           !netif_ip6_addr_isstatic(netif, i)) {
         u32_t life = netif_ip6_addr_valid_life(netif, i);
-        if (life <= ND6_TMR_INTERVAL / 1000) {
+        if (!ip6_addr_life_isinfinite(life) && life <= elapsed) {
           /* The address has expired. */
           netif_ip6_addr_set_valid_life(netif, i, 0);
           netif_ip6_addr_set_pref_life(netif, i, 0);
           netif_ip6_addr_set_state(netif, i, IP6_ADDR_INVALID);
         } else {
           if (!ip6_addr_life_isinfinite(life)) {
-            life -= ND6_TMR_INTERVAL / 1000;
+            life -= elapsed;
             LWIP_ASSERT("bad valid lifetime", life != IP6_ADDR_LIFE_STATIC);
             netif_ip6_addr_set_valid_life(netif, i, life);
           }
           /* The address is still here. Update the preferred lifetime too. */
           life = netif_ip6_addr_pref_life(netif, i);
-          if (life <= ND6_TMR_INTERVAL / 1000) {
+          if (!ip6_addr_life_isinfinite(life) && life <= elapsed) {
             /* This case must also trigger if 'life' was already zero, so as to
              * deal correctly with advertised preferred-lifetime reductions. */
             netif_ip6_addr_set_pref_life(netif, i, 0);
             if (addr_state == IP6_ADDR_PREFERRED)
               netif_ip6_addr_set_state(netif, i, IP6_ADDR_DEPRECATED);
           } else if (!ip6_addr_life_isinfinite(life)) {
-            life -= ND6_TMR_INTERVAL / 1000;
+            life -= elapsed;
             netif_ip6_addr_set_pref_life(netif, i, life);
           }
         }
       }
-      /* The address state may now have changed, so reobtain it next. */
+    }
+  }
 #endif /* LWIP_IPV6_ADDRESS_LIFETIMES */
-      /* Step 2: update DAD state. */
-      addr_state = netif_ip6_addr_state(netif, i);
+}
+
+/** Periodic neighbor probes, DAD and router solicitations. */
+void
+nd6_tmr(void)
+{
+  s8_t i;
+  struct netif *netif;
+
+#ifdef LWIP_HOOK_ND6_UPDATE_LIFETIMES
+  LWIP_HOOK_ND6_UPDATE_LIFETIMES();
+#else
+  nd6_age_lifetimes(ND6_TMR_INTERVAL / 1000);
+#endif
+
+  /* Process neighbor entries. */
+  for (i = 0; i < LWIP_ND6_NUM_NEIGHBORS; i++) {
+    switch (neighbor_cache[i].state) {
+    case ND6_INCOMPLETE:
+      if ((neighbor_cache[i].counter.probes_sent >= LWIP_ND6_MAX_MULTICAST_SOLICIT) &&
+          (!neighbor_cache[i].isrouter)) {
+        /* Retries exceeded. */
+        nd6_free_neighbor_cache_entry(i);
+      } else {
+        /* Send a NS for this entry. */
+        neighbor_cache[i].counter.probes_sent++;
+        nd6_send_neighbor_cache_probe(&neighbor_cache[i], ND6_SEND_FLAG_MULTICAST_DEST);
+      }
+      break;
+    case ND6_REACHABLE:
+      /* Send queued packets, if any are left. Should have been sent already. */
+      if (neighbor_cache[i].q != NULL) {
+        nd6_send_q(i);
+      }
+      if (neighbor_cache[i].counter.reachable_time <= ND6_TMR_INTERVAL) {
+        /* Change to stale state. */
+        neighbor_cache[i].state = ND6_STALE;
+        neighbor_cache[i].counter.stale_time = 0;
+      } else {
+        neighbor_cache[i].counter.reachable_time -= ND6_TMR_INTERVAL;
+      }
+      break;
+    case ND6_STALE:
+      neighbor_cache[i].counter.stale_time++;
+      break;
+    case ND6_DELAY:
+      if (neighbor_cache[i].counter.delay_time <= 1) {
+        /* Change to PROBE state. */
+        neighbor_cache[i].state = ND6_PROBE;
+        neighbor_cache[i].counter.probes_sent = 0;
+      } else {
+        neighbor_cache[i].counter.delay_time--;
+      }
+      break;
+    case ND6_PROBE:
+      if ((neighbor_cache[i].counter.probes_sent >= LWIP_ND6_MAX_MULTICAST_SOLICIT) &&
+          (!neighbor_cache[i].isrouter)) {
+        /* Retries exceeded. */
+        nd6_free_neighbor_cache_entry(i);
+      } else {
+        /* Send a NS for this entry. */
+        neighbor_cache[i].counter.probes_sent++;
+        nd6_send_neighbor_cache_probe(&neighbor_cache[i], 0);
+      }
+      break;
+    case ND6_NO_ENTRY:
+    default:
+      /* Do nothing. */
+      break;
+    }
+  }
+
+  /* Process destination entries. */
+  for (i = 0; i < LWIP_ND6_NUM_DESTINATIONS; i++) {
+    destination_cache[i].age++;
+  }
+
+  NETIF_FOREACH(netif) {
+    for (i = 0; i < LWIP_IPV6_NUM_ADDRESSES; ++i) {
+      u8_t addr_state = netif_ip6_addr_state(netif, i);
+
       if (ip6_addr_istentative(addr_state)) {
         if ((addr_state & IP6_ADDR_TENTATIVE_COUNT_MASK) >= LWIP_IPV6_DUP_DETECT_ATTEMPTS) {
           /* No NA received in response. Mark address as valid. For dynamic
@@ -1203,20 +1221,14 @@ nd6_send_ns(struct netif *netif, const ip6_addr_t *target_addr, u8_t flags)
   LWIP_ASSERT("target address is required", target_addr != NULL);
 
   if (!(flags & ND6_SEND_FLAG_ANY_SRC)) {
-    int i;
-    for (i = 0; i < LWIP_IPV6_NUM_ADDRESSES; i++) {
-      if (ip6_addr_isvalid(netif_ip6_addr_state(netif, i)) &&
-            ip6_addr_net_eq(target_addr, netif_ip6_addr(netif, i))) {
-        src_addr = netif_ip6_addr(netif, i);
-        break;
-      }
-    }
+    const ip_addr_t *selected = ip6_select_source_address(netif, target_addr);
 
-    if (i == LWIP_IPV6_NUM_ADDRESSES) {
+    if (selected == NULL) {
       LWIP_DEBUGF(IP6_DEBUG | LWIP_DBG_LEVEL_WARNING, ("ICMPv6 NS: no available src address\n"));
       ND6_STATS_INC(nd6.err);
       return;
     }
+    src_addr = ip_2_ip6(selected);
 
     /* calculate option length (in 8-byte-blocks) */
     lladdr_opt_len = ((netif->hwaddr_len + 2) + 7) >> 3;
@@ -1673,7 +1685,11 @@ nd6_is_prefix_in_netif(const ip6_addr_t *ip6addr, struct netif *netif)
   for (i = 0; i < LWIP_IPV6_NUM_ADDRESSES; i++) {
     if (ip6_addr_isvalid(netif_ip6_addr_state(netif, i)) &&
         netif_ip6_addr_isstatic(netif, i) &&
+#ifdef LWIP_HOOK_IP6_STATIC_PREFIX_MATCH
+        LWIP_HOOK_IP6_STATIC_PREFIX_MATCH(netif, i, ip6addr)) {
+#else
         ip6_addr_net_eq(ip6addr, netif_ip6_addr(netif, i))) {
+#endif
       return 1;
     }
   }
diff --git a/lib/lwip/lwip/src/include/lwip/nd6.h b/lib/lwip/lwip/src/include/lwip/nd6.h
index c30e624f02a..f93fff5c157 100644
--- a/lib/lwip/lwip/src/include/lwip/nd6.h
+++ b/lib/lwip/lwip/src/include/lwip/nd6.h
@@ -67,6 +67,7 @@ struct pbuf;
 struct netif;
 
 void nd6_tmr(void);
+void nd6_age_lifetimes(u32_t elapsed);
 void nd6_input(struct pbuf *p, struct netif *inp);
 void nd6_clear_destination_cache(void);
 struct netif *nd6_find_route(const ip6_addr_t *ip6addr);
diff --git a/lib/lwip/u-boot/lwip-hooks.h b/lib/lwip/u-boot/lwip-hooks.h
new file mode 100644
index 00000000000..0d955277908
--- /dev/null
+++ b/lib/lwip/u-boot/lwip-hooks.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#ifndef __UBOOT_LWIP_HOOKS_H
+#define __UBOOT_LWIP_HOOKS_H
+
+#ifdef CONFIG_CMD_DHCP
+#include "lwip-dhcp.h"
+#endif
+
+#if LWIP_IPV6
+#include <lwip/ip6_addr.h>
+
+struct netif;
+
+void net_lwip_ip6_update_lifetimes(void);
+#define LWIP_HOOK_ND6_UPDATE_LIFETIMES net_lwip_ip6_update_lifetimes
+
+int net_lwip_ip6_static_prefix(struct netif *netif, unsigned int index,
+			       const ip6_addr_t *dest);
+#define LWIP_HOOK_IP6_STATIC_PREFIX_MATCH net_lwip_ip6_static_prefix
+
+const ip6_addr_t *net_lwip_ip6_gateway(struct netif *netif,
+				       const ip6_addr_t *dest);
+#define LWIP_HOOK_ND6_GET_GW net_lwip_ip6_gateway
+#endif
+
+#endif /* __UBOOT_LWIP_HOOKS_H */
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 91a18a049da..565fea4f4fe 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -60,7 +60,12 @@
 #define NO_SYS                          1
 
 #define LWIP_IPV4			1
-#define LWIP_IPV6			0
+#define LWIP_IPV6			IS_ENABLED(CONFIG_IPV6)
+#define LWIP_IPV6_SEND_ROUTER_SOLICIT	IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
+#define LWIP_IPV6_AUTOCONFIG		IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
+/* A 64-bit reassembly pointer does not fit in the fragment header. */
+#define IPV6_FRAG_COPYHEADER		IS_ENABLED(CONFIG_64BIT)
+#define LWIP_HOOK_FILENAME		"lwip-hooks.h"
 
 #define MEM_ALIGNMENT                   8
 
@@ -136,9 +141,6 @@
 #endif
 
 #if defined(CONFIG_CMD_BOOTP) || defined(CONFIG_CMD_DHCP)
-#ifdef CONFIG_CMD_DHCP
-#define LWIP_HOOK_FILENAME "lwip-dhcp.h"
-#endif
 /* Core/PXE options plus two maximum-length hostname/vendor-class options. */
 #define DHCP_OPTIONS_LEN		640
 /* Stage NTP after concatenating fragments, not in the core option parser. */
diff --git a/net/Kconfig b/net/Kconfig
index 56ff8542321..6d6672b9662 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -245,6 +245,8 @@ config PROT_TCP_SACK
 	  This option should be turn on if you want to achieve the fastest
 	  file transfer possible.
 
+endif   # if NET_LEGACY
+
 config IPV6
 	bool "IPv6 support"
 	help
@@ -255,8 +257,6 @@ config IPV6
 	  ip6addr, serverip6. If a u-boot command is capable to parse an IPv6
 	  address and find it, it will force using IPv6 in the network stack.
 
-endif   # if NET_LEGACY
-
 source "net/lwip/Kconfig"
 
 source "net/9p/Kconfig"
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 60fcf9b3225..9205698d9ba 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -10,16 +10,21 @@
 #include <dm/uclass.h>
 #include <hexdump.h>
 #include <linux/compiler_attributes.h>
+#include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <lwip/ip4_addr.h>
 #include <lwip/dns.h>
 #include <lwip/err.h>
 #include <lwip/netif.h>
+#include <lwip/nd6.h>
 #include <lwip/pbuf.h>
 #include <lwip/etharp.h>
+#include <lwip/ethip6.h>
+#include <lwip/ip6.h>
 #include <lwip/init.h>
 #include <lwip/prot/etharp.h>
 #include <lwip/timeouts.h>
+#include <lwip-hooks.h>
 #include <net.h>
 #include <net/pcap.h>
 #include <timer.h>
@@ -42,6 +47,13 @@ static struct {
 	unsigned int strict_env_users;
 	unsigned int no_addr_users;
 	bool polling;
+#if CONFIG_IS_ENABLED(IPV6)
+	bool ip6_configured;
+	u64 ip6_lifetime_time;
+	ip6_addr_t ip6_addr;
+	ip6_addr_t ip6_gateway;
+	u8 ip6_prefix_len;
+#endif
 } net_lwip_runtime;
 static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN]
 	__aligned(PKTALIGN);
@@ -102,12 +114,40 @@ static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
 	return ERR_OK;
 }
 
+#if CONFIG_IS_ENABLED(IPV6)
+static err_t net_lwip_mld_filter(struct netif *netif, const ip6_addr_t *group,
+				 enum netif_mac_filter_action action)
+{
+	struct udevice *dev = netif->state;
+	u8 mac[ARP_HLEN] = { 0x33, 0x33 };
+
+	if (!eth_get_ops(dev)->mcast)
+		return ERR_OK;
+
+	memcpy(mac + 2, &group->addr[3], 4);
+	return eth_get_ops(dev)->mcast(dev, mac, action == NETIF_ADD_MAC_FILTER) ?
+		ERR_IF : ERR_OK;
+}
+#endif
+
 static err_t net_lwip_if_init(struct netif *netif)
 {
+#if CONFIG_IS_ENABLED(IPV6)
+	ip6_addr_t allnodes;
+#endif
+
 	netif->output = etharp_output;
 	netif->linkoutput = net_lwip_tx;
 	netif->mtu = 1500;
 	netif->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;
+#if CONFIG_IS_ENABLED(IPV6)
+	netif->output_ip6 = ethip6_output;
+	netif->flags |= NETIF_FLAG_MLD6;
+	netif_set_mld_mac_filter(netif, net_lwip_mld_filter);
+	/* lwIP assumes the all-nodes group is received without an MLD join. */
+	ip6_addr_set_allnodes_linklocal(&allnodes);
+	return net_lwip_mld_filter(netif, &allnodes, NETIF_ADD_MAC_FILTER);
+#endif
 
 	return ERR_OK;
 }
@@ -339,10 +379,298 @@ static struct netif *new_netif(struct udevice *udev, bool with_ip)
 
 static void net_lwip_remove_netif(struct netif *netif)
 {
+#if CONFIG_IS_ENABLED(IPV6)
+	ip6_addr_t allnodes;
+#endif
+
 	netif_remove(netif);
+#if CONFIG_IS_ENABLED(IPV6)
+	ip6_addr_set_allnodes_linklocal(&allnodes);
+	net_lwip_mld_filter(netif, &allnodes, NETIF_DEL_MAC_FILTER);
+	net_lwip_runtime.ip6_configured = false;
+#endif
 	free(netif);
 }
 
+/* Parse a complete decimal field without overflowing before the range check. */
+int net_lwip_parse_decimal(const char *text, size_t len, unsigned int max,
+			   unsigned int *value)
+{
+	unsigned int number = 0;
+
+	if (!len)
+		return -EINVAL;
+	for (size_t i = 0; i < len; i++) {
+		unsigned int digit = (unsigned char)text[i] - '0';
+
+		if (digit > 9 || number > max / 10 ||
+		    (number == max / 10 && digit > max % 10))
+			return -EINVAL;
+		number = number * 10 + digit;
+	}
+	*value = number;
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(IPV6)
+/* Age learned configuration without replaying DAD or neighbor probes. */
+void net_lwip_ip6_update_lifetimes(void)
+{
+	u64 elapsed;
+
+	if (!net_lwip_runtime.netif)
+		return;
+	elapsed = get_timer_us(net_lwip_runtime.ip6_lifetime_time) / 1000000;
+	if (!elapsed)
+		return;
+	/* Keep fractional seconds and advance the clock before expiry callbacks. */
+	net_lwip_runtime.ip6_lifetime_time += elapsed * 1000000;
+	nd6_age_lifetimes(min_t(u64, elapsed, U32_MAX));
+}
+
+int net_lwip_ip6_aton(const char *text, ip6_addr_t *addr)
+{
+	const char *p = text;
+	unsigned int groups = 0;
+	bool compressed = false;
+
+	/* Validate groups and compression before using lwIP's permissive parser. */
+	if (*p == ':') {
+		if (*++p != ':')
+			return -EINVAL;
+		compressed = true;
+		p++;
+	}
+	while (*p) {
+		const char *start = p;
+
+		while (isxdigit(*p))
+			p++;
+		if (p == start || p - start > 4 || ++groups > 8)
+			return -EINVAL;
+		if (!*p)
+			break;
+		if (*p++ != ':')
+			return -EINVAL;
+		if (*p == ':') {
+			if (compressed)
+				return -EINVAL;
+			compressed = true;
+			p++;
+		} else if (!*p) {
+			return -EINVAL;
+		}
+	}
+	if (compressed ? groups >= 8 : groups != 8)
+		return -EINVAL;
+	if (!ip6addr_aton(text, addr) || ip6_addr_isany(addr) ||
+	    ip6_addr_ismulticast(addr) || ip6_addr_isloopback(addr) ||
+	    ip6_addr_isipv4mappedipv6(addr) || ip6_addr_isipv4compat(addr))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int net_lwip_ip6_env(const char *name, ip6_addr_t *addr, unsigned int *prefix)
+{
+	const char *value = env_get(name);
+	char text[IP6ADDR_STRLEN_MAX];
+	char *slash;
+	unsigned int bits;
+
+	ip6_addr_set_zero(addr);
+	if (prefix)
+		*prefix = 64;
+	if (!value || !*value)
+		return 0;
+	if (strlcpy(text, value, sizeof(text)) >= sizeof(text))
+		goto invalid;
+	slash = strchr(text, '/');
+	if (slash) {
+		if (!prefix || net_lwip_parse_decimal(slash + 1, strlen(slash + 1),
+						      128, &bits))
+			goto invalid;
+		*prefix = bits;
+		*slash = '\0';
+	}
+	if (net_lwip_ip6_aton(text, addr))
+		goto invalid;
+
+	return 0;
+
+invalid:
+	printf("Invalid %s: %s\n", name, value);
+	return -EINVAL;
+}
+
+int net_lwip_ip6_static_prefix(struct netif *netif, unsigned int index,
+			       const ip6_addr_t *dest)
+{
+	const ip6_addr_t *addr = netif_ip6_addr(netif, index);
+	const u8 *a = (const u8 *)addr->addr, *b = (const u8 *)dest->addr;
+	unsigned int bits = 64, bytes;
+
+	if (netif == net_lwip_runtime.netif && net_lwip_runtime.ip6_configured &&
+	    ip6_addr_zoneless_eq(addr, &net_lwip_runtime.ip6_addr))
+		bits = net_lwip_runtime.ip6_prefix_len;
+	bytes = bits / 8;
+	if (memcmp(a, b, bytes))
+		return 0;
+	return !(bits % 8) || !((a[bytes] ^ b[bytes]) >> (8 - bits % 8));
+}
+
+const ip6_addr_t *net_lwip_ip6_gateway(struct netif *netif,
+				       const ip6_addr_t *dest)
+{
+	if (netif != net_lwip_runtime.netif || !net_lwip_runtime.ip6_configured ||
+	    ip6_addr_isany(&net_lwip_runtime.ip6_gateway))
+		return NULL;
+
+	return &net_lwip_runtime.ip6_gateway;
+}
+
+/* Configure IPv6 on demand, without changing a concurrent client's IPv4. */
+int net_lwip_ip6_init(struct net_lwip_ctx *ctx)
+{
+	ip6_addr_t addr, gateway;
+	struct netif *netif;
+	unsigned int prefix;
+	int ret;
+
+	if (!ctx || !ctx->netif || ctx->netif != net_lwip_runtime.netif)
+		return -EINVAL;
+	net_lwip_ip6_update_lifetimes();
+	netif = ctx->netif;
+	ret = net_lwip_ip6_env("ip6addr", &addr, &prefix);
+	if (ret)
+		return ret;
+	ret = net_lwip_ip6_env("gatewayip6", &gateway, NULL);
+	if (ret)
+		return ret;
+	if (net_lwip_runtime.ip6_configured) {
+		if (prefix != net_lwip_runtime.ip6_prefix_len ||
+		    !ip6_addr_zoneless_eq(&addr, &net_lwip_runtime.ip6_addr) ||
+		    !ip6_addr_zoneless_eq(&gateway, &net_lwip_runtime.ip6_gateway))
+			return -EBUSY;
+		return 0;
+	}
+
+	if (ip6_addr_islinklocal(&addr)) {
+		netif_ip6_addr_set(netif, 0, &addr);
+		netif_ip6_addr_set_state(netif, 0, IP6_ADDR_TENTATIVE);
+	} else {
+		netif_create_ip6_linklocal_address(netif, 1);
+		if (!ip6_addr_isany(&addr)) {
+			netif_ip6_addr_set(netif, 1, &addr);
+			netif_ip6_addr_set_state(netif, 1, IP6_ADDR_TENTATIVE);
+		}
+	}
+#if CONFIG_IS_ENABLED(IPV6_ROUTER_DISCOVERY)
+	netif_set_ip6_autoconfig_enabled(netif, 1);
+#endif
+	ip6_addr_copy(net_lwip_runtime.ip6_addr, addr);
+	net_lwip_runtime.ip6_prefix_len = prefix;
+	ip6_addr_copy(net_lwip_runtime.ip6_gateway, gateway);
+	ip6_addr_assign_zone(&net_lwip_runtime.ip6_gateway, IP6_UNICAST, netif);
+	net_lwip_runtime.ip6_configured = true;
+
+	return 0;
+}
+
+int net_lwip_ip6_start(struct net_lwip_ctx *ctx)
+{
+	ulong start;
+	int ret = net_lwip_ip6_init(ctx);
+
+	if (ret)
+		return ret;
+	start = get_timer(0);
+	while (!ip6_addr_isvalid(netif_ip6_addr_state(ctx->netif, 0))) {
+		if (ip6_addr_isduplicated(netif_ip6_addr_state(ctx->netif, 0)))
+			return -EADDRINUSE;
+		if (ctrlc())
+			return -EINTR;
+		if (get_timer(start) >= 15000)
+			return -ETIMEDOUT;
+		ret = net_lwip_poll();
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Check readiness without blocking another address family's clients. */
+int net_lwip_ip6_ready(struct net_lwip_ctx *ctx, ip_addr_t *dest)
+{
+	const ip6_addr_t *duplicate = NULL;
+	const ip_addr_t *src;
+	int ret, i;
+
+	if (!IP_IS_V6(dest) || ip6_addr_isany(ip_2_ip6(dest)) ||
+	    ip6_addr_ismulticast(ip_2_ip6(dest)) ||
+	    ip6_addr_isloopback(ip_2_ip6(dest)) ||
+	    ip6_addr_isipv4mappedipv6(ip_2_ip6(dest)) ||
+	    ip6_addr_isipv4compat(ip_2_ip6(dest)))
+		return -EINVAL;
+	ret = net_lwip_ip6_init(ctx);
+	if (ret)
+		return ret;
+	ip6_addr_assign_zone(ip_2_ip6(dest), IP6_UNICAST, ctx->netif);
+	src = ip6_select_source_address(ctx->netif, ip_2_ip6(dest));
+	if (src && (ip6_addr_islinklocal(ip_2_ip6(dest)) ||
+		    !ip6_addr_islinklocal(ip_2_ip6(src)))) {
+		if (ip6_addr_islinklocal(ip_2_ip6(dest)) ||
+		    !ip6_addr_isany(&net_lwip_runtime.ip6_gateway) ||
+		    nd6_find_route(ip_2_ip6(dest)) == ctx->netif)
+			return 0;
+		for (i = 0; i < LWIP_IPV6_NUM_ADDRESSES; i++) {
+			if (ip6_addr_isvalid(netif_ip6_addr_state(ctx->netif, i)) &&
+			    netif_ip6_addr_isstatic(ctx->netif, i) &&
+			    net_lwip_ip6_static_prefix(ctx->netif, i, ip_2_ip6(dest)))
+				return 0;
+		}
+		return -EAGAIN;
+	}
+	for (i = 0; i < LWIP_IPV6_NUM_ADDRESSES; i++) {
+		const ip6_addr_t *addr = netif_ip6_addr(ctx->netif, i);
+
+		if (ip6_addr_islinklocal(addr) != ip6_addr_islinklocal(ip_2_ip6(dest)))
+			continue;
+		if (ip6_addr_istentative(netif_ip6_addr_state(ctx->netif, i)))
+			return -EAGAIN;
+		if (ip6_addr_isduplicated(netif_ip6_addr_state(ctx->netif, i)))
+			duplicate = addr;
+	}
+	if (duplicate) {
+		printf("Duplicate IPv6 address: %s\n", ip6addr_ntoa(duplicate));
+		return -EADDRINUSE;
+	}
+	return -EAGAIN;
+}
+
+/* Wait for DAD and, if needed, an advertised prefix before starting a client. */
+int net_lwip_ip6_prepare(struct net_lwip_ctx *ctx, ip_addr_t *dest)
+{
+	ulong start = get_timer(0);
+	int ret;
+
+	do {
+		ret = net_lwip_ip6_ready(ctx, dest);
+		if (ret != -EAGAIN)
+			return ret;
+		if (ctrlc())
+			return -EINTR;
+		ret = net_lwip_poll();
+		if (ret < 0)
+			return ret;
+	} while (get_timer(start) < 15000);
+
+	puts("Timed out waiting for an IPv6 address or route\n");
+	return -ETIMEDOUT;
+}
+#endif
+
 static int net_lwip_configure(enum net_lwip_addr_mode addr_mode)
 {
 	ip4_addr_t ip, mask, gw;
@@ -408,6 +736,9 @@ static int net_lwip_start_ctx(struct net_lwip_ctx *ctx,
 			return -ENODEV;
 		}
 		net_lwip_runtime.netif = netif;
+#if CONFIG_IS_ENABLED(IPV6)
+		net_lwip_runtime.ip6_lifetime_time = get_timer_us(0);
+#endif
 	} else if (addr_mode == NET_LWIP_ADDR_NONE &&
 		   !net_lwip_runtime.no_addr_users) {
 		ret = net_lwip_configure(NET_LWIP_ADDR_NONE);
@@ -682,6 +1013,9 @@ int net_lwip_poll(void)
 		return -EBUSY;
 
 	net_lwip_runtime.polling = true;
+#if CONFIG_IS_ENABLED(IPV6)
+	net_lwip_ip6_update_lifetimes();
+#endif
 	ret = net_lwip_rx(net_lwip_runtime.dev, net_lwip_runtime.netif);
 	net_lwip_runtime.polling = false;
 
diff --git a/test/dm/eth.c b/test/dm/eth.c
index f3a972c5c0a..a5e98f2e81f 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -23,7 +23,7 @@
 
 #define DM_TEST_ETH_NUM		4
 
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6) && IS_ENABLED(CONFIG_NET_LEGACY)
 static int dm_test_string_to_ip6(struct unit_test_state *uts)
 {
 	char *str;
@@ -774,7 +774,7 @@ DM_TEST(dm_test_dhcp6_clientid_reject, UTF_SCAN_FDT);
 #endif
 #endif
 
-#if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
+#if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY) && IS_ENABLED(CONFIG_NET_LEGACY)
 
 static u8 ip6_ra_buf[] = {0x60, 0xf, 0xc5, 0x4a, 0x0, 0x38, 0x3a, 0xff, 0xfe,
 			  0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x6, 0x85, 0xe6,

-- 
2.53.0

