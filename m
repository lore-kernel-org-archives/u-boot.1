Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1810ACA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 16:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3A626080A;
	Wed,  7 Oct 2026 16:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mdDoIJLx-hu6; Wed,  7 Oct 2026 16:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E3D85607E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791392317;
	b=CZXT/d5XvElPEQXQ01QEe/9sfW72BGgGFRbX15y9+W3koE+JUVRJs8nJuLrInkygl2ZN
	 jkRZF/CYFLyHrF53ycXyoboA1zkU3xMygjooB20IabLAudN3lqx3Rb8clw2O26KMzUz3q
	 NHogbzvpJGq7w8gCzKgd7gGTQ/z7C05gnMYjSFhW2IjMkw2TMVfdBJmUBtLlBED7/rebH
	 3hhuQl9e43pGJo0amJFLPVRcMg/1cyL637Shnbt/ngBlIy7xjs2FNn2oAhF6CoA7IFH+n
	 MKzhTeN33q878ox/HAw4iSr2PMWmqCY2pfJ/KW06LHAx5jebthwqCLIgRZqug+ERq3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791392317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fm6xdHt/WzcXTLsEJL16OKnaMuW6czGBlxID3zJVJ5I=;
	b=n3NS8WUCJVa/s10ylprskSvCn3nARfe0p5iRPNlB+O5NCazMp/C4ljwz9MoMxqhvUABA
	 E7MXIel60hAZ1KG3ZdAN93Gy5+mF/9ZI0WuEFSwnrIe1jxggaHL48zdQx9kuaBnmkeNY7
	 qKeIPJfP+Hbvn3LhJ5u0u4904NLljGcRnfah5MdwQlRUr9o1im72DMKZKNl7bJTalKAzD
	 +gAtVD6QyVdOalJMYc+wyW0/rNMUkAFKyv4PsTWa4CINXBCSHWHF71GV+uEeVlzGz0pls
	 amiFslPC4B5IIiysDZ7cogXW+FXUYPRniQSOfwHO/OeqRV/uYIi6vsf98ZkKrADwtjQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791392317;
	bh=fm6xdHt/WzcXTLsEJL16OKnaMuW6czGBlxID3zJVJ5I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rW2Wwne1IvgK9HHUMGS4jtqpasY9XM4WRokgcnkLCHvWXRgfhyHF64/bm5aiUWOdh
	 BQukQA3jGTpXsJdZp3zjqSsBck7naKESEs4mm4WjjZ3cGoNIYlWLZUAT+S8xbxBXUw
	 sVY5aj6RNfMrsUuB5jINFv6q+AIzTqDhiJiBlp2HeCEHYj2vG9nm0hSbjQWSpxfh4I
	 W2pI+4WCKyyoXahrpjzRT42xIHPMEzUC2OEokB/YMS3enVGjiawYmwKbKY/g196z/0
	 RiCWq9Ou8diLIkaTP/+dEkvT/l7ssidcYIU8RZVXcQwHJQB5pgKk7jsH/CZ0uKnTAj
	 AFDdKyZ0hPNmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3D85607E8;
	Wed,  7 Oct 2026 16:58:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FFDD1D2
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 16:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5637B400B3
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 16:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 46DAsb22pfJS for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 16:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A98C640204
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791389308;
 b=M7tPU086ioGOG1WvYny6N1RmGi7s2o3YyrYCeRvOFKbkl2UrUE7aNltxmzGfEqEGspF8
 KzfmCKUiAxpguDZ8oyZINW/8rP0exGbR/sWW88WhXsKLpgWCWvUdqkC6KcPbvRUHo0Leo
 FK4OhnePhofEfwHyt9J8CzHN6250W8d2vqu3UEhGqd9SqXKsAlgIPKY64nSYnOPTZ1n0P
 PYJ5kvEy93CToK/t+v4uIYgX/ppYgBXRxhCCulGTfQqg+qJV3BgLz2f0AKeJ6TXOySk4I
 Nj9c1wI53l/NP4NjKnKFThc3q4o43YSXawxHvdE0KLKsrhrbMgbFsw/Gz1YBK0n93Ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791389308;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=fm6xdHt/WzcXTLsEJL16OKnaMuW6czGBlxID3zJVJ5I=;
 b=gUYko48TSJCev+6x8TlQhfzu+QJ71wA3RLzMc0Tdw29VZsu7u00lBlC2j8BzSBFwPrZd
 54yeVmNzEabJustxZIAoOTPpqi7x3FSUu10hTRNJhCyJPJMSSsuqPgV0oCgKdQm7fcHEw
 arSve5RJRL8fUGK21S8VYWerHFKulZrCGFeVMWfdoL7fxdH4HmamfXBCrOPWJ3G1heWW/
 H/I9SeWzaBtee4ujNcyV2JCDKvj86RYO3gNSH4VNfUAojNWG2kIl8X3kLU5+sLszrB7fs
 kisqggbve6fJRaG7bmWSPPClh/IYsgHk6dTP6t4a1GejcbzKlK/z/Lfkmf5LJ9gC9lA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=ozlabs.org; 
 dkim=pass header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=SyrCcyBu; 
 arc=none smtp.remote-ip=150.107.74.76
X-Greylist: delayed 964 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 07 Oct 2026 16:08:27 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=SyrCcyBu
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=150.107.74.76;
 helo=mail.ozlabs.org; envelope-from=jk@ozlabs.org; receiver=<UNKNOWN> 
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A98C640204
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 16:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1791388335;
 bh=fm6xdHt/WzcXTLsEJL16OKnaMuW6czGBlxID3zJVJ5I=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=SyrCcyBu2GAxUBdvEQKIn+AC4Yss9ILaF00GQ8f/gvaWhowolZC+wfsH+Pj4b9glu
 +EZdTFTEjHUumi+U4ThF9ARlMQn/Gd/ERAv1nYpfnBQbrw7c72FFTVdswkx3pzT3pY
 Qv4SQs7XniXZqHa4J2D1vbITJkvN0Tx0WJl2/HfkQhRy84GEGqg+zvSMZBJt3n/4R5
 /9V2QEOnWj/kM1eOHs/fik2NLCZ0QF3bca/bTVEr1k8gJ+P7hCiF4NddWDONOz+buM
 sokh2AU58GnvQM5rkXYh+yd1IhxtycVgKicfNjRR6uQfys1WyIea5nbx1wUlQIijjj
 kYcP+Zng5e6WQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4j0Hgd0LQWz4wCH;
 Thu, 08 Oct 2026 02:52:12 +1100 (AEDT)
Message-ID: <1f5fb33c5e9009ee4cb521ca3ac6168301841da3.camel@ozlabs.org>
Subject: Re: patchwork.ozlabs.org: slow responses and timeouts
From: Jeremy Kerr <jk@ozlabs.org>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: patchwork@lists.ozlabs.org, trini@konsulko.com, 
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Date: Wed, 07 Oct 2026 23:52:05 +0800
In-Reply-To: <20261007115918.2553308-1-mehmet.fide@gmail.com>
References: <20261007115918.2553308-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 07 Oct 2026 16:42:38 +0000
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

Hi Mehmet,

> patchwork.ozlabs.org has been slow for us for some weeks, in a browser
> and through the REST API, and requests often time out.

Particularly over the last week or so there have been some increased
loads, this tends to be the ongoing whack-a-mole situation with scraper
workloads.`

Somewhat coincidentally, this tends to happen while I am travelling. I
have scheduled some time next week to tweak the anubis settings and
connection limits, when I am back at the desk.

> Is this a known load problem on the machine, and is there anything
> users can do to lighten it, for example in how often they poll the
> API?

Legitimate web- and API- uses are only a fraction of the patchwork
workload; the vast majority of problematic load is crawlers. There have
been some cases of high-load actual-user API polling in the past, but
that has been fairly easy to identify and resolve.

Cheers,


Jeremy
