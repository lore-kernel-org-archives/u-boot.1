Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E497F513E6
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 22:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ABD283F2D;
	Thu,  5 Mar 2026 23:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="z9L55B18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D904383F2E; Thu,  5 Mar 2026 23:36:18 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50537839A8
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 23:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e821=BG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1772750174;
 bh=E64ILDSm94k9T5rq0frA3WdUHp7UoMQsqH8LkIkWDhM=;
 b=z9L55B18IhaWQmDa+pfZfJz18P5LPLI+GPV4Pk0hxLRDnZXndz8edZyz9coE4NpFmEJjt7ZWl
 r8MaTjfxSlEfRhRApP8xCH/YAQljfnkihaMSPpoapw86nDrBYDiO/XaxOIwsUDcfX+T446i+Vpq
 ZLDyHvqlEfT+XcQ4hqoFt9MepTE//RhqmDcMAJSee2P8Yw1sejRoRz5eGF9sKF56GAuqVy3WJhb
 RygIIEgHfirQOK3Pj6GI2BWe9Re5fYJQUYrSCcfAuCP9nIQxfBDA55uWAy74t0Pgjj4XPWgbNJr
 E0xBsHzovpJqzovOIl8zjI8xPTbETJ0cqF5C6wsqL4YQ==
X-Forward-Email-ID: 69aa055a87915799587b96c8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.39
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] net: lwip: Fix PBUF_POOL_BUFSIZE when PROT_TCP_LWIP is
 disabled
Date: Thu,  5 Mar 2026 22:36:03 +0000
Message-ID: <20260305223606.3163779-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
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

The PBUF_POOL_BUFSIZE ends up being only 592 bytes, instead of 1514,
when PROT_TCP_LWIP Kconfig option is disabled. This results in a full
Ethernet frame requiring three PBUFs instead of just one.

This happens because the PBUF_POOL_BUFSIZE constants depends on the
value of a TCP_MSS constant, something that defaults to 536 when
PROT_TCP_LWIP=n.

  PBUF_POOL_BUFSIZE = LWIP_MEM_ALIGN_SIZE(TCP_MSS + 40 + PBUF_LINK_HLEN)

Ensure that a full Ethernet frame fits inside a single PBUF by moving
the define of TCP_MSS outside the PROT_TCP_LWIP ifdef block.

Fixes: 1c41a7afaa15 ("net: lwip: build lwIP")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 lib/lwip/u-boot/lwipopts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index e8a2c9d7a0a6..96aae3ad1f4f 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -121,9 +121,9 @@
 #define LWIP_UDP                        0
 #endif
 
+#define TCP_MSS                         1460
 #if defined(CONFIG_PROT_TCP_LWIP)
 #define LWIP_TCP                        1
-#define TCP_MSS                         1460
 #define TCP_WND                         CONFIG_LWIP_TCP_WND
 #define LWIP_WND_SCALE                  1
 #define TCP_RCV_SCALE                   0x7
-- 
2.53.0

