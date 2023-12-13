Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D617C4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 22:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C57877E6;
	Wed, 13 Dec 2023 23:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GJcjokdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7813A878D1; Wed, 13 Dec 2023 23:22:39 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C76878AA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 23:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a22f2a28c16so242728466b.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702506154; x=1703110954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xci0iCSCSDTvmIsk2HGkoHpQBFVjaK62BT9PuJM/dgM=;
 b=GJcjokdrtkWct1+EtE3XMJUJlfybs9LLMKKkeahgwwavzqGUJhkt0epmli50Tt2wgx
 ORKyBbexlGHgZp9oQyA/zvZF93idqnGmjlYL3iUfMmr629cd67LKAyE0UvT8ln1DY8ZA
 qXkBuMpct2ebqEejfMaiFVdRB5cFeVeQQ2D4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702506154; x=1703110954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xci0iCSCSDTvmIsk2HGkoHpQBFVjaK62BT9PuJM/dgM=;
 b=VhBUvxGiguhktGJRHy8Cp98yayM6faKiHXmJeruQ15CbnRlZy5lSOTYlCY1YAL1Bf/
 M47OTJzOM0JexOeLAeEjxpKy6Fe5OXsE008VuISrGYuJ6RVw1my5togI6XFzs4xM7B2P
 xTm4PCrRwU+tEQjPcE9g8r7iB32elu0Rpnky3m439qwwDxIXuJekuhP9fRQ4ZXHLqCxK
 YfjXIhnxO27/i4dk/0tgH+bo52Wj8SGJemf6Hl4cuhxx5l0QiH/9/fx76OYmbNoJtN3K
 ruejiRV1EpOMs0CIsNC+eg534ZUJQdk4ezkMLz5JflyZPB44OIAxw7tqd0RC3GR3wy8n
 KgwA==
X-Gm-Message-State: AOJu0YzUQVXQ4J39hyIsAzw44JuiVvFeq6zsk8JrSEN8u69zNY9Bnnmb
 kcv/y6HzKZjIwCcS2sRuTaLZokuQnPH7XfYBunFQRg==
X-Google-Smtp-Source: AGHT+IECprRnPs1GfIUMLEzHD8lJcqTGp8+CJq4zMKbtyPh5EnVozBaXcR8KgIgIDqAd1YNWoGCdBB6q5nCpx6wb3Rg=
X-Received: by 2002:a17:907:948f:b0:9f9:2d85:1ccc with SMTP id
 dm15-20020a170907948f00b009f92d851cccmr3454810ejc.33.1702506154249; Wed, 13
 Dec 2023 14:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Y5Dzhp2c5qsoDEjY-w8NsueEHgvCSfTEbtEOPMTJ9wA@mail.gmail.com>
 <CAC_iWj+zd5X7FiM7XQVPSj9a7cwxpo-VHR6TV36y98ust-Ckpg@mail.gmail.com>
In-Reply-To: <CAC_iWj+zd5X7FiM7XQVPSj9a7cwxpo-VHR6TV36y98ust-Ckpg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 15:22:19 -0700
Message-ID: <CAPnjgZ1b3tSR3nh0H6Xu1RCp=Zid+TXfUVr0C4HvDtqWvyiMog@mail.gmail.com>
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

On Wed, 13 Dec 2023 at 14:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 13 Dec 2023 at 21:52, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 7 Dec 2023 at 02:19, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > If a value is not valid during the DT or SYSINFO parsing,  we explicitly
> > > set that to "Unknown Product" and "Unknown" for the product and
> > > manufacturer respectively.  It's cleaner if we move the checks insisde
> > > smbios_add_prop_si() and provide an alternative string in case the
> > > primary is NULL or empty
> > >
> > > pre-patch dmidecode
> > > <snip>
> > > Handle 0x0001, DMI type 1, 27 bytes
> > > System Information
> > >         Manufacturer: Unknown
> > >         Product Name: Unknown Product
> > >         Version: Not Specified
> > >         Serial Number: Not Specified
> > >         UUID: Not Settable
> > >         Wake-up Type: Reserved
> > >         SKU Number: Not Specified
> > >         Family: Not Specified
> > >
> > > [...]
> > >
> > > post-patch dmidecode:
> > >
> > > Handle 0x0001, DMI type 1, 27 bytes
> > > System Information
> > >         Manufacturer: Unknown
> > >         Product Name: Unknown
> > >         Version: Unknown
> > >         Serial Number: Unknown
> > >         UUID: Not Settable
> > >         Wake-up Type: Reserved
> > >         SKU Number: Unknown
> > >         Family: Unknown
> > > [...]
> > >
> > > While at it make smbios_add_prop_si() add a string directly if the prop
> > > node is NULL and replace smbios_add_string() calls with
> > > smbios_add_prop_si(ctx, NULL, ....)
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > > Changes since v2:
> > > - refactor even more code and remove the smbios_add_string calls from the
> > >   main code. Instead use smbios_add_prop() foir everything and add a
> > >   default value, in case the parsed one is NULL or emtpy
> > > Changes since v1:
> > > - None
> > >
> > >  lib/smbios.c | 73 +++++++++++++++++++++++++---------------------------
> > >  1 file changed, 35 insertions(+), 38 deletions(-)
> > >
> >
> > I actually think we should just stop here and first write a test for
> > what we already have. I can take a crack at it if you like?
>
> I don't mind.  As I said in a previous email I'd rather do it after
> the refactoring you had in mind. But I don't see why that should stop
> the current patch from going forward.

OK, well if this series could be simplified, I don't mind either. But
at present it is complicated and I think it really needs a test.

>
> >
> > > diff --git a/lib/smbios.c b/lib/smbios.c
> > > index d7f4999e8b2a..444aa245a273 100644
> > > --- a/lib/smbios.c
> > > +++ b/lib/smbios.c
> > > @@ -102,9 +102,6 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
> > >         int i = 1;
> > >         char *p = ctx->eos;
> > >
> > > -       if (!*str)
> > > -               str = "Unknown";
> > > -
> > >         for (;;) {
> > >                 if (!*p) {
> > >                         ctx->last_str = p;
> > > @@ -134,11 +131,18 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
> > >   *
> > >   * @ctx:       context for writing the tables
> > >   * @prop:      property to write
> >
> > which can now be NULL?
>
> No, it can't because smbios_add_string can't do that. See commit 00a871d34e2f0a.
> But instead of checking it here, I moved the code around and
> smbios_add_string is only called from smbios_add_prop_si instead of
> calling it on each failure of smbios_add_prop_si(). In that function,
> we make sure the value isn't NULL, apart from the ->get_str sysinfo
> calls -- none of these currently returns null though. I can move the
> checking back to where it was if to shield us again dump 'get_str'
> implementations, or in the future fix smbios_add_string properly, but
> that's not the point of this patch.

My point was that you have code to check for !prop and do something:

if (!prop)
    return smbios_add_string(ctx, dval);

Before, we needed prop (at least if OF_CONTROL), but now prop can be
NULL, so you should update the comment to mention that and explain
what it means.

>
> >
> > > + * @dval:      Default value to use if the string is not found or is empty
> > >   * Return:     0 if not found, else SMBIOS string number (1 or more)
> > >   */
> > >  static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
> > > -                             int sysinfo_id)
> > > +                             int sysinfo_id, const char *dval)
> > >  {
> > > +       if (!dval || !*dval)
> > > +               dval = "Unknown";
> >
> > You shouldn't need this, right? It is already the default value.
>
> Unless someone misuses smbios_add_prop_si() with both the prop and
> dval being NULL. Also see above.

Don't allow that, then? It seems strange to have a default value for
the default value.

>
> >
> > > +
> > > +       if (!prop)
> > > +               return smbios_add_string(ctx, dval);
> > > +
> > >         if (sysinfo_id && ctx->dev) {
> > >                 char val[SMBIOS_STR_MAX];
> > >                 int ret;
> > > @@ -151,8 +155,8 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
> > >                 const char *str;
> > >
> > >                 str = ofnode_read_string(ctx->node, prop);
> > > -               if (str)
> > > -                       return smbios_add_string(ctx, str);
> > > +
> > > +               return smbios_add_string(ctx, str ? str : dval);
> > >         }
> > >
> > >         return 0;
> > > @@ -161,12 +165,15 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
> > >  /**
> > >   * smbios_add_prop() - Add a property from the devicetree
> > >   *
> > > - * @prop:      property to write
> > > + * @prop:      property to write. The default string will be written if
> > > + *             prop is NULL
> > > + * @dval:      Default value to use if the string is not found or is empty
> > >   * Return:     0 if not found, else SMBIOS string number (1 or more)
> > >   */
> > > -static int smbios_add_prop(struct smbios_ctx *ctx, const char *prop)
> > > +static int smbios_add_prop(struct smbios_ctx *ctx, const char *prop,
> > > +                          const char *dval)
> > >  {
> > > -       return smbios_add_prop_si(ctx, prop, SYSINFO_ID_NONE);
> > > +       return smbios_add_prop_si(ctx, prop, SYSINFO_ID_NONE, dval);
> > >  }
> > >
> > >  static void smbios_set_eos(struct smbios_ctx *ctx, char *eos)
> > > @@ -228,11 +235,9 @@ static int smbios_write_type0(ulong *current, int handle,
> > >         memset(t, 0, sizeof(struct smbios_type0));
> > >         fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
> > >         smbios_set_eos(ctx, t->eos);
> > > -       t->vendor = smbios_add_string(ctx, "U-Boot");
> > > +       t->vendor = smbios_add_prop(ctx, NULL, "U-Boot");
> >
> > What is this doing exactly? I don't really understand this change.
>
> Re-read the patch description please, it's explained in the last paragraph.
>
> >
> > >
>
> [...]
>
> > > 2.40.1
> > >
> >
> > From my understanding, the only thing your fallback adds is the
> > manufacturer ('vendor' from DT compatible = "vendor,board"), and the
> > product (from DT model = "..."). This is an awful lot of code to make
> > that change and it seems very, confusing to me.
>
> Can we please comment on the current patchset? Future history and
> digging becomes a nightmare otherwise.
>
> >
> > Instead, can you do something like:
> >
> > if (!IS_ENABLED(CONFIG_SYSINFO)) {
>
> That beats the purpose of the series though, we want this as a
> *fallback* not disabled in the defconfig.
>
> >    const char *compat = ofnode_read_string(ofnode_root(), "compatible");
> >    const char *model = ofnode_read_string(ofnode_root(), "model");
> >    const *p = strchr(compat, ',');
>
> No. This is just a quick and dirty patch that allows you to split on
> the first comma. On top of that it won't work for cases like 'model'
> which, most of the times, only has a single value (which is again
> explained in the patch description) and you have to add a bunch of ifs
> on the code above. You could only parse compatible only, but model
> tends to be way more accurate than the one added in the compatible
> node. The first is a full description of the device while the latter
> is just a trigger for driver probing etc.
>
> random example
> model = "Socionext Developer Box";
> compatible = "socionext,developer-box", "socionext,synquacer";

But your code does the same as my fragment above, doesn't it? Only the
compatible string is split, and only the first part (before the ',')
is used.

For the model, the whole string is used, so having a function to split
the string, which doesn't have a separator in it, seems unnecessary.

I am not talking about the end result, just trying to make the code
easier to understand. It is very complex right now.


>
> >    char vendor[32];
> >
> >   *vendor = '\0';
> >   if (p) {
> >       int len = p - compat + 1;
> >
> >       strlcpy(vendor, compat, len);
> >   }
> >
> >   // add these two strings to the ctx struct so that
> > smbios_write_type1() can pass them as defaults
> > }
> >
> > You still need to make the 'default' change, but much of the other
> > code could go away?

Regards,
Simon
