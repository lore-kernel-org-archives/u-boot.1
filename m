Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C55DC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A1A88AC2;
	Thu, 15 Aug 2024 22:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l5Ikxir1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2289788ABF; Thu, 15 Aug 2024 22:31:52 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B3F88B37
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6bf784346b9so4345326d6.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753907; x=1724358707; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBSRdtku5Um7TC70lEoOEq0TZX3mWlFs7jQ5dlhW6Lg=;
 b=l5Ikxir1mQ2XT4S1ilXt/x1rSbpHn0XftKgSRYtvXnJQo9VWDowuX2jd0VZHxYlV2Y
 rZoB6dfS2VkJfoxPPEGhjDNXYRppF1ZofVqwYNDYmaLQr0pNu26YbWpLLD7ASHe4rcF/
 +/LoLtgxuRiiIoZnl5Z64lJ0LXRRZYJQwfekw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753907; x=1724358707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBSRdtku5Um7TC70lEoOEq0TZX3mWlFs7jQ5dlhW6Lg=;
 b=mT6opYOsnq4fTvrLsX4/Uo1so5EGcPtlFM3fPOsgO1Giazh6SNBBS84CCTjfYgLtW5
 7twrjMvrg9dFmebDF+lazJUz7aj/EpxkfiQU97155oYMTDNpg4OLW8kVPUqVioMMDm+s
 eG+hEXFiUwr+PWS8+r4Ggj4Ru7/WIkc66rZKQKbK8Nnl2FYccrCzyps18NGoIN9MLIrr
 Ykc+TBnXl4T5u0CyRaXEV+DR64Ql48rPsEUFmyOLDrCHbKwc8vq6DuSdfuJP6hxdXg5q
 /COYaEkHY9DbK0YWFQWjko3XTrxKsX5NQO2pBTVd3GRTXfCbOewVbJwvCIjapPRkgqxY
 eBrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYBrwO2youA0kNpVhfDPefWSjcqf1AI1HHo5FA621MJXvddy5GBk549zwTtjmTe4LuJYyDXDDAaZf+nXhqdoBIQCFlYQ==
X-Gm-Message-State: AOJu0YxSPWHU3/88zdZJzl0Y/8ej7R6ZA0NNNlCXS5AA6FwigKqEl/nx
 Pmiuy/2PossfNUsMTnYTMEcWp6N9DGAvlBctjcmg8sDPkkF7yM83H/qYinBzLGDqbdSidmQfOmg
 +DHrNPnaTnL7y9ufs7z7fOu/NH4fYDVaJD6w+
X-Google-Smtp-Source: AGHT+IHPFbh+fjCKv0dvCySdMAfiHfmmoQLqJUcpyj5JVTG5u7JFTxTWR6B92pMcME6XBZU9wPxDoP1xl62pYeAGxaU=
X-Received: by 2002:a05:6214:4986:b0:6bf:6b6e:d148 with SMTP id
 6a1803df08f44-6bf7ce65d0dmr10234566d6.41.1723753906888; Thu, 15 Aug 2024
 13:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgd7S8RQFJnpVfH-wRirrZ0VQ=kN=mK2TOqmHkr85OBcQ@mail.gmail.com>
 <6bf3ab31-7fca-4cd8-bb74-16264a931ed2@canonical.com>
In-Reply-To: <6bf3ab31-7fca-4cd8-bb74-16264a931ed2@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:31:36 +0100
Message-ID: <CAFLszTikcRWpCPAa=dyWNZ0pVP3p4U9ei0S_O6r7gnn3DpesbA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/mkeficapsule: correct printf codes
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 14 Aug 2024 at 06:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 14.08.24 14:40, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, 14 Aug 2024 at 01:14, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> uint64_t is defined as unsigned long long on 32bit ARM.
> >> Convert uint64_t values to unsigned long long and use %llX for printin=
g.
> >>
> >>      tools/mkeficapsule.c: In function =E2=80=98dump_capsule_auth_head=
er=E2=80=99:
> >>      tools/mkeficapsule.c:694:66: warning: format =E2=80=98%lX=E2=80=
=99 expects argument of
> >>      type =E2=80=98long unsigned int=E2=80=99, but argument 2 has type=
 =E2=80=98uint64_t=E2=80=99
> >>      {aka =E2=80=98long long unsigned int=E2=80=99} [-Wformat=3D]
> >>      694 | printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\=
n",
> >>          |                                                      ~~~~^
> >>          |                                                          |
> >>          |                                                          lo=
ng unsigned int
> >>          |                                                      %08llX
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   tools/mkeficapsule.c | 12 ++++++------
> >>   1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> >> index f28008a0829..d346c217f09 100644
> >> --- a/tools/mkeficapsule.c
> >> +++ b/tools/mkeficapsule.c
> >> @@ -691,8 +691,8 @@ static uint32_t dump_fmp_payload_header(
> >>   static void dump_capsule_auth_header(
> >>          struct efi_firmware_image_authentication *capsule_auth_hdr)
> >>   {
> >> -       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
> >> -              capsule_auth_hdr->monotonic_count);
> >> +       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08llX\n"=
,
> >> +              (unsigned long long)capsule_auth_hdr->monotonic_count);
> >>          printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.dwLENGTH\t: %08=
X\n",
> >>                 capsule_auth_hdr->auth_info.hdr.dwLength);
> >>          printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.wREVISION\t: %0=
8X\n",
> >> @@ -724,10 +724,10 @@ static void dump_fmp_capsule_image_header(
> >>                 image_hdr->update_image_size);
> >>          printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_VENDOR_CODE_SIZE\t: %08X=
\n",
> >>                 image_hdr->update_vendor_code_size);
> >> -       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08l=
X\n",
> >> -              image_hdr->update_hardware_instance);
> >> -       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08lX\n=
",
> >> -              image_hdr->image_capsule_support);
> >> +       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08l=
lX\n",
> >> +              (unsigned long long)image_hdr->update_hardware_instance=
);
> >> +       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08llX\=
n",
> >> +              (unsigned long long)image_hdr->image_capsule_support);
> >
> > These should be in lower-case hex, by the way. Also see inttypes.h
>
> Why would you print some lines in lower case while the rest is upper case=
?
>
> I have sent a second version using PRIX64 and avoiding the conversion.

Please send a second patch to convert them all to lower case.

- Simon
