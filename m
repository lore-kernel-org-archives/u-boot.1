Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3869C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E599C88258;
	Tue, 11 Jun 2024 16:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="IeKLdkyn";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFIoiZ0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E9AC84374; Tue, 11 Jun 2024 16:01:22 +0200 (CEST)
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com
 [103.168.172.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A36885F6
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 1AD1A138008E;
 Tue, 11 Jun 2024 10:01:19 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 11 Jun 2024 10:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718114479;
 x=1718200879; bh=z3s08QSrPxcGODb+kU/nvG61Q4RZi+c+khbFvmsd6eo=; b=
 IeKLdkynLShAY1nAmIq9VymxPH7suhcEYzLlyjifmTm0n9TJaqzYisDS+4F7ZpLc
 3RdUG5fDXtD+IxbrnQvKfDK+p6YOIKxTPiNv3ETtsmisSgZK5H6BC3asxTgeEWf1
 0bWthGFVecof009XjSgt6DncHZNAwcmQup+AZJSC6XwoZAWmTsxO8ci+5CvN9Hf2
 KJYqAaMICsQVTTXNWH5BmnRZpN6lgf776Rn2ifSzeyXnUXsmTP+tdMPbNjuGAy5D
 H2+U6c0MeEadF6pDUqW88EqJCyc1oG2bFofLX7XFMT+YslbdxG/TAUobufz7Raqm
 /wAsg5zZGaYXg13V/aD94Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718114479; x=
 1718200879; bh=z3s08QSrPxcGODb+kU/nvG61Q4RZi+c+khbFvmsd6eo=; b=c
 FIoiZ0qxnhG8f36BtJWewHayp9FxWTP8hpOeqY3oV7wqGvNDnqyAPWlsfKo1yNds
 4nJBfgQKUFOYso6ZgD23gouhnEHfCKKcSosnJSOl/DSbDWMen7H0PB/WsFfdug4r
 K3Khvon2zFs8cBAYKOXV1ZmPGRuk4QO3uJ2pEVBAKR+mRgB+7fWZyP+SuNf0fMUQ
 l1CJla5a/cA4WNoTjtLiOmrJ5GIr71wpFs5Opb1zYJJviU5lXyeTb83c5L08y2KN
 2NuiR7SjmriHPamQ82XYjWG7sPCxiTHOvZtNxDvOJQi/a3rjSUUzBakOG80D/2AV
 6aXGJZsp1nUz8cKXbPayw==
X-ME-Sender: <xms:rlhoZlqbKKz3_LIXXSK56XTfeMBRyrjaYPiB4uZBzy6_-pay3X3lgw>
 <xme:rlhoZnody1MzY7w-W8c6y11RUHGJQxSSor0o5DuEAm3wt2d8ML4t6P7y5LJmGVpRz
 a4Ns25D-5If3xqNcQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:rlhoZiOBzxkFB66o_bG2N7xU0-d7sM_MT5Nu9tpZ_J-EouVlZF6jgA>
 <xmx:rlhoZg7ahhbuC9eQeGHWPsq3R9tV0Aafq8h0B517cTKIciImNJduGw>
 <xmx:rlhoZk4wfyRmjee6d4EMm9yZWy2QHi1QZid4jp1xuqWUEYRcI6aIDg>
 <xmx:rlhoZohBXHwOlfGdKHtR5HmyeWGj_MJ1j-czbQKhwGn2jmqF5vJzlQ>
 <xmx:r1hoZv2WTkla5osaJKMN1JJHRJQ_Rp70mwqHDwIjGcwjhkrrORLyoHp1>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 9F5EB36A0074; Tue, 11 Jun 2024 10:01:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <cdb2ba34-09c0-47f3-b72c-4099b48a6946@app.fastmail.com>
In-Reply-To: <20240611135209.GB68077@bill-the-cat>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-3-1407e0b69678@flygoat.com>
 <4887f128-786d-4d07-8dec-79ef75e39509@gmx.de>
 <43b029fc-2910-455c-93d7-6555c65bf189@app.fastmail.com>
 <20240611135209.GB68077@bill-the-cat>
Date: Tue, 11 Jun 2024 15:01:00 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Tom Rini" <trini@konsulko.com>
Cc: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 "Simon Glass" <sjg@chromium.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 03/16] image: Take entry point as an output of setup_booti
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
=8D=882:52=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Jun 11, 2024 at 02:29:38PM +0100, Jiaxun Yang wrote:
>>=20
>>=20
>> =E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=882:02=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
>> > On 22.05.24 17:34, Jiaxun Yang wrote:
>> >> For LoongArch the start of the image is not the entry
>> >> point to the image.
>> >
>> > Looking at arch/loongarch/kernel/head.S there seem to be two cases:
>> >
>> > * The kernel has an EFI stub (CONFIG_EFI_STUB=3Dy).
>> >    The legacy physical entry point is available at offset 0x08 of t=
he
>> > header.
>> > * The kernel has no EFI stub.
>> >    The kernel entry point matches the start of the image.
>> >
>> > Where do you differentiate between the cases?
>>=20
>> Hi Heinrich,
>>=20
>> In case there is no EFI stub LoongArch would use elf format vmlinux, =
there
>> is no real "raw" image for us.
>>=20
>> bootelf can't be used at the moment as it doesn't setup FDT and other=
 environments
>> properly.
>>=20
>> I'm planning to implement a bootlinuxelf command for this case, as MI=
PS, LoongArch,
>> xtensa are all using ELF as default kernel image format.
>
> Please note that we have CONFIG_CMD_ELF_FDT_SETUP already, so adjusting
> things so that bootelf works for this case should be doable without a
> new command.

This is a little bit broken as then you'll need to bring architecture sp=
ecific
functions to bootelf to setup boot registers, initrd etc. It's fine for =
Arm64 which
you just need to throw fdt into a location in memory but for MIPS and Lo=
ongArch=20
you have to setup a good deal of other stuff.

Ideally those setups should be done with bootm_run_states as what we've =
done at
booti, but that would be a semantic to bootelf command. I know many exis=
ting
MIPS bare-metal applications rely on argc/argv style bootelf and I don't=
 want to
break them, thus I think a new command is necessary.

Thanks
>
> --=20
> Tom
>
> =E9=99=84=E4=BB=B6:
> * signature.asc

--=20
- Jiaxun
