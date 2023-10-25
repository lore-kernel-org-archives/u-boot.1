Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE47C25B48
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 00:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE3A87987;
	Wed, 25 Oct 2023 02:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jFfX44Yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0C087987; Wed, 25 Oct 2023 02:20:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC779879A9
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 02:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698193201; x=1698798001; i=xypron.glpk@gmx.de;
 bh=OnHlkSEcLaRTfLjY4hq9ESumsGGRBKvbxdPdb6u3dWg=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=jFfX44Ybl4TpebntTyH4q5KM6hIVIvQZR8uw0brHLVlQwAiii4pjYWnDij2dbIK1
 mGIRv5dexMa0rSVD5BE8INrZJoJm6UAdFOTX1dMiTT+NZkTj4UTilGINoQzXvycAi
 GcH3wzqpqm4Qec1eH1sSG7ZbnPGz2vd3SOq6V2WDDMjJGKmXDX0LgAaCTQTXc92uU
 9tqY9ZMJAVLOmXrO0RC9Gt725xF3OtFxG6C41ZLYoqeW3l2YiremlkhKMTL55Bh8l
 UZaH4naYYagYqF3+AEP8PKJYe7Rz21ukwwXNvPbRefaQh6GrVgmL4JdPQRHhlV7Dw
 4/HOGaBBBAzBTxLBxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1rS0UJ31Ve-00fOSq; Wed, 25
 Oct 2023 02:20:01 +0200
Date: Wed, 25 Oct 2023 02:19:59 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Mark Kettenis <mark.kettenis@xs4all.nl>, caleb.connolly@linaro.org,
 u-boot@lists.denx.de, ilias.apalodimas@linaro.org, bmeng.cn@gmail.com,
 brandon.maier@collins.com, kconsul@ventanamicro.com,
 oleksandr.suvorov@foundries.io, patrick.delaunay@foss.st.com,
 sughosh.ganu@linaro.org
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ1h2GUWKupVJcNEQmQd1JJf1h9X+xkc3P=+qxmfCwAcOA@mail.gmail.com>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <CAPnjgZ1h2GUWKupVJcNEQmQd1JJf1h9X+xkc3P=+qxmfCwAcOA@mail.gmail.com>
Message-ID: <5F047C34-685E-41E9-A726-6003B8FCFB56@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ga8hLaiiF9i4+Ruxs01/bF22cEyZLF5F2Sr/a6jZ+rmcsfPBAzj
 FS6c+Urw2xAjJfyvA+zr8Hyuy9qC5PsVs0DBLACCO3sJnkKKWjCmW0u5Wl1tCBlEZpjFzWR
 g9ECybkTlt2EggzbQktPltg1OcIjkNeebQGKQwBgiR1pTsAbdAXepGDFz+HDuY+IbLTnEg7
 nRxSwTEaXleoxP+HcX8Wg==
UI-OutboundReport: notjunk:1;M01:P0:zP52cQJpHjw=;T6gT60s5rD135PTWosJ6h5iQLPL
 EDN2oJptvcKer6RrNVNpqD74FwsmzA7gszX333ATe7FTPyxfNv2MMpifiKf40dLVfj8RU1SEM
 gTGNlydcDVSHBjSuVCFHn/eVAmHijg+DsaRZnJHKT+HKCif95g6eYo3WRenWTJ3Jn4tQar++h
 21RJJ8hhgYV87vDFcmzwlI5DbV2SWBR/vdQN7KLHJbGR9RqkCVq1bC+UHtbRrozedlJUBwNiq
 09UR52VT/ux63MiJnyYEY2U8oow8QSbHkt5dLpEKGVcGiweX/YB6ZGHXhCzC2hfl/nwtwmbN8
 09lsPT6VnkpdI6Z5bjjFTTqpwNgimdxyOgKhfkjNjhW/73/fOFKa9SO8HxKGmOMxV8x8pAcFR
 5/sjbOVWKow6PPlNJSbfdgJCNelEcXvogiCRG6+fEE7R14U+ed3UACt/gonhRYqqjTGysrbDr
 zIZ7U7zqOWYl0Qy/b0ep2rGsBCe/AcKf0u/yrhniTczAr122jyaXuF7u0P3AnhMRAKzO/1c7h
 VtBeVZwee4YYAKCzHU9nk+kUUQ6bn0SgraDs5x11abYffRdh5VRC6g0/ctLQyVXjrB+evCTbP
 xBj0fnvoyeIugYPU+ZL7Z5h7At3x9Wu3m0XkTvRmytcvw6QSVowvb565ijLY0z9o9DWZgMGMm
 KJHZlQxtaVjgJaomR7h1/Vdb5oKdEl3gfGwaZWy1TLJ2iWKsSzOBTfIv+BTsWX0WA0h+g7h3K
 E13+xq9m5TnQqccRaVFUno91AVmr352yO+Mo5rvMrIEa5NbFod0cs6hgRWOdjZ/uIiIJlU8bb
 pmuLhsxCO/pGmRl4rBhSwtbzqSuT6qnh1NwH2x9a8cFl2QHiOV7+s5sv9wD4a/VAjDwdvzpyh
 NMUEKKP18M3u+Psyq/U/fPCKLIuHGptdDJTyVj01+G9y1hb3rvT4h3OUiffnfALw1yX4GD/WL
 17b6LfyfIopLOruDB5Dybo0wRF8=
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



Am 25=2E Oktober 2023 01:28:10 MESZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Tom,
>
>On Tue, 24 Oct 2023 at 15:34, Tom Rini <trini@konsulko=2Ecom> wrote:
>>
>> On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
>> > > From: Simon Glass <sjg@chromium=2Eorg>
>> > > Date: Mon, 23 Oct 2023 00:04:14 -0700
>> > >
>> > > Hi Caleb,
>> > >
>> > > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb=2Econnolly@lina=
ro=2Eorg> wrote:
>> > > >
>> > > > Hi Simon,
>> > > >
>> > > > On 21/10/2023 01:45, Simon Glass wrote:
>> > > > > U-Boot typically sets up its malloc() pool near the top of memo=
ry=2E On
>> > > > > ARM64 systems this can result in an SMBIOS table above 4GB whic=
h is
>> > > > > not supported by SMBIOSv2=2E
>> [snip]
>> > There is absolutely no guarantee that arm64 machines have memory belo=
w
>> > 4GB=2E  Examples of SoCs that have no memory below 4GB are AMD's Opte=
ron
>> > A1100 SoC and all the recent Apple SoCs=2E
>>
>> So one thing to resolve here is where does that requirement about the
>> SMBIOS table needing to be below 4GB come from (standards wise), and in
>> turn is that obeyed by consumers like say Linux or OpenBSD? Answering m=
y
>> own question, maybe in part, https://www=2Edmtf=2Eorg/standards/smbios =
reads
>> to me like there's a v3 and maybe we should be doing what we need to
>> support / identify as that, if it doesn't have that restriction?
>
>Yes that was my previous patch=2E However 1) we apparently don't want to
>use SMBIOS3 and 2) my patch had some sort of bug so that it wasn't
>read correctly=2E
>
>So my next version is going to be along the lines of what was discussed h=
ere=2E
>
>Of course, we cannot solve Mark's problem with SMBIOS2, but I suppose
>that is obvious=2E Anyway, those platforms probably don't need SMBIOS=2E

You are heading in the wrong direction=2E We need SMBIOS 3=2E SMBIOS 2 is =
only a fallback for outdated tools=2E

Upcoming mainline RISC-V platforms will also have memory starting above 4G=
iB=2E

Best regards

Heinrich

>
>Regards,
>Simon
