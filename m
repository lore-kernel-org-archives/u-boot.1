Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597AFCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CD784A1C;
	Wed, 10 Jun 2026 03:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="gK5iOys6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE72784869; Tue,  9 Jun 2026 20:41:20 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A45A84704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 20:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C1C1127313;
 Tue,  9 Jun 2026 20:41:17 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a_olIM_nHnCR; Tue,  9 Jun 2026 20:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1781030477; bh=oIZaH4CKN3vR81K9jthNBfkGqnoord6qfD6O1gJWPjk=;
 h=Date:Cc:Subject:From:To:References:In-Reply-To;
 b=gK5iOys6n3Ynuokf+tv6LohMLmMKgumgQDiigByqWQvMtLDVIPgX+N8zZ0k8eJwp+
 t45dJAMmPAjIrKxJ1oiGJIg1f6kY82qD8URWDmzw8LURpkY6ZAbJRXTf99yD/ezUSH
 LryjWtkTGvRuVfxil9RbZOLBl0cFYw3ByIGTNeUiXPlS1AyhwwqCKW1JWnq+RyQS0h
 OKJ6yzL/9VPFYVoeSZvy9wYLVUZgBchMZlOSnwjrFhs/iyzCyehg+c2mQHTcagXGOJ
 EFGkW2PpSuXKHP3aTryx7qJeTwAFyi3R8Qd2MWsxqwNcmidmeTk4poS/YlygyzAn0R
 3KfkOY3sa8HRg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 00:11:01 +0530
Message-Id: <DJ4QLUOW3HOV.946WQKV3H4V9@disroot.org>
Cc: <u-boot@lists.denx.de>, "Tom Rini" <trini@konsulko.com>, "Alper Nebi
 Yasak" <alpernebiyasak@gmail.com>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Bryan Brattlof" <bb@ti.com>, "Yannic Moog"
 <y.moog@phytec.de>, "Wojciech Dubowik" <Wojciech.Dubowik@mt.com>, "Yegor
 Yefremov" <yegorslists@googlemail.com>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Rasmus Villemoes"
 <ravi@prevas.dk>, "Javier Tia" <floss@jetm.me>, "Minkyu Kang"
 <mk7.kang@samsung.com>, "Kaustabh Chakraborty" <kauschluss@disroot.org>,
 "Henrik Grimler" <henrik@grimler.se>
Subject: Re: [PATCH v2 7/8] arch: arm: exynos: add j7xelte binman config
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Simon Glass" <sjg@chromium.org>, <me@samcday.com>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-7-b8203682507f@samcday.com>
 <CAFLszTjXckdYQ4kQmmH9yFsh0GQtea2TGkRfsitNn55RkPFF5A@mail.gmail.com>
In-Reply-To: <CAFLszTjXckdYQ4kQmmH9yFsh0GQtea2TGkRfsitNn55RkPFF5A@mail.gmail.com>
X-Mailman-Approved-At: Wed, 10 Jun 2026 03:29:29 +0200
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

Allow me to chime in and provide some context for discussions below:

On 2026-06-08 07:27 -06:00, Simon Glass wrote:
> Hi Sam,
>
> On 2026-06-07T23:37:09, Sam Day via B4 Relay
> <devnull+me.samcday.com@kernel.org> wrote:
>> arch: arm: exynos: add j7xelte binman config
>>
>> Note that, as of this commit, j7xelte does not yet exist in U-Boot's
>> upstream DTS tree. It was accepted into next so it should appear here
>> eventually.
>>
>> S-BOOT expects a DTBH with hw-rev =3D=3D 6.
>>
>> Link: https://lore.kernel.org/all/177209522223.26390.6219893536178441080=
.b4-ty@kernel.org/
>> Signed-off-by: Sam Day <me@samcday.com>
>>
>> arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi | 24 +++++++++++++++++++++++=
+
>>  1 file chang
>> diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dts/=
exynos7870-j7xelte-u-boot.dtsi
>> @@ -0,0 +1,24 @@
>> +     binman {
>> +             filename =3D 'u-boot-samsung-j7xelte.img';
>> +             android-boot {
>> +                     kernel {
>> +                             u-boot-nodtb {};
>> +                     };
>
> No 'base' is set, so android_boot falls back to its default of
> 0x10000000, putting the kernel_addr field in the abootimg header at
> 0x10008000 - nowhere near Exynos7870 DRAM at 0x40000000. Does S-BOOT
> on j7xelte ignore the load addresses in the header (so the defaults
> are harmless), or do you need to set base =3D <0x40000000> explicitly? A
> short note in the commit message on what S-BOOT does with those fields
> would help.

In my devices (on7xelte, a2corelte, j6lte), S-BOOT does ignore the load
address. This is also mentioned in the install guide [1], as it says:

  "Offsets are not provided to mkbootimg as S-BOOT ignores them."

>> diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dts/=
exynos7870-j7xelte-u-boot.dtsi
>> @@ -0,0 +1,24 @@
>> +                     vendor-dt {
>> +                             dtbh {
>> +                                     dtb-0 {
>> +                                             u-boot-dtb { };
>> +                                     };
>> +                             };
>> +                     };
>
> Does this indenting use tabs? It should.
>
> 'S-BOOT expects a DTBH with hw-rev =3D=3D 6' is terse - worth a sentence
> explaining that this pins both hw_rev and hw_rev_end to 6, contrasting
> with the wider 0..255 range used by the j6lte overlay, so it's clear
> why that DTSI's approach wasn't reused.

I also question this approach. In my devices S-BOOT happily accepts dtbs
having revisions lower than that of the hardware, but of course, doesn't
accept higher ones. Setting hw-rev to 6 means that U-Boot won't work for
S-BOOT versions 5 or below.

If this is indeed a quirk of S-BOOT in this device, then do we need to
make revision variants for j7xelte, or pass the revision to binman
somehow?

> Regards,
> Simon

[1] https://docs.u-boot-project.org/en/v2026.04/board/samsung/exynos-mobile=
/exynos7870.html#preparation.

