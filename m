Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE63CC5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7136360B20;
	Thu, 13 Aug 2026 15:57:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aSjCHNxIGNAM; Thu, 13 Aug 2026 15:57:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0367760B2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636633;
	bh=IFZnDsHHJCw1lCvnKanViQrhxETLqqHElF9MbUP0TQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OWmp5Rpy7qcKpg7R7TL+lTtgUMgXJzUreGG3IMuQ4ijce30547by53Lr7dLX27t3q
	 T67AmipCqaOVooaw8ST+MMhVsAP4/8cArpZF1tzXyT8OAxDjpH/0bvIVrKyXZPvVLN
	 F34aYJUk0SdKtjfrTyEP0fWtl2HNpsVhvRaucJQjlypx02rxosQpMOBkR5YqtK7foU
	 AxFx28UHoOlg71snxKUC7xXablYYdhPcv+gZrfd76Gw0Jf8DTl9qwKwL6NwszLxyrb
	 GfGjmL+Rs0UIPTZEGTBWbl7JQCh2+OzFtA8Ei2csG6K/IJUfhWvuzTvKowmQd41Ogp
	 ScIX/L34SO3WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0367760B2C;
	Thu, 13 Aug 2026 15:57:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C2F53259
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A990640158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tFwmveDx0eVg for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:48:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C76C540133
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C76C540133
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C76C540133
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:54 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1fbe461f59so9744766b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636133; x=1787240933;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IFZnDsHHJCw1lCvnKanViQrhxETLqqHElF9MbUP0TQ4=;
 b=moqQIvnh6D+n+dzYODBwYPB3gcxEPy/JCJBlZkoaRwwY6UzRYOojh2JarI+otgJN4v
 c0SrRmE/yDQCOMWiiXDbaa3+u9WU7LPQL1LAyLy9saCu61v0Wn4gE7X8SiRqQb+utD++
 BFiICNfrQ2TNYXtGy1UTaWVYfkQBsZ/It5K4Ag/pi3q9KZhbQ9m5GsCy3ZpdD9IJPbjw
 A4vThxamjXrvFdLDx1YtU2MY/x5R7j8T9E7K7sO1OiYG/fd7BDgmjuum9x2Tf6Vf5wcF
 U8CZzRFLYY71TljSdsGzy+qKopCpjvBD8b8fU2WoiEw0+CJNxx9k9rzgw6pkgZ8nkHPX
 M24A==
X-Gm-Message-State: AOJu0Yxfo5ov3w6YFjEpNwUljEx+Rqxa8XCzEZWK8yDtujMrcvLzU++I
 JDyUdUMZhoORGw8rI8fi8EPObX0yPeH8fGEjH8+zwDzi/K84DH3sQBxALr4eunEXQ4s=
X-Gm-Gg: AR+sD13ck9hzN3XwU0gTLoV7jgS63IkUi2w9u3YuzZLwng0iB89eKK+/8epXQfP/+lA
 FeONfcMbwJ0IfsC3tCbMTpyCSbKD7eXsWCurRaaGJznuYOALSmrt9hBSbwP1Bx6RWTqmYW4ttrz
 hPHs3Ofyx0Oi5nmomL8mbrKsqYoeh1uh80MC5bzalrAURiGA6B/K2tss4EOP0qUXuOJqTP++67T
 QT4Qh+ooaVc4w4zMlx2IddwFsK6SA4vCveNitflOXg0uoMydviJTTJMATkOOO2U9OQerxgOaRZN
 DAEIBo8khiJ45kpa2aFiKDa8+cKBe9by0Cv3YudDiC3KXAzm1h8uSoxxrLnXY58cW0EEbmo8JGh
 FZZxlpdy7YtJ5XBlP4VPB50EHEFUelICyPtogdsTJErEjCzWEmgFbg4lz+Rl6xRz66gxY5QQz97
 j8tyggoDgPxeKUkXMaN7HRok2GXdm2NSumRZaf03UPHHXwk9iaUQvfEONkJCGzSjz1Gpvwdh7wv
 o2f8guVmfiCY/mA6hMhTViSQ6UNzgRqR7DpwQushpyXqXdXlwBM
X-Received: by 2002:a17:907:728c:b0:c20:af9d:4546 with SMTP id
 a640c23a62f3a-c2108fb4ef8mr314882666b.17.1786636132533; 
 Thu, 13 Aug 2026 08:48:52 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c212378d8d9sm8151066b.40.2026.08.13.08.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:48:52 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Thu, 13 Aug 2026 17:48:22 +0200
Subject: [PATCH v2 2/3] net: nfs: reject a negative or oversized readlink
 length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nfs-oob-fix-v2-2-80993770518e@byteray.co.uk>
References: <20260813-nfs-oob-fix-v2-0-80993770518e@byteray.co.uk>
In-Reply-To: <20260813-nfs-oob-fix-v2-0-80993770518e@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 15:57:08 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786636133; x=1787240933;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IFZnDsHHJCw1lCvnKanViQrhxETLqqHElF9MbUP0TQ4=;
 b=t4ewELcWhxOC7SblHIra6BfiXUlHQdLF25GdISo3TmjuvOMUaHzSiAWIKbsiWfLO+m
 OY3pKjHMu2eUQlxI1SfouVvVTA6R9SW+GFrTpEO4icRRVFuP34ttT7dJmCa9uWmlEcNW
 uYg3U5TWeUWWesuvuasSbkjvtfMtrgPydwoymx9JsM+WfkMoPB2OGlAmnDAAo9+qAgzh
 lP7+lZn2tYRGz0keaYQEncmYmb7PkmKo+WJPstWXwxuTiYh5Z5yRlGIm88Prq8JvjhHb
 +T1eEUcuqgnOhmP8poba4aEH2cY4DUsMbKsj7gWyrdlcE1pDNeCTmVWK8Nha7ae7eiMT
 cJ7A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=t4ewELcW
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

nfs_readlink_reply() reads the symlink length from the server into a signed
int rlen and bounds it with

	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
		return -NFS_RPC_DROP;

This misses two cases. A negative rlen makes the sum smaller than len, so the
check passes; rlen is then used as an unsigned size_t in memcpy(), and in the
relative-symlink branch pathlen + rlen also stays below the buffer size, so a
length of -1 drives a memcpy() off nfs_path_buff. The bound is also measured
from the reply header rather than from the symlink data, which begins a few
words later, so a large positive rlen reads past the end of the received
reply.

A malicious server answers the READ with an ISDIR status to move the client
into the readlink state, then returns such a reply.

Reject a negative length and measure the bound from the symlink data.

Fixes: cf3a4f1e86ec ("CVE-2019-14195: nfs: fix unbounded memcpy with unvalidated length at nfs_readlink_reply")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/nfs-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index 020b0185ad1..6a536cd5229 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -666,7 +666,10 @@ static int nfs_readlink_reply(uchar *pkt, unsigned int len)
 	/* new path length */
 	rlen = ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
 
-	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
+	/* reject a negative length or one that runs past the packet */
+	if (rlen < 0 ||
+	    ((uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset] -
+	     (uchar *)&rpc_pkt + rlen) > len)
 		return -NFS_RPC_DROP;
 
 	if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) != '/') {

-- 
2.43.0

