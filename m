Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA07CEFD01
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 20:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A527F83F01;
	Tue,  6 Jan 2026 21:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UssGgiK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4801083FBE; Tue,  6 Jan 2026 21:34:49 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA93083D9F
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 21:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0cbd=7M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1767731684;
 bh=skQkvfC91h2RtKeDUTsD9PC2zNJT31n4DHtu5Ccg98I=;
 b=UssGgiK9LU5R0lksxnzFv96vD7FyeHyZeYamqRSVt4L44W1sbQ2rgT0mCtxH2SQ/1y2xbv76k
 WkOCEe1Js9LdxiXaOGUWHUAIp5A31HgOxCzbvg14buJSsi0p9dxxEqT3yg4M+MK8pZTMKqmduRx
 jq3h5l7cyLCqrNSlSQHZ0zGDQjLpDhpOsUkiMqVI2N78IFdGiRFLwJ9mDB9AX5JC8GbJLY8lbkn
 eJQ3JSZxGDH/aO8awBZPbPvI+NLChlzUT5fiRtwNJJA7bxeSiJOHo/mOfH3gzufWj1qfjZBCqYv
 2QepcAycmVtwG9JYTdBxUkzAlKyx2Brwiy4WNJK6rNZg==
X-Forward-Email-ID: 695d71df4c4fab46c2994ff3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Jerome Forissier <jerome@forissier.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] net: lwip: add TFTPSERVERIP Kconfig option
Date: Tue,  6 Jan 2026 20:34:30 +0000
Message-ID: <20260106203433.3133926-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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

With the legacy networking stack, it is possible to use USE_SERVERIP,
SERVERIP and BOOTP_PREFER_SERVERIP Kconfg options to force use of a
specific TFTP server ip.

Using the lwIP networking stack use of the 'tftpserverip' environment
variable provide the closest equivalent functionality.

Add USE_TFTPSERVERIP and TFTPSERVERIP Kconfig options that can be used
to add the 'tftpserverip' environment variable to force use of a
specific TFTP server ip.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/env_default.h |  3 +++
 net/lwip/Kconfig      | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/env_default.h b/include/env_default.h
index 7f8dc1c35a74..014873e304d8 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -58,6 +58,9 @@ const char default_environment[] = {
 #ifdef	CONFIG_USE_SERVERIP
 	"serverip="	CONFIG_SERVERIP			"\0"
 #endif
+#ifdef	CONFIG_USE_TFTPSERVERIP
+	"tftpserverip="	CONFIG_TFTPSERVERIP		"\0"
+#endif
 #ifdef	CONFIG_SYS_DISABLE_AUTOLOAD
 	"autoload=0\0"
 #endif
diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
index 5789766fe624..0cfd3eb2684f 100644
--- a/net/lwip/Kconfig
+++ b/net/lwip/Kconfig
@@ -72,4 +72,16 @@ config LWIP_TCP_WND
 	  but QEMU with "-net user" needs no more than a few KB or the
 	  transfer will stall and eventually time out.
 
+config USE_TFTPSERVERIP
+	bool "Set a default 'tftpserverip' value in the environment"
+	depends on CMD_TFTPBOOT
+	help
+	  Defines a default value for the IP address of a TFTP server to
+	  contact when using the "tftpboot" command.  (Environment variable
+	  "tftpserverip")
+
+config TFTPSERVERIP
+	string "Value of the default 'tftpserverip' value in the environment"
+	depends on USE_TFTPSERVERIP
+
 endif # NET_LWIP
-- 
2.52.0

