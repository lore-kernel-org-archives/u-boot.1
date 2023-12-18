Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143CDC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A438387E4C;
	Mon, 18 Dec 2023 16:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V5zM7fbr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C2B87E0A; Mon, 18 Dec 2023 16:02:45 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD5387E38
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dbcfb7e8ad0so2364871276.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7IJ4deCYGILlw7sVRIpe6h/1k7WrI0ILkWFpV1nyJEQ=;
 b=V5zM7fbrNHXMJiS5SlGU0m4mlwNtcDajSag6iE3mS/EvQD6QbUoyWfCGIaSAMPqY3h
 C6sB6bDz3S1qYZ8asgLOXv9iqdbr5xstsh0jhaopFF66Z8oSAtBOt6JEMouvMkBhYL0t
 tL04iZ3KRYMk4tbdElEzOTnyUeNRNC5iF/gDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7IJ4deCYGILlw7sVRIpe6h/1k7WrI0ILkWFpV1nyJEQ=;
 b=HTU6E64tXiJ3bBYj+Stkhn7MvPBLz7pW3xcvdZgdzpyoR/Cq6SvRTPdrgjrFA+t+S4
 eMrYwFbI8dNu4QU8ZtgAflCnTB6C21rfWWVdhHDkd6ZYhWNw8fJ3r0UHTLv4yom/nTSi
 nW/ReRipPf25miS9IXUbo5ilIr2OcLY5hHbNvLjNDYq1LA3yuvg2Os9anzteptSGD5Hi
 WzG0GAc+XlAoGiI/x0vOiFeOHXMwoleppX1CssNVKp0dciJKpx3Qg62yWw4b2+8FDNtj
 Tp5mlu6AfavCpCpXjutngnv5P8+9uF5waN1snnRPyzM8Sm6LQhhDDX/IdWqEt/7oLzUk
 wv0A==
X-Gm-Message-State: AOJu0YwRgjzMSXXsBwCQj920J2gpJVXNipJfn9Z/d+2NuK8JgJ0Mh25F
 1Jn6pzSPCHhf4FgxUUqRktmXFkV2XKfVwPpNmZ0HKP5QCthynEQrJeg=
X-Google-Smtp-Source: AGHT+IEa8B8BM3z27eOs0BY6rWysSp0AoHZ//HntNugz3dmc2iTPQLKDkQ+tsgkLzH7+warQgj4qAP+anGSd8hHyMXI=
X-Received: by 2002:a25:3144:0:b0:da0:93bf:2691 with SMTP id
 x65-20020a253144000000b00da093bf2691mr8385177ybx.26.1702911752805; Mon, 18
 Dec 2023 07:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Y5Dzhp2c5qsoDEjY-w8NsueEHgvCSfTEbtEOPMTJ9wA@mail.gmail.com>
 <CAC_iWj+zd5X7FiM7XQVPSj9a7cwxpo-VHR6TV36y98ust-Ckpg@mail.gmail.com>
 <CAPnjgZ1b3tSR3nh0H6Xu1RCp=Zid+TXfUVr0C4HvDtqWvyiMog@mail.gmail.com>
 <CAC_iWjLJo7zNBJ3N45ctDeuJSzKgQiZqQEQ-kRUFurehXpcArg@mail.gmail.com>
In-Reply-To: <CAC_iWjLJo7zNBJ3N45ctDeuJSzKgQiZqQEQ-kRUFurehXpcArg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:50 -0700
Message-ID: <CAPnjgZ3BWYKiOowJV83WUgKmY3dWZmUy2a0fJ75=88Sb+OpS1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] smbios: Simplify reporting of unknown values
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 u-boot@lists.denx.de
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

Hi Ilias,

On Wed, 13 Dec 2023 at 15:38, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 14 Dec 2023 at 00:22, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 13 Dec 2023 at 14:37, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Wed, 13 Dec 2023 at 21:52, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Thu, 7 Dec 2023 at 02:19, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > If a value is not valid during the DT or SYSINFO parsing,  we explicitly
> > > > > set that to "Unknown Product" and "Unknown" for the product and
> > > > > manufacturer respectively.  It's cleaner if we move the checks insisde
> > > > > smbios_add_prop_si() and provide an alternative string in case the
> > > > > primary is NULL or empty
> > > > >
> > > > > pre-patch dmidecode
> > > > > <snip>
> > > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > > System Information
> > > > >         Manufacturer: Unknown
> > > > >         Product Name: Unknown Product
> > > > >         Version: Not Specified
> > > > >         Serial Number: Not Specified
> > > > >         UUID: Not Settable
> > > > >         Wake-up Type: Reserved
> > > > >         SKU Number: Not Specified
> > > > >         Family: Not Specified
> > > > >
> > > > > [...]
> > > > >
> > > > > post-patch dmidecode:
> > > > >
> > > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > > System Information
> > > > >         Manufacturer: Unknown
> > > > >         Product Name: Unknown
> > > > >         Version: Unknown
> > > > >         Serial Number: Unknown
> > > > >         UUID: Not Settable
> > > > >         Wake-up Type: Reserved
> > > > >         SKU Number: Unknown
> > > > >         Family: Unknown
> > > > > [...]
> > > > >
> > > > > While at it make smbios_add_prop_si() add a string directly if the prop
> > > > > node is NULL and replace smbios_add_string() calls with
> > > > > smbios_add_prop_si(ctx, NULL, ....)
> > > > >
> > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > ---
> > > > > Changes since v2:
> > > > > - refactor even more code and remove the smbios_add_string calls from the
> > > > >   main code. Instead use smbios_add_prop() foir everything and add a
> > > > >   default value, in case the parsed one is NULL or emtpy
> > > > > Changes since v1:
> > > > > - None
> > > > >
> > > > >  lib/smbios.c | 73 +++++++++++++++++++++++++---------------------------
> > > > >  1 file changed, 35 insertions(+), 38 deletions(-)
> > > > >
> > > >
> > > > I actually think we should just stop here and first write a test for
> > > > what we already have. I can take a crack at it if you like?
> > >
> > > I don't mind.  As I said in a previous email I'd rather do it after
> > > the refactoring you had in mind. But I don't see why that should stop
> > > the current patch from going forward.
> >
> > OK, well if this series could be simplified, I don't mind either. But
> > at present it is complicated and I think it really needs a test.
> >
> > >
> > > >
> > > > > diff --git a/lib/smbios.c b/lib/smbios.c
> > > > > index d7f4999e8b2a..444aa245a273 100644
> > > > > --- a/lib/smbios.c
> > > > > +++ b/lib/smbios.c
> > > > > @@ -102,9 +102,6 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
> > > > >         int i = 1;
> > > > >         char *p = ctx->eos;
> > > > >
> > > > > -       if (!*str)
> > > > > -               str = "Unknown";
> > > > > -
> > > > >         for (;;) {
> > > > >                 if (!*p) {
> > > > >                         ctx->last_str = p;
> > > > > @@ -134,11 +131,18 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
> > > > >   *
> > > > >   * @ctx:       context for writing the tables
> > > > >   * @prop:      property to write
> > > >
> > > > which can now be NULL?
> > >
> > > No, it can't because smbios_add_string can't do that. See commit 00a871d34e2f0a.
> > > But instead of checking it here, I moved the code around and
> > > smbios_add_string is only called from smbios_add_prop_si instead of
> > > calling it on each failure of smbios_add_prop_si(). In that function,
> > > we make sure the value isn't NULL, apart from the ->get_str sysinfo
> > > calls -- none of these currently returns null though. I can move the
> > > checking back to where it was if to shield us again dump 'get_str'
> > > implementations, or in the future fix smbios_add_string properly, but
> > > that's not the point of this patch.
> >
> > My point was that you have code to check for !prop and do something:
> >
> > if (!prop)
> >     return smbios_add_string(ctx, dval);
> >
> > Before, we needed prop (at least if OF_CONTROL), but now prop can be
> > NULL, so you should update the comment to mention that and explain
> > what it means.
>
> Sure
>
> >
> > >
> > > >
> > > > > + * @dval:      Default value to use if the string is not found or is empty
> > > > >   * Return:     0 if not found, else SMBIOS string number (1 or more)
> > > > >   */
> > > > >  static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
> > > > > -                             int sysinfo_id)
> > > > > +                             int sysinfo_id, const char *dval)
> > > > >  {
> > > > > +       if (!dval || !*dval)
> > > > > +               dval = "Unknown";
> > > >
> > > > You shouldn't need this, right? It is already the default value.
> > >
> > > Unless someone misuses smbios_add_prop_si() with both the prop and
> > > dval being NULL. Also see above.
> >
> > Don't allow that, then?
>
> But I am not allowing it. Instead of returning an error though we
> implicitly set it to unknown, which is exactly what we used to do.

Either:
- document that dval can be NULL
- don't handle it being NULL

I prefer the latter, since there are two levels of default with this code.

>
> >  It seems strange to have a default value for the default value.
>
> That's how smbios_add_string works now. Since Heinrich found that
> problem we should eventually fix smbios_add_string() to return and
> error on NULL ptrs and empty strings . But the point of this patchset
> is to clean up the random ad-hoc calls of it, not fix it (yet)

OK...

>
> >
> > >
> > > >
> > > > > +
> > > > > +       if (!prop)
> > > > > +               return smbios_add_string(ctx, dval);
> > > > > +
> > > > >         if (sysinfo_id && ctx->dev) {
> > > > >                 char val[SMBIOS_STR_MAX];
> > > > >                 int ret;
> > > > > @@ -151,8 +155,8 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
> > > > >                 const char *str;
> > > > >
> > > > >                 str = ofnode_read_string(ctx->node, prop);
> > > > > -               if (str)
> > > > > -                       return smbios_add_string(ctx, str);
> > > > > +
> > > > > +               return smbios_add_string(ctx, str ? str : dval);
> > > > >         }
> > > > >
> > > > >         return 0;
> > > > > @@ -161,12 +165,15 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
> > > > >  /**
> > > > >   * smbios_add_prop() - Add a property from the devicetree
> > > > >   *
> > > > > - * @prop:      property to write
> > > > > + * @prop:      property to write. The default string will be written if
> > > > > + *             prop is NULL
> > > > > + * @dval:      Default value to use if the string is not found or is empty
> > > > >   * Return:     0 if not found, else SMBIOS string number (1 or more)
> > > > >   */
> > > > > -static int smbios_add_prop(struct smbios_ctx *ctx, const char *prop)
> > > > > +static int smbios_add_prop(struct smbios_ctx *ctx, const char *prop,
> > > > > +                          const char *dval)
> > > > >  {
> > > > > -       return smbios_add_prop_si(ctx, prop, SYSINFO_ID_NONE);
> > > > > +       return smbios_add_prop_si(ctx, prop, SYSINFO_ID_NONE, dval);
> > > > >  }
> > > > >
> > > > >  static void smbios_set_eos(struct smbios_ctx *ctx, char *eos)
> > > > > @@ -228,11 +235,9 @@ static int smbios_write_type0(ulong *current, int handle,
> > > > >         memset(t, 0, sizeof(struct smbios_type0));
> > > > >         fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
> > > > >         smbios_set_eos(ctx, t->eos);
> > > > > -       t->vendor = smbios_add_string(ctx, "U-Boot");
> > > > > +       t->vendor = smbios_add_prop(ctx, NULL, "U-Boot");
> > > >
> > > > What is this doing exactly? I don't really understand this change.
> > >
> > > Re-read the patch description please, it's explained in the last paragraph.
> > >
> > > >
> > > > >
> > >
> > > [...]
> > >
> > > > > 2.40.1
> > > > >
> > > >
> > > > From my understanding, the only thing your fallback adds is the
> > > > manufacturer ('vendor' from DT compatible = "vendor,board"), and the
> > > > product (from DT model = "..."). This is an awful lot of code to make
> > > > that change and it seems very, confusing to me.
> > >
> > > Can we please comment on the current patchset? Future history and
> > > digging becomes a nightmare otherwise.
> > >
> > > >
> > > > Instead, can you do something like:
> > > >
> > > > if (!IS_ENABLED(CONFIG_SYSINFO)) {
> > >
> > > That beats the purpose of the series though, we want this as a
> > > *fallback* not disabled in the defconfig.
> > >
> > > >    const char *compat = ofnode_read_string(ofnode_root(), "compatible");
> > > >    const char *model = ofnode_read_string(ofnode_root(), "model");
> > > >    const *p = strchr(compat, ',');
> > >
> > > No. This is just a quick and dirty patch that allows you to split on
> > > the first comma. On top of that it won't work for cases like 'model'
> > > which, most of the times, only has a single value (which is again
> > > explained in the patch description) and you have to add a bunch of ifs
> > > on the code above. You could only parse compatible only, but model
> > > tends to be way more accurate than the one added in the compatible
> > > node. The first is a full description of the device while the latter
> > > is just a trigger for driver probing etc.
> > >
> > > random example
> > > model = "Socionext Developer Box";
> > > compatible = "socionext,developer-box", "socionext,synquacer";
> >
> > But your code does the same as my fragment above, doesn't it? Only the
> > compatible string is split, and only the first part (before the ',')
> > is used.
> >
> > For the model, the whole string is used,
> >  so having a function to split
> > the string, which doesn't have a separator in it, seems unnecessary.
>
> No, it's not. the spec says model = <manufacturer, model>. Some of the
> existing DTs follow that pattern. In that case, you need to split
> those as well and that code would start to look really ugly and non
> extendable. NXP and Qualcomm boards are just some examples

Oh that's interesting, for example:

model = "Qualcomm Technologies, Inc. SM8550 QRD";

But I don't actually see any use of 'model' in Linux that has a
vendor,model approach. Also the existing values are clearly indented
for display to the user. I wonder if we should change the spec at this
point?

>
> >
> > I am not talking about the end result, just trying to make the code
> > easier to understand. It is very complex right now.
>
> The function has a pretty clear comment on what it tries to do.
> Also if we do what you suggest, adding chassis-id would mean that we
> need another round of strchrs and ifs and who knows what else.  With
> the current patch, you just need to add an entry to the array
> something along the lines of
> { .sysinfo_str = "chassis", .dt_str = "chassis-type", 1}

Yes I agree that it would be easier to do such a thing and now I
understand why you have done this in the code. But why would we do
that? We might as well use the proper sysinfo binding in U-Boot,
instead of inventing something like this? Or would what you propose
here be easier to upstream? I'm just not sure it makes sense, which is
why I feel the code is over-complicated (and still has no tests even
after all this work).

Regards,
Simon
