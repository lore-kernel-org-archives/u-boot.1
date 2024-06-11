Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05612C27C77
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B5A888652;
	Tue, 11 Jun 2024 16:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="vMnOOePl";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="aA5BAeiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E790886DA; Tue, 11 Jun 2024 16:30:53 +0200 (CEST)
Received: from fhigh8-smtp.messagingengine.com
 (fhigh8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D578859A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 1207C11400F8;
 Tue, 11 Jun 2024 10:30:50 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 11 Jun 2024 10:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718116250;
 x=1718202650; bh=REXhsWoX0oUvfnGQAMrPCI64+csOqdBHBtkEZw6FK3g=; b=
 vMnOOePlLS57NQpsUre7Ow3OZj+7lzH3PekB/Ytoq+H9/VDSVqNumMnlahM72CBx
 DFEvfUGQFazzr6tjGh6CemQCJYcuidKyxo3yma1EOFOLr4eSRRAM0JOh0G1YbTLQ
 /IQprWydf2VG/LiPhrUTb1SnQy1w+vvRw2+JXeC86FQ9gDet/6D3cP8nk7QfmLXU
 omEIN2WgNsKrg/PnGMN+yYtJ8PykcaE1SF4HhgWVi1DG8Xtq+H8OXpY71/d8OJQr
 rExCWjm2w/JlI7w3tGXvCM/QwHkqKBJV2H2oKwF6p6wZcg1/sr+R+b5j542sUTqv
 vtWUMJ1b1/eScl1HbqB3/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718116250; x=
 1718202650; bh=REXhsWoX0oUvfnGQAMrPCI64+csOqdBHBtkEZw6FK3g=; b=a
 A5BAeiObWTHWtJ+JJaG2D/kXrBFa1Ir79fIE5RmoeRZSLvv51bR6/ARk0re7r8Kx
 QRYesM218x0FeIUa79Y3myzMT1g1e/IZ5FuQbHZ09zGr4kHSgygzDSdc89qa9t6y
 mV0Ylnyg7/douH3lqOu53IoS8kPR/LSkCeiWce/FA0M3gIbOXwymbSaV9svHYMmf
 0+yN62njH+2t9phnP3S+5L9Bzr5K7crpXwBYCUVv8goRgECizVsYQyPmaJQrJqQX
 pnxJQ6wAk5LkiamRSHRHl+9u9Nb+oHPLsX5wcTOK/bwee/wN1/9VjTaEa7UJMeuM
 pIcEMpWLyodDTrdMZ98tg==
X-ME-Sender: <xms:mV9oZhuVUAa9AHqLidmNU-usRtw345b3VZSqvjqW6uLFw-v4iyNZkw>
 <xme:mV9oZqfaHz1-ZqQatUwhz_T0wTLqmbMfs8WaR4YHTLf_tNakFKAgt70sroWQI7-QM
 LAvl9gae7zwip6l2dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgjeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:mV9oZkx7VgCPI1cABKxxNcyyGr1yVbMybyoX6otiDyhbTtS_16CcQQ>
 <xmx:mV9oZoMzjK623b8ONWJ2g1gZfu0l0EJxFrc4NyjTzFkdLl4L9ndmNw>
 <xmx:mV9oZh9lAZuXg2XkfA-cg9_9OGoX7uli4EQlYCqw_zW4yN9pc6pBCQ>
 <xmx:mV9oZoWE7Nur9eRv2xO4yTmFQkPlel4xLQKrepiTCTprbjU63iOaDw>
 <xmx:ml9oZtbIXcXWl_9SuL3y1nite2u8Wq1l16hyMsKdXnh1cm6h5fxku7Vy>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B161736A0074; Tue, 11 Jun 2024 10:30:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <e155cd79-aa2c-47e0-ac8c-61477d9843f9@app.fastmail.com>
In-Reply-To: <85599d13-b610-4735-8461-6793a45eb4ec@gmx.de>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-3-79096e3ca3b3@flygoat.com>
 <CAC_iWjK+KdrYWWfdVVqzyzUia+b7sddKHPF+ziQFp_Am0CbzQQ@mail.gmail.com>
 <c789596e-d676-4fcd-a25b-4311257a9153@app.fastmail.com>
 <85599d13-b610-4735-8461-6793a45eb4ec@gmx.de>
Date: Tue, 11 Jun 2024 15:30:32 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>, 
 "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 3/7] Makefile.lib: Preserve .rodata section for EFI file
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=883:28=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> We have:
>
> arch/arm/lib/elf_aarch64_efi.lds:26:            *(.rodata*)
> arch/arm/lib/elf_arm_efi.lds:26:                *(.rodata*)
> arch/riscv/lib/elf_riscv32_efi.lds:26:          *(.rodata*)
> arch/riscv/lib/elf_riscv64_efi.lds:26:          *(.rodata*)
> arch/x86/lib/elf_ia32_efi.lds:35:               *(.rodata*)
> arch/x86/lib/elf_x86_64_efi.lds:37:             *(.rodata*)
>
> Not considering .rodata in objcopy looks inconsistent.
>
> As we use -fdata-sections wouldn't we expect a .rodata* section per
> function with constants on LoongArch? Shouldn't we use:
>
> + .dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc -j .rodata* \

That makes sense, will take in next version.

Thanks
>
> Best regards
>
> Heinrich

--=20
- Jiaxun
