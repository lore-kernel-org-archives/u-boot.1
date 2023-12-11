Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95B2C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 18:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3168F87635;
	Mon, 11 Dec 2023 19:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AlRBQlwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384A587740; Mon, 11 Dec 2023 19:19:24 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD0186E7E
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 19:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5d8a772157fso40606377b3.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702318760; x=1702923560; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bgGxgGncSE54QJQtYE89vUk2z4zE8gxJ6viP9rT3fNs=;
 b=AlRBQlwbWHJi6c3W46BpAIfBkuUNdzCsBbNw1O+Ap1A83bt6I7StNgX6mSVemjBS2M
 mPGsxFF9sbDwMugAxEMNQfRQL2oQqA9cA7tOq/ScjLBicr3xLQgdtIWYmMVccj1cj6kE
 7pCsLjtXp2oDKlGyNVOaDw78Lq04/w67dSzZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702318760; x=1702923560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgGxgGncSE54QJQtYE89vUk2z4zE8gxJ6viP9rT3fNs=;
 b=cD+oa6iU8bjvPTTOEdgEHOgjtqMdFmXN6y4zutsx8C3ZyOICzJk5+C4yMWBZNmhaYQ
 Ukt0ADd1B0sHo+R2hiSU8kxWB8Yr0EGQo489RPsnYJvyoUYPsKrKpx2MXWdz+FHkEcEc
 Xef5+omKnSQmRMbi4Uyl8EGHws3b19RGoHHHI1NvjfdtJppgfM7hRgPLtd44/fHQ7pyr
 bmGmYj1kaTs/Hz/KlHRrtTwUq0JcBQ+UaaMZxB+fuGMkqrNMRKHzA/jCYzTizJCneIha
 Aax6SxNF4rcd6KQH9vkUbSG6tx4vjIaLmJDftoEOLw6kNk8UYK/nzrljr88WDAlxDenH
 N14A==
X-Gm-Message-State: AOJu0YwGCo8FcBN0mjgrh+Vcr5A4kdgUrRGxv7FncqXtI9UBHFC8n0yJ
 nKvcQbv0AJWMGW9Y+pjxmQM5KA==
X-Google-Smtp-Source: AGHT+IGmiyA0Qxt5VR3Uojgh4qjkSUhYituMqcHARQ8a8/wDVIhUREipwdYYGlCw8U4AwRU4vkPVag==
X-Received: by 2002:a81:8a05:0:b0:5d7:1941:aad with SMTP id
 a5-20020a818a05000000b005d719410aadmr3465153ywg.72.1702318760299; 
 Mon, 11 Dec 2023 10:19:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fa42-ae3b-3aac-d543.res6.spectrum.com.
 [2603:6081:7b00:6400:fa42:ae3b:3aac:d543])
 by smtp.gmail.com with ESMTPSA id
 ee12-20020a05690c288c00b005e16c1c0bf9sm308337ywb.95.2023.12.11.10.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 10:19:19 -0800 (PST)
Date: Mon, 11 Dec 2023 13:19:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Bharat Gooty <bharat.gooty@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
Message-ID: <20231211181918.GS2513409@bill-the-cat>
References: <20231119172310.1307942-1-i@shantur.com>
 <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
 <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
 <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
 <20231209205627.GI2513409@bill-the-cat>
 <CABEcMwXYCczbTRVgqGC=USRJw138tDM0RkbmGoR4zSY7pBj1PA@mail.gmail.com>
 <CAPnjgZ3gEoOFxahZ2mg=MTQTmBPyCBphS8uVcpSSwq2bg4eJwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JaO5xzKf26IXS314"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3gEoOFxahZ2mg=MTQTmBPyCBphS8uVcpSSwq2bg4eJwQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--JaO5xzKf26IXS314
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:52:12AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Sat, 9 Dec 2023 at 15:19, Shantur Rathore <i@shantur.com> wrote:
> >
> > On Sat, Dec 9, 2023 at 8:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> > >
> > > On Fri, Dec 08, 2023 at 01:59:26PM +0000, Shantur Rathore wrote:
> > > > Hi Peter,
> > > >
> > > > On Fri, Dec 8, 2023 at 12:59=E2=80=AFPM Peter Robinson <pbrobinson@=
gmail.com> wrote:
> > > > >
> > > > > On Fri, Dec 8, 2023 at 12:52=E2=80=AFPM Shantur Rathore <i@shantu=
r.com> wrote:
> > > > > >
> > > > > > Hi Jagan,
> > > > > >
> > > > > > On Fri, Dec 8, 2023 at 11:13=E2=80=AFAM Jagan Teki <jagan@amaru=
lasolutions.com> wrote:
> > > > > > >
> > > > > > > On Sun, Nov 19, 2023 at 10:54=E2=80=AFPM Shantur Rathore <i@s=
hantur.com> wrote:
> > > > > > > >
> > > > > > > > Rockchip SoCs can support wide range of bootflows.
> > > > > > > > Without full bootflow commands, it can be difficult to
> > > > > > > > figure out issues if any, hence enable by default.
> > > > > > > >
> > > > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > > > >
> > > > > > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >  arch/arm/Kconfig | 1 +
> > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > > > > > index d812685c98..fca6ef6d7e 100644
> > > > > > > > --- a/arch/arm/Kconfig
> > > > > > > > +++ b/arch/arm/Kconfig
> > > > > > > > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> > > > > > > >         imply CMD_DM
> > > > > > > >         imply DEBUG_UART_BOARD_INIT
> > > > > > > >         imply BOOTSTD_DEFAULTS
> > > > > > > > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> > > > > > >
> > > > > > > Yes, but better to give this option to specific board vendors=
 as
> > > > > > > defaults are enough to boot 1st bootflow and what ever media'=
s it has.
> > > > > > >
> > > > > >
> > > > > > Yes, that's correct it is enough to boot but by default there i=
s no option
> > > > > > to choose what to boot from.
> > > > > > This was discussed in an earlier version of this patch [0] wher=
e I was
> > > > > > explicitly enabling only for RP64.
> > > > >
> > > > > What actual extra functionality does this provide, what is the im=
pact
> > > > > on the size of images? You've not provided reasonable justificati=
on
> > > > > outside of very vague statements, it would be useful to know what=
 the
> > > > > added options actually solves.
> > > >
> > > > BOOTSTD_FULL enables all the options in bootflow commands. This is =
needed if
> > > > - you want to choose between multiple available bootflows rather th=
an
> > > > just boot one default.
> > > > - if you need to list the available bootflows that bootstd has found
> > > > - if you need to select and boot any bootflow other than default.
> > > > By default all other commands in U-boot come with options to show d=
etails
> > > > For example, nvme info, nvme detail, usb info, usb tree but with
> > > > bootstd no way to know anything.
> > > >
> > > > Image size - u-boot.itd without BOOTSTD_FULL - 1193984 bytes
> > > > Image size - u-boot.itb with BOOTSTD_FULL - 1214976 bytes
> > > > Difference - 20992 bytes
> > > >
> > > > According to binman for RK3399 u-boot can take upto 4M [1] so we ha=
ve
> > > > ample space.
> > > >
> > > > This was discussed in the previous patch in the link below [0]
> > > >
> > > > [0] - https://patchwork.ozlabs.org/project/uboot/patch/202311110013=
29.537704-1-i@shantur.com/
> > > > [1] - https://github.com/shantur/u-boot/blob/master/arch/arm/dts/rk=
3399-u-boot.dtsi#L68
> > >
> > > If I'm recalling everything right, this also brings "bootflow" as a
> > > command more in line with what could be done with distro_bootcmd in
> > > terms of "cover every possible case and let the user override things"
> > >
> > Yes,
> > That's correct.
> >
> > U_BOOT_LONGHELP(bootflow,
> > #ifdef CONFIG_CMD_BOOTFLOW_FULL
> > "scan [-abeGl] [bdev]  - scan for valid bootflows (-l list, -a all, -e
> > errors, -b boot, -G no global)\n"
> > "bootflow list [-e]             - list scanned bootflows (-e errors)\n"
> > "bootflow select [<num>|<name>] - select a bootflow\n"
> > "bootflow info [-ds]            - show info on current bootflow (-d
> > dump bootflow)\n"
> > "bootflow read                  - read all current-bootflow files\n"
> > "bootflow boot                  - boot current bootflow\n"
> > "bootflow menu [-t]             - show a menu of available bootflows\n"
> > "bootflow cmdline [set|get|clear|delete|auto] <param> [<value>] -
> > update cmdline"
> > #else
> > "scan - boot first available bootflow\n"
> > #endif
> > );
>=20
> I suggest we keep it off for now, as we did put in quite a bit of
> effort to reduce code size. It would be a shame to throw it all away.
>=20
> That said, I can imagine this becoming a pain for people over time, as
> the 'bootflow' command becomes the common way to interact with U-Boot.
> I just wonder if it is too early to make the switch?

I think in hind-sight too much stuff is omitted without BOOTSTD_FULL.
The option itself then enables other stuff too by default, but some
parts of the bootflow command itself should be visible even without FULL
to make things easier on the user.

--=20
Tom

--JaO5xzKf26IXS314
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV3UqIACgkQFHw5/5Y0
tyztigwAgy5rBun4S5+BxFg8HnDB3zi1ioU6eEww74836xWDJ6iHswBaUYz+76mC
WNBuQbrTI3BF6XUuSbcdqV5+n+RG0+U3NDWuErEdW3WIe5DlJXT/Z/aqAFJyJAXT
1SzaUIK2WQAtLCPXqBBSjQzfItNMez88A5fRdEtP+qymQFIdKemdM8V+v1ZylPMm
1lxIgpqqRYZTTSE+hqYS9SM41gDn9sZ9fUOJHi6eronZFx0oXHtg6mvFWrOHfgv1
CkigRaWDz4wBTDZN5SEffaGeHD4TlrGXpql5USurJgJuPcnhK6Lrey1CmBHaDef9
H/bLLdyC+ko7LCBm6YnU+27ePJwyprrnAtQnWDYPwLHUCe70q5vKxy1sBRlH4qHl
5VWGjwPs01m62Ip9dKFZr/KqudQuIUGNKLugh18uH3mXPqtSk6ZDO0Dvojj+7HWW
2eoQfD2yQxx87UlYb/xYK0GmxAihNeRpKiZXr1dK8wjn2KqGqewOOsN7pB37BxuI
EVNJZkPy
=IfoI
-----END PGP SIGNATURE-----

--JaO5xzKf26IXS314--
