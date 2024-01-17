Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6743C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 06:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17AC386D82;
	Wed, 17 Jan 2024 07:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="Qo6SaI3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E5C86DC3; Wed, 17 Jan 2024 07:26:26 +0100 (CET)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7886E86BFA
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 07:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7cdb67ec4caso3156814241.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 22:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1705472782; x=1706077582;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cbfgFQDyNeh17op1FQDXH0WOz7Rqy5fy+7G0rmwyraE=;
 b=Qo6SaI3sTaFPEACePKN5GB5Lr+m0Xe43rfi1jnai49JwtV0+FiKP0tDf6/jB4GB3Kv
 5K3MFfZMmeGN8TMgqbjm/dhobK+gQbfEid2/0mlDArjAvSv+AkPMuim1jbaFnfmRzc4Y
 +UlSVFnK9GIonMDXlO2Z2wOo04T8AXTA0GjZ+alXP7t5kX1f2HUwuYsdb6DMARy+lubW
 uFwXS3fASVXWtUGMlXphGTtqq6UuntBTgKjaFMuNKeZByEwUOjbEw2FM9W5MEhGG/WQK
 7duQoD0qt5NJVj9Dj1SB+ifvz3/0TF6+iQt6BSmG/WlaVJtc2e7G2L79pgR21HYQF9QS
 VoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705472782; x=1706077582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbfgFQDyNeh17op1FQDXH0WOz7Rqy5fy+7G0rmwyraE=;
 b=OXdyucUZ7yRpIGhHCggfu6F2tzE9OC2gjQoyn8/O6TOWEajnB9+j62xYMTQQ/LZUnT
 +a9XbJe5cv6o0MHujiiYizuLBwRWcaLpw5VLuQT/JnKtu6IGSDWUG3hAi95WNRBBRc0y
 PO7F1380ssTv60OCB3BczmtxzvtjAL7v7R4BuYErdWrEi83CCqdre3uXgURZuIGVmCTq
 7MVLUhHjBaHxw7vlTtIRFKWneKgLkd9KoZgdzSpBCSqJd/mBBQGVB9WCSLDarjyYONa5
 aIkWHLeTuPpEysf/++0w55SUSk2IciE5DiW33TKoIRB0nBGHACvdsiaDh2v6xgAhKZ1o
 0zIw==
X-Gm-Message-State: AOJu0Yxshu7anmuNTTyC9drJqSsZafdTw08DJkGEAmK7vPlDMgEIbCYO
 oRCdjHriIUwMKS+jpdSkpt9fj6qztNfQfYBobihuRXgRzf8XFlWcXA5twCXQjFo=
X-Google-Smtp-Source: AGHT+IF5C3cnRY99ubuOauTUcxXzzMpzaEeXdd3ncOXBDG8Qw5t72q/HTqxnuSL6Ig7bMu+ucmc0OtgDEh4mEJN5Qoo=
X-Received: by 2002:a05:6122:3d16:b0:4b6:e333:168e with SMTP id
 ga22-20020a0561223d1600b004b6e333168emr4586949vkb.2.1705472782116; Tue, 16
 Jan 2024 22:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CABEcMwW14BFrA1ZYWTh7iQTsnrXA7LdBPcREKf_QeO71op+Wdw@mail.gmail.com>
 <20231209191853.GA2513409@bill-the-cat>
 <CABEcMwU4C75Xsq9AYdugyPqjPYbrTf3C01gnE+sTM0WDyoMkQg@mail.gmail.com>
 <20231209204507.GH2513409@bill-the-cat>
 <5430e6c4-5d0d-4ddf-bc95-e3fbd2b046cd@rock-chips.com>
 <CABEcMwWfLJ_vHDBLNdFRe4U=+e2fWswF0FD0JAaDF49TtyDp1A@mail.gmail.com>
In-Reply-To: <CABEcMwWfLJ_vHDBLNdFRe4U=+e2fWswF0FD0JAaDF49TtyDp1A@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 17 Jan 2024 06:26:11 +0000
Message-ID: <CABEcMwWt2yMXoRZG_s45G+AMDsuEVvNkdVo-8VA5pxN4wXWvCA@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>,
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

Hi Kever,

On Wed, Jan 10, 2024 at 11:58=E2=80=AFAM Shantur Rathore <i@shantur.com> wr=
ote:
>
> Hi Kever,
>
> On Tue, Jan 9, 2024 at 10:55=E2=80=AFAM Kever Yang <kever.yang@rock-chips=
.com> wrote:
> >
> > Hi Shantur, Tom,
> >
> > On 2023/12/10 04:45, Tom Rini wrote:
> > > On Sat, Dec 09, 2023 at 07:49:04PM +0000, Shantur Rathore wrote:
> > >> On Sat, Dec 9, 2023 at 7:18=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > >>> On Fri, Dec 08, 2023 at 10:52:02AM +0000, Shantur Rathore wrote:
> > >>>
> > >>>> Hi Tom / Kever
> > >>>>
> > >>>> On Sun, Nov 19, 2023 at 5:24=E2=80=AFPM Shantur Rathore <i@shantur=
.com> wrote:
> > >>>>> Rockchip SoCs can support wide range of bootflows.
> > >>>>> Without full bootflow commands, it can be difficult to
> > >>>>> figure out issues if any, hence enable by default.
> > >>>>>
> > >>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
> > >>>>>
> > >>>>> Signed-off-by: Shantur Rathore <i@shantur.com>
> > >>>>> ---
> > >>>>>
> > >>>>> (no changes since v1)
> > >>>>>
> > >>>>>   arch/arm/Kconfig | 1 +
> > >>>>>   1 file changed, 1 insertion(+)
> > >>>>>
> > >>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > >>>>> index d812685c98..fca6ef6d7e 100644
> > >>>>> --- a/arch/arm/Kconfig
> > >>>>> +++ b/arch/arm/Kconfig
> > >>>>> @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> > >>>>>          imply CMD_DM
> > >>>>>          imply DEBUG_UART_BOARD_INIT
> > >>>>>          imply BOOTSTD_DEFAULTS
> > >>>>> +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> > >>>>>          imply FAT_WRITE
> > >>>>>          imply SARADC_ROCKCHIP
> > >>>>>          imply SPL_SYSRESET
> > >>>> Can this please be merged in ?
> > >>> I wonder if we shouldn't really globally default to BOOTSTD_FULL if
> > >>> BOOTSTD_DEFAULTS for everyone.
> > >>>
> > >> Its matter of ~21KB in size, unless any platform is really to its
> > >> limits it should be alright.
> > > Maybe I need to re-check things too, since I wonder how much of that
> > > growth is re-enabling things that were removed when dropping the DIST=
RO
> > > stuff, and so for platforms just migrating over now it would be small=
er
> > > in size if much.
> >
> > A board maintainer is free to enable this option, but I don't agree to
> > enable this for everyone.
> >
> > Not like rk3399 and rk3588, some of other SoCs always want a clean and
> > simple but usable U-Boot,
> >
> > eg. rk3036 and rk3308 are still in the list.
> >
>
> The discussion is what we consider "usable U-Boot"
> By default bootstd doesn't have any options and not even to show what
> it's going to boot.
>
> Would it be acceptable if BOOTSTD_FULL is enabled for SoCs rather than bo=
ards?
>

Can you please suggest the way forward?
Initially the patch was for RockPro64 and then after discussion it was
suggested that as BOOTSTD_DEFAULT is very very limited
we should enable BOOTSTD_FULL for SoCs that can support multiple boot modes=
.

Kind regards,
Shantur
