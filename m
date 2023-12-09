Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704C4C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 22:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52CF875A4;
	Sat,  9 Dec 2023 23:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="eoK9iji0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDEA875DB; Sat,  9 Dec 2023 23:19:07 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCC08758F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 23:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6d9dc789f23so1935092a34.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 14:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702160343; x=1702765143;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iu2vbosxKgM/XJCwav4KC2jZN3tNdfiEm0VO75u6adM=;
 b=eoK9iji0xA8e9Ue+K2SKLF76DpP9K98ASHhAi+F5IHENXw6Bjqw1smxhvi8tzJGNdh
 lHDbs3cIXx8HS2a/46bsxFnKh/IpgbXb4LAfRv8FO0rT7h/RMDrOk3iiIoH4NzKfcKjN
 /lf18623zUC1DQnl3x5C7W39SCj5kyI1qeyswbVo3xJOiB+wmXWkKjTgQATSp37etCtL
 taavKSOBKgZx1P0lcLdmJVDLg7tQCObky6DK+0SBzw7yowpnVOgPmzG9k9PurQQXyE/q
 APk2H0upzZFSLjg0TN2L56VJTQM6OjABDMQsKuwKXl5BOy5scmvD6kozsPB9gCAcswcU
 bGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702160343; x=1702765143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iu2vbosxKgM/XJCwav4KC2jZN3tNdfiEm0VO75u6adM=;
 b=ZF8D32z+WsTAml2gE4svuMoEpEUx5g+CwMkcWPNuB081kcj4qBLx8IO2vqqYGxJZqh
 xEr3c42j9kYio2u3Br1AjcRfPkglFKm1U3s6Rn95stleYFoSSq9cFmsrnAap4xOefkJH
 GFyRSmSILpFYu+Kln0rFdloNUjwdZLHR8BypOoKOx66CUYj+wqyZX2LlgjlWLWuHGXSY
 bsa2Y2vJVf57psksX7+orutdJWnVH5TUCA07JJHdFxCI0hAQPxsFoGbU/zSNGTnzpOCL
 e9jT9Y2ik5rrL03v5VOmhTFPJqrj4q52uZVaD7Te79ib4qeSWRF5gBy4yxwwsRGPDr0s
 Kb7Q==
X-Gm-Message-State: AOJu0YxyeaQp5cBcbtk2Q+kenYuR429xyCrL4qEGzZLDvzMTGU2KFNnv
 MoHx1AEM4C9UKZBwS/gQZT/EdLpHlB3VKJzcXVYnGg==
X-Google-Smtp-Source: AGHT+IEnGSr4iAEBbIaBKT2CLaeIWHhRutc9H+ykBzYZE6U/NXi3vPJBJvuJaSkJ4wwPiiE4GmXV1kr4CcGnDqjBO2U=
X-Received: by 2002:a05:6808:bcf:b0:3b8:ba0a:3460 with SMTP id
 o15-20020a0568080bcf00b003b8ba0a3460mr2530179oik.17.1702160342976; Sat, 09
 Dec 2023 14:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
 <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
 <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
 <20231209205627.GI2513409@bill-the-cat>
In-Reply-To: <20231209205627.GI2513409@bill-the-cat>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 9 Dec 2023 22:18:51 +0000
Message-ID: <CABEcMwXYCczbTRVgqGC=USRJw138tDM0RkbmGoR4zSY7pBj1PA@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Bharat Gooty <bharat.gooty@broadcom.com>, 
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

On Sat, Dec 9, 2023 at 8:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 08, 2023 at 01:59:26PM +0000, Shantur Rathore wrote:
> > Hi Peter,
> >
> > On Fri, Dec 8, 2023 at 12:59=E2=80=AFPM Peter Robinson <pbrobinson@gmai=
l.com> wrote:
> > >
> > > On Fri, Dec 8, 2023 at 12:52=E2=80=AFPM Shantur Rathore <i@shantur.co=
m> wrote:
> > > >
> > > > Hi Jagan,
> > > >
> > > > On Fri, Dec 8, 2023 at 11:13=E2=80=AFAM Jagan Teki <jagan@amarulaso=
lutions.com> wrote:
> > > > >
> > > > > On Sun, Nov 19, 2023 at 10:54=E2=80=AFPM Shantur Rathore <i@shant=
ur.com> wrote:
> > > > > >
> > > > > > Rockchip SoCs can support wide range of bootflows.
> > > > > > Without full bootflow commands, it can be difficult to
> > > > > > figure out issues if any, hence enable by default.
> > > > > >
> > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  arch/arm/Kconfig | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > > > index d812685c98..fca6ef6d7e 100644
> > > > > > --- a/arch/arm/Kconfig
> > > > > > +++ b/arch/arm/Kconfig
> > > > > > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> > > > > >         imply CMD_DM
> > > > > >         imply DEBUG_UART_BOARD_INIT
> > > > > >         imply BOOTSTD_DEFAULTS
> > > > > > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> > > > >
> > > > > Yes, but better to give this option to specific board vendors as
> > > > > defaults are enough to boot 1st bootflow and what ever media's it=
 has.
> > > > >
> > > >
> > > > Yes, that's correct it is enough to boot but by default there is no=
 option
> > > > to choose what to boot from.
> > > > This was discussed in an earlier version of this patch [0] where I =
was
> > > > explicitly enabling only for RP64.
> > >
> > > What actual extra functionality does this provide, what is the impact
> > > on the size of images? You've not provided reasonable justification
> > > outside of very vague statements, it would be useful to know what the
> > > added options actually solves.
> >
> > BOOTSTD_FULL enables all the options in bootflow commands. This is need=
ed if
> > - you want to choose between multiple available bootflows rather than
> > just boot one default.
> > - if you need to list the available bootflows that bootstd has found
> > - if you need to select and boot any bootflow other than default.
> > By default all other commands in U-boot come with options to show detai=
ls
> > For example, nvme info, nvme detail, usb info, usb tree but with
> > bootstd no way to know anything.
> >
> > Image size - u-boot.itd without BOOTSTD_FULL - 1193984 bytes
> > Image size - u-boot.itb with BOOTSTD_FULL - 1214976 bytes
> > Difference - 20992 bytes
> >
> > According to binman for RK3399 u-boot can take upto 4M [1] so we have
> > ample space.
> >
> > This was discussed in the previous patch in the link below [0]
> >
> > [0] - https://patchwork.ozlabs.org/project/uboot/patch/20231111001329.5=
37704-1-i@shantur.com/
> > [1] - https://github.com/shantur/u-boot/blob/master/arch/arm/dts/rk3399=
-u-boot.dtsi#L68
>
> If I'm recalling everything right, this also brings "bootflow" as a
> command more in line with what could be done with distro_bootcmd in
> terms of "cover every possible case and let the user override things"
>
Yes,
That's correct.

U_BOOT_LONGHELP(bootflow,
#ifdef CONFIG_CMD_BOOTFLOW_FULL
"scan [-abeGl] [bdev]  - scan for valid bootflows (-l list, -a all, -e
errors, -b boot, -G no global)\n"
"bootflow list [-e]             - list scanned bootflows (-e errors)\n"
"bootflow select [<num>|<name>] - select a bootflow\n"
"bootflow info [-ds]            - show info on current bootflow (-d
dump bootflow)\n"
"bootflow read                  - read all current-bootflow files\n"
"bootflow boot                  - boot current bootflow\n"
"bootflow menu [-t]             - show a menu of available bootflows\n"
"bootflow cmdline [set|get|clear|delete|auto] <param> [<value>] -
update cmdline"
#else
"scan - boot first available bootflow\n"
#endif
);
