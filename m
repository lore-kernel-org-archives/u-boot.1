Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D219DC25B7E
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 10:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E47D388488;
	Tue,  4 Jun 2024 12:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="t3xbtk0z";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="bxiOHVfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16CC388489; Tue,  4 Jun 2024 12:50:47 +0200 (CEST)
Received: from wfhigh6-smtp.messagingengine.com
 (wfhigh6-smtp.messagingengine.com [64.147.123.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F6E88476
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 12:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id 2053A1800152;
 Tue,  4 Jun 2024 06:50:42 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 04 Jun 2024 06:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717498241;
 x=1717584641; bh=EG+iLYMoV08Klbd1KJA4gG4EBRJWkGI2HfhE/rxNaxw=; b=
 t3xbtk0zQ756qkDreDcxqXbiKRHwl/XJFz4iWKRWEGPBhQqTreRndNuGuXOwwvBM
 xf+7bL34ZTn4HEZBVt5fds68nTUNaEMDhpCzQ08t5HD1nUlt1kWo50rFHnFcFKY8
 jMtbXhjvgRc/M9PQ/YLxjpWSE79QSzZ6/Iw9LDIezQo4GReySjYqZJn6eeBFHjgZ
 5Jm3ysBieMdZFhc8J8CGjg2GIwtv1K3mLsn7u9MJUkClDhCAwjtDO7ULX+CWHuWL
 EwknmVdjGqP23d61m8m3uWdjUCrCJUJWMOR/nt5ygHF9luuWFG1Ugq1lPQuqyp7k
 STfJTBmJJY/JSAAO5+Eb/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717498241; x=
 1717584641; bh=EG+iLYMoV08Klbd1KJA4gG4EBRJWkGI2HfhE/rxNaxw=; b=b
 xiOHVfQ/ou99UoHn1xhUFOeLTjm6+1DKSeDD2eEC+1eYG1cwvTv7uFTpLWW0aMLp
 1zTbMDiGmIMlYrHnTD6AyiyUJPzWX14m3ettez6MSYSdisA4/oqqKl7HZgHcMSMq
 t6251S8kvx09ejbwGFxUGgtBs/m2+ronmavEK2aaR1oRFJcRSCklDDXbNI8ulRM2
 LdJls8BhBpWTS5N2UyZpE4yByMVxLmiwvtFC5l/VUB74YthA1a8OhgKBk1LNvh/S
 fs3KqbcbZf3DBIw+MzFo8bymBSe8P9lJuyvRkCivqxmFsS6CCtO7E1ZR+lYD1xfR
 l5NLcikZPG9iop6vtS+Nw==
X-ME-Sender: <xms:gfFeZnKTCdha5HC3nZbD9DS7PUxx1Ohka_OtK6IXs9Zw3F5nMDsKNg>
 <xme:gfFeZrJPmqdpU9iCpbivqwbK2tH_i8Qzc_qWthT8zZgSu9XkA2j46L65rrZA0v5iU
 _-buEUusUCEZxzzn_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeeujeduheeltdeffefgfeffhfevgefggefhffeftdeu
 uddvtdekuedvkedvtdfhieenucffohhmrghinhepuhdqsghoohhtrdhorhhgnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
 rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:gfFeZvsyxsvzldfRB0tPorurYGcrydc1cjFJDk-fjKZ65q1LJALG5g>
 <xmx:gfFeZgajeMMm5a5z_hoF2WoKFuTGyhGuXF9s_Zs4KmYpLlrpFCHGiA>
 <xmx:gfFeZuaRoFYrpsSNnOhSdjDicBe2rONfKO2AEm0FZHWiEeT35qZdQQ>
 <xmx:gfFeZkBfYZob3SOzxtP8hjrqm3vZVRR6qPHL8JL6U1H1vkuafLPJgQ>
 <xmx:gfFeZlUhRvHZ_5ByNWwXLnGjxXoTRlOFfWF38lV10ui-xe2stuJmG2Ym>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 7202E36A0074; Tue,  4 Jun 2024 06:50:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
MIME-Version: 1.0
Message-Id: <ce9d23a2-d273-4493-83dd-ef565cbc1c44@app.fastmail.com>
In-Reply-To: <20240523154317.GT2568172@bill-the-cat>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240523152540.GR2568172@bill-the-cat>
 <36b2a4a8-9a37-44b8-9630-bb48a862e60d@app.fastmail.com>
 <20240523154317.GT2568172@bill-the-cat>
Date: Tue, 04 Jun 2024 11:50:20 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Tom Rini" <trini@konsulko.com>
Cc: "Simon Glass" <sjg@chromium.org>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 00/16] LoongArch initial support
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8823=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=884:43=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, May 23, 2024 at 04:38:52PM +0100, Jiaxun Yang wrote:
>>=20
>>=20
>> =E5=9C=A82024=E5=B9=B45=E6=9C=8823=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=884:25=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
>> > On Wed, May 22, 2024 at 04:34:43PM +0100, Jiaxun Yang wrote:
>> >
>> >> Hi all,
>> >>=20
>> >> Sorry for flooding the mailing list recently, yet another huge RFC=
 series ahead.
>> >>=20
>> >> So after working on MIPS, arm64be and Xtensa I'm now on LoongArch,=
 as suggested
>> >> by=C2=A0Heinrich.
>> >
>> > My big feedback here, and it applies to all of your other series as
>> > well, is to please update CI to make use of and test this. On the D=
ocker
>> > side, update tools/docker/Dockerfile as needed. For Azure, you can =
tell
>> > it to use a different image and then follow the documentation on
>> > https://docs.u-boot.org/en/latest/develop/ci_testing.html and for G=
itLab
>> > you can at least use their "linter" to make sure that your additions
>> > have the correct syntax. Thanks.
>>=20
>> Hi Tom,
>>=20
>> Thanks for the feedback, I thought CI is for custodians only :-)
>>=20
>> Do you mean I should include azure/gitlab pipeline file to create
>> pipeline for those new qemu targets?
>
> Yes, just like the rest of the QEMU targets.

Hi Tom,

I've got CI working on azure-pipeline for my arm64be, xtensa and LoongAr=
ch
work.

What is the best way to submit all these changes? I think I can send pat=
ches to
update Dockerfile and CI hooks first, then after new docker image being =
built
I'll combine CI related changes into these series and refresh all those =
series.

Will it work for you?

Thanks

>
> --=20
> Tom
>
> =E9=99=84=E4=BB=B6:
> * signature.asc

--=20
- Jiaxun
