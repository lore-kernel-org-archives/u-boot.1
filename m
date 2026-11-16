Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411F606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hDi2E4uX;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=ECgfz5R2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7936C80FA9;
	Mon, 16 Nov 2026 16:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JaVvtTUKnfEp; Mon, 16 Nov 2026 16:14:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 892E280FB5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845652;
	b=hdO5LSWD5BKaWv+NO0Wbm/9zTz6APMwQ/5KHxKB/vZkIrSq/k7Yxs5WIFlBAwL1IvJNr
	 lkzjOWsgLHbcXzfvSieU9VQ0ptZJ256UHYgbFHPnfFMvhNCI0qWhxQ7bWH9yhpYjQtTUF
	 Lhj2AOfnUojq2WNlD9IDzgLKNcy8ZgoJ6MII+aYYBP/bzCRVnFjk1yGyXey7VAyaaej5m
	 0fkZLZsIqYnEmKXYQn6SyPzvU0v6o6oEjV/BZWu6lmgDExv7NpmxjjvA0m0OIAsjuhq8a
	 +eGt+11nge9t5l4JdkHVrU+hZHb6XSduOej0Jvfw0KsTrZ+N8gRHwOJREMAzMmPALSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4bNVX5IFXJRsaAGFOwvzVdUIlMezUG9fyOWq7kFs/8o=;
	b=BcDtAvBZX1UxFEiLFMFI1UNrETJMvldRxL/tztlbyxvQJDwYlk3tTW1wV6B/8JsUckem
	 /WeA2OzsyBG+aZz/hry096QUJYmnu2uiJudxoRJ4MyDKzdyx9g8jn6Qq51AqeIueyBbuw
	 mSld/829G1FFELbcW+0YfC7qBeb1Msmsy98wF2BXJh6NRr3oOUskaPRtRfNtVUQWxAi4F
	 /4dkAKGDRI9viIW5KCms+i5icPoMSTTN2kOdTbniXVpep8D3mI14zjFF+5Fr2qVlkGzdb
	 bPq66oL3szrijsx0YX/oDupTAHe4OeaMvidIdhM6MIciibpW9nLSXPqBy2e0xuHkErQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=ECgfz5R2;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845652;
	bh=4bNVX5IFXJRsaAGFOwvzVdUIlMezUG9fyOWq7kFs/8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hDi2E4uXd75WtGXob5lUJP9TPgV0TUJ2AE7KrV16j0um5mwoJE36955OYXIKBIppl
	 l0faV6DPkG5TDWXU+NwmAQgrPDlEEBTo+hCBoJCDCN5XaB6m2ejmDalXXbOxl12c6M
	 R3c79aAnXEJGzW9nBxYjjBVm65SJld/k2H+2TV1zaFd+1ibJ2NcsQZH7C+aoRG8aCq
	 TFUuseNWpa6Ctt+aSG7Z4Oeqkr+weg5ymqdWdpevydb1fD6eEh3fgXAx1nstrMbsE5
	 YwLmJksOaYvPCIOvdCqdGtyL3Ok2IpAdSXr0TE3Gk09RPQYpD8Ccfqj7+eGMHxg+88
	 tWODBN6s53VhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 892E280FB5;
	Mon, 16 Nov 2026 16:14:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28BB6260
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D93D80D5C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id snQnQAfNn-9n for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED82C80D10
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.125.25.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.12;
 helo=smtp-190c.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=ECgfz5R2
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED82C80D10
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:05 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jStGM2dLrz2TnK;
 Mon, 16 Nov 2026 17:14:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794845643;
 bh=4bNVX5IFXJRsaAGFOwvzVdUIlMezUG9fyOWq7kFs/8o=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ECgfz5R2z4BgyywVjqmnTW3nJl+wu9jgrSV5tZo9RKSz3qlMihOvZj5uqtAwxrHc/
 +Yeoi5A5/UqM8PLdTGK0U45iO2i09dUY8l5Nq59AmWnTGZymahjMGNvud1tD7DanOS
 ud/1Af9x6owfzwd2hhHhE0oe8lfBmZjJVo1LYmt3jIGl2cFC4csD4nBa3xTxmG3hDw
 LiJywoYM+NMhS9OdtaTGiWPp052DMbwgtoqW5B10udNbWpB1ciTxR4KpEtwMP6xAMO
 fp4oNhm07AzXbGmwzy7SpxxuJoU1GG8UkCC7yNQL8THvhMQ7k3TFQp462BQ5d/y5Ty
 9nLYD5ikCoidQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jStGL2wXbzyKb; Mon, 16 Nov 2026 17:14:02 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261115195600.119868-1-jonas@kwiboo.se>
References: <20261115195600.119868-1-jonas@kwiboo.se>
Subject: Re: [PATCH v4 0/6] rockchip: Miscellaneous PLL handling fixes
Message-Id: <179484564238.1840799.13826490336018564527.b4-ty@b4>
Date: Mon, 16 Nov 2026 17:14:02 +0100
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

On Sun, 15 Nov 2026 19:55:52 +0000, Jonas Karlman wrote:
> This series fixes a few issues found in Rockchip PLL handling while
> working on a cleanup and refactoring series for RK35xx clock drivers.
> 
> The 'special pll handling' should ideally be moved into clk_rk3588
> driver, something that can be done in a future follow-up series.
> 
> Similarly, any refactoring has been held back for a future follow-up
> series.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.04), thanks!

[1/6] clk: rockchip: pll: Fix fractional PLL rate calculation
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/63fd00abafbc2eb70234142e175da0de3ed9781c
[2/6] clk: rockchip: pll: Fix automatic PLL fractional parameter calculation
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/ea665bde5f020e33cb2768e6e0cbcf241d9f7085
[3/6] clk: rockchip: pll: Always write the dsmpd flag
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/1a50ae37147a39e4cb349a278b6483f802d5604b
[4/6] clk: rockchip: pll: Always write the k parameter
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/070ecf61ab41dd45961e758f00b04e8365ca77ec
[5/6] clk: rockchip: pll: Use PLL_FIXED_MODE flag on RK3588/RK3576 PPLL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/464ab6457bafce42bbca156ddfdf35c5eeac4a5f
[6/6] clk: rockchip: pll: Limit special rk3588_pll handling to RK3588
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/5335515b2b53ad13e1c80637a552afb1dcd50b5b

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

