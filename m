Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E3606A32E
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cqAsGoKp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoJ2pTRo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8D9740740;
	Wed, 11 Nov 2026 11:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgjz_swow6Jr; Wed, 11 Nov 2026 11:01:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43418405A2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794394879;
	b=Cw8XSKmkDxhSzMUFmhL3vJK+jArqpEGL2Sn5jhCt5sRjCE24/7VtvwAtR0FYwxFlbMC4
	 7EXRm+Zo3ahcfQowLtaw1C/qrmsseG6yvAh75exip7u+hmiCWvBWqba4aO7YIt32UBRJI
	 HSJZ4CIyDNxRBOnbtABaINd7yhDu0Jgp6eueMUTNZJyQ33+HDUfa7BFpLcPjw8EFLSjfq
	 FwzGZrkoiWAgVD7F4pqeTqg/Y334UCMbc9pm860AejhwNe9YU8L/SwBi2KZ1REqLwQxty
	 La9ssVK2a9jxmXEVgmn2aGFYEcVDIHlP92bzdll9XXAzlDvgS7p65gymvsOBu54hiGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oWEv3/FILYZi6/++GVaIpWTCVYrJEiI9zJtA94CIKww=;
	b=QmklBvzaucdyYjQCwf+UGyu08i3VTv7Dibf/aAB33t/TaWNVMz36xLqUOUnkBc+uddrz
	 SWnT7FCuR6yllQabkh9FXycLs7OrWyuPZELqatfnBLKAwcpVPp2lYWmQSxcX7w7AApAh8
	 ZZ+sxcl/64NWY86s029T2HnwZGzQD/72hvziezV8EeYpoe7mBuIPcz8fp1epsV2RzDMdQ
	 bCWQcGMeRZ1Pv2gwQimqHp3YBtEffkQugVabO3XNCepEdEZcLIbU1TafHOBprErcoOQfz
	 E0fKOi4/5JhNdVeXUJxF7rP65uq+hDJPO2iU+/q8dJk0Liiid5yTdQkpnjSYly+2JrA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794394879;
	bh=oWEv3/FILYZi6/++GVaIpWTCVYrJEiI9zJtA94CIKww=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cqAsGoKp1C6GFUAwk49f6Kh9aGG3fAwOlWoZw0ytn9GSBmscD3eN/gWMPf9lgP1Eq
	 tuwU30DpP2CDsu81VS/6nAq7her6b5+tBNbgQEV6URy5tenf3km+4sFxwZzCcKscT2
	 hhG95/zBUshKg7H3TBAWyESRsS6++Js2ulMCOOOtzrtN121QMb5vq7C/ISsH2WkobV
	 qon7ceYqnCNe7B/BBWoylKlP9ARouURvd+Ks5NisL2Sex2RuaOOZyuzTaSIEL5eAAP
	 cV6akwy4T6ebHnLiuVyKSXU9YRbct2JzKqrbUOC+VZOFibxF6Ey1+4pDAxbAW00XAe
	 ZJpofAxRMTJHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43418405A2;
	Wed, 11 Nov 2026 11:01:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0351228C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD75C812C4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:01:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pvIuTUTnKjxl for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 11:01:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B5A9811BB
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HoJ2pTRo
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B5A9811BB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:01:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8474A44E81;
 Wed, 11 Nov 2026 11:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080DD1F00A06;
 Wed, 11 Nov 2026 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794394876;
 bh=oWEv3/FILYZi6/++GVaIpWTCVYrJEiI9zJtA94CIKww=;
 h=From:Date:Subject:To:Cc;
 b=HoJ2pTRoEj8qR7Vc4slCivL14ZYHhduuBtM6Myek9wrjJs6v/DFbaUh1b4JI7gGVi
 cROf/okLNxvj9EOTDd/xLqy/xm8UdRdMMMZp4jrEfhN/V+Ko4LrSyctPkJGCAFlnuX
 CBTlx5vW34C9bnLCCaAejxdX9/pvMSwb924VGySofl/zy1u9XMpDZEN8CZbKLEZd1k
 pezlcy8ynA91c3ucbbpVPMqUrEdArtngW8yDRhgrEKLYvSqGjbgSQmUBA15u7pVvCw
 T/Cm6T/C8SLWEQBsO3qkgH7+43wE7OuwA2h6ySqg0Y60QdQulMuFBa/aI7b2VAhJiG
 80q1eLkbvLB5w==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 11 Nov 2026 11:01:09 +0000
Subject: [PATCH] MAINTAINERS: spacemit: k1: drop Huan Zhou
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-01-maintainer-spacemit-k1-v1-1-2b3de5f34954@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1Jm7UBSqBWvIi5i8qOjNJZMFKH07
 h31w1+8xXsLKapA6dgtVPEWlWcx8LuO4i2UK1iSMfWu33sbO89TkNLsqKxziJik8cNzPKQhuxF
 5TIHMnyuyfH7t0/nP+rrcEds3SOu6AY+yt1Z9AAAA
X-Change-ID: 20261111-01-maintainer-spacemit-k1-c8d5f07ef7da
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=dlan@kernel.org;
 h=from:subject:message-id; bh=Ld7X3nNtK6iA+2czuFSXy0071oSZxi9DlRbNpAyE86Q=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq9Er3Qqvnr3+VZXDDFQ/1HsA5h14Z12t0CxpMm
 AnkNQL8CzmJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCavRK9xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1Xbw//V6rmkCYWzQaGHoB4KbJnrzh5NU4LLLQ/I51Aociqj19KvNGnMvGGo
 cQJ1PFVt5IqQPbILXQG8Iij3OdPWrIFkKxwJLpWXaahK0pteyqyR6cxaXxlsUyTpkHgoewvQNa0
 k+A7veTIBNq9V/kFPADch2xhi2XBEj7X1Wpic5cCKf8Tad5fbVEFQsYS9Oox+BOfQS2v2Z6gk5S
 v20VvRAlSbOwMLzMS7nZhZUfKbe3ItV6FFKZsytc3FRK9XwPUl3ua2iMhr9/DczZL5WOuzt1QxF
 NGhXVD0U8YMIIlQdMjenj2qZjD23CG+efUsIbcrtrjjS9TY0PAtt4vQe7FT6tTMvyNnfdrdeQi0
 vqxfjDDXNDN3JiuCR2O7/H0Yhm8y3E4ZEU93FQ093xVHm01AVANYjwY7SuA9aPN8AY4DaitJWDA
 ryaMZovxyMowBAlCYyDi+/JcxDNFMJUbK1jbEvcjkrKBK3QFr8QzMqSfXxYRrKfw34D1hIm3tLA
 xZ5eLnFHYSmpaC6Zgktye4CLBwlSRplMQtq3fwBf/G+ROygM6FBYpOji2Xr7Ry/CJIV/3kyxmCI
 s5BzyNy1hbxBosLHBOdBRAbCTRCTRG1p3lK/exlJExBgE9vyRgBklbUyOypeQIvjI7mhRP/rCgv
 emwL98DsQaTacGW5qVObB6OzDKMCGk=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Have talked to Huan Zhou offline, he was not active to review
patches for K1 and wont contribute in the future, so adjust the
entry to reflect the status.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 board/spacemit/k1/MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index c1d6b8f3a1c..93a5aa6677a 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,5 +1,4 @@
 BananaPi F3
-M:	Huan Zhou <pericycle.cc@gmail.com>
 M:	Eric Chung <eric.chung@riscstar.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained

---
base-commit: 8ea02c99391d2d922810065206721ead2863f075
change-id: 20261111-01-maintainer-spacemit-k1-c8d5f07ef7da

Best regards,
--  
Yixun Lan <dlan@kernel.org>

