Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD937FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C898460C;
	Mon,  4 May 2026 14:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FBlufrLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 938DC84653; Mon,  4 May 2026 14:44:21 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ACB78460B
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-671dad7cac8so4480455a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777898659; cv=none;
 d=google.com; s=arc-20240605;
 b=GxF3jhaPf09rv3RifYkmuxK7zounkHcYi9Fsm1bDdeMSSMozwj6J2uPoBTUz5P2DKh
 pN0f1txevSfyb740UO0Ul8/66rygEWQvShvPrcNv/StStev7v7cnULd7TYq0NF8JoOI+
 G+erw849FmpRSv/gZiSUtaJLNRcNM3N1G6j7gpQ1Pc1enitEiAhfr26kUxJgdGG1YxW8
 2irkR6XwP9XcS1ZaWGfjNEKxv+Q7HWPY9YwxfJkEkgvG6uVEI3LG4HxQ/7aZfc6uixcN
 0dv931K9n6njfZyM3jonR1mVNixhml9LJqHIC+Oh63j3MJhk7zLiht3gRChfC7D7TqYA
 Iedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aZyTnTdXp1ZPA2MyT+dscw4ZStbwn+T2OKrzp/3WuT4=;
 fh=DFckRsv0qokwsicMGANTSyuTqOOhjVTjcJimUrc7cIQ=;
 b=iT5qOCZCI6MdTY4Dcmd89cA0FhefOOCZbXJ+21SAbWdV+Mgu2dMQrcV0fOHCRne+L+
 cF5IDydujl5XBef/cxVLF7rj9+OOtEefp+IRJ7l5XXdo+l2VTGExrIzs2zLOYpDyQO3g
 InFXSQ3Ixi/JewNyexCR63z6DXbT6SIn4kLYdZdVs9KUQ1fb07ieNom/c0b1jh/3l5U4
 h2kU47icRPeNREawcHxvqlwMTxpYUQlGtrIwJuCxOE2S+M1JfwPTrn25Vsjd4AXpgdhJ
 9rTFHAxaOm3olIUGDtl7VBJ/TQymQJAWqbjRqDfmcw8BuFAjEaRbS9DoV64sjfuw4CHK
 RdmQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777898659; x=1778503459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aZyTnTdXp1ZPA2MyT+dscw4ZStbwn+T2OKrzp/3WuT4=;
 b=FBlufrLx3c7jRvIMg2zpEvluJtsEuGCA6si2mmudXJFoZpU7iKeCM27/E3bdWfhikn
 RJoZoXNsz7zHJh0H7H16uLZbO8/MxveMRDSj3SVzv20LAs+dCJhkK9IkMXeSDFdvDsCE
 dq7hevegnVIIsvIH3xhkP3jcQ1A4PAe8jWZFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777898659; x=1778503459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZyTnTdXp1ZPA2MyT+dscw4ZStbwn+T2OKrzp/3WuT4=;
 b=MxtuW/orRrv7dKrKX8xdSYGm/Hcf3rSLsKLUWcdK/Zxr29udga8k8grZ0jl+dPH93r
 nEjLF9kdtzgow+HAiejFFmuThReSaO1qHj4CjtZzuAaL0O9mA49kEyy9S7qQg5c1+0XC
 F34XX86Xc6ntW3BlrXtqibxvHfKzBlz1c4C6FrHfWYL2OQga4oh1CQbOhfa9eGIDxyEH
 3iE7wczi9U+V9T1vqVeZC4EKfzy13OsUKuVCqXUALc0n4yhoQ8B/EdMrFoiDQRBnDfzh
 vZlUzHzbHIbTcMej7CE/cd1YCUDZucnSzFsdbGcFQEyBI91POAo9jDvaBCuenn3lnkLK
 KVKA==
X-Gm-Message-State: AOJu0YyVfYo+NraLijc0CYnZRl6Qu7hxRpNOcK0FSgg97h0cM7yExMgg
 n89rkRVLF+eodm337qHGs+B97/jWHcJvvQiV3TW0tRJ++z0o3+M9bZJTjK2W3P17PyOEbmrDAkf
 W9rVx4ePWu1+piAbml/oKht6sDkOtrxh+gLKshRFw
X-Gm-Gg: AeBDiev+fl9FDHRm8VsP1+CE4tSlT5hERwHQ/2UOh/MHb6jEmTlGVJjOkBop6OS/P8P
 5ZN4RzSzX9jPSwIIDYh4UGwNpQow+MTZIoL3Dx9ib7RdlOymnRtk7aDXLpd38Um7mNEggKMM52u
 aMXJlCzAvCWu7rZeAOWQSat3bHwhMGmfiHpXZHDOAJseZjcLLHsgBD4MkKnvDi6qy+bpbO9W+2n
 pK3we/b61NCTeI4gpO63lxMivHllZMDX+wpshUJHn+bwi/+YmVD6viFaIfRrQLx2GXRloZv1Yan
 7gEXmrKE/8GkV/SV
X-Received: by 2002:a17:907:a317:b0:ba7:a1cb:eae4 with SMTP id
 a640c23a62f3a-bbffb247e96mr431195966b.23.1777898658845; Mon, 04 May 2026
 05:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777551598.git.michal.simek@amd.com>
 <74c8b0830dadc5b7f36c4e2c49a1087a503f7ca1.1777551598.git.michal.simek@amd.com>
 <CAFLszTgWRJgZoLQqqLvLuUR0B_uKje5ffvQt3uZG9sdhPiKNNg@mail.gmail.com>
 <9a88e2cb-37a2-46a5-b56e-e01d336daa31@amd.com>
In-Reply-To: <9a88e2cb-37a2-46a5-b56e-e01d336daa31@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:44:05 -0600
X-Gm-Features: AVHnY4Iapq0vMDgTS9aWSOsryLy223uqB38FW_xHAndRzIqccfjmICrzm7UHjs8
Message-ID: <CAFLszTiWY77F+T4ycyW+Xr9h3bpTGBUfzCaKFMvm0V8Vnj9w7w@mail.gmail.com>
Subject: Re: [PATCH 1/4] reset: Add reset_reset() and reset_reset_bulk() API
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com
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

Hi Michal,

On Mon, 4 May 2026 at 06:39, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 5/4/26 14:17, Simon Glass wrote:
> > Hi Michal,
> >
> > On 2026-04-30T12:20:00, Michal Simek <michal.simek@amd.com> wrote:
> >> reset: Add reset_reset() and reset_reset_bulk() API
> >>
> >> Add reset_reset() and reset_reset_bulk() functions to the reset
> >> controller API. These functions assert and then deassert reset signals
> >> in a single call, providing a convenient way to pulse/toggle a reset
> >> line.
> >>
> >> This mirrors the Linux kernel's reset_control_reset() and
> >> reset_control_bulk_reset() APIs. The new functions are useful for
> >> drivers that need to cycle a reset line during initialization or
> >> error recovery.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>
> >> drivers/reset/reset-uclass.c | 30 ++++++++++++++++++++++++++++++
> >>   include/reset-uclass.h       | 11 +++++++++++
> >>   include/reset.h              | 35 +++++++++++++++++++++++++++++++++++
> >>   3 files changed, 76 insertions(+)
> >
> >> diff --git a/drivers/reset/reset-uclass.c b/drivers/reset/reset-uclass.c
> >> @@ -225,6 +225,36 @@ int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
> >> +int reset_reset(struct reset_ctl *reset_ctl)
> >> +{
> >> +     struct reset_ops *ops = reset_dev_ops(reset_ctl->dev);
> >> +     int ret;
> >> +
> >> +     debug('%s(reset_ctl=%p)\n', __func__, reset_ctl);
> >> +
> >> +     if (ops->rst_reset)
> >> +             return ops->rst_reset(reset_ctl);
> >> +
> >> +     ret = reset_assert(reset_ctl);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     return reset_deassert(reset_ctl);
> >> +}
> >
> > Will this provide a long-enough pulse on real hardware?
>
> In our case delays are handled by firmware itself because we are asking firmware
> to do it. It means no issue on our platform.
>
> GPIO based reset can be also handled via gpio delay driver.
> But I can add there one more parameter to also pass waiting delay. What do you
> think?

Seems like a good idea to me.

>
>
> >
> >> diff --git a/include/reset.h b/include/reset.h
> >> @@ -443,6 +468,16 @@ static inline int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
> >> +static inline int reset_reset(struct reset_ctl *reset_ctl)
> >> +{
> >> +     return 0;
> >> +}
> >
> > Just to check - this matches the existing assert/deassert stubs,
> > silently succeeding with !CONFIG_DM_RESET: is that intended? Should we
> > return -NOSYS here?
>
> Will look at this one.
>

I meant -ENOSYS of course. We have that in clk.h for example.

Regards,
Simon
