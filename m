Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1773ED1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F9189202;
	Mon, 14 Oct 2024 17:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iqBdU8Gl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB89B891E0; Mon, 14 Oct 2024 17:51:15 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59576891E0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbd1ae26a6so33629556d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921072; x=1729525872; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TQyb+AWJt22GxetpABdp92puA9JRCoYS7zP5Tl36WVM=;
 b=iqBdU8GlE+GC9SK0ymnE6SCrTQtkm/9eDZDRaapkXHbrQgQ4d4NLfvW63wf8sKNU2r
 uYn11TobhbjtJ1HgWocjC7OB25Jfz2pJs2CRO2r3P3SawkgiYZwCfCTJMIDFzeqXmOKX
 uoiUV2KzXziGW7nL0siLgehjaN02NpQ1aUisI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921072; x=1729525872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TQyb+AWJt22GxetpABdp92puA9JRCoYS7zP5Tl36WVM=;
 b=kQVxL12qCXmA3LP1DTy11qE/mAmQorxeEZ/sAkzmgdEpnlQdEQSS8CYtA/gZK1iro4
 xhgakz8Ht/MubvMbEKd4eDBTNihMRPlL879cv4cGyKWQo2rc8q4Ep1fPWRSNtnKuNwvi
 3OBOdQCfWk1HyKhkw8zGcChU4jae3+lEcmibfbgmdY2BEVMQpVzAcv5f8FoPJF3Wyqr8
 Oy3XuzH8YV43aMSAFNwkseqn3q4N6KZKEkTdYJg5LbH13NpfZIEzNwBfxwwrPWNeIYqd
 yuYc0vfJs9XpOXToRYGKXpRJwexclxjJxWLzcDpBQh3XPbko5ePu/KjtAuJM+26JKi+1
 5SBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJdd00OEXmbhzHhf/9xPtX583W+v7VIRCN4OjvEuaYviBndrUGWVreIEHN16ZnXgcwTbXZ15M=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3wjWQMfGXz1Ej+apaQm4m1bsPXRTOV1ETb2kSUm0Rewmd0PsU
 2ZHi3BOvSNyoxbE41uc6GhL9qDU3zhh8A1DKzHLL+IJz0rpLagQ6jXHsPtmPZR47Zyn4/s4QhoR
 hTOJmxIfrMUE8MAsDKd91tvL0j0OSuUjqeJWr1vrxPYgeuZ8=
X-Google-Smtp-Source: AGHT+IEvcNQH2dghyNIhfTYJTYBEuWvlSnKvVwixMO8mRJacUmuGjQehRUvfjs58zQyjLZheEqCzB1pV6AP2VyCNTAU=
X-Received: by 2002:a05:6214:458a:b0:6cb:e9da:bd6 with SMTP id
 6a1803df08f44-6cbf0009929mr161020646d6.35.1728921072117; Mon, 14 Oct 2024
 08:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-3-sughosh.ganu@linaro.org>
 <20241013175146.GN14210@bill-the-cat>
 <CADg8p97a5jVR=_YRpbzBDEFLzPea-UtBFHc+X679vyPhGfC2Xw@mail.gmail.com>
 <20241014150217.GL53053@bill-the-cat>
In-Reply-To: <20241014150217.GL53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:51:01 -0600
Message-ID: <CAFLszTgABdmQwUqh0B+3d_vcstoaG1wTq=ksix+Om_7rbUL5Bg@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] lmb: add a flag to allow suppressing memory map
 change notification
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Mon, 14 Oct 2024 at 09:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 12:26:02PM +0530, Sughosh Ganu wrote:
> > On Sun, 13 Oct 2024 at 23:21, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Oct 13, 2024 at 04:25:09PM +0530, Sughosh Ganu wrote:
> > >
> > > > Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> > > > reserving memory. This will then result in no notification being sent
> > > > from the LMB module for the changes to the LMB's memory map.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > >
> > > Can you please elaborate on what we need this flag for, for example what
> > > the valid situation for it is? We should be updating (or adding comments
> > > such that updates are automatic..) to doc/api/lmb.rst as well. Thanks.
> >
> > The flag is used to prevent notifying the EFI code about the change in
> > the LMB memory map when the alloc/free request originates in the EFI
> > memory module.
>
> Simon, this is the loop you referred to on IRC the other day, and
> instead you solve this with the flag about a point of cooperation?

Yes, that's right. I'd like to have EFI allocations confined to the
EFI area until efi_init_obj_list() is called, then have EFI add the
lmb reservations to its own table, then own memory-allocation from
then on.

Basically if we apply my series[1] first, it will remove the need for
this EFI call and the associated complexity. Most of this series will
still be needed though.

>
> > The EFI memory module adds the memory region to its
> > memory map as part of the alloc/free operation. The idea is that the
> > LMB module should notify EFI about changes to its memory map when
> > these changes are initiated from non-EFI consumers of memory.
>
> OK, so the first change is that since doc/api/lmb.rst is just a
> kerneldoc of include/lmb.h we need to add the flag here, and we need to
> first document LMB_NOOVERWRITE which is already undocumented. The next
> change is that at the end of the series, update the rst with some
> paragraphs about what and why, for clarity, after auditing include/lmb.h
> for other items that are missing kerneldoc comments. I am willing to
> make that second change a follow-up series, however.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=427729
