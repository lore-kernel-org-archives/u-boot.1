Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F56FD9E22
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F87C83E81;
	Fri, 27 Feb 2026 00:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IDPXBPp9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182BA83D1A; Fri, 27 Feb 2026 00:45:17 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76A1583E81
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65fb991d7e7so1905628a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:45:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772149513; cv=none;
 d=google.com; s=arc-20240605;
 b=UP3c+QrpdW4p6K8A2rXBQf8STf+WNR+rTD+g9fj8cE5Z7dLq4T6pLazNTlJaMrBcOu
 2/3vCWjZAGCgTAJioqwaWpMJlZOLb0o7BMZgcKNLjLoMq1u/I8hQEvPITd8mgBGBonFk
 xpSzPtk5QmBhmv6mLfOzeHN7vzgP/itByH11kls06Sln3N3yt/1hpQAHgwBjKUoWFejB
 /QthPBy1OD4bWdX3ctgLon/AFP60cfIDHCQYy5erEichXulIb439e2kFdhqlh1sPoD3x
 TjgWsjatjco8+2HgPM98do/yBsRiz2QzIHNUqlyHe49WtWOUtmQUPLdCvhYBvefCvjSI
 Byhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SAVeAYgdZXdNLTYhp4QFsstqRj+a7+DivGGUpyy3Iq4=;
 fh=EvbwqM8qZQ8pYolidgKb990duOAN85ANGMYxkqo3GNU=;
 b=XedoWHRhPrzoaC6zhqGGhLrSvVmLl78cqYn/od0Sj9sWJ76pDwIO2f4+F+6TE6pyUN
 /XJm0NMuMwCSp9n/urZeklzfnbp/NbfxlC9cnX193hMhJS93PjJ14T10TOpKmv/S7eNT
 2YzfwbVeWlnEHerrDEvMw9JUHbhJp3XGOMGm2N4K0SnN4n8mx6o31/8XOn2WMvAOpv3A
 Vqc6nzcoSlC+pYYrYuXJMy3rU/ay/BqIaXDno3mYKaHKSBLcpXhW0EvL6JPCKNQj3tt3
 13HVEYvJHhZ7irKLaesw2vGNpX34SVpot0fDOMQQXJlp1QE2s2CD3ZqQjcoUe4YpT2Nr
 p92Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149513; x=1772754313; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SAVeAYgdZXdNLTYhp4QFsstqRj+a7+DivGGUpyy3Iq4=;
 b=IDPXBPp90m7vxjaLvrqOCHcqA6/OS+SwblRSR3UO9es7aeWoFwuh/+liUkMlOdUW6O
 +M/a74ZyNnB4P4FK9sCTcY5yCH5kmJnoAlf6xSLa1+a8j5Ogc/lxIYYb4XZJ0usnCFcQ
 Ck6e9Hztpnm7i/ccK13CrqxRn5+AMYYJT529Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149513; x=1772754313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAVeAYgdZXdNLTYhp4QFsstqRj+a7+DivGGUpyy3Iq4=;
 b=P3b/8qKDwz+MC73YVqTT2OQSS8G3bhtMdFR68SdMtud3PhuAKafN6W+m/UFYmjRnXD
 a/1Mhc8cjVQEI1DiVfP4OrAfUkO9u2j4iP2/ZZ2XU28B6SEvB4vZ60+ky9WjOHcm450i
 JIpcU7M+AY2H3APxtVvtuUKkVzm26NhLMC1Z9cCBVlvMvJiac/I85oA+nOl5UnLbmDVZ
 nHqB5E7BOqZPU2qN0OBTLRTsOR7DfDVEfKA0DysAk0VBXmI1KvQot/iV77KKLLPuZbPQ
 Q3msfWEHfzUTzOiQ2ViBgqgun8brVaNqInbZCoi4HiR0eInTMxv45B1naxpNcSi6vScu
 FKWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7aJ8ZemyyPwtyGDppBir/TWO+huBocLOKh8tIDc/St8jM8hZSjFd2xQ/ikbqPwQinOT7TpLw=@lists.denx.de
X-Gm-Message-State: AOJu0YzL1IFoJuQDwXWIUh+w4Jy6P/c3eWyZYe6FjucSPzzueo3MqNaL
 lhWLUeDfylIW3ykeH8PpDMZxiOMd2tb7HMEPJohqIJQGyGaRRIdRJzSuH5E/xUFwyDXKw13OQuD
 7RFqs+r5ul9BJGydNfGdW+gAEo5g+hLUf+yDVOIU4
X-Gm-Gg: ATEYQzyUh8lLJtjOHs43V09FQ8zqIRh6dJ8g1fLFUX0wPO/FsPVHPCL/GexonAAYiU2
 8iiuq8wNGk+qXhxFtjfkdvUpvIweRDKjzUNN5OFPNsMTyN0N3JD0J5dcPdhUUZUEn7oSphEGZxF
 30oHfpUP6UmolAD5t9/D6Uq/qgHmyjieapCPlK0M/YPTX6PMjWho61C+JCzks58mIGDRkF4dBdr
 EaRrbGTA1M5Gbt8CR2kr6zyqHU35+njgcl1A2hMuRSIzf+EoJStNze4LadUJPQc/U23Wlqrlugk
 8Laiaw==
X-Received: by 2002:a05:6402:42c4:b0:65f:82dc:f127 with SMTP id
 4fb4d7f45d1cf-65fddcfa881mr738114a12.17.1772149512821; Thu, 26 Feb 2026
 15:45:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217174617.GD2747538@bill-the-cat>
 <20260223193219.GF3233182@bill-the-cat> <aZ2SI0rKuMEgSq1F@makrotopia.org>
 <20260224172444.GA3233182@bill-the-cat> <aZ8IXfm1TEPMqb4a@makrotopia.org>
 <20260225221611.GX1593142@bill-the-cat> <aZ-KgxENCGLR73lf@makrotopia.org>
 <20260226184512.GL1593142@bill-the-cat>
In-Reply-To: <20260226184512.GL1593142@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Feb 2026 16:44:50 -0700
X-Gm-Features: AaiRm516RSkV2OJ7eOip7k2a2G1Ih2TprbME6Lcb0_j0lZZec1we5vvElAsy_nI
Message-ID: <CAFLszTjV5PK4OEz4Ry_n4KXp_PNy=D8tLK+2CZJyY0RqDnX84A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand FIT
 loading
To: Tom Rini <trini@konsulko.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 26 Feb 2026 at 11:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 25, 2026 at 11:49:23PM +0000, Daniel Golle wrote:
> > On Wed, Feb 25, 2026 at 04:16:11PM -0600, Tom Rini wrote:
> > > On Wed, Feb 25, 2026 at 02:34:05PM +0000, Daniel Golle wrote:

[..]

> > One thing which I'm anaway not interely decided about is whether to
> > build fit_verity_build_params() (the function which reads the dm-verity
> > parameters from FIT and generates the Linux cmdline arguments from that)
> > on top of bootflow_cmdline_set_arg() or to just generate the whole
> > string and use env_get(), env_set() on the "bootargs" env variable.
> >
> >
> > Not using bootflow_cmdline_set_arg() would also mean that in the case of
> > bootmeth_openwrt nothing would be using it, and that would free 688
> > bytes, while fit_verity_build_params() might get a very tiny bit larger,
> > certainly less than that.
> >
> > The thing is that it looks to me like bootflow/bootmeth is meant to ignore
> > "bootargs" and overwrites it just before boot. On the other hand, having
> > a generic feature such as generting the dm-mod.create=... Linux kernel
> > cmdline parameter from the values stored in FIT depend on bootmeth, or
> > even a specific bootmeth, also seems wrong.
> >
> > I'd be happy to hear your opinion about that.
>
> It should probably exist outside of the bootflow/bootmeth code, yes. As
> we start expanding the real usage of bootflow/bootmeth we do need to
> make sure that it's not doing things that violate user expectations, so
> I'm not 100% sure if we are or aren't doing anything odd with bootargs,
> depending on the flow.

We do have 'bootflow read' which reads the files and sets things up
ready to boot. Bootstd is designed to keep the bootargs env var
aligned which whatever is the current bootflow (bootflow select).

But yes, it is useful to be able to do things 'manually' and we should
try to avoid something which is automatic but cannot be decomposed for
debugging, etc.

[..]

Regards,
Simon
