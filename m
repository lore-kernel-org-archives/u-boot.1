Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27297606A32C
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iUw9vQ3s;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=thQfCGVg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8F766065A;
	Sat, 21 Nov 2026 17:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C2G97AF9VUK8; Sat, 21 Nov 2026 17:01:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2105E60653
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795280496;
	b=tApHeNrkrWkL1cNK+cHS5RWWTEb8uV51wUmTFjKSOYRH+VXXcHAzyxuoYEm6SDtS5W+t
	 hmfUs47uVxIpa7BI3egJlSFNvFn0RSK2Zi7kcMBRUFzYRxGM5nbfJAkwPVLP1LKzmk+B1
	 lzMWI5suXBSd1gN6pofODsgXSsOGrQs0GiifWrfm05LlcIL7LkdFsLtOPYbkTEEwWzL3s
	 kJ0cObZ7xaUCqIPXduUNdFhNe8eF6AAoBKi0U/7k9yhjPscxYbGs+ATnpf1J6eDfHMRO4
	 FLpEWFzlr5yc5FUEoQA1A8OrYffg60uT+16Wm0TEjdGaVqyiYmpy2CHgwDtUfJresMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795280496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qh0VBBFQSau5E54jr2EMl6FXFbS+5r1BZyYpfYm64KE=;
	b=UlbTwcijGnkGCN++E4KsjK90CiJ1DQCtsM0VwI2Ldip7ACePjExToCGMSAk0TPUy5a/r
	 fzF/XSVoixBJ5e5yQVj25lMrMtIKSsTyHdsqfrIbEqxkYJT/cpTODCUWEnbIRzlTG0HHJ
	 us8t+LiGS8U0uupLHe4l0EBopv7SNpCwq0eLv4oAbeqtW3HttBkvnoOSrW+eDkEzlLX1M
	 eUGfL3UUWx5GGmciApzqwJBEPoGUltnV2+MNJfX6XYO4oAlnXzqatRaZU6TgCPSWZ5XCO
	 kjXwLM7Ifi3EBi4J97byArgc24/veUEeMyY0iwIyg3knFu7BR30h7p5WchhHmCt0rMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795280496;
	bh=qh0VBBFQSau5E54jr2EMl6FXFbS+5r1BZyYpfYm64KE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iUw9vQ3sAPhI8D3STZ5Q0wdD28gmri245LH0xZelULhMxrDQyykKJDwMe8mFH3ux2
	 IBJxnjBQ6q4Hm63MEJ2RuyJ5miPTvZX79NbfvvpnQnvuyGhxd0krz2dnISzTW4Dc+i
	 lQylZzJMFEJlXR1mT57s7QiWbCnju1ROs+y5/t4j/uqpVsQymm7xVwFTIVwTCkMKYw
	 XY5AzyybOV9Tgm8w52n417wbIov+PW+siC3sYA5CSXCcBw8E/gYcd/2/AiUFhD5Was
	 29wx3j7tp27OIvc1Xanw3cCqzLHSrkuY4/IxYOCu0VpMTsFrROwo66RGM5LH3A7Lch
	 dLEgD61Ro6nNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2105E60653;
	Sat, 21 Nov 2026 17:01:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF1BB260
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4BEC80F56
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ogLEejNTdSrL for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 17:01:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A150B80E58
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=thQfCGVg
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A150B80E58
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:01:33 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jWz4n4cfPz8vSC;
 Sat, 21 Nov 2026 18:01:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795280489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qh0VBBFQSau5E54jr2EMl6FXFbS+5r1BZyYpfYm64KE=;
 b=thQfCGVgMHiXQueixElpdat1DOxs/q6O5zhRG3jPHqMRUbu2LoexBG/6NanO5yncJfhEan
 CsY6ijRfZE9LktXXDpHN/FcUuckLtlhric8XDV7V+/oR3XXPbubfKPfb/XFk5AdYkwwft2
 qMo5LQXRap9FSqQiWLtCiUfCjePOp38xFP7NM+lvRmo3ZMZZ/FQuEKfLy8I3dMbg/fK/aK
 PU9ESjTLjOZiwlXE7t73EDLiFqCXhmDlKAsNZBczxpOC3QNnfDpeZRgFnfLxghwDxhIZJx
 4w4Tg/KBvbfEVRxcfZU84du7rLHWZqSD2SK3K3SeA5EtQBOMpjuS7Q5+pFdMag==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] net: nfs: Reorder nfs_pkt_recv()
Date: Sat, 21 Nov 2026 18:01:14 +0100
Message-ID: <20261121170127.942522-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 90f0fb8ba28605c9655
X-MBO-RS-META: ydp4gsexuu98u1bfum3s5x36xxggu9eh
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

Slightly change the formatting of nfs_pkt_recv() in preparation
for removal of nfs_send() call from this function. No functional
change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 net/nfs-common.c | 125 +++++++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 53 deletions(-)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index ad5b9cc1f48..bf8a42d9bc6 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -781,113 +781,132 @@ void nfs_pkt_recv(uchar *pkt, unsigned int len)
 	switch (nfs_state) {
 	case STATE_PRCLOOKUP_PROG_MOUNT_REQ:
 		if (rpc_lookup_reply(PROG_MOUNT, pkt, len) == -NFS_RPC_DROP)
-			break;
+			return;
+
 		nfs_state = STATE_PRCLOOKUP_PROG_NFS_REQ;
 		nfs_send();
-		break;
+		return;
 
 	case STATE_PRCLOOKUP_PROG_NFS_REQ:
 		if (rpc_lookup_reply(PROG_NFS, pkt, len) == -NFS_RPC_DROP)
-			break;
+			return;
+
 		nfs_state = STATE_MOUNT_REQ;
 		nfs_send();
-		break;
+		return;
 
 	case STATE_MOUNT_REQ:
 		reply = nfs_mount_reply(pkt, len);
-		if (reply == -NFS_RPC_DROP) {
-			break;
-		} else if (reply == -NFS_RPC_ERR) {
+		if (reply == -NFS_RPC_DROP)
+			return;
+
+		if (reply == -NFS_RPC_ERR) {
 			puts("*** ERROR: Cannot mount\n");
 			/* just to be sure... */
 			nfs_state = STATE_UMOUNT_REQ;
 			nfs_send();
-		} else if (reply == -NFS_RPC_PROG_MISMATCH &&
-			   choosen_nfs_version != NFS_UNKOWN) {
+			return;
+		}
+
+		if (reply == -NFS_RPC_PROG_MISMATCH &&
+		    choosen_nfs_version != NFS_UNKOWN) {
 			nfs_state = STATE_MOUNT_REQ;
 			nfs_send();
-		} else {
-			nfs_state = STATE_LOOKUP_REQ;
-			nfs_send();
+			return;
 		}
-		break;
+
+		nfs_state = STATE_LOOKUP_REQ;
+		nfs_send();
+		return;
 
 	case STATE_UMOUNT_REQ:
 		reply = nfs_umountall_reply(pkt, len);
-		if (reply == -NFS_RPC_DROP) {
-			break;
-		} else if (reply == -NFS_RPC_ERR) {
+		if (reply == -NFS_RPC_DROP)
+			return;
+
+		if (reply == -NFS_RPC_ERR) {
 			debug("*** ERROR: Cannot umount\n");
 			net_set_state(NETLOOP_FAIL);
-		} else {
-			puts("\ndone\n");
-			net_set_state(nfs_download_state);
+			return;
 		}
-		break;
+
+		puts("\ndone\n");
+		net_set_state(nfs_download_state);
+		return;
 
 	case STATE_LOOKUP_REQ:
 		reply = nfs_lookup_reply(pkt, len);
-		if (reply == -NFS_RPC_DROP) {
-			break;
-		} else if (reply == -NFS_RPC_ERR) {
+		if (reply == -NFS_RPC_DROP)
+			return;
+
+		if (reply == -NFS_RPC_ERR) {
 			puts("*** ERROR: File lookup fail\n");
 			nfs_state = STATE_UMOUNT_REQ;
 			nfs_send();
-		} else if (reply == -NFS_RPC_PROG_MISMATCH &&
-			   choosen_nfs_version != NFS_UNKOWN) {
+			return;
+		}
+
+		if (reply == -NFS_RPC_PROG_MISMATCH &&
+		    choosen_nfs_version != NFS_UNKOWN) {
 			/* umount */
 			nfs_state = STATE_UMOUNT_REQ;
 			nfs_send();
 			/* And retry with another supported version */
 			nfs_state = STATE_PRCLOOKUP_PROG_MOUNT_REQ;
 			nfs_send();
-		} else {
-			nfs_state = STATE_READ_REQ;
-			nfs_offset = 0;
-			nfs_len = NFS_READ_SIZE;
-			nfs_send();
+			return;
 		}
-		break;
+
+		nfs_state = STATE_READ_REQ;
+		nfs_offset = 0;
+		nfs_len = NFS_READ_SIZE;
+		nfs_send();
+		return;
 
 	case STATE_READLINK_REQ:
 		reply = nfs_readlink_reply(pkt, len);
-		if (reply == -NFS_RPC_DROP) {
-			break;
-		} else if (reply == -NFS_RPC_ERR) {
+		if (reply == -NFS_RPC_DROP)
+			return;
+
+		if (reply == -NFS_RPC_ERR) {
 			puts("*** ERROR: Symlink fail\n");
 			nfs_state = STATE_UMOUNT_REQ;
 			nfs_send();
-		} else {
-			debug("Symlink --> %s\n", nfs_path);
-			nfs_filename = nfs_basename(nfs_path);
-			nfs_path     = nfs_dirname(nfs_path);
-
-			nfs_state = STATE_MOUNT_REQ;
-			nfs_send();
+			return;
 		}
-		break;
+
+		debug("Symlink --> %s\n", nfs_path);
+		nfs_filename = nfs_basename(nfs_path);
+		nfs_path     = nfs_dirname(nfs_path);
+		nfs_state = STATE_MOUNT_REQ;
+		nfs_send();
+		return;
 
 	case STATE_READ_REQ:
 		rlen = nfs_read_reply(pkt, len);
 		if (rlen == -NFS_RPC_DROP)
-			break;
+			return;
+
 		nfs_refresh_timeout();
 		if (rlen > 0) {
 			nfs_offset += rlen;
 			nfs_send();
-		} else if ((rlen == -NFSERR_ISDIR) || (rlen == -NFSERR_INVAL)) {
+			return;
+		}
+
+		if ((rlen == -NFSERR_ISDIR) || (rlen == -NFSERR_INVAL)) {
 			/* symbolic link */
 			nfs_state = STATE_READLINK_REQ;
 			nfs_send();
-		} else {
-			if (!rlen)
-				nfs_download_state = NETLOOP_SUCCESS;
-			if (rlen < 0)
-				debug("NFS READ error (%d)\n", rlen);
-			nfs_state = STATE_UMOUNT_REQ;
-			nfs_send();
+			return;
 		}
-		break;
+
+		if (!rlen)
+			nfs_download_state = NETLOOP_SUCCESS;
+		if (rlen < 0)
+			debug("NFS READ error (%d)\n", rlen);
+		nfs_state = STATE_UMOUNT_REQ;
+		nfs_send();
+		return;
 	}
 }
-
-- 
2.53.0

