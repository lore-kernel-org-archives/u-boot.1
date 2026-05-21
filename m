Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84103CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA3C846EB;
	Thu, 21 May 2026 17:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lMm0kuPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA016846F1; Thu, 21 May 2026 17:38:50 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86BD846E7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 17:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bd8faef2e18so620241366b.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 08:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779377928; cv=none;
 d=google.com; s=arc-20240605;
 b=P6mjBxg/MnNaQSEqWX0PzBlMqDGWURie7zcOwUrssEPMMBsDaf0+takSWJr4FF2a+x
 xq52BC4/pkIiZ/VYCUvjFQv7Q2nBybP14HkFQBVY86/ZNJ9Ao0LeobiN6BqXZTIUFXc7
 eVQn4+hrOYRuHQmbq4LMovks9t08TxRfkngPotWpBeGEHA5+/93x8ekb63dtO9bCox53
 3yt+nvegyz9UoP4Anh5YgFSj/e1MvIc+udNevGBLl496euwBx4CLp8nMJ7Ix1aMO8Yu0
 xBNE9un4DDUTyzMCAQUOXSW46JeOw5TirL76szp06UC0xU05bQAAexua3ttsPdLnLi+E
 utcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5SLZg8MSV0b9+QUshF6s35KxxUJ4M1Jt2sSpGw1Doac=;
 fh=SaD0tZ1cEisCKRSCrMo3pzWcN7NHA+bo/e19TasHSqA=;
 b=jO57JN093Y4k4j+Ry/rohB3SkVajWJIcpDDoYdlXAn/dceiQuu/kmefGpHNbc68nfJ
 j2E6ikilNK/9PsIPBzHiQqiM36Ow6pNWr69BOh/gBor/OBhCwnp5eg9dHE9e61uUlRY4
 lMBGUvf0h/dEecXfK6ZXH05y5WghWI9xrt4VZ8v4KbPIjFGhcu7Hezx3cPSPJ3U5QV4T
 ZP3tvJ4rKulOutWdQl6pDLcrxEzk9UDayhj1Cnc7MX8qCdS5WxbiFQy4zXhmUzHdnbzZ
 SC/tEft11rb8g+bu5MvYuaS+daAPJbHQCsA0YYc/u3CAhRz66iWIdCWJSwSdla+P0KRO
 tHIw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779377928; x=1779982728; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5SLZg8MSV0b9+QUshF6s35KxxUJ4M1Jt2sSpGw1Doac=;
 b=lMm0kuPIwurgY7CFVRICM0DAmdThb1byrWhJjrU81bvpmkeAdMH61Q8WsSGD9NeuSx
 DhKUeA9koXPslZmOU07oD9CDo9CA1CzYxlCaCW0I85tfkYiFgYZzt089PkC6HsaftOA7
 SRZUvE/93xBZgs0dTrM/sfyn8oIIzDW5Po6Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779377928; x=1779982728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SLZg8MSV0b9+QUshF6s35KxxUJ4M1Jt2sSpGw1Doac=;
 b=Zd5MYTklkcE5Mib8j/b36CKBZmKsKCayVxUqcaaI9kHCJYBeG8isUqh51il3jnKIk4
 eTP6HXLdMrvWloFhOBgAvSt4AC3DwLSeSnZmeZ5GbB8Hqdk4Ha1uM1RbGgLhgjCBhqC6
 tuGnqEc0Ei/4ym+I2o+nDP1cT5fua69clqF7D9h4w3Vi4piqxsC4azuiBGd6PTydreh0
 hytDraTFfL/6HBiLXRus5jvl1op8EDxm49Fb9v/Z6Q32YGnVQi/kHCJM1fyqi7/cs/hX
 eXSMhP7EargT0WWKt3DbBuC3Mw515ojGOvryGn5a2OK6cyydDkZzyvWoPvLZJYDVUiLo
 oOUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qPeLurfDksESqbGIH15t/zyvCPrU5N2aEqE6TAFFMT+HGXO6cnrWQaqNApQ2H7HzjuggaD4I=@lists.denx.de
X-Gm-Message-State: AOJu0YwGKb57XUqHxrMqZIwPm/ePLex2giS+YCg2qisz1PTE2Hqxvz4w
 5c+7L1uFmlv6cRfmxe1mPoH4TMnCjaGmF5rZcMdhl7efc2rCgGuky7XbVBghn3bYtJAZ5hIItfY
 UcHzHo4Ec3vgULiXy1x2hpdLYjx2FE1XyHbtmDNyW
X-Gm-Gg: Acq92OH4IGaKKPNK8zvvo1jE6Fjg6MPXb6+Ht5AvkRsi+7Wf/Dt4MF1F3VJpw2YEaxn
 XTrOrV86HYU9EI3Ux7BXhlL+AydYU3Ie/ezEdBlZyi6fO2JVuafh8XiUk6my/PNb8RGZeN3wxd7
 InPCPRRVNtcOyby6Rmb/NIsYvE1VXCebZmjz+/ybnJVRBQVOvd6LlH+X/lA/JTzsLRfW/5cQVTi
 tZ0L3t2oW68MqFPTT/RqTi0UM+ash4c1lu+urKhcqCNeIsxgpl9Y4t99//t8mBWWoj1sXWdnSxZ
 iAW7AQMVi55iTEhDfg==
X-Received: by 2002:a17:907:c70b:b0:b97:1d24:c004 with SMTP id
 a640c23a62f3a-bdc13e8b3a4mr237352566b.21.1779377927804; Thu, 21 May 2026
 08:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
 <CAFLszTgZ=ciSU-ny1+X+8jYsvRD-jc-TVQ3WwfyZ3DYvmR81Ug@mail.gmail.com>
 <73acbfa7-43aa-4d65-b7ba-1824fda3b348@canonical.com>
In-Reply-To: <73acbfa7-43aa-4d65-b7ba-1824fda3b348@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 May 2026 10:38:33 -0500
X-Gm-Features: AVHnY4JdReHmsOJezTh6Jf5rqupT1C2ZliBTRLLzPaCY0wb57v_uuDdrhKnNgls
Message-ID: <CAFLszTiO2TCmT=aD3L7bMG5zNNeoXKBmwf0OCEZ_F6aLSAXqsA@mail.gmail.com>
Subject: Re: [PATCH 3/9] fs: ext4: print change date in directory listing
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Huang Jianan <jnhuang95@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>, 
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Daniel Palmer <daniel@thingy.jp>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, linux-erofs@lists.ozlabs.org
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

Hi Heinrich,

On Wed, 20 May 2026, 19:46 Heinrich Schuchardt,
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/20/26 22:42, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 18 May 2026 at 00:57, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_generic()
> >> displays the modification date alongside the file size:
> >>
> >>   4096 2024-03-15 09:30 filename.txt
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   fs/fs.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/fs/fs.c b/fs/fs.c
> >> index f8e4794c10e..482a5523712 100644
> >> --- a/fs/fs.c
> >> +++ b/fs/fs.c
> >> @@ -261,6 +261,9 @@ static struct fstype_info fstypes[] = {
> >>                  .fstype = FS_TYPE_EXT,
> >>                  .name = "ext4",
> >>                  .null_dev_desc_ok = false,
> >> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> >> +               .caps = FS_CAP_DATE,
> >> +#endif
> >>                  .probe = ext4fs_probe,
> >>                  .close = ext4fs_close,
> >>                  .ls = fs_ls_generic,
> >> --
> >> 2.53.0
> >>
> >
> > I would prefer having a head-file macro which expands to nothing for
> > xPL builds, rather than adding preprocessor macros.
> >
> > Regards,
> > Simon
>
> Hello Simon,
>
> In the internet I could not find what a "head-file macro" might be.

Sorry I meant 'header-file macro'

>
> As struct fstype_info is not defined in a header file, a preprocessor
> macro defined in a header file would not make sense here.
>
> Do you mean something like:
>
> #if IS_ENABLED(CONFIG_XPL_BUILD)
> #define FS_CAPS(flags)  /* empty */
> #else
> #define FS_CAPS(flags)  .caps = (flags),
> #endif
>
> static struct fstype_info fstypes[] = {
> #if CONFIG_IS_ENABLED(FS_FAT)
>          {
>                  .fstype = FS_TYPE_FAT,
>                  .name = "fat",
>                  .null_dev_desc_ok = false,
>                  FS_CAPS(FS_CAP_DATE)
>                  .probe = fat_set_blk_dev,
> ...
>
> A line without a comma in the initializer is easily mistaken as
> incorrect. I am not sure that a code reviewers life is made easier with
> defining a new preprocessor macro.

Firstly I wonder if it is actually worth making the field conditional?
We have a null_dev_desc_ok bool which could be turned into flags, if
you are trying to save space.

Ideally we would have a new Kconfig for this, so it is possible to
enable the feature in particular xPL builds.

If you don't like the example above, another option is:

CONFIG_IS_ENABLED(YOUR_OPTION, (FS_CAP_DATE,))

which we use in quite a few places now.

Regards,
Simon
