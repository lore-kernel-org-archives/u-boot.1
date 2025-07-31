Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7368EC87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 19:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A855483852;
	Thu, 31 Jul 2025 21:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="neCUqB/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE6A83933; Thu, 31 Jul 2025 21:08:50 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA488349B
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 21:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6197886a6eeso365969eaf.0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1753988927; x=1754593727; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNNp4ScNsicKzBzzVQzC0e0JsRlVJaFf55DHWM0IgrQ=;
 b=neCUqB/plPXqwQng/fDDwfM7oifD3uq9b3VpIg3cPIDw5VRm+B064NlLNyCX5SwdBD
 nBCrt1olwr3y51wDslIlogkBkGHyc9uP60ITh2bGB3Cu8pqKa02N+8CR5jqKJlYQfQOy
 nY3PHxGDAPBt/FtSBIB11Pu5LqKVr6bluacC4pDFu5I4OkqFybWWe/7fUicvXAeT3tk1
 PSx8mg07Fkcnz+G54VZ0yqgDUJF9X/5hO2LfZ6uEihsvj53bzgidABgb3lI5eH2Xn1i0
 lHa1W/NRPH7sTA7jJJMNJf7F7dgxTRXJXd7iYnVf2XhVve/GwXJwRmc9JjJoBhABndto
 WQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753988927; x=1754593727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNNp4ScNsicKzBzzVQzC0e0JsRlVJaFf55DHWM0IgrQ=;
 b=m98rqlrDxMUkrioWf6O6qHkWfJ6vSrBo2qcvHp1Ui5II3rqtFfF0VQgNthiEOjtAAh
 5VZbhwE7sn4eT4orcAM7HlD8vnQVM4xf9UtdHG2AvX5faZvTpvjkD1xrIYLwrR2HagYr
 emmdc6SbGeXFtNJI/GOkAeBALY4EHSAZfACcXbV/9a6Oja3JzrMwgvJR8D3DX2fyRPyl
 sjCqEUnB5TX5Mm25n/pGHtnc+Qx3Hfjlb1UYzxsXscX5vzYXJTkyJPmZKZ9pfsfqkHT1
 pSdeJt6G0IxaZrJA79oDLcahdzasjjsRlf8xdH2TQeZn7c9GKe8S35Gr1LQp5OD0ZDv2
 LFng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWogc+OXDQM4vMCZRkdhLgFUcOREwozL/LpyfQ9loHSvc8GPQeDhWXc5g3ByEfxy9kkCapCdpM=@lists.denx.de
X-Gm-Message-State: AOJu0YznJtda7GeYjb1FxobNw9pPeyM0qRXUVGC+HLsLhlSFzyOdTk2j
 xP30mMIY/0aiEcdnl5RUIun3wfGqLt8neCw8qbGHQ6cHoXQ5ILOpdDtw9UbTtC/w94jEj5kOM2k
 h8YsVOScFAslmSbHQwdM8I9uzupYdiGHea2g06I3/Lg==
X-Gm-Gg: ASbGncsU0HGyNLdfeeWJ+lz56kd0eMapsXtOCG9hdl0FxzjJnlXsb7GZ4xOE37fpyew
 Fn4EMpKJDJ+t1nMEM71AyCo58npIGfN0/RjK5jbYNLZfu4zb2IA0f5uSKanxRe9MCU2LGeoZ2YK
 GLJ48xB0eaXSbh/bGSkq8iaI5AjjXlKJ1e2ns53JcyxfqFKvgRw2jdGuKctxWHHdpCaDQ/k/RjV
 kkKec0=
X-Google-Smtp-Source: AGHT+IFtBMAcAbzRw9krvzqZ3hilua1reJXv2Ui/XTH43W/p2B8hgMu9N1Qxu/aFd3xxiZHgllQlFHS29brW/FONzFw=
X-Received: by 2002:a4a:ee0a:0:b0:613:90e1:729a with SMTP id
 006d021491bc7-619706dbc9bmr2075940eaf.4.1753988926772; Thu, 31 Jul 2025
 12:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
 <20250720-imx95-v1-1-759619b47b1f@oss.nxp.com>
In-Reply-To: <20250720-imx95-v1-1-759619b47b1f@oss.nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 31 Jul 2025 12:08:35 -0700
X-Gm-Features: Ac12FXyElM5MCC-ug0Mrj7QzyuOpSYKvqld57WXogopj63zrn006iy1-ejQjel0
Message-ID: <CAJ+vNU1D80zFTygfBFDstiULGkP2pwSEF1JfTqVQ=3_jECK6Cg@mail.gmail.com>
Subject: Re: [PATCH 1/6] Update VID/PID
To: Ye Li <ye.li@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>,
 Adrian Alonso <adrian.alonso@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>, u-boot@lists.denx.de,
 Frank Li <Frank.Li@nxp.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
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

On Tue, Jul 29, 2025 at 4:19=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>

Hi Ye,

I think a better commit subject would be 'imx: Update SDP VID/PID' or
something more descriptive than what you have.

> VID 0x525 and PID 0xa4a5 already registered as
> PLX Technology, Inc.
> Linux-USB File-backed Storage Gadget
>
> But fastboot device is not mass storage devices
> windowns 10 latest update already cached above vid/pid

s/windowns/Windows/

>
> Change to use Freescale VID 0x1fc9
>
> PID 0x151, for SPL SDP HID download
> PID 0x152, for Fastboot
> PID 0x153, for Kernel fastboot
>

Please expand a bit on why you need to change these exactly.

It took me a while to figure out how the VID/PID's affect uuu and what
you are trying to do here:

The uuu tool maps VID/PID/BCD values to protocols (see 'uuu -v' for a
list) and supports built-in scripts mapping protocols to various
functions (see 'uuu -bshow').

Before these changes for these defconfigs:
- SPL SDP enumerates as 0x0525:0xb4a4:0x500 which uuu maps to the SDPV
protocol (the 0xb4a4 comes from adding 0xfff to the PID which was
indeed strange)
- U-Boot SDP command enumerates as 0x0525:0xa4a5 which uuu maps to the
FB (fastboot) protocol

After your changes for these defconfigs:
- SPL SDP enumerates as 0x1FC9:0x0151:0x0500 which uuu also maps to
the SDPV protocol.
- U-Boot SDP command enumerates as 0x1FC9:0x0152 which uuu maps to the
FB (fastboot) protocol

So with respect to using uuu on these devices the protocols and thus
functions have not changed and what you were really trying to do is
properly use NXP ID's instead of squatting on the PLX ID's for
historic reasons.

Is there any other side effect of changing VID/PID here when not using
uuu? I'm not very familiar with Windows drivers... Perhaps there was a
Windows driver binding to the old VID/PID getting in the way of using
uuu on Windows? I'm not clear what other OS's like could be used here.

> Need update uuu above 1.4.182
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  arch/arm/mach-imx/spl.c           | 2 +-
>  configs/imx8m_data_modul.config   | 4 ++--
>  configs/imx8mm_evk_defconfig      | 4 ++--
>  configs/imx8mn_ddr4_evk_defconfig | 4 ++--
>  configs/imx8mp_evk_defconfig      | 4 ++--
>  configs/mx6qsabrelite_defconfig   | 4 ++--
>  configs/mx6sabreauto_defconfig    | 4 ++--
>  configs/mx6sabresd_defconfig      | 4 ++--
>  configs/mx6ul_14x14_evk_defconfig | 4 ++--
>  configs/mx7dsabresd_defconfig     | 4 ++--
>  10 files changed, 19 insertions(+), 19 deletions(-)

Why are you suggesting changing specifically these defconfigs and not
all imx defconfigs? It seems you cherry-picked a handful but they
don't all look like NXP maintained boards to me.

>
> diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
> index 518d9cb1262..4a86d8698b4 100644
> --- a/arch/arm/mach-imx/spl.c
> +++ b/arch/arm/mach-imx/spl.c
> @@ -184,7 +184,7 @@ u32 spl_boot_device(void)
>  #ifdef CONFIG_SPL_USB_GADGET
>  int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name=
)
>  {
> -       put_unaligned(CONFIG_USB_GADGET_PRODUCT_NUM + 0xfff, &dev->idProd=
uct);
> +       put_unaligned(0x0151, &dev->idProduct);

A comment here indicating that 0x1fc9:0x151 is mapped by uuu to the
SDPV protocol would be handy. The magic 0xa4a5+0xfff=3D0xb4a4 which maps
to SDPV was very strange and confusing for sure.

Should the VID be hard coded to 0x1fc9 as well?

I think these should be #defines in this file.

But, because you are only changing a handful of IMX defconfigs you are
completely breaking SDP for all other imx defconfigs with the above
change so:
NAK

Note that I would agree with not using the PLX ID's in general. Also
note that this patch isn't necessary for Alice's series and can be
dropped from that series.

Best Regards,

Tim
