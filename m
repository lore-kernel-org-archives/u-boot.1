Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5076DC88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD4FB406A1;
	Tue, 15 Sep 2026 20:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r9QmH6xP-2-V; Tue, 15 Sep 2026 20:52:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1E1D64066D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789505541;
	b=YHU79SAgNrb0bEtMD5zt75+6xYF4O8+Jf+1jgYpEyD8+Qt9JoFIrrjXDpxzJNLvEiY5l
	 iOn4lCKfAjtX5CuUJ3o1TPTHHj6Ik417xiJJ3pz+5mebbKJq3yjNDT//p8a+mPXa+8TSb
	 84G0VvYTn4jZ1m5yEeTkkkLzguH6I71ODtD+2k/rylvVqbl4XaqaEUM6tdvWfD+f5UMZv
	 D+kydNr28WfEqUioxR1bJItMDSFMhpDdCc1HGZuoUkpXxIt5ljF8ctU6p70CSdk+iuCRV
	 sl7Ii6lmEvP46iYyX89E+yA7lIIOJJOH9uMsWGjEUT9ks+jrhCSN2PWBQ2rVAvGto2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789505541;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9y2IKlC6E3YJ7jmidfZqD5ez5tal9+JxOXhjLRRs4L8=;
	b=XOAfshf4vShF5qx0L60c98Fuou3DEweeVJ9qfDR5NuRtMrUYffMnp98qfvFIlKKOwno2
	 1ZojTf81BJGok4aJ4zc184j9tiZlv5lx+S5f+xoulKa9h3naO7hLp0RbXK8R2tJkC7Sqy
	 AcgujiYUR/suJkG6j01IG7tG6d9lf4ORVmxHzPnvNhs/4Ry3aiO9Ynb/svjGGELq7QTAL
	 a7tXb2w06f5HuGfDWVnpz0FrO6adg5cZVmGFGtfHSrjsMqn5+o5ciREOrEupwlnp5Yw1I
	 B3whR0uJAZ5HN9mBhbncuQNlzaarrKbDtSIQkCe0n8C/BagokVQfM2jWhRhV8gaWpsQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789505541;
	bh=9y2IKlC6E3YJ7jmidfZqD5ez5tal9+JxOXhjLRRs4L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sb2xPvIGcWGT8Q1L5JFgdfi1km48Fiamgk/WEpKjEPnLqLCtdFDCoMFZztXXWs9mq
	 nvKlbXBJA6OfXgZN5dVSwmzw92ahcaEMY77V7H5vBUWDy1fq45UW2z1ereWe7CrsUQ
	 x60mq6vbwWTsEj+21OYCNwGERQ78zS2tuuCZ7yt7K055pELxtPln99MYRTHSpxzhoF
	 c4LUJmC3Zkmts0UjhyglftEy2BZJrvPdOaxp0rbrs9CdTwQA7bfNYpGIKsuIrP09zK
	 Li84ahW4lujX0SDjCI1n4uT2qVdqHct4N7lxika3BiMTuRyHg6CRvhapklsN+ORk9V
	 lh3CeyxBVCtow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E1D64066D;
	Tue, 15 Sep 2026 20:52:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 35FD52E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2882040231
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yz_2v7e-hQ4C for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:52:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7817A40224
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789505538;
 b=RaFyCiqTOVeKWnPO+7SmKWeGkoZvqgsYWz4ftsmWDIrk0MVRN6/yjRV7uFb78Dnvl7gG
 6KeIP4iFbyixd5f+gWt5k5DYp+qGkETi4xHekTEiU8tpAOPg0b2iZwyL+VstJajgYOTXV
 cKBLtmLkVBKsAhoY4aBOTucRYpxm5L4ckEUQlzuB6Ga6AUNMXm9ZHJWmLUVHdeT9O3Na8
 PXbKVzPeYYJwOcPnhvMkHl8KKnYTo3pEdo/O5tYv7fgpXCmjc0uBG90R/oiWJ+KDOSzjv
 ZG9pt7hGZx+KPfsGbAa1eeqhyd71V35dKOTMhztMjGjSnPvwe5rr251TvYCgOTeOZ6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789505538;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=9y2IKlC6E3YJ7jmidfZqD5ez5tal9+JxOXhjLRRs4L8=;
 b=aGzN2pZr1f/MICxZeuBCWN2K3zJlowydeE8vX7+a9z1v9z6RdVe+QuMVl5xwQpxPIL7A
 Z850SweOyA7wsGgLnmJL183nR9ieyGIgcB4cXkDBDAT4Pc2ilE0VUP97qXkacMsxmeaSl
 s07gUnFht2NOB0XmtMTz8NRTMk2sDmU0bq1v9J4k6n4a27duktS4T69bDVMSgm3zsJrBb
 1mU4ypwhOLm98pwIdkR/s3r65koMsW730T3Xq8rVIJ190Xt8xV0NS/ykgzXr9C+mKf5OC
 nEr5FXiHdgDmmXeTxuiui+pGNXQNhWGx9r7uZ0P4vodCyUN1fPwLiRTW+lokEmEaymA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b="qI/vFM9G"; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=qI/vFM9G
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7817A40224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:18 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 81E0020B716B;
 Tue, 15 Sep 2026 13:51:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81E0020B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789505491;
 bh=9y2IKlC6E3YJ7jmidfZqD5ez5tal9+JxOXhjLRRs4L8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qI/vFM9GZBXb04DVmlyK4v8HO2ZLS9uo4+yTkgv6oocoARYhmXFn3ivkJ/pdW/lFa
 uBL69c2DikFcVsEXwcY4FZeTN64fZVCu04x+VxYZ0q6p1Bwkbfd5z6L3OMA6emCPQI
 I3YrqQ8BipcTRkCrklq6pIjmGYYCERIAKAo1avoE=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH v2 1/3] net: nfs: add bounds checks on memcpy into
 stack-allocated rpc_pkt
Date: Tue, 15 Sep 2026 13:52:08 -0700
Message-ID: <20260915205210.260404-2-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Changes in v2:
 - No change, rebased onto current master.

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

