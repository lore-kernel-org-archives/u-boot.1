Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161F3C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 23:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B5E874AC;
	Sat, 23 Dec 2023 00:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="lnRuZaTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 607AE87579; Sat, 23 Dec 2023 00:47:51 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3877286BA8
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 00:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7812bed1c86so77963885a.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 15:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1703288867; x=1703893667;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GP+KcZkuSwUvU3Z2GfbbxLYv3KHM8OWjhtzKO2izPKY=;
 b=lnRuZaTtkodzvwsBGJaDwpM5T9rbXnkzP0kI73RYbD82zQ9j3Z+UzRf4hH4X4GS3Jf
 X+fOsCwb4TxxGhpucvQ69DbMlnWGsneOe9V5D4BR8Iq41jNCEW8MJYaR86UALDlSyVKU
 GfT1pm/CaT0ThOmQXoM/6KUmbYFtkA+XOcNGXvm2i6aLRc2bckjbSyz3xC0FxFiF4eBW
 n4rRGduWn/QzRspNZS6h9B5kIq91DwAkoH6vp7rvjhZTFfzFFynlr8jAtzd1UvD9Rqzz
 sB5t6/H4j+oOct1xnwcW2Tau7om/LZFZYAIrK+fnkF/xW5GCPa8ip3veEJQ1tWwcl0Uy
 tvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703288867; x=1703893667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GP+KcZkuSwUvU3Z2GfbbxLYv3KHM8OWjhtzKO2izPKY=;
 b=A7RAILj4cLc/ezRwRMTzfbg8BhBCkdijDyP/ix9OEEIpnU2quzZgp8jELLxkNodTOn
 fi+J4WpP36J9RFqrw009/KLwnWBL675wnWU97KB9Kkzs6FcnwKxZ4DRC92ktUZdGqaqU
 ab89d5NEbd0xY5L8bsw3a1zlwEOT7PZTnhUCH8dIREaN/DSEzW/hZ5QO0jX6r5sr0u0m
 GTz7mdeeAJgitLcFRuoQPv0JUH1J4M/NSWrlENYXp9Ko3SHQOA6wuKCpAfOuAcpLACbN
 Op+31DffqCQP+8ZXpTHR+lZbC4+QoYdpUbILsrQ9xXEEhCwSsYAfBAp3ohdNXmGhHQzc
 rpgg==
X-Gm-Message-State: AOJu0Yw1UcF8hgbldIrBJRxd42Ubqj0SkQdzuXvsYvIRFvMvZHbmo4tN
 1ptnp+p/ypGm+R0gBnquaEzMjVnF/z+UZu10ZIUkzDOG9teSuA==
X-Google-Smtp-Source: AGHT+IElZ0siJhBlYCyxu0ks2PDDOPol7CoFa5OF1eT805lYY1iIHnFm6T7G6HL6ahYp9Sv3YQ06UfS1EY0p6OVeoOs=
X-Received: by 2002:ae9:f70e:0:b0:77b:e2ae:934c with SMTP id
 s14-20020ae9f70e000000b0077be2ae934cmr2370945qkg.12.1703288867045; Fri, 22
 Dec 2023 15:47:47 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
 <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
 <20231209205627.GI2513409@bill-the-cat>
 <CABEcMwXYCczbTRVgqGC=USRJw138tDM0RkbmGoR4zSY7pBj1PA@mail.gmail.com>
 <CAPnjgZ3gEoOFxahZ2mg=MTQTmBPyCBphS8uVcpSSwq2bg4eJwQ@mail.gmail.com>
 <20231211181918.GS2513409@bill-the-cat>
 <CAPnjgZ3+yJCNgO635gSsDbrb-BpQvJTOqo4qHoWxunvbHZ8jyQ@mail.gmail.com>
 <20231211182710.GT2513409@bill-the-cat>
 <CABEcMwUuoHp2JWDkPacadL1X3-x9wVKH-OZuYx6Cvx_kWCCNUw@mail.gmail.com>
 <20231222120700.GW2513409@bill-the-cat>
 <CABEcMwU521x5_JMsZkGS-hnr2B+w8SNA31-7VXfwo3aPrXytwQ@mail.gmail.com>
In-Reply-To: <CABEcMwU521x5_JMsZkGS-hnr2B+w8SNA31-7VXfwo3aPrXytwQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 22 Dec 2023 23:47:35 +0000
Message-ID: <CABEcMwXKm_5XnxrftAzO27okrPVxozjMwDKSU4p6udyxccSrcg@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
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

On Fri, Dec 22, 2023 at 12:09=E2=80=AFPM Shantur Rathore <i@shantur.com> wr=
ote:
>
> On Fri, Dec 22, 2023 at 12:07=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Fri, Dec 22, 2023 at 12:05:39PM +0000, Shantur Rathore wrote:
> > > Hi all,
> > >
> > > On Mon, Dec 11, 2023 at 6:27=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Mon, Dec 11, 2023 at 11:22:45AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > [snip]
> > > > > > I think in hind-sight too much stuff is omitted without BOOTSTD=
_FULL.
> > > > > > The option itself then enables other stuff too by default, but =
some
> > > > > > parts of the bootflow command itself should be visible even wit=
hout FULL
> > > > > > to make things easier on the user.
> > > > >
> > > > > At the time the goal was to avoid growth compared to the distro
> > > > > scripts. We could perhaps add some more things in with BOOTSTD_FU=
LL
> > > > > but still have it as an option?
> > > >
> > > > Right. But now that we've tried this, some of the feedback has been=
 that
> > > > it's just too minimal right now. Like looking at the help message f=
or
> > > > bootflow, list and info should probably always be available. And ma=
ybe
> > > > the flags for "scan" should be re-thought? Too late to change thing=
s now
> > > > but "bootflow scan -b" should maybe how it's always been for "scan =
and
> > > > boot".
> > >
> > > What would be the preferred approach for this patch?
> > > Is it to update the default capabilities of bootflow or we can have t=
his patch?
> >
> > Well, I don't see a problem with just adding this to the platforms whic=
h
> > enable BOOTSTD_FULL until we can rework what's included/excluded by tha=
t
> > flag, and there's an issue filed for it now.
> >
> > --
> > Tom
>
> Great,  can we have this merged in please then [0]
>
> [0] - https://patchwork.ozlabs.org/project/uboot/patch/20231119172310.130=
7942-1-i@shantur.com/
>

I tried this patch over the next branch and it failed to build.

Sent v4 here :
https://patchwork.ozlabs.org/project/uboot/patch/20231222234358.563121-1-i@=
shantur.com/

Regards,
Shantur
