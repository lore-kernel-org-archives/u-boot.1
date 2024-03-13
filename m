Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D05DC54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05EF787150;
	Wed, 13 Mar 2024 17:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="thWCkoTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77C3687150; Wed, 13 Mar 2024 17:31:30 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE8A87E9A
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a466381b411so2508566b.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1710347486; x=1710952286;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bs2IxaLo/JejgmUgoBebzpAxCOrSfEIfheSGaa1XElk=;
 b=thWCkoTLrD2UgfSifI/YINKmBGZ+ZqOJF3tvBEVnMMUgq39L8xeKHQ81Rx5rJBv4p4
 R12oHl+QMZggHu/3uftPvgYbnpz1GiIpNSF0dCddDDJainlVwhOMfdsA29vi91NPIaS1
 zie4KjL1dYIBV5SyrYnG1jIHWPdudn5GYGDosGDAjureaNQVO4hs9KPPLFF+ciFqZfo9
 HGJT+P1ACySxiSS6Xau7++mxXq9IypGHjf68ItQfhyXrFrvxPHvMHV4PBEDgacb+YHiO
 hDhgocLht59Pb8xRe+YzcVB6OBoO+SEDMdrQHni16V6zt3iDtYgg+/3UCjJh+mwmGar4
 1Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347486; x=1710952286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bs2IxaLo/JejgmUgoBebzpAxCOrSfEIfheSGaa1XElk=;
 b=ZVuVmoIc3k6ky3bNFmib7LuCxx2NvT9aOKLnv1I/jMiA/lYCvD9I4GoOTxU8zEM9c4
 B0vT15qnnU7UDTQSw/iQKjOegSxZrfL9of8qgVpauDauYhV6sKuTjI9ZlmeVrEOfN/Za
 cUKogGu3CCEiPrgvEI0ox1pAH24FfQiu3b2w1ZVBF4dJrteiN0SX+3NLc2Zn0ytWOYqo
 QYG1Ku7KiX1E/LOJnkAgP7GTRzJUiTaRQbF6tngUfe4Y6E+nUHwRQThbqvvMwI26YD6m
 FVqBUpLZ/zo56fw8u0hTRxsOKQa9RmGVb9y/XUyGTT/ktFzVGva3pjaylWsog6qOUwlw
 1nAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJzoSI7Yo3TBp0jIR8OsqpTBR2rmh/XLOUJ5zmuuWQ5b/rSbn/5Qje8Pcxu2AnpCQ971iNSg8sAGv3n32lLzyQCpWnSA==
X-Gm-Message-State: AOJu0YyU500o5t6PQ/5tA2jCwTAva1202tZasw+gjfXkcrmKsKUpJhMP
 LWXwlEbdUImWli+GQQzxOloXaN2GOiUjzagRy+9ocdgJfqOx8hFlngvXKDSfJEXrqrCtJknRYp8
 nfZPleGpCRkh//bDpiMxlL5zJEmSBlvIA2sO4Gw==
X-Google-Smtp-Source: AGHT+IEvVwRCvb627/sCfK/1trsaZlL82n6Ztb8vYoNXroZ435n0/7rfD/8b6cBsYX1SdH7Dpb+T7ZEPebUcKzk2Wss=
X-Received: by 2002:a17:907:d041:b0:a46:1cd4:cb49 with SMTP id
 vb1-20020a170907d04100b00a461cd4cb49mr8352470ejc.48.1710347486204; Wed, 13
 Mar 2024 09:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240312190543.3544532-1-tharvey@gateworks.com>
 <CAOMZO5A8m5gW+MgD8RWrtsd3kpsMaj+cV5CLHuvUkux7daD1jQ@mail.gmail.com>
 <CAFA6WYNV60m4Nv7tm2jCqqYFn9_=WTKmctUrGppCnKA30dxiRw@mail.gmail.com>
In-Reply-To: <CAFA6WYNV60m4Nv7tm2jCqqYFn9_=WTKmctUrGppCnKA30dxiRw@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 13 Mar 2024 09:31:14 -0700
Message-ID: <CAJ+vNU10auPr7wp2AGfX7Ei=Z1kf2dQax1Z21Nwex7-bh_cooQ@mail.gmail.com>
Subject: Re: [PATCH] imx8m*_venice: move venice to OF_UPSTREAM
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de, 
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

On Wed, Mar 13, 2024 at 6:20=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Wed, 13 Mar 2024 at 06:46, Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Tim,
> >
> > On Tue, Mar 12, 2024 at 4:05=E2=80=AFPM Tim Harvey <tharvey@gateworks.c=
om> wrote:
> > >
> > > Move to imx8m{m,n,p}-venice to OF_UPSTREAM:
> > >  - replace the non-upstream generic imx8m{m,n,p}-venice dt with one o=
f the
> > >    dt's from the OF_LIST
> > >  - handle the fact that dtbs now have a 'freescale/' prefix
> > >  - imply OF_UPSTREAM
> > >  - remove rudundant files from arch/arm/dts leaving only the
> > >    *-u-boot.dtsi files
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ...
> > >  33 files changed, 13 insertions(+), 10658 deletions(-)
> >
> > This diff looks great :-)
>
> +1
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>

Hi Sumit,

Thanks for your work on this - I imagine over time this will
de-duplicate a lot of work!

I have a couple of questions about OF_UPSTREAM I haven't found the
answer to yet:
1. how do you determine what the last sync point was in dts/upstream?
(ie what kernel version is it currently sync'd with)
2. how often will dts/upstream get re-synced (not the
devicetree-rebasing.git but u-boot dts/upstream), who do you suspect
will do be doing it?
3. how would one go about adding a new feature via dt to uboot when
the same feature has not yet landed in dts upstream? perhaps the
answer is it must land upstream first or do you suspect it would be ok
to put something in a u-boot.dtsi that can later get removed as
redundant? I ask mainly for being able to add things quickly to a
downstream U-Boot repo that lags behind upstream U-Boot

Best Regards,

Tim
