Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B028DC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0793587740;
	Mon, 11 Dec 2023 18:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NgbEKnXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC8708776E; Mon, 11 Dec 2023 18:52:57 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C94F86308
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d6b9143782so41520947b3.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317174; x=1702921974; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QJ0mXSjrsHo3Ib5E+TW/xOC5k8hQ9v01Oe4uMxxaZs=;
 b=NgbEKnXLvKDk7YxZdciR/twLpwngOKbkzRECAQ3WutPa6ItgfBd/xKTTubXSB7zFgd
 xcBmyT1lAQJcf9PZr4O0Kx0euTv2KK2TnEjRRkUXKFUv/zca+PEjwtZB9lXso9XFSv1h
 vTEZPu44pRIwAh0Yj5zXWkMHKk0H9jWaHktfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317174; x=1702921974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QJ0mXSjrsHo3Ib5E+TW/xOC5k8hQ9v01Oe4uMxxaZs=;
 b=KPnKEYQD/PSY1YlE+Fq6BLdGE32SGCZS9iAkFyyOrR5f9dwWtuYA++1C8xq1wY+xgP
 vaaQeBeXWwdbLGTjo0EhOzWeODbiEPYkaNDXXxN5ypgwl3QzdFsf2ZhmJegX9mzYTIXH
 tVWAl7doo/qtwZuu4ZcqlhAZub1uc7Rjl9zwi9wnAACGFdm5RWX3TnWmgt0sjgcRfqn6
 UHqAKLuCJ+CKAJA0AobQctedd7QrgYpIcUm6F/jMTV4XBNzlepZJzRw9nPRdNF9iJa7S
 u6033Xk734nGbMa6rseRQJR1kctnusbRb4UxvU8MYoewaIHKDJVOXP4l25WQBzHufcXo
 OKbQ==
X-Gm-Message-State: AOJu0YySLSD2U9E/DrgBh8qupkmiVicMaIWRn8TS7CnsXG3LvUJP9XiR
 mPF27q3naIebTTtCNQ1PXXD1+VLHtH5xv0qoZhTFRQ==
X-Google-Smtp-Source: AGHT+IFepebH0lWhNps8uFQgyQyy+8JpC2mSBpSKyfuscYief42VixBxcGd187PH8Xs38LbF4RDKGfJJkcaFZpKn8gs=
X-Received: by 2002:a0d:e901:0:b0:5d7:1940:7d6b with SMTP id
 s1-20020a0de901000000b005d719407d6bmr3648293ywe.66.1702317173718; Mon, 11 Dec
 2023 09:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
 <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
 <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
 <20231209205627.GI2513409@bill-the-cat>
 <CABEcMwXYCczbTRVgqGC=USRJw138tDM0RkbmGoR4zSY7pBj1PA@mail.gmail.com>
In-Reply-To: <CABEcMwXYCczbTRVgqGC=USRJw138tDM0RkbmGoR4zSY7pBj1PA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:12 -0700
Message-ID: <CAPnjgZ3gEoOFxahZ2mg=MTQTmBPyCBphS8uVcpSSwq2bg4eJwQ@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Shantur Rathore <i@shantur.com>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de, Bharat Gooty <bharat.gooty@broadcom.com>, 
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

Hi,

On Sat, 9 Dec 2023 at 15:19, Shantur Rathore <i@shantur.com> wrote:
>
> On Sat, Dec 9, 2023 at 8:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Fri, Dec 08, 2023 at 01:59:26PM +0000, Shantur Rathore wrote:
> > > Hi Peter,
> > >
> > > On Fri, Dec 8, 2023 at 12:59=E2=80=AFPM Peter Robinson <pbrobinson@gm=
ail.com> wrote:
> > > >
> > > > On Fri, Dec 8, 2023 at 12:52=E2=80=AFPM Shantur Rathore <i@shantur.=
com> wrote:
> > > > >
> > > > > Hi Jagan,
> > > > >
> > > > > On Fri, Dec 8, 2023 at 11:13=E2=80=AFAM Jagan Teki <jagan@amarula=
solutions.com> wrote:
> > > > > >
> > > > > > On Sun, Nov 19, 2023 at 10:54=E2=80=AFPM Shantur Rathore <i@sha=
ntur.com> wrote:
> > > > > > >
> > > > > > > Rockchip SoCs can support wide range of bootflows.
> > > > > > > Without full bootflow commands, it can be difficult to
> > > > > > > figure out issues if any, hence enable by default.
> > > > > > >
> > > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  arch/arm/Kconfig | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > > > > index d812685c98..fca6ef6d7e 100644
> > > > > > > --- a/arch/arm/Kconfig
> > > > > > > +++ b/arch/arm/Kconfig
> > > > > > > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> > > > > > >         imply CMD_DM
> > > > > > >         imply DEBUG_UART_BOARD_INIT
> > > > > > >         imply BOOTSTD_DEFAULTS
> > > > > > > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> > > > > >
> > > > > > Yes, but better to give this option to specific board vendors a=
s
> > > > > > defaults are enough to boot 1st bootflow and what ever media's =
it has.
> > > > > >
> > > > >
> > > > > Yes, that's correct it is enough to boot but by default there is =
no option
> > > > > to choose what to boot from.
> > > > > This was discussed in an earlier version of this patch [0] where =
I was
> > > > > explicitly enabling only for RP64.
> > > >
> > > > What actual extra functionality does this provide, what is the impa=
ct
> > > > on the size of images? You've not provided reasonable justification
> > > > outside of very vague statements, it would be useful to know what t=
he
> > > > added options actually solves.
> > >
> > > BOOTSTD_FULL enables all the options in bootflow commands. This is ne=
eded if
> > > - you want to choose between multiple available bootflows rather than
> > > just boot one default.
> > > - if you need to list the available bootflows that bootstd has found
> > > - if you need to select and boot any bootflow other than default.
> > > By default all other commands in U-boot come with options to show det=
ails
> > > For example, nvme info, nvme detail, usb info, usb tree but with
> > > bootstd no way to know anything.
> > >
> > > Image size - u-boot.itd without BOOTSTD_FULL - 1193984 bytes
> > > Image size - u-boot.itb with BOOTSTD_FULL - 1214976 bytes
> > > Difference - 20992 bytes
> > >
> > > According to binman for RK3399 u-boot can take upto 4M [1] so we have
> > > ample space.
> > >
> > > This was discussed in the previous patch in the link below [0]
> > >
> > > [0] - https://patchwork.ozlabs.org/project/uboot/patch/20231111001329=
.537704-1-i@shantur.com/
> > > [1] - https://github.com/shantur/u-boot/blob/master/arch/arm/dts/rk33=
99-u-boot.dtsi#L68
> >
> > If I'm recalling everything right, this also brings "bootflow" as a
> > command more in line with what could be done with distro_bootcmd in
> > terms of "cover every possible case and let the user override things"
> >
> Yes,
> That's correct.
>
> U_BOOT_LONGHELP(bootflow,
> #ifdef CONFIG_CMD_BOOTFLOW_FULL
> "scan [-abeGl] [bdev]  - scan for valid bootflows (-l list, -a all, -e
> errors, -b boot, -G no global)\n"
> "bootflow list [-e]             - list scanned bootflows (-e errors)\n"
> "bootflow select [<num>|<name>] - select a bootflow\n"
> "bootflow info [-ds]            - show info on current bootflow (-d
> dump bootflow)\n"
> "bootflow read                  - read all current-bootflow files\n"
> "bootflow boot                  - boot current bootflow\n"
> "bootflow menu [-t]             - show a menu of available bootflows\n"
> "bootflow cmdline [set|get|clear|delete|auto] <param> [<value>] -
> update cmdline"
> #else
> "scan - boot first available bootflow\n"
> #endif
> );

I suggest we keep it off for now, as we did put in quite a bit of
effort to reduce code size. It would be a shame to throw it all away.

That said, I can imagine this becoming a pain for people over time, as
the 'bootflow' command becomes the common way to interact with U-Boot.
I just wonder if it is too early to make the switch?

Regards,
Simon
