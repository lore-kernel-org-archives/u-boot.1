Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD01EC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C38280FDD;
	Wed,  5 Mar 2025 15:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AZ1pFVd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C87380FE2; Wed,  5 Mar 2025 15:35:34 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6C880E94
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390eebcc371so3200847f8f.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741185331; x=1741790131; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJ/F/ZRS5T6OtwjmwodUiSQkkxmDguPDW0Rd41nAhMo=;
 b=AZ1pFVd8D9huhXE8ECNvQ7cRrnvmdKgbyY6UV9Yu9ZVEXL2FohAjr5AS8al06FFJR4
 069dEGMaYsbJOfY5VGLborPvHHYAHlDPncUqY96RZYAg3B05KJPdeVxm/PzqWiieOntm
 U79JnO+ZQPx7OOWjUs+pdBKlYyrVTisQRuywP3FiUCYXLkN9TGKXXCcU4jCZf5uHW2QD
 R3zbQowvgf8CVoKOIVVlf+Txxh8T57Fz3KckqQXu/9mms03ji6UyEZ44B9/mzxBEjSri
 mAcIJ1fx8bqwpUg71PCFUCNWmCkoMPhbvPfYuRbECe9H8Dvh6i/A/CJ3PTWddYrjreJv
 /TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741185331; x=1741790131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJ/F/ZRS5T6OtwjmwodUiSQkkxmDguPDW0Rd41nAhMo=;
 b=etbdX7uJACm7U3AmoY/DxYqIsaO8pYBcFlxdVmNk89AKYEEdHg77omt3pt3+G0PdNE
 mL+fJKN0vbLj2L8qoW8+/nbncp+xnu3vQFbxYOmqxhN0VSxIutLXi9CryJTwyzkB+WMb
 0p4u8PJxW7vDCVGg7SdR6Lmx2pCPBse64CT691Di6P2v7M6rhIFaj2Wjal7K2wiUjWEe
 iNG2JF10sOlMmmO4oURxS8hvq8NwkZBURotjy7d/fnr3ciNSA5KNPdaEO84utytUVudF
 XfZWOANJtUyVkKncwYmt0HLnrUM8Q+DDlvZssBzeF3REJHfHVjVA+AJ6rnlwzlv6QgIX
 59qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk/CaorhVguPsU5BOtabNsF9Eg9jwYBgx/0Pd1bzmo4mE/OXSjCG5WB7anewEXk88jx0sbupw=@lists.denx.de
X-Gm-Message-State: AOJu0YwYz/N9wIrMqDGmC8xaFqs+M0C6eYTU9bE43KNqLKfJjlddOEel
 NiDoVuH3oRLyQMJm2SnN7KCNOgU6JmH7rJBeItNuuxHSYlKGpRTwFzH1vJMilSAk9rLxFinqkfy
 8Tm4BJ6fNSzB88UvjkHK/TLoZQFo=
X-Gm-Gg: ASbGncvEa0tMsnbkFS2CEiTXOJIT77n0i7QLM8gxWrciHek56tvrcUwSBIZ1lKmMLmA
 UiHo3dhDV2nksKsn439oodMXgOB+7CYjLHoI+3KYF1b9QD+Ho6qAkyeJ2ykZykyBqUZM1ZbmjMH
 wBd+Ayfsd3cbnEFMcqEdEEilneLaw=
X-Google-Smtp-Source: AGHT+IGWwWp/cVUWILa4bwQpPo09Apr9qqln2HF/2O2Kbnmo8WMYCAIftrG5dzE0I3ZEeZ+Ewxd2tPpLIb/9pxTq/PY=
X-Received: by 2002:a05:6000:2b12:b0:390:f460:77b0 with SMTP id
 ffacd0b85a97d-3911f757315mr1828386f8f.26.1741185331402; Wed, 05 Mar 2025
 06:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20250305111213.163428-1-clamor95@gmail.com>
 <20250305111213.163428-2-clamor95@gmail.com>
 <kfyuo4l2w4menkfrb2sbvvp2ptumyed7bvz64vrnpm7lx6dpqe@hxo2633n2poq>
 <CAPVz0n1H5rktuYJ=HGMiXtOqyOFLSEJeyUJvcEdGcr1T_PfCrA@mail.gmail.com>
 <tcwixvrk57o5rtrfycjj6u6r3e3lrbyfjbinddy7i3vqryy32u@m7emuzsuikdn>
In-Reply-To: <tcwixvrk57o5rtrfycjj6u6r3e3lrbyfjbinddy7i3vqryy32u@m7emuzsuikdn>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 5 Mar 2025 16:35:19 +0200
X-Gm-Features: AQ5f1JoxwoVjbbZkQ8IKIK9_gmOxTXPK9JYSZ3CnoD6v3giRmmZT6YJjSLoUqpE
Message-ID: <CAPVz0n0XBm-vDazOPX-i=2Dr_CJCU0EKziRR+gPeP-vWAh=sSA@mail.gmail.com>
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

=D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 16:02 Thier=
ry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Mar 05, 2025 at 03:52:36PM +0200, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:47 T=
hierry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Mar 05, 2025 at 01:12:12PM +0200, Svyatoslav Ryhel wrote:
> > > > From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> > > >
> > > > While PLLD/D2 is the nominal parent clock, all derived clocks are g=
enerated
> > > > from its single output, plld_out0, which is PLLD/D2 divided by two.=
 Direct
> > > > use of PLLD/D2 is absent in peripheral clock configurations. Theref=
ore,
> > > > clock derivation formulas must take in account this division.
> > > >
> > > > Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  arch/arm/mach-tegra/clock.c | 30 +++++++++++++++++++++++++++++-
> > > >  1 file changed, 29 insertions(+), 1 deletion(-)
> > >
> > > In Linux we ended up exposing the _out0 branches of the display clock=
s.
> > > Wouldn't that be a better way to describe this?
> > >
> > > Thierry
> >
> > You are not satisfied with the description or with solution?
>
> I meant the solution. However I might have misunderstood what you're
> doing here. This is actually computing the rate of the _out0 branches,
> which are the ones listed in the DTS files as parents, correct?
>

Basically this is u-boot equivalent of Linux approach, well its final
stage. This patch does 2 things. First, it updates pll_rate[id] value
if rate is changed which was not done since usually PLL do not need
updates till we hit display clocks. Second, it fixes display clock
children divider calculation taking in account that raw plld/d2 freq
is halved. And all this does not break existing drivers which use plld
in any way (I have checked that on all generations till t124
including).

Introducing plld_out0 instead of plld Tegra wide will basically add
more confusion and possibly hidden regressions since all drivers using
plld as parent take in account this quirk.

> Thierry
