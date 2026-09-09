Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886CAC79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CCDD607F8;
	Wed,  9 Sep 2026 20:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zZ9R6ZCbUPL6; Wed,  9 Sep 2026 20:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 854FC607FD
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788986693;
	b=GeDMfmEuDyMyhQpH05YvqKfJ+Ifjj5mz00R5Df+BWFvw/65kf35EZvoOeCa49SGU6R4j
	 BZLGI3dOwfKW54fES8i4gknwpWCFhh6Szp7Ea8rIoLnF2TD9C/7zE7HInZVK9cSZE3ESe
	 hodGFN8H/egTh46iIjnzByS0pTvhnHW0AtGNjEzWmQX7ollFxJVaB4+Yiydi83ktyRJXm
	 f+560aug73mIc7okvIYpbk21WCc6nZpd2FefLm1tWDyIA4iafSDrgw0TetwfPGvI6JuFY
	 fY4C12VzPrRVQB3Rv0GYiijBhEaQfRFuUT3CNjaekPP+pbzP3zkxGjAVxt66fY7YgiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KQk1Kpn0Rn3cChZdefNz77lsgaoifq1Xm3AaYeM4q8Q=;
	b=fsSlOuzjBI39l0Lq8Q5KBJZM2gHuTNPUSf1BdlR6KmXk0IR0O4Ggr1p4bn1z9/n8FeWF
	 YH2ppu8LEnBUmS3+NeRgrd+KVaLfVOrN6wHYV2TCSImUM6seMxOwV6WdNg7t/pGLrf15Z
	 OAJQh8RDajHF3GjYseJESgHjh2LNL4l+PE18U6+w8Zme5aN0Z4ym7zHugYPogl0EmWvy6
	 D8rKAPMhFVaOCI21voNME596/iJCxrtrmsKApKt8lB0z1m/w9GT4P7MLD1S6GUHOSacVu
	 r2cD1hdqLExu7nNEmwWAXkI03jrxmajb8G+tCrs+c1ne+y07QVjuZYxvbzrYiiVYt6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986693;
	bh=KQk1Kpn0Rn3cChZdefNz77lsgaoifq1Xm3AaYeM4q8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pRUis/FjqgcXh37ycaHCoAGv5y9JBwgk8CBIMC+pfJcZWLKeZA3wtc4iKSEDmm8WC
	 /ap73ZZPDzthkTL46P9hjMUunTw41kRssd4BZvB+tUebaTOrwP9A85MGdxA/canpy0
	 XRiW4dklx1aYT1xMbF5g7xswR785q6k26t6v0++MsciHzfyemFbhewpdovBtX4g7ma
	 rfQJBLEyCdZFkIroRBgcFiu02Y3VBKJEu2aNKLMxbsTNyM9O5SVYb46T02bD5vk02P
	 xKqP/G9k+qV3JczRcH6QehspbyV7OZIXG7CZXIvlbUz0eF3QO/+ni/BiR7p6MjJlmF
	 P8FyiE8G4/C0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 854FC607FD;
	Wed,  9 Sep 2026 20:44:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D43222FC
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B958A81858
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kyfa245UmS2l for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:20:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1AA2881854
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788981629;
 b=IW975mYkxawOzGLaeWP5Ws+cP6Ilm0PmirgsM0H6mByaJAt13L6tBcAkSGCDuQf1178x
 oXHZSQkUy4xnWrlI/UUxzirPaYGc67J2j5AZv7FPRHdYxsJxbkWcs5CmoMaVV3GtsDRtl
 wItc2NFkxv993+aKxzEInKhaf6ImhqctYrTOpH6TfFniBSbZ291gpTJ/5iuPOaODOfsEg
 Iu6BCUWmaBjT6mqs24JGN3OKGzCthtfgLhzx1124wKZzTab3TTtoOnE0sXWDQC4KdaCnd
 TLbSpzsslZBGYMuvMoPpLw4pY1iuEWkuNuTWYJkIrlJr8uOWxUZZWhusZaMdJ3qRjEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788981629;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=KQk1Kpn0Rn3cChZdefNz77lsgaoifq1Xm3AaYeM4q8Q=;
 b=UEN5EG6MU3CiiC5qmjd1pte0y28Ca+1MRdPvwUE7q22Z+saklNyupJIuI2Ihpe3R/5ud
 gzo3eXRbKC4sJGIyR6Kv6D1LxEoGRRR0u6CfhwaxOGtX8qjbFdKf62yisTuBtTxiC9VSR
 /LotK9M4saCVJYyaIe0yud8adBw/wZp9ojA4G0wnFuoCU2Z5Etjz4CkO6XE2V1fMutXux
 UEE/ipkssGpd/TbRy3VahXnF7OgU9XuXBbCnzGOEbGLYc0H2sqsuYNmvbddcyO0M+BbZ4
 mPjHeCwwvoYLYwUYPjOHoHQTIJddtj63nTRQonSGxs5gnNmTO+F2NiOZ8ScwK28mGeQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=Uq3hRxum; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux.microsoft.com
 header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default
 header.b=Uq3hRxum
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1AA2881854
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:28 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2402A20B7169;
 Wed,  9 Sep 2026 12:19:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2402A20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788981587;
 bh=KQk1Kpn0Rn3cChZdefNz77lsgaoifq1Xm3AaYeM4q8Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Uq3hRxumnPWKsQgy3V90Vx3ZMsfdt3r0wglXRZtm8mtnxzyQ3rZCuCB9as4/vu4cL
 ENhnrXHStSMzk0J+IRf+JMqBQKsmpx3b+Xw4toSfLcAuPbGXRi/pJmMBzZVm2IzU8o
 xVseeJJosw7s/oRMIdeTeLzzzc2jLuhpxLLspERY=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH 1/4] net: nfs: add bounds checks on memcpy into
 stack-allocated rpc_pkt
Date: Wed,  9 Sep 2026 12:20:13 -0700
Message-ID: <20260909192016.217183-2-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 20:44:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Drew Kluemke <ankluemk@microsoft.com>

Multiple NFS reply handlers (rpc_lookup_reply, nfs_mount_reply,
nfs_umountall_reply, nfs_lookup_reply, nfs_readlink_reply) copy network
data into a stack-allocated struct rpc_t without verifying that the UDP
payload length fits within the buffer. A malicious or malformed NFS
server response with len > sizeof(rpc_pkt) overwrites the stack frame.

Add a bounds check before each memcpy to drop oversized packets.

Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
---
 net/nfs-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index 637fcfd9bb8..226e3fe5798 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -503,6 +503,8 @@ static int rpc_lookup_reply(int prog, uchar *pkt, unsigned int len)
 {
 	struct rpc_t rpc_pkt;
 
+	if (len > sizeof(rpc_pkt.u.data))
+		return -NFS_RPC_DROP;
 	memcpy(&rpc_pkt.u.data[0], pkt, len);
 
 	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
@@ -532,6 +534,8 @@ static int nfs_mount_reply(uchar *pkt, unsigned int len)
 	struct rpc_t rpc_pkt;
 	int ret;
 
+	if (len > sizeof(rpc_pkt.u.data))
+		return -NFS_RPC_DROP;
 	memcpy(&rpc_pkt.u.data[0], pkt, len);
 
 	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
@@ -561,6 +565,8 @@ static int nfs_umountall_reply(uchar *pkt, unsigned int len)
 {
 	struct rpc_t rpc_pkt;
 
+	if (len > sizeof(rpc_pkt.u.data))
+		return -NFS_RPC_DROP;
 	memcpy(&rpc_pkt.u.data[0], pkt, len);
 
 	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
@@ -584,6 +590,8 @@ static int nfs_lookup_reply(uchar *pkt, unsigned int len)
 	struct rpc_t rpc_pkt;
 	int ret;
 
+	if (len > sizeof(rpc_pkt.u.data))
+		return -NFS_RPC_DROP;
 	memcpy(&rpc_pkt.u.data[0], pkt, len);
 
 	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
@@ -645,6 +653,8 @@ static int nfs_readlink_reply(uchar *pkt, unsigned int len)
 	int rlen;
 	int nfsv3_data_offset = 0;
 
+	if (len > sizeof(rpc_pkt))
+		return -NFS_RPC_DROP;
 	memcpy((unsigned char *)&rpc_pkt, pkt, len);
 
 	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
-- 
2.49.0

