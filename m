Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51BDC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 06:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D905288442;
	Wed, 22 May 2024 08:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="ThL1c17W";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BYjwVDIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B7D088464; Wed, 22 May 2024 08:12:54 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D1A88412
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 1C81B11401D3;
 Wed, 22 May 2024 02:12:50 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 22 May 2024 02:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716358370;
 x=1716444770; bh=1gl4NnLRhvw648SEueI7FbXbpE3b47YtnNks75jrx48=; b=
 ThL1c17WK5VkCG/o0Yd4Ggq8E5cQ7LSduNalmAyl33a9mjcHpTCtc2y/Dz3v7HHX
 KxVHlCuFinwj34fKog97lfpaHnxFQrNKn/2cPVpvPBwSubumzERllciySyRi2Oiv
 +scV7viezZ4PG8fBnsk+t3yWICXeZW63i3pq4CC77kwaqcTw6pT7J8Kqsfdzrn3f
 oqjY0x5ZgfYxfTxf74tDQYVPB6KBIlKvHq+BQYJob6RSbPg2La9gUadAjPcECat/
 Wsk+aQ+Ocs4YDq+UTH6+u13SbjJzqwUs3UHqNkicq4XmjiOst4FKD1d64cYU6i2k
 1uCEEE0Rac9oovmHbaYq4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716358370; x=
 1716444770; bh=1gl4NnLRhvw648SEueI7FbXbpE3b47YtnNks75jrx48=; b=B
 YjwVDIRrm+Ct4Zt0iUoSW9YyMQ7Cj25NlSNMMHi/0pohTU1nbhbvrnm9j/oiP2C0
 +FRu4XUNGk//ZJGAfVqR4wkJaAJR4ecVMvQzuPoKaDaXuHec6xCpO+kPDQrwVHgd
 rpccONYvj9AgLb2m8VkPMywwu6wy8tgeFXfkmkIKbs3gTqXY0D6+WtW+NTmCSKfq
 mHuTP18KBiJi8vM27QQtiGbjgRH0OCn17s6popcENn5/bC6oGPIezi29By9qndRr
 DTQnEs1l3O2iXcrapwDc26iY05vD0Qtb7dRrR4pBz+ZhYwleA3iQDrByud9JzuQy
 mCWw1MJnvpasdD++tzfhw==
X-ME-Sender: <xms:4YxNZjcWwqq_JCIbM-umBVVwG2j9d1_dnPSIDvLRdL96jEFbZvHELg>
 <xme:4YxNZpP7Qok2b9QQ_G8HTpvm5-2Vr-ezeLTDhRkYH3FPe7vCKdQX6dta7tmenFBqU
 Mcn-vNYzEsHiM1cyMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedgleeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:4YxNZsiHb_zCwxQwYwVfLw8hgoZ1uHuKIidZBnU0JzrzRcQHfZeJfQ>
 <xmx:4YxNZk_svZCFVlKXkCK5C5mhueHVhTEItaerMLKFYSr2KtQ8IQH9ww>
 <xmx:4YxNZvtbRNqyYRIwozItVkGAVpI5H4WBRfc0kbRP7BVJxNlyb1kJpQ>
 <xmx:4YxNZjFICVCMOHprnJwv5KO5WjwW7RI7_E1zew2XDt8NBVlpmqsVVg>
 <xmx:4oxNZpLsbTvhNzLu9PVS0ZT_lUCFd9K6dN2XyPHWcM0bxaYHyiurpEjE>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C9F9636A0075; Wed, 22 May 2024 02:12:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <d796526c-ef12-40ca-b837-7f7c6a9c634b@app.fastmail.com>
In-Reply-To: <CAC_iWjJuMkmHJvs6r3yd+fB=tGZKV0+CkaykEfjiwaC8NikfHQ@mail.gmail.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-2-79096e3ca3b3@flygoat.com>
 <CAC_iWjKKyUm=4NJVuWgUqmFR43TNcuxFKmaBJLAFKC2CQYbxJg@mail.gmail.com>
 <7160e2f2-358c-4f3e-9865-1632ffea7975@app.fastmail.com>
 <CAC_iWjJuMkmHJvs6r3yd+fB=tGZKV0+CkaykEfjiwaC8NikfHQ@mail.gmail.com>
Date: Wed, 22 May 2024 07:12:18 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>, 
 "Tom Rini" <trini@konsulko.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Subject: Re: [PATCH 2/7] efi: Allow runtime relocate to be disabled
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
=8D=886:32=EF=BC=8CIlias Apalodimas=E5=86=99=E9=81=93=EF=BC=9A
[...]
> What's ventoy? Googling it seems to be a tool for writing images?

It's a sophisticated EFI application designed for network booting,
more file system support etc...

>
>> It's nearly impossible to run MIPS OS in virtual (or paged)
>> segment. All MIPS OS and bootloaders are running in KSEG/XKPHYS
>> segment, which directly mapping lower bits of virtual address
>> into physical address. So I suppose set_virtual_address_map
>> is unnecessary on MIPS because the mapping for U-Boot is
>> always here and can't be disabled in hardware.
>>
>
> Fair enough, I am not too happy with the restriction but I think it's
> ok to start with
>
[...]
>
> hrrm any idea why? Was that a pre-existing state in mips? Perhaps we
> can fix it in the future.

Yes, I think that's because on some MIPS ISA reversion we don't have
PC-Relative addressing instruction, which makes MIPS's PIC ABI really
awkward. That's why Kernel choose to use such relocation mechanism.

At U-Boot we are just following kernel for now. It might be possible
to switch to standard -fPIC relocation. But I'd prefer just leave it
at this point.

>
> That being said, I was away on a conference, I'll have a look at the
> mips patches, but probably next week

Much appreciated!

Thanks
>
> Cheers
> /Ilias
>>
>> Thanks
>> >
>> > Thanks
>> > /Ilias
>> >>
>> [...]
>> --
>> - Jiaxun

--=20
- Jiaxun
