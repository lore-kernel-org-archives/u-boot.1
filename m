Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA73DC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BEE488906;
	Sat, 13 Jul 2024 15:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xQftN/2h";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aVTJQXq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3FA8888F6; Sat, 13 Jul 2024 15:21:46 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC39F888C8
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpyc4MkCz9sTd;
 Sat, 13 Jul 2024 15:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RjGUCiVk+CREnzxPEmzEqCxWnZX9yv6LpTQAM+yE3As=;
 b=xQftN/2hqSRmBN4rASLUAWGNHL5CwD2wpMsfW3m+e2Ip9BQ1r7XlDKAcOJNsZtD+C1XYYz
 xCf2h5i9SwoNxYqQqJTAiNTjVwXY/vPXo+B4+ATkhWiYHrvhTJJNOGiaTJSF33NaVVV9Z+
 lBiG3Uyp4eIAefsWWyHdwl2uSohr69NSNAcxut19dHa2nL4IXR3+5ti4ag47kN8KGhKuDW
 g8szDPnZXMb3lw4OFbrmNrdnPGHuq3wxOhKh3wuVtmGk8NKeq+JU6eB2FW+e8NQ9e/wO8d
 rhb4kjhIpdvByxPBSWV1WXQsSCR9xQi/bJefv2C7RQx5dJc36PQHlGM+9Y206A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RjGUCiVk+CREnzxPEmzEqCxWnZX9yv6LpTQAM+yE3As=;
 b=aVTJQXq9VQIk72XjSkm0RkTba9tcs2mLPPVVPJaQ6EJzoMaOMfd59rufdPoblKS7TCPWr3
 6miysS2NFQ32ZVPapUEgGk1SBkJAfOyfOLPZokqre9YZpVZcsY5hPMamdmXoD+xTEQuzYO
 J80THzi/OLuJ1XAi54A85LMKq8woObA5UFRSBVD08fBQITwQbyZsBcB3Kz+HfOrP1gO9UE
 jBoVaIQFuc+xfnOCYvwjRHGg7G3FJBsncgn1P8KpRIuUL17/sCFjvtt1VrzbX7+oR3DThJ
 6NJrKeOWOAJRqQ/Eja3DqPELhUKcBaQeO7c3FeszdZ6c+MGGvQmuyoHHsW1Sdw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 35/45] net: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:26 +0200
Message-ID: <20240713132021.57650-35-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a1fab749c9e32d478d3
X-MBO-RS-META: uq7z9cu4opykd9e4t88toctq7k3mensi
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 net/bootp.h | 1 -
 net/dns.c   | 1 -
 net/net.c   | 1 -
 net/nfs.c   | 1 -
 net/nfs.h   | 1 -
 net/rarp.c  | 2 --
 net/tftp.c  | 1 -
 7 files changed, 8 deletions(-)

diff --git a/net/bootp.h b/net/bootp.h
index 4e32b19d424..521d38f3528 100644
--- a/net/bootp.h
+++ b/net/bootp.h
@@ -65,7 +65,6 @@ struct bootp_hdr {
 extern u32	bootp_id;		/* ID of cur BOOTP request	*/
 extern int	bootp_try;
 
-
 /* Send a BOOTP request */
 void bootp_reset(void);
 void bootp_request(void);
diff --git a/net/dns.c b/net/dns.c
index c2f0ab98c8d..08ad54a04d5 100644
--- a/net/dns.c
+++ b/net/dns.c
@@ -121,7 +121,6 @@ static void dns_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	char ip_str[22];
 	struct in_addr ip_addr;
 
-
 	debug("%s\n", __func__);
 	if (dest != dns_our_port)
 		return;
diff --git a/net/net.c b/net/net.c
index 23b5d3356af..d9bc9df643f 100644
--- a/net/net.c
+++ b/net/net.c
@@ -80,7 +80,6 @@
  *	Next step:	none
  */
 
-
 #include <bootstage.h>
 #include <command.h>
 #include <console.h>
diff --git a/net/nfs.c b/net/nfs.c
index acc7106f10d..537d4c62de2 100644
--- a/net/nfs.c
+++ b/net/nfs.c
@@ -913,7 +913,6 @@ static void nfs_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	}
 }
 
-
 void nfs_start(void)
 {
 	debug("%s\n", __func__);
diff --git a/net/nfs.h b/net/nfs.h
index 68ada0efeb9..6bf1cb76bd5 100644
--- a/net/nfs.h
+++ b/net/nfs.h
@@ -81,7 +81,6 @@ struct rpc_t {
 };
 void nfs_start(void);	/* Begin NFS */
 
-
 /**********************************************************************/
 
 #endif /* __NFS_H__ */
diff --git a/net/rarp.c b/net/rarp.c
index a6b564e314d..a346e067cb9 100644
--- a/net/rarp.c
+++ b/net/rarp.c
@@ -45,7 +45,6 @@ void rarp_receive(struct ip_udp_hdr *ip, unsigned len)
 	}
 }
 
-
 /*
  *	Timeout on BOOTP request.
  */
@@ -60,7 +59,6 @@ static void rarp_timeout_handler(void)
 	}
 }
 
-
 void rarp_request(void)
 {
 	uchar *pkt;
diff --git a/net/tftp.c b/net/tftp.c
index 6b16bdcbe4c..65c39d7fb70 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -694,7 +694,6 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	}
 }
 
-
 static void tftp_timeout_handler(void)
 {
 	if (++timeout_count > timeout_count_max) {
-- 
2.43.0

