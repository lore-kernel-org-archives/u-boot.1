Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF297F94CB4
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD60839D5;
	Wed, 22 Apr 2026 00:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X7C91BId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFB9683AC5; Wed, 22 Apr 2026 00:39:13 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C2583936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-baa8c78ac7fso92363966b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811150; cv=none;
 d=google.com; s=arc-20240605;
 b=XWYoNfelZyFmTXUCHppmmepMyO5OBFsHTbFGVUBiXQ6xoNrSN58uP8aLmm/tn4Ordn
 pA2wC3Z6d8FCVj44FILsMtXOXPJgKfmy3fVo820OMVw50kinoL4xKbH3BxVZ9IWVGT9D
 usIIy/Obn0r6xxTmnfLaYCbfmD8668IhE4oVzXPx+iqwIaLxNvLEO+7Tqwy7EN8H4014
 ME0yPYipt/RfqQbz8hLio7eoKw8RguHBDD+9jkTfOqsCGFJYpGwAZilGxciWprnMCQmI
 UOEc4Qn3MhM4get+rFXlLNFSawRiA9fE5EjR/F5YiVjRPT+OYh2GilPh7uWMh0wn9kf0
 Y/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zLOUGE2QRKI+OG/IeM8L0UEgxuhCTDgzWs2ugAq3b1I=;
 fh=EThWCHGHt343PXesa/4+4ZO1y/ssTtINZWn/LindcxU=;
 b=MGs4w6qpoFon+N44gQy+gF1KO1Avp8b0c7f/yqTXf6/6FoqenoE3IaiDgqNjo2GtRH
 7185OJt0VtQxWoHNC1VJL4CJW8lN19DjtZw8Aljs74GknDXiUwOZABHeYHUCr24RYnfL
 mbX0sJUtnxl85rOTGIr+Rxy99sZgUI24ZqQxsVAdJrWGJiL88egGXIeV3Hw5IHbXPDIf
 7xEIXACP70zoD/pfn2aKovz3TnSP+143XshAEmjZavJS8tGirFmO8JV30/2HmCBX0WPZ
 mdRMklddL7nHgPMwxQZQc8PTDt57kJ0g9RplY9fWj4KJu4VBExTtziAUNvd4kECH+iC3
 Ljtw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811150; x=1777415950; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLOUGE2QRKI+OG/IeM8L0UEgxuhCTDgzWs2ugAq3b1I=;
 b=X7C91BIdH5kHuS4BXvB97m9LyxvKUoy28ymk//JkliN1JzwJLEquTkUhxhFmVvio0k
 aFoDt2io8f8fMbIN5hJDk8XDiECpyxvSS542ODLKyQp7ZHJr6enL17FX4yw40LTENMYS
 CrfhwMnQj5jA85gfYr3ghqz+6L3c7+8vQx/G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811150; x=1777415950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zLOUGE2QRKI+OG/IeM8L0UEgxuhCTDgzWs2ugAq3b1I=;
 b=pVF2rEa3JEpKt3lLgTo9vEFvc00qqleX5KmTbPS8E7qIknEYf8QRARVt+gShRNZ/+O
 /qiMn7c4l2YE/Oc4GDLwo8TwL80XVYD62pekzi4e5kvrjuh42meII6dwtdcuB5+RzMPE
 QwmH8mF1NJFQ/zR8V2/wrD1nA9mpDxEI92Q4hK+TCQkDv4bRuFKUjHzy30VfJ71ccy/H
 ASvwTs40CK/606/9fOK+nXWIZovGV8RgTw7dpqjCafEYzWYddd4sx9qyytA98kntZAHB
 U5pOQ/hDnN9NJVnjjAub5z4vmkH0z4YzdatbYXoVv5cl324Sunm1a8QdsNDewNIzG1cI
 3prg==
X-Gm-Message-State: AOJu0Yys2rzOOHB1Y/wmVHKKJh9ZSe2BQFcnYsJFJcxsh1cDg0fwnMOr
 X4usIvgLcYdDrLCueowGF8O9sIvqACDJ7Tz9g2n3a3TxLsUHyBKw4NL0nZN98z8EFI95mt5kEdY
 vk6BzZyouzir87mrELawNfhcvnOAud28wQFZLVPvNF9s46BQ3MLSOSmm+
X-Gm-Gg: AeBDies3/FR6O1pPQ6lKYvYr/B2qVnlvsOP0eDYCBdk2mVQ29UZLxn9TmzCmbRmJ340
 acasSVJ98s+PsVkw3gs1so873P2MDm46qIbz5xJRQcYaiz8yio5/Mnp5Yz+RsafkgfuxA+m0FlE
 xVGC8tKWkfmj7Pdez4rkUQ3fmBOus5j00WRzZuevsLWvTZMovDMCeFtwZH1+x56euFEICYf+Rz2
 QBIZ3lGS3iKiNtVCJ8PJALnTl/jp8nQO1G+cX7U5iP9dvAWGgB5120rP1x8BrdnHIpNIhfRV2iD
 EIXgft2K6Nyj/oNocnxg
X-Received: by 2002:a17:907:72c6:b0:ba6:1412:9339 with SMTP id
 a640c23a62f3a-ba6141295bfmr667704166b.20.1776811150566; Tue, 21 Apr 2026
 15:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260420074601.24988-1-briansune@gmail.com>
 <CAFLszThRNhVTMRpVPySFSComEhL_s0a1wY1BVnKKtV+K6OXnEQ@mail.gmail.com>
 <CAN7C2SCpBYi=c1kS7-aXL9Qf7wUq_ipcvQMSUSW9aYrQqUcAAg@mail.gmail.com>
In-Reply-To: <CAN7C2SCpBYi=c1kS7-aXL9Qf7wUq_ipcvQMSUSW9aYrQqUcAAg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:38:59 +1200
X-Gm-Features: AQROBzCMduKTvQ_WO7N69qiDMPyxkayubhPaUeSLBbfMWz_3YPnL4rXcRxrEqLA
Message-ID: <CAFLszTiiv-os+sK+g+E7zUHqZVj79Pf9bUx6G2LczmgwUXXozQ@mail.gmail.com>
Subject: Re: [PATCH v3] Improve handosff prepare on SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Brian,

On Tue, 21 Apr 2026 at 11:12, Sune Brian <briansune@gmail.com> wrote:
>
> On Tue, Apr 21, 2026 at 3:32=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Brian,
> >
> > On 2026-04-20T07:46:01, Brian Sune <briansune@gmail.com> wrote:
> > > Improve handosff prepare on SoCFPGA
> > >
> > > There are some cases that the Python scripts
> > > are run and the qts files are not replaced.
> > > Make sure qts folder h files are removed before
> > > handoff script runs.
> > >
> > > Signed-off-by: Brian Sune <briansune@gmail.com>
> > >
> > > arch/arm/mach-socfpga/config.mk | 29 ++++++++++++++++++++++++++---
> > >  1 file changed, 26 insertions(+), 3 deletions(-)
> >
> > Typo in commit message: "handosff" should be "handoff".
> >
> > > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/=
config.mk
> > > @@ -8,6 +8,8 @@ else ifeq ($(CONFIG_ARCH_SOCFPGA_ARRIA5),y)
> > > +HANDOFF_KEEP ?=3D 0
> >
> > > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/=
config.mk
> > > @@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
> > > +             if [ -n "$$HANDOFF_KEEP" ]; then \
> >
> > HANDOFF_KEEP defaults to "0", so -n "0" is always true. I suspect you w=
ant:
> >
> >     if [ "$$HANDOFF_KEEP" !=3D "0" ]; then \
>
> Hi Simon,
>
> I think this is a misunderstanding.
> My original idea is to use the HANDOFF_KEEP=3D(whatever is mistyped)
> to run the keep branch.
>
> While the absence of HANDOFF_KEEP(anything) will not keep.
> But simply HANDOFF_KEEP will not work and need HANDOFF_KEEP=3Dxxx.

I'd suggest either dropping the assignment to '0', since someone
reading the Makefile will reasonably expect the shell to see it as
'off'.

In any case, how about a comment above to explain what the argument is
for and what it does?

>
> Because the command >
> "make prepare HANDOFF_KEEP=3Dxxx" is very distinctly long
> HANDOFF_KEEP=3Dxxx so it must keep my thingy.
> Even if I mistyped =3D0 etc.
>
> And during the absence of HANDOFF_KEEP=3Dxxxx
> "make prepare " immediately, see ok clean so it will not keep good.
>
> That's my original thought.
> I think I should changed to:
> if [ -n "$${HANDOFF_KEEP+x}" ]; then \
>
>
> Need your comments on this.
>
> Thanks,
> Brian
>
> >
> > Otherwise the 'preserve' path is always taken and the 'clean' path is d=
ead code.
> >
> > You could also have an empty variable meaning don't keep.
> >
> > > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/=
config.mk
> > > @@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
> > > +             trap 'rm -rf "$$TEMP_DIR"' EXIT;
> >
> > The trap is set after TEMP_DIR has already been used. If the python
> > script or mv fails partway through, the temporary directory won't be
> > cleaned up. You could move the trap to immediately after mktemp

OK I had that wrong. If someone presses Ctrl-C while Python is running
it would not clean up, but that's a minor issue...

Please note that you should add a change log for version 2, 3, etc. -
see here for details:

https://docs.u-boot.org/en/latest/develop/sending_patches.html

Regards,
Simon
