Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8B1C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 06:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A06E876FF;
	Wed,  3 Jan 2024 07:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yFERWkgc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E750876C8; Wed,  3 Jan 2024 07:57:42 +0100 (CET)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC6987705
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 07:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-466faf5846eso1210166137.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 22:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704265056; x=1704869856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wgJFm4Um3PEf73Z4AZDUS14+UdEI1LHfnLwZFGcRY84=;
 b=yFERWkgcfSQ3OeCBt49WOltBbPQzdn323Zk4TNTTJgsd89FGLMV5aPJRWyBzTPVc56
 pk63cFVX0DpqJll1InFm2ylDYafUy+1juB1lmbT65zfnkZbBmh+ssclYy1VZQp014ktu
 NFXJp2CE4C+DbzdslklrG9z0izKc68kBtrR8sNI0IfL+XvoaQVQXKQVKcHFsCuBeHg10
 28/7/XsfgFXlYYECqsr0IvWESedNOQw/1k227WwFRRrNd4iwPx2nx0U6oa+12wviR0+6
 rdXXleYdVBC+sy+tXCxVeXKM3Tlp31ZXZ7CZGR1LGOs2VmIJyuV2elNFXSFYA9rvUmq5
 +bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704265056; x=1704869856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgJFm4Um3PEf73Z4AZDUS14+UdEI1LHfnLwZFGcRY84=;
 b=DwJXQGLIeOztoj/VA2dNezukdUSC0VPaWyvjR54ZE2RJbrLuK/whJrqEUAFn74iw/F
 yAObmo2LsFijew4bhZoz5UiJsTfNiPf0xsOOe7xECUiuV/JJSnTGQVu3EVD3cO0PzhhW
 KF6Hfrlgztbgn73lZHKZBvBvd2iDcnQDD/1npqyjv6mb9MtsBl9mFy/DCJ6W8VEJ2nXl
 V55HgCeULNJpfomSqOYgANo7ZVdbPAA3XAEIwGaIktteJLrSPHfIOiTQCV9qyV8Sid8E
 w4p6ZRLw1bEZNCFsKWga9t1d+gFRF1E8vgqhLuXQnfdb4FivcncbYklz9Las1hC5YTj6
 gYAg==
X-Gm-Message-State: AOJu0YzE5ymqmVdENb07rhfDTGrRrLP3xlm8E3DoWyIovGxSVvrhptrQ
 uNOu3stWR+A5/l8r4uoDgrqok52o50tHwGhMxj8dZp5Z8ZPM+g==
X-Google-Smtp-Source: AGHT+IFAXcyRZL8XSxIcbu4nGOcqPdCs7pG3KUN99aX65ATCtCGdMio9//f0JP3e8lV+wTLouXdzLLqfMYD6AD0+g74=
X-Received: by 2002:a05:6102:55a3:b0:464:89f2:801e with SMTP id
 dc35-20020a05610255a300b0046489f2801emr10508375vsb.29.1704265055877; Tue, 02
 Jan 2024 22:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20231228155428.GI2652760@bill-the-cat>
 <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat>
 <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat>
 <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
 <CAFA6WYP5Ko+VJ1MLN3W2Y9-B2osiL40PcMpqwiN0=F-k=FowjA@mail.gmail.com>
 <20240102180643.GA1610741@bill-the-cat>
In-Reply-To: <20240102180643.GA1610741@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 3 Jan 2024 12:27:24 +0530
Message-ID: <CAFA6WYPfey+Si29eGAyaUaiacCBwGBR+f3+o8hjFRSU_j504Wg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB
 builds
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
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

On Tue, 2 Jan 2024 at 23:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jan 02, 2024 at 09:07:48PM +0530, Sumit Garg wrote:
> > On Tue, 2 Jan 2024 at 19:36, Simon Glass <sjg@chromium.org> wrote:
> [snip]
> > > 2. Choose a directory target for devicetree-rebasing. I see that
> > > 'barebox' uses 'dts' which seems better to me than
> > > 'devicetree-rebasing/src/'.
> >
> > Actually as part of this patch-set we try to reuse the U-Boot 'dts'
> > directory (via dts/arch/arm64/<vendor> soft links) since it was
> > already taken for U-Boot specific DT Makefile. However, I am open to
> > renaming 'devicetree-rebasing' but to me that sounds more clear that
> > we maintain a specific subtree within U-Boot.
>
> Looking at what little is in dts/ here today could we just use subtree
> and pop the contents under there, and basically ignore the
> project-provided Makefile? Or is that not really worth it?
>

If we really want to avoid soft links then I did try to add the subree
with the prefix as dts/upstream here [1]. It works well with the
downside that we will pollute the subtree source code with U-Boot
specific Makefiles [2]. However, the subtree pull works fine still. If
this sounds better to you and Simon then let me know I will use this
approach for v4.

[1] https://github.com/b49020/u-boot/commits/use_dts_dir/
[2] https://github.com/b49020/u-boot/commit/90eabe614e77bc30a437e7d5559c1ac414ac07b3

-Sumit

> --
> Tom
