Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCFCC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 14:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C56E88744;
	Tue, 21 May 2024 16:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="ETlTvxPJ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1Ki8RtJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 639118874F; Tue, 21 May 2024 16:42:59 +0200 (CEST)
Received: from wfout5-smtp.messagingengine.com
 (wfout5-smtp.messagingengine.com [64.147.123.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0F4D884B0
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 16:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id DDBB71C000D9;
 Tue, 21 May 2024 10:42:52 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 21 May 2024 10:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716302572;
 x=1716388972; bh=cM37sUDbDj6CdieSWK64AXvXooXUnWKQvrbg1yv04SM=; b=
 ETlTvxPJYz7POaEXl0bAv28lDGVeZWOtpJul1OcVihRZ4iejfgK298FTyteosh6D
 NvDyhtiF1rW9OnnBhDIp0W6I3IFJQoRqxw40uFsCv+7ZBcDwWm9x3eLfNhc2LKKU
 /TNzDLhFRmw7+CXLfTm8/Sodx+Yge1IkXP746CHBTIwrhzp2o2A/61ZVLWF40GjA
 Xq4yf3u1+qBPSs4pc0wOzXR5Jc4H7tU4JhFEQfkW2OPk23c4eSvp1xJI8ItCsUzZ
 vhU8GjUH33yCVPiby6osyXPywcpX1Eoqx28bNFOc5MBEB8dx4iBJbzqr8LqMR43J
 J7LS6K1s+HZXePv0ZGd7iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716302572; x=
 1716388972; bh=cM37sUDbDj6CdieSWK64AXvXooXUnWKQvrbg1yv04SM=; b=O
 1Ki8RtJkdtMaL5/ogcEruATwFuqo9QiIUl5Kzj4f3DWRK1In9knFJDXOyzgPj72R
 uN/Kuzd9708r7VZfp+PxyUfgs6kO6FtMqzoABWBcVrVPQyrN6ciVbUGfdoGkEX9P
 9X+iMKSzh7Ny6LCpvdqcbOysVtH/aUacDPY3UIn5VfG0IxSywVnRIvFCHNvxH7LI
 1t4anedUtxk7PI5F+lyo+g/PMo8ugzK9Lwr1rgV2XuocSqbGmeLiyq/ps4DeDmKR
 Mb9OB8yDhTa/HygTp6w0Fk8jB+LxhzTuIMq+KtJzsmdBEn2QpQWJI/UH7dTj/ZFV
 VLYDktmp2N7HyD8WMkIkg==
X-ME-Sender: <xms:7LJMZqeIX9X655XdRD2xzb0Mkf3xe5oumCiIvr16b3F-vE9ox_xZ6w>
 <xme:7LJMZkNVXcIn2JGMF1Nkae2LCm6qEkFxKHsP15VFlwisNEgDrihCJHFzmLDbtQcrJ
 KgG-RYKkgWr5EWsyrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeivddgjeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:7LJMZrjXe0d6WDSENpb5T9xIR2G1x8g-tM19NByuzwCtMpdQQXPdpg>
 <xmx:7LJMZn-VDWbHksk2m958oI5g1mgEzSOtOpZYMph1VRzF0mlmgUb_bw>
 <xmx:7LJMZmuFcNcXncMcWkhVcu7xxpFjMph2g64D8cw02V6tnf7W_NXnfQ>
 <xmx:7LJMZuGMURwnJA1VLv3d2pUbbFOqwYM49wG33d0Jj4nVCLqTHhvgVQ>
 <xmx:7LJMZoI5PJb2932oQh6mw75phdUJ-Obd2Ks3SG_e4bMNd1EWYlcVOxAX>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 39C0236A0076; Tue, 21 May 2024 10:42:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <7160e2f2-358c-4f3e-9865-1632ffea7975@app.fastmail.com>
In-Reply-To: <CAC_iWjKKyUm=4NJVuWgUqmFR43TNcuxFKmaBJLAFKC2CQYbxJg@mail.gmail.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-2-79096e3ca3b3@flygoat.com>
 <CAC_iWjKKyUm=4NJVuWgUqmFR43TNcuxFKmaBJLAFKC2CQYbxJg@mail.gmail.com>
Date: Tue, 21 May 2024 15:42:33 +0100
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
=8D=882:58=EF=BC=8CIlias Apalodimas=E5=86=99=E9=81=93=EF=BC=9A
> Hi Jiaxun,
>
> On Fri, 17 May 2024 at 19:33, Jiaxun Yang <jiaxun.yang@flygoat.com> wr=
ote:
>>
>> Allow runtime relocate to be disabled because on MIPS we
>> never do that. It's guaranteed that OS won't call
>> set_virtual_address_map and convert_pointer as well.
>
> Who guarantees that? Is it only for Linux?
Hi Ilias,

It's guarantee by all the existing implementations, ventoy,
linux etc.

It's nearly impossible to run MIPS OS in virtual (or paged)
segment. All MIPS OS and bootloaders are running in KSEG/XKPHYS
segment, which directly mapping lower bits of virtual address
into physical address. So I suppose set_virtual_address_map
is unnecessary on MIPS because the mapping for U-Boot is
always here and can't be disabled in hardware.

>
>>
>> On MIPS KSEG0 is always mapped to memory and there is no
>> way to disable it for kernel mode. Both EFI runtime and
>> kernel lays in this segment, so relocation is totally
>> unnecessary.
>>
>> Also U-Boot does not use traditional .dyn.rel to perform
>> relocation on MIPS, that makes implementation of runtime
>> relocation pretty hard.
>
> It already works on other architectures so I suppose it's only a
> matter of adding it?

MIPS is odd here, we are not compiling U-Boot with -fPIC, instead
we use our own tools to generate relocation records and embedded
them into U-Boot.

Adding relocation support requires modifications to that tool
"tools/mips-relocs.c" and also processing our own record format
here.

Given that set_virtual_address_map have no practice use on MIPS,
I think the best way to handle it is to leave set_virtual_address_map
alone.

Thanks
>
> Thanks
> /Ilias
>>
[...]
--=20
- Jiaxun
