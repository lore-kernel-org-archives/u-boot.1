Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E3606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SfNwl6on;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=iOBX4vzy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED1F380E49;
	Mon,  9 Nov 2026 03:27:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l6S4m9skdMHt; Mon,  9 Nov 2026 03:27:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A6D380E34
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794194831;
	b=eGgWOvl1lqvBz4uol38e7ojSw62zpZ+nB+K1WtQE3mV6TmhbFs1eF9mJhsx/HyH0lBL/
	 wr/+lI+xKdGs3+HMrztx0gUMwZ6iFjwL5Wq+hbQ7QzV1V98SxQ9okksp2NexonZlnGKdK
	 539ZhCWJVyYRwJFHJj4R6D7sLKB0dlN3vTPEo84d38GkFPPyprUwpxnOsRItQ0FNj7IMN
	 BiD3Xy9vgSL+of9wVsRHV1RBSGHMSgcaz8HEunXyl2l2nrwfF9RCt2lfxJF5KYz/PJjgz
	 4xBZSghRbbyR06zT4cFGywmSfNLTb/EoIQ/DSu3h2VYpvkuNnIW1IaBUzWv69klohvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794194831;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6/XLJ3pALHfoi10h9vxe1br/vaerp6ILZBQNI7FnaEE=;
	b=V6mKZqVxSEqw0EMxXl0zSOGjnG4NJ+hTdAm0GiEY5iaUZjrwkhBBJJbiIKT6PIE5SaMV
	 HoREi4cQcQlRWNg/OLrIdpOYaxjktXquJJx4j8UGu+8xFzxk5LkJXrNDXsm7i7jPYVTg4
	 W6UZzSYDolDCXxL4OhbIIRpa/rP+A3MGPP46kTHlcCavGmutgLYqRFeNUHzM9tUyD6eDC
	 JeeYJPiO1OMA2qbREiIpDNNCOhxEWMNnHHQ93dGqtetprue3gXUhDm65QzEfNkZ3/IzQh
	 +YYL0KR2PqFfr1x+hktxud6LNLkpxPe4ydnY7VoM0lJRtvTCYpm8ibd3jhcBHGi2nrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=iOBX4vzy;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794194831;
	bh=6/XLJ3pALHfoi10h9vxe1br/vaerp6ILZBQNI7FnaEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SfNwl6onSEuysmWV22dZud8UT4y70bAn+tda6/AjgiwHQrI/RjSIMKJdjL+wZAKqy
	 f+LgFD73zHtek7ojDTb6roipZKDOozW3J+lMsH8NeQ+npFBtX+NKTo3SvCz3gz2Yex
	 tSMI2nWXkM6SlWZNwPGvc6WlO3Q2SNXY6mYgKMlSaxoTKamcm1ANNs8q1cbjEZZWWL
	 FpZIWgDIQrODAlGLKVNPFa1rrIWJGT8br24qVqRWqEiTs9yGVo5wk2xMDaesuHK1gg
	 tqpJHE92JW4j09v8aALS0Z6VwjmtyM8hXe6PLhiToLg/CnaGhurCcxXI/qThPAh1wl
	 BUfKv6jT5gNbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A6D380E34;
	Mon,  9 Nov 2026 03:27:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A0D1235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B4C580E34
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:27:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NwKiGoFnL7MO for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 03:27:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36D6580DA4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=iOBX4vzy
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36D6580DA4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:27:07 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jNFZc5VTWzMljT;
 Mon, 09 Nov 2026 04:27:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794194824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/XLJ3pALHfoi10h9vxe1br/vaerp6ILZBQNI7FnaEE=;
 b=iOBX4vzyk4oD0A1WGtTOJEsV+Y48KJxm/a+zbvwJOHBt+6Yp7J9srt+ItmQutX0gHf3i8i
 k2RYzFOp6d1N9w2n1p2X2SpgVKJz8bZH9ehVNMflnOVN3DaFDai15sloakxM6W551ATWu7
 bse345MI2qp/VkJ5C8VoSH4f/8KYQe64eZGrDMDRpjpoj77EKQ0/0QnJigiV3PMBYrdf7W
 IoTfuEnVrW9wumfU2w+bn2547SOzNoksijZhCERSIsxhtRUZLnS/DplAddnL1XRKjEboLW
 nAgyilZAAvKcQvPP/+R210c+2u16fRmUCcwQpkoUqCG/lpwk6xfMO46HsAkktw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] net: lwip: Split do_tftpb() into command line parser
 and loop
Date: Mon,  9 Nov 2026 04:26:45 +0100
Message-ID: <20261109032700.2839970-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109032700.2839970-1-marek.vasut+renesas@mailbox.org>
References: <20261109032700.2839970-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1c24cbc1ae9ebb07873
X-MBO-RS-META: cb8wnbt7s1mejrrj58x9611mokkzoir9
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
V2: Fix return code in do_tftpb()
---
 include/net-common.h | 13 ++++++
 net/lwip/tftp.c      | 99 ++++++++++++++++++++++++--------------------
 2 files changed, 66 insertions(+), 46 deletions(-)

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
index 1d0e95d826b..97f6ca7d01a 100644
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
+	ret = do_tftpb_raw(laddr, fname, server_ip, server_port, TFTP_TIMEOUT_MSECS);
 
-	if (server_port)
-		port = dectoul(server_port, NULL);
-
-	if (!ipaddr_aton(server_ip, &srvip)) {
-		log_err("error: ipaddr_aton\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
-
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
+		return CMD_RET_FAILURE;
 
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
-	return ret;
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
-- 
2.53.0

