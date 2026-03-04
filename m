Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A33EB7ED7
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 12:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B42E838BB;
	Wed,  4 Mar 2026 13:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NuTaR3zA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE34839A8; Wed,  4 Mar 2026 13:04:42 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9C983642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 13:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-660a58841d4so2138654a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 04:04:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772625878; cv=none;
 d=google.com; s=arc-20240605;
 b=lD7XS2ONQHoav+u2kaGbJgMJxEefeOeeShz7jKfWNyuAfCXUXXaA9IVdwD6R8X3+/j
 hv2voeY8hc+Oho5AgfP/3s362PLvcOcTYHsLgr2bAkXjMhlNgC6i8LKCPK5kocamKezI
 wzzVyqJP7cpaFYqXimbaalkupkimKSoEHzkwyWF/oLRy4x18hCub5oAzMgJMAOLF3hk+
 6p+dEHdpnbSaK6+l924HQSnKXvs7hlUJwpfumxU3fZXz2/th27abH1EK9lYuxBOpUTqW
 4td2ghPxyrD4RWL9jjB+TQiLRQeOFZ8OPqtkFaMHkafln40dPOQYxt382Hwgt3PQcDqM
 tnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iNG3TTFfH9iZix+0Wps02IM6diSjI3oj4av4VaptHY4=;
 fh=eta8945aNoknDTKef1EOXdDluhFH4Ka+He2db/L7x1s=;
 b=aPY19s2N3VKIUe/wxkKxaVX4UV0P+dHl3shzRMcBHfgeNi6LkRjd2GMvCSmqyNvlGa
 zs0Y5mst7AKfoDi5HXaBQrvsGByRLXNkQKClDkPBwZLhQBVDreZ0CKiSjPAjBuJeWgCJ
 AODJLAV60Jqiv5laCB4EGIFRl38NbAaLX5dlTNyxLIln+K3c6W2w5oTNaxdc7brMF5sa
 OBPHJlV2nIBPYKls6Ls4NzBXd3DZYcxbwWchxBGiD2XjIqqXlYwmiv3+k6YvNVWZ7Vyk
 gyZxfmiSrIiEDk7Qz8fqCmvWrKFoOPNr6Koz+NyxtXbUiPg4jGZuEdBfu9AybVaIxTGf
 qDbA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772625878; x=1773230678; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iNG3TTFfH9iZix+0Wps02IM6diSjI3oj4av4VaptHY4=;
 b=NuTaR3zAu/B8vYZlGmuQPtZ/00JwU0K3rGSgmzwf5ZtSXPZ0cRoA1E83njmQSOM+g/
 v8MxBjY+iBScg9Atem8P7GKwj2ZD7m9zjbStWNNDXwtHc8ovS0yCEuaFHtv3VuXBysXT
 bbjZwFtIWZD77GaxRDIcntX9nx5Wo8obSr/h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772625878; x=1773230678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNG3TTFfH9iZix+0Wps02IM6diSjI3oj4av4VaptHY4=;
 b=tqSJ6ckApywCFE60uuHSImYz2VQ8N40pYCG4W0FJbp+XzRSKzW2dmBWLCarhBkdKpy
 cMbd9jq7YkqXfRWYzsFi36/glCLAwxLcBb63vHIypM55wyY40l2ro7CHnY1zOTV139az
 uvNy58Twe6z7pqwnpfrGhNaDuCef5kejWZzIYtk0sMQhJzKVxELDBk2zb2KtQqk3feDZ
 VoLKCYQdSpuLLdBrAMz+MehVbMoIVushkxBqqtHIbCG0iTdEzxm6FNuBnjrlKw9ufdPW
 dWSCFmAhgRaJdt4R2Hr94L5HhXsLceonR9YidxV0OJEX1pd5mM2yc/uQJF1vz4Sj/tlP
 qe3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+5hSbbXBFNyjyuPk5t5Z7bb9KxdszdYUfOKUoC3wc0Bt8MgTcL61EG8jfIlfiZvWbJFGk7sY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/+VKD7cYu/YAnNaoJz4gldOoWZTuTBs+yDI//UFaffT7UZ6nd
 qxFKQyjOk9f1wO4jnQ0ImDeAvDlzlHlbYgOuuyr+X+34KjNCjj2wRwFE2upQDsy8ZVLCjkvxGa/
 MlahXPCxGZ2N1C6m8yx4EAKPM5sshCdw87IZkO0lj
X-Gm-Gg: ATEYQzw6UEswEP2VNE65i2ydyVumVRZAiyKSS1oi9ERmhx7g9x3PjDAC6Q9Hq8BSri2
 3g69w9qvwEJMKOM2TG0xsWqzs1tycMcbvQuiGZPr+QMeOk/R4KN2B9my4rQ7BsSlZpb+nwFfiu/
 jJHP4h2TEYL5WL2wTMzPLOc4T/SGt/uFQobdw+gJiYVbmnYVDpNDXpRvNJyojozBnHByfhX5H5/
 DHTWpJkY2SS1kud5BLw1faQTHKQXYEf37+dyj91/23SkebXG5edhe8SFmhUTQzlC0geDZzYveBc
 Yj3bYw==
X-Received: by 2002:a05:6402:2685:b0:65b:f30a:1081 with SMTP id
 4fb4d7f45d1cf-660effc549cmr883309a12.26.1772625878508; Wed, 04 Mar 2026
 04:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20260302220937.3682128-1-trini@konsulko.com>
 <1c8f8282-7ec9-440e-bfbe-2494f5ea69c8@pengutronix.de>
 <20260303155335.GO1388590@bill-the-cat>
 <d175c4628cefe9d86ec7e8d44e05a85bf081f1ff.camel@siemens.com>
In-Reply-To: <d175c4628cefe9d86ec7e8d44e05a85bf081f1ff.camel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Mar 2026 05:04:26 -0700
X-Gm-Features: AaiRm528yyl_5_BCWg2b3q65lQvFHWMAgCHEjnurlxaGtBlCji10nRODQBv2LJQ
Message-ID: <CAFLszTixT1WpFdjPLvza+0OYyUSRJ7c7becTAAfuN4agZnNfmg@mail.gmail.com>
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
To: "Nussel, Ludwig" <ludwig.nussel@siemens.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Wed, 4 Mar 2026 at 02:22, Nussel, Ludwig <ludwig.nussel@siemens.com> wrote:
>
> On Tue, 2026-03-03 at 09:53 -0600, Tom Rini wrote:
> > On Tue, Mar 03, 2026 at 09:08:59AM +0100, Ahmad Fatoum wrote:
> > > Hello Tom,
> > >
> > > On 3/2/26 23:09, Tom Rini wrote:
> > > > There is a flaw in how U-Boot verifies and generates signatures for FIT
> > > > images. To prevent mix and match style attacks, it is recommended to
> > > > use signed configurations. How this is supposed to work is documented in
> > > > doc/usage/fit/signature.rst.
> > > >
> > > > Crucially, the `hashed-nodes` property of the `signature` node contains
> > > > which nodes of the FIT device tree were hashed as part of the signature
> > > > and should be verified. However, this property itself is not part of the
> > > > hash and can therefore be modified by an attacker. Furthermore, the
> > > > signature only contains the name of each node and not the path in the
> > > > device tree to the node.
> > > >
> > > > This patch reworks the code to address this specific oversight.
> > >
> > > Do I understand correctly that this is a breaking change
> > > for FIT with signed configurations?
> > >
> > > - New U-Boot hashes more than intended for old FIT
> > > - Old U-Boot hashes less than intended for new FIT
> >
> > Sadly yes, similar to:
>
> I'm a bit confused why this doesn't cause an outcry. Aren't both the
> problem and the proposed fix a disaster for anyone relying on FIT
> signatures? :-)
>
> If I understand the issue description right, the problem is that the
> `hashed-nodes` property is used for verification as is.
> I wonder whether a simpler fix that doesn't break compatibility is
> possible by treating this property differently.
>
> Consider the config from the example at
> https://docs.u-boot.org/en/latest/usage/fit/signature.html:
>
>     configurations {
>         default = "conf-1";
>         conf-1 {
>             kernel = "kernel-1";
>             fdt = "fdt-1";
>             signature-1 {
>                 algo = "sha256,rsa2048";
>                 value = <...conf 1 signature...>;
>             };
>         };
>         ...
>     };
>
> The example doesn't actually list the `hashed-nodes` property. It would
> be
>
> hashed-nodes = "/", "/configurations/conf-1", "/images/kernel-1",
> "/images/kernel-1/hash-1", "/images/fdt-1", "/images/fdt-1/hash-1";
>
> Is there a legitimate use case where this value would be any different?
> Maybe for adding some unused properties that are only used for
> documentation purposes? If there aren't such, the `hashed-nodes` value
> would be actually redundant and can be calculated at verification time.
> No need to write it into the fit image.
>
> So an alternative fix could be to make u-boot work without the `hashed-
> nodes` property.
> For backwards compatibility with vulnerable u-boots we could read the
> value if present. Instead of using it as is, u-boot could calculate the
> intersection with what it would use. If the result is equal or a subset
> of the calculated value it's fine to use and an error if not. So even
> if an attacker can modify the `hashed-nodes` value, u-boot couldn't be
> tricked to mess up verification.
> Maybe it makes sense to also issue a warning about unverified
> properties.

Yes, I was playing around with that yesterday...I'll try to create a patch.

Regards,
Simon



>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
