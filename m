Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45A606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mWOVWH0D;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=puwkr/ch;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=wGKko+GI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9332360802;
	Wed, 21 Oct 2026 10:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uV7zOM8i-e1D; Wed, 21 Oct 2026 10:26:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C375C607F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792578407;
	b=O/V4WJhr3sFDqSBhqJ3/N2VENOpAvxBbbjM4AbmUdOVbA2s22nOJM6XLwtdfDsNrJOmh
	 5+hu9Bh/lLc1oJ/fQ7Pa6PmOXK31qFoVEMbr4cXtJqDneFjKxMkP5rHJVENf7LsrhZ4iQ
	 v/gxRpfPDvIKU7YpyfYaXVw2aj0JTxY/rrDhoge9JN8f1IT/cweN23csMkkUcqCN0fX/F
	 aJgJa+xmARoz/jie6zyO5eIIwcMnnxBZh5C1G9MGzGE0t/OUS1yzatkv+hjG1+h6kMObd
	 Aq6ZBw5wmEto0abOSuxT1mISEosi/24u3IpcmZGXQRTKwOQ5PGi8VDyoRpUo2THrXdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792578407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NOGWT83QGQEvURsiZVasOIXtwrxPhEuLDeDnWG2y3BM=;
	b=AWK5u9pP0UZCubFAuF9KWzOrjwXyKVsozCRLTkXsRJrTqkLD+m3oDR7cHco31y3jlWSO
	 3RH0tAbWthowoH6qPGDV2o5JFalSyq6lYyqj50geFgpYzkStSlzMP92CwSVnWvMNRilvz
	 iujTOmco48/WnJS2jLxwQ33O/8ODTyrQOMIwYqkelyquDlLm4/8DoXx6RG/Zm6NlqNouY
	 q5hUQdIVRoaGO4RMJS+1of8rDHdFTAGHqmuKDV5yx1+ScJGVl+dyBmzCKyS84OG6XJamT
	 h1gTHzvd6f6AlU7QN0Zg9rOPK9WrLszIkyH9jJIKvoOjVXBOiWAD+mC/60heuLRDvKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792578406;
	bh=NOGWT83QGQEvURsiZVasOIXtwrxPhEuLDeDnWG2y3BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mWOVWH0DajKfpC8lTyvsWBdx3KAPhCx8R5FizWM2BriRe1Vy2WanbBWqgUesZD4f3
	 af4epftlQvhnhem/8S1q4U3olAGcNGW5pq8wapCHPVjyEHuLoJ5p7t+oJterMeR+nO
	 Hr26WYeszTP94mMN/0K7lDzYTD4YfctneBWZ08bdP9xIaDtW4XchojUV/0iUxfAOYb
	 W+ZXpz9A7toEXohLstzKtPuSbWQ5VrAcl4DxlaEjLulPlp28OtA9j4aXRhwOUpk+fa
	 74L9TyPC5MTU/gDcmfj5jFRmUUZm1qBeDioLn1ZUu/u0F9A/wdARN6uoU8OaxdugbV
	 PehK5vSS3ystA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C375C607F2;
	Wed, 21 Oct 2026 10:26:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 34460279
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 254CC80D9C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EpEeEQviSEju for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9760280F35
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792578398;
 b=e0tE1PajWCFpmueKk1ZZrgcNi63xxSz0j3KI6t8du3094Q/3PQaHKLp5s+Tc05t4uxrd
 uilu3t4O38PCZRfEpawHII1WDAo76dj2btdXeNt0lGm4Fwy54PCftuO1Cr/hHuZ6fnqiP
 wwjJKtgGsVTkSGFvRU/75WyROc0ypNs+DACuqmE9CMXEh3XGnBJO+pNdKx2I73OdgfTwv
 PZ+/g0d+DcokM62o+JZ51al+M+n75Xd1Obbx+W8/Zs6ez6n8Wv/8tb9mnr+mp9HvqMayY
 ywY0qA1w9wZMCvXHzh0sa3VRXJFXVZ0l0i7OTzTj3MipQfLHHDzwrwznWqcmxVfG/8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792578398;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=NOGWT83QGQEvURsiZVasOIXtwrxPhEuLDeDnWG2y3BM=;
 b=T2Z/UcoDfXPXeZRo6QAMeJhWnYIskuoAQ201vjpmyx3Qr8gYvOeB3wGat3QxNG2nHzeE
 NWzFdLps9vxC4E0Tk3vLvNLAoPyuUnla3sel37TgeBSh/pyL+zNwyyaTJdgS0//xaqgPk
 LTjqjRCJ32wwytjUQir5+6+IPbzSReWH0Zg44Roodns+DSm3Me3Y6iqR+4fdpJkmU1IJI
 1NR5YItK4PAmRWqnXKCe27besVvgavXb94nLm1GPTEq8PilJA0QCBc/WBfHD88S391+IK
 2nF09Bt+I3T2QYiJhUIhPo/6O7dcGtyNZIn806fNhAO+cE7D7UXxoYXj/LXsK7gTwgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b="puwkr/ch"; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=wGKko+GI; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=puwkr/ch; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=wGKko+GI
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9760280F35
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792578390;
 x=1793183190; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=NOGWT83QGQEvURsiZVasOIXtwrxPhEuLDeDnWG2y3BM=;
 b=puwkr/chwQppi+ggW0M38QbNNSUFdhPLB5ozVsT138YCnollDb8d2KNG45XKBSio3DuHRaF0fERLE
 7xbJZaRj5E3uXLVaSIfsAYH9olEXtumFX2jhm2p9rB9LoSVH3dFfeQQszebTgAne4uXXBc4MbOroz+
 /D/fjzTJLhhnqMqgkRvLP7m7ul4N2Pgn6vjG7AgSKucvJWoL5cK+cb7C/UKAj/K2Njmo6PafBqfNqK
 bzh0bKx3C/Gg4Q5Dv+ZDFjO10i9tCX1M0x3ZprkTvw8iG8leVFS2wRnQ8lOTHRByjwpIA+42tvJhQN
 8CVxY/ZDDI/hF2baAkqmbOLxoXvA5RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792578390;
 x=1793183190; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=NOGWT83QGQEvURsiZVasOIXtwrxPhEuLDeDnWG2y3BM=;
 b=wGKko+GIjGw523nY9v3Z1rDSM6n6XbX1wzJC8/aim8WVFk8raG2K6AnY9y5PRTBuYFDXNA3fVTapQ
 LFE+os8Ag==
X-HalOne-ID: e0e80f5a-cd39-11f1-8910-33fc7c51c1c8
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-7f8e-6877-ce5b-5167.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:7f8e:6877:ce5b:5167])
 by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id e0e80f5a-cd39-11f1-8910-33fc7c51c1c8;
 Wed, 21 Oct 2026 10:26:29 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>, E Shattow <e@freeshell.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/5] lib: ecdsa: Remove outdated key lookup comments
Date: Wed, 21 Oct 2026 12:26:23 +0200
Message-ID: <20261021102626.264091-3-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
References: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The signer already uses key-name-hint to find keys in the key directory.
Remove comments that describe the old lookup behavior.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
 lib/ecdsa/ecdsa-libcrypto.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 14027d27c0c..6a020b84d6b 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -8,12 +8,6 @@
  * Deviations from behavior of RSA equivalent:
  *  - Verification uses private key. This is not technically required, but a
  *    limitation on how clumsy the openssl API is to use.
- *  - Handling of keys and key paths:
- *    - The '-K' key directory option must contain path to the key file,
- *      instead of the key directory.
- *    - No assumptions are made about the file extension of the key
- *    - The 'key-name-hint' property is only used for naming devicetree nodes,
- *      but is not used for looking up keys on the filesystem.
  *
  * Copyright (c) 2020,2021, Alexandru Gagniuc <mr.nuke.me@gmail.com>
  */
-- 
2.53.0

