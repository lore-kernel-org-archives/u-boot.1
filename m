Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB751CCF2D4
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 01:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71D0080F65;
	Mon, 19 Oct 2026 01:42:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e3CA9ihD0UgY; Mon, 19 Oct 2026 01:42:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D77580F42
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792374134;
	b=WtxWbgE7Xic+0I1pqnmiMPSf34E3X/cH42amo/blVa1wE6jSUhpvPuAjtbmTLDNstPfp
	 9lbQE+OEJaI9A6YyJtGL05izAJDaIxmy3e9QJQGfBoiKRlYnKC4yuD13vnmzkL77Wxcyv
	 JNoJtoZUS+bK0Ab4tJo/n2TjlCuLTxKjJhy1Ugnv6i4lfIHf7psEVKmTLxqaqCC4/Ub6d
	 1KLS0h4oTBqupvrtOrgnwMQF3FafoD3CsLG3IZeicw+GdfRKoot46bUQCbIGpo4aM+8FO
	 MfuqRttoZ4AlebCsugvZVYBUO55/ib8YoiTz82VYJrHMIMe5an2eGxGP7be+WCu0BSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792374134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JQ5E4MhyFEfO3FTpSwMoIGhdzI0JH3pMOXRrvt9EfK4=;
	b=kqaBmZc9wOfBahwQIjaFF4qDQm2Tibu09ALLRpwFvGbd+ndiKXn84i9mVDFEZpIkWtMw
	 o84gsj6LWCS7r8VTbi2ynbw6mOKf8ZDwPiAUf2I46draleZXTCFl/yeuNrh7YNUbf7lVQ
	 GaIip/3OTW2czbFqcPQrhzRUSM+ZuCK7WNf2yGJ50Ykyx4P9fEjFUyujEDJH1BmG2+jiE
	 LZqFhhcRzMiFSycDeiJoBYfjiGiZPHzlmaZ2Yy/hHwryy51O20OcnyNyt0oPNgjdI7aEY
	 qTahhmstGIreoJPpGd9cnFZ5YMJPnasN6jreT5WD7vNEJkx/65GeBwoSOKEgi20Smfw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792374134;
	bh=JQ5E4MhyFEfO3FTpSwMoIGhdzI0JH3pMOXRrvt9EfK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A++Fd/rvF4oyarungv+eeltuNXcR0xA0lS8vwWuPms2vsMPD9ZSUS/0qoIDDDNUQw
	 4eM26YubnsT951peEUzKbFepiE1AfO16z3q1/DSMiOYdKYbJWfM8AoM2WrYXQfpTey
	 JmGHGFiTVHJyDWU/Xj/vdLOPWQUcOqTOulyUk2dfG3dWppGnekWB/NsJyZLUpByvoa
	 qZnJ5Wy3aaYm4bAz4ll+Ro+qt+G5S704up9xcNe8GtouzHNt2Sd681uJ+kuRnJ8GoN
	 pYOJSsXyprxACWVhCZcqZRAfigWA4GL5Ibp+pvSzPWyd0G9PaxR8RLBxSjEH/+CxPH
	 rx6wkjJLpZF5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D77580F42;
	Mon, 19 Oct 2026 01:42:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 573542A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48E5560600
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vL1-_Xo5nMU for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 01:42:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E8AF160634
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792374131;
 b=Q6UjNM5IGx9nJeYxOFL9oy8k3Ax9EMAQFV8pOsBeL56OOfcs1F6izoEESUkOtvL/2A1+
 3INsvauXxGg+bjea7PsZgO3S9AUzELNXGSfk/MZQYsbL+2I4cp0aAJhH2Vbf7qu7cCqy4
 0bAkFi+WbajUUGOQh0aBTiwNtou4gx6ij4V6PoK/CnUntiVvAKwBDqLOfn+1aJE5dboIN
 EHCXH3o2QxfZCtd7lv20x9YWMvw/+NUDDqS0rpQmiNmJxG9UhMBogi41ULLAbFHpabbw7
 CQWFPbIqXPXWhuVwfFXKXiy6s/AH1UR/8TfIXO1vpQlGXmZht5GNbh8ROk6uMpjVikQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792374131;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=JQ5E4MhyFEfO3FTpSwMoIGhdzI0JH3pMOXRrvt9EfK4=;
 b=RGd7IRkhUSzvMp4Qycqg/Sttpkx1De/JDkYjJe9BVgExIWO28GHtehcNM4BiYXJRu2Ds
 F4trvjd9SVnhJoppZyJwcmbxxMnqXvgwo3SUeImHJ15ZzKNdGe3usB7PiNGVHQrX595w2
 PHEKFuI/0NOCmvIQYVtFS9r6Gz1owAeVQQuWgZuoC6tTiUGiUnY32Rgq/xnW/cCUcsX+F
 dYXsAiMz3JEElr7tP9U0zXF0DtaB5eU8fEDZRvQCZKUTokA6DPlbufrmkZihnHTq9Sps/
 xrvCue+xs0nTPZ4y4Q6Jj1/j1jTYvrLMvcgmLRkvp/hmxAGDcqYlY/UrjHiGTIF50Ig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=LLeaH8Iw; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=LLeaH8Iw
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8AF160634
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792374082;
 bh=JQ5E4MhyFEfO3FTpSwMoIGhdzI0JH3pMOXRrvt9EfK4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LLeaH8IwkuPcSXNgauPBkH24U19hRv7kYkRmlTnf62fPCwzHDh+N/uVu3f19MyzIo
 RYbcRCo5f0Ws0oH3boTYbIj/DkbPCnMd8KK2esF12Qmok7up3e8gWFRhH8BHUfVNRy
 oeTx5tIjOn5nBsrykANsEP+4sqrACXTwPDjUsbHPN4GW6ehQf46p+PzoTvhx41K9OJ
 TGuN2oxuIyio7AWd5R1iGKy7dziU8PuGVeIO4LBE6nvOxJaIYgijEmtablpJkfzNLZ
 gLsT+8zlC5MoOc4070kcqmkjDcF0sKiFZfkwdK+5RkMuTrXeQDnc2usieJLUUXgVuo
 skGvNfq2pHc9A==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id EDE8BB22019F;
 Mon, 19 Oct 2026 03:41:20 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 3/4] riscv: dts: spacemit: add i2c aliases on K3 Pico-ITX board
Date: Sun, 18 Oct 2026 18:40:20 -0700
Message-ID: <20261019014044.698294-4-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019014044.698294-1-e@freeshell.de>
References: <20261019014044.698294-1-e@freeshell.de>
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

From: Aurelien Jarno <aurelien@aurel32.net>

Add i2c aliases for i2c2 and i2c8 on K3 Pico-ITX board. This is useful
to keep a stable number for the /dev entries after loading the i2c-dev
module.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Link: https://patch.msgid.link/20260623204431.498700-5-aurelien@aurel32.net
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: ae4e84366b5d621171da2e9fae2b1f8bea3312b8 ]

(cherry picked from commit e1f4b93f2a556b0ae661285aa72cad07b3c65fa4)
---
 dts/upstream/src/riscv/spacemit/k3-pico-itx.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
index 143bf6f41260..309b4554d064 100644
--- a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
+++ b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
@@ -14,6 +14,8 @@
 
 	aliases {
 		ethernet0 = &eth0;
+		i2c2 = &i2c2;
+		i2c8 = &i2c8;
 		serial0 = &uart0;
 	};
 
-- 
2.53.0

