Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67B4CFC279
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B458388D;
	Fri, 21 Nov 2025 15:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YVWEVtsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 624A08393F; Fri, 21 Nov 2025 15:26:01 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 286F38382A
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b72bf7e703fso343441466b.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763735158; x=1764339958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s4ikzpLb0YYGz4RkQm6vDdMMqIPw4npsxtnO82K419o=;
 b=YVWEVtsK3SPPlp4QvYeVlPWeTFuKlBx7EBmNGvylCywIeh/AtE3s6I8mtmVH9Eg+ER
 Famu8QUVr9UELjTFeruofyZUAvoDtJ1M4KPRwgIfJPSZUgZ2Eba1qK1JhdBiih0bhvT+
 Xq3ehWdwqyXQ2Fvf6uxfXpadvswKhX03BnsJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735158; x=1764339958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4ikzpLb0YYGz4RkQm6vDdMMqIPw4npsxtnO82K419o=;
 b=ApIsSOcCtDhiSQMWZynooOA6kDaQ9lV9vVSHpe2bYU3yqy7gxWLQrdWWso0NHw0ZC9
 RBQtdOn9i8dT1faKKNrK3gnkK7V5GoaiU+HM7l3pn23TuZplKu8yE9SiD9R6W5uxz0yj
 ZF9D1MZ7jGxRKCaGhTEDyZUxkbTyUsE3tURFaBBwzoz8X8un14rNYWWsHfwm3LR3WqZQ
 +hxAsHrXgZj440r6JdYhQesAmI6L2Da3ocxTaMsMiHWCwO0gdGIhnWCOs3Oj/MabPmAb
 zVkQWMbD67esXgFVNngufb+QMEGww6PCT8rpoRJjc56d67WBXAD5B6TL3fsrw5APuRC4
 c+4Q==
X-Gm-Message-State: AOJu0Yzrj5eoGIGlnqp5wNXyuMIDRBgVTZRvGJHALic4wSv4ToeCeKWK
 oqzLB1+0d7WTi6JEKJy1UtHLTL7EbZyeVxg3Rm+n86L4s/wr9p2cjMsywRAgEXhJHzqgnM5172q
 CM0v5A+GNogef/MhzEqT+FvA08Bar5DhpV9oAFv8a
X-Gm-Gg: ASbGncuttkiLIJjcqqXqB2IEnOfdmdXYhTAMErMieMYVHuu/+6bijU5oBjjFIXjv+CF
 ZbSedciDBtmINXu5OtxBQmTTxNV3KcA34yxixF6QGE31CDo+OPNUd7Vp7WIq07vc1JQBS9bsyQK
 Umi69niYxKFCKknLIubU3GjSZnUy9rabSPf53LOwTinO1EDMmVAHEY/PmuqJSw9xJHBhYDnDBeL
 mZp+//XhSZ7NX2yxOxnnDzo6oOQprnTlzwTsTZxMarMy1u3ecy++7OMvIkZC+jOryh5oQ==
X-Google-Smtp-Source: AGHT+IH/v+EB3CTpA1R8OzDDRfr38/cd29z6WMh78MNMKmkOil4MTxGrzeMU4xvILUYAKo4lC3/W/gBuzxIQC3jJV3c=
X-Received: by 2002:a17:907:d05:b0:b73:6b24:14b5 with SMTP id
 a640c23a62f3a-b7671a47bafmr281932566b.31.1763735158514; Fri, 21 Nov 2025
 06:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjnGtSPvki-i1fHQEU+bn=6cTqjRFyid3D5zQepNEhzog@mail.gmail.com>
 <c8752825-92d5-43bd-aa28-e229d4cc3fda@mailbox.org>
In-Reply-To: <c8752825-92d5-43bd-aa28-e229d4cc3fda@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Nov 2025 07:25:46 -0700
X-Gm-Features: AWmQ_blXdqhylhIl_f9C-4y4j-qDCLd54-cRAwgFbvitQ5I3VBGLd0Ln7stVcoc
Message-ID: <CAFLszThiZ9iWZG8vNSaosNjMMTQZeG2=yO8kGoPDBL0SSp_4Cw@mail.gmail.com>
Subject: Re: [PATCH] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Thu, 20 Nov 2025 at 21:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/21/25 12:40 AM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Wed, 19 Nov 2025 at 21:14, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
> >> with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
> >> call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
> >> and passes result of ofnode_to_offset(node) as an offset parameter into it.
> >>
> >> The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
> >> fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
> >> because libfdt can not handle negative node offsets without full tree check,
> >> which U-Boot inhibits to keep size lower.
> >>
> >> Add dev_has_ofnode(dev) check and do not assign clock rate in case the
> >> device has no valid node associated with it, and do not call any of the
> >> dev_read_*() functions for devices without valid nodes.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> >> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >> Cc: Sean Anderson <seanga2@gmail.com>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: u-boot@lists.denx.de
> >> ---
> >>   drivers/clk/clk_fixed_rate.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
> >> index 95a77d2e041..5c32ae207fe 100644
> >> --- a/drivers/clk/clk_fixed_rate.c
> >> +++ b/drivers/clk/clk_fixed_rate.c
> >> @@ -35,7 +35,7 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
> >>                                      struct clk_fixed_rate *plat)
> >>   {
> >>          struct clk *clk = &plat->clk;
> >> -       if (CONFIG_IS_ENABLED(OF_REAL))
> >> +       if (CONFIG_IS_ENABLED(OF_REAL) && dev_has_ofnode(dev))
> >>                  plat->fixed_rate = dev_read_u32_default(dev, "clock-frequency",
> >>                                                          0);
> >
> > What is happening here? It should already be checking this:
> >
> > static inline __attribute_const__ bool dev_has_ofnode(const struct udevice *dev)
> > {
> > #if CONFIG_IS_ENABLED(OF_REAL)
> > return ofnode_valid(dev_ofnode(dev));
> > #else
> > return false;
> > #endif
> > }
> I do not understand the question -- this patch _adds_ the
> dev_has_ofnode() test into clk_fixed_rate_ofdata_to_plat_() , it wasn't
> present before. Can you please rephrase your question / concern ?

The dev_has_ofnode() function already checks OF_REAL, as shown above. To repeat:

> > static inline __attribute_const__ bool dev_has_ofnode(const struct udevice *dev)
> > {
> > #if CONFIG_IS_ENABLED(OF_REAL)
> > return ofnode_valid(dev_ofnode(dev));
> > #else
> > return false;

   ^^ returns false here

> > #endif

You are adding another check in the caller:

> >> -       if (CONFIG_IS_ENABLED(OF_REAL))
> >> +       if (CONFIG_IS_ENABLED(OF_REAL) && dev_has_ofnode(dev))

dev_has_ofnode() will already return false if OF_REAL is not enabled.
So what is the point of checking OF_REAL before calling
dev_has_ofnode() ?

I don't understand what benefit this patch brings.

Regards,
Simon
