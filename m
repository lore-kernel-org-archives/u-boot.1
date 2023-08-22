Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E26DEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 13:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F1B8648E;
	Tue, 22 Aug 2023 15:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GYa+Oxmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE355864A3; Tue, 22 Aug 2023 15:35:58 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7D3C86297
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 15:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fe61ae020bso6828008e87.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692711355; x=1693316155;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uXGsq/z+wQcYHfjsphZ76QdV7D18eRCddDwK5qXXrig=;
 b=GYa+Oxmgp2KZl5P657QvdsU/n01S5n0QnR9BWCkjfj1W3m9p4AbVGGb9V6hQCpUjBZ
 4BrhDLUMjO0y8sugCk8kV9fHw2fks5wMt4d0IvhJf0kSQMGhbVnPXczJPkou+hEhgLbq
 syJ7MG127wJAn+pEaqMA+kb6/EK/SDGKR7/jEPLWcZhFob4fQf76u763eRkX1dRYnWIg
 Kn7nUBGuvwapNEyL26N8bj202XaMZ8fzeCfdNYm4qCShv9Uw/Sl2XhzgYibFByqn7wuR
 Holcwyx3mnJzxvfpm9Cevu10bsSipTajc9Jt6b7wtUik9W5SkuiBTKnFosJYTidIqy4n
 QEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692711355; x=1693316155;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uXGsq/z+wQcYHfjsphZ76QdV7D18eRCddDwK5qXXrig=;
 b=KbatCsEu+hiIrCVA+ot6qB8ezslDIX3R5VZr0BPTE+7xNI58ZFUSc+DkKnp2fbAbI2
 scbX2v/bMrcpUKb7Zw1EyZkK1+NUHUH6WW9BgTE50Fqj6xM33WDVOHmLdNOZiExowVo0
 OTYZ9/cwfcU4FR3DD8AJFtL14g59cz0gI5WfXfMWab757EIClRAtn1XOZX6PIzKzcDcb
 qXu+0HnCgbBs3wZRxnvlIa6v8PYO1Fz8pHmMqGeUUmhsL8Sisu/7LL7BS6xhsXi2giDl
 S0BC+AV4oIRmEOWSb5cCWeilF/3LSzYAjb8InnxoCj4MHwjxqSTZSSQhzOj4WhSSM0RQ
 BQqg==
X-Gm-Message-State: AOJu0YwVCmGbKbObaNf1+xWJN7MR6jyhJ+fSxsqo321XWx+sGwkZPh3o
 e1EM+Ec9QNnGVHNWaDJxuPk=
X-Google-Smtp-Source: AGHT+IEPjpCypfcRNmNwJcbq/m3ngV0ZPd1iMXClK2StjvuL4JjRYhn6sDrd5VxpgPxs13TpAA1ymg==
X-Received: by 2002:a05:6512:2506:b0:4f7:6685:2c5f with SMTP id
 be6-20020a056512250600b004f766852c5fmr8822883lfb.61.1692711354628; 
 Tue, 22 Aug 2023 06:35:54 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.19.215]) by smtp.gmail.com with ESMTPSA id
 w9-20020a056402070900b00525683f9b2fsm7571535edx.5.2023.08.22.06.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 06:35:54 -0700 (PDT)
Date: Tue, 22 Aug 2023 16:35:53 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <thierry.reding@gmail.com>
CC: u-boot@lists.denx.de
Subject: Re: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <20230822131305.GM3953269@bill-the-cat>
References: <20230818133923.286332-1-thierry.reding@gmail.com>
 <20230818164943.GZ1515023@bill-the-cat>
 <0C415156-B22C-4B86-94C6-1D03ED4287ED@gmail.com>
 <20230818170447.GA1515023@bill-the-cat>
 <5DFCCFFB-D137-4530-8AF9-C72071842A60@gmail.com> <ZORmfDblupZkjoh-@orome>
 <20230822131305.GM3953269@bill-the-cat>
Message-ID: <2FC03DB7-07CC-47A6-BA4A-34789E4DDA16@gmail.com>
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

22 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 16:13:05 GMT+03:00, =
Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0):
>On Tue, Aug 22, 2023 at 09:40:44AM +0200, Thierry Reding wrote:
>> On Tue, Aug 22, 2023 at 08:16:29AM +0300, Svyatoslav Ryhel wrote:
>> >=20
>> >=20
>> > 18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 20:04:47 GMT+0=
3:00, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
>> > >On Fri, Aug 18, 2023 at 08:02:30PM +0300, Svyatoslav Ryhel wrote:
>> > >>=20
>> > >>=20
>> > >> 18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 19:49:43 GM=
T+03:00, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
>> > >> >On Fri, Aug 18, 2023 at 03:39:22PM +0200, Thierry Reding wrote:
>> > >> >
>> > >> >> From: Thierry Reding <treding@nvidia=2Ecom>
>> > >> >>=20
>> > >> >> Hi Tom,
>> > >> >>=20
>> > >> >> The following changes since commit 68c07fc5fdf34f0926cf06fc0c4e=
bd6f2f3afe19:
>> > >> >>=20
>> > >> >>   Merge https://source=2Edenx=2Ede/u-boot/custodians/u-boot-usb=
 (2023-06-21 14:42:50 -0400)
>> > >> >>=20
>> > >> >> are available in the Git repository at:
>> > >> >>=20
>> > >> >>   git@source=2Edenx=2Ede:u-boot/custodians/u-boot-tegra=2Egit t=
ags/tegra-for-2023=2E10-rc1
>> > >> >
>> > >> >FYI, in your =2Egit/config you can do:
>> > >> >	url =3D https://source=2Edenx=2Ede/u-boot/custodians/u-boot-tegr=
a=2Egit
>> > >> >	pushurl =3D git@source=2Edenx=2Ede:u-boot/custodians/u-boot-tegr=
a=2Egit
>> > >> >
>> > >> >And this part looks "nicer"=2E  Not a big deal, just an FYI=2E
>> > >> >
>> > >> >> for you to fetch changes up to bdf9dead86f06c7d6980c399a4a63394=
30b531ec:
>> > >> >>=20
>> > >> >>   board: htc: endeavoru: add One X support (2023-06-30 15:20:37=
 +0200)
>> > >> >>=20
>> > >> >> This passes CI successfully:
>> > >> >>=20
>> > >> >>   https://source=2Edenx=2Ede/u-boot/custodians/u-boot-tegra/-/p=
ipelines/17411
>> > >> >>=20
>> > >> >> Thanks,
>> > >> >> Thierry
>> > >> >>=20
>> > >> >> ---------------------------------------------------------------=
-
>> > >> >> ARM: tegra: Changes for v2023=2E10-rc1
>> > >> >>=20
>> > >> >> This adds support for various new Tegra30 boards (ASUS, LG and =
HTC) and
>> > >> >> has some other minor enhancements, such as enabling the powerof=
f command
>> > >> >> on several Tegra210 and Tegra186 boards=2E
>> > >> >>=20
>> > >> >> ---------------------------------------------------------------=
-
>> > >> >> Jonas Schw=C3=B6bel (1):
>> > >> >>       configs: tegra-common-post: make PXE and DHCP boot target=
s optional
>> > >> >>=20
>> > >> >> Svyatoslav Ryhel (6):
>> > >> >>       configs: tegra-common-post: add GPIO keyboard as STDIN de=
vice
>> > >> >>       ARM: tegra: add SoC UID calculation function
>> > >> >>       board: asus: transformer: add ASUS Transformer T30 family=
 support
>> > >> >>       board: asus: grouper: add Google Nexus 7 (2012) support
>> > >> >>       board: lg: x3: add Optimus 4X HD and Optimus Vu support
>> > >> >>       board: htc: endeavoru: add One X support
>> > >> >>=20
>> > >> >> Thierry Reding (2):
>> > >> >>       ARM: tegra: Enable poweroff command on Jetson TX1 and Jet=
son Nano
>> > >> >>       ARM: tegra: Enable poweroff command on Jetson TX2
>> > >> >>=20
>> > >> >> Tomasz Maciej Nowak (1):
>> > >> >>       ARM: dts: trimslice: sync SPI node with Linux dts
>> > >> >
>> > >> >Since I'm not sure if this is v8 or v9, given when v9 was posted,=
 I've
>> > >> >applied this PR now, as I had said I wanted this in=2E  I do have=
 two
>> > >> >requests for you Svyatoslav, however=2E  First, if there's change=
s that
>> > >> >are missing in master, please post those ASAP and we'll get them =
in, for
>> > >> >v2023=2E10=2E=20
>> > >>=20
>> > >> Patches Thierry applied are v8, while v9 has significant improveme=
nts=2E
>> > >
>> > >OK, I've updated patchwork to try and reflect this too=2E
>> > >
>> >=20
>> > Merged patches are not the most recent I have sent=2E How to fix this=
?
>>=20
>> Usually once something has been merged it's difficult to back it out=2E=
 So
>> unless Tom can (and is willing to) somehow redo the merge with the
>> newest patches, you're going to have to rebase what you have and send
>> out as follow-up patches=2E
>
>I would hope that locally, doing a git diff between master with this PR
>applied and a branch with v9 on it instead would yield a set of changes
>that are easy to turn in to a follow up patch or series of patches=2E I
>really don't want to revert the merge and bring in a new PR instead=2E
>

Alright, done=2E
