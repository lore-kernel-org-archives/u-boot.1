Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006B3D743D8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 20:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B24894A2;
	Wed, 20 Nov 2024 21:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hw8P9gCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C29C58925A; Wed, 20 Nov 2024 21:06:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2448910B
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 21:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732133138; x=1732737938; i=xypron.glpk@gmx.de;
 bh=nZoOuUqsnIRBKNSiqPpdrFJK0Q5HQSOLN2z8lStHy6Y=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hw8P9gCQCpI/xmqczGZkCeFpBJTO8YJF6DExGjh90FuareSEz43Cu7keb40zc9tu
 QXxcs9RhRHsuEvSI2c0ul/9DqArgOGlv0uEE6BZYDKj+AUoG71EDcjxPoqP0sy5De
 5NuSiP+JnNYr5eb3HuS/vvHsU58jlPPW2/lnz2I1bMTlSUTtAIGUC9f++Ue0BoM6O
 ThrVoGRDwr2fpu28e1BFxr1stDnb6XJs9gV1k0+oCBt2WFpzalpjVgRlftvsm2Vzb
 8y511TPyxbd0/+nwFAANu9v6rJxQQpLA5v+nSZZqTgtfm9tQg0Sz/sh7KpXa1tB0Y
 HoirAfSBb0alo23msw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.107.239]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1tAIBi3kIJ-00GusX; Wed, 20
 Nov 2024 21:05:38 +0100
Date: Wed, 20 Nov 2024 21:05:22 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Levi Yun <yeoreum.yun@arm.com>,
 Marek Vasut <marex@denx.de>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 Wei Ming Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH 00/15] efi_loader: Add support for logging to a buffer
User-Agent: Thunderbird for Android
In-Reply-To: <20241120180633.GE3600562@bill-the-cat>
References: <20241028124815.47262-1-sjg@chromium.org>
 <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
 <CAFLszTj9Dc-uF=GjSyxTue5Sw3ohUnDaAnAc5sz2dxfQ3gEuxw@mail.gmail.com>
 <CAC_iWjJkAfJHp_NDXJMfNPe7OhBp6B_WBMxvwU_qHU5tamm6ZA@mail.gmail.com>
 <CAFLszTiL88dHANMHo1bK2Uj5K1-7B56_Uk8keSQTo6FUfUoOVQ@mail.gmail.com>
 <CAC_iWjJOFv1v5VPoJ2UEu1YR84i1GUdB7tEng-uqgZ+6o_XWZw@mail.gmail.com>
 <CAFLszThCONSk2v30pGDGyGjz9mz2X0mtpqGCWSZJdbAuDaT0bw@mail.gmail.com>
 <CAC_iWj+g1nMA1DrWjguP=YiQhKOmyGKyu233Eb6Zjcv0x4yatA@mail.gmail.com>
 <20241120180633.GE3600562@bill-the-cat>
Message-ID: <ED2EDEA3-44B9-48BC-9531-FE061A18F6D8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nWwkvVirD+6b9aP7GDG7cyIfnPP0Nrb2w57lClzFd6pjjYX+TfB
 vH0TGUY3/ts+niuHGY8cpH0O+yy6N6P/MKEGiiF8qZErpRaDnIdcRFu34r8BTGjhFmvn8Db
 2z3lXOubN5Zd0hPydfHaQg4whT1VKDDRWjLAzmVI6bFf1ILnJBWJfVWvbWLWJhwad73JWP5
 nL898e6mz5pD5EMvCzqLQ==
UI-OutboundReport: notjunk:1;M01:P0:QJxQfU2JjkE=;5XruOY3HINTvdWlEm050iQjHWvJ
 fIcgQeuFr+ySUtoEQ7aez8irtrXg92cmuIdh+x9GhSgdKtPPH0E+ota7OLqRXWZ9pRrMBSrKR
 P+pMg0JCitBDIIBEKvLcyseczfkVcpj8U31Dq3Pk/isMe5SVEyipPuQYEL4Cz3tv1yU40GwcU
 mnGbu0YEHDjazqueWBPHYvnyOaEP10izJC/ganxC4wJdQgYJhIyGsgUWawHCYqv9uGYyhepi2
 TjDTaNK2ezw5rROvjX3ky0OhH+ZVCzphDc1vzVPDAMb/Ha6CmVG9ewxcqq4ntQnU0XSJPMKCy
 mCKFqA4w05cFGRqQB/NTnsnS0QZLuk41y1vvSHXYoaFX6mBr9Soq776o8eQHo5hHukVDtkRpk
 U3/nooAYbrbwjL8B1AolkXa02R/4M5USfVSsP/uSI9Ic0VT8/4ad9s7Q6HCDThDumlioNunhP
 XHol/TZxuaI2WPiNR5adRV6s6cMinqXAFy5AeR8y4VSMOu5riz65rzvnEKDoJvTNQWrOBgjxs
 xv2cJhdkLLASV/IsxhM/9+1bIbc17peAoYJXpEiIRv3pBRZPVQcAoCtl51Fju5kDVFqRq4mLo
 /ePjoasYckzlYqm/+d85CYJG9Lov6qrv52Rc6sNdJArL+Ma8UiISL22IikP5TILmtCXbql5Lq
 wQdoZKSGtjAYPvtRK8mJMMw72E+PUeoXtEzdzrXCXxGJHsDHOas20pQiLQwU5XKxGNnJMeI+8
 hwkV0riKnK/+cpuvxTfmDsQWBmjC6Xx+fURWZqNIXvT+K53Zt2z38nN166KZK93cuZsmd+Ul2
 Qb6UGtWfdS0JKFByjgGQck5YADro/+Vp7wF5hPJnq8EMxweMu+nlDID7OexwQGpXS3qNFM4T3
 WRqivVFp5I8LWYo4Ufyhb6PRsDgvpj3UVgW1S/yEuCDn55+gmS+JIPrLJ
X-Mailman-Approved-At: Wed, 20 Nov 2024 21:41:16 +0100
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

Am 20=2E November 2024 19:06:33 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>=
:
>On Wed, Nov 20, 2024 at 05:55:18PM +0200, Ilias Apalodimas wrote:
>> Hi Simon,
>>=20
>> On Wed, 20 Nov 2024 at 17:37, Simon Glass <sjg@chromium=2Eorg> wrote:
>> >
>> > HI Ilias,
>> >
>> > On Fri, 1 Nov 2024 at 05:32, Ilias Apalodimas
>> > <ilias=2Eapalodimas@linaro=2Eorg> wrote:
>> > >
>> > > Hi Simon,
>> > >
>> > > On Thu, 31 Oct 2024 at 20:02, Simon Glass <sjg@chromium=2Eorg> wrot=
e:
>> > > >
>> > > > Hi Ilias,
>> > > >
>> > > > On Tue, 29 Oct 2024 at 19:32, Ilias Apalodimas
>> > > > <ilias=2Eapalodimas@linaro=2Eorg> wrote:
>> > > > >
>> > > > > On Tue, 29 Oct 2024 at 17:45, Simon Glass <sjg@chromium=2Eorg> =
wrote:
>> > > > > >
>> > > > > > Hi Ilias,
>> > > > > >
>> > > > > > On Tue, 29 Oct 2024 at 10:58, Ilias Apalodimas
>> > > > > > <ilias=2Eapalodimas@linaro=2Eorg> wrote:
>> > > > > > >
>> > > > > > > Hi Simon,
>> > > > > > >
>> > > > > > > On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium=2Eo=
rg> wrote:
>> > > > > > > >
>> > > > > > > > It is a bit of a pain to log EFI boot-services calls at p=
resent=2E The
>> > > > > > > > output goes to the console so cannot easily be inspected =
later=2E Also it
>> > > > > > > > would be useful to be able to store the log and review it=
 later, perhaps
>> > > > > > > > after something has gone wrong=2E
>> > > > > > > >
>> > > > > > > > This series makes a start on implementing a log-to-buffer=
 feature=2E It
>> > > > > > > > provides a simple 'efidebug log' command to inspect the b=
uffer=2E For now,
>> > > > > > > > only memory allocations are logged=2E
>> > > > > > >
>> > > > > > > Why is this problem specific to EFI and no U-Boot in genera=
l? Do we
>> > > > > > > have a similar machinery for malloc()?
>> > > > > >
>> > > > > > Mostly because an app can make EFI calls and we want to know =
what they
>> > > > > > are, e=2Eg=2E to debug them and figure out what might be wron=
g when
>> > > > > > something doesn't boot=2E
>> > > > >
>> > > > > EFI_PRINT() has been proven pretty useful for this=2E I don't p=
ersonally
>> > > > > see the point of adding ~1300 lines of code to replace a print=
=2E
>> > > > > What would make more sense is teach EFI_PRINT to log errors in =
a buffer=2E
>> > > >
>> > > > Is that a NAK? Please be clear if you are reviewing the code or j=
ust
>> > > > rejecting the whole idea=2E
>> > >
>> > > For the idea, no=2E But I don't think what's implemented here is wh=
at we want=2E
>> > >
>> > > To track what EFI services are called, we already have EFI_ENTRY an=
d EFI_EXIT=2E
>> > > Why don't we instead, add a logging service (and we already have
>> > > ftrace iirc) and plug it in the macros above?
>> > > That would make more sense not to mention way less code=2E
>> >
>> > I am wanting to programmatically log and manage what EFI_LOADER does,
>> > so that bootstd can present a high-level view of what is going on,
>> > e=2Eg=2E which protocols are used, how much memory is allocated and w=
here=2E
>> > So this is not just about logging text output=2E
>>=20
>> Why the EFI_LOADER only? Bootstd is supposed to cover more cases, so
>> why not a generic framework for all boot commands?
>
>This feels similar to the point I've made elsewhere in this overarching
>series, why not do this at existing common points in the code path?
>

The common code point is the log library=2E Just add an event there for wh=
ich the test can register a handler=2E

With a log event you get:

function name
source location
message class
message text
message priority

and all of this with minimal invasiveness=2E

Best regards

Heinrich


