Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2646E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 17:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 279A78007D;
	Thu,  2 Jan 2025 18:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v6+MWYeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED2180196; Thu,  2 Jan 2025 18:13:28 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58FB58001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 18:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso12290304a91.0
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 09:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735838005; x=1736442805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IjL7bA0F7HJnlYLFiOeAii82ZnUSpiR9BfnrxmHs3mk=;
 b=v6+MWYeDUWEpX8cugbrjts/Pdt6/KVuHD/qcKg5lPHd/W0vXR+kr+0H+HmKTZqDCwg
 78811yU9m37L4fXeK4y7CQYZehIQmUvkQcmFmSj/mOh6tDEfKhtBocFc9Yfh3SISdzpw
 z5AQL20Yz1APVj2cfryHp2R/gUD9z37sMe5L4OL4rEfPHSfvA8r7hRdUaI3Bfe7fRG3X
 jtBwx5SAhzY/dlM7Kt2QLNEiGJX0Ei8OgCmxFehUdPHAErXzEAYhGcMOTv45PSwGr/qx
 VO8D/exTT/2e8AQO9HHlWmBFmVXg2UbJM7N0riuwOZqEvVWNFGQR0uji2Ybkb4s1sf2C
 wy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735838005; x=1736442805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IjL7bA0F7HJnlYLFiOeAii82ZnUSpiR9BfnrxmHs3mk=;
 b=F3NkY96jW8PbskJOCNiGQB+YgC5y0G9Y5d2StCYuEsple5dRyN9AmXFUcwE8Qug/K1
 FGCXUJ7Q7lmRWgMywmbyiZrRv2W+m9+l+UykIWqkXD25LJVL7rtdK7/sN0Rm1A9HmyUw
 MswM11/IoUJAPoap7I2M3XSzxdD0h+6Kzl+T+CLw+nm4/Au4Sog3XnQh8k18j98RSd8G
 hUNvSGhSv8KaBXA2DzVaH//EzdWNT6B7LR33AaM5AfcCJsSh6LDdvrU/jdmK2rMl2cdi
 YFLQA+H/9M8rvFi9W+K9CDSK6FaNc934r4L25g1nnusUHZLRLiMxsJ+UnrCQOfR5MaIt
 zQiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmihS+oFjYVFUh+HjZMOJLUc9gHFyxVeeW4bbaWMXgvlABluXJTrLE++ogaN4I1OVw4wUh4JM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyi7r4JouzyUJJScCTNVwfnwKOvggOgKy+4PSBWBNmdLmvrQk8h
 KdDn2rV4eijLDcRwWP8gJkuobUZlvt7YVWpCWn/hKjC9j/z6NCwb/OkX720TaR/AoAUJK+SOlSN
 twMAGxllZbZGFsSHCzGXO2oE3ngkSgOs+Rg+ghFoGn1gGOm1/7VQ=
X-Gm-Gg: ASbGncs8o9kcCA+GjCET/3i9t+QuyZc7XxYhx0l2+gYLKxbPBMUVWwVeJ0u8NooIS5f
 wHcXApehostuXkgQ3UvjxGbTIxVtlLgjaSD4LBrXYsm9zUBFNw3eIwvLL2tBeJZE7xienwXE=
X-Google-Smtp-Source: AGHT+IEkpsBWCpgdDVusGxF/ghj54dYPaVxiPCnkh0E6E6DKNUIzMcC9lwz88GcC9HM8L8RLCTgmL/yOC4bNM0H80so=
X-Received: by 2002:a17:90b:2e4a:b0:2ee:ab04:1037 with SMTP id
 98e67ed59e1d1-2f452e36956mr72259095a91.17.1735838003297; Thu, 02 Jan 2025
 09:13:23 -0800 (PST)
MIME-Version: 1.0
References: <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
 <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
 <20241216183014.GH1505244@bill-the-cat>
 <CAFLszTg3YgBABRqFOmzaz5KT1ipqmuFxTd1NX1x2yQz2rNgjZw@mail.gmail.com>
 <CAEfUkUJsdH=YjcN4V8Fe8Vfa2Sdb4PQJZxKe6y9RaRXcJgX_=Q@mail.gmail.com>
 <20241219163604.GV1505244@bill-the-cat>
 <CAFLszThG6SY-BvZQ_FzZ+AT+w0NSVmS_iS+nvCWaqoxVRvv6dg@mail.gmail.com>
 <CAEfUkUJhuCB-5dXt1+FKMAk1t_N_sO6qAZHMK5NJrV7coGH6MA@mail.gmail.com>
 <20250102154844.GO3476@bill-the-cat>
 <CAEfUkUJvm-Co4sZLbJEXTey3HPjTdEs33HBZzSY0BrVcMi=rYA@mail.gmail.com>
 <20250102165302.GQ3476@bill-the-cat>
In-Reply-To: <20250102165302.GQ3476@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 2 Jan 2025 12:13:12 -0500
Message-ID: <CAEfUkULiiR4FNtE8TsZ=dYa+YNLi8vAAsnkwJAZ_CKhoEFudZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 2 Jan 2025 at 11:53, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Jan 02, 2025 at 11:00:02AM -0500, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Thu, 2 Jan 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Thu, Jan 02, 2025 at 10:25:15AM -0500, Raymond Mao wrote:
> > >
> > > [snip]
> > > > As I said, we need an kconfig here to decide whether a user should
> look
> > > for
> > > > TPM log (and all other handoff information defined by the Firmware
> > > Handoff
> > > > specification) from the bloblist or not.
> > > > We don't have such kconfig now.
> > >
> > > We do we need this knob? I don't think that we do. The case of bloblist
> > > not existing where we looked for it needs to work. And the case of the
> > > bloblist not having an entry needs to work (or if it *must* exist,
> > > that's a separate option to add, ie CONFIG_TPM_BLOBLIST_LOG_REQUIRED).
> > >
> > I think this kconfig should not be only for TPM log, but for all general
> > blob tags which are required to be handed over.
> > User should have a choice to hand over *all* required handoff data from a
> > blobllist (if exists) or to stay in each data's own legacy way (from DT
> or
> > whatever)
> > Aka, the switch should be general and "one for all", otherwise, we have
> to
> > add multiple CONFIG_XXX_BLOBLIST_REQUIRED in the future.
>
> Since we're just getting this effort really moving forward now, I'd
> like to go with the assumption that bloblists will be complete if
> passed. So if the TPM code wants to do:
> if (IS_ENABLED(CONFIG_BLOBLIST))
>   ... no event log found ... hang("No eventlog in bloblist!") ...
> That's fine and how we can enforce requirements. But we don't know for
> certain what a previous to U-Boot stage will or will not have done. It
> could be TF-A, it could be U-Boot, it could be something else. We also
> don't have a list of strictly required tags, so that too is perhaps part
> of the problem.
>
>
OK. I can update my patch with this logic as a temporary solution.

Actually the tags before "BLOBLISTT_AREA_TF = 0x100" can be regarded as
strictly-required, and, when any of them does not exist, another kconfig
can be introduced for the behaviour whether to hang or to fall back to each
one's legacy handoff method. Both kconfigs can be general and one-for-all.
But yes, I agree we can solve this later when we have a clearer picture.

Thanks and regards,
Raymond
