Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF98FEC1447
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5858B83F4C;
	Tue,  3 Mar 2026 14:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dy1HKPpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1840183F69; Tue,  3 Mar 2026 14:33:07 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C8B83F4C
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-660a58841d4so785646a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 05:33:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772544783; cv=none;
 d=google.com; s=arc-20240605;
 b=cvPaJVajC2PJKiZxNQmazU6dX2JhER2k6eChUEWJQe7U/Y4NCoVVPfJucPs7QjQCg1
 64TzJnGmCmGmi6U61SuI5kPYFjDHtja8pCqkFFHtFceBa0pF3Z3dugFh0uO7jdH3bFPA
 3TFj/u5+6YYNyhDmwJB8sC2nVJg0GqK1F1teMGKpw7sVYUvsdlM+2w+VcfRHnSvTqKLt
 +YEd/axbWhCP2rTbmT0LEC9Pe5wAjCDmG3/iLri0SL3QXTD2j1Qv1FZrAr7nZV2gZ2WF
 dX8CSVxTO1LdN6aTH9fdtAWA5ZAQ7wBPsWB9mxq4hb2xdXyjBFEPvPWvi/N4IBbdfSC0
 g0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zvbcm8+ZRE6GnMLeGye0sjegNwkpsyfnWDgo3xu/OqM=;
 fh=Px+FZQu8YtL4INmJKwbYteIC5wFjca+RjrpiQyoTIjI=;
 b=anhYQhXZqCkGB4y05Px5zLvCbybPs6LaqBoBjykgsKvixtBEF33oGu2zC8CH+nNUf3
 fubM81gOQeFY4gTNqves25Ln9XXCK8EZi4DPjFQHo42MCdUpVP6doZeLNFJ4o4q0kTEW
 MbpoiJ0b88xaM/lRwJsMOmOCBrx9dqngF3YnRmYCagR4NlIBH9JniyrUR/WiquO2kZbf
 1HZSefzyDSC58dLYvCzD4NHPxOFwBgQCmKwBDJaVewZ/BBBob5d7XO+lxSb751iPaD4a
 8yaCNWKF7kHA4vKMPAwd1afT693tPg57VWK+zHLBT9HngGakUPYLwuOgX8ufp8uZr0AU
 LgrA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772544783; x=1773149583; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zvbcm8+ZRE6GnMLeGye0sjegNwkpsyfnWDgo3xu/OqM=;
 b=Dy1HKPpvFCthJvUjHkzWz0cJIINamAVV2WC8f4eobBNpmHMmbB1u5xw3hYCvcazE8b
 h9rgTaUUX6/pt8HC/wfw4W2V+sgq9n+9nO72AbWCK/X2IJmT94d5jtLs4Qm676WRy2b8
 QrfhwAgRvHVaVNY6qvqlT6RhWdMU8/lQcb9NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772544783; x=1773149583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvbcm8+ZRE6GnMLeGye0sjegNwkpsyfnWDgo3xu/OqM=;
 b=ign/QFboKC26ubrkhuavVAggGMFhzmEdVGaAiePJIX61i7Y1B9R3YtbQSKn5z4Ls+J
 RgkXasueybbHhAF8M2CcUUfaferbyty/wJoWXvSwHwQZR0Q8BI+Y1Djs2SECLQw6Ow13
 BdhR30Rg17FkR8rA/V+jQ/wp78+oSsEplHZGuTVAaOmsvc1XoTo/DTF9tO+v1Vu4Xfwt
 Y7rlgOpYf9jktv9NTd8Ge0mj9YFV1QCFoNdNa2s1MLhMA7QF99P9TRCqdhBnzGQEGgAH
 /bX+l692U4JPNdQtrigJb2vqjLS1hhkFXi9hAG9DnyD3o2a20Yha7vUjf3FRNsW1GE9D
 X8gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTsR0XJsU/8NcilU0NE+o9Ai9IlqNJIDjWVsVaJKfTpkoJzsIcqQKkifa047c7kosLCxKIMT8=@lists.denx.de
X-Gm-Message-State: AOJu0YyirBYBOSx6m6MEElyUAA+SDmvuivJdvwP/ngorKVmaw8ym+eAE
 rle8dA1FTCVP8lsNHnoaPnuAUWu+fI9LcAf1NT3Y3q38gJEhgOVrlQlShs5w0MYNXkQYri3Gblx
 CwCMwbxzaLmAOqPnJy8Emyy0BjfebXp9+ZkPlSBsW4D7bD+w/qkMSoQ==
X-Gm-Gg: ATEYQzzVS/iJMYoYqFC50k+5Nni1Wi4cxBbJOH3qocsTW5+bCsT0BoK+U9Qeok05lua
 mAEiSKPTBLCwxdCd6mhJucNF6ganAcG/rf4GdpEPS6Z+Gwjw56l7dxNkj6SEC9xjMh7Yv6NhqxO
 w82iArOcY4lC4/YjKqcErfMt4TzTSgrjtkoXu1jB0IkZUmlmbAjXeySVdVAAF3vRPkGaXQWHl8d
 3rCjc6mRWQDHYv6x6KaJzbP3KKsM05Y3XUf5ji22XlKTKVGG1x+mjHXyQyQoJf4l536n+C0QVDk
 ktPd7w==
X-Received: by 2002:a17:907:3f13:b0:b93:c5a9:a5e1 with SMTP id
 a640c23a62f3a-b93c5a9b96cmr335752366b.10.1772544783148; Tue, 03 Mar 2026
 05:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20260302220937.3682128-1-trini@konsulko.com>
 <1c8f8282-7ec9-440e-bfbe-2494f5ea69c8@pengutronix.de>
In-Reply-To: <1c8f8282-7ec9-440e-bfbe-2494f5ea69c8@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Mar 2026 06:32:50 -0700
X-Gm-Features: AaiRm50JEBgHy5n59CqxmAEEswa0kvz5DEcZnQr3a7UzSvQU9XVZUV_n3HNAlh8
Message-ID: <CAFLszTjSxQ5Q2HGEqiRVH5VnG1M8++F=MVWWrSJg6HuTmzckFw@mail.gmail.com>
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi,

On Tue, 3 Mar 2026 at 01:09, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Tom,
>
> On 3/2/26 23:09, Tom Rini wrote:
> > There is a flaw in how U-Boot verifies and generates signatures for FIT
> > images. To prevent mix and match style attacks, it is recommended to
> > use signed configurations. How this is supposed to work is documented in
> > doc/usage/fit/signature.rst.
> >
> > Crucially, the `hashed-nodes` property of the `signature` node contains
> > which nodes of the FIT device tree were hashed as part of the signature
> > and should be verified. However, this property itself is not part of the
> > hash and can therefore be modified by an attacker. Furthermore, the
> > signature only contains the name of each node and not the path in the
> > device tree to the node.
> >
> > This patch reworks the code to address this specific oversight.
>
> Do I understand correctly that this is a breaking change
> for FIT with signed configurations?
>
> - New U-Boot hashes more than intended for old FIT
> - Old U-Boot hashes less than intended for new FIT

Yes, that's right.

Reviewed-by: Simon Glass <sjg@chromium.org>

I can see how this works. Please see nit below.

>
> Thanks,
> Ahmad
>
> >
> > Thanks to Apple Security Engineering and Architecture (SEAR) for
> > reporting this issue and then coming up with a fix.
> >
> > Reported-by: Apple Security Engineering and Architecture (SEAR)
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > I assume one question will be about adding a test case. I have been
> > asked to not share the testcase for a few releases yet, so plan to add
> > that later in the year.
> > ---
> >  boot/image-fit-sig.c | 31 +++++++++++++++++++++++--------
> >  include/image.h      | 12 ++++++++++++
> >  tools/image-host.c   |  9 +++++++--
> >  3 files changed, 42 insertions(+), 10 deletions(-)
> >
> > diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> > index f23e9d5d0b0f..dce8bbe30e93 100644
> > --- a/boot/image-fit-sig.c
> > +++ b/boot/image-fit-sig.c
> > @@ -44,12 +44,6 @@ struct image_region *fit_region_make_list(const void *fit,
> >       debug("Hash regions:\n");
> >       debug("%10s %10s\n", "Offset", "Size");
> >
> > -     /*
> > -      * Use malloc() except in SPL (to save code size). In SPL the caller
> > -      * must allocate the array.
> > -      */
> > -     if (!IS_ENABLED(CONFIG_XPL_BUILD) && !region)
> > -             region = calloc(sizeof(*region), count);
> >       if (!region)
> >               return NULL;
> >       for (i = 0; i < count; i++) {
> > @@ -62,6 +56,23 @@ struct image_region *fit_region_make_list(const void *fit,
> >       return region;
> >  }
> >
> > +int fit_region_add_hashed_nodes(struct image_region *region, int count,
> > +                                     const char* hashed_nodes, int hashed_nodes_len)

That should line up with the previous line.

> > +{
> > +     /* Add the spacer to ensure the hashed strings and hashed-nodes cannot "overlap". */
> > +     const char* HASHED_NODES_SPACER = "hashed-nodes";
> > +     region[count].data = HASHED_NODES_SPACER;
> > +     region[count].size = strlen(HASHED_NODES_SPACER);
> > +     count++;
> > +
> > +     region[count].data = hashed_nodes;
> > +     region[count].size = hashed_nodes_len;
> > +     count++;
> > +
> > +     /* Now add the actual hashed-nodes value. */
> > +     return count;
> > +}
> > +
> >  static int fit_image_setup_verify(struct image_sign_info *info,
> >                                 const void *fit, int noffset,
> >                                 const void *key_blob, int required_keynode,
> > @@ -376,10 +387,14 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
> >               count++;
> >       }
> >
> > -     /* Allocate the region list on the stack */
> > -     struct image_region region[count];
> > +     /* Allocate the region list on the stack, +2 for the hashed-nodes */
> > +     struct image_region region[count+2];

spaces around +

> >
> >       fit_region_make_list(fit, fdt_regions, count, region);
> > +
> > +     /* Add the hashed-nodes */
> > +     count = fit_region_add_hashed_nodes(region, count, prop, prop_len);
> > +
> >       if (info.crypto->verify(&info, region, count, fit_value,
> >                               fit_value_len)) {
> >               *err_msgp = "Verification failed";
> > diff --git a/include/image.h b/include/image.h
> > index 34efac6056dd..5b847527b586 100644
> > --- a/include/image.h
> > +++ b/include/image.h
> > @@ -1771,6 +1771,18 @@ struct image_region *fit_region_make_list(const void *fit,
> >               struct fdt_region *fdt_regions, int count,
> >               struct image_region *region);
> >
> > +/**
> > + * fit_region_add_hashed_nodes() - Add a list of hashed nodes to the regions
> > + *
> > + * @region:          List of regions to add to
> > + * @count:           Number of existing regions (Note: region needs to have space for an additional two regions)

long line

> > + * @hashed_nodes:            List of hashed nodes
> > + * @hashed_nodes_len:        Length of list
> > + * Return: The updated count value (i.e. count+2).
> > + */
> > +int fit_region_add_hashed_nodes(struct image_region *region, int count,
> > +             const char* hashed_nodes, int hashed_nodes_len);
> > +
> >  static inline int fit_image_check_target_arch(const void *fdt, int node)
> >  {
> >  #ifndef USE_HOSTCC
> > diff --git a/tools/image-host.c b/tools/image-host.c
> > index 48d69191c921..1e7c38a9a211 100644
> > --- a/tools/image-host.c
> > +++ b/tools/image-host.c
> > @@ -1018,13 +1018,15 @@ static int fit_config_get_regions(const void *fit, int conf_noffset,
> >               return -EINVAL;
> >       }
> >
> > -     /* Build our list of data blocks */
> > -     region = fit_region_make_list(fit, fdt_regions, count, NULL);
> > +     /* Allocate the region array, +2 for the hashed-nodes region. */
> > +     region = calloc(count+2, sizeof(*region));
> >       if (!region) {
> >               fprintf(stderr, "Out of memory hashing configuration '%s/%s'\n",
> >                       conf_name, sig_name);
> >               return -ENOMEM;
> >       }
> > +     /* Build our list of data blocks */
> > +     fit_region_make_list(fit, fdt_regions, count, region);
> >
> >       /* Create a list of all hashed properties */
> >       debug("Hash nodes:\n");
> > @@ -1043,6 +1045,9 @@ static int fit_config_get_regions(const void *fit, int conf_noffset,
> >               strcpy(region_prop + len, node_inc.strings[i]);
> >       strlist_free(&node_inc);
> >
> > +     /* Add the hashed-nodes. */
> > +     count = fit_region_add_hashed_nodes(region, count, region_prop, len);
> > +
> >       *region_countp = count;
> >       *regionp = region;
> >       *region_propp = region_prop;

Regards,
Simon
