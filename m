Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9B606A335
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pWKWLNvA;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=dDGUCm2g
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FBC080F6D;
	Sat, 21 Nov 2026 17:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UiiOciAVfb3B; Sat, 21 Nov 2026 17:01:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA34780F56
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795280497;
	b=ggBSqkbCwbjJYRYIMMnUAgkfmaFq6ou47sXFihNrMvREboFYo4umOOsnGXj1MS8T1WlS
	 5suudt1XIaVyghfx3uMk6y82tqU+RumGGcqvSUU0KfWHiULR2Zu5giHCvbwOaQ/QteqT9
	 f+MnDZZoOgR8CGIVZxCVUMcCy92rw+d45WBu6jermGBUNXuRcWuWsu4SQ5wJ6ZmZDG7i+
	 2ghnV0C6Qq4WRDmaa3uTgPWRff6e+9UdjSe4nGIF+Nlgid9PGSN7nQV1+jJUXUx32jxFU
	 nQCNp+T09OROvTFhpDKWOVAI0F5/Vg36rSU6sKwJUHsCioeMD8vEW3p7MJRiawf8I3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795280497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rwmPAehFejYoO9ukgNiwrhKZBsD6wxJ5e1FFPcpVJSM=;
	b=DpMYLAgjrc9Px0UERx2yf9Vqs8NKeh3l1W/N8nicDFuznePZghZlQnaQdhd8zyFDPgxi
	 EfEFn52gZ87wi9anuLKec4TXeWPJxWD0BcwCGPbKtm2QzEME+eVIaeO8Ujm5IiTJb23li
	 zPxK9JsGSw7aQsKWDqPIP8IbGFZgAag+e3BAYqfYi7V6wck8B4USavKWeY5HwiZxvukpA
	 gdIsCxCTU2Vjf/oUS0ZUdUvvgnRG48cWgou8QIrNJ2Lytkx4LyM4KQVUTO/7cmn4BSIVB
	 AmXrO9X33abxXQHwiHP4o/Cg6cKxzD53iJpaOs2KENp2x9v+wA1Fv7HnMDHdqV0MT7A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795280497;
	bh=rwmPAehFejYoO9ukgNiwrhKZBsD6wxJ5e1FFPcpVJSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pWKWLNvAKVBo80fe3z5YnoGBTF5GQSZtmvEC6ah/yg8kwpTxQuqTENLOETvX0Kz1U
	 xUV8gI/xX3dmCFJlSKNR+a3ta3Zsnply5l5ZXRD16edPSuWkWdfc5xyyVMg4R1Dag7
	 nhg8n+TIPHgFXu1UidCbUU5hNSTkbrfoHCPqKvxmqt3ugo1Df18i0qauCwIV1UyXNi
	 8YG8MbCT8fzJ9Kz43ZvriN4+FlrKV4We+Xn4Vw7WKSKaDVGC8rgPQvo7VklHCDLuyf
	 F2+7uuAXlGGSk3Q/QZ2OHt+J75vfHAMhloRghwoyuuNDjCc2eUeH+SjJqbAW1SoWDE
	 WH7QI5E1gPZlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA34780F56;
	Sat, 21 Nov 2026 17:01:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DE9F260
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0453A400B5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:01:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rjriYy8hgGpP for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 17:01:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E2A3E40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=dDGUCm2g
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2A3E40012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:01:33 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jWz4p3VygzKmwr;
 Sat, 21 Nov 2026 18:01:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795280490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwmPAehFejYoO9ukgNiwrhKZBsD6wxJ5e1FFPcpVJSM=;
 b=dDGUCm2gh/aHXB9a1gybFaqSpnkQAquZOOnWJ9z+r6yQ0KV4XGePZE4RjWO9xeCqJMkk1x
 fKmNiyrc2ao6FNqWrqZ83BKXvqbTe8hOlUweYHIChfT9NRmd4CWRYusuGJm5m9jS41dTiB
 O27v5eR24a5GiZygGlMNvthmwYg8qAc8qCXC+MEDCSuamefcSbc/N9G6Tamrex25R4PJHP
 bEONueS2nFinGlPp0aDbw8lGHA3HyZTx5HT1rtYJkHFLmdjGTx+fIMiJ7xV4Zbfjdw8fxS
 LPyf8FWP66qDTNe2w5l7N582IyF0USmX5/22PULuzF7/SWp9GwgE/xvaoEA7VQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] net: nfs: Remove nfs_send() calls from nfs_pkt_recv()
Date: Sat, 21 Nov 2026 18:01:15 +0100
Message-ID: <20261121170127.942522-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121170127.942522-1-marek.vasut+renesas@mailbox.org>
References: <20261121170127.942522-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ec575727b4828f946a5
X-MBO-RS-META: rpqh1pe6nw9o7gsoksu78bnxboq1rzck
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

The nfs_pkt_recv() should only update the NFS core state machine based
on the received packet, not send any response, which is important for
the NFS TCP implementation that cannot send response from LwIP .recv()
callback. Introduce nfs_pkt_recv_nosend() function, which does not do
nfs_send() and instead returns 1 in case a follow up packet should be
sent, and returns 0 otherwise. Add nfs_pkt_recv() wrapper for use by the
legacy network stack which invokes nfs_send() if nfs_pkt_recv_nosend()
returns 1.

The nfs_pkt_recv() STATE_LOOKUP_REQ state could invoke nfs_send() twice
in case of protocol mismatch, introduce new STATE_UMOUNT_RETRY_REQ state
and move into this state in case of protocol mismatch, then move the
state machine forward as usual. The STATE_UMOUNT_RETRY_REQ decays back
into STATE_UMOUNT_REQ unless a valid fallback protocol match is found.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 net/nfs-common.c | 82 +++++++++++++++++++++++++-----------------------
 net/nfs-common.h |  2 ++
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index bf8a42d9bc6..4b66536a3fd 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -431,6 +431,7 @@ void nfs_send(void)
 	case STATE_MOUNT_REQ:
 		nfs_mount_req(nfs_path);
 		break;
+	case STATE_UMOUNT_RETRY_REQ:
 	case STATE_UMOUNT_REQ:
 		nfs_umountall_req();
 		break;
@@ -773,132 +774,126 @@ static int nfs_read_reply(uchar *pkt, unsigned int len)
 	return rlen;
 }
 
-void nfs_pkt_recv(uchar *pkt, unsigned int len)
+int nfs_pkt_recv_nosend(uchar *pkt, unsigned int len)
 {
+	int local_state = nfs_state;
 	int rlen;
 	int reply;
 
+	if (nfs_state == STATE_UMOUNT_RETRY_REQ)
+		nfs_state = STATE_UMOUNT_REQ;
+
 	switch (nfs_state) {
 	case STATE_PRCLOOKUP_PROG_MOUNT_REQ:
 		if (rpc_lookup_reply(PROG_MOUNT, pkt, len) == -NFS_RPC_DROP)
-			return;
+			return 0;
 
 		nfs_state = STATE_PRCLOOKUP_PROG_NFS_REQ;
-		nfs_send();
-		return;
+		return 1;
 
 	case STATE_PRCLOOKUP_PROG_NFS_REQ:
 		if (rpc_lookup_reply(PROG_NFS, pkt, len) == -NFS_RPC_DROP)
-			return;
+			return 0;
 
 		nfs_state = STATE_MOUNT_REQ;
-		nfs_send();
-		return;
+		return 1;
 
 	case STATE_MOUNT_REQ:
 		reply = nfs_mount_reply(pkt, len);
 		if (reply == -NFS_RPC_DROP)
-			return;
+			return 0;
 
 		if (reply == -NFS_RPC_ERR) {
 			puts("*** ERROR: Cannot mount\n");
 			/* just to be sure... */
 			nfs_state = STATE_UMOUNT_REQ;
-			nfs_send();
-			return;
+			return 1;
 		}
 
 		if (reply == -NFS_RPC_PROG_MISMATCH &&
 		    choosen_nfs_version != NFS_UNKOWN) {
 			nfs_state = STATE_MOUNT_REQ;
-			nfs_send();
-			return;
+			return 1;
 		}
 
 		nfs_state = STATE_LOOKUP_REQ;
-		nfs_send();
-		return;
+		return 1;
 
 	case STATE_UMOUNT_REQ:
 		reply = nfs_umountall_reply(pkt, len);
 		if (reply == -NFS_RPC_DROP)
-			return;
+			return 0;
 
 		if (reply == -NFS_RPC_ERR) {
 			debug("*** ERROR: Cannot umount\n");
 			net_set_state(NETLOOP_FAIL);
-			return;
+			return 0;
+		}
+
+		if (local_state == STATE_UMOUNT_RETRY_REQ) {
+			nfs_state = STATE_PRCLOOKUP_PROG_MOUNT_REQ;
+			return 1;
 		}
 
 		puts("\ndone\n");
 		net_set_state(nfs_download_state);
-		return;
+		return 0;
 
 	case STATE_LOOKUP_REQ:
 		reply = nfs_lookup_reply(pkt, len);
 		if (reply == -NFS_RPC_DROP)
-			return;
+			return 0;
 
 		if (reply == -NFS_RPC_ERR) {
 			puts("*** ERROR: File lookup fail\n");
 			nfs_state = STATE_UMOUNT_REQ;
-			nfs_send();
-			return;
+			return 1;
 		}
 
 		if (reply == -NFS_RPC_PROG_MISMATCH &&
 		    choosen_nfs_version != NFS_UNKOWN) {
 			/* umount */
-			nfs_state = STATE_UMOUNT_REQ;
-			nfs_send();
-			/* And retry with another supported version */
-			nfs_state = STATE_PRCLOOKUP_PROG_MOUNT_REQ;
-			nfs_send();
-			return;
+			nfs_state = STATE_UMOUNT_RETRY_REQ;
+			return 1;
 		}
 
 		nfs_state = STATE_READ_REQ;
 		nfs_offset = 0;
 		nfs_len = NFS_READ_SIZE;
-		nfs_send();
-		return;
+		return 1;
 
 	case STATE_READLINK_REQ:
 		reply = nfs_readlink_reply(pkt, len);
 		if (reply == -NFS_RPC_DROP)
-			return;
+			return 0;
 
 		if (reply == -NFS_RPC_ERR) {
 			puts("*** ERROR: Symlink fail\n");
 			nfs_state = STATE_UMOUNT_REQ;
-			nfs_send();
-			return;
+			return 1;
 		}
 
 		debug("Symlink --> %s\n", nfs_path);
 		nfs_filename = nfs_basename(nfs_path);
 		nfs_path     = nfs_dirname(nfs_path);
 		nfs_state = STATE_MOUNT_REQ;
-		nfs_send();
-		return;
+		return 1;
 
 	case STATE_READ_REQ:
 		rlen = nfs_read_reply(pkt, len);
 		if (rlen == -NFS_RPC_DROP)
-			return;
+			return 0;
 
 		nfs_refresh_timeout();
 		if (rlen > 0) {
 			nfs_offset += rlen;
-			nfs_send();
-			return;
+			return 1;
 		}
 
 		if ((rlen == -NFSERR_ISDIR) || (rlen == -NFSERR_INVAL)) {
 			/* symbolic link */
 			nfs_state = STATE_READLINK_REQ;
-			nfs_send();
-			return;
+			return 1;
 		}
 
 		if (!rlen)
@@ -906,7 +901,14 @@ void nfs_pkt_recv(uchar *pkt, unsigned int len)
 		if (rlen < 0)
 			debug("NFS READ error (%d)\n", rlen);
 		nfs_state = STATE_UMOUNT_REQ;
-		nfs_send();
-		return;
+		return 1;
 	}
+
+	return 0;
+}
+
+void nfs_pkt_recv(uchar *pkt, unsigned int len)
+{
+	if (nfs_pkt_recv_nosend(pkt, len))
+		nfs_send();
 }
diff --git a/net/nfs-common.h b/net/nfs-common.h
index a19b98b7b1f..df8a40e2ef2 100644
--- a/net/nfs-common.h
+++ b/net/nfs-common.h
@@ -67,6 +67,7 @@ extern int nfs_state;
 #define STATE_LOOKUP_REQ		5
 #define STATE_READ_REQ			6
 #define STATE_READLINK_REQ		7
+#define STATE_UMOUNT_RETRY_REQ		8
 
 /*
  * Block size used for NFS read accesses.  A RPC reply packet (including  all
@@ -108,6 +109,7 @@ char *nfs_dirname(char *path);
 void rpc_req_common(int rpc_prog, int rpc_proc, uint32_t *data, int datalen,
 		    uchar *txbuff, int *pktlen, int *sport);
 void nfs_send(void);
+int nfs_pkt_recv_nosend(uchar *pkt, unsigned int len);
 void nfs_pkt_recv(uchar *pkt, unsigned int len);
 
 extern enum nfs_version choosen_nfs_version;
-- 
2.53.0

