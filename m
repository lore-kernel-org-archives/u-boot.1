Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE174C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 22:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE54878D0;
	Wed, 13 Dec 2023 23:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HOBXdZaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8EC878D6; Wed, 13 Dec 2023 23:22:37 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFF8786ECA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 23:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1d93da3eb7so865415866b.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702506154; x=1703110954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mdR46GjsNHrasM3O6oq9bvkubwLW3jG2VzmrAXoJbMc=;
 b=HOBXdZaSU0HSPL8CPZLvLyW1CaLmQMIg2WmyaMny93JliYOkpb4/0rEzwjXn2yTu8y
 ynPfpuVVdoNa/yGHFv4dwnfXKsJw5x8SOmNMcXE0j7qnXNn4D7ccX2hrj08BAlrj7LIe
 jtQrLcB2nx5NL3d96sMxRuPTG/kY17AZwNxWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702506154; x=1703110954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mdR46GjsNHrasM3O6oq9bvkubwLW3jG2VzmrAXoJbMc=;
 b=AzXz90P6XIfRDvJhssJnfbaTX/Or/BGdBtvWj8d/gdTiLB9RzgvZfDfhnYaqOS5Wac
 HL8vxC3m8ZTuy1lxVj9vkN+ggWmKfNXvdnzIyDdFb965FX4CtOfOaFu15KG9oNQHEHc4
 VJ/pMlUZJupwv6rQHsSss/VWmXu64rhZ/rFwm5OZ9VZnkhq9G4Mz6Bp2W0emJnFSh39f
 pcZHkhkNl3rWr9Fil5P4hE3VD/YsI0eRO6AXdC6+eCSOW0yLOvp5fmjhX2HigqctfhjC
 1XrTmk1ccddDnHmy4in/BMEk/COpeNqYd7xlMx6lDHAN9K+1cUc9qKby1cFviA1gIXNT
 OarA==
X-Gm-Message-State: AOJu0YyByou1YE4raqFktkRUuZerrUoY9avZiFzjhGLaKZSyOeoM+CaG
 yGxl7T9W+aHgBEpScs4yBQsY6gJ8/lScsj7NcdcDDQ==
X-Google-Smtp-Source: AGHT+IGYiYDhAAu23cUOw5GLYtPWI//EUPIIHVtDg9ZBFEP3QtdfHbzR1LWJmhaFnJ+VVavnYh9Yr8Igv5a44ZxfyGs=
X-Received: by 2002:a17:906:c14b:b0:a1c:af1b:7562 with SMTP id
 dp11-20020a170906c14b00b00a1caf1b7562mr4473441ejc.62.1702506154172; Wed, 13
 Dec 2023 14:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20231210150304.124458-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ10dpyK3qyoogTaabyH0sNsXRZReCGdvVhdO=0LG2DJWw@mail.gmail.com>
 <6b56dc6f-f753-4da3-b371-4a8146d3f4e9@mailbox.org>
 <CAPnjgZ1bwt8-n=saKfdcoKOx42SdE1-t36eGazaiatzn626_ww@mail.gmail.com>
 <b09c6600-b05b-4fec-beb0-c0a9a226a507@mailbox.org>
 <CAPnjgZ0vjRjX3nQ+GU-vL6cgZN++szsS_ZEYXN1KXJD=Yxgyvw@mail.gmail.com>
 <1eeea86e-f696-4452-a160-6c5e8131f6ad@mailbox.org>
In-Reply-To: <1eeea86e-f696-4452-a160-6c5e8131f6ad@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 15:22:21 -0700
Message-ID: <CAPnjgZ14Ah=y9g-OHnRpzs5OXgTYoH=dk0obc17XcxXeatzd=g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: Poll CD in case cyclic framework is enabled
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Marek,

On Wed, 13 Dec 2023 at 14:00, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 12/13/23 20:49, Simon Glass wrote:
> > Hi Marek,
> >
> > On Wed, 13 Dec 2023 at 07:08, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 12/12/23 15:05, Simon Glass wrote:
> >>> Hi Marek,
> >>>
> >>> On Mon, 11 Dec 2023 at 12:24, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>>>
> >>>> On 12/11/23 18:52, Simon Glass wrote:
> >>>>> Hi Marek,
> >>>>>
> >>>>> On Sun, 10 Dec 2023 at 08:03, Marek Vasut
> >>>>> <marek.vasut+renesas@mailbox.org> wrote:
> >>>>>>
> >>>>>> In case the cyclic framework is enabled, poll the card detect of already
> >>>>>> initialized cards and deinitialize them in case they are removed. Since
> >>>>>> the card initialization is a longer process and card initialization is
> >>>>>> done on first access to an uninitialized card anyway, avoid initializing
> >>>>>> newly detected uninitialized cards in the cyclic callback.
> >>>>>>
> >>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>>>>> ---
> >>>>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> >>>>>> Cc: Peng Fan <peng.fan@nxp.com>
> >>>>>> Cc: Simon Glass <sjg@chromium.org>
> >>>>>> ---
> >>>>>> V2: Move the cyclic registration/unregistration into mmc init/deinit
> >>>>>> V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
> >>>>>>        does not work with structure members
> >>>>>> ---
> >>>>>>     drivers/mmc/mmc.c | 36 ++++++++++++++++++++++++++++++++++++
> >>>>>>     include/mmc.h     |  5 +++++
> >>>>>>     2 files changed, 41 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> >>>>>> index eb5010c1465..a5686dbc12e 100644
> >>>>>> --- a/drivers/mmc/mmc.c
> >>>>>> +++ b/drivers/mmc/mmc.c
> >>>>>> @@ -2985,6 +2985,22 @@ static int mmc_complete_init(struct mmc *mmc)
> >>>>>>            return err;
> >>>>>>     }
> >>>>>>
> >>>>>> +#if CONFIG_IS_ENABLED(CYCLIC)
> >>>>>> +static void mmc_cyclic_cd_poll(void *ctx)
> >>>>>> +{
> >>>>>> +       struct mmc *m = ctx;
> >>>>>> +
> >>>>>> +       if (!m->has_init)
> >>>>>> +               return;
> >>>>>> +
> >>>>>> +       if (mmc_getcd(m))
> >>>>>> +               return;
> >>>>>> +
> >>>>>> +       mmc_deinit(m);
> >>>>>> +       m->has_init = 0;
> >>>>>> +}
> >>>>>> +#endif
> >>>>>> +
> >>>>>>     int mmc_init(struct mmc *mmc)
> >>>>>>     {
> >>>>>>            int err = 0;
> >>>>>> @@ -3007,6 +3023,19 @@ int mmc_init(struct mmc *mmc)
> >>>>>>            if (err)
> >>>>>>                    pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
> >>>>>>
> >>>>>> +#if CONFIG_IS_ENABLED(CYCLIC)
> >>>>>
> >>>>> We really shouldn't be adding new #ifdefs to the code.
> >>>>>
> >>>>> If you really want to make put ->cyclic behind an #ifdef then how
> >>>>> about creating an accessor as is done in global_data.h ?
> >>>>
> >>>> That's really just working around the underlying issue, which is that
> >>>> this does not compile:
> >>>>
> >>>> struct foo {
> >>>> #if CONFIG_IS_ENABLED(STUFF)
> >>>>      type member;
> >>>> #endif
> >>>> ...
> >>>> };
> >>>>
> >>>> type fn() {
> >>>> ...
> >>>> if (CONFIG_IS_ENABLED(STUFF))
> >>>>      access struct->member;
> >>>> ...
> >>>> }
> >>>>
> >>>> Accessor won't make it any better, would it ? It would only attempt to
> >>>> hide the error and make the code more fragile, i.e. this:
> >>>>
> >>>> accessor(struct)
> >>>> {
> >>>> type fn() {
> >>>> if (CONFIG_IS_ENABLED(STUFF))
> >>>>      return access struct->member;
> >>>> else
> >>>>      return 0;
> >>>> }
> >>>>
> >>>> }
> >>>>
> >>>> type fn() {
> >>>> ...
> >>>>      accessor(struct);
> >>>> ...
> >>>> }
> >>>>
> >>>> I suspect it also won't compile for one thing, and for the other, it
> >>>> really just hides the issue.
> >>>
> >>> No, I mean like this:
> >>>
> >>> #ifdef CONFIG_ACPI
> >>> #define gd_acpi_ctx() gd->acpi_ctx
> >>> #define gd_acpi_start() gd->acpi_start
> >>> #define gd_set_acpi_start(addr) gd->acpi_start = addr
> >>> #else
> >>> #define gd_acpi_ctx() NULL
> >>> #define gd_acpi_start() 0UL
> >>> #define gd_set_acpi_start(addr)
> >>> #endif
> >>>
> >>> The header file has #ifdefs but not the C files.
> >>
> >> Hmmm, I can't say I like that either, that just adds more indirection
> >> into the code and makes it harder to read in my opinion .
> >
> > Sure, it isn't for everyone. But adding new #ifdefs is really grim
> > IMO. Maybe you will get used to it?
>
> I don't really want to get used to such workarounds which only obfuscate
> the code and decrease readability.
>
> > Maybe there is a better approach?
>
> I am open to suggestions . If there are none, I would say go with the
> ifdefs .

OK

Regards,
Simon
