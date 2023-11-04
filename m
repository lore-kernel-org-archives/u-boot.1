Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D0BC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 15:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA2587091;
	Sat,  4 Nov 2023 16:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699110634;
	bh=Ohtq7vJLgQoqdPSrIpxNW8CYOzfVU3P5rhSZ2gSPjJY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WA7jb3m9URLswnxXleGi9PEbt3ZaxQCCvgVsFTHbYPzK4v0ogJbjKujwzr+mOVBOn
	 81tLcSM0Qk7Rp37aVQWny1QClZdrfzgyeEK1nNAnquMDn8afG8oZ8nEMVv2slxGKy9
	 n/bdXgTmraUmzMRzc8mnl7gcgb28iGAzR2RElImnEmrW7sHF/dY01lWvEr4+BIx6Rg
	 oHPe3EvlAkcNba1j3sdGZOfQXGqTSJBYhN6Xbjd4Y8rnhVrTuWYo7Y4nFbflilliNW
	 gPiks9xi8ou3s6NhIvcS+IEC795AI2vBD+xGL3fSnyaOkr4Tkklos82BtypV7nzMmN
	 D0ftLFIhTACQg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E19FF8708A;
 Sat,  4 Nov 2023 16:10:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699110627;
 bh=Ohtq7vJLgQoqdPSrIpxNW8CYOzfVU3P5rhSZ2gSPjJY=;
 h=From:To:Cc:Subject:Date:From;
 b=cXpHT4kfhWJvNfGtzwvFdsoLzS32SmBoHt6syriMJ+k8CRwNmgDqPBEx0GF5hCxQr
 ZIjNlSR+bwofQlTGUcLwyX+/UBxsAyW+8Ajatb1XPspeD9rPNJWyb9Zsm7T+tBAp2f
 SIfKELy+YzGfasriCEKY8NTxiGuQdEBbCXtrSw/0u7HebXgRbfHc7Y8In7hKtIY/WG
 9LHWXuRXN82+0dEIAM8Vf77xIeVM6RfT7XwD1n0V91uMfEFOZ1l73lOk0WtUDuYUBB
 QMT7gdYGw+L1U0g7bbFyJ8b0TNFlKM4NH+9qp/MQ6tOgJX7Nym7Crtxs9ar2hRtux5
 M//rEJ+21feag==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Duncan Hare <DuncanCHare@yahoo.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] net: wget: Support non-default HTTP port
Date: Sat,  4 Nov 2023 16:09:54 +0100
Message-ID: <20231104151012.51516-1-marex@denx.de>
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
Cc: Marek Vasut <marex@denx.de>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
 include/net/wget.h |  1 -
 net/wget.c         | 14 ++++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

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
index 8bb4d72db1a..e1e580c8351 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -14,6 +14,9 @@
 #include <net/tcp.h>
 #include <net/wget.h>
 
+/* The default, change with environment variable 'httpdstp' */
+#define SERVER_PORT		80
+
 static const char bootfile1[] = "GET ";
 static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
 static const char http_eom[] = "\r\n\r\n";
@@ -91,19 +94,22 @@ static void wget_send_stored(void)
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
@@ -118,14 +124,14 @@ static void wget_send_stored(void)
 
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

