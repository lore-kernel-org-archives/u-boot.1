Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9DDCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 16:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C35B883A2A;
	Wed,  8 Oct 2025 18:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZK17bxYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0731083C7B; Wed,  8 Oct 2025 18:20:59 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9CDC83929
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 18:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-631df7b2dffso238820a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759940456; x=1760545256; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BIpBsJbIdAHup8ihkWg60N2YDspdHnn5VU+mkjG1mpY=;
 b=ZK17bxYkaxsF92s8DfA9UIT4U1gtFdZ4jr30ngBYFZv37w3fcJMTixNv06D/QtC8yW
 QiplQBuT+n0htxNM1pB772TPZsr4okuE43yX/PuPemEclgFlWeTJFewIiZhS28JJBYbD
 mFFtFr/cbiScrbgvi2oOySa/hpV5bSLdqM1Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759940456; x=1760545256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BIpBsJbIdAHup8ihkWg60N2YDspdHnn5VU+mkjG1mpY=;
 b=IuE5v4dmdoUQG4bv21VQj7ONkW0y/IGL/23nZrbwUhRiE75uegoVHdv7RijyDFhcfU
 YJUkrtkeSqerHGzu7sQOWHIlUWNT04MW02kCOcN8ibl2YRTKa7ZLhbltHvW4Igulhtf9
 XoG5Yd+mf+jjTB80S8yabPc0jVd57MN+3OYsbEQQHhxlKAv8hlkgPtVW7dOJ8FFDQhGi
 HVPmXoS9Vrrwglqkt1EyhjA1UlSA0f4bfwDCOzJOJPUH/y+djczq0GpsMVOQAesXgP3w
 426KucWpAU9vfcSKFjWNDM/bckpTAdgcI1GIXI+pctJsl6+rVIRtgG1+xPO9jk/r5R1s
 icUA==
X-Gm-Message-State: AOJu0Yz0FFeF9gHoHW9Vz2UfoWe2YInBpFJGNiR8x/jrIP3FVGrX8kY+
 hTdeaJtKtfw87bD48SzfSs5zXPCc++Tl3Zw/2urTvHwWENLj+vl2jBgXobSAiG0frdJZOxKKPmc
 zD0ogAJQrG6vH1oOry2vthS7UtxngUEGKNyR5ydXtPGdvvy37UKI=
X-Gm-Gg: ASbGncuur6Gsrg42G3xX+/l+12UdPAQkPouCdJlZTaR0IBa5QHNnDXKC2y+X4WkqdHE
 aHl38C17QsH36dZn3/f6ckjt6WZ2HDLN8ivmRL/THIT1XxHVsiUtxDb3yPhoO7FXoE7Q7gpy1jP
 RlnEBOGyhGByHwEwiMFJSpaQwcVNFH3b8WPqo54szC2DAHYkS3ekktk4CTwqGRjjOhFHUXjIuDT
 Cwy0vAlYP/11tlG+RWvX3Tw6i7c2Q==
X-Google-Smtp-Source: AGHT+IFtQUR7Ae+RAKryErQofJKmRV30dfsqE15BDuqxcU3avzxv8LquoqGjPVlim2XAhPqarSiu5IByR1WoCGGrUyg=
X-Received: by 2002:a05:6402:42cb:b0:639:e5da:637e with SMTP id
 4fb4d7f45d1cf-639e5da69a0mr2246831a12.6.1759940456145; Wed, 08 Oct 2025
 09:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-3-sjg@chromium.org>
 <20251007181356.GO298503@bill-the-cat>
 <CAFLszTieyj5_wTNCqsGryCses5a7DWpgVN9AUiJchmjPMViHTg@mail.gmail.com>
 <20251008143415.GU298503@bill-the-cat>
 <CAFLszTh=jWE0pefvXCpxvBZUtWWuJVem7f5HsYeJU1C7dkvq+g@mail.gmail.com>
 <20251008145734.GX298503@bill-the-cat>
In-Reply-To: <20251008145734.GX298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 10:20:43 -0600
X-Gm-Features: AS18NWCZjHppbRkDNPbVnVRqS0Mgy0ERgugZmL8KD8jWtm9F48xtF9gNh82yGQI
Message-ID: <CAFLszTjTOU1J=JPzDj-VV+mrewwAG4i04e22WQ+pKU-gND1pBA@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] boot: Try all bootmeths on the final partition
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 8 Oct 2025 at 08:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 08, 2025 at 08:45:54AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 8 Oct 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 08, 2025 at 06:53:44AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 7 Oct 2025 at 12:13, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Oct 01, 2025 at 03:26:27PM -0600, Simon Glass wrote:
> > > > >
> > > > > > At present when one bootmeth fails on the final partition, the next
> > > > > > bootmeth is not tried. Adjust the logic to go to the next bootmeth,
> > > > > > which is the more natural behaviour.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > My feedback on v1:
> > > > > https://lore.kernel.org/u-boot/20250331174144.GI93000@bill-the-cat/
> > > > > was that we need to do a documentation change when doing a behavior
> > > > > change. And I cannot recall if this change here is because of reports of
> > > > > problems or not.
> > > >
> > > > This is a long time ago, but I think it might have been an
> > > > inconsistency that I found myself. Otherwise I would probably have
> > > > mentioned the person who reported it.
> > > >
> > > > The documentation already implies the logic in this patch, as I see
> > > > it. But please suggest any changes.
> > >
> > > OK, I guess it's because the commit message doesn't explain the bug
> > > clearly enough. Is this a correct description of the patch:
> > >
> > > At present, normally when one bootmeth fails on a partition, we move on
> > > and try the next bootmeth. However, this was not the case for the final
> > > partition due to a bug. Rework the logic so that all partitions are
> > > treated the same.
> >
> > We can certainly say that if you like. It is fair to say that the
> > algorithm is still being evolved as new things come up. Most of the
> > behaviour has been driven by new tests that I've written. The global
> > bootmeth is the biggest change since hunters were introduced, but I
> > suspect there will be more in future.
> >
> > I'm heading out later today but can probably send v3 series (with the
> > tweaks you've given) tomorrow. After that I'm not sure as I'm on
> > holiday for two weeks.
>
> Peter's feedback should be addressed too for a v3 (and not just set
> aside).

Is that the email just received, or something from a different series
that I maybe missed from a while back?

Regards,
Simon
