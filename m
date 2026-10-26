Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AC606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ctx257j+;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cybIfiW9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA637606BE;
	Mon, 26 Oct 2026 21:29:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id apGvdAFvKqjq; Mon, 26 Oct 2026 21:29:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE0A8605EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050147;
	b=b/JrGGjXKjwuWT4izqRvOw8swuKGuHl7tJZ8XLaRu9RssWuBUOPy1mfum0YBlkathakc
	 Et3LOPPAtr1/2gOfhDcMWIi8ce7toO4l0E4ilbBBaGDjIiZkmAjwyJav5xAci3ym2En6c
	 Pd08GS75CWkwKEnrkgcCJjyHbDs9WXiDqi+yfgAfkQOkyB8CkFdiXdkK1cjJcs/rUBR9f
	 QX41wmU4qkrAwWtsvLfnRkql5dGatOFtCXh5svHrWo0hvpOzcu1yG0d6VU1pgRp+BFrQ1
	 dJ2gBnFNfp3CuY5dkbRb7uTQbGnqA2keZn5dzk6WWfRtYULb0EWXpFS8gqHv3YMqsJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050147;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s5jXaTRzMStywT9Hc9z72oL/3X6oES0txrExXpjNReU=;
	b=kdHdS2Cyxw858tpz65gM/LA0zMjIhsxw/45ZNRNIVBlnrvosr6cNZJDwmD5ZVcg9R2PE
	 c/e76wk0xqzF1nDnTmpxTqBRApIlo7lTGRmizGFh19x6K1mSNqY4Ufq+muKSKuoW8z5Q5
	 wkY1s/72WCamtR21tIdXWRKFMRdqC264fXXDJ1XKeqxjvhcOFUphDR6Oodpl/w+Tj5wXy
	 SEK9nWFmapVUzGy/ohct2VEPnrIEB5jBYT1di/m5u1tflMmcSFK0t8Hs0u/wn89n26P+w
	 dt/bWhN4iJS0X+SX44DBd8t/N4nK8Q2uka399yHsHDuTkIsNviKqHvUy3HnEdugcKSg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050147;
	bh=s5jXaTRzMStywT9Hc9z72oL/3X6oES0txrExXpjNReU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ctx257j+M7XJPlWunWeNpp89anrd2fe/CnzstMWwIc1wC7jdJrsukxbAKkyEJP8hY
	 oL5mz+bV5206wPXbWHfgYNNEnOhf03XXesrOWwgQWdNIjE7pGV167mYrDYXPGuoWaj
	 CVyLQcTSV0oPOc5aq2GkLOrSrB1/RzXZPJ6gzvOyjQAxvsqceQo2y4G6EE1BAwU9+f
	 2J4cEIkAOQ8F+QJhWa4MgzFE8UkHY0vnS5M9GYMKXurftYzmoscNBiUPBEL1vEg3Re
	 A/VyG+YAMF+e01f2UJs6utarNziCFJE9ColXKKZXdfm9kCHbjwjx0npH0DLXqET6pi
	 /fBOghD+gmMhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE0A8605EC;
	Mon, 26 Oct 2026 21:29:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8299A3421
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6874080A90
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qmqz9Cx7_Nt5 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:29:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 289CD80A5A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050143;
 b=PQiLQKto9/dL01DnzZQLl5J6SjUlwvxcYeyriLCUNxTWxZVqSsTxJTNAywkLLwAoYp2i
 J0T9tKjuzzco7A2RW1/wDFTDQlh4A4XUhTtLe2jO5wmrmm6qP0NlqpCBTl79nBfPmkw3d
 UgeS6bcenuHU1+xKjtmBW+t1J2JmJHSFaJ/1Tfdif+zM9PXhxORuiO22A7rORf9ShwcjB
 ixhybJ2WZBVdeH0amUjrJzD7tAc0SSlmWNVqLg2sqHumd5W5Fie1FgO7B9VcIGN/lTEH7
 4c3Gv/ne0D4oAvx7y8Krnj4VfEUUuupl0kQhdKRLCXUPtew1kamhXUNeyBfA6o8m3xA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050143;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=s5jXaTRzMStywT9Hc9z72oL/3X6oES0txrExXpjNReU=;
 b=sxRm3RTKcNr1klWPdt+btP2c3mGod6vivqGt0WCceFi0J/Ojw1pdlk+X0EWuZE78DEoR
 TDzlj/p2VniKW7NISIfO/wGGycWbgcCDqyyXm1XDiU1plClncqfMYZ47rKwxGx+9XMgP7
 5LxoUVwXVrfyGa8CTTJtqAP8WfBBUoMO2aK0k3kOX99Nq0sgkBwXouRiQ3la/mwaO+iF1
 CrnEEuOb+Q9dKNlGYHgKnHkQC3TeZirzvltCFx+CH+HfaeEWgWOo02f6eJPdXgEF87/EF
 khr7P8sEvFGNyJUyjYaIB+951DQbdPbyEKTIjqpLvc/2BUZPISSV+ZMiX3jlzi4AB2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cybIfiW9; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cybIfiW9
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 289CD80A5A
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:29:02 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jD6FR0PDMzMlNR;
 Mon, 26 Oct 2026 22:28:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793050139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5jXaTRzMStywT9Hc9z72oL/3X6oES0txrExXpjNReU=;
 b=cybIfiW9zhAWOR8wkipbRy/k3oaNiyX2+dDmOMByJ7bv7KzUIYZVGT8eS+sg1xKYK6lejH
 zYp88IPFY3V0Xif6djL2sVVipAXU5GULO37k084yWe1+t2ZxH0comFfYaYh0rr6NdWAzsB
 9WYmKFrT4QgrLSSkjACE/k/Ynmyhnj6yNqP8jKEdnbmU4t1lU7VJ7hpB4GPeT2O5LN/XV3
 NISK+/xxoYc3jDoVFW8o2SOMiJW3gfXp4WAU3KOflkwM1d4nEA0Yc61m0bv/U4rRTzADgQ
 H6qZQqX+hH7xRRI5X5A1szTWaC5ipQsxpL2meyeZB0vjbsyrNguQKG5RWtIVDw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] net: lwip: Split do_tftpb() into command line parser and
 loop
Date: Mon, 26 Oct 2026 22:28:27 +0100
Message-ID: <20261026212853.453191-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
References: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e035d25308a4db159c8
X-MBO-RS-META: djqkuw5ssdutq15osdqx6f1b3jos1qrf
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Split the do_tftpb() into do_tftpb() which is the command line interface
and parser of various parameters passed on command line, and do_tftpb_raw()
which is the core TFTP loop invocation. The purpose of do_tftpb_raw() is
to be called from within U-Boot, namely from the DFU TFTP code, which is
passing in custom load address, filename and timeout, and which uses the
default server IP and ports from U-Boot environment.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 include/net-common.h | 13 ++++++
 net/lwip/tftp.c      | 97 ++++++++++++++++++++++++--------------------
 2 files changed, 65 insertions(+), 45 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index f1f670dbd8b..ad777949dda 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -568,6 +568,19 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
  */
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
+/**
+ * do_tftpb_raw - Run the tftpboot from within U-Boot
+ *
+ * @laddr: Load address
+ * @fname: File name to load
+ * @server_ip: Optional server IP string, or NULL
+ * @server_port: Optional server port string, or NULL
+ * @timeout: Transfer timeout
+ * Return: 0 if OK, -ve on error
+ */
+int do_tftpb_raw(ulong laddr, char *fname, char *server_ip, char *server_port,
+		 unsigned long timeout);
+
 /**
  * wget_do_request() - sends a wget request
  *
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 1d0e95d826b..a49d5a72852 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -428,9 +428,53 @@ out:
 	return ret;
 }
 
-int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+int do_tftpb_raw(ulong laddr, char *fname, char *server_ip, char *server_port,
+		 unsigned long timeout)
 {
 	struct net_lwip_ctx net = {};
+	u16 port = TFTP_PORT;
+	ip_addr_t srvip;
+	int ret;
+
+	if (!server_ip)
+		server_ip = env_get("tftpserverip");
+	if (!server_ip)
+		server_ip = env_get("serverip");
+	if (!server_ip) {
+		log_err("error: tftpserverip/serverip has to be set\n");
+		return -EINVAL;
+	}
+
+	if (server_port)
+		port = dectoul(server_port, NULL);
+
+	if (!ipaddr_aton(server_ip, &srvip)) {
+		log_err("error: ipaddr_aton\n");
+		return -EINVAL;
+	}
+
+	if (!fname) {
+		log_err("error: no file name\n");
+		return -EINVAL;
+	}
+
+	if (!laddr) {
+		log_err("error: no load address\n");
+		return -EINVAL;
+	}
+
+	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT))
+		return -EINVAL;
+
+	ret = tftp_loop(&net, laddr, fname, srvip, port, timeout);
+
+	net_lwip_stop(&net);
+
+	return ret;
+}
+
+int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
 	int ret = CMD_RET_SUCCESS;
 	char *arg = NULL;
 	char *words[3] = { };
@@ -438,8 +482,6 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	char *server_ip = NULL;
 	char *server_port = NULL;
 	char *end;
-	ip_addr_t srvip;
-	u16 port = TFTP_PORT;
 	ulong laddr;
 	ulong addr;
 	int i;
@@ -470,8 +512,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		arg = strdup(argv[2]);
 		break;
 	default:
-		ret = CMD_RET_USAGE;
-		goto out;
+		return CMD_RET_USAGE;
 	}
 
 	if (!arg)
@@ -501,49 +542,15 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 	}
 
-	if (!server_ip)
-		server_ip = env_get("tftpserverip");
-	if (!server_ip)
-		server_ip = env_get("serverip");
-	if (!server_ip) {
-		log_err("error: tftpserverip/serverip has to be set\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
-
-	if (server_port)
-		port = dectoul(server_port, NULL);
-
-	if (!ipaddr_aton(server_ip, &srvip)) {
-		log_err("error: ipaddr_aton\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
+	ret = do_tftpb_raw(laddr, fname, server_ip, server_port, TFTP_TIMEOUT_MSECS);
 
-	if (!fname) {
-		log_err("error: no file name\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
+	if (arg != net_boot_file_name)
+		free(arg);
 
-	if (!laddr) {
-		log_err("error: no load address\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
+	if (ret)
+		return ret;
 
-	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT)) {
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
+	image_load_addr = laddr;
 
-	if (tftp_loop(&net, laddr, fname, srvip, port, TFTP_TIMEOUT_MSECS) < 0)
-		ret = CMD_RET_FAILURE;
-	else
-		image_load_addr = laddr;
-out:
-	net_lwip_stop(&net);
-	if (arg != net_boot_file_name)
-		free(arg);
 	return ret;
 }
-- 
2.53.0

