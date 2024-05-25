Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA44AC25B78
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 16:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9AC881DB;
	Sat, 25 May 2024 18:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="TBYmTqC+";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="AVmn/Lma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75EC88289; Sat, 25 May 2024 18:21:05 +0200 (CEST)
Received: from fhigh5-smtp.messagingengine.com
 (fhigh5-smtp.messagingengine.com [103.168.172.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D6CB88093
 for <U-Boot@lists.denx.de>; Sat, 25 May 2024 18:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id C97EB11400AE;
 Sat, 25 May 2024 12:21:01 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Sat, 25 May 2024 12:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716654061;
 x=1716740461; bh=idCGMyqbIIDw1hhiZqaNjhp/OZy9oAMeeNFJQHRYuk8=; b=
 TBYmTqC+ptgFlfdI+Qi2cNYL8Z1WWjRQ/KFho0yn96NSMJStxV7Oghoh97TK2CJb
 BCl/KjPLUCHgO3YuEO1YvKs0YYqB3fDl4+V+SvNm7i67kq9dKMZMSy0SzaIBU4I2
 /WLt/jtGjBmJnNZsTtYvhzgBCfvB8hJkwdjWrktU5MIPYsrhpetBBYw3hyPJFIs/
 IHmEKOK6GahG/W3OoSZ3Sl82iU3A7Ria7fEb272zQhTC3xk9SLrU43tgXwLkrUKs
 aMVuM7b/fs5Pj1H8nGB7pWf+oiMHFIv5uMf3+Nt3PK+WDXjKLfgUggRW7ZaL9b2P
 ZJAt3FSRlV/EGgiKxo3LCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716654061; x=
 1716740461; bh=idCGMyqbIIDw1hhiZqaNjhp/OZy9oAMeeNFJQHRYuk8=; b=A
 Vmn/LmaFFBWpqTBjq8BRWDFeLj9p/XSbyvbEeNDXXqjhEN9MGbeWEpkHtxqj5L6N
 CAjyKzb7sP/G3ynQwrTsd/Yh0RWYX6MNxc3RUhL9iJ0mds/+ojo3r8NObMSpD/hc
 SgTNocra4bWolDsbgRYW56upKy9ahgLkQbSOyZAakWOv38rW2gK4owJWHdqSf7TB
 HXlzL6V1ZaGy07SEp6vgEsDnhPAHbp6Rl3H9STHo4wi1cIexyVJ8UdkheucEP+Z6
 8YrzycF40CVTKO2eSXdrSTvCcdxVlp+FsrXhHVfx7AZxafURJC8WZ5Yj7ndfUzl1
 zhc4Cpz0yKo62hbPV84IA==
X-ME-Sender: <xms:7Q9SZgzqmLcc5n8EKcDag4fkPt81AWYIB4sKg19DHwHByy5a9Wo-ow>
 <xme:7Q9SZkSLaAHgEu_SnFrKIJk4QRBcY39MqpV-fIxYj9VtquAvUOFCjzW43HLld5v98
 DN7Y94lzaxh8-f1hOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejtddgleeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:7Q9SZiW8stjb6kRBRYFp0X8s5aS_tmCqKy3KtPs0IO9ukt1RP2X3Lg>
 <xmx:7Q9SZujFIqZkkNFPkagUkXVQZeCiHzLTGMIlkJrQLllw0hLKj7nYfQ>
 <xmx:7Q9SZiB4wNjgQIe1b5HAkRWoc3hh62T9EyvRIbQXR8KC7-rqoHOC0Q>
 <xmx:7Q9SZvKBRjQZhtACMQGXljz9HqZcOnig9W53O6J0DxMZVwn0Qg35GQ>
 <xmx:7Q9SZl-CLsvFzH2MmDRCsRZoSGR-ABDfHKdioPTbea4ycIZjgRIWWdg7>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 51BDD36A0074; Sat, 25 May 2024 12:21:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
In-Reply-To: <20240521181534.GD2568172@bill-the-cat>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
Date: Sat, 25 May 2024 17:20:43 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Tom Rini" <trini@konsulko.com>,
 "Brunham, Kalen" <kalen.brunham@intel.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8821=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=887:15=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> We have long not done a great job with the U-Boot standalone API stuff,
> and for a number of years at this point a lot of the use cases it was
> used for could instead be filled by making an EFI application. There's=
 a
> well defined API there, there's lots of examples, and frankly for the
> license related questions, makes a much nicer answer.

Hi Tom + U-Boot EFI folks,

Sorry for chime in here.

AFAIK there are quite a lot of users of U-Boot API in MIPS world, mostly=
 for
Bare mental applications to perform chip diagnostic or programming stuff.

But I'd agree that there is no benefit to maintain ABI stuff in upstream
for long run.

However, I think people still need an API-like interface for those simple
applications, while many architectures are not supported by U-Boot EFI f=
or
now.

Sadly, most architectures are not covered by UEFI spec, some of them are
violating fundamental assumptions of UEFI spec, like no 1:1 PA VA mapping
or simply being Big Endian.

Do you think it's a good idea to port EFI support to as many architectur=
es
as possible, and produce U-Boot supplements to UEFI spec to cover those
details? I'm happy to look into it.

Thanks

>
> That there's some power users out there making use of standalone to do
> useful things is news to me. Some of them speaking up and offering to
> be visible in maintaining it would be good (there's Coverity issues and
> lack of CI testing, which should be addressed).
>
> --=20
> Tom
>
> =E9=99=84=E4=BB=B6:
> * signature.asc

--=20
- Jiaxun
