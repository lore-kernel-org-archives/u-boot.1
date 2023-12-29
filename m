Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105FDC47072
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 16:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2BC87A54;
	Fri, 29 Dec 2023 17:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bld+DZO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B5F87B50; Fri, 29 Dec 2023 17:46:48 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E93C87A3D
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 17:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5537dd673e5so5649233a12.0
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 08:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703868405; x=1704473205; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwZlbFGYFqwp+X7zyX/lqB48YTBi55rTpvhKhpF0euE=;
 b=Bld+DZO2NZI7qhpm2JrgpkTWzlgBXlFW5gPeJqwJBL5yIHZWeIC2utqNA1tplVFEgh
 EDVg7mYSq70cYkpMlJIzhFdV0e/84fR6KNG/pGaQd2JyplumMnRd91WD9vR50pxA9FnL
 a1SOBHMmR6MwSEXC8b+4WjLoJaUjGqjdOuAvxwyyY+EVrwAhHklMmnCzaYIbwj+sQ8L2
 hgdEuy33zIH16p2A9+iAcSlwzW+1wniAcFnVKME672mDTOOvc7T45OGnB0/mt67hPOsn
 JbpBAxAJWmiD0DxdbogGHJzKi8sWMIeZXTztsDLdWVUNu4IXM3YPAuyN8yOxvzP3auwB
 VgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703868405; x=1704473205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwZlbFGYFqwp+X7zyX/lqB48YTBi55rTpvhKhpF0euE=;
 b=QPzXPN7q9Lsn2NjNLvk4OFEKL8lHPhybFZW9HK+em7FYh33y+SlcYo4Ucetzq3ggMF
 YLd8gEj/im06EbjY3HbNvLdDzg44mzCbfsN/qWl+tmwt9/H3lBHnqOHZtv+c+vSblbYv
 58ucHBJNt2fD3cP5tvSV4g6OQN9VZdSbz/nJyVRGfgAQyIAdrFZ+937M8pWnZw1LGS4p
 EVeKo1lfhFcv9vMHde7X+H8dHA6/Hu7xdH1diKxrAQKlEkq3F5AtAbTYu0TDTpfxx8zz
 uFwkJN/o8PW1VrC02z2kEuyeXOuJE/ijmHoFW1fySr4yXGlLgK2ibEv88CqqYB/3Xhry
 SPKQ==
X-Gm-Message-State: AOJu0Yxv7iG33VD86SUf3Im+6jrJ6hD161bBx5hmBvDqvMTLxknb8udM
 EwS2vo3eDXAtMpzMz8F6iLRZpL4iXMaTBazWL3o=
X-Google-Smtp-Source: AGHT+IFyi5O5z2/CzgfEaMCH9Mm6MQotEOHdj7flC4ozwIfNRhtuRUADI9ulqtAUVCW8tQay7zXejaoAkd3YjainSGQ=
X-Received: by 2002:a50:8a9c:0:b0:554:4ad0:9374 with SMTP id
 j28-20020a508a9c000000b005544ad09374mr8118845edj.52.1703868405260; Fri, 29
 Dec 2023 08:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227132156.GQ2652760@bill-the-cat>
 <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
 <20231228142311.GD2652760@bill-the-cat>
 <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
 <20231228154019.GH2652760@bill-the-cat>
 <CAFLszTgZfAHATieERE1x8hhoFHpYDK4Vq4=VVmQapKEn63diyA@mail.gmail.com>
 <20231228204425.GQ2652760@bill-the-cat>
In-Reply-To: <20231228204425.GQ2652760@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 29 Dec 2023 16:46:34 +0000
Message-ID: <CALeDE9MfEd=xjwekR+oVPuWNR7TBPCMU6mc+Z7ig7tc1nhKu_Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
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

On Fri, Dec 29, 2023 at 12:23=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Dec 28, 2023 at 07:48:08PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, Dec 28, 2023 at 3:40=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass wrote:
> > > > > > >
> > > > > > > > U-Boot builds devicetree binaries from its source tree. As =
part of the
> > > > > > > > Kconfig conversion, the Makefiles were updated to align wit=
h how this
> > > > > > > > is done in Linux: a single target for each SoC is used to b=
uild all the
> > > > > > > > .dtb files for that SoC.
> > > > > > > >
> > > > > > > > Since then, the Makefiles have devolved in some cases, resu=
lting in
> > > > > > > > lots of target-specific build rules. Also Linux has moved t=
o using
> > > > > > > > subdirectories for each vendor.
> > > > > > > >
> > > > > > > > Recent work aims to allow U-Boot to directly use devicetree=
 files from
> > > > > > > > Linux. This would be easier if the directory structure were=
 the same.
> > > > > > > > Another recent discussion involved dropping the build rules=
 altogether.
> > > > > > > >
> > > > > > > > This series makes a start at cleaning up some of the build =
rules, to
> > > > > > > > reduce the amount of code and make it easier to add new boa=
rds for the
> > > > > > > > same SoC.
> > > > > > > >
> > > > > > > > One issue is that the ARCH_xxx Kconfig options between U-Bo=
ot and Linux
> > > > > > > > are not always the same. Given the large number of SoCs and=
 boards
> > > > > > > > supported by U-Boot, it would be useful to align these wher=
e possible.
> > > > > > >
> > > > > > > I don't know why we should start with this now, and further n=
ot being on
> > > > > > > top of Sumit's series to remove our duplicate dts files. And =
that's
> > > > > > > where we can have the conversation about for which cases it e=
ven makes
> > > > > > > sense to build all of the dts files for a given SoC.
> > > > > >
> > > > > > This is a completely different series - there are no conflicts =
with
> > > > > > Sumit's series so it can be applied before or after it.
> > > > > >
> > > > > > My goal here is to clean up our build rules, rather than just t=
hrowing
> > > > > > them all away, for reasons we have discussed previously. I file=
d [1]
> > > > > > to track that.
> > > > >
> > > > > Yes, I'm saying we shouldn't be doing anything this series does u=
ntil
> > > > > after Sumit's series has landed. Along with the fact that I don't=
 like
> > > > > what's going on in this series.
> > > >
> > > > This seems to again be the disagreement over whether a single DT
> > > > should be build for each board, or all the DTs for an SoC?
> > >
> > > It's about the disagreement on what we should be building, and what t=
hat
> > > infrastructure looks like. I do not like adding extra rules for
> > > "clarity" because they don't make things clearer, they lead to the
> > > unclear mess we have today getting worse. Most instructions are _not_
> > > "now take this dtb and this binary and .." but just "take this binary=
",
> > > because we already have the rules and logic to ensure we build the
> > > required dtbs. I also don't like the parts of this series that amount
> > > to deck shuffling when we should just be taking the chairs away. Ther=
e's
> > > just not nor will there be a case for omap3/4/5 platforms of "change =
the
> > > dtb", so building more is pointless. For other SoCs, there may be som=
e
> > > cases of "this could have been just a DT change", like
> > > rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig could share a boar=
d
> > > dir, but the configs are different and the dts are different, so I do=
n't
> > > know that you could really just swap the dtbs.
> >
> > It is true that we have a different defconfig for each board, but IMO
> > that is not good. It is an artifact of the way the build system works.
> > IMO Kconfig should be used to define sensible defaults so that the
> > defconfigs are nearly empty. Perhaps config fragments can be part of
> > the mix, if we can agree on [1].
> >
> > But if we let this genie out of the bottle, it will be impossible to
> > put back in. The devicetree should control the hardware in U-Boot and
> > it should be possible to use the same U-Boot proper on all boards
> > which use the same SoC.
>
> We've never been past the point where a few examples of closely related
> boards can re-use the same U-Boot build and just change the device tree.
>
> It's going to be very SoC specific if we can ever do things like that,
> and it will also likely in turn become a question of where did the
> tricky bits that U-Boot used to do get shoved instead. You're not going
> to combine board/beagle/beagle/beagle.c and board/ti/omap3evm/evm.c (and
> ignoring all of the other omap3 boards) and get one binary that works on
> both, and just uses DT. Let alone that no one wants to do that work.
>
> You've mentioned Rockchip before as maybe a better example, but
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D383579&state=3D=
* was
> leading me to think that no, there's too much "this is what THIS
> hardware does" that means that no, there's going to be hardware
> variation that one must just handle in C. Or get more and new bindings
> accepted upstream to try and make that be data driven, and also possibly
> have to deal with "that's policy, not hardware" type arguments and so
> forth.

Related I've seen issues with nearly identical rockchips devices that
use different memory chips that as a result need different U-Boot
builds because the early boot part needs to initialise a completely
different set of memory and the two different sets of rules aren't
detectable at run-time nor are they even small enough to fit into
smem.

> > [1] https://patchwork.ozlabs.org/user/todo/uboot/?series=3D380278
>
> Note that patchwork is annoying here and that for a series you've
> assigned, you need to click on a patch in it, then the series link again
> to get:
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D380278
> which works for everyone. And append '&state=3D*' so that archive links
> will still show it later once it's been accepted or superseded or what
> have you.
>
> --
> Tom
