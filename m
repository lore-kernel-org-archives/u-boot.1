Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA76C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 09:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B189C807D7;
	Fri, 21 Mar 2025 10:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ok/Jjx8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC19808A2; Fri, 21 Mar 2025 10:53:01 +0100 (CET)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB593805C8
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 10:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-51eb1823a8eso831126e0c.3
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742550778; x=1743155578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NDoaHmdyZVehc2Dg3/xIFE4jG64+lac+3i7hX0WXhFk=;
 b=Ok/Jjx8aul9FIcBPNZE8j81nakVYbkKFiHmmXNFbdsXBMY5n36S/tZGhhzQYZcjjLD
 gFyO1lZV0KxQU4uoDR4il2iQ1kFHsrVGRZV2I2fRldPlY50kjOS5MsT4SK/1DN79ADDq
 FR6M7hMGtzRMuS2+vfNeYlRN4AMP0oPtaEAMCqN2oqWI+7YBoBXmboq6c5UPeuBt8AQF
 GN3qc7xUrXtrMGZKRU3C82/uDuG8Ur/kM+rpTbSJQR0CGZ450QMN7CL62oNRQFEp8nhw
 zgMA97Vz9TogKIx2xpc+CITBz7PSEnkHXUBIDuIqf9nXAbbLYnGcZ19owd6FG9HVBFzV
 +giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742550778; x=1743155578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NDoaHmdyZVehc2Dg3/xIFE4jG64+lac+3i7hX0WXhFk=;
 b=mNhPJOerXAALIe4l3WolaoLwq/VbAnvtz+LHvYSkXP6FUsw3+0g/FZg1yiT9U5C7W8
 q/6n5KlKUaC20X4EqXEHWyHYzRe071t55iEvh6VCs2dN5s5yXoyRu5HaP3707eqSEMOU
 nvCz8J2Vr8l1Xr0hPlyhRsZQhCUQiYtJDkPK0KDJ4jx45lGaACp5Q560qBUVbvqqeYiI
 U1XxgXlRosYuxKSaQScgr5vFbqUJtrx3dJp9q37WC34RBhrrZS4zrbW7c/8Qo5UY/tqW
 zRD8I2FfNyWqMlcqsRU3MEtinay8XC1GJE0V451wJIyCMtWoslqAmBy+aDI+2I1t1E0A
 I2iQ==
X-Gm-Message-State: AOJu0YyEiE1Q2XH65zS9HSbBkLYEHsOTo9s23hPN9o6KG+4vx5C20DzL
 kBQtm00eHklCe0BUVaw6PmUjH+pO1tsnvqUV39XJjWijr32zL/NCX9yblNHlpJ2jZkiFNo3jE0l
 l59pWhB9dKZ0LQPotNregIUPG5bQjgoZXhzXc1A==
X-Gm-Gg: ASbGnctfDseBIox2t6MeOjHuf/NYcuXQ6Qfe71revcJALH27XK7C1Mvgl7tGmcgvzXY
 BIp05vEy52p9BgHEap0+AvONSidYnSVNR072kz6BGXiYyewji057gfu7aoYJ3yfmODodqkeNgd7
 gob3yJgWfi6Q7kGcNNI7LYCKR7dwQ=
X-Google-Smtp-Source: AGHT+IEiGZ5zAAlMh596rBnslBcG6Fp8dyouVP55ytXR9me1qI7D4jpJwUk2omZnxiX1CXdE+HWsmjZNj/fO3mC3cSo=
X-Received: by 2002:a05:6122:1989:b0:520:5a87:66fa with SMTP id
 71dfb90a1353d-525a834239cmr2262782e0c.3.1742550777561; Fri, 21 Mar 2025
 02:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com>
 <CADg8p96oba52R=nSKFg8hprE-BYNNtSuOkswLNi4raW1W770dQ@mail.gmail.com>
 <fbad5d5b-2b69-4004-bc13-9bd0e73d3278@amd.com>
In-Reply-To: <fbad5d5b-2b69-4004-bc13-9bd0e73d3278@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 21 Mar 2025 15:22:45 +0530
X-Gm-Features: AQ5f1JrNxygePvb_6ivA8hnmfCAv0FWZ8qu3J1qWt7-aJ2Lkgy4bEfPdoIkf9Xo
Message-ID: <CADg8p95ETeJnz0xa+4UXyqwciWOJ3un8geEn1_3A6PbPEA_pUA@mail.gmail.com>
Subject: Re: [RFC PATCH] cmd: fwu: Dump custom fields from mdata structure
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Etienne Carriere <etienne.carriere@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Fri, 21 Mar 2025 at 14:09, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 3/21/25 08:40, Sughosh Ganu wrote:
> > On Wed, 5 Jun 2024 at 20:25, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >> The commit cb9ae40a16f0 ("tools: mkfwumdata: add logic to append vendor
> >> data to the FWU metadata") added support for adding vendor data to mdata
> >> structure but it is not visible anywhere that's why extend fwu command to
> >> dump it.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >> ---
> >
> > Looks good. Just a couple of nits.
> >
> >>
> >> I am using this for some time to check various configurations that's why it
> >> can be useful for others too.
> >> Sughosh: Maybe there is better way how to dump it.
> >> ---
> >>   cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
> >>   1 file changed, 25 insertions(+)
> >>
> >> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
> >> index 9c048d69a131..ff6435505167 100644
> >> --- a/cmd/fwu_mdata.c
> >> +++ b/cmd/fwu_mdata.c
> >> @@ -7,6 +7,7 @@
> >>   #include <dm.h>
> >>   #include <fwu.h>
> >>   #include <fwu_mdata.h>
> >> +#include <hexdump.h>
> >>   #include <log.h>
> >>   #include <stdio.h>
> >>   #include <stdlib.h>
> >> @@ -45,6 +46,30 @@ static void print_mdata(struct fwu_data *data)
> >>                                 img_info->accepted == 0x1 ? "yes" : "no");
> >>                  }
> >>          }
> >> +
> >> +       if (data->version == 2) {
> >> +               struct fwu_mdata *mdata = data->fwu_mdata;
> >> +               struct fwu_fw_store_desc *desc;
> >> +               void *end;
> >> +               u32 diff;
> >> +
> >> +               /*
> >> +                * fwu_mdata defines only header that's why taking it as array
> >> +                * which exactly point to image description location
> >> +                */
> >> +               desc = (struct fwu_fw_store_desc *)&mdata[1];
> >> +
> >> +               /* Number of entries is taken from for loop - variable i */
> >> +               end = &desc->img_entry[i];
> >> +               debug("mdata %p, desc %p, end %p\n", mdata, desc, end);
> >> +
> >> +               diff = data->metadata_size - ((void *)end - (void *)mdata);
> >> +               if (diff) {
> >> +                       printf("Custom fields covered by CRC 0x%x\n", diff);
> >
> > It would be better to mention that the value being printed is the
> > length of the vendor data. Or not print the value.
>
>
> printf("Custom fields covered by CRC len: 0x%x\n", diff);
>
> >
> >> +                       print_hex_dump_bytes("CUSTOM ", DUMP_PREFIX_OFFSET,
> >> +                                            end, diff);
> >> +               }
> >
> > Would be better to do a 'select HEXDUMP if FWU_MDATA_V2' under the
> > CMD_FWU_METADATA config.
>
> I think select is too hard here because hexdump is implementing empty function
> if HEXDUMP is not enabled.
>
> imply HEXDUMP if FWU_MDATA_V2

Fine with me.

-sughosh
