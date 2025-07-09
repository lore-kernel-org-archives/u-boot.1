Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ABCC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 11:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5DB83443;
	Wed,  9 Jul 2025 13:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ELB2JwRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4B283447; Wed,  9 Jul 2025 13:55:42 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE6D8003E
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 13:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4a77ea7ed49so9981261cf.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752062138; x=1752666938; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QzClhIfa3SZ/+lMiQwhs2L0UK++wZd9k+rDufNAPIt8=;
 b=ELB2JwRGyTcwjsJVlEgXzaa9GrxrleMil+qQe2d1EsMJ54gwZ163+rC0G6W+16wXyj
 FXZl7PVMmca7DdxZ9D4tuXd1hHOA1OalLGUY/6tfUWoId80W9ROnjUc/6mYIFmSRpORA
 MKlZdCDKkIxf7Tsl+6hs+0S/tz92+GBD7tA6HcK/DgSx4aaZ7R/uFU1ksVkiwXaFQD3Y
 eoy4xw2ZjNGjtTAH2woIlKnHKKhP45QtCJ++B8YIhwausq/gxzCXZufCOZNcD5JMJG2T
 F96oBd/Mjgc39MSfoL7Mxqep3R28Nx4BczhVURpk3IjEtgeQ/cuRGkqJZAa5uu/rLQtw
 Mi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752062138; x=1752666938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QzClhIfa3SZ/+lMiQwhs2L0UK++wZd9k+rDufNAPIt8=;
 b=SstiiXn8NxCKX4US46ogYUd04LBsVQOEG0mM31AkAaA/5hexv/IrJo/zrm/m5dzmmJ
 +MePCaXLEhBge62v+L3SdW6PlUb+wP4Lidn7vhHacY5IeXE0cZgrK7i5FOC2tBd41Gdh
 5ZVnELToWHGRND9acUHdeCTnedz36smFGEIG3m5FDrEoL9+02u/zlPXZd5XT4krwfePz
 zGSr83xEiwKJO3R0fP05+R5/E2zcPIV1zGddo7VgySfTUBmccfc9aXoir/GyimCvsUKe
 Vjt6YQr5ugjBgwbKivPTNrZrcrAnvSEmxVVlhwQRztNSeJdVt1ZF9pytieS4ctpLLndy
 rJGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUda0Eywrcg1dLGjqjhQkp+uf4xqW9YTEnehKROqEJ5+ENZAuqLOmj4pdBCeq0Er+AYkGUGjBY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0lUNukmIyt2SUnw/JbQwdUO6Nk02gUCmydIKGJdGVeppS44RF
 VF9Z0r05+lMyk5hAkCmzmLEUC9xKZ4gmRL6XjfkKvcuazgrR/w2jw4VIYn8o42RFeqapsvypEPi
 bpALF0Nb4+KEhsgy7k1jnNUnfGEm0zis/h6BPMWzNxw==
X-Gm-Gg: ASbGncu4dS/YFVJ6CNn+oAMLOneGDJzm46fHoM5+EE4PqXfE3bD4rcHt+tQ85VDqSbg
 dzSVxRVL1MtEtFrdE0bXhojw40tQQdZSaJI5SMAn3fZz163U6/irQvQGecNENwGdnDmg+w1Os9T
 HRhcUC+GMIMcUbyikS+SF3bTmZLpWyFw25PLB798wEjGA4
X-Google-Smtp-Source: AGHT+IFstvg2RsQf8GxU6M/d3OrzfQbOr7DjqlXMAmaSBE8pZXgDAJ+B70de2tzV6fOfRfCaOaHhIwDDnDzqbcQUQ4o=
X-Received: by 2002:a05:622a:5e11:b0:4a7:817e:c345 with SMTP id
 d75a77b69052e-4a9defcfec6mr34210151cf.24.1752062137667; Wed, 09 Jul 2025
 04:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250708114851.78109-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKCtmN8Pn4VRNKRgH0OXymtp8=vc0J_q=MxTDLvTXgSxw@mail.gmail.com>
 <c2b30b63-8920-4c74-a154-09d676de12e0@canonical.com>
 <CAC_iWjJ5Qt5M=1-zP3UV-y+roWskC4hjb9rc58F7KVcAmwma+A@mail.gmail.com>
In-Reply-To: <CAC_iWjJ5Qt5M=1-zP3UV-y+roWskC4hjb9rc58F7KVcAmwma+A@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 9 Jul 2025 17:25:26 +0530
X-Gm-Features: Ac12FXy3BKr9RgS65hKsQeEP0vMAxvJDzbvS1cJYZ3Yh_sCl8xV00VX-DIDcYQ4
Message-ID: <CADg8p95ntXXf_TsWqW=6NPYTEMndV9qn0di1L=J-ewk4vaCg2g@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: add missing check in FMP.GetImageInfo()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Casey Connolly <casey.connolly@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Tue, 8 Jul 2025 at 18:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 8 Jul 2025 at 15:20, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 08.07.25 13:56, Ilias Apalodimas wrote:
> > > Hi Heinrich
> > >
> > > On Tue, 8 Jul 2025 at 14:48, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> The UEFI 2.11 specification, chapter 23.1.3 requires
> > >> EFI_FIRMWARE_MANAGEMENT_PROTOCOL.GetImageInfo() to return
> > >> EFI_INVALID_PARAMETER if *ImageInfoSize is not too small
> > >> and ImageInfo is NULL.
> > >>
> > >> Fixes: f27c20148511 ("efi_loader: add firmware management protocol for FIT image")
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >> ---
> > >
> > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >
> > > That being said, we need to double check the FIT capsule users. I
> > > think we can probably remove it in the future.
> >
> > It is not clear if you mean the check or the FIT version of the protocol.
>
> I mean EFI_CAPSULE_FIRMWARE_FIT and the code that manages that
>
> >
> > efi_firmware_get_image_info() is a protocol implementation that may be
> > called from anywhere outside of U-Boot. We should not remove checks
> > required by the UEFI specification even if our internal usage of the
> > protocol would not require them.
> >
> > > Are you aware of use cases that FIT supports, which we don't support
> > > from the RAW variant?
> >
> > Maybe Takahiro remembers, why both RAW and FIT were implemented.
>
> It's been a few years and maybe my memory fails me but....
> I remember we added FIT for the authentication since we didn't have
> authenticated capsule update support. But we do now

I had proposed earlier, when I had added support for capsule
authentication, to remove support for FIT capsules. But Takahiro and
Simon preferred having this supported as FIT is used extensively in
U-Boot. IIRC, the FIT based capsule update is pretty unique in the way
the components of the FIT get written to the storage media.

-sughosh

>
> Cheers
> /Ilias
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > Thanks
> > > /Ilias
> > >>   lib/efi_loader/efi_firmware.c | 2 ++
> > >>   1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> > >> index 75501e21557..216df83de67 100644
> > >> --- a/lib/efi_loader/efi_firmware.c
> > >> +++ b/lib/efi_loader/efi_firmware.c
> > >> @@ -332,6 +332,8 @@ static efi_status_t efi_fill_image_desc_array(
> > >>
> > >>                  return EFI_BUFFER_TOO_SMALL;
> > >>          }
> > >> +       if (!image_info)
> > >> +               return EFI_INVALID_PARAMETER;
> > >>          *image_info_size = total_size;
> > >>
> > >>          ret = efi_gen_capsule_guids();
> > >> --
> > >> 2.48.1
> > >>
> >
