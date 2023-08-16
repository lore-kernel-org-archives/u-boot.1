Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB0C27C42
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 22:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A664A86A4A;
	Thu, 17 Aug 2023 00:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VERyxLPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E1A86A50; Thu, 17 Aug 2023 00:29:51 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E63786A48
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 00:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so737980a12.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692224984; x=1692829784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LLKukEQRGfD/o2Ie1VCaALePFR3QNl7W6j1I6gacZVI=;
 b=VERyxLPtJl4mNe9YIw6EaPutBchgmBuj2YmFY60Zikl/QZSeKRuANOAw2gnN2INmXQ
 ZS1IL7XiJY8/NBUwcase5j7piQ154D+MY1eJLRPbcfai/D08I7Idi75L1j9DvbYd4Jx+
 i0Zps1tvHZbpVkQjtyMvWulTEh7cRclCCP2II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692224984; x=1692829784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LLKukEQRGfD/o2Ie1VCaALePFR3QNl7W6j1I6gacZVI=;
 b=TwtYX7D8bCqzYmdX8H1T4Ljz0iWr0U3LiTD9WFN9e1wMoywI9uZmm4iqHT5q4kZ5n2
 FqmLJmgR3i5DQKgMSigs/CQ4U+H3O4TSVv4P97YT+A8kC2DLIeu27wqp03dKqvzHytjn
 /NVK6R7PRjvvN1eN2piGIkpj4DWdRZM2TDKbXbmz14I6jQhUEbn05PdqnA5jRelMYjEN
 e70Oo8ibTP6CyaKT3VlJJ3E5bjPMDh03MdWRgUdsTRVQeMeICwkdph3KZuhbE/MRNg3X
 CtcxUIn2mw4YufX435BO3q0vBmPEH9YCrvBAswA8wzOZCU7wVS7FasvPVejVeL8JSvtG
 YWHg==
X-Gm-Message-State: AOJu0YwEMahxodiXs4bilpvzrucu9S8GHQqAYIqYdBNokW1AfS6BK/8b
 fPBNY3Gtw2f7S7GUMAhRRJjpn8eZ7/29+1YwoapXjpP4e/DN09WH26ggRg==
X-Google-Smtp-Source: AGHT+IHVreU9eXVzf14HeTRvwVCBL0tdk3TGXhSCv6gLq9FAM2pviZi+AyKnxkuNRweiKn1MmQsKQFw4NxiXpWqfTyg=
X-Received: by 2002:a05:6402:1219:b0:525:b29d:8dc8 with SMTP id
 c25-20020a056402121900b00525b29d8dc8mr1173576edw.5.1692224983811; Wed, 16 Aug
 2023 15:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230805133208.788000-1-jonas@kwiboo.se>
 <CAPnjgZ216Mm5cv=NhmPdqGiGKjzc3fte4fVAcMLYwwZhq6gbVA@mail.gmail.com>
In-Reply-To: <CAPnjgZ216Mm5cv=NhmPdqGiGKjzc3fte4fVAcMLYwwZhq6gbVA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 16 Aug 2023 16:29:32 -0600
Message-ID: <CAPnjgZ0yq8-pm-HQuKy2vUK5i92zmJZwsYxHeoS-4e51ERZcNg@mail.gmail.com>
Subject: Re: [RFC] dm: core: Report bootph-pre-ram/sram node as pre-reloc
 after relocation
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
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

Hi Jonas,

On Tue, 8 Aug 2023 at 20:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Jonas,
>
> On Sat, 5 Aug 2023 at 07:32, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Devices for nodes with e.g. bootph-pre-ram are initialized three times.
> > 1. At SPL stage (always bind and probe only if used)
> > 2. At U-Boot proper pre-reloc (always bind and probe)
> > 3. At U-Boot proper normal (always bind and probe only if used)
> >
> > Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram prop
> > with a pre-reloc status only after U-Boot proper pre-relocation stage.
> > This prevents the device from being probed at U-Boot proper pre-reloc.
> >
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> > I am not sure if U-Boot proper pre-reloc behaves like this by design and
> > if there is some other way to signal that a device should not be probed
> > during U-Boot proper pre-reloc stage if it has been probed at SPL stage.
> >
> > For my use-case I added bootph-pre-ram prop to my RK8xx device node to
> > make the PMIC usable in SPL. However, I have no need for this device to
> > probe at U-Boot proper pre-reloc stage just after jumping out of TF-A.
> > And moments later bind and probe yet again at U-Boot proper normal stage.
> >
> > The bootph-pre-ram prop was used to have the device usable in SPL, else
> > I could have used bootph-all or added bootph-some-ram prop to indicate
> > use at U-Boot proper pre-reloc stage.
>
> This is changing how things work...we really need to have something
> explicit to use this new behaviour. Perhaps we can augment the binding
> in some way?

I had another look at this. The binding seems to be silent on this
point, so I believe this patch is correct.

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> >
> >  drivers/core/ofnode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > index 8df16e56af5c..ebd5a408ae58 100644
> > --- a/drivers/core/ofnode.c
> > +++ b/drivers/core/ofnode.c
> > @@ -1353,7 +1353,7 @@ bool ofnode_pre_reloc(ofnode node)
> >          */
> >         if (ofnode_read_bool(node, "bootph-pre-ram") ||
> >             ofnode_read_bool(node, "bootph-pre-sram"))
> > -               return true;
> > +               return !!(gd->flags & GD_FLG_RELOC);
>
> I believe that the compiler knows how to convert 'gd->flags &
> GD_FLG_RELOC' into a bool, so !! is not needed.
>
> >
> >         if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
> >                 /* detect and handle old tags */
> > --
> > 2.41.0
> >

Regards,
Simon
