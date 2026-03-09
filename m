Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B433EFCD9B
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 17:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE45983A8C;
	Mon,  9 Mar 2026 18:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gROwvGYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECCD683F14; Mon,  9 Mar 2026 18:43:48 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1451A80050
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 18:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-661b08b04deso3438346a12.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 10:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078221; cv=none;
 d=google.com; s=arc-20240605;
 b=PRru12MOo8XRxj9+UpjbDhFbqqH/68dS16e4riQ3ajRyxmvxaZEqXuPtR4u1LMr+at
 /3Ki2Qc89AkP803L9iEi8y073NA7tnzLm3TZcqLmX3dKkqVXVc/wI9+feuxyOBceV/uz
 PMlyaa6dNZJsccWIIeXQWxdx4we6ggerJyDm5Y4a0R29S7VDn1VuQf2tjxgGSJSRKn4j
 0GEy3TyEeb7hh7CAqtmwpdjpHBF+vPtGggFAp1c+wWKEMNTNCXtF1cfDwSQgF0kqqSyG
 2RTxCbjqvW5C40OPkvLW+jz+RD18RW/8BQwThSuVG3uNYDPFazdJVBNHCoskRCxsjkA4
 m3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=23R098OgI4vjs8wNAHi+M8vzRHO7a3XHn6n62mPMELs=;
 fh=rTso9aQYfzhdqnRu1vDrq4hglxFakK++rYCRH72GyJQ=;
 b=DEKlrf3Ibtb+kgqeqElPsSDQ1jSWZaUkze1yvcllJHYLPDHNcNmBrrrM9maAnyWwvI
 JPwAq3R+WzT9UR62z6FIMrdburAkVjyhQe+2Czjhpw4RRNWMcQBbstX5sKuci7HBaLCc
 V8a5NPj7/y/x9G0lifQ+G+Hclt/mXQrYNbfT77al691ZpqZ9NpltjQtUWKio9JswFWBi
 jXvkkl+EwG0gTdCinA0MaLhDCYx6chUrWX3yreEphGNLaJ6mzlYIgxBH2u/Kglucj7Ac
 TRY4RXBn1qttxwulf6YF8b0jHXlxs+LDkANnUJ793iv7UY0hx14pasrKWOSWx70e9w1J
 a3Fg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773078221; x=1773683021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=23R098OgI4vjs8wNAHi+M8vzRHO7a3XHn6n62mPMELs=;
 b=gROwvGYXBkpmpMF1GdYlhDKCoxouW2xEQ81Kn+aoJgZLzhVttdSgG22hX5r8zcTe+h
 RC1iEDvzmTdthnEfeIF0MJwn+AAMbxJ34Ie34MlZhuv+2k0RXPRhe/lGeyO938HjfkO9
 7vjpGIssqzhi6VQxVfsgcjEklbWehsaHb4ndo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078221; x=1773683021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23R098OgI4vjs8wNAHi+M8vzRHO7a3XHn6n62mPMELs=;
 b=CzdHCYtN9jM9I7O2HC6ZSKdtn3oBnk0pvhhyLjDn4TWHoVr973aO1ffjAoRhW45wuF
 wateLJfCoXFcjWTKAmMurMYbE8Iq+o63XvWG9YYVNd6HwDsX2BfyyFvK/v6pXyGtn40Z
 FOgpNZazI3qIXb39CKRLHZPnZ4ynyDXR8Wz6YSIywuMmCyQj4kOHUQsVR4BeFHCTAKq5
 Q8iSK4E2jcWeYUihNpMmfFgy+49ZlFNcfq81ZSyuH6u2wMMj6sLENSLwOQ3jQ+g+DMCR
 V4rbALDlASm1XNFEpMQkfL1WAzpqd4WQD3KSC4e4PtNgkEjkvCGoTfQu7GVPJkG1aKQI
 t0LQ==
X-Gm-Message-State: AOJu0YxyTeRDIXmd9O/em2dsCJujYLJsghKWPhkSWQ3RprpPsDQb4F75
 VdWoHGe9DM6sMPuPVeLmrTbs62hdappqAYcjdBTTL9Fc2SB1le97jsN0nt3RK4YNicDV5q0ZOB6
 Czbam1Vpa0JHajkuPIBECm+vpaLmEgYNyqeij2zbd
X-Gm-Gg: ATEYQzwGFup/76i73ASiDbX0N18w1ySfUO4zIPwg67JEPjPX3mIpqXfyPqUMSXJUec5
 sxHla1NHqWM/94BelrUVgn0RChIxdNCOdOiGIGDzSBSmNPi1wNX7n9FY2JkYIF3SxVKqZ/oAEuz
 Dgn+hmaydSpo4B55Zfc4PMgCc4MMToS34n5CP4o6V0dgRmrjImoTf2o23V2WLdr9sebVZ1/sLvH
 ecPf5qGMLlvU5Tmmy5NgBmaFdsGnOyNJe62LqlW4p8WOtGzYng5CiG7wfs2l264DDe40I5cW/Rr
 L16Vww==
X-Received: by 2002:a05:6402:146b:b0:65a:16fc:d81 with SMTP id
 4fb4d7f45d1cf-6619d53acd6mr6935171a12.22.1773078221473; Mon, 09 Mar 2026
 10:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260306012019.800588-1-sjg@chromium.org>
 <34161583f77cb999a04789bf6798d6fbd2c4e234.camel@siemens.com>
In-Reply-To: <34161583f77cb999a04789bf6798d6fbd2c4e234.camel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Mar 2026 11:43:29 -0600
X-Gm-Features: AaiRm52Sn950lRiktLavYWsMHhEPoQOvuoFBSIjR4E0bOdc-tuoS7J_4ftRaTEU
Message-ID: <CAFLszTj_hRfCU6V2O08qOF-8LsOZ_tinxPKVaNKypwwa=2H_sQ@mail.gmail.com>
Subject: Re: [PATCH v2] boot: Add fit_config_get_hash_list() to build signed
 node list
To: "Nussel, Ludwig" <ludwig.nussel@siemens.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>, 
 "trini@konsulko.com" <trini@konsulko.com>,
 "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>, 
 "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>, 
 "simon.glass@canonical.com" <simon.glass@canonical.com>,
 "eballetbo@kernel.org" <eballetbo@kernel.org>
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

Hi Ludwig,

On Mon, 9 Mar 2026 at 11:29, Nussel, Ludwig <ludwig.nussel@siemens.com> wrote:
>
> On Thu, 2026-03-05 at 18:20 -0700, Simon Glass wrote:
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > The hashed-nodes property in a FIT signature node lists which FDT paths
> > are included in the signature hash. It is intended as a hint so should
> > not be used for verification.
> >
> > Add a function to build the node list from scratch by iterating the
> > configuration's image references. Skip properties known not to be image
> > references. For each image, collect the path plus all hash and cipher
> > subnodes.
> >
> > Use the new function in fit_config_check_sig() instead of reading
> > 'hashed-nodes'.
>
> While growing more grey hair trying to wrap my head around this I found
> a mean trap. mkimage reads a 'sign-images' property to determine which
> images to include in the hash regions. Without that property only
> kernel, fdt and script properties are included at image generation time
> (see fit_config_get_image_list()).
>
> The new verification code works without such a weird hardcoded list. So
> as soon as a FIT image has e.g. a ramdisk and it's not listed in 'sign-
> images' the verification fails.

Yes I noticed that...I was thinking we could have mkimage report an
error, but fit_check_sign does do this check.

When designing all this I felt it was nice to have a sign-images
property which explicltly contains the things to sign, since it makes
you think about what you are doing. But perhaps we could just do
without it?

>
> > +static int fit_config_add_hash(const void *fit, int image_noffset,
> > +                            char **node_inc, int *count, int max_nodes,
> > +                            char *buf, int *buf_used, int buf_len)
>
> Took me a while to figure out that a function with the same name is
> also in tools/image-host.c. Might make sense to pick a different one :-
> )
>
>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com

Regards,
Simon
