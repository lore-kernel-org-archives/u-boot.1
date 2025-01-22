Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27B4C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 12:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28D8B80586;
	Wed, 22 Jan 2025 13:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sM4oQNOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B884880805; Wed, 22 Jan 2025 13:29:43 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA75803B5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4afdf096fc5so1610107137.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 04:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737548980; x=1738153780; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RKfDfqX2aJxApYpDKgQ/xMP3mRh+aW+Vi7f40y90W+I=;
 b=sM4oQNOt2ibJWDRibR9JjN3ZISnKWXQkuYSsZLDqSREJIYt0IhUA/fL7QnuGMpGu9O
 iYnKmxIj0LdKPDgKuGKr9ZGmbtD06mitenT04jR7oZVusy8xuFu8conYFNfmb1CGL321
 5Bi2+yHkIWfTiPq2PS7w3spX9H8wdvGmlnGtpJtjHAHCHGGDN2gxBNsR9qjKR2vChIb7
 m/aAU+CDfed+ANUUOVzB4EiM5u1hHUDicMbuJYNH1DwU1I9FUiNb+hJc0SO9zMJRzmVg
 Zp+tvEvYp+MnCIfZd6aidWlXFvHkFxUgFkLYacUWnqdmFrvMIy+TO9mwB85piknSyKZl
 Qocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737548980; x=1738153780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RKfDfqX2aJxApYpDKgQ/xMP3mRh+aW+Vi7f40y90W+I=;
 b=oTz40GSudrWyhyyIcIuHquNpJiTJK+HWSWqQze+9gtukcoaQSPXREd0ukDlY12+l9O
 RRzXE9G4nLD5hvhvGYgr2iVBlA06BaZYtWCq3U4aM1DwZAtasFrkx5rLpN9ngDamuKEq
 MwoPYL4ZLZtUgiVrWQOGbi3hXvr1qT6f6vsB3jS8x3qix6L2kM1HQZqDEjLXKJ7hLrtm
 4YaDja2zSmbgcdW/SmH8U8dNO36v0kIv2kw+s8CNRyKEbdt19lyN7ArwlSgSgcvMhc8s
 Z9tCfstSJ5YAVjbpqZhBOM1JTLHPdEgh5HB5AaW8DNoNCinJ8ccCNVrAeq9hQYgnTv3m
 0a7A==
X-Gm-Message-State: AOJu0YwjLPm37BmWYwvS1ZyBAkdWGLR6iJphEigfuXy3SmPuoH3Qc+83
 e3PEo6lJBkTBKWxUqDBWQhgQ6Ct7+KMs4rU6b2DVvtc5W0uhkdzoln6ccDSGEOnmG4tHAhWDs7T
 qkhHni9nMCeK3TjSZzWUdDSW66gpQ3TIhLFF0Qg==
X-Gm-Gg: ASbGncsT2gWJYbyfenzQMCU/WlNQiwlgtBjjkGQF7HEJ7NjBUgsNySDorb6eMWkL/5f
 ltjLgJOW//v8Ol2VtH6YV8DfY9/aRJo1jVabZgzl3QfWTbN6pMjxZlSZuplmd5uH2
X-Google-Smtp-Source: AGHT+IHOW4//E3VMc8I+DoxHnxfbn5ha6Ap2Xhdcy+WJKy8/z/aYYGRLodF4ac2XrbJ5oeXSSH164oLFf84AqeV75mo=
X-Received: by 2002:a05:6102:cd4:b0:4b2:c105:dc40 with SMTP id
 ada2fe7eead31-4b690bfc8c0mr17831596137.8.1737548980258; Wed, 22 Jan 2025
 04:29:40 -0800 (PST)
MIME-Version: 1.0
References: <20250119164157.23648-1-andre.przywara@arm.com>
 <CAFA6WYNAW_KTK5Evs0e_d0c3g4uDOVOZ6dbeF0LhVhX3tUrZDw@mail.gmail.com>
 <20250122111905.4dcbceee@donnerap.manchester.arm.com>
In-Reply-To: <20250122111905.4dcbceee@donnerap.manchester.arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 22 Jan 2025 17:59:29 +0530
X-Gm-Features: AWEUYZlZQgZ9MOqoPvDj4JhEc4D1kV86S-Cw8EnJSXuMeXVtt1livJXOKRINzEM
Message-ID: <CAFA6WYPaoRG=e3gGZc=+W-7y=i7qDWsqe+reGWFYivt5icVUUQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] sunxi: switch three SoC families to OF_UPSTREAM
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
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

On Wed, 22 Jan 2025 at 16:49, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Wed, 22 Jan 2025 12:03:24 +0530
> Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Sumit,
>
> > On Sun, 19 Jan 2025 at 22:13, Andre Przywara <andre.przywara@arm.com> wrote:
> > >
> > > This series converts boards with the Allwinner F1C100s/F1C200s, A10, A10s
> > > and A13s SoCs over to OF_UPSTREAM. The .dts and .dtsi files were
> > > identical between the kernel and U-Boot repository, so this is a
> > > no-brainer.
> >
> > Glad to see this series especially the diffstat.
>
> Yeah, love that too, though the mailing list server blocked 2/3 and 3/3
> initially because of their size ;-)
>
> > > However there are four boards (tablets, I guess) that do not have a .dts
> >
> > Can you share the board names you refer to here?
>
> Ah, sorry, sure, it's:
> iNet_3F_defconfig       sun4i-a10-inet-3f.dts
> iNet_3W_defconfig       sun4i-a10-inet-3w.dts
> Ampe_A76_defconfig      sun5i-a13-ampe-a76.dts
> iNet_86VS_defconfig     sun5i-a13-inet-86vs.dts
>
> As you can see, they are extremely minimal, and also identical
> between each other, except for the model names. So there is cleanup
> potential regardless, but we have bigger fish to fry.
>
> > > file in the kernel repository. For now I kept them using the "old
> > > style", so they continue working. This requires to keep a copy of the
> > > SoC .dtsi file,
> >
> > Is the SoC .dtsi file present in dts/upstream? If yes then it is
> > better to not maintain a local copy for them as the local .dts board
> > files are able to include SoC .dtsi file from dts/upstream directory
> > too.
>
> Oh, now I feel stupid for having not even tried that!
> That indeed works, so I will remove the .dtsi, but keep the .dts files in,
> at least for now. Jernej has a point that those boards could also be
> removed, but I didn't want to pull the plug too early and unnecessarily.
>
> > > I would be grateful for any advice as how to handle this
> > > situation best. Ideally we would submit the DTs to the kernel, but I
> > > don't know how feasible this is, given their age, the missing device
> > > availability and their basic DT nature.
> >
> > Lets have only local board .dts files for them including other
> > dependencies from dts/upstream tree. This will at least give folks who
> > care about these boards a chance to uprev the corresponding DTs.
>
> Yes, I agree, I didn't know that this was even possible. But works for me,
> certainly.
>
> If people don't mind, I will apply those patches now.

That's fine by me. Feel free to add:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> In my test builds
> the .dtb files came out identical, so there is really no risk in this
> anyway.
>
> Cheers,
> Andre
