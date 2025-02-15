Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27504C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 12:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99B4E80C6F;
	Sat, 15 Feb 2025 13:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MJZ5OMMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CBB280C77; Sat, 15 Feb 2025 13:12:00 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F4280756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5ded51d31f1so4507018a12.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739621517; x=1740226317; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i8dgo5yjaUhlIs9bXw+EZZltsW7EJ3jpJHKunGi4KOE=;
 b=MJZ5OMMsgn4+PgGA0rwO+RDdqDghCt5iXPGmE5sqXhqab3v5BpTLBDaO5DcHGl9HGS
 H36WGjp7s2mhG58DfqM6PbjPH2wPYHnZ8s6rq7mnl6yh2M2fXXfZUNh6O4Al0yW1C4jx
 qREIboKS4gjOgIzZFgE+liyllpcHVtNmdhkaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739621517; x=1740226317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i8dgo5yjaUhlIs9bXw+EZZltsW7EJ3jpJHKunGi4KOE=;
 b=l/mDXV+0VJXekd72r4UNkGhzS1SuGcBd6q5Wz7BwUQ/of5lrycAl7rTv1X512YFY8Q
 rUV31s64V9F00rboElD0TXCdxHYRPBgaLj75tdjTTxlkIbRHINUk3Pwxo4y5kW7Q+00V
 BoZ4lKGFhklTwpOB3R1ku+hPIPoMXrQiyItT3OcOUPH31m1JF32HgOn3t1xHpfAyO/u/
 bzd1RyDxNAeiBeSuKO65r9560Doo2VkpydPVdEZeHFLF4HjvVL/0ZGXNaxLP8awwwg6s
 YyqWdFR9CIqs9EwCjQOT6YmXU78HRPkZ8Bw95E5I8963weuw9dCEbIQd54YAM5B82Cro
 mKYw==
X-Gm-Message-State: AOJu0Ywz/KbNKL6Yawu6HpCWdY4vTp+UIccIX2OIAvAMp77cqHuN1blR
 W/o0hFUJVH+ndCsqbpMG4BdoRb09yYPJXszn8in5Ijgze/SCP/1aRqO0GrlqF2SeTz43GhMvUAf
 KfISY2tF+PtmMm5GmsFPEPbjuPqkifZXVxhWT
X-Gm-Gg: ASbGnct0rYdDNLNeecUUvMA1v6Cxqx5MPse2++q0bmqWjX0EFCK35MbnFaQAkGSQyEE
 qgdJDCX2bCY754yE9XgMnnAsGIY4fVoFQHwbhyMibPeFnvTaJ8cMnWr2mY4ySy4uBwgOzJK4QLg
 ==
X-Google-Smtp-Source: AGHT+IExf/NdGAYU0ZlNrLjBozwuobrR5sPwkvG+xDwDEkdm8L0sd8JDSk60eaassutRSDF44XtwHLQexUW7F1zSVSE=
X-Received: by 2002:a17:906:c10f:b0:ab7:eeae:b23e with SMTP id
 a640c23a62f3a-abb7112dc5emr244396466b.47.1739621517110; Sat, 15 Feb 2025
 04:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-34-sjg@chromium.org>
 <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
In-Reply-To: <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 05:11:45 -0700
X-Gm-Features: AWEUYZmTZh9zWaxqYSyF2QrPQOF1EfTPaJvo9dOygbmuIXggGl1OEMe6gZyfcls
Message-ID: <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
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

On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:
> > > >
> > > > > The logic of this has become too confusing.
> > > > >
> > > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > > phases can then use that bloblist.
> > > > >
> > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > >
> > > > > Reverting this commit seems like a better starting point for getting
> > > > > things working for all use-cases.
> > > > >
> > > > > Note: The work to tidy this up is apparently underway. For this series,
> > > > > a revert is the easiest path.
> > > > >
> > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > >
> > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> > > > >  include/bloblist.h | 10 --------
> > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > >
> > > > We aren't reverting this change so if you plan to move this series out of
> > > > your downstream fork you should start from that and stop posting it,
> > > > that just leads to confusion.
> > >
> > > Who is 'we', and start from what?
> >
> > We, being the community, in here, the community mainline U-Boot project
> > tree.
> >
> > > My goal with this series is to have something that actually boots on a
> > > real board, so the bloblist changes are needed for that, particularly
> > > as the 'vbe' board in the lab tests this on the hardware. I
> > > deliberately put these two patches at the end of the series so you can
> > > ignore them if you'd like.
> > >
> > > But for now, as I understand it, there are no users of standard
> > > passage in tree, so actually it would be fine to apply them.
> >
> > And you can ignore all the feedback you like for your downstream fork,
> > sure.
> >
> > Part of the feedback in this series already was "Yes, we can clean this
> > up a bit more if bloblist will do its own thing instead".
>
> So I see that Raymond's patch is a significant rewrite of what is
> there today, with multiple aims and changes. I would rather add my
> revert and start from a cleaner place.

Also, I forgot to mention that U-Boot doesn't seem to support the
firmware handoff protocol in SPL? If so, could you point me to the
code?

Regards,
Simon
