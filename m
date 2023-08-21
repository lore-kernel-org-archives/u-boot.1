Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA6BEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 14:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09EBE87081;
	Mon, 21 Aug 2023 16:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hAdbE31W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B4AE87081; Mon, 21 Aug 2023 16:10:25 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5615287002
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 16:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fee600dce6so18299035e9.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692627022; x=1693231822;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bsoyDriYeZKGV0ykpjTTz8zsoCxey7uAXOqUzyc/9rs=;
 b=hAdbE31WfvYkzGNLFZ3TLsP156vJwkFGa9t2hmPVPbOf9PAe/OOzfTjupHPGECEuru
 xdVzjbu1KRWeKorIn2K05hpoMkaIDqIxuJKWUkPdynmaFyUg1qxsA8mRnLOkfaOff7F7
 kQP+I3oFccTJGqYSGNR91sjJwGiT42uxqH4lTtCDD5odBWFAHi/K9vfDgxlh4i87vGvU
 P1aiU1Dj1mN4vqNr1/0gLaXiKe9c1doTb9u8SJsmT10tC59fG3hqfs5ZLf8fmoODVtF0
 ORqkq4Y2UkcP4X/bB2UkyxSEmfSs2Ek9a10YR0MXnZqEbhnkL689aFZT4r92SOWPvhLc
 6nuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692627022; x=1693231822;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bsoyDriYeZKGV0ykpjTTz8zsoCxey7uAXOqUzyc/9rs=;
 b=N/aU0nJEu05/cSl5oKo6yBWKooXPcDJQIuPWzbN3RFq7HulOhZwRQMUdaFicGyCcyb
 779HQoknGJL7mgno9AyoAROUMJtDRdkObbKi/4SA7oDacRa3GBPvnqa7OTlaEnur/ktM
 HO0/Can+pGenaukr4d7bjOL6eWX5BrreeLUoxEdDPRJsWaz8VwVR3JOXm0LavBlSAd+O
 4blBm4dfuUI6T9DF8WXdA4wjY6iO4efaS8vRGfmbktJ3i1M3rhQn6eRdt3XakOPNhuKL
 fkOUAu043pey6+0xuiDCmO971+dp0W81EMBVLG+eS7yOalKNoWPjnkQFnEmj8dBXsYwV
 rq1g==
X-Gm-Message-State: AOJu0YwfYu1rwK1WnJPPyJrg6vo7wXpEZnp2EYPK8rqltR4UcyVPM7JY
 nTY3PFTNeaui+rqbQPXgarY=
X-Google-Smtp-Source: AGHT+IEsuQpgpLN13N6d7NEQpcbjBkWuIhmBwYoSyiU4ZOyxBq17YH49+4IcjwzXrQScHiv5Liufrg==
X-Received: by 2002:a5d:4573:0:b0:315:ad1a:5abc with SMTP id
 a19-20020a5d4573000000b00315ad1a5abcmr5027144wrc.5.1692627021564; 
 Mon, 21 Aug 2023 07:10:21 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.148.65]) by smtp.gmail.com with ESMTPSA id
 rp6-20020a170906d96600b0098e2eaec395sm6593672ejb.130.2023.08.21.07.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 07:10:21 -0700 (PDT)
Date: Mon, 21 Aug 2023 17:10:20 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <ZONt3v3Hb8foJdup@orome>
References: <20230818133923.286332-1-thierry.reding@gmail.com>
 <20230818164943.GZ1515023@bill-the-cat>
 <0C415156-B22C-4B86-94C6-1D03ED4287ED@gmail.com> <ZONt3v3Hb8foJdup@orome>
Message-ID: <9D3E6ABB-93E3-43BB-95D7-5D05A2E0A403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



21 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 16:59:58 GMT+03:00,=
 Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Fri, Aug 18, 2023 at 08:02:30PM +0300, Svyatoslav Ryhel wrote:
>>=20
>>=20
>> 18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 19:49:43 GMT+03:=
00, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>> >On Fri, Aug 18, 2023 at 03:39:22PM +0200, Thierry Reding wrote:
>> >
>> >> From: Thierry Reding <treding@nvidia=2Ecom>
>> >>=20
>> >> Hi Tom,
>> >>=20
>> >> The following changes since commit 68c07fc5fdf34f0926cf06fc0c4ebd6f2=
f3afe19:
>> >>=20
>> >>   Merge https://source=2Edenx=2Ede/u-boot/custodians/u-boot-usb (202=
3-06-21 14:42:50 -0400)
>> >>=20
>> >> are available in the Git repository at:
>> >>=20
>> >>   git@source=2Edenx=2Ede:u-boot/custodians/u-boot-tegra=2Egit tags/t=
egra-for-2023=2E10-rc1
>> >
>> >FYI, in your =2Egit/config you can do:
>> >	url =3D https://source=2Edenx=2Ede/u-boot/custodians/u-boot-tegra=2Eg=
it
>> >	pushurl =3D git@source=2Edenx=2Ede:u-boot/custodians/u-boot-tegra=2Eg=
it
>> >
>> >And this part looks "nicer"=2E  Not a big deal, just an FYI=2E
>> >
>> >> for you to fetch changes up to bdf9dead86f06c7d6980c399a4a6339430b53=
1ec:
>> >>=20
>> >>   board: htc: endeavoru: add One X support (2023-06-30 15:20:37 +020=
0)
>> >>=20
>> >> This passes CI successfully:
>> >>=20
>> >>   https://source=2Edenx=2Ede/u-boot/custodians/u-boot-tegra/-/pipeli=
nes/17411
>> >>=20
>> >> Thanks,
>> >> Thierry
>> >>=20
>> >> ----------------------------------------------------------------
>> >> ARM: tegra: Changes for v2023=2E10-rc1
>> >>=20
>> >> This adds support for various new Tegra30 boards (ASUS, LG and HTC) =
and
>> >> has some other minor enhancements, such as enabling the poweroff com=
mand
>> >> on several Tegra210 and Tegra186 boards=2E
>> >>=20
>> >> ----------------------------------------------------------------
>> >> Jonas Schw=C3=B6bel (1):
>> >>       configs: tegra-common-post: make PXE and DHCP boot targets opt=
ional
>> >>=20
>> >> Svyatoslav Ryhel (6):
>> >>       configs: tegra-common-post: add GPIO keyboard as STDIN device
>> >>       ARM: tegra: add SoC UID calculation function
>> >>       board: asus: transformer: add ASUS Transformer T30 family supp=
ort
>> >>       board: asus: grouper: add Google Nexus 7 (2012) support
>> >>       board: lg: x3: add Optimus 4X HD and Optimus Vu support
>> >>       board: htc: endeavoru: add One X support
>> >>=20
>> >> Thierry Reding (2):
>> >>       ARM: tegra: Enable poweroff command on Jetson TX1 and Jetson N=
ano
>> >>       ARM: tegra: Enable poweroff command on Jetson TX2
>> >>=20
>> >> Tomasz Maciej Nowak (1):
>> >>       ARM: dts: trimslice: sync SPI node with Linux dts
>> >
>> >Since I'm not sure if this is v8 or v9, given when v9 was posted, I've
>> >applied this PR now, as I had said I wanted this in=2E  I do have two
>> >requests for you Svyatoslav, however=2E  First, if there's changes tha=
t
>> >are missing in master, please post those ASAP and we'll get them in, f=
or
>> >v2023=2E10=2E=20
>>=20
>> Patches Thierry applied are v8, while v9 has significant improvements=
=2E
>
>I'm a little surprised by how this series developed=2E You've been urging
>me since v6 to apply this, so I assumed this was mostly done=2E Having
>another 3 versions with significant improvements come in after that
>point indicates the opposite was true=2E

View changes, same as code=2E I am adapting and changing this to my needs =
and if you have hold it more, your would get even more iterations=2E Only w=
ay to stop is to upstream=2E

>Thierry
