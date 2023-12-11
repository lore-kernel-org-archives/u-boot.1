Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85258C10F05
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 18:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD34876E9;
	Mon, 11 Dec 2023 19:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lWxn2I7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2798E87740; Mon, 11 Dec 2023 19:23:03 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E1287635
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 19:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-db5e692d4e0so4976470276.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702318979; x=1702923779; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrfRijXHoVqz3GHwZegtpBAREf0A1yn+oZ68753YrF0=;
 b=lWxn2I7GBvalqKRkjlnp4x+4KIq37ZNrwREIOQkpCL32KccvFdg/f51byR6xmM0Jaq
 Jm33wDGXgVADXirzJIhRhx3iu9lrWlSRIamwGE4/TRDD205W9hD4IQj4MwW68vTGqa7t
 PImkR7jiOMF0Jlrwilo5VQG66+arkWF+noZ+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702318979; x=1702923779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lrfRijXHoVqz3GHwZegtpBAREf0A1yn+oZ68753YrF0=;
 b=OC3du1gypnpUTjbiZ5QP5YGgL2BH3p7N4kVoyK6v+x+TzqR7/lMh2sx2NaFhAdMu29
 YfzRbQ30ycGyZjeVAX0QgwV34zFe6U4lpF/XjboWs6GYJoPbarVPfkp/2MRuwKVZbKMN
 UcpfCUC45EWKFsfYUK2NAYyxpzAtPcs6jjUYy43536oc3XrPRO+ihlFRL1M584DF1UYc
 T776PyOYl2d7++Ti7VUql7fNiTKp0bGOB35djojJ80a/yjbLbnaEzu1yBr0aWP+Caj+d
 4E1823egt4LlNudzFVTGz8qj+F+pW7RaUZ1fRWtDK4j/RhUX3qo8mmLU8eG1jShi/Y0F
 mDJw==
X-Gm-Message-State: AOJu0YyxZ+wDo4XKHX0NgVzhxW4f6wxkMp6ydXCqKgsePQ8BM9iXzhQa
 WaBszt77t7jDt9z9WYYNszx74MbqJVJ75ZKxkuo2nw==
X-Google-Smtp-Source: AGHT+IF2mnQPwtZ+5eAGSVSy0Ri2Ka2K31Ffzf19TPwbsZw2yqf5yTW0GDFeiLMtc2dcEFr1pYyS8sU7JvjWKKBLaFo=
X-Received: by 2002:a25:844f:0:b0:db7:dad0:60e1 with SMTP id
 r15-20020a25844f000000b00db7dad060e1mr3182011ybm.110.1702318977451; Mon, 11
 Dec 2023 10:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
 <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
 <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
 <20231209205627.GI2513409@bill-the-cat>
 <CABEcMwXYCczbTRVgqGC=USRJw138tDM0RkbmGoR4zSY7pBj1PA@mail.gmail.com>
 <CAPnjgZ3gEoOFxahZ2mg=MTQTmBPyCBphS8uVcpSSwq2bg4eJwQ@mail.gmail.com>
 <20231211181918.GS2513409@bill-the-cat>
In-Reply-To: <20231211181918.GS2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 11:22:45 -0700
Message-ID: <CAPnjgZ3+yJCNgO635gSsDbrb-BpQvJTOqo4qHoWxunvbHZ8jyQ@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Tom Rini <trini@konsulko.com>
Cc: Shantur Rathore <i@shantur.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, 
 Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Mon, 11 Dec 2023 at 11:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 11, 2023 at 10:52:12AM -0700, Simon Glass wrote:
> > Hi,
> >
> > On Sat, 9 Dec 2023 at 15:19, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > On Sat, Dec 9, 2023 at 8:56=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > > >
> > > > On Fri, Dec 08, 2023 at 01:59:26PM +0000, Shantur Rathore wrote:
> > > > > Hi Peter,
> > > > >
> > > > > On Fri, Dec 8, 2023 at 12:59=E2=80=AFPM Peter Robinson <pbrobinso=
n@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Dec 8, 2023 at 12:52=E2=80=AFPM Shantur Rathore <i@shan=
tur.com> wrote:
> > > > > > >
> > > > > > > Hi Jagan,
> > > > > > >
> > > > > > > On Fri, Dec 8, 2023 at 11:13=E2=80=AFAM Jagan Teki <jagan@ama=
rulasolutions.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Nov 19, 2023 at 10:54=E2=80=AFPM Shantur Rathore <i=
@shantur.com> wrote:
> > > > > > > > >
> > > > > > > > > Rockchip SoCs can support wide range of bootflows.
> > > > > > > > > Without full bootflow commands, it can be difficult to
> > > > > > > > > figure out issues if any, hence enable by default.
> > > > > > > > >
> > > > > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > > > > >
> > > > > > > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > (no changes since v1)
> > > > > > > > >
> > > > > > > > >  arch/arm/Kconfig | 1 +
> > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > > > > > > index d812685c98..fca6ef6d7e 100644
> > > > > > > > > --- a/arch/arm/Kconfig
> > > > > > > > > +++ b/arch/arm/Kconfig
> > > > > > > > > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> > > > > > > > >         imply CMD_DM
> > > > > > > > >         imply DEBUG_UART_BOARD_INIT
> > > > > > > > >         imply BOOTSTD_DEFAULTS
> > > > > > > > > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> > > > > > > >
> > > > > > > > Yes, but better to give this option to specific board vendo=
rs as
> > > > > > > > defaults are enough to boot 1st bootflow and what ever medi=
a's it has.
> > > > > > > >
> > > > > > >
> > > > > > > Yes, that's correct it is enough to boot but by default there=
 is no option
> > > > > > > to choose what to boot from.
> > > > > > > This was discussed in an earlier version of this patch [0] wh=
ere I was
> > > > > > > explicitly enabling only for RP64.
> > > > > >
> > > > > > What actual extra functionality does this provide, what is the =
impact
> > > > > > on the size of images? You've not provided reasonable justifica=
tion
> > > > > > outside of very vague statements, it would be useful to know wh=
at the
> > > > > > added options actually solves.
> > > > >
> > > > > BOOTSTD_FULL enables all the options in bootflow commands. This i=
s needed if
> > > > > - you want to choose between multiple available bootflows rather =
than
> > > > > just boot one default.
> > > > > - if you need to list the available bootflows that bootstd has fo=
und
> > > > > - if you need to select and boot any bootflow other than default.
> > > > > By default all other commands in U-boot come with options to show=
 details
> > > > > For example, nvme info, nvme detail, usb info, usb tree but with
> > > > > bootstd no way to know anything.
> > > > >
> > > > > Image size - u-boot.itd without BOOTSTD_FULL - 1193984 bytes
> > > > > Image size - u-boot.itb with BOOTSTD_FULL - 1214976 bytes
> > > > > Difference - 20992 bytes
> > > > >
> > > > > According to binman for RK3399 u-boot can take upto 4M [1] so we =
have
> > > > > ample space.
> > > > >
> > > > > This was discussed in the previous patch in the link below [0]
> > > > >
> > > > > [0] - https://patchwork.ozlabs.org/project/uboot/patch/2023111100=
1329.537704-1-i@shantur.com/
> > > > > [1] - https://github.com/shantur/u-boot/blob/master/arch/arm/dts/=
rk3399-u-boot.dtsi#L68
> > > >
> > > > If I'm recalling everything right, this also brings "bootflow" as a
> > > > command more in line with what could be done with distro_bootcmd in
> > > > terms of "cover every possible case and let the user override thing=
s"
> > > >
> > > Yes,
> > > That's correct.
> > >
> > > U_BOOT_LONGHELP(bootflow,
> > > #ifdef CONFIG_CMD_BOOTFLOW_FULL
> > > "scan [-abeGl] [bdev]  - scan for valid bootflows (-l list, -a all, -=
e
> > > errors, -b boot, -G no global)\n"
> > > "bootflow list [-e]             - list scanned bootflows (-e errors)\=
n"
> > > "bootflow select [<num>|<name>] - select a bootflow\n"
> > > "bootflow info [-ds]            - show info on current bootflow (-d
> > > dump bootflow)\n"
> > > "bootflow read                  - read all current-bootflow files\n"
> > > "bootflow boot                  - boot current bootflow\n"
> > > "bootflow menu [-t]             - show a menu of available bootflows\=
n"
> > > "bootflow cmdline [set|get|clear|delete|auto] <param> [<value>] -
> > > update cmdline"
> > > #else
> > > "scan - boot first available bootflow\n"
> > > #endif
> > > );
> >
> > I suggest we keep it off for now, as we did put in quite a bit of
> > effort to reduce code size. It would be a shame to throw it all away.
> >
> > That said, I can imagine this becoming a pain for people over time, as
> > the 'bootflow' command becomes the common way to interact with U-Boot.
> > I just wonder if it is too early to make the switch?
>
> I think in hind-sight too much stuff is omitted without BOOTSTD_FULL.
> The option itself then enables other stuff too by default, but some
> parts of the bootflow command itself should be visible even without FULL
> to make things easier on the user.

At the time the goal was to avoid growth compared to the distro
scripts. We could perhaps add some more things in with BOOTSTD_FULL
but still have it as an option?

Regards,
Simon
