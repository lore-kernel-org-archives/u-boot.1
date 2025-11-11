Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D514CCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 12:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59AE883655;
	Tue, 11 Nov 2025 13:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fk5spGPL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A937983B72; Tue, 11 Nov 2025 13:38:39 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752CB835B3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64165cd689eso1334695a12.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 04:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762864717; x=1763469517; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9vJiEphAkOsMfFk4uPPtowW3LR4QEyiy8x4C1LuORNQ=;
 b=Fk5spGPLxgMm5XzUN3vFuf2KDMNEODER2nAtMGtiEej2zRUueUP0fkBBCOGbqn7lIM
 cgNBLVLKWwkQM1Pcpx3RgGCgVMOhAJkF9PMTIn2y6Rvda19XfzfZapIg4+vRXkufnFQi
 CnCScIpGhmoAv4S5C6D/mI25RKKf+6ScsK8aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762864717; x=1763469517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vJiEphAkOsMfFk4uPPtowW3LR4QEyiy8x4C1LuORNQ=;
 b=IGnh2fzX9FyDD/pu1bcvyaS2MKaTK7qTAy9vu2BYd9fiPqieV1BX1Uynb3wWRakg+l
 ByvgJ9+QI52ZE96iPaT/zDMeBVKnh03j3hN1kPT7Z9lINGhKMDDEbGZhEgSLac41GJAS
 VjCqIiOExSHR/I6OHbh8GtSexxsklIy9G8R5i9Q2hzfGT5H7yelDBgakzmIX29J3xXgY
 nvF/T1+ia7FlxhTUTQE2U3GPSvVYxTdx05DilkV7rRJh6+FwihhXzZNK4D/9nAX0Gqex
 iUNnWMUDufWZz6x0uSqYIzJDfCqB12lPER9+sOORIBR75abMOMn9kKYpxc5wlFhB3zBi
 LzHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgXtQiaKYQ8B62R8Hc8QnRqrxy7nqcaYzoG2otTBfxWRlWwzsOUQCn87L2NnV7MFuTLecVlxA=@lists.denx.de
X-Gm-Message-State: AOJu0YyBZBbFuKHeDBcwtEYJlaIQ8s+LcxuBZWYhJyaRaLT8YwwAxH7m
 g31Jq18Kgn6BoC/MMGOMpTu8R4Fs9fuP/FQJ77wDgT+EzhRtGsvHFBE9PEOyT15hCA5qb/cdYPZ
 dv1b4oNJFggMPjD4ZD+vBnOTdqfcLbyN6+4uid/m6
X-Gm-Gg: ASbGncv7LjBGBZs6y1VEyChyhkeL6xfknQK55vStfb1OZWDMRoTjvsTMPxQ06PHN5ox
 oT5HBKsjj++WxZ9niaxr7DQjLwxCzVm3dFSX9z7GHWNyqBHDLsRf+9fjwx+wpiMLa6TUt8PzvEq
 6YaSOED1MoUd6OMB4/M2hNvU74/jDjFNPnVCMb8V8KC2ACHAWgKlDlY7saeLbkNTjhwE2QEZTb5
 6sptVEIfJBslUdHekccTFF0INtUtbiZvqy1lSnYQW+7WULIf1fKrL9hAG8=
X-Google-Smtp-Source: AGHT+IHuXItWYzeQlJDRehcqnNgTJauCK4TigCV5HRzlLlG7tiaheEItCbfTJY4QRyxYy0rWJXfUL7yr4zM51FTUwzQ=
X-Received: by 2002:a17:907:9287:b0:b72:6224:7e95 with SMTP id
 a640c23a62f3a-b731d17d878mr341155366b.1.1762864716900; Tue, 11 Nov 2025
 04:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
 <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
 <20251103115225.381126f1@kmaincent-XPS-13-7390>
 <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
 <20251103161905.GP6688@bill-the-cat>
 <20251104102916.3df33d55@kmaincent-XPS-13-7390>
 <20251104163816.GB6688@bill-the-cat>
 <20251106190001.0e5a4504@kmaincent-XPS-13-7390>
 <20251106182329.GY6688@bill-the-cat>
 <20251107100517.6c79a976@kmaincent-XPS-13-7390>
 <20251107155154.GD6688@bill-the-cat>
In-Reply-To: <20251107155154.GD6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Nov 2025 05:38:23 -0700
X-Gm-Features: AWmQ_bmkd6Y24KBMXPfzP9UHOe5J4gTN4J0_Vdim5Z3RjX7tU2x0PrdTa0iGwlM
Message-ID: <CAFLszThB+WhTk3KDgb9hF0S2W1c+LLTRjNA2YysG6Zzo1_=w+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
To: Tom Rini <trini@konsulko.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, "Bajjuri,
 Praneeth" <praneeth@ti.com>, Marek Vasut <marex@denx.de>
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

On Fri, 7 Nov 2025 at 16:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 07, 2025 at 10:05:17AM +0100, Kory Maincent wrote:
> > On Thu, 6 Nov 2025 12:23:29 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Thu, Nov 06, 2025 at 07:00:01PM +0100, Kory Maincent wrote:
> > > > On Tue, 4 Nov 2025 10:38:16 -0600
> > > > Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > Other question: Is it possible to not add the environment to SPL image using
> > > > the new text environment format. I have tried to update am335_evm board to
> > > > it but I got a SPL too big error.
> > > > I have tried to add "#if !defined(XPL_BUILD)" but it is not working.
> > > > It seems the same generated environment file is used for all images.
> > > > I still haven't found were it is included in the build of the SPL image.
> > >
> > > It shouldn't change the environment size, but also environment is likely
> > > being pulled in to SPL for network boot support which does require
> > > environment. What do you mean by "same generated environment file is
> > > used for all images" ? And are you building in separate object
> > > directories for a given board or is it not being re-generated on config
> > > changes? Or did I misunderstand? Thanks.
> >
> > Sorry if I was not clear.
> > For the am335x_evm most of the environment is only in the main u-boot image
> > (i.e. not an xPL image).
> > https://elixir.bootlin.com/u-boot/v2025.10/source/include/configs/am335x_evm.h#L78
> >
> > I would like to do the same but with the new text environment format. Is it
> > possible? Something like: board/ti/am335x/am335x.env for main image
> > and board/ti/am335x/spl_am335x.env for SPL image.
> > If that is not the case could you point me where the change need to
> > happen to help me on that. I didn't find yet where the text environment is
> > pulled into the images.
>
> Ah. It sounds like we need to add missing logic to generate the text
> environment in each phase rather than once and use it in all phases?

That's quite possible, I'm not sure.

- Simon
