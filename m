Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F166606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b7PTGD5A;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=DyZamodb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCF4A80FBC;
	Mon, 16 Nov 2026 16:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3OhDswa7jRWK; Mon, 16 Nov 2026 16:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A1B2C80FF3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845655;
	b=VnAZ2pyj6x9JX87m3UjIA8/MOaUxtMr+qCKGv4WICqNvCJCbRw5n45KiHyQL1d+Qe90K
	 Z5APhnybmj8yaI36ikFKLS0VwmYelFUN/r7cPdLCPEmniX0iVLKnm+jcRI7FHTQIlFNuA
	 S+B2m6G9DLBGNRMyfNVWkLdv7RafzSwXnBeS1V00K2ESJnDENCt1uAwHyBO4gry8yMwUr
	 /AIUZo4W9DgSlJEp107ozXKiMM1kMxopObXdiM4bw02jG1P7hFUOk0TJeobfMmWnbCIZ/
	 aXMrzhsZV1yuYZhlYkobk+anfJcvsAIzGGdkcJbj0mrFcP7EPBb/BjtRPOek7WSYgVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xaj9gyVbvmrbWPChJWf2CMq1DE9IqdEqTkypUaUHY+o=;
	b=rc4p1uttY6jzgZ0kUo2KMGUis/pCCoeuuV2HZKWBSGy0GCRV3KIchVQQfCMGnh9oi0Ap
	 sdoQX04hsN+NcnvACYdSBRO/UJswMrwSsVRs9hMsS+7SLY50tcjKLIp7FbGfz6P5Wzv7H
	 CtfY3DB0N3P3LPkzmw0xqXQgAXzzFwPBmcljtDa2eBmMb6pvtyiaXV+SU7NeOfraXP4Ku
	 gtiij+lXRj3ElcV9xHPUstGNzfSES9BrXp8KuE/Z7SMykIdyqy2ur0lzdmnzs0Ra7Fty0
	 KVgN/iXEVEk03O/3vOGfjN0VJMMzvUswRojEUbuLOE1O+cRZc2mEyuenbKmekxTBbdA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845655;
	bh=xaj9gyVbvmrbWPChJWf2CMq1DE9IqdEqTkypUaUHY+o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b7PTGD5Az4kaRjPpk3xkgaxnXCYR3sLm+ABODNIpPRXHXtNouaZnax5pGEpyih35V
	 +yCoVEfsygl85mWsd5odaKLgd5FLa+F5S6Z8DNyYy4XsbbAesedDn6tq3bg1V/PJOX
	 4KEd0fBkZWy89mB3zZ9i9OFbFgwjx1EyxVHIkseAeSfvZzw70tXoxQzEF6KujdDSdj
	 g6f/fp6LIy5L8/kQ+RgDiNNoOImqHApoBgt+8n+b9q5VBqq6oWICpDXpSlSsPMrr1O
	 ZLY1bKl3Xeh7CxhluEIsbJi4q3foR3ahA7BuJbZKt6hxTmQHUzeVbV7CiGO1e4XlQA
	 2ymBjxuJMJnFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1B2C80FF3;
	Mon, 16 Nov 2026 16:14:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80F95169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FB5C4078E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sQASmsJUVQug for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD646407BA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:5550::190c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::190c; helo=smtp-190c.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=DyZamodb
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::190c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD646407BA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:04 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jStGL3RnSz2SgC;
 Mon, 16 Nov 2026 17:14:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794845642;
 bh=xaj9gyVbvmrbWPChJWf2CMq1DE9IqdEqTkypUaUHY+o=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=DyZamodbjBRjZxWcKxiAeRmOHg8eA/lUNhtReQkBkFZBEmaE7/CUf7L2T74Bbhv2p
 rbjZ0++A27xt7S4tqSb0UW+rjGVBye2qB7KgqjNa5LBMl+d0vT4y9RT0H1dhCDxtIE
 cBvK9NtfW8/19hlhc+cSzz812/BIXn6/lqfC26riHBm+q1AR6GMktXwf+45KCPEsnf
 Q1LkGC099q6DeNFWx3r4jrruW9n4LFUs0gBAecxe58oVQC/dunDkadxNK4zwUlbATh
 G75cUzbyLynpzdzmXm5Jf1IKoOo9dqD0uQxKKAvWIULrSc36JkaOUp6HgPTw1v1EkD
 Fnu4GytGNXZfQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jStGK4DsTzwR4; Mon, 16 Nov 2026 17:14:01 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261111223505.158852-1-jonas@kwiboo.se>
References: <20261111223505.158852-1-jonas@kwiboo.se>
Subject: Re: [PATCH v3 0/4] rockchip: Miscellaneous RK3568 clock fixes
Message-Id: <179484564154.1840799.18363024087817076854.b4-ty@b4>
Date: Mon, 16 Nov 2026 17:14:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 22:34:59 +0000, Jonas Karlman wrote:
> This series fixes a few issues found in Rockchip RK3568 clock driver while
> working on a cleanup and refactoring series for RK35xx clock drivers.
> 
> Any refactoring has been held back for a future follow-up series.
> 
> Changes in v3:
> - Split the series into smaller series
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.04), thanks!

[1/4] clk: rockchip: rk3568: Use correct clock id for GPLL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/165874f2f3685ac6d58543c2319b7824172a7666
[2/4] clk: rockchip: rk3568: Fix PWM0 parent selection mask
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/7e8692406c1e626935f0f188a4b1e8fe4ab3f2ac
[3/4] clk: rockchip: rk3568: Use PWM0 divider shift
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/c9a36709ded881b2eab9215a4311fd84fd736795
[4/4] clk: rockchip: rk3568: Use correct PLL rate for CLK_MAC0_2TOP
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/4c6371adb24252d16c779933e20213ca615dfefc

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

