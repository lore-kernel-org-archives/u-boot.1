Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A264C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 10:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47DE760765;
	Thu, 20 Aug 2026 10:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WKtQkkgEUS2x; Thu, 20 Aug 2026 10:41:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787222469;
	bh=EE9jGj4tRGdJFtBInvCCgsyv3TzhOO5Ul4QR5t8iVss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XFIiBufrecYQ/J3+tSppf1bG8D1OVmHBZf1GQrhoGd4tXUJH3nQSTmDCyTGhkq5B4
	 ucIru19jdtDfemchJfah8y6Y31Ivhq2iRHzuiZQLZ7l0yN+2xqBSHHDb6iDVYfsbhQ
	 qlVJ7DSykWRUwnLnbA2sPnA3+hfcVAzMQZHGwMhepSCNO5ST8B1M1Hm3aVFK4ygUkm
	 7GQJrZhByIUBAnKMJ7x6OAWc52DrjTd/zZFXVBtCuKqxDF9LppdK6LmMRw/prMmKsR
	 GFcSUSC4HZOsbl8zi30o239qs9CmCBwzZD3XdMywP9/ELf6SgIopFd4ruYlPylQque
	 tJ8+V1xnMa2lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38B02606E1;
	Thu, 20 Aug 2026 10:41:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D0EB39E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2C1F40291
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxNE89vMVThl for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 10:41:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=6AVS5lRs
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8D5940281
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:41:04 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3811f512167so2892904a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787222463; cv=none;
 d=google.com; s=arc-20260327;
 b=FQ1DkUn99IuP2T0ScCdyM4rNrW/i+jHbsY6T4WPQ6rO19oBamcUymvNyC8HO66sdxS
 Y1YIz/HXasBlcQi449fQiIxEXSgC/aGOUPpuZ6d9V2VbI09TA9+W+JDJ3mvtCUzKgPCA
 ccZuJsUAlUxpOrzLsfgOqFeaVPC3EfOh5/LctIKRApvbYHNkbj2ZCUTJtCxPg9c4lcfb
 Pz1l9U1SWNHhUAKvLSLUcQK6a5r/i8A8YvugQ4jFkkcNd0O4vlXYckqqXtdYgZOU/Ea9
 jJ5MfRo9HKAhvsZnIMfCRRGCgeP4TBBNRDwC3mAbxa/CxQtKPlARycpcUEtm0OXrdAaP
 ENdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EE9jGj4tRGdJFtBInvCCgsyv3TzhOO5Ul4QR5t8iVss=;
 fh=oM33lYcqdRTfgwY+ybYfFJOWMaWry38TiftoBASee98=;
 b=QCDW7xij6NqiqqtN1XNxwtCNOewkf6WtItzqAv745bUzTyRbqAbvrL/o0YhUPeEoSn
 2asWBNcfggV3M1CGIfswZPPVxQ2wpTMpKlZj5nD+aBNKBIvsafGE7keZvdSqiyUEzl6y
 f3xLsBWOmrvM3AcW8VDlx5NaQ7cFIHqD8War+fnHJ2PUfvju7LzlQzPwzObGyzgu/Sbt
 632UoVXoBdvS5OqzKa/1ZUFv7N6CwXQQdeJ5HdjWQFhHo+5c2/nlPQLm177O2DWRsupZ
 IqB8KRRFOKNHpD3cgAnLMV9U25h1me9yj3OJzLUcWKdQhx8AhFYRIEbT3cKgM+C3QDFw
 uBtQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787222463; x=1787827263;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EE9jGj4tRGdJFtBInvCCgsyv3TzhOO5Ul4QR5t8iVss=;
 b=6AVS5lRs6W93eNzx/X++5yPHZagKZIb/pmOB/zILJXlgS9K8tdIU7DeIuxvo0B0FhV
 2lcaQw7a6mDJAw6v52uDQSbCOVO7aj5GNqMobl5zZMikFeRZvXRrz0DunKCesONlKbnq
 4/+e1WOc4UOQ4bBGBTt8IWN1jrpxQRP3V7+UHryMO3Ajn2adNTVDNKZYqZ2ZjyQVW9+S
 8s/2IURHzz/CO1aDHHQ0bMTFRugdZuLSCtX+XTa+liHnIXbwQp5VYy2Yrj2XsImjZfEm
 GCw810A2FpyUeBICdlse2CY4m9rp9eDmDSSUJVQl8OHBfiLoMUiVEiBMeridf6V4iYSh
 80LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222463; x=1787827263;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EE9jGj4tRGdJFtBInvCCgsyv3TzhOO5Ul4QR5t8iVss=;
 b=e6ru9IIa/Z/A2ai6D3GIV5LBxHPlMtBICjxW9wWQTGTS6utojRavA6K3iomZOFJkW2
 hAPSbhhG06M5GACQK1s5iklOHd2EHOMU/7V0Wdqp/2RwBO5kU2okmNZVkzPGP54sFfMK
 uZcOGNFXJ5RBhr2IQ0TyUFJwiQCMgY2UafE1zCOoMg80bQxuDWmOh2okD9HLdDQi7vKx
 lt8iI0ldn4V4vc81Ju+WFTxUIQoIWxSLZvErJwoxQkfWTm4CrHk1iPiWSDf0nZk3Se1z
 wDXCsoAdbTIKCUcbLWLbuhJjFoW659O8v+wjvh9ZKIpH9/+2sDgNnXCo+PqrjXdrqD/Z
 11Xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkCA8rBgq9yQ+39RYtC8qNLaK/kKAAc7LbKO4sBxhg32wdYOWcxDazRHvwgK+Fn/WrHeDEbww=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nXRPxBSgRr1fyYRfpQpMJoqIEoNMYc+CgFTtAXyAaC0vIe4RVM
 eQrZpBuKqdHMR7VIRrguxqdYnRL60y2u7WfEVq0V1qI0iMQ8jaCtac54qQ029QiLyYnFpWisaOV
 B9QdD8ye6RFnjUpLtQLKM5FJOj+gG0p15b4gLqk9mnQ==
X-Gm-Gg: AR+sD11ODOUvaTEETDI9mNNMskYeGMvhS7sJwMnHY7QvmG9kI95d6aLveAk0mvRPIuX
 gJ6jXhegTl2uOPMWgc20ob1L5EGSU9EnfjVEugVwuGMLys39FimxSeYZsoSTOAvLUDx0kiiC0Xj
 Gs0KUPJUNJ9Pys8OS6FdzpNnZVQECavJ3FbcVnEMJ9/fxMcs1aamDbz1EIjKYQPXEXEWdDtZE0N
 EyqHQrPywllL4nYmbg5Bi3y7hyGnz/eSJE7xYC1EPNCh8ENskTUD1SBiyovT5U8fXg4UPhji/Uk
 EOy1CkAjReDyygjcdChyhoWyqPYOtsv+ZIZwPXom/4N7zl0rMtSAmSHxDr4zuZbswHg+2uJAlJf
 FXw==
X-Received: by 2002:a17:90b:544f:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-3958108a4b0mr22799748a91.11.1787222463295; Thu, 20 Aug 2026
 03:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
 <483e93ba-a427-4ed1-b5f6-8d6cd11c5a42@gmail.com>
 <c885ef7b-5d2c-4a0f-8681-43f3f87c650f@cherry.de>
In-Reply-To: <c885ef7b-5d2c-4a0f-8681-43f3f87c650f@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 20 Aug 2026 14:40:48 +0400
X-Gm-Features: AcwNN1XtQu6iCI_YyctHCh3E6rmGglirHLt3P2iDkKE0Y09ee7iAinV_FU1KSUU
Message-ID: <CAKTNdwEaUsQLe1qmn8JUVEXWqyO47ny510XN4K2+j59FGih9YA@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] rockchip: doc: add back to ROM section
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.u-boot-project.org, 
 eddie.cai.linux@gmail.com, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On Wed, Aug 19, 2026 at 4:49=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Johan,
>
> Please incorporate Jonas's comments made on the v6:
> https://lore.kernel.org/u-boot/1e47521b-c3f2-4c62-86eb-51866b911968@kwibo=
o.se/
>
> This also applies to patches 2 and 4's content and commit titles/logs. I
> won't repeat his review here.
>
> On 8/15/26 3:08 PM, Johan Jonker wrote:
> > Add a back to ROM section to rockchip.rst
> > Correct Kconfig text.
> >
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changed V7:
> > Move under a 'Boot flow' heading
> > Remove "Some"
> > ---
> >   arch/arm/mach-rockchip/Kconfig  | 16 ++++++++--------
> >   doc/board/rockchip/rockchip.rst | 11 +++++++++++
> >   2 files changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kc=
onfig
> > index 1a2e7847c9e7..c1dbcce1e27c 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -600,26 +600,26 @@ config ROCKCHIP_USB_UART
> >         SoCs will enable this routing as a debug measure.
> >
> >   config SPL_ROCKCHIP_BACK_TO_BROM
> > -     bool "SPL returns to bootrom"
> > +     bool "SPL returns to boot ROM"
> >       default y if ROCKCHIP_RK3036
> >       select ROCKCHIP_BROM_HELPER
> >       select SPL_BOOTROM_SUPPORT
> >       depends on SPL
> >       help
> > -       Rockchip SoCs have ability to load SPL & U-Boot binary. If enab=
led,
> > -       SPL will return to the boot rom, which will then load the U-Boo=
t
> > -       binary to keep going on.
> > +       Rockchip SoCs have the ability to load a second loader binary
>
> If I'm not mistaken, it can go back to BROM more than once? I vaguely
> recall the maximum supported number of images in the rk header to be 4
> from a discussion we had with Jonas but cannot find a source anymore :/

That's right, the RKNS image can have up to 4 entries. I've been
digging into RK3576 boot ROM quirks and can confirm from its behavior
that it checks for <=3D 4 when loading. I've also written up a separate
doc [1] on the behavior of the RK3576 specific ROM version, but I
don't know how well that generalizes to other SoC versions.

Another interesting part that I discovered there is that the ROM looks
for the image header at multiple offsets into each storage device.
This can potentially enable failsafe fallbacks to guard against a
failed write or a corrupted image (e.g. write known-good copies into
higher-numbered slots, and only then write the fresh idbloader.img at
sector 64).

[1] https://docs.flipper.net/one/hardware/rk3576/boot-rom#normal-boot-from-=
persistent-storage

> Maybe we should reword this to "have the ability to go back after SPL to
> BootROM and have it load and execute the next binary in the image
> (typically U-Boot proper)"?
>
> > +       after the SPL phase. If enabled, SPL will return to the boot RO=
M,
> > +       which will then load and execute the U-Boot binary.
> >
> >   config TPL_ROCKCHIP_BACK_TO_BROM
> > -     bool "TPL returns to bootrom"
> > +     bool "TPL returns to boot ROM"
> >       default y
> >       select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
> >       select TPL_BOOTROM_SUPPORT
> >       depends on TPL
> >       help
> > -       Rockchip SoCs have ability to load SPL & U-Boot binary. If enab=
led,
> > -       SPL will return to the boot rom, which will then load the U-Boo=
t
> > -       binary to keep going on.
> > +       Rockchip SoCs have the ability to load a second loader binary
> > +       after the TPL phase. If enabled, TPL will return to the boot RO=
M,
> > +       which will then load and execute a SPL binary.
>
> Maybe we should reword this to "have the ability to go back after TPL to
> BootROM and have it load and execute the next binary in the image
> (typically U-Boot SPL)"?
>
> >
> >   config ROCKCHIP_COMMON_BOARD
> >       bool "Rockchip common board file"
> > diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockc=
hip.rst
> > index 5e16e860bfd5..d5945e805ba8 100644
> > --- a/doc/board/rockchip/rockchip.rst
> > +++ b/doc/board/rockchip/rockchip.rst
> > @@ -560,5 +560,16 @@ config-flash.ini:
> >           PATH=3DRK30xxLoader_uboot.bin
> >
> >
> > +Boot flow
> > +---------
> > +
> > +Back to ROM
> > +^^^^^^^^^^^
> > +
> > +Rockchip SoCs have the ability to load a second loader binary.
> > +If enabled, the TPL/SPL code will return to the boot ROM, which will t=
hen
> > +load and execute a SPL or U-Boot binary.
>
> Maybe we should reword this to "have the ability to go, after a binary's
> been already loaded and executed, back to BootROM and have it load and
> execute the next binary in the image (typically SPL/U-Boot proper)".

On RK3576 in particular, both the boost.bin (which fixes SD card boot)
and the DDR init (the closed-source TPL) return to the boot ROM, and
then the boot ROM loads the SPL (and optionally its payload) into RAM
and executes it. So "a second loader binary" sounds too narrow. I
would say something like:

Rockchip SoCs have the ability to return control to the boot ROM after
any loaded binary has completed execution. In this case the boot ROM
loads and executes the next binary in the image, which for different
SoC versions can be the DRAM trainer, the SPL, or any other payload.

I wouldn't mention the U-Boot proper in the same row, as it normally
expects an FDT to work with, which the boot ROM won't provide (that's
the SPL's job).

Best regards,
Alexey
