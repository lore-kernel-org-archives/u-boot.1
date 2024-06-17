Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B24EC27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D48C87CF8;
	Mon, 17 Jun 2024 10:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="keH5g/cC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9563787E52; Mon, 17 Jun 2024 10:22:05 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2730878ED
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-48c3402e658so1476718137.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718612521; x=1719217321; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJyXm4phaXru/XM/zKML8kJ4GXiDF857ZyGMJicT/W0=;
 b=keH5g/cCvWyYLdLQWkAOo3ISG5+TSYhCGCtbcG0Gj6IJZOX4fgC5DMuvIs8/MPwSSp
 NuX4nzaLNDpKkwzllKVSCvdQAvpbN97ce+RX8s0ptVxSmodG4XqhtHIdn3QllmXHOn9w
 4T3xWMHsLvITuPGsuxRg+sA0/Nspt/fRz6GTqluyIxUCuNVBUG8ULWB/ry5rkliD2PME
 TJrrklNPFjr8rapJLYVQ3Tqwly9ej7q77yKKyh3k2hLEWpOf8CvDn+rD0pp3F4McnHZS
 6R+ep+ip4MGAvhgacpYIWMgo7wQ07KEcfbiXd5Y18iqu710t8IL5gvF6lD34OuTiE0Vu
 09lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718612521; x=1719217321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJyXm4phaXru/XM/zKML8kJ4GXiDF857ZyGMJicT/W0=;
 b=FhTSX0hksrsxOlVCTnSCBZBUiLbj7Q4Nau2KFQcTnyILexWEPV2vu8Sz/SR6KxWQJa
 qnz0PcY1XijmUJCKfNqHuFPB7RS2dKaHNYLcfEgglR84PCzOeGRaK6wT6k1ZuGmjcXJR
 6zAOLU5vXcIiUY3lqkxvprq5zO8RVDAimgRTsfSsg6a/PQ8jB3tkhNQacT9RtZZzkuul
 qMCN2HfrEXj9XuGjAVKVWaSTi6El3RdppnGpVx5Sv6w+xq+MyqF5XJz1j2Qz7h2a/A+1
 6SBa7BPaHrKl1s+1KEWhI+5pUyiFCxdEab1GdOi5A6UJxyRSzgtcDXvcmXQ7vrYUiRQE
 fJVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaDZh4+nXIyKExVnPuzuHLKvjvgtWQoJsa4twlmm8eERhc6QR2DmSG5804ljeDtIAVlNsWI2qNyOh0bk7bSFWNxKRtvA==
X-Gm-Message-State: AOJu0YzSERjCPRkBfxzkhZff5QKO0yDcAzY0UuvATLSP8qBppMjkctyF
 GCXbhLuIGopb5u8D+9NLtOxMfmZ6oOIG9NHLfYn9QABFcNSEsCfwDIgYrkkIY8zKapWE314gJE1
 MNMsNH+lnf0wipM27FG+AiUrJluQJox5yKPtAaA==
X-Google-Smtp-Source: AGHT+IFFRpzpjkvMm23DDsChRS51TCxKVSVwD7TyuwMmPQBG98oCJu88/EkzW9UEPi/fLdmm63pA/nRgHwYQMbdRMFg=
X-Received: by 2002:a67:f94d:0:b0:48d:c47d:6478 with SMTP id
 ada2fe7eead31-48dc47d74e5mr5243084137.2.1718612521379; Mon, 17 Jun 2024
 01:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
 <CAFA6WYPB17=YNabDyGTqo3p=uYD=Vy+Ec2P2VepXT6P+75f+VQ@mail.gmail.com>
 <CAOf5uwneUKJXJqgBMOQHs+d8-GQ6nr+vBAZ4ek2au1kngs8mXA@mail.gmail.com>
In-Reply-To: <CAOf5uwneUKJXJqgBMOQHs+d8-GQ6nr+vBAZ4ek2au1kngs8mXA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 17 Jun 2024 13:51:49 +0530
Message-ID: <CAFA6WYNt0-KBpYjo0eQM20s-eD4gRvkgT7WxoxvHgd6URTXGrg@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 u-boot@lists.denx.de, 
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, 
 marek.vasut+renesas@mailbox.org, afd@ti.com, bb@ti.com, 
 mr.bossman075@gmail.com, leon@georgemail.eu
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

Hi Michael,

Sorry for the delayed response as I had some health issues last week.

On Thu, 13 Jun 2024 at 12:44, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Sumit
>
> On Thu, Jun 13, 2024 at 9:02=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Mon, 3 Jun 2024 at 20:38, Patrick Barsanti
> > <patrick.barsanti@amarulasolutions.com> wrote:
> > >
> > > Always prioritizing u-boot includes causes problems when trying to mi=
grate
> > > boards to OF_UPSTREAM that have different local devicetree files with
> > > respect to the upstream ones, if local DT headers are not dropped.
> > > At the same time if local and upstream files are the same, migrations
> > > can be, and have been, introduced without dropping local DT headers.
> > > This also causes problems whenever upstream DTS and DT headers are pa=
tched.
> > >
> > > For example, now migrating a board based on `imx6ul.dtsi` to OF_UPSTR=
EAM
> > > breaks it, as there are some missing defines in a local DT header fil=
e
> > > (`imx6ul-clock.h`); the solution would be to drop it, which has not a=
lways
> > > been done in previous OF_UPSTREAM migration patches for other boards
> > > because most of the time the two are the same. This solution is also
> > > vulnerable to ABI breakage, although this has not yet happened since =
the
> > > introduction of OF_UPSTREAM support and is unlikely.
> > >
> > > Maintainers assure backwards compatibility for DT headers when syncin=
g the
> > > upstream folder with the kernel.
> > > The problem is that, at the current state, all boards that have not d=
ropped
> > > their local headers when migrating to OF_UPSTREAM will break once the
> > > upstream devicetrees are patched, for example, to use any newly added
> > > define which is not present in the local DT header file, even if thos=
e
> > > changes are backwards compatible.
> > >
> > > This patch fixes these problems by prioritizing upstream includes whe=
n
> > > `CONFIG_OF_UPSTREAM=3Dy`, while keeping current prioritization when i=
t is
> > > not.
> > >
> > > Also in case of ABI breakage in the kernel, keeping redundant header =
files
> > > (only until strictly necessary, e.g. until all boards including them =
have
> > > been migrated to OF_UPSTREAM) together with this selective prioritiza=
tion
> > > of the include folder is a solution for keeping not-yet-migrated boar=
ds
> > > from breaking.
> >
> > Let's just not try to make assumptions about DT ABI breakage due to
> > using upstream headers for not-yet-migrated boards but rather talk
> > about some real world examples. Have you come across any DT ABI
> > breakage with usage of upstream headers? The breakage you have
> > reported is due to usage of an old local copy of DT header.
> >
>
> The include priority is broken, and this a Makefile problem anyway.
> This patch fix
> anyway includes priorities.

The include priority only becomes an issue if you want to keep
redundant local copies of DT headers. And I have been advocating to
drop local copies from U-Boot as much as possible. Once we only have
upstream DT headers being used (Qcom platforms can be a good example
here), we don't need to care about trickier priorities.

> The imx6 board migration for us does not work

Patrick did mention here [1] that dropping
include/dt-bindings/clock/imx6ul-clock.h fixes the problem...

>
> > However, if this patch is only needed to address fear of DT ABI
> > breakage (which hasn't happened in the past) then I can live with it
> > such that it can help convince more people for OF_UPSTREAM migration.
> > We can drop local DT headers as and when people feel comfortable with
> > upstream.
>
> It's not abi breakage only but path inclusion order.

...however it's the ABI breakage part that worries Patrick. So if this
patch only solves that worry then I can live with it in the hope that
people will start to gain confidence in DT ABI stability.

[1] https://lore.kernel.org/u-boot/CABxfhNfWdD0NjPNskaxZxDTg9pDoDx5vBHrN9ch=
vMh5Xo_7Kzg@mail.gmail.com/

-Sumit
