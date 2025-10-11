Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9042DCCD183
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 07:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A7A983CEE;
	Sat, 11 Oct 2025 09:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ScyX/rve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D281183D40; Sat, 11 Oct 2025 09:21:12 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CA0583C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 09:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6318855a83fso5998775a12.2
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760167270; x=1760772070; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yWeV+fVOzYdVwRibt5O6ks4p/pjwkwDY1nQkNpevLGo=;
 b=ScyX/rve4iUBuOKK17CpQYZzNNTNgh+yerwhROG7oISjKvi3NcXqk0Lnx1/p7oZt3M
 WFKFhID36s9Je06y6d4/Xll89NYjAKucoQfOgK87bgKm71EiFv8SRBuaYiVTSwtDDuPB
 tJnUyt9JLQMv8KbQQogYnVm8k5sTK7ryGiQkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760167270; x=1760772070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yWeV+fVOzYdVwRibt5O6ks4p/pjwkwDY1nQkNpevLGo=;
 b=VJK2Bcr72PsTW0uEEKHlMIp1NCLgh++kF6MFIeC407TZRmGhXDaq+ufx0UGvtjfert
 j4OfDTpGedeGP6WwUa5qjMtrvhYQa2QmogiTugE0IeZD4k5Tef4OXXnyv0Ewi1rMnWpx
 mmr43FTzPcTaKpmWAm62pItzrqaBy4URsZ06CnYtzxooTZebpooocBU0Ph+OIW3v+5Jg
 E+eyy+7k5U0mybSMXqYiMmG1ibP3gzZjHnPsikY4GLIHuYv7YFID4+mrVsNkreS8o1UE
 06B9afytWS1ZDF1d/FxtMODm3KYEMVTqaiHDJS0Z9U2mnRGigA/cvk64t8Kms+4h7dYz
 FuNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0PN186qjM5pQ06O//qf92KTgHChV0oUbBKyeBqSGK01GzUqGnCb2aEcuH2MuabweyVuK427s=@lists.denx.de
X-Gm-Message-State: AOJu0YywWisP/9qsgSqGiwx+JoLK9UIqoqqDnOMglD17esw4FX2KrpCF
 6xYpSJM3f9Mtgyhw1Pwr7/ogUx6Mr4TIAKLrVYBzzfKndmF4FpdwGk2WIXzJOc+kYZqGRaWufly
 J4Uf9+o5+ypINm5O7FEvNclYk2kQi3WjgFeRJv0h/
X-Gm-Gg: ASbGncvUj/vvMAU+gscg0yvnDCTmG2+hW/D6sdX2ilRw9ItBQDgkBcumsZm/z7mh+nM
 vYMMC18c6vewyMQtRN7gsUsr+1fJW2WtcLT2YQpywPP+PsO4YqfrO0deXVJHcc4zU+OS4W92NGR
 Cj+q/OMVVoLqLc/mQ/Liir+kqvp9b9wPT0t2O47ZLyAVNy992LbfRFGkoYFkE0DxmtVxkMSsu0c
 ZB+R7NKAon5EYeiMT6jx7GmFS0HnwlrxzHUDjkocl/bJJ8=
X-Google-Smtp-Source: AGHT+IHpR896IKtDYCC1rMDtV2t5vO+7godM4bgKfPvmq+RTf/vCs2HrIov7eKXih+SkiXGFiskXBv9WFG+v0lCajCg=
X-Received: by 2002:a05:6402:5cb:b0:634:518b:c431 with SMTP id
 4fb4d7f45d1cf-639d5b8af38mr10050005a12.11.1760167269839; Sat, 11 Oct 2025
 00:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-3-e09b39e54de5@bootlin.com>
 <CAFLszTg-i7cDiN57pqat=bYwqucCOGqW6oh1CvnJz7-UhKaCwA@mail.gmail.com>
 <20251010153500.5bec4e20@kmaincent-XPS-13-7390>
In-Reply-To: <20251010153500.5bec4e20@kmaincent-XPS-13-7390>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Oct 2025 08:20:58 +0100
X-Gm-Features: AS18NWDh2hf_wq6eD6Rl6VU47qCilzJKg69B3kXmuJkks4hsds6Y9oYu8sz8INs
Message-ID: <CAFLszTjLmq0r9uTYR-irzzSN63G1Lpd0iWiwW9npLSraNB1Y_g@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] boot: Add UCLASS support for extension boards
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi Kory,

On Fri, 10 Oct 2025 at 14:35, Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> On Fri, 10 Oct 2025 12:13:11 +0100
> Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Kory,
> >
> > On Thu, 9 Oct 2025 at 15:51, Kory Maincent (TI.com)
> > <kory.maincent@bootlin.com> wrote:
> > >
> > > Introduce UCLASS-based extension board support to enable more
> > > standardized and automatic loading of extension board device tree
> > > overlays in preparation for integration with bootstd and pxe_utils.
> > >
> > > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
>
> ...
>
> > > +
> > > +#include <alist.h>
> > > +#include <command.h>
> > > +#include <dm/device-internal.h>
> > > +#include <dm/lists.h>
> > > +#include <dm/uclass.h>
> > > +#include <env.h>
> > > +#include <extension_board.h>
> > > +#include <fdt_support.h>
> > > +#include <malloc.h>
> > > +#include <mapmem.h>
> >
> > nit: Please correct the ordering
> >
> > https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files
>
> Oh didn't know this rule.
>
> > > +
> > > +DECLARE_GLOBAL_DATA_PTR;
> > > +
> > > +/* For now, bind the extension device manually if none are found */
> > > +static struct udevice *extension_get_dev(void)
> >
> > This should really return the error rather than gobbling it. Normally
> > we use 'int' as the return value, so:
> >
> > static int extension_get_dev(struct udevice *devp)
>
> You mean rather this then:
> static int extension_get_dev(struct udevice **devp)

Yes that's right. In fact you can probably drop this function and use
'uclass_first_device_err(UCLASS_EXTENSION, &dev)' ? The pre-relocation
check shouldn't be needed.

>
> >
> > > +{
> > > +       struct driver *drv = ll_entry_start(struct driver, driver);
> > > +       const int n_ents = ll_entry_count(struct driver, driver);
> > > +       struct udevice *dev;
> > > +       int i, ret;
> > > +
> > > +       /* These are not needed before relocation */
> > > +       if (!(gd->flags & GD_FLG_RELOC))
> > > +               return NULL;
> > > +
> > > +       uclass_first_device(UCLASS_EXTENSION, &dev);
> > > +       if (dev)
> > > +               return dev;
> > > +
> > > +       /* Create the extension device if not already bound */
> > > +       for (i = 0; i < n_ents; i++, drv++) {
> > > +               if (drv->id == UCLASS_EXTENSION) {
> >
> > If this is really what you want, you might as well just put a
> > U_BOOT_DRVINFO() declaration in the source. Then driver model does it
> > for you. We are supposed to use the devicetree, but it seems that that
> > idea is WIP at best.
>
> Oh I will use this MACRO instead.
>
> > > +int dm_extension_scan(void)
> > > +{
> > > +       struct alist *extension_list = dm_extension_get_list();
> > > +       struct udevice *dev = extension_get_dev();
> > > +       const struct extension_ops *ops;
> > > +
> > > +       if (!dev || !extension_list)
> > > +               return -ENODEV;
> > > +
> > > +       ops = device_get_ops(dev);
> >
> > extension_get_ops()
>
> Is it really needed as it is used only once.

Not needed, just a convention, which I'd like to keep if we can.

>
> >
> > > +       if (!ops->scan)
> > > +               return -ENODEV;
> >
> > That is normally -ENOSYS - at this point we have a device, it's just
> > that it doesn't have the require method.
> >
> > But it seem strange to me to allow a device that has no means to scan.
>
> Yes, maybe this check is useless indeed, as it is the only action done by the
> board code.
>
> ...
>
> > > @@ -13,9 +14,28 @@ LIST_HEAD(extension_list);
> > >  static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
> > >                              int argc, char *const argv[])
> > >  {
> > > +#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
> > > +       struct alist *dm_extension_list;
> > > +#endif
> > >         struct extension *extension;
> > >         int i = 0;
> > >
> > > +#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
> >
> > Is it possible to use if() ? Perhaps at the end of your series, when
> > all the conversions are done and you can delete the old code?
>
> As all these macro check are removed when the conversion is done I didn't
> bother to use if() because I would have to take care of define but not used
> warnings.

Ah OK, then it doesn't matter. I had forgotten that.

>
> ...
>
> > > +/**
> > > + * dm_extension_get_list - Get the extension list
> > > + * Return: The extension alist pointer, or NULL if no such list exists.
> >
> > caller must free the list?
>
> No.

OK, then perhaps just note that the caller must not free it

>
> > > + */
> > > +struct alist *dm_extension_get_list(void);
> >
> > Is this the list of all extensions from all extension devices?
>
> yes.
>
> > > +/**
> > > + * dm_extension_apply - Apply extension board overlay to the devicetree
> > > + * @extension_num: Extension number to be applied
> > > + * Return: Zero on success, negative on failure.
> > > + */
> > > +int dm_extension_apply(int extension_num);
> >
> > The uclass should have a method like apply(struct uclass *dev, int
> > extension_num). Is the numbering global across all devices?
>
> We currently support only one extension driver loaded at a time, therefore we
> don't currently need this uclass parameter.
> We will change the API when we will have several scan method possible at the
> same time but I can't test it for now. I don't think we will have such cases
> soon and maybe the devicetree WIP support will be ok at that time.

OK, I hadn't picked that up but it makes sense. We can always change
it later, as you say. But I would like to see an apply() method in
extension_ops, so that it actually looks like a driver.

>
> > > +
> > > +/**
> > > + * dm_extension_apply_all - Apply all extension board overlays to the
> > > + *                         devicetree
> > > + * Return: Zero on success, negative on failure.
> > > + */
> > > +int dm_extension_apply_all(void);
> > > +
> > >  struct extension {
> > >         struct list_head list;
> > >         char name[32];
> > > @@ -20,6 +62,28 @@ struct extension {
> > >         char other[32];
> > >  };
> >
> > At some point in this series, please comment this struct
>
> Ok I will add a patch to add comment on this.
>
> >
> > >
> > > +struct extension_ops {
> > > +       /**
> > > +        * scan - Add system-specific function to scan extension boards.
> > > +        * @dev: extension device to use
> >
> > need to document extension_list here - I believe it is a list of
> > struct extension? Or is it struct extension * ?
>
> Oop some code leftover here.
>
> >
> > > +        * Return: The number of extension or a negative value in case of
> > > +        *         error.
> > > +        */
> > > +       int (*scan)(struct alist *extension_list);
> >
> > This is a bit of a strange uclass function! Since you are probing
> > drivers in this uclass, you can iterate through them using
> > uclass_foreach...() etc.
> >
> > I am guessing that you just need to add a struct udevice * as the first arg.
>
> As I said there is only one drivers loaded at a time supported for now.

There are a lot of things with only one device / driver, but passing
the device in is how these work. If you don't want to do this, we can
always worry about it later, if needed.

Regards,
Simon
