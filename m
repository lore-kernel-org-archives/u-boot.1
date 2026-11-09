Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13985606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sc4+pxTU;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=jiXvGSYp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 920446070D;
	Mon,  9 Nov 2026 03:27:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o-L9dQ9HTAZC; Mon,  9 Nov 2026 03:27:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 321F46066E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794194833;
	b=YCYPJboejJ5ESAmqyYFPqbHflA9R4GRCJpmlJpo3Ge2nIgaXGgA2mh/mwvasZaW3OShx
	 mrnsY0GN37koF3HQMsBYjqxxDL6jFF+oGohY+U1IeRLikI2IazsTZC2y5N3NFbSJR2Bgm
	 vT7JJuguhSM3yY2mIZJayHkLHv3UeWcsphXxSzt4j1MSSh+uMuKMP4MhBXrhRhdvzB1xK
	 sEXUiA2LxYwxhtg6izhBNPyCnkDU5i/HYDlW3uQf35LbPa2xJ388Y8xj7UEuUVlFEjJMJ
	 c33LE4Z8DawycsooHRtWYDYvbapdWfNOnTOudGm9+p0naiUTkeLaxK3pGRFCdvriIcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794194833;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wgAaRfIfJxMYT1S7v77a2r3w52D3+reHfv2FCRv0OsE=;
	b=ihaWwZWk1UBJv798GMNLtwRanhXlYV0cF82s6iHt3llv6PgYgGhufI20VIYuP9GW7sso
	 dwWvyIXZHIQBdd37zkIkEP6qocmEafpMKyad0tbZ//YOh+NQRSLnvb5EqUQ77QWggPilN
	 CNNjH3FhbuFq5LX7/Pq1oxnbvIBqlYzGFS7fSkghWxG4QRqZHO4HFxniPkrhieUpJu0N7
	 iNAciG+chOaHZOvTXf4r5inrjjZxPcwiP5X+1abe8xSqqDpsMg22I6Q8wPUgOxfHELbSS
	 lKlfX8Iu1AfgMPoJrC820ev2aHee8nj89lXr5wkvw/UOupmpV2eyuC+xuTEE+7hsrQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794194833;
	bh=wgAaRfIfJxMYT1S7v77a2r3w52D3+reHfv2FCRv0OsE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sc4+pxTUr3w//2uN38AQh6hKZ4xxwgCawGAXsuPwp64RHR2kf9ruhezmmeSq8+XbQ
	 ocmztlNdXFql27DKDTYvrYf2Dg5A6uK9Q9qzXL4tr/ocBT5EHQDiqPs6Z5Ls/PdAf1
	 32tQgaW5xkjRaEanrpQmxWFVYWwbehbdb3bh94lHxUXy8uxh9rrj5cLHr3FKf32RT/
	 stThWEJ7lTZBNHM5JElbK467UJ1y2aIe9SH00LGwwK3zAqtSEgyqv5rfcjVFmUMBDF
	 dCgWESqaUr4Vn4mbU7XBIzZhzQDEHD0tPtoAVpDZJiFKB24QE5biZ5OrrSt1HYYq59
	 C1R5VIFSl9XRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 321F46066E;
	Mon,  9 Nov 2026 03:27:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73F14B6C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A31A4061A
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:27:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eauuxkls4gqf for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 03:27:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 18301405C3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=jiXvGSYp
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18301405C3
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:27:07 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jNFZb6bxGzMlRG;
 Mon, 09 Nov 2026 04:27:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794194824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wgAaRfIfJxMYT1S7v77a2r3w52D3+reHfv2FCRv0OsE=;
 b=jiXvGSYpGIm+/JnxmjPNjaHhGX4wPVu0z/xQNaPAuYLVNvtcAXcqlqONA3QKOB4X/lVCnw
 9eR3JXVLkzpzkg2tcyBpsGZ4pg2FKSA5t6EczpjS0OcM9+NtjtidOvgMgR2U7YaEuxlHkB
 iKJmfNO4AnnRw61J4tOUY0JcubiHEb9/EaFjuL+OvuB6J+8mZb3RCUUrxO/CsaAx33FfLF
 sreNyFdz6sgtQKN6KeqMiFw4gr/TTgC4md8pHVSwSw5tIFITOwNQ4DzSYcnLdx4AraD16H
 ezcSG+uYfVhzc4TgSx4ECGJJQUSVUlBpbkYngz588wMfzH+sslYvQlTyJV3lPQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/3] net: lwip: Make timeout configurable outside of TFTP
 loop
Date: Mon,  9 Nov 2026 04:26:44 +0100
Message-ID: <20261109032700.2839970-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a92cba872cee55ab881
X-MBO-RS-META: pimr3kdt1m9n9utzhnj648dbumhazs4n
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

Make timeout configurable outside of the TFTP loop invocation, and store
the timeout in TFTP context. This is a preparatory patch for porting of
the DFU TFTP to LwIP, which requires a different timeout than the LwIP
default one.

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
V2: No change
---
 net/lwip/tftp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 48c6eb7022a..1d0e95d826b 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -36,6 +36,7 @@ struct tftp_ctx {
 	ulong block_count;
 	ulong hash_count;
 	ulong start_time;
+	ulong timeout;
 	enum done_state done;
 	bool is_server;
 	bool wrq_accepted;
@@ -59,7 +60,7 @@ static void transfer_timeout(void *arg)
 static void restart_transfer_timeout(struct tftp_ctx *ctx)
 {
 	sys_untimeout(transfer_timeout, ctx);
-	sys_timeout(TFTP_TIMEOUT_MSECS, transfer_timeout, ctx);
+	sys_timeout(ctx->timeout, transfer_timeout, ctx);
 }
 
 /**
@@ -227,7 +228,7 @@ static void no_response(void *arg)
 }
 
 static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
-		     ip_addr_t srvip, uint16_t srvport)
+		     ip_addr_t srvip, uint16_t srvport, unsigned long timeout)
 {
 	int blksize = CONFIG_TFTP_BLOCKSIZE;
 	struct tftp_ctx ctx;
@@ -248,6 +249,7 @@ static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 	ctx.is_server = false;
 	ctx.wrq_accepted = false;
 	ctx.fname[0] = '\0';
+	ctx.timeout = timeout;
 
 	printf("Using %s device\n", net->dev->name);
 	printf("TFTP from server %s; our IP address is %s\n",
@@ -535,7 +537,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (tftp_loop(&net, laddr, fname, srvip, port) < 0)
+	if (tftp_loop(&net, laddr, fname, srvip, port, TFTP_TIMEOUT_MSECS) < 0)
 		ret = CMD_RET_FAILURE;
 	else
 		image_load_addr = laddr;
-- 
2.53.0

