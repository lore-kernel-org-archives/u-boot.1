Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1504C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 19:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FC787ABE;
	Thu, 28 Dec 2023 20:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HFmdLB//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CDF787A7F; Thu, 28 Dec 2023 20:48:23 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C033E87ABE
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 20:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67fa018c116so35702486d6.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 11:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703792899; x=1704397699; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2TqRPFlYXv5avOfgdpn+rqd1Qj/Q5sLie1gQsiiSfU=;
 b=HFmdLB//k+SD4A8aTDA21cSHxMT42PE5hOaXxqjVxZ7F7TE5++X8m6u9+oLLEM6tMP
 gtP41IMvRGT+dLJUm1LbTtn/iQnJfpOgR1HISqV+aL4WBRSEUD4D/VJHAImlVjmVYPFU
 I3/t6yjRs1URmTGCV90ksPqUa8dlF45NV17Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703792899; x=1704397699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2TqRPFlYXv5avOfgdpn+rqd1Qj/Q5sLie1gQsiiSfU=;
 b=syIOpiRi8n4HK+6B+0Pug6Prz29kK0044Rt3K8cU29U3qoiKNmk9Gnx5Mcfs79k9V1
 ZkbLmqXY4FcToNfb1v7dSGBs9lTeBlP1FA/brg2zRlrhxKS3JRVkNBAc+D1XHMTHpYIz
 6+YMJme9IuTpCr5ZTUllPdgq0slxZA+9TdSLYw4ekT0kfiFwjcYtqVmWJwTVCQuuYFgJ
 VDzMIlIXwdi6X74vllXy2odl/ILegyYWCKLx8KQGon0RKPmXBr26xYrtunsrgSLefBWe
 cr5Zbclc7s0hZ1PN/UWxmYI9rwmuMyKDVS13wfrSfJ+22cAKvDk5euix9R56BHPu5NRe
 VzHQ==
X-Gm-Message-State: AOJu0Yz4g4bbi7YbQFtXL0AG8bDXYfugbe4AbYP6dbxSa25TDII4uruZ
 SIAd9JKAhcvi53yLvnZyZNxafwDoWMJw6JnFXeA2rhFtmnDC
X-Google-Smtp-Source: AGHT+IGD9CvdptIsihVS5FOD07CW99PFXgyTbvhkyrjHoiRGxM8BlJQW3p0l4vtjmHwpKtyVppgNtoiJRNDazBestEE=
X-Received: by 2002:a05:6214:2aa9:b0:67f:2c33:3aca with SMTP id
 js9-20020a0562142aa900b0067f2c333acamr15313217qvb.78.1703792899611; Thu, 28
 Dec 2023 11:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227132156.GQ2652760@bill-the-cat>
 <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
 <20231228142311.GD2652760@bill-the-cat>
 <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
 <20231228154019.GH2652760@bill-the-cat>
In-Reply-To: <20231228154019.GH2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 19:48:08 +0000
Message-ID: <CAFLszTgZfAHATieERE1x8hhoFHpYDK4Vq4=VVmQapKEn63diyA@mail.gmail.com>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 =?UTF-8?Q?Andreas_Bie=C3=9Fmann?= <andreas@biessmann.org>, 
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>, 
 Minkyu Kang <mk7.kang@samsung.com>, Scott McNutt <smcnutt@psyent.com>, 
 Thomas Chou <thomas@wytron.com.tw>
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

On Thu, Dec 28, 2023 at 3:40=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass wrote:
> > > > >
> > > > > > U-Boot builds devicetree binaries from its source tree. As part=
 of the
> > > > > > Kconfig conversion, the Makefiles were updated to align with ho=
w this
> > > > > > is done in Linux: a single target for each SoC is used to build=
 all the
> > > > > > .dtb files for that SoC.
> > > > > >
> > > > > > Since then, the Makefiles have devolved in some cases, resultin=
g in
> > > > > > lots of target-specific build rules. Also Linux has moved to us=
ing
> > > > > > subdirectories for each vendor.
> > > > > >
> > > > > > Recent work aims to allow U-Boot to directly use devicetree fil=
es from
> > > > > > Linux. This would be easier if the directory structure were the=
 same.
> > > > > > Another recent discussion involved dropping the build rules alt=
ogether.
> > > > > >
> > > > > > This series makes a start at cleaning up some of the build rule=
s, to
> > > > > > reduce the amount of code and make it easier to add new boards =
for the
> > > > > > same SoC.
> > > > > >
> > > > > > One issue is that the ARCH_xxx Kconfig options between U-Boot a=
nd Linux
> > > > > > are not always the same. Given the large number of SoCs and boa=
rds
> > > > > > supported by U-Boot, it would be useful to align these where po=
ssible.
> > > > >
> > > > > I don't know why we should start with this now, and further not b=
eing on
> > > > > top of Sumit's series to remove our duplicate dts files. And that=
's
> > > > > where we can have the conversation about for which cases it even =
makes
> > > > > sense to build all of the dts files for a given SoC.
> > > >
> > > > This is a completely different series - there are no conflicts with
> > > > Sumit's series so it can be applied before or after it.
> > > >
> > > > My goal here is to clean up our build rules, rather than just throw=
ing
> > > > them all away, for reasons we have discussed previously. I filed [1=
]
> > > > to track that.
> > >
> > > Yes, I'm saying we shouldn't be doing anything this series does until
> > > after Sumit's series has landed. Along with the fact that I don't lik=
e
> > > what's going on in this series.
> >
> > This seems to again be the disagreement over whether a single DT
> > should be build for each board, or all the DTs for an SoC?
>
> It's about the disagreement on what we should be building, and what that
> infrastructure looks like. I do not like adding extra rules for
> "clarity" because they don't make things clearer, they lead to the
> unclear mess we have today getting worse. Most instructions are _not_
> "now take this dtb and this binary and .." but just "take this binary",
> because we already have the rules and logic to ensure we build the
> required dtbs. I also don't like the parts of this series that amount
> to deck shuffling when we should just be taking the chairs away. There's
> just not nor will there be a case for omap3/4/5 platforms of "change the
> dtb", so building more is pointless. For other SoCs, there may be some
> cases of "this could have been just a DT change", like
> rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig could share a board
> dir, but the configs are different and the dts are different, so I don't
> know that you could really just swap the dtbs.

It is true that we have a different defconfig for each board, but IMO
that is not good. It is an artifact of the way the build system works.
IMO Kconfig should be used to define sensible defaults so that the
defconfigs are nearly empty. Perhaps config fragments can be part of
the mix, if we can agree on [1].

But if we let this genie out of the bottle, it will be impossible to
put back in. The devicetree should control the hardware in U-Boot and
it should be possible to use the same U-Boot proper on all boards
which use the same SoC.

Regards,
SImon

[1] https://patchwork.ozlabs.org/user/todo/uboot/?series=3D380278
