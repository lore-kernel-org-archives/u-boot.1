Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C14EC48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 12:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E3A87D64;
	Tue, 13 Feb 2024 13:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yfj+UZD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E506187D23; Tue, 13 Feb 2024 13:55:49 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3F087D72
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 13:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-46ebd5990daso344428137.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 04:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707828939; x=1708433739; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SKAqb5BB4ThicEtIXQ2hB7H/qkuXbuPPr1DUJLEmmM0=;
 b=yfj+UZD23/gEOloOLoKsVXss7souAvLJBvwip25Q4teyR/d4pidJrMtu2bcws3Jamt
 7mGMrdLAlE373N9QBwIksL7ruPVM5FTxEand+65pKeMLyn/0tAd7tQ8fWCiEdCXd71QD
 J0Lg6d7yPhjVWAFEFIh95zQ+RtN9EmrCvBoCRdz/2vLG6rJYNB7OSbInBiRdE+9COQNI
 qkBYEIygsf/71c07T7A1sqAp6cYB24dKqXpK7+1k95qEctAsHqoGWNiZEu976upBcYAW
 AKf6Hn6D9kgoOtNqCzF7LYBXYcdlyVcmWG2uE0zffJu2wynMMlKqXauHuP77qRAfx8Q4
 0azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707828939; x=1708433739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SKAqb5BB4ThicEtIXQ2hB7H/qkuXbuPPr1DUJLEmmM0=;
 b=BllXK8cpiazrW5JbaWyvwuAzpfcsrner9aKs9ucki0I3s25LWnwbpQ5yI9xMgewDfz
 cPTb453dswcmNXsrq9ggOJcIkB2kanA/Hxc9xuYdQfIu4FD9RoneLkdOr0q7paOmhJjZ
 k9HuaaOY3XsVaXpGYc67SbUDZHjygBqIGtnvvU3PWFpx+27Zz4C7Ynyvs/o9s+imJhnv
 4cGKLWiO8udSDbqd91IKKRY+tLmsPhOpOXUHXJDgVtS9KylJkGHT031WtF19Dy81UfYq
 TxqWkVdwrhoNKP721TtMCfco5uS2l29u7LhYTf5VDHGf6sPernWe+lNjeup5Bz16DPh+
 d9Gg==
X-Gm-Message-State: AOJu0YzMAXceibuFMQhEXkwfXOH8aW8x7aV12vKBiB0niLVGO2zs1Pgu
 GnfgGx3pmR8K5vfHDVTu03RW2vK6JL3NY18FU0jihYRDcxUpho1SWzK2G5DiEAzy1dWbpeGTsFr
 kXV5+8AJ733HUGNlWgbb9rJIrpMaEsYBLJqmBNQ==
X-Google-Smtp-Source: AGHT+IHWKOhjF275RalgVa0+g7kD4n88jlZyyM5pb99xK+mNXT5Hri5z7e9jyvf2Rt24Wk6jz0JCkL/zhcVxRsVwaYA=
X-Received: by 2002:a67:fe86:0:b0:46d:2f8b:d7 with SMTP id
 b6-20020a67fe86000000b0046d2f8b00d7mr6848813vsr.22.1707828939594; 
 Tue, 13 Feb 2024 04:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202180226.GF1152441@bill-the-cat>
 <CAFA6WYMSvu0rL+et1Q7xVuOnyWMDbJYQj9TeC6c2ALNNFGhRCA@mail.gmail.com>
 <20240206130040.GO1152441@bill-the-cat>
In-Reply-To: <20240206130040.GO1152441@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 13 Feb 2024 18:25:28 +0530
Message-ID: <CAFA6WYNFrazifArec7+NS_exU77TFfCWcJk7Oy26tkeX6Q2a+w@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
 nm@ti.com, andre.przywara@arm.com
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

On Tue, 6 Feb 2024 at 18:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 06, 2024 at 10:57:12AM +0530, Sumit Garg wrote:
> > Hi Tom,
> >
> > On Fri, 2 Feb 2024 at 23:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Feb 02, 2024 at 06:35:23PM +0530, Sumit Garg wrote:
> > >
> > > > Changes in v5:
> > > > --------------
> > > > - Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
> > > > - Created v5_dt branch for testing purposes:
> > > >   https://github.com/b49020/u-boot/tree/v5_dt
> > > > - Patch #6: Added support to cherry-pick fixes in subtree update script.
> > > >   Also, used https:// instead of git://.
> > > > - Patch #7: Fixed inappropriate documentation update.
> > > > - Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
> > > >   tree.
> > >
> > > OK, for v6 please push this through CI. I've started a run now to check
> > > other things, but just sandbox currently fails to build right now.
> >
> > Yeah it looks like patch#3 rework in v4 has broken EFI capsule .dtsi
> > file generation logic which should be fixed by add-on fix [1] for
> > patch#3. The github CI passes [2] with that included. I suppose the
> > gitlab CI should be fine too. If its fine for your testing as well
> > then I will incorporate it in v6.
> >
> > [1] https://github.com/u-boot/u-boot/pull/484/commits/d796c34307cd363674e0d0d2e31618643ac8e76c
> > [2] https://github.com/u-boot/u-boot/pull/484
>
> Yup, if Azure passes GitLab should pass too. I think you should wait to
> repost v6 until you and Marek agree about how we are (and perhaps
> aren't) handling fixes to dts files.
>

Although I haven't received any further feedback/comments but will
wait for a few more days before posting v6.

-Sumit

> --
> Tom
