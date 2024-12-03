Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A64E74AC3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 16:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45E46894D9;
	Tue,  3 Dec 2024 17:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DmjX4BJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E24894D9; Tue,  3 Dec 2024 17:37:49 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC388916B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 17:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so296565566b.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 08:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733243867; x=1733848667; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HLUzvHIja2ZsSXRBZMBCi9VBdboAPhkXsmj3wY/5dls=;
 b=DmjX4BJqNm/Mh9vqhwf9rnxucCm4Vxt9V3gesynppayaiV2NKUNcQBP9JFkDxRLpP3
 S6D2wuNyrjWN2ZIIEhVxEFZLSKYVL1HDuNTVde++SqOOHV4vfl1z/hS8lXtViZkStFmH
 3ARZ6YKPHsEu75nOrxHdeo1JYiJYaNYnzbx60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733243867; x=1733848667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HLUzvHIja2ZsSXRBZMBCi9VBdboAPhkXsmj3wY/5dls=;
 b=q+XigojHA/mMHcKhq07+Zkqw7Jbttevc1XlgmCqi2HJwktrtUp29wcpUxvD7a+Zslc
 Cv257Ikk2BbSYJcJLglzudwZBmomIbuwEJBXl7ty7rrhCPNMC14IXsVvo6qxz1LQmRqt
 M+9Ce2U2GWIKiqCyqUFjei8ALGUSPD0IA4mf/GXK8e0yoOlLycCVInaT+NxgW7pgAaxa
 ZjErWvkBKWd2pTAKjRxqfblaj5IHfvBWWKcxO6g30UqfkMzlJZ7aaWETfrVLRZD7ZP8O
 Hnrv4AAreeKsG8PyIpg9psqQf5i/Ewwr4ymlznilMZCVdOCYeNBumG6DHpwWqQ3RovRt
 TeeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfv3ppqzidy4S8ACQmQ4XofS9nE+N5hednKGpTgm3AUU+e5kXmGQ9q5CniiRAU7DQi4Q6DlHc=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ2s4LFNGYMZ0vtQT/FyOK6aT9MvfLbylf435B5QNgz3l8Mwr4
 rTro5k95gf/WGi3Lz8QHv9bCeK1RdLSz4gIDEHIuZykKhOM9aV+i/Kjt2Hr66yVR6y2qFVLm+s9
 xiyK19VLYqQD5CFd3gM8TWaHI1vi2/cielkC3
X-Gm-Gg: ASbGncvqFjqwmE+T8C6hAlkboaMY+2Ovn01+xxNu49iqOzJkrpHEs7xTURHxbprHMio
 IODuVfiYd7RT4V2zx1iePL+M8zzB1hfEm
X-Google-Smtp-Source: AGHT+IEiEvMLytusK3tZBfFutKzx1B4QRq6tlX6BbX6xQM/LNHK7vbGTKV//mnBktWXPqZq8Em++pa7s7O8KFbn85ps=
X-Received: by 2002:a17:907:7758:b0:aa5:630d:7de0 with SMTP id
 a640c23a62f3a-aa6018d8978mr106803766b.44.1733243866729; Tue, 03 Dec 2024
 08:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
 <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
 <20241203005541.GP2457179@bill-the-cat>
 <CAFLszTi6koMMr0ggVLxKQK5LCBv+hCunewacBxDAZYH+rERGiw@mail.gmail.com>
 <20241203140133.GT2457179@bill-the-cat>
 <CAFLszThLAYQfMxE_fVuTYX57vNBfi0PyvBzuUGCw0_1EsXk7ag@mail.gmail.com>
 <20241203160131.GW2457179@bill-the-cat>
In-Reply-To: <20241203160131.GW2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 09:37:34 -0700
Message-ID: <CAFLszTgx6BacGQyiMOoCzYDM3vsOBgfr2XbzBEsNOZ_Gzj3=ig@mail.gmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
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

If you like, you can apply the reverts first, since they break boards.
That should not be controversial, particularly as I explained at the
time that this was likely to cause problems.

Then you can leave the discussion on OF_BLOBLIST open.

Just a thought.

Regards,
Simon

On Tue, 3 Dec 2024 at 09:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 03, 2024 at 08:53:27AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 3 Dec 2024 at 07:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 03, 2024 at 06:46:27AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 2 Dec 2024 at 17:55, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Dec 02, 2024 at 05:22:35PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 2 Dec 2024 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 02, 2024 at 09:26:42AM -0500, Raymond Mao wrote:
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Sun, 1 Dec 2024 at 09:43, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > > This stops coral, bob and kevin from booting.
> > > > > > > > >
> > > > > > > > > The correct way to do this was always to use a Kconfig option, so let's
> > > > > > > > > first revert this broken idea.
> > > > > > > > >
> > > > > > > > > OF_BOARD and BLOBLIST should be general and hardware agnostic,
> > > > > > > > do you have more information on why they don't work for a few boards?
> > > > > > > > Maybe the way to handle these logic within certain boards should be
> > > > > > > > changed other than to revert this?
> > > > > > >
> > > > > > > Yes, I'd like to understand the whole problem better since we had a
> > > > > > > forever-and-ever thread, compromised to what's in tree now and now you
> > > > > > > want to revert the compromise and bring is back to what was argued
> > > > > > > against for forever-and-ever, at least from a very quick read.
> > > > > >
> > > > > > I'm sorry but I believe I have explained the problem in that forever
> > > > > > and-ever thread, so I don't really want to re-run it. It may be that I
> > > > > > was right all along?
> > > > >
> > > > > Or maybe your use case is still badly explained, and your changes will
> > > > > instead break other platforms.
> > > > >
> > > > > > Raymond, I cannot pass the DT in the bloblist from TPL to SPL on x86.
> > > > > > There is not enough cache-as-RAM, for a start. Plus the DT is in the
> > > > > > memory-mapped SPI flash, so it makes no sense...
> > > > >
> > > > > DT using x86 is a pretty odd case. I don't recall if you mentioned that
> > > > > before, and it's likely everyone else assumed you were talking about
> > > > > something more standard. Of course, you're listing one x86 platform and
> > > > > two ARM platforms as needing this change. Non-chromebook Rockchip isn't
> > > > > generally broken (or several other people would be complaining).
> > > > >
> > > > > So something that may or may not be explained in the longer older
> > > > > threads is how the firmware in these platforms are doing anything with
> > > > > the device tree?
> > > > >
> > > > > But, the biggest problem I see with this portion of the series is that
> > > > > patch #4 is 'Revert "fdt: Allow the devicetree to come from a bloblist"'
> > > > > and patch #5 is "fdt: Allow the devicetree to come from a bloblist".
> > > > > What you need to do instead is squash all 3 of these in to one commit
> > > > > and then write a new message that explains what exactly you are
> > > > > changing, and why, instead of making someone else do that in order to
> > > > > review  your changes here.
> > > >
> > > > As I said, I do not wish to go through all of that again. It is still
> > > > a bad memory every though it was a year ago. I would like to build on
> > > > what I have here, to resolve any future breakages.
> > >
> > > Sure, then you need to post something that's reviewable, like I
> > > suggested.
> >
> > It is quite reviewable. It is just a revert. I am not expecting you or
> > Linaro to agree with it, but I am confident it is correct.
>
> It's _not_ at all reviewable. Again, you're reverting two commits, and
> then introducing a new commit with the same title as the previous
> revert. I'm not even sure there's a difference in the commit messages.
>
> --
> Tom
