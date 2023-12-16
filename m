Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD84C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 22:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45B987756;
	Sat, 16 Dec 2023 23:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jZWwvrRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 025F787784; Sat, 16 Dec 2023 23:30:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CFFA87730
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 23:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702765833; x=1703370633; i=xypron.glpk@gmx.de;
 bh=wUDD4U5tW7bhW6gmxpw5rHvEAUOnlbh4Ut7wAzPOe2U=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=jZWwvrRsds01D685qmHGmg4zwQN/x1OZjrFhB06N5LokteZ64SBS9m6XRGOL7tem
 KRJeLTFoCZXXI3bUdkH5DENb945sb9RWqksSMWa88lA/PHuIbggW17BOj1Ub0SaRk
 gHcv/Q8lHnT+2i3dHvj4IOBQMg6LCHG/JpShzUZIIUYvyo1TH95XPd/nV118c5V6A
 RvxsRChWwBJWszpdbn0rAxG1qM9a68gpR9yPcLqZ0bk3M5ayfnQrd421Qr8cMhpzG
 ju3z+VyRwLN3PbtLsMPYQyKOKc3WwG6qlR9ErhGdDeu0d+H9U0R4GEb8uy5x4C9bx
 cHjN/OsQdFULmVJEhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1qtG2Z2M8M-00LUcl; Sat, 16
 Dec 2023 23:30:33 +0100
Date: Sat, 16 Dec 2023 23:30:32 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/3] efi: Avoid using dm_scan_other()
User-Agent: K-9 Mail for Android
In-Reply-To: <20231216221420.GA2513409@bill-the-cat>
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-4-sjg@chromium.org>
 <082aeedd-4371-4ba4-a29a-bf0f0730b77b@gmx.de>
 <20231121132110.GQ2513409@bill-the-cat>
 <CAPnjgZ30CjQZ0+DMp2gy0HzrnRsjcY5NMi1YVVRQiN8UG-5oBg@mail.gmail.com>
 <c8f1c7cf-346f-42b4-9652-69476e763d5f@gmx.de>
 <20231216221420.GA2513409@bill-the-cat>
Message-ID: <5C28134C-16F4-4959-8EB6-A5A01488F33B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KlLHdbB8HQvDqCzlXk11KfppVt0pRpCiFuxPuvseQxjGI3MBjPp
 QhHU0z0/5xIsx6PqYY2NJ6BVYfzlcSkJ1XjBNvBUgbNUIzm4mu5vQueCrIZGQgitrrnyX8c
 wDE77KVrSml2hOWoRJFEgKPvWkXJjo94NiprThbKAUjjM6xGXK2E51uK5EQrQY21JVs/zQ1
 Z1tnqOSECEN9nPazJjreg==
UI-OutboundReport: notjunk:1;M01:P0:53Zqh1xAGKc=;FUatwFO4mBKnCkFXLc712ec66QC
 7O2GZMzHgiKWwi/6NgnDt3DLzITGDdFCrlpunOeOIKXRkqPTPO40AYoQEY2P8XF6GylvUgS9G
 wpA8XvsSh+5PN+itLoynJegb+BKnlbIddxIcAoUnx1smcVYIsGjm/uNMDlMQBLhjvI4R8+pLx
 7Eu0LraQuYu8rtjRN3z/TkR0Kz7ugPSGU2200Bep2fPkbvjkDzM59jDuM6/V8TN3kj1MukJUp
 odvES3cJcdaN+ECNuUEsfiUnfn6T1JxuESWQwgHn0h8zvttE9i17DuEpsKnzMyHD2LNoWXF+K
 GYN9e2tZD7znyS5TPXLSXCh1FnNYAUVeOcfI/QUJyEso0lLx2Rtur0qXPOhrg1/hCMLPsygKf
 uxu3xy9lrnRKi1NLXIYsLmlO3qe3dMPkKRQTNYk8FxC5qdx/xzw4DDhZ23J0STMNFo+uBknJv
 8vI8O2u2mmqyJtIuAIcDw/a5pzUkodSRWBFMr2v4+UJdpwI6I8Q8k6TMhfwoi4BpZzkYeO/jz
 g/uA+cDVy2yhq50hJYN/Coc0NMO9wN2h4KJftbiddNLB2YOt49AIlHPuPAPjqA8TwfrK2d87S
 c7VdXgKO36xmIzc51srylbtzpVUttTRkfjst2KOcQ39fsrzsmZJQf623TWyHxj1FY4SMrzE7b
 YTz7lgf0dI0qhIybeNDrk2ZVwMzVx5EfC5HGjL3dINslnjcm/QoB/ndf1wxbQVaaEgyrYqW88
 YQdWG37Ym9kM/k9VNulAc2c8/8vPdzArREHVolx9rBEcOiLHk8Ug7e0Mj1yoeeSwkEwk4qMn8
 EHxyKE4w/BAw+zRdCR8ILD8uywNe+yRzxdnsFPg3Ztku9e2XI8fPFiAisxFgSCMrgYbLmK1i7
 5Ho4gJlDYM6Xy7OZgpQCVcj+cBAP6TatPDc0jutge97elWPbC5rlMijfPYSGwl+vk9n5GYW8u
 jSJ7nQ==
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



Am 16=2E Dezember 2023 23:14:20 MEZ schrieb Tom Rini <trini@konsulko=2Ecom=
>:
>On Sat, Dec 16, 2023 at 09:57:41PM +0100, Heinrich Schuchardt wrote:
>> On 12/16/23 21:46, Simon Glass wrote:
>> > Hi,
>> >=20
>> > On Tue, 21 Nov 2023 at 06:21, Tom Rini <trini@konsulko=2Ecom> wrote:
>> > >=20
>> > > On Tue, Nov 21, 2023 at 01:18:09PM +0100, Heinrich Schuchardt wrote=
:
>> > > > On 11/12/23 21:55, Simon Glass wrote:
>> > > > > This function is defined by bootstd so using it precludes using=
 that
>> > > > > feature=2E Use the board_early_init_r() feature instead=2E
>> > > > >=20
>> > > > > This requires moving quite a lot of code into the board directo=
ry, butt
>> > > > > this is the normal place for code called by board_early_init_r(=
)
>> > > > >=20
>> > > > > Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> > > > > ---
>> > > > >=20
>> > > > > Changes in v2:
>> > > > > - Drop duplicate acpi_xsdt patch
>> > > > > - Put the board_early_init_r code into board/
>> > > > >=20
>> > > > >    board/efi/efi-x86_app/Makefile  |   5 +
>> > > > >    board/efi/efi-x86_app/efi_app=2Ec | 205 ++++++++++++++++++++=
++++++++++++
>> > > >=20
>> > > > Our target should be to enable building the EFI app on all archit=
ectures=2E
>> > > >=20
>> > > > Only x86 specific code should be added to board/efi/efi-x86_app/e=
fi_app=2Ec=2E
>> > >=20
>> > > A later enhancement to make U-Boot as an EFI app more generic would=
 be
>> > > good, but outside the scope of this patch which is moving generic c=
ode
>> > > out from "lib" and in to "board"=2E
>>=20
>> I cannot see that this patch is moving any code our of lib/=2E
>>=20
>> But why should we move generic code into board?
>>=20
>> >=20
>> > This patch was marked as old /archived in patchwork so has been
>> > forgotten=2E I have marked it new and non-archived in the hope that i=
t
>> > can be applied to -master soon=2E
>>=20
>> There is nothing x86 specific about the code=2E Generic code should be =
in
>> lib/=2E Please, provide a new version of the patch=2E
>
>It's not generic EFI code, it's generic "U-Boot as EFI application" code
>and so the whole "board" needs a bit of a clean and re-work as we all
>agree that there shouldn't be anything architecture specific about it,
>only building the binary for the correct architecture=2E However, we just
>aren't well structured to support that right now=2E Where on the list of
>priorities does that have to fall rather than just allowing for
>functionality to be tested / used? There's not yet IIRC efi-arm64_app
>but what we have today (and would have had with Simon's patch) should
>have just built and worked=2E
>

We have /lib/efi/ for that code=2E

Regards

Heinrich
