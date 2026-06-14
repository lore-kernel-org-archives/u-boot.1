Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E451CD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D6683EEF;
	Sun, 14 Jun 2026 14:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UjS38mV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A52A84105; Sun, 14 Jun 2026 14:42:12 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66DD8800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68bac6e24fdso3402129a12.1
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781440930; cv=none;
 d=google.com; s=arc-20240605;
 b=He4a06Q1lmoL2AIDCG2L0Bs63HKUYXLpIkpZ/BIyu8ayVd0/QfWR42LOzMg7S6iJGW
 ZjnF3aNyb5EYa0i0t2Sy/kwTOhacLVf5LS7pwt6JO/nRDyGIciJpPcTH9T06ya5+1oSc
 nD6Zp0n3KCBGkebLevClBjLUBVz4vQLgbTXfkUGYw6AQvGSp1m5VQYhP5FS/ShI9RAgE
 s560ktPn/tah4m5251iP+BpfrGv6nWBeqfsGdR8g5zHLM2jxAhgLJR34ITE6CGVjC4Ex
 RK7gJFOrfjeZL+gZHb2P44EKcBEQEO4TtTQJ1rVFK+r7bzaAcsABXwkncT44Msa8N8by
 P0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ckx2kB+Tld87odR5uBHZV2dq1VDOUa2LK5PblUuvrA8=;
 fh=CMEkRgMyvokWhS32R/BK289WahZvkwTRNbj0d2wOIN8=;
 b=GtFcZab76FNvH8JrylFJR0c4RAk6+ZnJvmBNaUH8KIKoYxMY//zYRKbIaHLJX17ibf
 RaaBEYpyWD3CxvaUnycPE4C+q6GpzgrfaCNEJYJ0pVT5U7NlHfV80LLrY6eMfnc81DlF
 Xhaxy/MeHlq9/XWZ/wGOsA24OE14ibG+dtNFpdbE4HEvTajt9xT6/Og/V3QwJkyfKRMj
 PcBQ7JcRHgpNXR2xPLqkAjjJEJ68vyfQQt3/4DhHuuWTtrFlSItASUNhKHFDYQ+grJZi
 arqDY7nIuJNoOzybx70hcQcwxVVZ/H+HSi8+F+F1ZsPbb3kMUFsILbeZQxSVVGP8pwVh
 o9Zg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781440930; x=1782045730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ckx2kB+Tld87odR5uBHZV2dq1VDOUa2LK5PblUuvrA8=;
 b=UjS38mV8z0x7lIeLhnDZS3G6koKKrGxc7A2WiLADiRqQqVtNDzpzxp1tDGh3C6vQL4
 F788BT+F6RB5R0DsPkUpP90bpRKwJX1GLyR8VfXF7Uc3aZiozLq4IeeQJtL2E2KxJTUF
 GUBC7jm5cudoF6DQdTLXEau9oFVOB1gB5wB/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781440930; x=1782045730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ckx2kB+Tld87odR5uBHZV2dq1VDOUa2LK5PblUuvrA8=;
 b=a8foQQJIidQCc4BN7WT7zIDZ1c8z5kCLMcRAZTXXJDLyD+pvOwoV2tfgmf8Lr9QGcg
 MR4hHvQJBtPkruyRAKYo0JeX/spfxeKwZGiVEy0ssCIZMcUWjoc1iWzttdF6p1He0HYj
 L6lgv0afU3h+OMHADqcAxj8nMRLbGZw85A30zF1MIaG6ZMrAc7zQb5Ud3zYUmYTdCi9p
 Ru6o0CrD8uYb8EbDE71K4gKYbyH/f1wbHZrN9aHMr6SHmd0LN+B26kYHAOzmymVbq9O5
 VbQHXPIRqeZfm+3J9KicWZ64+B1rPrjx8q+bqu+5l2enfFXkDfq5HNU5ZOYwWo519seK
 bxDw==
X-Gm-Message-State: AOJu0YwOfR4lotCn2Da9ifIyaWflbYlC7uulDo7w9IvBomz5qbTYeUnl
 zAEIYhCIqLny6hEEZrF7ZJA5OA/A1KNbGkQHe03fgXJkirvcSNmEJCU3/HUUe3bBE5omH3mFdEV
 aG5bHiBVb21RLn/dJ4m0yyVAiVcNJj+S2oWhOp5Az
X-Gm-Gg: Acq92OFoO44kLiVh1DxojOW8klcfvtZvDzsjy2rUjNHd34iQyG4/4NerT89kl38gUDO
 vYNPlRWn9wi4EKtBQ2B6Z0k/0Yl9Qox1et2zUcUnj2VJXwLN7fcH+g3N1UQfltiYfODR8dnkr/t
 D/VibleFcXkgSlnC+hcsGPkpUch9x+FMsS9pMiNa70FlIPjfdL5gAM+hvWyWkfhFjRSUXIN1Fi/
 lYHtukwI6CAixxelGBAvhwdlReQWk1nNfttsshBugD3stfmL6I2rXKU3PbiKCdcAu6GDXQMok2V
 pxFyuw==
X-Received: by 2002:a05:6402:35d2:b0:68a:ac22:ccc4 with SMTP id
 4fb4d7f45d1cf-693c6b9fb34mr2401806a12.14.1781440929817; Sun, 14 Jun 2026
 05:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260325165431.1027591-1-sjg@chromium.org>
 <20260408162616.GI41863@bill-the-cat>
In-Reply-To: <20260408162616.GI41863@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:41:57 -0600
X-Gm-Features: AVVi8CfptYS2qWknXJH8SCo6RzVaa4SemTIsYEAHl6_Qym3L-IRo8oxPHOBcfjs
Message-ID: <CAFLszTiqDX2U9nv++KMczSXY_iCp=dpvG4baSV=2-WnKc+hGEg@mail.gmail.com>
Subject: Re: [PATCH 00/13] boot: Make fit_image_load() easier to maintain
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Shiji Yang <yangshiji66@outlook.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
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

On Wed, 8 Apr 2026 at 10:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 25, 2026 at 10:54:09AM -0600, Simon Glass wrote:
>
> > Before fit_image_load() was created, the code to load kernels, ramdisks
> > and devicetrees from a FIT was spread around many functions. By
> > combining most of the code in one place, it became possible to add more
> > features in a consistent way. The 'loadables' feature was much easier to
> > plumb in, for example.
> >
> > While fit_image_load() was a substantial advance, it has never been a
> > svelte function and the passing years have not been entirely kind. With
> > a few new features on the horizon, this is a good time to improve the
> > implementation.
> >
> > This series splits much of the code from fit_image_load() into a number
> > of smaller functions. Most of the changes are fairly mechanical, with
> > just a few renames and tweaks here and there.
> >
> > This should make the function much easier to maintain. It may also
> > encourage someone to take a look at its callers, which could also use
> > some attention.
> >
> > Code-size impact: about +8 bytes on aarch64 and +24-40 bytes on arm, due
> > to the compiler's register allocation across the new helper functions.
> >
> >
> > Simon Glass (13):
> >   boot: Split out the first part of fit_image_load()
> >   boot: Move call to fit_image_select() and rename it
> >   boot: Tidy up setting of the OS arch on host builds
> >   boot: Move type and OS checking into a new function
> >   boot: Move handling of the load_op into a separate function
> >   boot: Move obtaining data from a FIT image into a function
> >   boot: Check the image is allowed before setting os.arch
> >   boot: Move the architecture check into check_allowed()
> >   boot: Move image-decompression into a separate function
> >   boot: Move decomp_image() into handle_load_op()
> >   boot: Move setting the OS arch into check_allowed()
> >   boot: Drop unnecessary data variable
> >   boot: Tidy local variables in fit_image_load()
>
> I've reviewed through 5, and I assume 6-13 have similar issues as the
> rest. Please think about that before submitting a v2, thanks.

It is hard to be to figure out whether you are saying that this is
hard to review (which I agree). If so, I could perhaps split it up
into more patches.

Or is it that you don't like the end result?

Regards,
Simon
