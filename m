Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E233C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 14:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8BBF807D7;
	Tue, 11 Mar 2025 15:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nE9rTRxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0894F80FB9; Tue, 11 Mar 2025 15:13:08 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A4F801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2993924f8f.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741702385; x=1742307185; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wrg1kn/RXj0C0c6RrFT9bHS/s3ojaL65HPRiUl4gJZQ=;
 b=nE9rTRxEqq57UsXUGZZ67hb5dPnDL0eAXC9lfBG7C+CUWUWkupj/kSIFHsZy/2oPB4
 K1MhYKbTHlIJKn6nPmFzCtiYFDVTPXb2kgsEP7zYULX2meODMX+RDOk3RLj1dlS8SBij
 7x81sCCLqzqmnaqg1y3YCeQ6KjXkPMvrKfQSdp8N3w1wKQiu4QBQn8URr4ddjeSscNmy
 E9BiDDa6OxBTK+TYqcfXaqKZ1ku3ruPBq+Qn/+6meA1ZaGEjrwu4ZcqODg+inFQfczgJ
 MzvlX+P5DRVNc4fQVPMvQnkY+QLX5mhKT8uPtWx7vanzL6ocYU5CXNA++iodmGUwF6BS
 5IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741702385; x=1742307185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wrg1kn/RXj0C0c6RrFT9bHS/s3ojaL65HPRiUl4gJZQ=;
 b=AJ65Yht+e6y/UxlUwawPQv7gdUlFlaD+Gpfb/DVbVByZiD3ti9HIdJm0uzcx7kujTf
 FE6SNYyyjJKcCr6arhX+18JhNGu5LvxUEulEB41IQHYXVFUmRgNg9kKQorIXWwiV0l0u
 ZoKfBrApLVQkdNHUZgYZCTgDE5NKC4xAPANQO1A7ualYFXxBN3sp49aRHkjTgp8cb/WL
 +UgOKrkPYHlvogYc+9Ewa1w4e9aO13Xg50sn9l2FSXywWmGnOfXoyNi5bd1ORSFmUoe7
 gA06E2iEUTz3T6lr3kg2xquh1YK6FAIpIhkkWkEDBN8QY9WJeqQEV6Wu9XN4zliElpph
 l4Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM5tmfR6nhHi9n5W1zszLgXek3qS2cK586qVnkTNLpV2sjVbQ+KsKsIjXsrVqXNiog6AX1Wmo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyw9DCuWlxD/woJ5OQJfbbw+UDDXXyo0TyZBuqRXCgQOjtaOgi0
 YRO/QFvyxqD3SfQUMqDNk5efTwLKRkaGLafO1ZIGmfNoyBsv0QkYIlaV2hTmScHdS0raoyo2J6G
 G8m+sj4W29VnRdimDuJUWcYRRTTiTPw==
X-Gm-Gg: ASbGncsLlPON0Y2mbxeFvH3F5uEZiqLutVVUvXCcT5WlEoG+PurgHkoBp1VnL7Kxz7N
 OHrWOw42jcs4chdquVLXUCHrHKXzR88/Bf+fbzFhH2bRhTs0LTulxumZ0uc/9JCUW6s3TLtUMWZ
 YMtBwhpoBdz4o947SzmegWI6vDLQ8=
X-Google-Smtp-Source: AGHT+IEqdR6J79jAtxABd4MiL41yXpQwIt8nYRE6d/CfHv7xpWHXaKERrZepItaztShQ7/bzh7pi7SHk05W1wjJJ0Oc=
X-Received: by 2002:a5d:64a4:0:b0:391:a74:d7dc with SMTP id
 ffacd0b85a97d-39132db7543mr14031393f8f.50.1741702385004; Tue, 11 Mar 2025
 07:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250305111213.163428-1-clamor95@gmail.com>
 <20250305111213.163428-2-clamor95@gmail.com>
 <kfyuo4l2w4menkfrb2sbvvp2ptumyed7bvz64vrnpm7lx6dpqe@hxo2633n2poq>
 <CAPVz0n1H5rktuYJ=HGMiXtOqyOFLSEJeyUJvcEdGcr1T_PfCrA@mail.gmail.com>
 <tcwixvrk57o5rtrfycjj6u6r3e3lrbyfjbinddy7i3vqryy32u@m7emuzsuikdn>
 <CAPVz0n0XBm-vDazOPX-i=2Dr_CJCU0EKziRR+gPeP-vWAh=sSA@mail.gmail.com>
In-Reply-To: <CAPVz0n0XBm-vDazOPX-i=2Dr_CJCU0EKziRR+gPeP-vWAh=sSA@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 11 Mar 2025 16:12:53 +0200
X-Gm-Features: AQ5f1JpBvKM4MNN1v0TmAgQ3i1GELQQ6jaIrvIIZIrfTU4n-rJY0GNvuGRYDOS4
Message-ID: <CAPVz0n2i9EL869OfMUxVdVd80NnnsMDsjTneY+a3ujyP68RGNg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ARM: tegra: clock: fix PLLD/PLLD2 related clock
 calculations
To: Thierry Reding <treding@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 16:35 Svyat=
oslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 16:02 Thi=
erry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Mar 05, 2025 at 03:52:36PM +0200, Svyatoslav Ryhel wrote:
> > > =D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:47=
 Thierry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Wed, Mar 05, 2025 at 01:12:12PM +0200, Svyatoslav Ryhel wrote:
> > > > > From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> > > > >
> > > > > While PLLD/D2 is the nominal parent clock, all derived clocks are=
 generated
> > > > > from its single output, plld_out0, which is PLLD/D2 divided by tw=
o. Direct
> > > > > use of PLLD/D2 is absent in peripheral clock configurations. Ther=
efore,
> > > > > clock derivation formulas must take in account this division.
> > > > >
> > > > > Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  arch/arm/mach-tegra/clock.c | 30 +++++++++++++++++++++++++++++-
> > > > >  1 file changed, 29 insertions(+), 1 deletion(-)
> > > >
> > > > In Linux we ended up exposing the _out0 branches of the display clo=
cks.
> > > > Wouldn't that be a better way to describe this?
> > > >
> > > > Thierry
> > >
> > > You are not satisfied with the description or with solution?
> >
> > I meant the solution. However I might have misunderstood what you're
> > doing here. This is actually computing the rate of the _out0 branches,
> > which are the ones listed in the DTS files as parents, correct?
> >
>
> Basically this is u-boot equivalent of Linux approach, well its final
> stage. This patch does 2 things. First, it updates pll_rate[id] value
> if rate is changed which was not done since usually PLL do not need
> updates till we hit display clocks. Second, it fixes display clock
> children divider calculation taking in account that raw plld/d2 freq
> is halved. And all this does not break existing drivers which use plld
> in any way (I have checked that on all generations till t124
> including).
>
> Introducing plld_out0 instead of plld Tegra wide will basically add
> more confusion and possibly hidden regressions since all drivers using
> plld as parent take in account this quirk.
>

If you have no suggestions, objections or proposals, I assume this
patch can be accepted.

> > Thierry
