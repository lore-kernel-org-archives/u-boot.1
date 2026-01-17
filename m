Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CCFC9830D
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 00:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B37839DF;
	Sat, 17 Jan 2026 01:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kGj/IRoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 632BF83980; Sat, 17 Jan 2026 01:25:26 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC153839DF
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 01:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f646=7W=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1768609522; bh=3cY9PC9XYeqDZRIAaIOQnhIFLFt4K/nBANJjdaU+7pc=;
 b=kGj/IRoGmPsGhHDpT425ilYuOxUnBTOj+ko7nrXeR0hZ1lxmtg2LQmcr/iiqvs7bLDOs58fVC
 EEn6SaFdFkr4gVOrXoPII3/jz5LXeA8U3Awo/5893N5Y0eRSj2kJCxFIjEMbJT3xz8lrB5nMyAE
 OpLlIlcYYe2sJ7ZUDPz/J0fIbAd5CllxSPEPwmHFPH347WCm9OB438Y9ekhm/XpaX5cHpo+9lMS
 wwitbsh0AbrDbvVyWIeb0InM4LIFDDyjzp5ceM9ecuG6FQbrgD3R8qmvQ9rSj93wgkeOMNiqNDL
 7QAIUiSb4HZBuAcNOi77whisEI1Yn+v0SkEW8dOYK/1A==
X-Forward-Email-ID: 696ad6ee75104fdab5e8c3b4
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
Subject: [PATCH 5/6] net: lwip: dhcp: Save DHCP siaddr field to tftpserverip
 env var
Date: Sat, 17 Jan 2026 00:24:41 +0000
Message-ID: <20260117002452.1026310-6-jonas@kwiboo.se>
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

The DHCP siaddr field contains the IP address of next server to use in
bootstrap. Typically this will be the IP address of a TFTP server or the
IP address of the DHCP server itself.

RFC 2131, 2. Protocol Summary, Page 10:

   DHCP clarifies the interpretation of the 'siaddr' field as the
   address of the server to use in the next step of the client's
   bootstrap process.  A DHCP server may return its own address in the
   'siaddr' field, if the server is prepared to supply the next
   bootstrap service (e.g., delivery of an operating system executable
   image).  A DHCP server always returns its own address in the 'server
   identifier' option.

Set the 'tftpserverip' env variable when the siaddr field contains an
IP address that is different compared to the DHCP server IP address.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 net/lwip/dhcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 4cd4184c42bb..acdf601d7eb5 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -101,6 +101,9 @@ static int dhcp_loop(struct udevice *udev)
 	env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
 	if (!ip4_addr_isany(&dhcp->offered_gw_addr))
 		env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr));
+	if (!ip4_addr_isany(&dhcp->offered_si_addr) &&
+	    !ip4_addr_eq(&dhcp->offered_si_addr, &dhcp->server_ip_addr))
+		env_set("tftpserverip", ip4addr_ntoa(&dhcp->offered_si_addr));
 
 #ifdef CONFIG_PROT_DNS_LWIP
 	env_set("dnsip", ip4addr_ntoa(dns_getserver(0)));
-- 
2.52.0

