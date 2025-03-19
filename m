Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40C2C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 13:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438628141E;
	Wed, 19 Mar 2025 14:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gT019Woq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A78978193A; Wed, 19 Mar 2025 14:02:43 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA1F881101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 14:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-300f92661fcso7325008a91.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742389359; x=1742994159; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2CUXSDxwKwiscpMBNNZxi+Fypu0JSpyA6DWjg9/vz90=;
 b=gT019WoqAoEovvhgTT7fcaKdAfzVDwyBgbI761Jp2zk8LiwGPg5YBQ/pw87ViLqCHP
 W84Pld6G66eJNVcSsT6LDxtLiNFhzwLnOn1d4jeAMUQK5s1nT4hz/u4wBC/Zhko6wTYb
 rmzqnRvjY/2dcVPZqx1N96UEYy/LIhQqrp12TykKNMhtVNKoRqSuKQ9TLSzoAao0c0uo
 MYWKMRDRldtIIxzUR52Riso2+hGVCErvR+r7xG8f6iMJzF/K89YruN49OiCC0OyTKvWs
 4ECGnyea9H9JJFKGiFh6/KhXzoq6Gwbsz812nTpF0Pv1Y1dTjfd68vYJdXb82zImdqwg
 gWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742389359; x=1742994159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2CUXSDxwKwiscpMBNNZxi+Fypu0JSpyA6DWjg9/vz90=;
 b=gS/G3JNsFvbKO3ZU0gNnqVT2cAC0NeLYIE26EfFSd+L+2RF35TloZP4NxysS2GLqtP
 xDjCcy8A0crAciya08v4XjtDdDVm1EAe4JEBFLIzU4hiLOddIr5Y68ZVEcznjPkq4qYV
 ZMZAsfjaWO92YcmqZmkf1S1YVKQCoQwZPNA2S+utH/ddbEAKk6khVXt7DKkyrjevhvor
 WFBy+D4Y4hEGIp9w+r1XSTswclYbIYpuaRavCnGE1u5+U14ScZTL3/hl0p4rrdIguTLz
 fSJB2qCyjoc+CTb6kz5paRSHUMplsPzvRoIbYriNTkW0rSzgE1EaHevcNIEVpkO2jCA1
 XkTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi1/9g+yuafxlq9AlthO6erglLYwgE9t24ru5LqCuhE+KWUtMntsaNobTbIsDXPt3IYShnS0I=@lists.denx.de
X-Gm-Message-State: AOJu0Yyg+GV2XJpSD4SE25zTSzGXCSbWMF2aU+qdj6im1+MFG9a4bLNq
 DG0hCWJORrSpKqLXKgWrLoDj1/IuLPyvJreA4TYBgk+T/wQzaRibQVVsOMCFwPdEpLeG1ZppI7m
 z48ps5wOj1ZirQGN63vSNZwKdFSc=
X-Gm-Gg: ASbGncs3v7t07C/GyVEdh1Z96TTwBWBcI63AweEUMuQ0ZxdHzuHk9DfjdESDT9pYVAk
 /ETlF97t78cGouFqGMiC7OjDfj1AIG+AVA6n+HQA6YbPCrpWXh7m2dc2DV0WgumJoC76vv8nhdk
 vVBl9vYUKCU9Pi6mliu/ARZdQ2mNnMOdbi42ybHw==
X-Google-Smtp-Source: AGHT+IHkBHErhEgfxxPm7M8P3nh7dytcemL4Bfw8Dr3+0mQqdV0LvUVj4t0I1Qn6krHcK5J4/s8QwRTlxoHkcWJ/ktw=
X-Received: by 2002:a17:90b:1f8d:b0:2fe:e0a9:49d4 with SMTP id
 98e67ed59e1d1-301bde5c92fmr4410955a91.2.1742389359142; Wed, 19 Mar 2025
 06:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <20250318132347.646703-3-adriano.cordova@canonical.com>
 <CAC_iWjKA8tzKdcRSUPWVdDkRNf2GEiz6dzbM6J6A+f788QqyJQ@mail.gmail.com>
 <CAMGU2hXE2gzQs7iibLMB66jJAL5qXm9CGpx5cvJ7AGP5vg8nFw@mail.gmail.com>
 <CAC_iWjJUjpDR_jAKVBg0We9=s=2hvxp7f6Yh8C+KVWs099AL=Q@mail.gmail.com>
In-Reply-To: <CAC_iWjJUjpDR_jAKVBg0We9=s=2hvxp7f6Yh8C+KVWs099AL=Q@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 19 Mar 2025 10:02:26 -0300
X-Gm-Features: AQ5f1JoQXDhIJGwwRNzJsTY93cqXs-588tSxu-uwQTTuEIju5nLk9P-PRCapTO4
Message-ID: <CAMGU2hUV1Ats4H56Tzqd0+RhOzB1i2BRLh5oCx8CNZrjbGRnSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: binary_run: register an initrd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Ok, I will change that in a v2. As a question: in here it is a U-Boot
routine the one that is doing the memcpy of the initrd, the one implemented
in the load_file2 protocol, the OS never knows about this dp explicitly,
could we technically use reserved data in here then?

Il mer 19 mar 2025, 09:37 Ilias Apalodimas <ilias.apalodimas@linaro.org> ha
scritto:

> On Wed, 19 Mar 2025 at 14:07, Adriano C=C3=B3rdova <adrianox@gmail.com> w=
rote:
> >
> > Hi Ilias,
> >
> > El mi=C3=A9, 19 mar 2025 a las 6:32, Ilias Apalodimas (<
> ilias.apalodimas@linaro.org>) escribi=C3=B3:
> >>
> >> Hi Adriano,
> >>
> >> [...]
> >>
> >> >   */
> >> >  static efi_status_t efi_binary_run_dp(void *image, size_t size, voi=
d
> *fdt,
> >> > +                                     void *initrd, size_t initd_sz,
> >> >                                       struct efi_device_path *dp_dev=
,
> >> >                                       struct efi_device_path *dp_img=
)
> >> >  {
> >> >         efi_status_t ret;
> >> > +       struct efi_device_path *dp_initrd;
> >> >
> >> >         /* Initialize EFI drivers */
> >> >         ret =3D efi_init_obj_list();
> >> > @@ -230,6 +234,14 @@ static efi_status_t efi_binary_run_dp(void
> *image, size_t size, void *fdt,
> >> >         if (ret !=3D EFI_SUCCESS)
> >> >                 return ret;
> >> >
> >> > +       dp_initrd =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> (uintptr_t)initrd, initd_sz);
> >>
> >> Why do we need reserved memory? What the EFI stub does, is allocate a
> >> new memory buffer which you later copy the initrd to.
> >> I think Boot Services Data is enough.
>
> I meant to write loader data*
>
> >
> >
> > dp_initrd is freed when the efi application returns in
> efi_initrd_deregister. Do you suggest to change it to
> > Boot Sevices Data and when the efi application returns just assume that
> it is freed?
>
> You will still have to free it on failures which is what
> efi_initrd_deregister() will do once we return from efi boot manager.
> But if you define it as reserved memory, it won't be usable by the OS.
> Since linux will eventually copy that memory in a buffer it allocated,
> you don't have to preserve it. So you can just define it as
> EFI_LOADER_DATA
>
> >  I took the usage from:
> >
> https://github.com/u-boot/u-boot/blob/8bc3542384e3a1219e5ffb62b79d16dddc1=
b1fb9/lib/efi_loader/efi_bootmgr.c#L514
>
> This is a different use-case. In this we download and run an EFI
> application from memory and I guess the assumption is that the EFI
> application will return so the type doesn't matter that much as it
> will eventually be freed. This obviously is not the case if the EFI
> application is a kernel.
> That being said, I think we can switch this to LOADER_CODE as well.
> Heinrich any ideas?
>
> Thanks
> /Ilias
>
> >
> >>
> >>
> >> [...]
> >>
> >> Thanks
> >> /Ilias
>
