Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5264EFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6060839D9;
	Mon, 27 Apr 2026 11:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="YfcyPRK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6187384120; Mon, 27 Apr 2026 11:15:42 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E823283693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1wHI3w-00036Q-Az; Mon, 27 Apr 2026 05:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=C9yT2xtYCu0N2EuUjsnAIxUD7+O75hj7hMh06lf9ZLo=; b=YfcyPRK1aw7WHVUAolWb
 xaD3yZJsRkFa/kpluEg3TnxHyFc4z3HOUROHS3vf6SvXx8eNq019B11dBVQo7eTpJaMIY5ESvgDCW
 JNGA692bc591uyZmuasW2x8ZvLniahKjvzXufcbCjhKHePqBF9JvXPWJ+YBc6uLRocrjrOxHaYb3J
 XTQFeRHIK+n0GgOnCXmK2Az+P/QS7HoO7BJkfCmlLqwg21uYiFxDW0HgoujJB0P1/KvhP6qtHysY/
 HdYrn7d5UFb7cpfZ7jy94ktzpqZ6WCAEYTqTsiiMCvbkCg1mnVzWTzzpNFiP4QY5aLbeDx6vcA44E
 4onwglODsLmi6Q==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,  Tom Rini <trini@konsulko.com>,
 Paul Barker <paul@pbarker.dev>,  Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>,  geert <geert@linux-m68k.org>,  Michael Allport
 <michael.allport.wm@renesas.com>,  Marcel Medvec
 <marcel.medvec.uj@bp.renesas.com>,  Chris Paterson
 <Chris.Paterson2@renesas.com>,  "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3] misc: Add RZG2L OTP support
In-Reply-To: <9e1786f1-2607-473e-8ed1-dc29c40ec470@mailbox.org>
References: <20260422093658.15723-1-othacehe@gnu.org>
 <c9af344e-6342-41a4-9ca3-a683691fcd52@mailbox.org>
 <TYCPR01MB11332159D47D6E4ED78598B1A862A2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <7ac4e375-859c-43a9-9cf2-fc44505e2c30@mailbox.org>
 <TYWPR01MB11343A62FB03012A458C1B1DC862A2@TYWPR01MB11343.jpnprd01.prod.outlook.com>
 <TYWPR01MB11343DA55762DB428EA42B211862A2@TYWPR01MB11343.jpnprd01.prod.outlook.com>
 <9e1786f1-2607-473e-8ed1-dc29c40ec470@mailbox.org>
Date: Mon, 27 Apr 2026 11:15:04 +0200
Message-ID: <87cxzkn4rr.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


Hello Marek,

> If you do want to expose the fuses via SMC , then the fuse region has to be
> secure only , so only TFA can access it . TFA can then decide which exact fuse
> the user can or can not read or program, on a single fuse granularity.
>
> By default, non-secure user should be able to read some select fuses (IDs),
> program no fuses. User should have the ability to expose some select fuses as
> programmable, for manufacturing purposes.
>
> Mathieu, which fuses exactly do you plan to program ?

I plan to program all fuses (enable secureboot, ROT hash, user
encryption keys) using U-Boot directly or U-Boot + TF-A during
manufacturing.

I then see two possibilities:

1. During manufacturing, use a specific TF-A that allows fusing from the
non-secure world (with SYS_SLVACCCTL7 register). Fuse directly
everything from U-Boot, using the patch under review. Then, flash the
regular, default TF-A that does not allow fusing from the non-secure
world.

2. During manufacturing, use a specific TF-A that allows, via SMC,
fusing everything from the non-secure world. Write a new U-Boot driver
that performs fusing through SMC. Use it to fuse everything from U-Boot
during manufacturing. Then, flash the regular, default TF-A that only
allows specific ID fuse read via SMC.

Both options require a specific TF-A during manufacturing. The only real
difference to me is that with option 2, we can allow ID fuse read from
U-Boot via SMC during regular use.

What do you think?

Thanks,

Mathieu
