Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF42C9830C
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 00:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F40838BB;
	Sat, 17 Jan 2026 01:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="P2WRjchE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A116283015; Sat, 17 Jan 2026 01:25:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A896836AC
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 01:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f646=7W=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1768609506; bh=Li1mX7GtUZwInyjWpL7UtZC6AJKtFKUQ1lDZGhr5L6A=;
 b=P2WRjchEKSWqtQuEaqCykQriefVSuJkMCkpLjf9uVMMweH8QgkhMhVRBt+/QwfD4ceYNCOsqx
 oCTHK1lngv94MNI6APJh2uVXLPE6qr0wWU8M/oezRWN0X22Dkq6Vw3MGO3pkx7pP0H0tllqQHaa
 2lqLjF2OffwvdfDJC10g7HuKer0u55XNV/hCazS3GmZgB0ungkvxgh7qYQHP2DDnYEnry5cp+RJ
 Bm/FFBXjgOSso1lwk7S8CFbhqhr9rQVAPGZ9W7arkBWcBe5c3DL7e2UUCvPgN/+Rhjr4pKQC/tE
 UsqGyEL+dJ1iN5WjE3RcJIgODBZnFNK0WCjXMJVW3iOA==
X-Forward-Email-ID: 696ad6de75104fdab5e8c312
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/6] net: lwip: dns: Fix print of resolved IP address
Date: Sat, 17 Jan 2026 00:24:37 +0000
Message-ID: <20260117002452.1026310-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117002452.1026310-1-jonas@kwiboo.se>
References: <20260117002452.1026310-1-jonas@kwiboo.se>
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

The lwIP dns command only prints out cached resolved IP addresses.

When a hostname is first resolved and ERR_INPROGRESS is returned the
dns command prints out 0.0.0.0 instead of the resolved IP address.

Fix this by printing out host_ipaddr instead of the temporary ipaddr
that only is valid when ERR_OK is returned.

Fixes: 1361d9f4f00a ("lwip: dns: do not print IP address when a variable is specified")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 net/lwip/dns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 9964003195f8..2b2a5947a2b8 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -86,7 +86,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 
 	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
 		if (!var)
-			printf("%s\n", ipaddr_ntoa(&ipaddr));
+			printf("%s\n", ipaddr_ntoa(&dns_cb_arg.host_ipaddr));
 		return CMD_RET_SUCCESS;
 	}
 
-- 
2.52.0

