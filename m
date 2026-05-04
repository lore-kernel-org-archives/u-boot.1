Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2682BFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A2F845E9;
	Mon,  4 May 2026 15:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R2BT1ZwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5642F8460C; Mon,  4 May 2026 15:18:04 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A24884255
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bc2301be8ecso151730466b.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 06:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777900680; cv=none;
 d=google.com; s=arc-20240605;
 b=kuLfT+4taC+nnloeVw/rMBCssVGzQWfsVTmqvV3IZjYnVC99PKcI1Ibu2ohIPb8PrV
 6TIDOa7mTrQPCP5u3j50SMQEcThw8XfgMBSYctPq9w1U4mPC6e9UoybVzEcZg7m84UGJ
 UdBzdZdWwJ/gYfibzM/ypoJGGrt407DmxDX1GOzTkwKefcU3WFrtbfnJtP+EXu9OmWaf
 ANAORnQyagjMYTbrqHmDMeQstm2bM+G7Ll6Hta/0OV/y9Td8mfV+kk8FHxZanpZN/JRi
 3uWU5vgTYfxV3gf0mQPBc+pTdBCMbB30rJtEFsOzZ71V0fSSA5mfWVC3a5Pb6ewOS+a2
 9GiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/BJCQ1blR9DzLQtTf2wTa/DJwWPOAJeKJYqor+AAXD0=;
 fh=MiPMVlZqbKlw1fatphHz+fPQCRVQHGg4dnQ7ziOy4C8=;
 b=OtiGa22xZ5r7Qn9IjKROjxDwiT8tYEKgW9sbMdygL5BOElK3JC78m4mI7SMzU0ghff
 31pBdQWJedPaOQ0mnxz4V3aaIgUzThHuFkq/xKu7VyifuoYK28oSWWAED/KyJdUzOGHL
 hnNf0EZfbCMSBTwEm6bftmLXJ9DjNT4LR0/8MPXurFcn5HYHqw6HViER9McwWFDtpSyh
 +ZvZXJGN2IW1M0mbvVuIheIOj1Umpk/ptMQp66EcI4D7TiXO0cWpetvHsJXPumRqZqZp
 99eDtt/0mKetmDS8AOSOBJLFgWwxPy24fIs1EHTUDiM3lgEihFBjwvIpP1+FlvKvIE6W
 yYRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777900680; x=1778505480; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/BJCQ1blR9DzLQtTf2wTa/DJwWPOAJeKJYqor+AAXD0=;
 b=R2BT1ZwCXPwxZp+rGXr79bE08kIVIz3mYb+XHdzE5fpv1Wdw7NHOuBJM3EZohndo8Z
 HqRq4hY6muTs+IHXMnY4DQpl5zczOG7T0P/DrBrRndyAWv5rs2OiwutV84tr8m2VUNqy
 RQYL2Syuy0a8HSRjo0uzFtfOvsg2FiOJRVxu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777900680; x=1778505480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BJCQ1blR9DzLQtTf2wTa/DJwWPOAJeKJYqor+AAXD0=;
 b=NpP91gFA3G7KxObtyZmUgEn3zIqPaIdsZeHI8ENPUtJa3ONnZ2urnWKqYWUB0l6Dem
 hEVhFmNcmkVAh4o0jQewWWvmRGUcJvjXjE4P3p38VxWChzsz9tyo2z0mbrNyQAfFNsKe
 GBDyiG9br2P989FCSQILhnwChhMdE8k/UrU+70/QWU6j1NjcEWttro84kS8FHPsqrft5
 KiidGMitN1frNd9l+s5oDEy5TbItUia2W+E2Ok+GkClFzqmYYYLRyd17aNMdrrlTuulB
 OzhuCQVvhXjNlN7I18OZqWpAiPtl71KJWlmCt+2c5UmAueR426cfNCDq369vviq3HZsm
 qeXg==
X-Gm-Message-State: AOJu0YzkAsDzpACk4AnM+PScY++kZszYSgqPnRYW8r14HrHeqis65CwT
 DHZRp/4BfzpFxUaNkM4g2LtH3JJeMj8vdskCpgelL0qHoAjsRvQ1PdKOBz9SOBLo77na0xg88ys
 RFUh1oypwvlLGZekyAnF7w4hfjyY3odbsp7dXURLcu/vGw1dGnLI=
X-Gm-Gg: AeBDietga8S3Nj6EnqexYjEjkMa8dLbyuqdA08C0qXQTe2wbdeYX+aDgWMRF1r7rvR6
 DteAi5w+Fnu1x3WBqZQFc7R8i6233H0V05X0XB0HsYfMelL8J/V8Iy8gHmiDcsUtxn/cj6+6Ssh
 6XX4nPFKRuUNfyCI0nLLOtlB72hWGda1HTELslQOIyOqqvWye521Nd4Nhu55PklzNte4Os4KtIi
 pHMIQlZdiwg0SvdbmKqFTI1c1fHHm1yjTXQi13NleTLJp4D1vy3RLDT/hZ2i1VNp4FhiBIldE3/
 zx5ZbcwiVY7qbJzM
X-Received: by 2002:a17:907:c312:b0:b9c:bc70:e928 with SMTP id
 a640c23a62f3a-bbffb951d50mr564643566b.25.1777900679584; Mon, 04 May 2026
 06:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260422023131.2813748-1-sjg@chromium.org>
 <04536c1e-c732-4d55-a98d-c14acf2d8336@cherry.de>
 <CAFLszTgQxCEYrCTyLkFiEtoDJKPBJKUJqGHFpUK0chb-wCV+DA@mail.gmail.com>
 <6980d77d-b0d6-4b77-9ade-4201bb88cb87@cherry.de>
 <CAFLszTis91k0xp6DaiV6aW2OgLYyRhHLEwpTk1jeWv0sD8gXpQ@mail.gmail.com>
 <f385e21f-8fae-4df3-93da-35f136c806ad@cherry.de>
In-Reply-To: <f385e21f-8fae-4df3-93da-35f136c806ad@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 07:17:47 -0600
X-Gm-Features: AVHnY4LXuzt3Wgn7dR7Lb34CKq1nBjED0x4Ysu_J7Bv0PfQSpU6vru3XLt7UmbE
Message-ID: <CAFLszThz24_tzGAgT9-=_MDHF6L01UeL_OEGUoJv7WPbcPR4hA@mail.gmail.com>
Subject: Re: [PATCH] fdtgrep: Add option to reserve free space in the output
 FDT
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Mon, 4 May 2026 at 07:10, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> On 5/4/26 3:02 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Mon, 4 May 2026 at 06:59, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 5/4/26 2:49 PM, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Mon, 27 Apr 2026 at 03:14, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>
> >>>> Hi Simon, Marek,
> >>>>
> >>>> On 4/22/26 4:31 AM, Simon Glass wrote:
> >>>>> When producing a DTB from fdtgrep, there is no way to reserve extra
> >>>>> space so that more nodes/properties can be added at runtime without
> >>>>> growing totalsize first.
> >>>>>
> >>>>
> >>>> Ok but why is that an issue? What is the actual usecase? What I'm afraid
> >>>> of is that you pad enough and you hit random bugs because you forget
> >>>> that adding enough properties can now hit the size limit and you forgot
> >>>> to add the logic to resize/grow the fdt when it's too small to fit new
> >>>> properties.
> >>>
> >>> I'm going to leave this question to Marek :-)
> >>>
> >>>>
> >>>>> Add a -B/--pad option that appends a caller-specified number of free
> >>>>> bytes after the strings section and grows totalsize accordingly. The
> >>>>> padding is applied after fdt_pack(), so it is not reclaimed when -r is
> >>>>> used.
> >>>>>
> >>>>> Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>> ---
> >>>>>
> >>>>>     tools/binman/btool/fdtgrep.py |  3 ++-
> >>>>>     tools/fdtgrep.c               | 31 ++++++++++++++++++++++++++++++-
> >>>>>     2 files changed, 32 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
> >>>>> index 446b2f4144b..7b393241878 100644
> >>>>> --- a/tools/binman/btool/fdtgrep.py
> >>>>> +++ b/tools/binman/btool/fdtgrep.py
> >>>>> @@ -16,9 +16,10 @@ Output formats are:
> >>>>>         dtb - device tree blob (sets -Hmt automatically)
> >>>>>         bin - device tree fragment (may not be a valid .dtb)
> >>>>>
> >>>>> -Options: -[haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
> >>>>> +Options: -[haAB:c:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
> >>>>>       -a, --show-address                 Display address
> >>>>>       -A, --colour                       Show all nodes/tags, colour those that match
> >>>>> +  -B, --pad <arg>                    Append free space to the output FDT, for later growth
> >>>>>       -b, --include-node-with-prop <arg> Include contains containing property
> >>>>>       -c, --include-compat <arg>         Compatible nodes to include in grep
> >>>>>       -C, --exclude-compat <arg>         Compatible nodes to exclude in grep
> >>>>
> >>>> I'm tempted to remove this and just tell people to look at the
> >>>> documentation in tools/fdtgrep.c. Especially since we don't actually
> >>>> allow the user to pass any of those parameters themselves via the
> >>>> bintool, so it isn't actually useful.
> >>>
> >>> I would like fdtgrep to give useful help, though. It is a tool which
> >>> can stand alone.
> >>>
> >>
> >> Yes, but this here is docstring for the fdtgrep *Bintool* module which
> >> actually doesn't support most of the arguments specified here. So I
> >> would say it's more confusing to have it there than not have anything.
> >> For sure we want to keep documentation of fdtgrep, the tool as in
> >> tools/fdtgrep.c, complete and up-to-date!
> >
> > Ah yes, I just generated it directly from fdtgrep. So perhaps we
> > should have no argument docs here and just mention what the bintool
> > actually supports / uses?
> >
>
> It only matters what the bintool exposes as API, create_for_phase() is
> one for example. I'm assuming you *could* call run_cmd() on the bintool
> and provide a list of arguments yourself but then there's no point
> documenting this in the bintool as it'll only be a thin wrapper around
> fdtgrep itself? See what we have for mkimage bintool for example?

i.e. very little :-) Yes that seems fine.

I'll keep an eye on this thread and send v2 when you and Marek have
resolved the other questions.

Regards,
Simon
