Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AEBF8DFC3
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B28683FC0;
	Thu, 16 Apr 2026 23:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BO5notmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A2B8405A; Thu, 16 Apr 2026 23:20:46 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14DF983EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9c01854477so5861166b.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776374443; cv=none;
 d=google.com; s=arc-20240605;
 b=Oz7IDPFZV8CEOOjIdyGFXxCuRo1rnvnqiy6GxLjyLf2fZPgp2euij+4eCaWfy4TKHz
 2J+4EWCFHpsSYW1Db++tObB902AkPUqHfeTpzL4w2fcBXjJD6d2K8N3FX2JKG9GSV1lX
 OwVdhD7EX+sN0iJLNl48D+HLe7Eb9SZTd18010dNB1hmc4Zh6Rob+uexsszfjkC4ms3d
 JgNMi2Lhdyydp60hoTxrIuz3cAUW5Y03O6s1rzKm3a7hy+zCDKT3B+E257VMjr+4KDAm
 Qut80acISwMASSrCJyyY/pjFj+cN1sRaqnzPNGjoKM1Xt/3SiLdMWor2WPWpMLDbGBr0
 Pr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Im2tukHqaX0QOGMcvXOmIoTPVs7nPTKWTyJzrhVQNEY=;
 fh=iQg/guWXGpKq70u5vTuPneJn9deGVw/N0AbsNNzSCoM=;
 b=UjrSGZeANWbZQHCehD6G9KCMDPW+WicgrRZqiXhWZp7VF0dwuOfYZgp4eNFfc0G9eQ
 VHWPQvS5a15IpeEKtBa1NvXjpuEzudV38Qj2YQWe8AEOhBOKVXwGCMkMrt+zWT2dU/Hd
 4qugbYBlJP12d/kAHHS6YPlDPjPB9cNO4Sr5uc9BQxjyb4jjoYhL6fhqUKaS8ru/mzDR
 ah6y0rAxlY+EDzT8xPfQpc5UFXvkLsbNBNyp6SQ2MccdQ9MCOJ9GhnpBoYVe0n5o/q5J
 mGa3X2tW2zDwsMTJE902afdE1681AR80OGip6BUHpYdkTWvZUo4TAZJhcgh1j2D/Cwvg
 sKCA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776374443; x=1776979243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Im2tukHqaX0QOGMcvXOmIoTPVs7nPTKWTyJzrhVQNEY=;
 b=BO5notmE8bWFxzsYRe6/kge7fWlJ7wi4Lpy5jhjYCjHkIae8ePlP45173U8YIXnq0/
 2s6zbfKrgoiCrg8QlyVtsWJ893oRXOC+5GbCjBdH1xGmsNp5OPM8PbE2aT5YQrkFZsyB
 lFmYWT1gkf53Zqy5uOHzS7fMRwxE4nUrnp9xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776374443; x=1776979243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Im2tukHqaX0QOGMcvXOmIoTPVs7nPTKWTyJzrhVQNEY=;
 b=cCD6vtPHUxz0YTRH5BgftlpFKshLNOBD4d0O17vCP+DhKahZjzltKCrPF6Gr/3LZL6
 P09PLKy4iKkLQuSeJNfXzImqY/6qc2PxF8sgQRAgf3eIuzsh0/tqn+PH3c1Y35z92AFM
 aFW3iGGJYqYy+6GddixTgIncjdyyMIqVQGGXDK3zcLf8ADm2aZ2yP+Srp8pZt73QMglI
 w0jOjSfnYvmZy5t7wb6X4uvbVYQCxsEgCyChQD9IwZ9S/V1GfY3vi0swY6Y/mB5U9L48
 5BsLCH+uPKHdCJMgW12tpvPdapuiHqwqiOqWsCzpgmSKOgpJONuOwVu5eMiY81LTm2T1
 eoIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lV6/KQOTAyfVlKWWuqoq40fX/QarEFRaMer+vYa+ek/vn44WengCMFgJVJ2R06TfIPYitpps=@lists.denx.de
X-Gm-Message-State: AOJu0YxPdJieJwEOJpOGTUxfDmZrzIV8WLJziskG97mVXeK6BgjNahZm
 zO2h6jCC2Bme4vd0WVl7q4PGXs+9SMGZqw7VQ/785rGY6sTsd6az264zpR5lINU7UIepytn8Nu3
 YjSL55nS8D1d1LFyXkrGoCFAy1nwCiMTBq4ciak2v
X-Gm-Gg: AeBDievVrBZl7vDsJl9ROaJVOHTCgQoZuicxQLN0W517Gix68zkMPhon/uqT6huw7w4
 KWHlvh1qXprTJmmVYjVyVVGMFoLwfEBAuru828qPnOFAASBZEl58nNt2OZgavLMDByiB8foChpW
 pdg/gW1w7gTOgrmUUHwPf5WWm7b+O1Jd+n/C6UZtdfqXcXbtE4/GCxX4IVvlO3yMk0C8emulq3u
 pg0eNwswam8VH/4ggWKb4NcBJ7xCtc9oEwPtJ+WEpPcRvQjevTS5GrDDh+N/lkCdhrAC7jDg9FF
 pV5JxN5DLR4vB2S+/uR+
X-Received: by 2002:a17:906:6a05:b0:b9b:308f:d9b9 with SMTP id
 a640c23a62f3a-ba41bad001dmr9033866b.5.1776374443436; Thu, 16 Apr 2026
 14:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAFLszTiUDtH14YTn8tPifA4cjOV=2h5MEkOGiGm6x6sQuJ-AZA@mail.gmail.com>
 <DHUW0ASRTCZR.8TB6FRJ580PY@ti.com>
In-Reply-To: <DHUW0ASRTCZR.8TB6FRJ580PY@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 09:20:31 +1200
X-Gm-Features: AQROBzAPgiPLEJDYLg3Tpuok-dTOLofM3hLY0YrrJgt-1Ewg1kJZOyiP9rR3xSQ
Message-ID: <CAFLszTjXh+uEEMFQYOAS7sApqYBkfb3VhgiRrTDmzEzj9P+M5w@mail.gmail.com>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On Fri, 17 Apr 2026 at 09:12, Randolph Sapp <rs@ti.com> wrote:
>
> On Thu Apr 16, 2026 at 4:02 PM CDT, Simon Glass wrote:
> > Hi Randolph,
> >
> > On Tue, 14 Apr 2026 at 08:36, <rs@ti.com> wrote:
> >>
> >> From: Randolph Sapp <rs@ti.com>
> >>
> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> >> parsing a new device tree and properly warn people when a reservation
> >> overlaps with an existing allocation.
> >>
> >> If we don't at least warn the user of these reservation failures,
> >> there's a chance that this region could be freed and reallocated for
> >> something important later.
> >>
> >> This useful warning mechanism was broken in:
> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
> >>
> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> ---
> >>  boot/image-fdt.c |  5 ++++-
> >>  include/lmb.h    | 14 ++++++++++++++
> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
> >>  3 files changed, 47 insertions(+), 5 deletions(-)
> >>
> >
> > With bootstd we maintain a list of images attached to each bootflow,
> > including the address when loaded. Could that provide a solution here?
> >
> > Regards,
> > Simon
>
> Hey Simon, you may have to elaborate on that a little more. Are you suggesting
> we treat FDT reserved regions as dummy bootstd binary entries? That might work
> if it counts as an LMB reservation and we can dynamically update it if the FDT
> is reloaded/changed. I haven't looked into that too much yet.

Not so much dummies, I mean real bootflows. I am not sure if you are
using bootstd, though?

Basically, once you have a bootflow there is a list of images attached
- see struct bootflow_img

Each image has a type so you can see if it is an FDT.

This is just an idea though...I'm not sure if you are even using bootstd.

Regards,
Simon
