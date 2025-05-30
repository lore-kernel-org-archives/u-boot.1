Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BB4C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF13282CB6;
	Fri, 30 May 2025 17:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="XLS8stCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C34A78334D; Fri, 30 May 2025 17:49:36 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8607D82B0F
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e7dc5f8148bso3186497276.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748620173; x=1749224973; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NT0CxEh38T/gkl1ANZuoBZ0VM7efgk4Mlv8Dw/PcN8=;
 b=XLS8stCN/hOlMI/3fku9o6DsLMwSiieKIlIfiR9osGHSeiROXtu0IQqNWZb2QY9fXl
 fEo5z0a913VQ6n82P4ywi9bdzP/3vvrWJc5V7pFPlhFMMzgBfBEZTf3uQ4m5daQYR21n
 LVq+3P6cARwsSQIc1JboPa/VRV2wWH5N8vj8p6ZBMwyZsw+9N5bEMU+9uiDp6eYyxNc/
 PVt1rbmkMN2F342xX8j/17Rfs6mHGS1SAiLeVSK4rCkfiN/67Z8LC1Hu0cMdQeuXgSqG
 wY5bBwCEcFyAAz62jBuQC8vg7KNAHCjjCteYCD/ejbE7CtWTaaN3/1H/oW+wfdFDJXET
 5AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748620173; x=1749224973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NT0CxEh38T/gkl1ANZuoBZ0VM7efgk4Mlv8Dw/PcN8=;
 b=uVj+NSl1+B0QBr8t42T8Oc1MOfIQkKVDQ48pH5XPC9A+ifds8PlH8OUmWfvGkAosP3
 t+QhtDTl0FpAN3F8V19VgTrwU8HOnY6PeoKWwYW4YgggXlOA+KFRompa8HwsQhgPpyGu
 VwbIcT4BVwrBtOUnP1vMoR99tfHnNlv5eMaYtbmiDjC0Vd9ux0YEjsC+xLt0QhgaaEvL
 y06bDtRvMTIR2MAavEIV/1Xe+V0r26L+CQz3fiaqqJlL0DqAXqPeyDhPuzb7nzw/FmoC
 Dm53oNBZZAPUYTZ9gv7B/y67oNe1hWqoPy6hMPa2FtD12B1AAJPsiwZIPd7Wn8iZkfbP
 uBZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6mIhWsBiRUbdCyE31RfwbNMffq2PUUIPuqmHl2BWp8nDBIz1kOatufZlC/uOyZP0SJwCALaY=@lists.denx.de
X-Gm-Message-State: AOJu0YxLnB/sOCtEZoBDprCaoZlTSbbBMcEMjaxuhVvk15kaUEFA8dOU
 blCfH4K/FTmLlwp+iHxSAR6uxqAvWwIZ48D85IiM8FtZNcC+ahQLxNG27+ckap1AyeadSq3JSt6
 VzVsW9XXi6dJqNW5Wbq3eKASl+T1h0uEVQtC46UEJ6A==
X-Gm-Gg: ASbGncvQEDpLNenz2cTiK8L0dHPJbDYCAeGX4GwTVPON2egwv1aQVGSTBh8kQCJNkvh
 YNbTDAYQ4tjFi6IHNOWwsLYh19cxqQtcErHn0Il9tbSxhlYE4M70dlzz7pWe4g/FFEBTfaFpSWA
 j34roSqnxaZizE7cwKYWOdJD+4FOvtkiqnsghZz2tqINY=
X-Google-Smtp-Source: AGHT+IFd/JZfj5Sz4LC+QIt6tIdgOaPdrxXRNwj2uJRMpzfXleLnmxCe/aeKyA39Oewr+3v7iJeWie81/DsKkHpgPrw=
X-Received: by 2002:a05:690c:670f:b0:703:b47a:7312 with SMTP id
 00721157ae682-70f9812ca0emr56275457b3.15.1748620173245; Fri, 30 May 2025
 08:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250520084120.4175862-1-olaf.baehring@draeger.com>
 <CAJ+vNU1Ge_s4mEFYCn0TPhuKW5X1J-jcV3GyZqc_70GjgsqRtA@mail.gmail.com>
 <CAOMZO5CtK=Z4-60Ny+H8TQqAAT7B3jyqkPs75M7GrtGiq6tfqw@mail.gmail.com>
 <CAOMZO5BiPP9-S9sUsa6quR_gUgo4zwHZH-H81Y=wgpi8uBdWng@mail.gmail.com>
In-Reply-To: <CAOMZO5BiPP9-S9sUsa6quR_gUgo4zwHZH-H81Y=wgpi8uBdWng@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 30 May 2025 08:49:21 -0700
X-Gm-Features: AX0GCFv1-sOvY9UrrYyWdyYEyDkS_ud5y6CYJopH2rbQcAFdodk4kOoYX-DC9AU
Message-ID: <CAJ+vNU3hfouc0zJ63zjU1rqH0_i+BO=a+Htd_UgwiuM9Kxhc1g@mail.gmail.com>
Subject: Re: [PATCH v2] caam: bugfix CAAM error on startup
To: Fabio Estevam <festevam@gmail.com>
Cc: Olaf Baehring <olaf.baehring@draeger.com>, u-boot@lists.denx.de, 
 Gaurav Jain <gaurav.jain@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Fri, May 30, 2025 at 5:13=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Fri, May 30, 2025 at 9:09=E2=80=AFAM Fabio Estevam <festevam@gmail.com=
> wrote:
>
> > u-boot=3D> rng 0 10
> > Reading RNG failed
> > u-boot=3D> rng 0 10
> > 00000000: 27 42 f0 b8 92 c8 ca 29 6f 6a c3 98 ff 61 2b ae  'B.....)oj..=
.a+.
> > u-boot=3D> rng 0 10
> > 00000000: 48 fb 52 44 29 ea 83 f9 a4 1d 68 20 82 c5 af b5  H.RD).....h =
....
> > u-boot=3D> rng 0 10
> > 00000000: 92 63 76 fc 1c 12 4b cd 68 50 8c fa 2b 51 21 50  .cv...K.hP..=
+Q!P
> > u-boot=3D> rng 0 10
> >
> > (always hang in the fifth attempt)
>
> Correction: it does not hang in the fifth attempt. It works on all
> subsequent calls, as Tim reported.

Fabio,

Thanks for verifying from your end. I ran into this when I was testing
lwIP HTTPS as it causes anything that uses dm_rng to fail the first
time (such as HTTPS).

I have never seen the error Olaf reports 'SEC0:  RNG4 SH0
instantiation failed with error 0xffffffff' and I'm not clear what SoC
he saw that on or how rare it was. From the commit log it seemed like
a theoretical fix that may have not been the right thing to do.

Best regards,

Tim
