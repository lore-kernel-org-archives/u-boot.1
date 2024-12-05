Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC8BE7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD0A88B4B;
	Thu,  5 Dec 2024 20:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Lj1ZxLP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E5828903B; Thu,  5 Dec 2024 20:33:01 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF2787BF4
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A92FE3FC13; 
 Thu,  5 Dec 2024 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733427179;
 bh=1MmRnaFtSzHU9xwcfsQDaUQxUN4gN3FQKkm2eio8Gl4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Lj1ZxLP05GHh5UxUdcqIIjQYC+Ae5ZJZqE3Vuo/Cd9sM/bkmuoLZ6gmjn5kHgk9Q1
 l3VALsvIF/kvB10vEi1CM31OEzldF4B5RuA2LS//rv8e61CQNvhv0kxdJMz3EM31/9
 HTzEQiZqylHudlRK0ASn0ud5QMJ4cOry7qq6oBglyZBUXODTkkxKWrHKKdMCR3mrEZ
 1EaV3Z9B6t9CWrLtjxxnNmQV2koYoyooToqfkH7mWjYbGiYbuiVqtklQm1ycnzkaMQ
 zJ3mSbdZIkI3tEc+06991x05JpCX5dCmMIbXywR65skHbAIKB06P8cccocPeIaYAbH
 FsdGdkoMEsTyg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: lwip: do not return CMD_RET_USAGE if no interface
Date: Thu,  5 Dec 2024 20:32:53 +0100
Message-ID: <20241205193254.25807-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

If the dns command cannot find a network interface, we should return
CMD_RETFAIURE and not -1 (CMD_RET_USAGE).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 net/lwip/dns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 4b937feaee1..1de63c9998b 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -56,7 +56,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 
 	netif = net_lwip_new_netif(udev);
 	if (!netif)
-		return -1;
+		return CMD_RET_FAILURE;
 
 	dns_init();
 
-- 
2.45.2

