Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471F606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rdithjN9;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=NvrTMwGi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C181780AA3;
	Mon, 26 Oct 2026 21:29:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZXcsaH8lISyW; Mon, 26 Oct 2026 21:29:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0157080A90
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050145;
	b=hnA+KipS/dYvpKGe3dRiYLBQPXUbG/1jiJ7TFvB4RMqW7gS6JTebfjlXaKEA02+gkWNN
	 KIkO0JuF7hYpqFFvIRn96CcbXfFqT+RF28bww41Qz89qJyyVMyJo8Wlu25iZ0y+Gmvyih
	 0jh2uTty8t9JezbwkepwQari99yG1ZFdUuA2UlqzN7Gcbg0t7wfwv7kWsCe77rjtRu/0I
	 Bcucp6fHYVL8XP82EGAxiFRXfhKLZ42Wwq9rHmhsVjerfcBrtxS53bGSHW159YNxBlMBz
	 dmHjv8fMYzhi68C+d6VTsgngDMcd5vCvxzB+n1XbWTUeEXkqwXMmb3w1oYYvueOR1Sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zh7ggLRF79s+9EmH0BjZKPpWn0vE735s3pKYPE4NU6c=;
	b=DMsdYDAyINIBUSqApIouHNlmUxIc4y6LdWiKr0Fn2mKoUpN5tcJwSx7tw+BEPPVdZEp1
	 53XwhDshbvSaI0NPDZh5fVueUW/tmtWe6PzLUiWNHMNgk+vXlmKHYTUkQq3tiNQQGmZ9T
	 p/f+Wn8qbmokOhd9uTuWLBgQDg8irVKKUZ7hlExhfE5RLB7TNwGzMc+lOEec66+IQ4yKA
	 w8nKnkgY5CHsB2oCH7qc22TzQlYxjig49j6V1fjy8L28z45qtL4SP3NVoRwXH+21Ac0/k
	 JDAFrUVHMCp5mQbKLH9WUFzGTseDoo0moTE/J8ofDnfvqR5lHNQAcndbjSwWnsNVloA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050145;
	bh=zh7ggLRF79s+9EmH0BjZKPpWn0vE735s3pKYPE4NU6c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rdithjN9OlOhpP+DlF67Tt/F+RlQCicJ3yzeA1IzvDCHSss6XwECMHiFcwwsALHbu
	 pxTmR/jsZCRq5wfCZ9/RCIx1btV+SL1DYpN2DeJ8gD3Nsv6t7euz/iBHznR74eNlju
	 JVUpTI21e5QGI9d6/J6+ffgZk+OzBA6VaQouZ8arV+HENBPQyiQZ4L9/414fNmXZzK
	 0W9lbTPiIoFbHSWEwVxio3u36ucevb01LtuC6VleQEp2gybbV8wa0V+UHiV5VjUvVg
	 JK5AYfYrT10hu0p+lviW9hR5u91ZvucerFmD74VDkbQK/tYsHvVdWs2Nwc0/JMeK2p
	 HsceY5tBbnCag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0157080A90;
	Mon, 26 Oct 2026 21:29:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C9B22F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7298740556
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AzW1h2v52jOv for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:29:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 23F3C4053E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050142;
 b=JjRUcs/kfkKB/8T1SX+upNAW6mGF7ba0coPSVzaoNi2l9uriNyTvMCuBhK7Ruh3fsDrm
 ZVaQXr4cRS+mj8cD2SaON3t7DV0q/XrDRlh6c94d3eUQ8k6I6MxdOerDX55qfoT/J+Eoz
 z1yR/L5Svw8BkGhtbzwepxHFMGdVA8mQMKVcW65L1sB3cKsys+vywfneZVbvRL3qRIm+X
 uSOBMmIGbrVz8j/mNEbf1w5Bb7c3LAad8ccaOwqId1ISSyIpll04zsOs6YQAbI0GdAt53
 e1RUN9ttj47SBrSI6Ufxa4kzBXSqc7UvHjH6Z0Zbh+CXDzre6Qjrvz6PR5sTOc1/Gcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050142;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-ID:X-MBO-RS-META;
 bh=zh7ggLRF79s+9EmH0BjZKPpWn0vE735s3pKYPE4NU6c=;
 b=fw6Bo15g+OK+MSJgFlOWO6P/4ZUfzj+pfx4vrwT4bJwFOZga8yya0Dt+e964HdMQ7MqR
 ngnetQTOxtc9va86UV/OHoTRywOWYyZIkVTMH5HAc3bSTeZ5gSD2caNhlFPsNoJf8E7nE
 NaZep40Uir7RzM2RD+HKExy9oSsPJKDjLohlX41dWPyRkG/RswCIcO3OlCTuWVFd6stC5
 r5cKm/calij+VieD7UNXy73KPAH/VG/aXgco6tsytZS2f/t31l6UqPOxsKhAyZMezmICn
 BYQeXo1A6fq8804WDRSNXsumIdIT/v9/pkxJu0czM8/asYIhWGjOAshaDzoy2Z5zrCw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=NvrTMwGi; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=NvrTMwGi
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23F3C4053E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:29:01 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jD6FQ1DbRzKm5l;
 Mon, 26 Oct 2026 22:28:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793050138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zh7ggLRF79s+9EmH0BjZKPpWn0vE735s3pKYPE4NU6c=;
 b=NvrTMwGiPNWHEczB9Z4KSg9DQlj5zuvfvXSHa1QG+QOCF7obIDLIQs2uFvFonzSQ4w5mqx
 FTBYhs0sVtMUYGwml5s/DbYuP2Hyo7ka3DiVxKzzEpOW6WKWTJQgxVU/2bER7fMl5V7Tt2
 srhg/0l/+koglLaGnM0xps0qpKj05/jPcbxK3meLcAaRkFWgFS9V9McQ6aLgc1gtktQVQJ
 9T/w9zkhzfIe+ZwN28qXJSjOYAfpsU93MVkYFVhdCF9iFtndJUvVBMVsVjk3DiyIsKRvbj
 CG73CgNXNZckVnqOC9TlylVqAlO4gVd9Y3J5v/ssvhmYrsg2m/P4oLSSPKWj1g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] net: lwip: Make timeout configurable outside of TFTP loop
Date: Mon, 26 Oct 2026 22:28:26 +0100
Message-ID: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 05426a76b9548038f30
X-MBO-RS-META: dcw7dytxp1wewcsafran75ejjs5skqpb
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

