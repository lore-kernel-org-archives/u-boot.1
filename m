Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4695DCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 16:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C3984088;
	Wed,  8 Oct 2025 18:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bU5zbfw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3E1D84090; Wed,  8 Oct 2025 18:52:31 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B03DC839B9
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 18:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6398ff5fbd3so30170a12.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759942349; x=1760547149; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XHEpTZKfN8aZzBEt8OHckxg3aYOGSveLXkXiPOScE14=;
 b=bU5zbfw94hWxx9uGPeGU/Lb/KdRLUHB0/kIsTsNZlmG2u9zvxNcQCibaaXeAZhYJt8
 AhXGRMAkg3Rlq4TxKCq7+Cb869T3Z6s1JLh1ojuLxwllEbGg+aA75YWV0tgRfI6t756o
 cZU1WIbdUwRyZjR2d5BaeEUblNv4i1LhRVIwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759942349; x=1760547149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XHEpTZKfN8aZzBEt8OHckxg3aYOGSveLXkXiPOScE14=;
 b=w4wOqq3EO30mBF6r7zbX4LcE9VCLIyCVacYLdWbW3scQKG28MpuXLFkR9wbY1m08dT
 e6rRcLa6n3Vl4jDOGTkO/CM+kZ7HQ3jxNCF/5q+5aoLsWOLxvoN5qO4iPvp4SKBIaQK1
 ZwOxP+HQ1RJHE3ZWG+n0P0XYrGo0peCisQV5TL2MwnnbCM4VCHtXU096/QOvaMc6b6N7
 Ha2gsVfU3OajbmRoXWokoySIQzgqyEyhw7iT4kKDCCcSvMrKik7L/T5d41jJFxpdhkl8
 4Tm6GhC8T9DrKdkGhUEPzh1C8rgHtRR0zKLy9tIewii/I4tHRyuFDXNsXWRmAhT7a/E3
 LN0w==
X-Gm-Message-State: AOJu0Yz2LsQ/tCGB2ZEUcFNbKKylQlpgFxmgFKhIGHnGJBklYY5mt/ei
 x9LFkS6YrH+4+BkjGtRnJi06H1fFIgpzA4O6Jg+riDtMGJlFrqunBZBpy5z96P3dTS+rurwvxn9
 mUsgv90NYOZwepYLhZKUcRMyBXYsMZgSlqa8I9RM8
X-Gm-Gg: ASbGnctLHa3xtYw42259odQT91xWCZTg6lLZPqDO3nHoPLBT60abCgqfMR/KNoiKv47
 h1Cs+98NoXjRqpvnvm6idLH3Pr2U7wYr+Vu4baUwMnkYjik8fJQj/ESHnxyvB8A2ZRhN6IsmnR6
 M2tf2zZlBbiYzlT5Xsj6bpbqR871+nJxrA5RrnOuRLlUT1FdKyh1FiWMx+7MOpyDxdmWlDr6p+4
 hv29txboKRFzCCWPO7V436a8q48BnLi0viL84Fj
X-Google-Smtp-Source: AGHT+IFZYkVvVq7YAy/dmJ1LH12Oo+xG9QwyQOV/OEHA7HnddsMYEwYKj373eJTydiIBWS05Pd8Tr6oGXinPhf57ybs=
X-Received: by 2002:a05:6402:5c8:b0:639:d9f4:165e with SMTP id
 4fb4d7f45d1cf-639d9f4174emr2977335a12.29.1759942349189; Wed, 08 Oct 2025
 09:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-3-sjg@chromium.org>
 <20251007181356.GO298503@bill-the-cat>
 <CAFLszTieyj5_wTNCqsGryCses5a7DWpgVN9AUiJchmjPMViHTg@mail.gmail.com>
 <20251008143415.GU298503@bill-the-cat>
 <CAFLszTh=jWE0pefvXCpxvBZUtWWuJVem7f5HsYeJU1C7dkvq+g@mail.gmail.com>
 <20251008145734.GX298503@bill-the-cat>
 <CAFLszTjTOU1J=JPzDj-VV+mrewwAG4i04e22WQ+pKU-gND1pBA@mail.gmail.com>
 <20251008162809.GB298503@bill-the-cat>
In-Reply-To: <20251008162809.GB298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 10:52:17 -0600
X-Gm-Features: AS18NWAJzmQvYyaqvAVEklNBJgONAEQrtkZG8EJ8MT7k8HSumuY50MUi65oQVvk
Message-ID: <CAFLszTjCqi8U7s8NgGq+ZpXf-Cqe3=fK2rLTY1UVMHqvkyrvDw@mail.gmail.com>
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

On Wed, 8 Oct 2025 at 10:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 08, 2025 at 10:20:43AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 8 Oct 2025 at 08:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 08, 2025 at 08:45:54AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 8 Oct 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Oct 08, 2025 at 06:53:44AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 7 Oct 2025 at 12:13, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 01, 2025 at 03:26:27PM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > At present when one bootmeth fails on the final partition, the next
> > > > > > > > bootmeth is not tried. Adjust the logic to go to the next bootmeth,
> > > > > > > > which is the more natural behaviour.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > My feedback on v1:
> > > > > > > https://lore.kernel.org/u-boot/20250331174144.GI93000@bill-the-cat/
> > > > > > > was that we need to do a documentation change when doing a behavior
> > > > > > > change. And I cannot recall if this change here is because of reports of
> > > > > > > problems or not.
> > > > > >
> > > > > > This is a long time ago, but I think it might have been an
> > > > > > inconsistency that I found myself. Otherwise I would probably have
> > > > > > mentioned the person who reported it.
> > > > > >
> > > > > > The documentation already implies the logic in this patch, as I see
> > > > > > it. But please suggest any changes.
> > > > >
> > > > > OK, I guess it's because the commit message doesn't explain the bug
> > > > > clearly enough. Is this a correct description of the patch:
> > > > >
> > > > > At present, normally when one bootmeth fails on a partition, we move on
> > > > > and try the next bootmeth. However, this was not the case for the final
> > > > > partition due to a bug. Rework the logic so that all partitions are
> > > > > treated the same.
> > > >
> > > > We can certainly say that if you like. It is fair to say that the
> > > > algorithm is still being evolved as new things come up. Most of the
> > > > behaviour has been driven by new tests that I've written. The global
> > > > bootmeth is the biggest change since hunters were introduced, but I
> > > > suspect there will be more in future.
> > > >
> > > > I'm heading out later today but can probably send v3 series (with the
> > > > tweaks you've given) tomorrow. After that I'm not sure as I'm on
> > > > holiday for two weeks.
> > >
> > > Peter's feedback should be addressed too for a v3 (and not just set
> > > aside).
> >
> > Is that the email just received, or something from a different series
> > that I maybe missed from a while back?
>
> It was yesterday:
> https://lore.kernel.org/u-boot/CALeDE9Ovemog2AGN_Li8Ju12QKHOC0D30V2=KG00f0KsQ5aPkg@mail.gmail.com/T/#m34f6e2c51fdfb275ba9930bfdc2ff349ee542b51

OK, I replied. Would you like me to send the 5 separate patches he
mentions as a separate series?

Regards,
Simon
