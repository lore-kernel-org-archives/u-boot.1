Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD2DC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 14:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEE8808B6;
	Sun, 16 Feb 2025 15:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HzkbPbdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D998801B0; Sun, 16 Feb 2025 15:10:46 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D55808B6
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 15:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-abb999658fbso16127766b.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 06:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739715043; x=1740319843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4fq4QjiOB40rL8Vm/G2ihCkuU5fLHmSLrfog3EXn6d4=;
 b=HzkbPbdyrV6bgElFO8idOqJG31f2BpniOYAZexeE8Q0bGjSbPwX9cIWl2Ib1BjkXjF
 /71o5jA5fMqzxkhFR28Xft7NDAX7XkN3+goWIx5Zh66KcN2xSqg66fKklJak9UKn6zQC
 oEqaP3z32MqF3SHuxZrs5XvU/9TnnwXb0ruT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739715043; x=1740319843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4fq4QjiOB40rL8Vm/G2ihCkuU5fLHmSLrfog3EXn6d4=;
 b=R021dgcAfKkX6kKMZ1fskSKzcP+rU5cAWznd8/vEPNUYYgD9VoIDsSQAuRAbEST8Nv
 dlBiO0OeW19CrG8HmllW8AAV1flKYBULxTXbt8zzoIimST79TbVFYIhSHC3BjpyN2CUX
 hZsxFO2E3v0WrWv2e+D+qKaUHWw+t9R1YwM6E+FUuK1gg6S5pNn/wFgCUe9L1/W0g8td
 zJOGE7mPUFY2NvNcNU5mpZ/LaJF1CO1E/rxLbXf+AThtrbd12Soek9ekTZPr0+2gpBN1
 s1sIjW9dZLDq4kZUsPbQIaUNeM5yHrUZMP+QG9vVNMsEjaTHCp/j3pFjOyckbvQPbvsZ
 kkGg==
X-Gm-Message-State: AOJu0YwXnNyOHJ2FbLJtCCu41DeNNZnI1rYEI0Jtd+niscpjs/k2ZvU+
 dde9BRYxxmb7O5VAXYF0jIeSQg6PrdOdBue/WCKTdqWn9KqgiYMqeP/NBTBXU3w/smXrQDh2H/o
 dMQ8eoza/jVTrltwbpwyndWY+k7rJiVYj+sl5
X-Gm-Gg: ASbGncv5qgUYJfUkVA1YKP2ZCxoxuthnp7XSSfpZXkxACn5hJoUUSkHTxtk9X0AI2c2
 y4rJItUIPzk95Z3NUs1oIcFOCz/PphnxthrPHdahbXVoRFu6OI4ObE/pS4iOhV4ulx5XMS8S4FA
 ==
X-Google-Smtp-Source: AGHT+IFlauDGNuTiruP9/UEfLHLH1Fy1tqFjQn+XmS3GluQQiqxGDceYVEAoVjd8Fh8bjBVqYjC0sDwK1Io9b6/eFL8=
X-Received: by 2002:a05:6402:234f:b0:5de:a6a8:5ec6 with SMTP id
 4fb4d7f45d1cf-5e03602e275mr19035960a12.10.1739715043374; Sun, 16 Feb 2025
 06:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-34-sjg@chromium.org>
 <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
 <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
 <20250215150116.GS1233568@bill-the-cat>
 <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
 <20250215182847.GW1233568@bill-the-cat>
In-Reply-To: <20250215182847.GW1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 07:10:31 -0700
X-Gm-Features: AWEUYZn5qXvSisa_DudxAocO1gPvUdEbvAHxWRm5VZhedbawISkP7XGhGU_Mvqc
Message-ID: <CAFLszThDsf322WQ1GCSFNmj=41yhBhLEZisXEaSTyHYjzG6TmQ@mail.gmail.com>
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

On Sat, 15 Feb 2025 at 11:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 10:24:50AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 15 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > The logic of this has become too confusing.
> > > > > > > > >
> > > > > > > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > > > > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > > > > > > phases can then use that bloblist.
> > > > > > > > >
> > > > > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > > > > >
> > > > > > > > > Reverting this commit seems like a better starting point for getting
> > > > > > > > > things working for all use-cases.
> > > > > > > > >
> > > > > > > > > Note: The work to tidy this up is apparently underway. For this series,
> > > > > > > > > a revert is the easiest path.
> > > > > > > > >
> > > > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > > > > > >
> > > > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > (no changes since v1)
> > > > > > > > >
> > > > > > > > >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> > > > > > > > >  include/bloblist.h | 10 --------
> > > > > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > > > > >
> > > > > > > > We aren't reverting this change so if you plan to move this series out of
> > > > > > > > your downstream fork you should start from that and stop posting it,
> > > > > > > > that just leads to confusion.
> > > > > > >
> > > > > > > Who is 'we', and start from what?
> > > > > >
> > > > > > We, being the community, in here, the community mainline U-Boot project
> > > > > > tree.
> > > > > >
> > > > > > > My goal with this series is to have something that actually boots on a
> > > > > > > real board, so the bloblist changes are needed for that, particularly
> > > > > > > as the 'vbe' board in the lab tests this on the hardware. I
> > > > > > > deliberately put these two patches at the end of the series so you can
> > > > > > > ignore them if you'd like.
> > > > > > >
> > > > > > > But for now, as I understand it, there are no users of standard
> > > > > > > passage in tree, so actually it would be fine to apply them.
> > > > > >
> > > > > > And you can ignore all the feedback you like for your downstream fork,
> > > > > > sure.
> > > > > >
> > > > > > Part of the feedback in this series already was "Yes, we can clean this
> > > > > > up a bit more if bloblist will do its own thing instead".
> > > > >
> > > > > So I see that Raymond's patch is a significant rewrite of what is
> > > > > there today, with multiple aims and changes. I would rather add my
> > > > > revert and start from a cleaner place.
> > > >
> > > > Also, I forgot to mention that U-Boot doesn't seem to support the
> > > > firmware handoff protocol in SPL? If so, could you point me to the
> > > > code?
> > >
> > > Yes, you never implemented handoff between stages in U-Boot via
> > > register. That's not a use case for the platforms that don't use U-Boot
> > > for SPL.
> >
> > If you let me own bloblist, I'll own it, but for now I am staying away.
>
> Would you be working against mainline again, and not breaking standard
> passage (as it's been split off) ?

Sure. The only reason I have my tree is because (I feel that) parts of
U-Boot have become no-go for me. So if you'd like me to maintain
bloblist again, I would be delighted to do so.

Steps I see:
- Get my boards working again
- Add standard passage from SPL->PPL
- Figure out what to do on x86 to also use standard passage

I'm not quite sure that BLOBLIST_FIXED can be removed, as it needs
more thought. The phase that creates the bloblist initially needs to
know where to put it.

Regards,
Simon
