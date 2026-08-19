Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31913C5DF89
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 17:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36A2980CE8;
	Wed, 19 Aug 2026 17:03:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oCxXcFZw_dll; Wed, 19 Aug 2026 17:03:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787158982;
	bh=RsxXcnl3QUIh438a1CwXXEKdDW/dUUbuw+N2XSaJxLY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RHVute1D9BgPf2auSVRCMvJ8QLC6pOvvT3NjtmKmMQ0HxrBLGYNSFsp2mGsTejJnb
	 99VMqDFllCufkfX8xlOVE74COPytJfQmLwBUzte+Aexu0TQKPGHcbYsb1+L03+r7II
	 k8GFxtAWfE3ZDCd+wGdDwWFcO0tADtQkMPIILqlnWj2FpTKtbBPO9oFmP9XLQmXrA1
	 xLfjZonPdr0vtRg1muKhkE1L9R18EWKorBcWEljoPskinlxMHkRT0RwYj055UjX5kG
	 fnSeryH+s7waZEs/9C7jK9Vls0OxyyNs62NFoqV176fy3gCMr2/tZvXpxjadEpF+KD
	 L1qAh8XMzUNWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4ED480CCA;
	Wed, 19 Aug 2026 17:03:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F26C1EA4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 049A180A80
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z6h1Q4BV2Gu5 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 16:40:47 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=byteray.co.uk
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=qof8/N9G
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9D2280A7B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:46 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a3efa2b38aso2108569a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1787157644; x=1787762444;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RsxXcnl3QUIh438a1CwXXEKdDW/dUUbuw+N2XSaJxLY=;
 b=qof8/N9G4Tvbip3pFmoMv/XgsIxWVnG66Dd7qJX3+5OpJeQEDg6s4TPAVGR6FYq2go
 5LjJDMJ/qFh1UclNjweeUe/3IBwmIEaPT0jEEpCOhsnqLQg602Rc/glFq+WwlwWVssp+
 qoxEZdtKVsB6Sa8RpROPHDpZixkJrv5AOUD0AMIKLmvr2jBeljZfuWE0L4Iv9StAS68h
 RTKqILVpXhIaCrb62A+RNtKYktVGWuRqYKKKbPjegFrCnilnPjAmiGwlkZ24ab1yNB4s
 eG1HXtxEi+F4mnJJgb9yx0/bjmMTu860HLpPnRLBq8Fh4Hkm8P9GmFCavQ0iS9PQNqcU
 FTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787157644; x=1787762444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RsxXcnl3QUIh438a1CwXXEKdDW/dUUbuw+N2XSaJxLY=;
 b=Eo38pe6N3BsAP16lVxXOpU8Wt7DZkACe8cLch0Ai5NmLtUjEbvoEPv6E1dblE42uHJ
 wgRK/XjG6y1uyFePujjEkSC3fHa+Z5nxfoWlBvHOjtCdg4iV04BfS8Nr/YAwgiIExWz1
 3L+ufqc1TWCWjCRCazQ4kOAeItPfD47hEZmbZpOGYDTYMS0f6+zsg+xwSdLFC1GKsJUq
 s0byewGjswggPJ4jvh/KWCmcQSPCIzdEcuOvFSL3PGVfzjq4JRArM7ArVP//o9g29CYs
 EHkAU2bcbM2jtddJ/1kvDnfPZJ2D9ktO32JxuJy/mIRwCSsIpkICnLDArEE5Fp7d0DaM
 S/IA==
X-Gm-Message-State: AFuF++ma+nPo+6fRUzUKu5qhCoh4Mf3H7iv0ntj4QjTJ/CSjwDlaLK4m
 Ao1MopQ3Xi7dPBfxxmbK0AStZbOUJrAnuyrkZWbpWZMnPUDSieCIsgG7fN+xmSROjtRDjKHk9rE
 +0h8d65I=
X-Gm-Gg: AR+sD11O5cBpX1rT8b1a/ntW1I1BQrQglovBPqoBBy4Ae6MmS/p/KQFmkEI/NuN6TJ0
 /ZlJFy3H9ov7IgzbTz3wusH8eDBZyTIplXIYtIMw3r8HKLSr1A7bD9b+yB90d3alDg6mGHF3KaH
 44Cr83nefzYZr5gBKB868krK/61uPIIL4SGXY6e63AMZN2o1xvPoG5LoW7iXe3QZ9gNh+ukcUnf
 MQNdbZ/fuMVXU/V5K+x71ELrgUeI9JEimmSF/nwp613b7OJ+GJKuOnVp22nuasOeB1wzm2J2b7p
 sTLQqIHk1wNMWfH8QFS8GQJi1uHy45M8g6tZUlgn6jy53Qk/Fgw8pYEcc9oZ2NBkfG7ycBqyIl1
 +PTHagoVBTmvg/uFFRvTo074O3b5XjrA32Lv/FM5ZqWjGzVgkPclB1xE2MSuM507zUgIZGEHjVA
 8aUq2D/00zKWFghsNMbXVRR0Ll92OjaZqdo3Ae5hqy+nQZuhZ4iy9RmuP/pRmXXQbLcHIng67ry
 hYUvpwwf+6H5EtdVGN/1cd359I9VdqRH5C/txJLpTUAM6FYGcOUHp4U/dckYg==
X-Received: by 2002:a05:6402:454a:b0:699:728e:48c3 with SMTP id
 4fb4d7f45d1cf-6a4032fc5c5mr3358303a12.9.1787157644384; 
 Wed, 19 Aug 2026 09:40:44 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f003bf9bad107298ed5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:3bf9:bad1:729:8ed5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0c327asm1219822a12.8.2026.08.19.09.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:40:44 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Wed, 19 Aug 2026 18:40:25 +0200
Subject: [PATCH v3 2/3] net: nfs: bound the length of an NFS readlink reply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-nfs-oob-fix-v3-2-7f8158088b80@byteray.co.uk>
References: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
In-Reply-To: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 19 Aug 2026 17:02:59 +0000
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

nfs_readlink_reply() takes the symlink length from the server and
memcpy()s that many bytes into nfs_path_buff[]. It was kept in a signed
int and bounded with:

	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
		return -NFS_RPC_DROP;

A negative rlen makes the sum smaller than len, so the check passes; rlen
is then used as an unsigned size_t in memcpy(), and in the relative-symlink
branch pathlen + rlen also stays below the buffer size, so a length of -1
drives a memcpy() off nfs_path_buff. The bound is also measured from the
reply header rather than from the symlink data, which begins a few words
later, so a large positive length reads past the end of the received
reply.

A malicious server answers the READ with an ISDIR status to move the
client into the readlink state, then returns such a reply.

Read the length into an unsigned int, bound it against the received packet
measured from the symlink data, and check it against the destination
buffer with the subtraction ordered so it cannot wrap.

Fixes: cf3a4f1e86ec ("CVE-2019-14195: nfs: fix unbounded memcpy with unvalidated length at nfs_readlink_reply")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/nfs-common.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index 91ae7a43b8c..c8bc101cda1 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -642,7 +642,8 @@ static int nfs3_get_attributes_offset(uint32_t *data)
 static int nfs_readlink_reply(uchar *pkt, unsigned int len)
 {
 	struct rpc_t rpc_pkt;
-	int rlen;
+	u32 rlen;
+	size_t data_offset;
 	int nfsv3_data_offset = 0;
 
 	memcpy((unsigned char *)&rpc_pkt, pkt, len);
@@ -665,16 +666,20 @@ static int nfs_readlink_reply(uchar *pkt, unsigned int len)
 
 	/* new path length */
 	rlen = ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
+	data_offset = (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset] -
+		      (uchar *)&rpc_pkt;
 
-	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
+	/* reject a length that runs past the received packet */
+	if (data_offset > len || rlen > len - data_offset)
 		return -NFS_RPC_DROP;
 
 	if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) != '/') {
-		int pathlen;
+		size_t pathlen;
 
 		strcat(nfs_path, "/");
 		pathlen = strlen(nfs_path);
-		if (pathlen + rlen >= sizeof(nfs_path_buff))
+		if (pathlen >= sizeof(nfs_path_buff) ||
+		    rlen >= sizeof(nfs_path_buff) - pathlen)
 			return -NFS_RPC_DROP;
 		memcpy(nfs_path + pathlen,
 		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],

-- 
2.43.0

