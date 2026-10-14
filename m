Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F903CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D03380D96;
	Wed, 14 Oct 2026 08:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s90UwkeYEMiP; Wed, 14 Oct 2026 08:39:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7014680A92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967151;
	b=HTGMwjrjgktS3VCn5jUH+eX30FCAxp6MSHtjQnwLPnF6r9HRAyrm0Ko3NQhNLnCERxyu
	 I42KD5VJcmX7HfQywxA9Bz0jCV7kjhHQuW8ia0YV+pRfcHx+mpn9E5b3jQLSKw5DySiro
	 pQaxV78JtEWrCokPe+Mjdf1rqLqxJcF5uw2HWB9ZaFs5TGJWXP/9JjLkDcYB4OhzwX491
	 pXXa/ak8hqRp3LJMpiv52TVRI0nBeHQViyuWJteGNej7+LXeLjfS1fX66ChQtvgQm9zh0
	 IQ9HLIjV6tMVNaX2Ujg5OgR2s4ikRE5jJuSUpx3joYuaJYWTzut36JtTwH5qKBuBgFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967151;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QRy+m3wjyIt7HsLCTC1P6/YIdkDUd+B6HfPEH9Q3Iws=;
	b=qy4SWBJjuAZKNL63j7TDpO+IkP+8EnK1b4VXFKUes+JCg7GkhWzbgYI/Gc3ZnDQGWol9
	 iuBv4RQs+pibk88fnBO3MWnhmkKKVa5iUqaDpZ77zwk9cVDaYO1WrzI10/Zwv1bax+Wl2
	 UmrztjQBtjc5bBSpbJxym/is7Y3vb5cK9BQpeUC/ViCgwoRGG7CxfBw3xrF0VRiPbcWZs
	 OKlEyBWjeAMyQbBe4KjaWxkdiEavILzGG+uJx+WYOqKCPWBLVkbWVcS9gGvNYHj3IB8xR
	 Bj4r9BgY/vQozbnr7ifGGu29LqSHL2U2dOvVlDFsXuqzAaUQfxAAFYKS52uiu10Pv+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967151;
	bh=QRy+m3wjyIt7HsLCTC1P6/YIdkDUd+B6HfPEH9Q3Iws=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nqyp0cjgK7pYzkRhX3M06y9m2H4hG1NuR4ALADFSeMWHqj7kg9r/qf2b7xj3CVS3N
	 ETdkUGVoxOI7lj4lhpnYqE6ivRf4wFcEDH0dfmCbvAPtIUIwmSaE+LN6wLyp9neGB3
	 LLv8SO68SkoaNDZFINaou09HECdXpfTh5yS8H44r31ZuQZK7BEJj58l7svBUSNEw8C
	 6JYU5JPLOiIqj2Y10UmMGwbPMOGY1BUNoevA1VbVloZlJrz/eXEZoM6nkFXeUn+s3E
	 ExImMtCAdmHoP/qYLY6SUm9rGrEpyZAzoQ7zEFtx7KooAzB7oljBHfzBlh7cHxEOBw
	 mZUPnLJeIaP+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7014680A92;
	Wed, 14 Oct 2026 08:39:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7157375
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EF3A406DF
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wfFLYuRW137 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:39:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9B0ED406C3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967149;
 b=WY25DEgGOvzZr963HozVow1R6ZRNBVcK3Y2AbgQcX96l5T6vpOEAn1fI92uzPj5gRs8d
 6LZ99W59JAA3efafmaQ8ewTsG3xQPwg4ExU8CRI11VT68yK5rHn3SQ4X8HaFWxUxAurtN
 4WpTqb7igeRdL4aCYkEMf1RXDn/gtOsNQhW9GGBFhFmVPywN3x5xPtdxlGhoQN/FkBVan
 /pdsuj38o48EEGEw/HKfyvq5yyLZxe5jbfZwAYO5i9hygPkBpQ//1bXTfrwANg7zpyW+Q
 Y5yWk5FljT3cv0D0YtkD7Z3w16cgMuMju3YRhrRvM25WAtrDNwqlqb2rEu4NOLgOKGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967149;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=QRy+m3wjyIt7HsLCTC1P6/YIdkDUd+B6HfPEH9Q3Iws=;
 b=V0iU+9HD+WELeYYfhnOIBQwSkR3BmDaTFolNzCxW3yryYOhMGZaWeYu84/OaJwCxhMoK
 h/K61K4TSdtzrutAartUmu9yciBLn4u4B5s+UyXsyveb+F8Qbg6qLeUMXxfls08FYKI/l
 gBrPbRs1UMAMgS15J13V6prncV5oqTa1SRUzzUJaPaJXVwTNB0pM4NjTtQTwB67WJLneI
 jkBb/CTpByobyX8iM8eRuW027Ah3CgALbFWlUCf6MKSBUxABzTZsyoduJnfZWHSskDxLb
 ReQFhGL7vpzphfjvGv4qd14x1D70Y+GNGMmKKGfaBCaOaK0aG04N5eILT2B0T8NNS4A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B0ED406C3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:09 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuVt-000000005bM-3hUm;
 Wed, 14 Oct 2026 08:39:05 +0000
Date: Wed, 14 Oct 2026 09:39:03 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 03/11] boot: imagemap: correct the lookup guard rationale
Message-ID: <776dacf4f1e0120c0fa12f81126733024591bb60.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
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

The comment on imagemap_lookup() attributes the need for its second
guard to ulong and loff_t sharing a rank on LP64. loff_t is a signed
long long on every target U-Boot builds for, so it never shares a rank
with ulong on ILP32, and the guard is needed regardless: the comparison
is against an unsigned @size, so an underflowing subtraction makes any
range look like it fits.

State the actual reason.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/imagemap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index b004aa1644b..e7222d58c93 100644
--- a/boot/imagemap.c
+++ b/boot/imagemap.c
@@ -72,10 +72,10 @@ void *imagemap_lookup(struct udevice *dev, loff_t img_offset, ulong size)
 		 *
 		 *  2) img_offset - r->img_offset <= r->size
 		 *     The offset into the region does not exceed the
-		 *     region size.  This guard is essential: without it,
-		 *     the subtraction in (3) wraps to a huge value on
-		 *     LP64 where ulong and loff_t have the same rank
-		 *     and the arithmetic is performed as unsigned.
+		 *     region size.  This guard is essential: @size is
+		 *     unsigned, so without it the subtraction in (3)
+		 *     wraps to a huge value and every range appears to
+		 *     fit.
 		 *
 		 *  3) size <= r->size - (img_offset - r->img_offset)
 		 *     The requested range fits in the remaining space.
-- 
2.56.0
