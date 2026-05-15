Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFD6CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7AE84865;
	Fri, 15 May 2026 20:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PdSCHSVd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29AB384815; Fri, 15 May 2026 20:35:12 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC31846CF
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd4f7f05e90so14734166b.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778870109; cv=none;
 d=google.com; s=arc-20240605;
 b=h0ct/noNdNzuvWaxech+uhzDNi2FTe3+ZI5ZWeJXu27wNjpNrXBXIX7JU/kOlemxDI
 kkCMmejJuO6usLuSdyZIBXSbkKKJXnYJuCD9QdRwpPYNhL8yyGhG4VwJ9kmGZIj4McrX
 fRK8njg5iaDIhVZPI5mNwjPV+2kvvjw/bUwgfU64B0NT18lQrAKJrV89ceal5phigLGs
 VqiGpCT/gZ6QuYiUVeAluk/QtIxCtAL6gXjrR2gHn5TAQ1hFBmvZKWarZnRYfBABOpMO
 0LyTA0IzIfm8Yu40MyU5WW+t7o+UnMCHB9HmNNlE8N64VFgdcnRThNJ/HQhsCmJcHeRw
 unWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J8SZXyZvjhzXoLbdbAEQecGzYZpFaUvkNChpaqb6Fl4=;
 fh=bnupiERZn2PI+MmEvXIHvRvb/x9C+g9PVm9rW1kLi8I=;
 b=KtorLrabOZ26Y6JIpjgtBg490qv/bbnDKQGbtbTP1dMHfadfUn/v7GM8sgC988w8kl
 aVoeixL1kiDC+ascqvjxdixMbENyHfJ+MHclz017skKuFWqNfvFEkq7PcfZnoMogcguf
 LOZz6vXIQffvkzmqq98/XdN5e0DmjncYmIys4I9GgU1DVA5cnRXAIrfpuTaQIywp7c4/
 bZGqqpXoeKLwMnpmooBIMGNsHwF5w4rkKRG1aUAiaN2kytK0Mfp7wzc2Fd2ht3y++Qtd
 OjQa6Yekbcws+KDgtp5QbrfS1/UJT5jdTarvSoETVLHGvVIFBA3v50XQDCxUJPRIOdan
 VIIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778870109; x=1779474909; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J8SZXyZvjhzXoLbdbAEQecGzYZpFaUvkNChpaqb6Fl4=;
 b=PdSCHSVdWOYqTkcGCmGUwmYGiQ0DLxcLBgtDG6sAh+073ZcIlZZ6qGZ8RLw8/aCSe8
 r28uyoqXqu+as/WYul9fKBOJuf2l9OEUVppDt9M5MLD1H9rZZ1B4miVuXkNmM1DsgY7p
 R1tDhswJ0eCPG2arKfzVcPKciUdI3L/ogBc98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778870109; x=1779474909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8SZXyZvjhzXoLbdbAEQecGzYZpFaUvkNChpaqb6Fl4=;
 b=PfWCaz/1OVETNqzxaAwpSmPPKeAtAqqdGV4W/UIKFbEyJ1/Row1ojbmiUEaXtaJDv5
 wCxxqWB4R2C2+ThiXpmdojuMv58tlkvEateNkQ//N4RE0+hDgMzCBcqM07wZWW/a7XdN
 jenhQ8oEUDOqd33hl02O29xHQG5z5tpjCSmZ8e4BuCD1BA3ChCyqqw/jS9hbbLR1zLNp
 V/wadXEHTUZ15N7/UWL+v0o+Wy+z3MKQVd1tvV2bxKHL4tPzQjLA/qN/S/2W4gyB+VVI
 SyDfInyyUC+tGYvYxe+/1XgCzKonknn/FJnR/RXGYPG17F/LWM7YK4pGkiBjZ+iUPghO
 sxzw==
X-Gm-Message-State: AOJu0YxWQe+Ty48b5jyXPsle6ejJ0U3oqC54/GJujTajFYzIfPFKXPl3
 pMwVnPEoS+GB4noBJJMQ6qeQmSTDAJ3ZOZZHBE7V24JNjpcLmrd3TDG9Wvv2VpsPUPzPzYpSyKn
 ljLtRE471LJ397T2/4yM7PaTKaooTpYvWPThJQ2lv
X-Gm-Gg: Acq92OGv04EB3IhqkkX6HZIIbK3L3nLvbXUzQYF86VVxaHeoRVGwwFrfaAbUmzwwI3Y
 0HipRD9d1YgaLYBzotk0EaOKDaTxDl15aOMfG5t9Q5/32nTI238r6mFsaZY5q9fa32Ko4nCoJtk
 uFBVU+v1vlXQvWtocrpiCBV0ecQzRM0/w0poWnRVnl9NDQqVpko3v5KUJ1km5MICcoKhELmurXn
 EOOF4jFeYDg16/gBYgrvcLj6V8GelPI57xmOpuAXkTAejQwBDaV72y5L3kXtBHArQqQmeqrP7rJ
 7kLpQg==
X-Received: by 2002:a17:907:c8c5:b0:bd1:1391:c326 with SMTP id
 a640c23a62f3a-bd517813aecmr316160966b.15.1778870109239; Fri, 15 May 2026
 11:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260511220555.GM1858239@bill-the-cat>
 <CAFLszThULFjq_R4A1nWYjQcQ4Odw3aZ200RPmQ56Ecf3gO4UYA@mail.gmail.com>
 <20260515141043.GY1858239@bill-the-cat>
 <CAFLszTg8HQK-tkCnGkH_Reju6frdNzPZNF6d+ekwKtWvWTrLmA@mail.gmail.com>
 <20260515155535.GD1858239@bill-the-cat>
In-Reply-To: <20260515155535.GD1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:34:55 -0600
X-Gm-Features: AVHnY4KhlJnZlPuVYsiYdwOin9llGpgSW0nX5oIFBKmuHFakSGM-bs7WatbsDz8
Message-ID: <CAFLszTiKLMkvbL86QXbOC6cKXUt2gLYo5c3w2coFFcFk5mBR-w@mail.gmail.com>
Subject: Re: [ANN] U-Boot v2026.07-rc2 released
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de, 
 u-boot-board-maintainers@lists.denx.de
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

Hi Tom,

On Fri, 15 May 2026 at 09:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 15, 2026 at 09:05:37AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 15 May 2026 at 08:10, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 15, 2026 at 06:49:25AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 11 May 2026 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > Hey all,
> > > > >
> > > > > So it's release day and I have tagged and pushed things out.
> > > > >
> > > > > As I mentioned earlier today[1], I would like to again thank DENX (and
> > > > > the Denk family) for supporting the project for so long, and we're
> > > > > starting the process of moving our infrastructure to the OSU OSL lab and
> > > > > the u-boot-project.org domain.
> > > > >
> > > > > The delta between -rc1 and -rc2 looks OK to me, and I do still think
> > > > > there's a few outstanding PRs to come in and a few things I should pick
> > > > > up as well. But, the next branch is now open and so bigger changes
> > > > > should target that and I will be applying a few things there shortly.
> > > > >
> > > > > To repeat what I said in rc2 (and will keep repeatint) is that it might
> > > > > really be time to retire support for running our tools on Windows under
> > > > > MSYS, rather than something like WSL. The move to support more modern
> > > > > OpenSSL versions has hit a lack of support problem in MSYS[2].
> > > >
> > > > I'm not really the right person to answer this, since I'm not a
> > > > Windows user. But as I understand it, this would mean not building
> > > > Windows executables anymore. Is that right?
> > > >
> > > > Should we perhaps just build without the pkcs11-provider feature?
> > >
> > > In the age of WSL, I'm not sure the value of supporting MSYS. If someone
> > > is using this, and steps up to resolve the problem, great. Otherwise we
> > > should end up dropping it. Unlike the macOS side, we haven't had a
> > > report of a user in well over a decade I think at this point.
> >
> > We were certainly using this when UPL was being worked on- 2023 I
> > think. The Tianocore people use Windows and needed mkimage.
> >
> > I took a bit of a look at what is involved here. Basically with WSL
> > you should be able to run 'wsl.exe mkimage ...' and things should
> > work. I haven't actually tried it though.
> >
> > It would not be too hard to add the package to MSYS, but that just
> > makes it build...it would not actually be useful without hooking into
> > Windows APIs about which I have no knowledge.
> >
> > So I agree it is best to retire it, perhaps document WSL as the means
> > to run mkimage - will we be able to have some CI tests for it?
>
> WSL is just Linux userspace, I don't think there's a need to for us to
> add a test on top there.

Ah yes.

Regards,
Simon
