Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855E9C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 18:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C4B80BA8;
	Thu, 24 Apr 2025 20:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LMS5vFSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70828819FC; Thu, 24 Apr 2025 20:31:55 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139EE803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso248235066b.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745519512; x=1746124312; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lYTivpyMcKjY9DVshLe04f15bk/dD7jYK+nf+i4DPNg=;
 b=LMS5vFSYo5Ck54Dm6PIJFx5bUn8R5lf0e20SOxwGaxfkxDlwMgRJq8GCbv9EwEIJ8U
 9BoDaFzy+StrmJoXF6de1QwncjKbP8Uj1Xt2//iZ4XyZPO9jyX/I7aZIMQ3rM5oEm7D+
 HIGOGb4zesN4kaLCMvP6ooquXATnM3vO5v8ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519512; x=1746124312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYTivpyMcKjY9DVshLe04f15bk/dD7jYK+nf+i4DPNg=;
 b=M2v2FS06KbzZm9r6jH3qFJXms6zM+gqcqk8Gl41QRn+/qTaC53zwvEpji2sb8X/wbM
 7vt/VP+GzFGq0uw2aYk0HyXeWkKRNjwqfn7I/86Hs04dTZkqkMHVwfLRsInWapsHX8H8
 T/YFt//qSZH2yDxGKRJdfuQIA6zP+emj2wwCEh5v9dKFRWeJFXp6ucMCC/SICqbSJZrB
 PLNPtciah9r7pZ7LgRSbh90LNRnk3jiNZPOswzLVRSuOjH1+KyqZ4v8WgW6nOI0SG5BT
 F3A7OoFo2MYPlfuwboNrLO4w/osDSoe1Xojh83G0zw4dGc2DUPovsNCCZx1T/5FRZuH4
 PioA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmgMTlObqq9VKarMxR4uMpd40uQcR+bin97WNtZhb+EMfFq685jANOPa43RF7QhbkY01waKeA=@lists.denx.de
X-Gm-Message-State: AOJu0YzPRDHXs+xfbrp4un2wKDeAbKLAjs9LIvXEljRLoGBV3XnQ5dgo
 O8H4zg2y6HYjHD52lb1PoKWUcFeIODHmLmmLrvfkLGqOPJl1/2Ium/XZOXfblAZ49NYKdCRuCcg
 OqzL2GrcZMkS8wZkRQQstCL6F/WDOgMVEvK7b
X-Gm-Gg: ASbGncuorayA8NhkoJ21VJPN8iykjqopxgG3vE6lromyznyQYLcRpWCa1+bLwymh+3v
 3l2IfCg+1UKaTu0RS+K2OQ44cTQgf+vGFSnp5UWLhoRk46BrxRl1Y6kUbgULWrqrH0AO+l7T3i6
 YE4zgmvES8nVLG7mwmB7jeOZLiMAf3kPnooA==
X-Google-Smtp-Source: AGHT+IGrnhrqqFhZa8EtK9AprgvS8qKynFkJcUv/NVIQ3yHlB98jQjcB4SrCeCl/1v6ZKq0kFr19JnswB6+zSDuU5ok=
X-Received: by 2002:a17:907:3d92:b0:aca:a35e:59fe with SMTP id
 a640c23a62f3a-ace570e3038mr378123766b.1.1745519512499; Thu, 24 Apr 2025
 11:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <CAFLszTinU=6v+3OyaH0pp8snYm9BgfVrU_+35x2Az7fVs_CfYw@mail.gmail.com>
 <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
In-Reply-To: <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Apr 2025 12:31:38 -0600
X-Gm-Features: ATxdqUH1BrqCZgsKcmLCkr-HHUdv_YBQF3z7odb93yOUUE_oUW0dlT84PQAfrNI
Message-ID: <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
To: Martin Schwan <M.Schwan@phytec.de>
Cc: Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
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

Hi Martin,

On Thu, 24 Apr 2025 at 06:43, Martin Schwan <M.Schwan@phytec.de> wrote:
>
> Hi Simon,
>
> thanks for the review and sorry for my delayed reply.
>
> On Mon, 2025-04-14 at 05:32 -0600, Simon Glass wrote:
> > Hi Martin,
> >
> > On Wed, 29 Jan 2025 at 07:25, Martin Schwan <m.schwan@phytec.de>
> > wrote:
> > >
> > > Add a bootmeth driver which supports booting A/B system with RAUC
> > > as
> > > their update client.
> > >
> > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > ---
> > >  boot/Kconfig         |  11 ++
> > >  boot/Makefile        |   1 +
> > >  boot/bootmeth_rauc.c | 408
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 420 insertions(+)
> >
> > This looks fine to me. Just some nits below.
> >

[..]

> > > +
> > > +       partitions = env_get("rauc_partitions");
> > > +       if (!partitions)
> > > +               return log_msg_ret("env", -ENOENT);
> > > +       partitions_list = str_to_list(partitions);
> > > +
> > > +       slots = env_get("rauc_slots");
> > > +       if (!slots)
> > > +               return log_msg_ret("env", -ENOENT);
> > > +       slots_list = str_to_list(slots);
> > > +
> > > +       boot_order = env_get("BOOT_ORDER");
> >
> > Environment variables should be in lower case.
>
> Unfortunately, we are bound to the naming RAUC uses for these
> environment variables, which is upper case. See
> https://rauc.readthedocs.io/en/latest/integration.html#set-up-u-boot-boot-script-for-rauc

Can't you change it, since you are introducing new support here?

If not, then you could perhaps set the env variables to lowercase when
you find uppercase variables? I suppose that would require updating
the client to do the same thing too?

It would be very confusing for a user to have upper-case variables for
some things.

>
> >
> > > +       if (!boot_order) {
> > > +               if (env_set("BOOT_ORDER", slots))
> > > +                       return log_msg_ret("env", -EPERM);
> > > +       }
> > > +       priv->boot_order = strdup(boot_order);
> > > +
> > > +       default_tries = env_get_ulong("rauc_slot_default_tries",
> > > 10, 3);
> > > +       for (i = 0; slots_list[i] != NULL; i++) {
> > > +               sprintf(boot_left, "BOOT_%s_LEFT", slots_list[i]);
> >
> > same here

[..]

Regards,
Simon
