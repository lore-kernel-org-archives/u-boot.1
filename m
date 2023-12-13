Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9FAC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 21:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0615987852;
	Wed, 13 Dec 2023 22:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702501916;
	bh=3aaAqwvjp1e0N0wfT0dKQPJ4/Gx7ktbfK130SeGYbMc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NBhOKbNc/p9NFtbz6bugw5a/Vk4lwJrwmYk3mL1lKPpO7QFGvRdjn8hVZequyGJzM
	 fFnpjlRIgfAaAfZ62JLTR1xIWJtl84jB9rU5TbuXomdgOmPQ1+MgmNVNxy/EkDX2+f
	 MKv4coWsTsjSQ5NIFasbdYTRhL7iQFr6wdXgIFP/HK+/csEL25IQG6v5nBtVD1Yiay
	 d/yvD5hsgXNJDsjqJ89Zq5oIGajFGr9kHBdxbY9CebdnM+DkiJd7J23Hd1DiT7xkJN
	 T0qBT7kvZGtPeVPSZboRBW59d2jValEcf/VrIprjvx/kVfIPgf06/ikhv/3+3tbAYa
	 ls+z330SDugvw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ACC8D86579;
 Wed, 13 Dec 2023 22:11:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702501914;
 bh=3aaAqwvjp1e0N0wfT0dKQPJ4/Gx7ktbfK130SeGYbMc=;
 h=From:To:Cc:Subject:Date:From;
 b=XQmQrwQqtBotb2fK8gClINKbcrS4pqLt7c5GejzlOR1jAKBpjUSNM3779VJH4Iqx2
 zXJA6bP6ckuQ3xW7sRsrzYX8qK3FYcK9cAr5zyMQGqv9guv4q7MMG1tSIz4mdi33FX
 /vs7VKOnFXvg+MLkCY/mzwBRp4jUF3K8QzIstzluQbK+6xDCuSikycaqPVEpLDPgDY
 9Vz14S4uSH3aEpDQLn902jRTaPe3X8S9hfTltfXfzXZC/Rq3z69BKSOzbmS0MgVJRf
 /ytyjSRNDvfvxuZ4PeCeZ0ywMJa817UIlnuhWZLznhywoSN6x5eCy+rTyr4NxDOi07
 GTN+zangcAwaw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Duncan Hare <DuncanCHare@yahoo.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] net: wget: Support non-default HTTP port
Date: Wed, 13 Dec 2023 22:11:13 +0100
Message-ID: <20231213211125.279880-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

Currently the wget command is hard wired to HTTP port 80. This is
inconvenient, as it is extremely easy to start trivial HTTP server
as an unprivileged user using e.g. python http module to serve the
files, but such a server has to run on one of the higher ports:
"
$ python3 -m http.server -d $(pwd) 8080
"

Make it possible to configure HTTP server port the same way it is
possible to configure TFTP server port, using environment variable
'httpdstp' (similar to 'tftpdstp'). Retain port 80 as the default
fallback port. This way, users can start their own trivial server
and conveniently download whatever files they need into U-Boot.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Duncan Hare <DuncanCHare@yahoo.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: Update documentation
---
 doc/usage/cmd/wget.rst    |  3 ++-
 doc/usage/environment.rst |  4 ++++
 include/net/wget.h        |  1 -
 net/wget.c                | 14 ++++++++++----
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index e1e7f8d8145..8e7383b6c60 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -16,7 +16,8 @@ Description
 The wget command is used to download a file from an HTTP server.
 
 wget command will use HTTP over TCP to download files from an HTTP server.
-Currently it can only download image from an HTTP server hosted on port 80.
+By default the destination port is 80 and the source port is pseudo-random.
+The environment variable *httpdstp* can be used to set the destination port.
 
 address
     memory address for the data downloaded
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index c57b717caaf..82b6ea7b6e7 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -306,6 +306,10 @@ ethrotate
     anything other than "no", U-Boot does go through all
     available network interfaces.
 
+httpdstp
+    If this is set, the value is used for HTTP's TCP
+    destination port instead of the default port 80.
+
 netretry
     When set to "no" each network operation will
     either succeed or fail without retrying.
diff --git a/include/net/wget.h b/include/net/wget.h
index da0920de118..6714f7ea573 100644
--- a/include/net/wget.h
+++ b/include/net/wget.h
@@ -17,6 +17,5 @@ enum wget_state {
 };
 
 #define DEBUG_WGET		0	/* Set to 1 for debug messages */
-#define SERVER_PORT		80
 #define WGET_RETRY_COUNT	30
 #define WGET_TIMEOUT		2000UL
diff --git a/net/wget.c b/net/wget.c
index 6ae2237a0a8..817c5ebd5d0 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -19,6 +19,9 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+/* The default, change with environment variable 'httpdstp' */
+#define SERVER_PORT		80
+
 static const char bootfile1[] = "GET ";
 static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
 static const char http_eom[] = "\r\n\r\n";
@@ -134,19 +137,22 @@ static void wget_send_stored(void)
 	int len = retry_len;
 	unsigned int tcp_ack_num = retry_tcp_seq_num + (len == 0 ? 1 : len);
 	unsigned int tcp_seq_num = retry_tcp_ack_num;
+	unsigned int server_port;
 	uchar *ptr, *offset;
 
+	server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
+
 	switch (current_wget_state) {
 	case WGET_CLOSED:
 		debug_cond(DEBUG_WGET, "wget: send SYN\n");
 		current_wget_state = WGET_CONNECTING;
-		net_send_tcp_packet(0, SERVER_PORT, our_port, action,
+		net_send_tcp_packet(0, server_port, our_port, action,
 				    tcp_seq_num, tcp_ack_num);
 		packets = 0;
 		break;
 	case WGET_CONNECTING:
 		pkt_q_idx = 0;
-		net_send_tcp_packet(0, SERVER_PORT, our_port, action,
+		net_send_tcp_packet(0, server_port, our_port, action,
 				    tcp_seq_num, tcp_ack_num);
 
 		ptr = net_tx_packet + net_eth_hdr_size() +
@@ -161,14 +167,14 @@ static void wget_send_stored(void)
 
 		memcpy(offset, &bootfile3, strlen(bootfile3));
 		offset += strlen(bootfile3);
-		net_send_tcp_packet((offset - ptr), SERVER_PORT, our_port,
+		net_send_tcp_packet((offset - ptr), server_port, our_port,
 				    TCP_PUSH, tcp_seq_num, tcp_ack_num);
 		current_wget_state = WGET_CONNECTED;
 		break;
 	case WGET_CONNECTED:
 	case WGET_TRANSFERRING:
 	case WGET_TRANSFERRED:
-		net_send_tcp_packet(0, SERVER_PORT, our_port, action,
+		net_send_tcp_packet(0, server_port, our_port, action,
 				    tcp_seq_num, tcp_ack_num);
 		break;
 	}
-- 
2.42.0

