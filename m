Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691B6E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24B2D80327;
	Tue, 17 Dec 2024 20:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CGft4gJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6738480317; Tue, 17 Dec 2024 20:47:19 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6631C80107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso817943266b.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464837; x=1735069637; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=svxvofsaTykEXWwGKmao/KERoKpYRd2V2UOSHGpbc68=;
 b=CGft4gJXQ4w08PqyHjbIMG8h+htOjaQmjUUelYe4MwMEfLOYqokXa39NKkFjkWdd4h
 DUQcPdoOfPViDLwLPoEMIkTgxLC2aJ1rWlNiTjXoy5jKZoihmZC5OWEGVUdlB2uYis6b
 kfqa3lKe9PI98PoMPZ/xHIoVP8Axd9erg2AV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464837; x=1735069637;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svxvofsaTykEXWwGKmao/KERoKpYRd2V2UOSHGpbc68=;
 b=X6Kw+G027KMkQo6IZmC3Mk4f9XCVXeNMAKpjFSbZGl3+PQVY2sodPICwu86iEanx5R
 WPBqXXXGipre7/2ZGRGyElGOGEK8H0BLdAmITdBhLRBeLsOewBY3FJ33O3lWxhrkpuGI
 ibkw9eAcy5MhCPUa243VP/+9Xrqu54UCtz8zwST/NQWh9js/Y1zM/4lT/dagE9BKARgf
 esdFnd6NFkNkSDuGKuaxqHbtNxAn8k1Y1ym5g49/vufDtFgcLE4WoJ0QxUPkh/RlASRu
 Dulx1TAmUMPYB1z7PSAxaFmUgxyB+JRtmnEsP904FwnOhfQyKV9xe+Fjmwm46RnkJqy+
 0ExA==
X-Gm-Message-State: AOJu0Yx4jMKDhbHcZskh27wYdMIfYJMpwZvSRt3bQEfiSwYeDvDlPjn8
 MyLYoIqhYQBsKCtcXmCExoyJCIGayTeEq0Xzkd+ml9AEWiL85o5DU4cCpTNCgP94Kj82UeCfu5T
 v4LMaHmYwWew8FAZk73hn6AUsB9a61l+gxQco
X-Gm-Gg: ASbGncv2J+VyYZAn6XIvVEOMVHXxmF20FPJdYhyeRdvEidipK76Rg3U2W3mttrMpjqh
 Axp1wyAHPmPgEF/Z3lDs1l08bhtMQkb7MKdKCUZw=
X-Google-Smtp-Source: AGHT+IHLEC4OpFxWLB3Df86wrWDriFTdFivKy0sQD2Dj+cJplgNxquh3xrXAA8w4xvIQ6D0kjF9s+vHwJpWqxmIuReQ=
X-Received: by 2002:a17:907:9507:b0:aa5:46b6:4344 with SMTP id
 a640c23a62f3a-aab77eda8b9mr1527311866b.58.1734464836804; Tue, 17 Dec 2024
 11:47:16 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:13 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTh5465tDrsLWNnS4-xb0sOMRsWf89u2h3_kj=s6Wg3y9A@mail.gmail.com>
References: <CAFLszTh5465tDrsLWNnS4-xb0sOMRsWf89u2h3_kj=s6Wg3y9A@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-19-sjg@chromium.org>
 <CAC_iWj+warnOCWhpp9H4-AUc70Ft-6jRM9tRcZ3yVTKJ1_88FA@mail.gmail.com>
 <CAFLszTgT0tE=fU2W__n1Kz_yoAE32wnMcVOEb99XG4EZCzP3TQ@mail.gmail.com>
 <CAC_iWj+Yjg81CRvgt3hV0wFoudhD_QS4yOBRwBbJ0zq14jb-TQ@mail.gmail.com>
Date: Tue, 17 Dec 2024 11:47:13 -0800
X-Google-Sender-Auth: JWe-TIVxspyycqooTFEBFsf3wEM
Message-ID: <CAFLszTiGef_4s3S9gFMGEHV6w5N8OsSBdwLr1K_P5odzB+2Y1w@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] efi_loader: Don't try to add sandbox runtime code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 11 Dec 2024 at 23:16, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 11 Dec 2024 at 17:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 11 Dec 2024 at 08:19, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > This cannot work since the code is not present in the emulated memory.
> > > > In any case, sandbox cannot make use of the runtime code.
> > > >
> > > > For now, just drop it from sandbox. We can always adjust things to copy
> > > > it into memory, if needed.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
> > > >  1 file changed, 16 insertions(+), 10 deletions(-)
> > > >
Applied to sjg/master, thanks!
