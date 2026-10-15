Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3402ECC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 12:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B73A681164;
	Thu, 15 Oct 2026 12:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CqnRzDeNY-di; Thu, 15 Oct 2026 12:26:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 174348115F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792067192;
	b=oJfW0HizGPYDYmCER+jqBN01GtgPVDEhm91qm84H0ATwKt8KV3+wTwbDjCPxJsiPcaH3
	 5tDainljIl+0dD0IVU51wivIcAr5x2KxMrqXdA2gea81YekYOjH/qfs51QjNSuNZqFJ8S
	 7dhcq7XL7rxce4qThPm3T0jeUz5j8Tjg2FMzYyo+YYxxel9iGDIUdx1Mc1EdBFREt5bjn
	 Ifze61+isKe4JWxuYKGJQv4ZWg0tph1YA7j9+bHhEd01efHl11YysXmRwP1GokiPCXCh8
	 UR0d3o3LX2HYFbQoRQ33QbmNYeTf3ke0tBeNMKNPJeqKSJmEJuGCKYKQnyxmYazV6NQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792067192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lMR020Aiob59WUchq1FvvT6tdWKw/QD0mnawN27SPiA=;
	b=ccVzDf70Uz7WcBBstHooP8edlLIgZCWnH4UOhCabySr9igDgC06d+1fxzy3tac66/IYd
	 T5ymaOy9T/ROX1EjEijd7JmxiOvEShzQm8x/APJhYuqzPjv/FhriLL1XJdF7y8uVGkl/c
	 d+PVYLPnFJ2cIpwyu4Jm8EoTUIw32llFqUWnU1KFP8qSpgO626cDccfHCZwIbrBVApfAK
	 SuDxFZmouc+z/6aa3z0WVtOQhk0W+uYVE7cZjvxmKBwYMR+zlf2Vx8JQn23kvcsxxedbD
	 lAshL7btpWxMZ3nMx+peKFJWsSzMAJ9zlwFurRymYNGTXkR8aE48938ovwKjPyE5yDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PJ8gjtuV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792067192;
	bh=lMR020Aiob59WUchq1FvvT6tdWKw/QD0mnawN27SPiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UNyRKzgrbUTfzSMnFyZNnCXNlk9sMq6JdxwYo/knicEB7IUZqTW6WKI50PJ8hJm1T
	 ojE9gvmWUyaY8Z2gmz7Iv+9EmSCR6hOQvSsOkE9e0utYI7SVA1flMxBqpg5XkEDgrp
	 RsVtpr86aXJtG17ZH3VyOR4UUYO3lF7TGWTLU4Ol3qfgUeq7Y5ddpkvFtoNb7hJkoB
	 rKXhoGs6sOpuifX7zDTweBd7v5AKz2awkhGeAVS/Cjgaw94bIkNHPdw9mQraRQhlIU
	 4Jd/4Vm0H5gisSiEDTJ00igzNby+kxt+Z/MLtzdZ2c4v8PqFp5VEaO84El9YNy52Ra
	 0XJlW33rj35Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 174348115F;
	Thu, 15 Oct 2026 12:26:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CC2E41E9
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 12:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDCB78115E
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 12:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q0epgX9pPd7L for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 12:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A63D8115F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792067189;
 b=clSYcovAKioDl6Ru48bcso0mjyIwJrwgyVxuErIRHGw7AtebpBd/oyfJxFVCbrwPRmQG
 u9aAFkJck1tGmuq+FGeki9/7kqTVyFVY23rVALY0TW0qyc8uVIlzPWiO9A4dQloJoKslA
 ERih880LUPQwBbt61N7pk5kUErxEWAHP6a9rS2NViLThgVkGCbOX5iMiqyib8HuCMh/2C
 Umr0iWJ9jtZb4u3yZ8tDoYgZC3MfGVmuHONlCd3GKhPC8Pu2PUbPaNehd8bFrPuZjMaa0
 6CUhAMl0zHv0sQjJ3/Q/LlLwVJDvLuf64ZAnbLqR+KSBsJ0xOlM02NTKbuq8Zz526WA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792067189;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Last-TLS-Session-Version;
 bh=lMR020Aiob59WUchq1FvvT6tdWKw/QD0mnawN27SPiA=;
 b=MbW7PNZdWn7IiVd5/phORYwvjB6JHuWw1Saj4EMz4POT4bxNrNLNpm3aCnGdLE7Xq7IA
 nl71wYXN2ganPTNY5/15waz0tpgbNxNoYMquTZONt0Ca1nLSXqCkHky4DXBohnMQ3+08s
 Is9ADjf9AnQ2ny9NlivANpYXcv81V4S7TJPcHLLgoMMpGNlh4C9ojAbvpzZjxgKTKZ3OH
 LxKLv9jIeSbx0JGKm7RMlpnxqu/8PX7xiCrnBt+loM9xWEEDfVHPP1uyUL/mf2HgFgv0W
 DOid+ei5TnZ43Q+TGRPHTYuEaxO3MNhvI3g8ABESsXgoYsSt2khR6Im3sfPARuQrdkA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=PJ8gjtuV; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=PJ8gjtuV
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A63D8115F
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 12:26:27 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 7B63AC62203;
 Thu, 15 Oct 2026 12:27:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1624C60360;
 Thu, 15 Oct 2026 12:26:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E4E110328BFB; 
 Thu, 15 Oct 2026 14:26:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792067179; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=lMR020Aiob59WUchq1FvvT6tdWKw/QD0mnawN27SPiA=;
 b=PJ8gjtuVYOItKUBf9w23W+dyoqM12qb2lL2vO6HuOTe8m9zdLstIBgIfHITr2iN+nbDivm
 tWS5ArjNElOLUJ9R76i384U9RGZiSU2j+YiFXfOHwheDfVFBXrwGEinV8y0qD83Vg5C6fc
 lHZ7VztpxALauj7WatZwYRgZB8kef6O+mkWcnMi4591bfpUyhAxQp9jnJ1o8T0POJQ3VCP
 xO1jHynAIKv6NlbRoRNmGZzR6827P4TpaIn4C7nxCIvcitxWyLQ4doqit3fCLp8M4JzjvT
 M59UlAbGTYrFSW0r42OCDbVN9rrQ7QZQBs+QWdrZD5G90KiAXTXpfncTop2AZw==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>,
 Alexey Charkov <alchark@flipper.net>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Packham <judge.packham@gmail.com>,
 Randolph Sheng-Kai =?UTF-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>
Subject: Re: [PATCH 06/10] mmc: metanoia_sdhci: Add SDHCI driver for Metanoia
 MT2824 SoC
Date: Thu, 15 Oct 2026 14:26:06 +0200
Message-ID: <Q6JujkcJSbG0iqxrHBpoUA@bootlin.com>
In-Reply-To: <20261013150534.GC4042005@bill-the-cat>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
 <EDoKM1LoTYiVJ09AAx_ihg@bootlin.com> <20261013150534.GC4042005@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
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

On Tuesday, 13 October 2026 at 17:05:34 CEST, Tom Rini wrote:
[...]
> > > I don't see this compatible in Linus' tree currently, so what's the
> > > status on upstreaming all of the device tree parts? Thanks.
> > >=20
> > We are currently preparing a first patch series for Linux, but it has n=
ot
> > been posted yet.
>=20
> I'd really like to see that get posted and commented on, so we don't
> have to have churn here later if there's changes requested.
>=20
Understood. I'll finish and post the series for Linux before doing a v2.

=2D-=20
Beno=C3=AEt



