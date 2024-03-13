Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21656C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 13:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 491C587DE8;
	Wed, 13 Mar 2024 14:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R6ikSAT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E329687B07; Wed, 13 Mar 2024 14:20:28 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BACF787B2A
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 14:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dcc4de7d901so5708108276.0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710336023; x=1710940823; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3FY6hXwpS80ckr+vOzIaBLFgLdEP5m4MglglDYWF+U=;
 b=R6ikSAT1bl1vlnilwOZPmrxjmF99jI/0E3AbL1rfI2hOMybGRgPKUGHpETwLd/qkyC
 iKhkcoRF53GDx3fDM8XvZP7pgbozrXEKREFsfWVna2AxsrkR0M/gC40nrzM2LpJX/q1F
 2r3kRczt4hHwjy3hiGdk5zDkA0Ncg1+q0yLK/eRMO3A7mXvqe2RheRoI2hn26p3IGMk9
 Wm/0LJ9GjQE9lhtKWSmZHOMNT0Y8abSKgRpWWDPJjWnmQeLukilHeTy8flzQSe9Wmok8
 xTqJ0oOFER/ss5r3rxysW4bHeLy5OLqk/7UTWqMOqMNATecferxlqAGJlc4QAocCde5A
 J/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710336023; x=1710940823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3FY6hXwpS80ckr+vOzIaBLFgLdEP5m4MglglDYWF+U=;
 b=B1DCzqMRqZ/AbsYpCVMfTJrO+ZRE4sEAjhyhNRq5Rv+mesQR89Vw6FDO2XaBByD1Dv
 75RH7uhC68F4UkDezmixIH0HYxkZUncAgKgKn9/TgGRUgPLxN/d5ef2TlFPfGhj6ORnA
 E/wvPopsiBC84wceoOdc70z9kvUcuy87Ja8EwTEfDMvXX1wHe9EglRYN6fya8oimJqDj
 648mO/zkZ45zG6LH6v5Zf+Qc4sZent7EcJY3Az/LLSWWWiXF7jEbjyW2EM784WyHbgxk
 ArWZPYs/XfBXSPNkPVgZ/fCiD6BUG8PFLeWtbrUiqtFWxv5BqzRujNXjZPOyJlsHEW8g
 Vm4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSfPIx03Xt2JivYRb0Zbv7z5+w2vTfJ9szcolb848dzJ/RfooiJONU+kvcqM/Mto8uzTjb3SETUYRETUfyDXf+Z/+OwA==
X-Gm-Message-State: AOJu0YyyJOSLV8nADVbGh9bTgl/GC1YPO2/fSm0HRJWRfxT3vBGmATy1
 YBd9PO34ryhmWKDhWIzmsHy5dmPytg0xrALE3FHnEFpTbHmLE7PR5CQswdFcMEvDhvHAf0vUE3S
 lpX8RVC7lBz4aHZgt31Qkocq7ScN9eS5VmjzpYg==
X-Google-Smtp-Source: AGHT+IH5Y7ei7ndcfOuZx8FsCf78D6niatmV/1xkc+bFXe1pi0ZPL2fA3HO3HOoy1UZaoCtKThCLbwxQlzqf2vagRsk=
X-Received: by 2002:a25:d8d4:0:b0:dcb:d8d1:2d59 with SMTP id
 p203-20020a25d8d4000000b00dcbd8d12d59mr2295386ybg.38.1710336023450; Wed, 13
 Mar 2024 06:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240312190543.3544532-1-tharvey@gateworks.com>
 <CAOMZO5A8m5gW+MgD8RWrtsd3kpsMaj+cV5CLHuvUkux7daD1jQ@mail.gmail.com>
In-Reply-To: <CAOMZO5A8m5gW+MgD8RWrtsd3kpsMaj+cV5CLHuvUkux7daD1jQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 13 Mar 2024 18:50:12 +0530
Message-ID: <CAFA6WYNV60m4Nv7tm2jCqqYFn9_=WTKmctUrGppCnKA30dxiRw@mail.gmail.com>
Subject: Re: [PATCH] imx8m*_venice: move venice to OF_UPSTREAM
To: Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Wed, 13 Mar 2024 at 06:46, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Tim,
>
> On Tue, Mar 12, 2024 at 4:05=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
> >
> > Move to imx8m{m,n,p}-venice to OF_UPSTREAM:
> >  - replace the non-upstream generic imx8m{m,n,p}-venice dt with one of =
the
> >    dt's from the OF_LIST
> >  - handle the fact that dtbs now have a 'freescale/' prefix
> >  - imply OF_UPSTREAM
> >  - remove rudundant files from arch/arm/dts leaving only the
> >    *-u-boot.dtsi files
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ...
> >  33 files changed, 13 insertions(+), 10658 deletions(-)
>
> This diff looks great :-)

+1

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>
> I will queue it to u-boot-imx/next soon.
