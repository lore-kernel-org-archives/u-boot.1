Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D13AC982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 16:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0794F8131A;
	Fri, 18 Sep 2026 16:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E7X28Z6mpMlY; Fri, 18 Sep 2026 16:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D487981312
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789749310;
	b=QWU6AZniE5Egf/HgPl4wlLFeDU37Jx9BYtDj+6+lkkMgzk5lIVPWolLShlgMuvy0240t
	 +YzHXIcHLlpTtT2ivROE+7bbybfHpLF2GTge2sIG04AGWPJEt9bGDQS4bRUNIDKu/71h7
	 SAszR0lno8k3+AtXX7orbdEi4IsymWHJhoSJOZgnm87JlPtQSCaEMhpmMlls03GtfQFrx
	 ruu08IGLsO0WHTUpxEqAeepwJ1sdzi1Z48VmPy2rIvhQdyU/0i/UUiI7CFLqlal8exQKz
	 eq+TWiILdzbVS7TAf3+OKm6WP4Oa/9YBriIq/i9mvxH7nDVcgknL4H2fYj3SOWfBURA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789749310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8eJxWW1h/LEOw98jNKCil45qn6vd4PcFsRmynrJ8bCE=;
	b=fMCIYsfMmgT4TK1TBuxQVDb0OuQCzJBAVRVimvr7O9D0imAzF85FvF4s6QoOWgVFz/Bx
	 4+4pNg3JJQZtTfbfKBANuc1bbSZzxOIDpqzeL4R1Uv8Dll42u4XsL4ybkXAP0fWTMhu06
	 LUCXf3xuccLb9GsLF31XKwh+hzGtvpaTUUiK/s+d/KDHDesDajnEM5kjwt9hUv9ogU19d
	 L9LWaFUL0W+8AJkT5pC5TDyJrdZo3wKQe9V4gcZFeKJVHldDJXUjGT39lQRIADIlyo3Hg
	 CLqhxwdOZqpDe5Iiobfs/4bg3d1L5mThyaSiPZPwfuvpYiGiVBA6miLdlA/h78LPmVw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789749310;
	bh=8eJxWW1h/LEOw98jNKCil45qn6vd4PcFsRmynrJ8bCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d+hqD3oOwPzugOEb3oHfLfdMzLtL2vEaetak6nJHUykiKSesH+3SMuR/71RoXuAUB
	 /c8QYwVGkpmCUP9vMHXn3SZLOsNqF+16a0XMy9b43LA5BvQxFEUmLZwULU7pwGzjCA
	 eK7XwEH2taOFLmhDaIkEgI8/TiskHGFjo+yY11MDfjSY7m7pCfODccfR2hqlbpgF1q
	 ihXsAdoCD1AbyOHIhzp2k/6uQtHNNgzgXk4p7dNGMK7a6sLTXs5oeHczuxd3AIsIin
	 +UOyezOTakD29vMk0FsvPUyMs7TFhqoslIhxUEWg5jSnAoSdsKK9d1/Kl311KqlETO
	 LsrnBXz4mC6XA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D487981312;
	Fri, 18 Sep 2026 16:35:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 73B5313D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64FA660D88
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0HIUxgmXA7JY for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 16:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4856F60D71
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:d548::8fad"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789749305;
 b=nEk+8nt26uiBdFWBqo1+LsbVb5zfoc5gLEsq+flamrQ+elI/Iy8006Y7eCaKBsaZNAiP
 3SXVaY/QLTKXiFOpQp8+k+5KQOpfFSpE+zdPfPMhH+5tRyICbDQ5wZUSSpBmcEsWQVwYM
 OUa8u+NJDSBQO34VzuPQ32k1AlI+cOelU4Df8nSen7kyMpUDx9lejgLzgOg0aAyEjFvBC
 stC5F+InKfXqUrKdV87D1OOEG7WfctmPhaVQXHvPCzaROe+724HcP1VFdchoKXvQwNEdL
 LyVWYAJVa+7zVaHHnYOw9DoUVjEI7wONlnzKr+8/ACQJAxzjk9LCx4pJgg0nD3RNuOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789749305;
 h=Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing;
 bh=8eJxWW1h/LEOw98jNKCil45qn6vd4PcFsRmynrJ8bCE=;
 b=KPHwV24rp15iGi2jNebX1xSUPaJZZjTrWFrjtr1sGOfVnFd4xtYFcE9yvQNzVp+MWzer
 wSB0sGBu9cJmyIHcSiMWUzy8bEhweZjVyjhCvJc8le59TCMbZtLl+S5+hAzVqLNeG9eb2
 jnNZ4MIj42ZSHl5UzmP9mduFE7lGv4gwTHxiNpzZZ34a3H8hEWpf8WnaqWN2O3vA+odC+
 6zQMkaYgvTU/bCBGAHDsZlxPXMb5BUOFcMAR5cvHni1fZlQR72Un+0WDR1Jm2u5+hMiea
 BMa/5JP6oPRPQd7WT3KeOxHfSw5fKzzcjt1c2YAHKpHuElEhmgZ9gfQlAdAQTH34ldg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=OKBhUsCH; 
 arc=none smtp.remote-ip="2001:1600:19:d548::8fad"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::8fad; helo=smtp-8fad.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=OKBhUsCH
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::8fad])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4856F60D71
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:35:03 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmdWm6xqgzrgn;
 Fri, 18 Sep 2026 18:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1789749300;
 bh=8eJxWW1h/LEOw98jNKCil45qn6vd4PcFsRmynrJ8bCE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=OKBhUsCHjLXwNpogVa4CKL/h5uKXiz1F4KW8BJlYs6DbPLAlLn3oKoMLSyR/Uk4nd
 E0o6pkOW4lUmpYzAEn6Nt/GUg8eo7awSAEmfXnq7uYeDlt1BADp6Zsk+czOIFAeDJa
 dsu+L26m3P0qoe9sgQ5ZQuCA+ziw3ipnFCmotLohAaYB+tn0x2q4986qUY58T3dnE2
 JQjhEI/TNpn/n3dwSb1XBMQo5XLn0MovhYXH5oVw+0eHvGQg+6pbi+10cITO0r2qKM
 X+JMGS5Ca8X2DDrfi++RCWSEr0PIE5v+7s0EAl1Lx4WzgqmfAziXW8yn2KUfgbLFJA
 oE/Ql1lKKLOdg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hmdWm1TTGz8Gj; Fri, 18 Sep 2026 18:35:00 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: u-boot@lists.u-boot-project.org, Pengpeng Hou <hppiscas@163.com>
Cc: Chris Morgan <macromorgan@hotmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20260906044845.27801-1-hppiscas@163.com>
References: <20260906044845.27801-1-hppiscas@163.com>
Subject: Re: [PATCH] board: anbernic: Fix the RG-DS Kconfig target guard
Message-Id: <178974930018.351239.4677585452196718198.b4-ty@b4>
Date: Fri, 18 Sep 2026 18:35:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

On Sun, 06 Sep 2026 12:48:45 +0800, Pengpeng Hou wrote:
> The RG-DS target is named TARGET_ANBERNIC_RG_DS_RK3568, but the board
> Kconfig tests the undefined TARGET_RG_DS_RK3568 symbol.  The board
> specific defaults therefore never apply.
> 
> In particular, SYS_CONFIG_NAME falls back to rk3568_common instead of
> selecting anbernic-rg-ds-rk3568.  This omits the board header which adds
> the serial and video console settings.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[1/1] board: anbernic: Fix the RG-DS Kconfig target guard
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/508732ba45b8a328e2b38e9fa02820904922e421

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

