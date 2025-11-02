Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59784CCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 17:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4105083642;
	Sun,  2 Nov 2025 18:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ds4EpsxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC460830A0; Sun,  2 Nov 2025 02:10:02 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C9C982A9E
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 02:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4711810948aso23509695e9.2
 for <u-boot@lists.denx.de>; Sat, 01 Nov 2025 18:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762045800; x=1762650600; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YIdGNyJElwsPOOS0zRgIsevZAlH9JPDZcpI77KZwq9Y=;
 b=Ds4EpsxGPnp05Lq7VtbdDrusoFUD1NysACBbX0SJkIc1bQjnwuKinxrdyLsArNCnmh
 1MUmNyvQ1KlGgWASkIzhZOf9l7tEeJ0BZFFZ1SbuAyt7Ovp0cN+Wd4q8KZBovja08z26
 Vj05TunGQ1VSlCL0JvzVkJR0YrGFSxpye+xv/+wVlbki7xmfUprtWKFo4gbWaxIPlvCj
 kZtLV/uMuMvwjRj+jiquzeYzUZKYj4BvYl0tyKuo+YmhQnr5YJFoTrjWqB6rLOPr9y+C
 2Ew1S9S13DokavY4WUizrZZZiNpvWF3LFSx7dztMt+Or3mDTKItiiMKR3cn3+hCisc4k
 XDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762045800; x=1762650600;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YIdGNyJElwsPOOS0zRgIsevZAlH9JPDZcpI77KZwq9Y=;
 b=tCze+SUWmj2daBmdU827wTrppnP9BamQsmcfy/rPIegtOkNSATPorjetzx+gb6FYU+
 +C5zAYoKvRv9b2u6Lggu4J4t8ljsoOaXmrxt2NNtVs7uiCGr0ZK0A505NclR3/4Hj0YU
 lwEgwqcCElvJuwCiUDfFJcx7L8YitxtS/TQFekgrKvJWBa3Vta9gLF+LAQYtOF5DUZAP
 5xfwISLvY3JQKH3CdnmyvnP9Flt8mBbAg98jw3dMew1ckJ6sMkzp7T76sBsG/tB60UYC
 k2fa371fygcpW5qOkAlDggxJuEZevUTu7Izg1rFOj6RNAyqcRRW7X4vrryZMxq1uietR
 r++A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaeUsC9hgM57Ad8eFEjrRjSsapDblCnZ1uu3wlKl0Ga+2uGUA7LjSGbPEP9l1yZhyMoHlzxyE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzmc7auIwXu8tl2Bkoh9pV1CmK0dsjTDARkki/fI0xqPny1dEg/
 53UWteC3Tkv84Fssoi3WhhZ6/gGKfaVfOeHyhCt/VLBRKC6bsCHaUA/O
X-Gm-Gg: ASbGnctaYxoKZbsYb+E9LveBiywRcMNTE0olB/6nWRnMo89IFaQPVZT6jQXaVVPDHZO
 McmNWbJD86o4hqu1lDGDj6anfLhGK6opdBkk38ncLSMCcDiiIQqae7AM+njsBhBDXM2/27tJJmb
 nVw8Z5pmEKUvF2lrq9TnGysQkunLQwowTee1BkY1PgSyO6WCkHnWxFmYzE/id4Pd+ShdtKD1weA
 lhoKWYHiohj/R1gWiH8/2+YjTsfyiBSuY3IGYfNGSYGweBldnScGVO/Ne7I3RbbUk9jSQq0Z2oo
 v11yLSN5DOWRljJx6zfZwG845gjdl8cxMYFGqpMjOhrZvPoilNV49aoLmIFbbj7KbUDjTZzt+kM
 c4vX/eLXZMvsCjpc6VS2KuP2Vpq5NXdvqa3gN7Syslr7kxyqB+q6Kd9rq0WA33Kh/tzi19FFGTJ
 mX2nGVBMt2lojk
X-Google-Smtp-Source: AGHT+IEXVh03mHIPh+MWp0GP4XlnP+CDeoYMFJuqRScteYbXsDvJQPClQLJkyEd7lZgxLN103/Oq0g==
X-Received: by 2002:a05:6000:18a5:b0:427:a34:648c with SMTP id
 ffacd0b85a97d-429bd6efbbdmr7217481f8f.58.1762045799469; 
 Sat, 01 Nov 2025 18:09:59 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13e1d8bsm11717105f8f.25.2025.11.01.18.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 18:09:58 -0700 (PDT)
Date: Sun, 2 Nov 2025 02:09:50 +0100
From: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com,
 Sumit Garg <sumit.garg@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Dillon Min <dillon.minfei@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: Re: [Uboot-stm32] [PATCH v3 1/7] ofnode: support panel-timings in
 ofnode_decode_display_timing
Message-ID: <aQavXq6jVagkIa53@thinkstation>
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-1-b42847884974@foss.st.com>
 <CAFLszTiT9iLx6gguhVui2Qh0Ew89yhvpDggKwPo71cB+Rv=xJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTiT9iLx6gguhVui2Qh0Ew89yhvpDggKwPo71cB+Rv=xJA@mail.gmail.com>
X-Mailman-Approved-At: Sun, 02 Nov 2025 18:18:08 +0100
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

Le Sat, Nov 01, 2025 at 10:03:59AM +0100, Simon Glass a écrit :
> Hi Raphael,
> 
> On Thu, 4 Sept 2025 at 14:53, Raphael Gallais-Pou
> <raphael.gallais-pou@foss.st.com> wrote:
> >
> > The "Display Timings" in panel-common.yaml can be provided by 2 properties
> > - panel-timing: when display panels are restricted to a single resolution
> >                 the "panel-timing" node expresses the required timings.
> > - display-timings: several resolutions with different timings are supported
> >                    with several timing subnode of "display-timings" node
> >
> > This patch update the parsing function to handle this 2 possibility
> > when index = 0.
> >
> > Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
> > Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> > ---
> >  drivers/core/ofnode.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > index e040e3f2806ffe74c58dcd82f36307351acd5a99..5a721b46e5a3214e7bd437739776362c2d22a3c9 100644
> > --- a/drivers/core/ofnode.c
> > +++ b/drivers/core/ofnode.c
> > @@ -1221,13 +1221,16 @@ int ofnode_decode_display_timing(ofnode parent, int index,
> >         int ret = 0;
> >
> >         timings = ofnode_find_subnode(parent, "display-timings");
> > -       if (!ofnode_valid(timings))
> > -               return -EINVAL;
> > -
> > -       i = 0;
> > -       ofnode_for_each_subnode(node, timings) {
> > -               if (i++ == index)
> > -                       break;
> > +       if (ofnode_valid(timings)) {
> > +               i = 0;
> > +               ofnode_for_each_subnode(node, timings) {
> > +                       if (i++ == index)
> > +                               break;
> > +               }
> > +       } else {
> > +               if (index != 0)
> > +                       return -EINVAL;
> > +               node = ofnode_find_subnode(parent, "panel-timing");
> >         }
> >
> >         if (!ofnode_valid(node))
> >
> > --
> > 2.25.1
> >
> 
> Please add a test for this in test/dm/ofnode.c

Hi Simon,

I'll gladly do that, but I haven't write and use any test in U-Boot.  So
it is a bit foggy how to implement it.

Do we want to create a fake device-tree and test each configuration or
do we want to test in the _current_ device-tree if timings are correctly
set according to the index value ?

Best regards,
Raphaël

> 
> Regards,
> Simon
> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32
