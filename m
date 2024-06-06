Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ABBC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A021881B8;
	Thu,  6 Jun 2024 10:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HpGqk3Ea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1490D88199; Thu,  6 Jun 2024 10:24:28 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09286881B8
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f62a628b4cso6591875ad.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717662263; x=1718267063; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NFiZ1YL0QUIcdp7lKMMVK0VRo5hke0I2cGrYTHv8jwg=;
 b=HpGqk3EabaNCqJPiDyexVsNKNHiFqoNqbzAeRuT/J03Fw6jw5qWaXs0pJv4USXpTdq
 rMj+11UX7Z5ug+HVbwZDZVsdYT861J2xQG+OMYeb8ucm8VaSCnBhGDg9fUTnbHR9Lqb1
 ruKRkUu/NQcJfXyU9CWAxRP+yIJDyjXO8e1v/t+KLrcH6jBS+oQVSADsZM9ZpGCSlHTM
 nt6FhVtkULXt8sHTKmFfUFSXrm6kmm1ndNBBfwLpp33iOVg3Mvc5XtQuqaj8BEK4ydFc
 yynRN0cpsIvaiadIJMbnSnL1cf/5Th3qQ+YBk/QWH5Df35tIOT9qscdapcGFdJ5ne2yi
 1oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717662263; x=1718267063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NFiZ1YL0QUIcdp7lKMMVK0VRo5hke0I2cGrYTHv8jwg=;
 b=tKKBqxHLlxGG8mJSdYroYAlxIC+D7V88agjBkQj7rHdxTj4Ii2Gn6HuAMhVURBO+wW
 7T3VQNmNffIZlaDkfI345jNA27JcWDo6S+XA563M1s1Wxz4DADduibwGVpTbzjdDoIKt
 TK6v4MPf/sW48cPCifo1KbP44ERhdjAy+E3znQJXWpy0UjNSRAtdnunOBoFfbwOUHa+C
 i7MW3mTSw54rwNrTWJjD9hfwk1kDeyo3EhJLBFGWImaxe9w600bUvIq/Y6gJI+rl7WVP
 i2QCSlPX0F2xmU41vut0UE6LhTSCTH/urVQ7aWyl1AuIkecy+ORvdTY1BBBxcXKWP0lP
 4FAw==
X-Gm-Message-State: AOJu0YxW9MT4b/TtMR8g3MdrVOZxbOdFU26Xiwax3Lodn43NmuCiqqmR
 4ZH181+LwhHUvtZJ9PBSxDDZ/KMpJ7U/nxoXFc5dWTFcyl7EZHTkxUOBTowdoBETLPohQH0DslE
 kmfXvIVo152QDE2cOKPWytaMrlsOy4Yo2SVxHkg==
X-Google-Smtp-Source: AGHT+IGhtyyxAOpuSvXEH1pQaO+OmTIPlSbf032yqxV4COxzm/XbkhrLdtaI41t7z4TPuqZQk/j+nwBWN/I2Kcn7syY=
X-Received: by 2002:a17:903:4303:b0:1f6:a43:89c3 with SMTP id
 d9443c01a7336-1f6a5a76a53mr36101455ad.57.1717662263469; Thu, 06 Jun 2024
 01:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <0513d382abefaa0cab02bd85e120f544d1ef8e6d.1717599504.git.michal.simek@amd.com>
 <CAC_iWjJc5gO1W8GeNRG3Oo24hVzPope3cisz0R=7_pUTjJLWVA@mail.gmail.com>
 <6ecddda9-0823-4512-b33c-787eef615181@amd.com>
In-Reply-To: <6ecddda9-0823-4512-b33c-787eef615181@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Jun 2024 11:23:46 +0300
Message-ID: <CAC_iWjJo9oiPh55NixeK8pXtQJZb_9xZ-zxSty00Vn87LAmz=Q@mail.gmail.com>
Subject: Re: [PATCH] cmd: fwu: Also print information about size
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Etienne Carriere <etienne.carriere@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Thu, 6 Jun 2024 at 09:38, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 6/5/24 17:09, Ilias Apalodimas wrote:
> > On Wed, 5 Jun 2024 at 17:58, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >> It is useful when structure is also used for saving vendor data covered
> >> by CRC32.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >> ---
> >>
> >>   cmd/fwu_mdata.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
> >> index 3c8be576ac7a..9c048d69a131 100644
> >> --- a/cmd/fwu_mdata.c
> >> +++ b/cmd/fwu_mdata.c
> >> @@ -22,6 +22,7 @@ static void print_mdata(struct fwu_data *data)
> >>          printf("\tFWU Metadata\n");
> >>          printf("crc32: %#x\n", data->crc32);
> >>          printf("version: %#x\n", data->version);
> >> +       printf("size: %#x\n", data->metadata_size);
> >
> > That's only available in v2
> > IS_ENABLED(CONFIG_FWU_MDATA_V1) etc?
>
> This field should be present in v1 and v2 case because it is the part of
> fwu_data (u-boot private structure) not fwu_mdata (which match the spec).
> But I have sent v2 and only printing it in v2 case.

Ah you are right, I was looking at an older tree....

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Thanks,
> Michal
