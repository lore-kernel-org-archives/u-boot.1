Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87DFC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 10:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CFC87911;
	Tue, 26 Dec 2023 11:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KeJqbGj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A4E8783A; Tue, 26 Dec 2023 11:09:44 +0100 (CET)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D24A8786A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 11:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-466df7eb9cdso543021137.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703585380; x=1704190180; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pM1adoCyOq4ljhY5ce4+5eZzlBSxkIQeb/I/Pvs9lF0=;
 b=KeJqbGj0iHd4CDzpLH4G64jlEnCyjk9eNLmzGPKdhtV4adBWUsZ4P5FPCAFU/ILp+6
 IWujTlIRfOlnoey72Z87sjM00JxGXlv7O1OyH0nahxYoetEWZb3S3V8+fXsYafYOgxMn
 neRXaZ7EihNZCayAzsavA3o6TLWMI7oK3Vw0GKlQSW3GpSbz7gY1YhCbnNo1x/5XB1nx
 VUxDVXJJwwoCh6IskBI8i91GZH6jB0BN9Qeu4+Hz68gHCb61WAcyDeWWSuZPc1ZQVOPx
 1z7ciyI8ZDwzHJi6yyGy5l/tzZgWcXGzQUwAT1+j7x051QyC5nPV1CRATnQqd3xgD4Cp
 ktsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703585380; x=1704190180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pM1adoCyOq4ljhY5ce4+5eZzlBSxkIQeb/I/Pvs9lF0=;
 b=RVmWLAaoOU5rF//Uc/RQAU3V3af4tV67JXLjLKB7UsORBq5jwd6N8YbOQXxE17cLa5
 d3bjOkJOyDcbyLKHEpbfYqgl+Ahm/Ukm8+2Le6n05fnw6LEidZzqPCZLEkxCam44n63q
 CmHcFfRMWHpzmQiXO9byVKeHIVxg38fs5tiwhy79a7zdn1tpL7DwQPHPmqA1icS8cdyN
 VEKxSD6dU0alQeaD+RGPu6dM/4QOk4QbBcKS7xYgMYnRGApdpjd78R3Sjx7JpyHwCcUL
 xtdJfN1MkX0numWAbO05+n6u0mtIdVDHxEmPlKq+J7hpQ4cc3YdgV3axEvQTtnxABPIR
 sMPw==
X-Gm-Message-State: AOJu0Ywt3fQsjLQmbMajYCG1lau6Der0GJUhf9OOu7kb6x4+qzzw2PwK
 HL4gP36qTXExUOkjmOXurcq/4Gr10utA60FH9BhQOXEZG6+sWQ==
X-Google-Smtp-Source: AGHT+IE/UYcm/QEO3M+rUR7DbFRQP2Qoi23eeNOF23tiXaXRyBHalE9fOGAL8BmPaY8VAqlnwM0c++lDyC92ev4yvKw=
X-Received: by 2002:a05:6102:209b:b0:467:5c0:132c with SMTP id
 h27-20020a056102209b00b0046705c0132cmr410326vsr.5.1703585380236; Tue, 26 Dec
 2023 02:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-4-sumit.garg@linaro.org>
 <CAFLszTiPbM-fofbNaTO3vtTWNTOee_pO7-_obKxmP=oChD-8oA@mail.gmail.com>
In-Reply-To: <CAFLszTiPbM-fofbNaTO3vtTWNTOee_pO7-_obKxmP=oChD-8oA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 15:39:29 +0530
Message-ID: <CAFA6WYO=2Ba7FsXh7=Eg_J77w=sVmxOC-_=XNQH4JaquQoBPSQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Fri, Dec 22, 2023 at 6:12=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > Allow u-boot to build DTB from a different directory tree such that
> > *-u-boot.dtsi files can be included from a common location. Currently
> > that location is arch/$(ARCH)/dts/, so statically define that common
> > location.
> >
> > This is needed for platform owners to start building DTB files from
> > devicetree-rebasing directory but still being able to include
> > *-u-boot.dtsi files.
> >
>
> This is a v2 patch but I don't see a change log?

I usually prefer to keep change logs in the cover letter [1].

[1] https://lore.kernel.org/all/20231222061208.3009970-1-sumit.garg@linaro.=
org/

>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  scripts/Makefile.lib | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>

Thanks.
-Sumit

> Regards,
> Simon
