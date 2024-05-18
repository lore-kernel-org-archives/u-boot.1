Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA3DC25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 11:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B41118863A;
	Sat, 18 May 2024 13:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="TxmfiGeT";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2tbOIRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39DEF8863A; Sat, 18 May 2024 13:36:20 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E02E882B8
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 13:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 6CC3511400A1;
 Sat, 18 May 2024 07:36:15 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Sat, 18 May 2024 07:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716032175;
 x=1716118575; bh=8eV6BVk5CVWUaMAHCxbOacyWn1FPmMmtVK0/1rmj6CQ=; b=
 TxmfiGeTjpWShDwZ5eQXRC4v5FOzGzB6MmNkWuPT9TEjDzTh6MLakhX6ynfDOcmU
 H6vM1Wmyd+RGHri931EGx+FWbsWtL75PWCMSmkSr3482U8SnHOdhc034y3hRPdlt
 4GQUu8I8lPA60OykVw9Tii/tmOB+Zjs2pA2vHxtrlTprnb25u5J6M0X1AsCEOTKK
 yWSMh4/WzIRtzC/yEc7TqDEEXt64sUTdYKW5Zkt0wUw94R0KbsNLRhC2RQi8QgQ3
 QTasdBbtTOf+zHtGwBKhldOclsP4mPteE5gwl5Cnsncrjazv8Vc5puut6RPawQRt
 le/cKupkh+1SqwPRu8/c3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716032175; x=
 1716118575; bh=8eV6BVk5CVWUaMAHCxbOacyWn1FPmMmtVK0/1rmj6CQ=; b=R
 2tbOIRNnyFZXAXJLITKHMxzy5NrzaweaT9zSRgzETdhXAkdC3om4XkkqQMEwyRX4
 FyIqOJ2xiKMkyJVFcC+bu1ZjMKg11CBuhMq7jnzoz7ppdvBOFIBO30y/LBVLvi0n
 c8MlhDL5LLlYSjKW40wTd7Oo9RrJajedMvhOn+6BcOO1VWbS7HqC+I6RdmDyTsej
 ZAdC1uMOB+btFKmIc1IocKEN961B1nONbot+kvGbJqq90mlj207QtTdCqDFc5j06
 KdJDEbhTTStiWTsaESumulhVvoH8KDDkaPYxaKi0nbg/tRKZB/t2EEBlczyPEQel
 VjbrcRg6cMeTLozEN9MUw==
X-ME-Sender: <xms:r5JIZns_W1EzV-gBbRNIbkt-x969KNdgsm_hQlZeD3koLZfx9ViCAw>
 <xme:r5JIZoelPBaEduHjjKKtrPyM3Nq6o-QGZAVTiaNB8byawuvASeIMSqDK5pK0XqVhi
 vgupxSxSzs1nxcYnE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehiedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:r5JIZqwcXpYO5kIlTdqKXmkAwSbfjxZe207EcyPyrjyZjblpu6OtoA>
 <xmx:r5JIZmMpSG9apcsaUnCbFIQGtiElNRqf4fFjZ10TyiwCUbb5sNYLzQ>
 <xmx:r5JIZn9VcHTBvca8LS-LHsfUb9gob_8hlEHWCU2nK6lRF9AOER7GTw>
 <xmx:r5JIZmUdn_SZzRXNa_WORcChV2HIe4e1X1dUoX3lJ7Gwut144Fv1fQ>
 <xmx:r5JIZqbqBTymoJE5QFtP1Yy5OiaYkP52DN79bXQJTjcFsp1BeiwBZoNQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 20B8736A0074; Sat, 18 May 2024 07:36:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <1d7b798a-5f1e-4b69-84b4-044456fe8a89@app.fastmail.com>
In-Reply-To: <a4d513ec-2f6e-464b-8167-462e05615571@gmx.de>
References: <20240517-address-spaces-v1-1-93e14c260b73@flygoat.com>
 <a4d513ec-2f6e-464b-8167-462e05615571@gmx.de>
Date: Sat, 18 May 2024 12:35:55 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: "Tom Rini" <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH RFC] doc: Document address spaces used by U-Boot
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8818=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=889:08=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
> On 5/17/24 13:45, Jiaxun Yang wrote:
[...]

Hi Heinrich,

Ah sorry I should really spell check it before sending it off....
It was copied directly from my personal note.

> %s/optinos/options/
>
> Relating to gd->bd->bi_dram[] or LMB just adds a layer of confusion to
> the reader. I would not refer to specific internal structures in this
> document.

So it's a developer oriented document and I decided to add some examples.

>
>> +used as arguments to load commands. It is recommended to use ``sysme=
m_addr_t``
>> +to store ``sysmem`` address.
>
> In most places long is used.
>
>> +
>> +It is further used by sandbox to simulate memory, and by MIPS to han=
dle
>> +differences between ``virt`` and ``phys`` address spaces.
>
> You have been submitting patches to implement EFI for MIPS.
>
> The EFI specification explicitly requires a 1:1 mapping in the MMU
> between. virtual and physical addresses.
>
> In what respect does MIPS not comply to this?
>
> In how far do MIPS addresses shown in the CLI differ from the physical
> addresses (i.e. addresses on the electrical address lines)?

So for MIPS we need to apply a fixed offset to physical address to get a
usable virtual address, i.e. 0x1000 physical is 0x80001000 virtual. That
mapping is guaranteed by the hardware, and you can't disable it even aft=
er
enabling MMU.

All CLIs are currently using virtual address.

For EFI all table address passed are virtual-ish address.

>
> CONFIG_ARCH_MAP_SYSMEM seems only to be set on the sandbox and not on
> MIPS. We should try to keep it that way.
>

I'm actually trying to introduce ARCH_MAP_SYSMEM abstraction to MIPS
because currently it's totally a mess about virtual vs physical everywhe=
re.

I think eventually we should convert most internal data structure (and c=
md
arguments) to use physical address for consistency, but converting all
existing boards to that model cost an arm and a leg. So my plan is to in=
troduce
an option telling if sysmem is virtual or physical and let boards opt-in
that option.

Thanks

>
> To summarize. If I have not mistaken anything about MIPS:
>
> All physical devices are identity mapped.
>
> The sandbox uses a virtual address space incorrectly called 'physical'
> which is mapped to the virtual address space of the host. This sandbox
> virtual address space is used in
>
> * the command line interface
> * in the sandbox device-tree
> * in environment variable
>
> This allows using the same address values in sandbox tests irrespective
> of what part of the host RAM was mapped via mmap().
>
> Best regards
>
> Heinrich
>
[...]
--=20
- Jiaxun
