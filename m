Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C3EC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 17:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8461E88126;
	Fri, 17 May 2024 19:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="r95xXhR/";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0skGkFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901AE8818C; Fri, 17 May 2024 19:40:45 +0200 (CEST)
Received: from fhigh6-smtp.messagingengine.com
 (fhigh6-smtp.messagingengine.com [103.168.172.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7629188093
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 19:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 361A011401AA;
 Fri, 17 May 2024 13:40:41 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Fri, 17 May 2024 13:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715967641;
 x=1716054041; bh=AHZZeSpN5s3qw0SbkktmzkCkiajPaeqQe4zMAyEvYKI=; b=
 r95xXhR/cWqrRLOkV07hIUQZpGKiQa9Rz4Cl9iDhZvlmLTflu2Lqpl1uDFLNu5o2
 XO72EXVht/hucAvkS+VcGP5Ah4/AsFg0i6u3HWMGIepiDzt8HZASF4fZ/Luv3yXv
 RhlkwpJ5d7x6FmfS0+3qtadbbRgMl2ECVNSDwXxZ3TcVytwSRwX/g+jwARunphTO
 vkrBuuhW5+Tz55TQe3iOGGEPlPj+dj+OkHySbzKWcVTSByB9iIYls4mAH/1eANuC
 v3TdQ5T3hu2/Vzr/pHth/NjJC9lxeANAtnDOri6jW9KAo2fSDI7EOfSpCV35Khus
 unhj7FG80wCvmBzkiXyPPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715967641; x=
 1716054041; bh=AHZZeSpN5s3qw0SbkktmzkCkiajPaeqQe4zMAyEvYKI=; b=I
 0skGkFLWV7aFxVGPBRuTDaY/tiDoBxvhS2QDWj1pxEvHNW9SpoSDh9AjM49SI+aL
 vXm1sP8KYRGS0XLyOlZBotSKzYoqfL4bthXdHxVh57JEh3VB5zfxhuGf58V0tr3z
 WLkBmwncUIviQNXFoVRKhCDgxPySyIoT8jNeaZ1eNJ9K2KnU8xbQOd/kY/SFC3eI
 kJZHoslpFrONjIQG7iFo/+jiMXmwU0JfXyF4tESxF2t6qCsZuO6JAxjb3nHFS4gj
 HMasd8M61rABulDf4gc77T39KTVnW1Ige6OM3hDEOmX9TkRPxKi35PTc4Zn+/p9e
 w3OXtSr08HogJ39dJbKJg==
X-ME-Sender: <xms:mJZHZp-kVCOkGI2RZtCH9SKPuJbKINGvtRnoBXLX8N3EWgdM9FlgpQ>
 <xme:mJZHZtsNewOI-TygeSCqM9Xz__U4sPvdFOVzHJ7EnEvVir2jsYYEEdAx2x2o680kZ
 wGIBKekFVYklEJ7dCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
 ufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjih
 grgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeel
 udevkefgvdegvdfgteefgefhgeffffetkeegkefgledujeeiueelleegjeevveenucffoh
 hmrghinhepuhgvfhhirdhorhhgpdgtihhpuhhnihhtvggurdgtohhmpdhgihhthhhusgdr
 tghomhdpkhhunhhluhhnthgvtghhrdgtohhmrdgtnhdpshhouhhrtggvfhhorhhgvgdrnh
 gvthdpvhgvnhhtohihrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
 pehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:mJZHZnAAHLGkBedBUMjU4sJ5Cop4bPdjoCu7-BwLDlzi46CqIT5Mmw>
 <xmx:mZZHZtc7dF0AFUyye5fPZxhKlDaf62r52JiAJ5gZU_ZKIaBm1Q4fbQ>
 <xmx:mZZHZuNouBCyU2wZKhAjtrKQ4yV7_rG13Ae_U0aqGSHtON9W94O4IA>
 <xmx:mZZHZvk269isZTMspRjKIILmI4UDTuHMUXVaQ-ZweXw-b_eQZxBZmA>
 <xmx:mZZHZrqEORcF0hUJ0-8MNRNm-SIrbLPQsA059ywRV_h_kX2KVUA-utXC>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id DBCE036A0074; Fri, 17 May 2024 13:40:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <0153f00e-feb3-45b1-a13b-0b57da90252c@app.fastmail.com>
In-Reply-To: <F673BC88-7C9C-4633-91E6-1994732C5955@gmx.de>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <F673BC88-7C9C-4633-91E6-1994732C5955@gmx.de>
Date: Fri, 17 May 2024 18:40:21 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>,
 "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/7] MIPS: Enable EFI support
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8817=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=886:12=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>as well.
>>
>>Please review.
>>Thanks
>
> Implementing the Loongarch architecture defined in=20
> <https://uefi.org/specs/UEFI/2.10/02_Overview.html#loongarch-platforms=
>=20
> would make sense to me.
>
> Supporting an architecture that does not have published UEFI standards=20
> is less convincing.=20
>
> Is any of the mentioned boards being produced anymore?

Hi Heinrich,

Yes, MIPS/Loongson boards are still producing for many existing applicat=
ions.
There will be some future MIPS product from CIP United [1], and I think =
get
EBBR like booting stuff implemented can save a lot of hassle.

I also intended to use UEFI as loongson3-virt firmware, supporting actual
Loongson hardware is out of my scope.

I'm a hobbyist (and contractor) on MIPS stuff, so I don't really know de=
tails
on LoongArch UEFI.

Thanks

[1]: http://www.cipunited.com/

>
> Best regards
>
> Heinrich
>
>>
>>[1]: https://github.com/kontais/EFI-MIPS
>>[2]: https://github.com/loongson-community/firmware-nonfree
>>[3]: http://www.kunluntech.com.cn/klbiosxl
>>[4]: https://sourceforge.net/projects/efify/
>>[5]: https://github.com/loongson-community/grub
>>[6]: https://www.ventoy.net/en/index.html
>>
>>Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>---
>>Jiaxun Yang (7):
>>      MIPS: Implement setjmp
>>      efi: Allow runtime relocate to be disabled
>>      Makefile.lib: Preserve .rodata section for EFI file
>>      Makefile.lib: Enforce EFI CFLAGS/AFLAGS
>>      MIPS: Add smbios_start to arch_global_data
>>      MIPS: Define MIPS EFI related bits everywhere
>>      MIPS: Implement EFI supporting stuff
>>
>> Makefile                                          |   3 +
>> arch/mips/config.mk                               |   9 +
>> arch/mips/include/asm/global_data.h               |   3 +
>> arch/mips/include/asm/setjmp.h                    |  36 ++++
>> arch/mips/lib/Makefile                            |  15 ++
>> arch/mips/lib/crt0_mips_efi.S                     | 239 +++++++++++++=
+++++++++
>> arch/mips/lib/elf_mips_efi.lds                    | 113 ++++++++++
>> arch/mips/lib/reloc_mips_efi.c                    |  99 +++++++++
>> arch/mips/lib/setjmp32.S                          |  51 +++++
>> arch/mips/lib/setjmp64.S                          |  56 +++++
>> include/asm-generic/pe.h                          |   5 +
>> include/config_distro_bootcmd.h                   |   6 +
>> include/efi_default_filename.h                    |   8 +
>> include/efi_loader.h                              |  26 ++-
>> include/elf.h                                     |   8 +
>> lib/efi_loader/Kconfig                            |  12 +-
>> lib/efi_loader/efi_image_loader.c                 |  18 ++
>> lib/efi_loader/efi_memory.c                       |  14 +-
>> lib/efi_loader/efi_runtime.c                      |  11 +-
>> lib/efi_loader/efi_var_mem.c                      |   6 +-
>> lib/efi_selftest/Makefile                         |   2 +-
>> lib/efi_selftest/efi_selftest_miniapp_exception.c |   2 +
>> scripts/Makefile.lib                              |  10 +-
>> 23 files changed, 734 insertions(+), 18 deletions(-)
>>---
>>base-commit: ad7dce5abd49ef3b5c93da5303e15449c8c162b4
>>change-id: 20240517-mips-efi-c9a1ad819c2d
>>
>>Best regards,

--=20
- Jiaxun
