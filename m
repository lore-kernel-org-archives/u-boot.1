Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D51606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wAledbYE;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=j2Dmv475
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 462C380BFF;
	Wed, 28 Oct 2026 00:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GoHaxB05sxti; Wed, 28 Oct 2026 00:47:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D21880C0C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793148446;
	b=sXN42jFYK+3UP6le+SWb/3BeMoDWHWoW7uPqn8BB9oQbWQji1QbGgQWDFyAi+EtzWcWr
	 Gm/em5jRYnuWg+toqz1CkinXYTNCU/Na4PatkdBgxfpG2ttC+RZHQcHMiEIQJ7QSiPZXD
	 Gy9CjdJDeP1g6c4cpo18m2+hkvqkNeMM7OE20yJiybON5EGXptGoMDIFssGjnTUc8ZgCV
	 nsUQSSygNVx5WtI58uQAtsqUNOVetLYwsP3vp/vzJwT5qTQMWF+B45QZPlsg+V2E9sVQo
	 H4hD0hSPXipQ3yY2aRtJwG+pStcoPqCck5hPLW9eeRtjFafMuOcoVoGsaOobccheLZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793148446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3RbCS/xB98yzr/V1Qk78RvfvF2XtafnpYeq5yuuB8lE=;
	b=rxH+9QXwOCtPIxDo3X2OwKceGhwf50FpFgrK2616+A2mrVe1oKU/3FA+nxvqjhH9Axv9
	 Y5xVsU+wGDsLj+n+L+3hsV/Ew+08mfHqOhK3WEjQe+Li0FVmwpahgH3C7bl3+pJ1If3KR
	 zi8FzU+KOlgwcBfxTbv4RkygCMh9kqjLgTKVL+dgt8aGpxnYF7qF8jXa3xv3HGzm4SmJ/
	 bgkt6MGa1p2hG2muR2f43ti+HJh+QC6t7sUKA1hdKgBXJLK5pL3lWrCOFa3w02WzvWY1V
	 P52vgC5zcn0T0hpIvn2Xjn9josvrS2ciPJYbWcXAOoM8Kekud/iBetvT68lewOCVs1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793148446;
	bh=3RbCS/xB98yzr/V1Qk78RvfvF2XtafnpYeq5yuuB8lE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wAledbYEgPHCNrVZyvG5/tedFaIMlbp4ExxTMvCnHkNJAlxyYZN0ZuSOslNCVjJ/V
	 nIvagi9JdPrnL95qSyUk3crkw9ioGx1mfgl/to2dzseB+dn1PK7pU/NqxHoLafvc1r
	 tIGCZGY2lA8jl1jBcgVr0zatgbwjoyTSfxR8PwfjZsqhL0N3YWDV6VpHNRq18C84Zu
	 0QDuIkEsHqyIZLrfRaoj0A5XsgdmolFGXcJ7b47nfSFYBHhSax5770tJLTHatW/VnU
	 vnG8R707DHgKgPAItPV7bNhCHrj4emlp4qBAN8JdL3VPLaZvbhcso6zBA7MK6Eemoi
	 cxy9B3k3aOjLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D21880C0C;
	Wed, 28 Oct 2026 00:47:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E33B9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FF10401E6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:47:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCm0I9T0WJTQ for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 00:47:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 44C8D401DE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793148444;
 b=MX1JcvfpzocgSfKmOlZAHaegUmu9Tx2cRpO0DrP4kJbCC0+5sVqAmXqxvNM/cCimxudU
 Jzfv3YCz4DyPB9AdMfwMEV1hlI2SD+vD2kc5L4DIt8ZG3ReRP4nPQnOJWfrHnzjJ9jhl1
 8pzaC6Ha4pS3nHAVHBd9dxPBBpy+OGJs8lcw+c/kZhMVjbTVz7GNYcDYvcYRFAesN8M/K
 u/3OEnaB7gC68Y8lqLhqMICKXLSET/GcpntPDl5XcN97MmnVpf4didUcWsE2uz0TDe6JU
 pGBOwl2ddRxdXQ/dxQ5iHOVkdmU3uNjBWkn1CQyb3gS/ss6xivSk+0k6eNgzDdwwSsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793148444;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=3RbCS/xB98yzr/V1Qk78RvfvF2XtafnpYeq5yuuB8lE=;
 b=rYE1TCz3luUS27SHNvDBfJTDFUsllW31rBHALiRA9wTtzBbCoLLjenkgnOyRGD3dReus
 nf114VB414wgS0QlXp/8AoJPlmJcpkvlweiguwCa6sieb+BuWsOOBqjMVGc4qo1Oc+rQC
 l4J6p3VD5hentbRxGxL/iHyrdLsLOFsxUmgCPy6uAuWmi8vvELd9TGEnh1Qg3uLcPNOI4
 26MOlDg/GTEOQFzj1dOWWkAd4EFkfAXyb0EvSqQxbaDM5kiplJ9NuTCA4WYG57RNYzz6J
 J/xpsCL05V8rR/sjWDGdVMVD8pgTCdRBzmSH3o5Wh1Y48O88CcoPBlmBEdkopLyv5Xw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=j2Dmv475; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=j2Dmv475
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44C8D401DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:47:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E1DB010BA56; Wed, 28 Oct 2026 01:47:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793148442;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3RbCS/xB98yzr/V1Qk78RvfvF2XtafnpYeq5yuuB8lE=;
 b=j2Dmv475yEEzlNxh+QIoQc7qcdw4/LIDJsD6tE7Cm/nIKxrIkFuETA76MQ/CSpaxW+eulr
 x8QqHEwYqHm68z7mcY4mEAhBdbtYgsnmJGL6XA++5s8Koky+/s1ZjS/9ivUV8UMobIB8IB
 Bretoge2JPVepAn+fEYmOIy0puQZw3lzC2GDqvQ2q+oyJ8TSmRvrcuTqqGFIzReX/gEO6F
 NMhsFDz3Bw0bkTU6a4ydekzN2ZS3xk9YSNNY4XOEckYeuJQRwedN53cBqUbj3oe5vFLyMC
 imKOmnEbJKJaMGZB9nqfkwYpDyj4Y5rebjiqYQjCMZhzQp23KUc0m2rWqUtt4Q==
Message-ID: <a829d462-e139-4905-b2c7-f8140a6cb2f2@nabladev.com>
Date: Tue, 27 Oct 2026 18:24:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] usb: ehci-mx6: set up i.MX7D misc registers
 regardless of CONFIG_PHY setting
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
 <bd8f810425b7d3f8d1d78fc699b232da5a7ea60a.1793091394.git.nora.schiffer@ew.tq-group.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <bd8f810425b7d3f8d1d78fc699b232da5a7ea60a.1793091394.git.nora.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 10:39 AM, Nora Schiffer wrote:
> While a separate usbmisc driver could be added, no such driver currently
> exists, and it would not necessarily be part of the PHY subsystem. Rather
> than making the misc setup conditional on CONFIG_PHY, make it depend on
> the existence of a fsl,usbmisc property. This will allow enabling
> CONFIG_PHY on the i.MX7D for the NOP PHY driver's power domain support.
> 
> Also update the code that reads the usbmisc address to use the modern
> ofnode API and fix the portnr to be determined from the usbmisc phandle
> arg instead of the alias seqno.
It seems this patch does multiple things, can you please split it up ?

Thank you
