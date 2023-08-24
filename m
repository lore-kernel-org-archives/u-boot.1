Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91FEC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74C88653D;
	Thu, 24 Aug 2023 16:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YDjDtIHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 621208664A; Thu, 24 Aug 2023 16:41:36 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AD5F86414
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99c93638322so205587166b.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692888093; x=1693492893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bAArZxilMdafYN0YYrcuIx+9R9cfa4JM+gLl2a5oPxI=;
 b=YDjDtIHmi4IGsrIFuYwwGfY8DweNuh9UPeUrn8gp8UyiODJiTnlUIkXj/E4N9Mjqgo
 /iPqtHceyICMJ2SxTif7u1x8Hkilfq3GaLwMIVbRin+j1/ShNFdbZ2xYsRKhtlbWvw3E
 5NSLvElCO0h7XqwAoA9WxEfvH0qfYx2FQyfVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888093; x=1693492893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bAArZxilMdafYN0YYrcuIx+9R9cfa4JM+gLl2a5oPxI=;
 b=Ew4oe/hggRb3k0gzH5faYjVtAOJ7FJjOeYSCtVFbJJXRPrsm0fPBJSD8XrgYcUg8Xh
 A+JSUFZMeetdeGoFnWMJR2yj8BaMOApLuDbeCYUt0xgNLxFFI+WaHHTSh88FBoaGwxkJ
 Cy9jyCXDkwB/yLJoLzHYAQCPy+O80h5+2Lj4+oWFpn7wUz/VoQnBCblwhL2HrH4sVpay
 PWXO5OU60OeP+zzSZ7y9T7Xn65DPfY8aG5hO5Ela2Yj4pRiuum69UcgEAPVS5TlGy+t/
 3yFpNf0dC7H5dBvzcy7CNUx99RcNI9ylEiC2x7/wuZOmWEuY2RZWiOAk98AXGy64lDYc
 A2zg==
X-Gm-Message-State: AOJu0YzU4jfu3nchjn+iOJDQtYYhj1QHMt8+WRnuQJwsvGCRjzZFASvu
 43dY7AJFgbK2ZB6/6O9KafgVMCEC0gW7pOV1p61YFQ==
X-Google-Smtp-Source: AGHT+IGuUVu8B6RMBQO5SAHlZSO+rI3Prp0pji/F3INchAoUk+f8v7CkO3gSwAnfLQgjQIcdm0T3/N0dTswy0036m6E=
X-Received: by 2002:a17:907:da1:b0:9a2:248f:aac with SMTP id
 go33-20020a1709070da100b009a2248f0aacmr1059631ejc.16.1692888092555; Thu, 24
 Aug 2023 07:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230824030304.1555547-1-sjg@chromium.org>
 <66f15744-0b0b-743f-8ad3-8448d78812f6@ti.com>
In-Reply-To: <66f15744-0b0b-743f-8ad3-8448d78812f6@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Aug 2023 08:41:19 -0600
Message-ID: <CAPnjgZ3MFkrR6qNTqgF1AMHun0DrMK2RfZ_6X824eczBXyEyNA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
To: Neha Malcom Francis <n-francis@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, 
 Ivan Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Walle <michael@walle.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com, Nishanth Menon <nm@ti.com>, 
 "Raghavendra, Vignesh" <vigneshr@ti.com>
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

Hi Neha,

On Thu, 24 Aug 2023 at 06:26, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Hi Simon
>
> + Vignesh, Nishanth to comment on this as well
>
> On 24/08/23 08:32, Simon Glass wrote:
> > In this early stage of using binman to produce output files, we are mostly
> > seeing people using common extensions such as '.bin' and '.rom'
>
> [...]
>
> > The fact that the .pem files are at the top level means that they are
> > output images, which surely is not intended. They should be buried in the
> > image description, at a lower level, as part of something else.
> >
> > So please take a loke at the above and see if the binman descriptions can
> > be reworked slightly to follow these new rules.
> >
>
> I think this can work... but few concerns.
>
> 1. Our output binaries also include <image>.bin_unsigned, would extensions that
> aren't "standard" be added to the list if they are truly output binaries? If
> not, changing names for them may be a long stretch (pinging Vignesh and Nishanth
> to comment here).

How about changing them to image-unsigned.bin ? That is a convention I
am trying to follow...so we have the file type last.

>
> 2. Can it be an option to not enforce this, to support users that may make use
> of the intermediate binaries?

This does not apply to sections within an image, which can still
produce files. But those files won't be preserved by buildman unless
they have a supported extension.

>
> Also if we do move forward with this, we will need to sync to make sure that the
> changes to the affected boards come through as well.

Yes.

Regards,
Simon
