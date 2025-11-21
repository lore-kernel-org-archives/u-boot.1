Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EDFCFC299
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B160383A1B;
	Fri, 21 Nov 2025 18:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T1oNlDdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD7083A3A; Fri, 21 Nov 2025 18:35:33 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2051D839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b735ce67d1dso367729066b.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763746530; x=1764351330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EEIcBaGX1GxnfgemwyN1rDKF9lcq19JrS5VhBrDK3qE=;
 b=T1oNlDdkRY6YBJnUmsG5zwSABX4+iS6ayhu72coWf6b6p6z5p480plVP00JSUlc4rp
 hg6zyV72Ihce7n5zvCzED/9eB0UCS5NHN9m31ZnnRMSz5ptfelOGXLQjbr5oiHzGLuqo
 z3WGW7tVom2F2oz82BlOqWuk5QuOgxl1101MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763746530; x=1764351330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEIcBaGX1GxnfgemwyN1rDKF9lcq19JrS5VhBrDK3qE=;
 b=DiWRBqhkQuhrSl0apDEfepvoIAih6A6XaTtslpLV57NVZyzKOE7kZ+f6Fv8APuShF+
 5E2EvwDJxNNsMnhRL/V0WPF28OU2o1lvvULqa05zr5SwN/dZgvmpxl0sOIwxLkwIhsIt
 4R9kTERsXN4hfqjjf1yxwRTJbxDvlnY2yaD6DgyfDhnEqjbFSV3RUCmEkmRLiYeB7FRg
 ACWQ5/1MvvlzIMs80JTdu47aP39SNjaDfD8qJiHnrue+mc3RJQ/Q+MaFFoCOcKRAbONA
 1rduTLsjHxsgAPMysaR7dOYfkuCdLaifir6Jhnm5IB0VdsWkSMPJbvr7Q/v0x5CMc+Gz
 1TTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK3kzd9um9BCNJlEY/Ur6h1D30WZmPsucvhBTmgIRKAGpFWOdk3Bsn2x5EdRQRf0Oa4JD+gOk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9zSPSxYQLI96+Wza0vJ4+trj96Y54ofSMUUY/8ViMo6wfSdm6
 O9x8CGLbBwJFC3pdNwEjAKOHy6o7AC6zhVZVoDcdtjjeTq5uAzLnwHmKfRusW1eRi1j2ZB2c2rq
 +QDnW0GsMgxziOfQdAQmY/SGTXAMS2oKs8wbZdI5O
X-Gm-Gg: ASbGnctje2+8TmxNTUl5bS6ZzVOKXo3LanF7IQXzkS0ifTYeGlA87+vNnY/mfLlLly9
 Vy63cU4oKyElcORNeeMf8e0Y9PaHehceC5ae7N9HUnF31q4g426UuC9C/tDTMNELnmC24bYkQb6
 Rxyhy190hJHOez1nU/9D5Lcm8lTIyPekxXuDQS6K413oubO3t0mOkskUqjob5SU57t/hU0Muc4o
 D6pBNUxzdapr63lc9ZcXTnm28O83fV03Pg5ft7Ybwdc2t+0wNQo0HH60T+9COc67sDSfw==
X-Google-Smtp-Source: AGHT+IGLIYAR1qBt5X37c4PRoLzdtzrVOMp3a3dXdGr4688SpuUHjaKfK2ib1oB6ArUQnbvKWuGTIb2cc3TJQKr9uY4=
X-Received: by 2002:a17:907:72cd:b0:b73:5e4d:fae0 with SMTP id
 a640c23a62f3a-b7671567b72mr341349366b.23.1763746530580; Fri, 21 Nov 2025
 09:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjnGtSPvki-i1fHQEU+bn=6cTqjRFyid3D5zQepNEhzog@mail.gmail.com>
 <c8752825-92d5-43bd-aa28-e229d4cc3fda@mailbox.org>
 <CAFLszThiZ9iWZG8vNSaosNjMMTQZeG2=yO8kGoPDBL0SSp_4Cw@mail.gmail.com>
 <20251121143510.GX2125796@bill-the-cat>
In-Reply-To: <20251121143510.GX2125796@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Nov 2025 10:35:18 -0700
X-Gm-Features: AWmQ_bkdh6TgG7NWClQ8_elm0RQyd06FZB6k5UxVBphnndWbRWl7_BdTipmpcu8
Message-ID: <CAFLszTiBezzWuBE2qo8iEU8dyyD6ro4x2UrXGnQnfKSYSmTGgg@mail.gmail.com>
Subject: Re: [PATCH] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>
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

On Fri, 21 Nov 2025 at 07:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 21, 2025 at 07:25:46AM -0700, Simon Glass wrote:
> > Hi Marek,
> >
> > On Thu, 20 Nov 2025 at 21:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > >
> > > On 11/21/25 12:40 AM, Simon Glass wrote:
> > > > Hi Marek,
> > > >
> > > > On Wed, 19 Nov 2025 at 21:14, Marek Vasut
> > > > <marek.vasut+renesas@mailbox.org> wrote:
> > > >>
> > > >> If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
> > > >> with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
> > > >> call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
> > > >> and passes result of ofnode_to_offset(node) as an offset parameter into it.
> > > >>
> > > >> The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
> > > >> fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
> > > >> because libfdt can not handle negative node offsets without full tree check,
> > > >> which U-Boot inhibits to keep size lower.
> > > >>
> > > >> Add dev_has_ofnode(dev) check and do not assign clock rate in case the
> > > >> device has no valid node associated with it, and do not call any of the
> > > >> dev_read_*() functions for devices without valid nodes.
> > > >>
> > > >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > >> ---
> > > >> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > >> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > >> Cc: Sean Anderson <seanga2@gmail.com>
> > > >> Cc: Tom Rini <trini@konsulko.com>
> > > >> Cc: u-boot@lists.denx.de
> > > >> ---
> > > >>   drivers/clk/clk_fixed_rate.c | 2 +-
> > > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
> > > >> index 95a77d2e041..5c32ae207fe 100644
> > > >> --- a/drivers/clk/clk_fixed_rate.c
> > > >> +++ b/drivers/clk/clk_fixed_rate.c
> > > >> @@ -35,7 +35,7 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
> > > >>                                      struct clk_fixed_rate *plat)
> > > >>   {
> > > >>          struct clk *clk = &plat->clk;
> > > >> -       if (CONFIG_IS_ENABLED(OF_REAL))
> > > >> +       if (CONFIG_IS_ENABLED(OF_REAL) && dev_has_ofnode(dev))
> > > >>                  plat->fixed_rate = dev_read_u32_default(dev, "clock-frequency",
> > > >>                                                          0);
> > > >
> > > > What is happening here? It should already be checking this:
> > > >
> > > > static inline __attribute_const__ bool dev_has_ofnode(const struct udevice *dev)
> > > > {
> > > > #if CONFIG_IS_ENABLED(OF_REAL)
> > > > return ofnode_valid(dev_ofnode(dev));
> > > > #else
> > > > return false;
> > > > #endif
> > > > }
> > > I do not understand the question -- this patch _adds_ the
> > > dev_has_ofnode() test into clk_fixed_rate_ofdata_to_plat_() , it wasn't
> > > present before. Can you please rephrase your question / concern ?
> >
> > The dev_has_ofnode() function already checks OF_REAL, as shown above. To repeat:
> >
> > > > static inline __attribute_const__ bool dev_has_ofnode(const struct udevice *dev)
> > > > {
> > > > #if CONFIG_IS_ENABLED(OF_REAL)
> > > > return ofnode_valid(dev_ofnode(dev));
> > > > #else
> > > > return false;
> >
> >    ^^ returns false here
> >
> > > > #endif
> >
> > You are adding another check in the caller:
> >
> > > >> -       if (CONFIG_IS_ENABLED(OF_REAL))
> > > >> +       if (CONFIG_IS_ENABLED(OF_REAL) && dev_has_ofnode(dev))
> >
> > dev_has_ofnode() will already return false if OF_REAL is not enabled.
> > So what is the point of checking OF_REAL before calling
> > dev_has_ofnode() ?
> >
> > I don't understand what benefit this patch brings.
>
> I think the misunderstanding is that you're asking for this:
> -       if (CONFIG_IS_ENABLED(OF_REAL))
> +       if (dev_has_ofnode(dev))
>
> To be made to clk_fixed_rate_ofdata_to_plat_(...) in
> drivers/clk/clk_fixed_rate.c as it does not currently call
> dev_has_ofnode(dev).

Ah OK. So the call stack is something like:

dev_read_u32_default()
dev_ofnode() - returns ofnode_null
ofnode_read_u32_default()
ofnode_read_u32_index
fdt_getprop(NULL, -1, ...)   // guess

And I see that I put assert() in some of the ofnode_read..() functions
because I don't have tests for passing an invalid ofnode.

So perhaps fdt_offset_ptr_() should check for NULL and return? I
haven't traced it though.

Regards,
Simon
