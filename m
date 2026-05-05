Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8C2CD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 10:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C8B8487C;
	Tue,  5 May 2026 12:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nePa4UN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A46848A1; Tue,  5 May 2026 12:48:47 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF76B8486B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 12:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dea20cf21aso4784863a34.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 03:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777978124; cv=none;
 d=google.com; s=arc-20240605;
 b=RacRpFyDLwdlzxTYSkIInd3nlsjSC3/NqG8vINOcLxxTZysXBugyyOay3WC6JQo3tG
 tQ4MJ3MERJJmgunzdtAwxLroVPMdcx7rvNth37/QehTIT6TIaB06h/AZUP9Y5XeFAWIS
 04+RGOYxOUJemh1guHg/UFMz/dzh3hW4ejUrYv6a8y63/HpQcGxhCbH4I2cc30Ejdx0f
 /S/5sW+7OREVvDf4JL+JcTxJpmaeJAfZBAn3bidzlf8sCV8jGbCGhLgY85t9CJg1eX95
 Mwt3RnkYSFH1lcFNMNCBBKR2iSaSOgxDRaNI1OoUU3dQ71P3t63ZdtjtSGp+Uh55VCZo
 +GpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RLooTjS8OS2aslXbdf/L+Q48kkbBBzSwP2j5rt+Cfy8=;
 fh=W4JgJSzjULev0XfUEVRF+lX3adx0KsOVAOAukof8Ri8=;
 b=KMxkx1Y2AnmJWmrucBYfAGVDouSw06dtcJdjzOPHyB7vXYYQUbJT1GjqkTijkaX9kt
 db/C73eB5wz67rTevYP1U9nHTrHP0a1phhSKxMeLAu2TyIcvkOlMgOdWv705RgmTfjmx
 NT9KbOdkgROUFWwwiNanw8SEAPgEZxdNFZ/fyaUTO1d4OaaqFPXopdAw4svNI3kyLu55
 ZleRJ+SMPI9I0yvR8qPV8+2EK+To74JEqVNS8+aAkGWXtHMJhRIxaJbPgpFEgwbP3U+D
 LmLS9SYY7Usz+ogg+zGncF81CPtybJsJjrjWLs/3gm/ZEdWGEZCBF9ns3RQbdFk7J7d1
 C8Vw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777978124; x=1778582924; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLooTjS8OS2aslXbdf/L+Q48kkbBBzSwP2j5rt+Cfy8=;
 b=nePa4UN+n8ndLyNaQPYA+PqAqB5M1IQPH/Yo4c5UlvFkueDIRJ5r0YQLty1iGCvU4+
 2QUPV+JlirKn9RkRisyp6pJIh6IazN5KyWRPZxbjAAWq7YnnB3XaZgpznIEz0gwjCmg/
 TF9xzs51Mfy/7wSPfN182IGCwTaBqXIjnQe974VkwGfPrXwHY8SgJ4UCEcHBmmOkBxRB
 FxgWr3LAu1sACgWGVQggofkHkudIKm2HTSm3jetHwmQVffmaSksmN4iHaORixXZkNwUx
 VAAR89fmjZlgPBeolH9n9EC5zuNvw8Kitb20IskQyrv2qVGBUzb3pCWvjsXO0XzXKPgg
 C14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777978124; x=1778582924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RLooTjS8OS2aslXbdf/L+Q48kkbBBzSwP2j5rt+Cfy8=;
 b=AgVC40SAnjz7SXQ/Sdnsl6/+elCsKwfaOHEp6x2IJC8rDg1bQXsJQpRlIWZq0Mtxhu
 2Hq5B6JWZcRJJfw4d+CaRmEL3zRAK4Vas8MHxxSOBEb5bz2yfvknWUghkkgZIxCgVfrn
 b0Hhmno99RoXTCP1ghKZMjJ+TdkNGFDi24XQnclJYVF/U8EhE3YR4+XHuFWhO4zdrYUg
 EwgSoO8JjZA0vGP/Y0kwsfLWeCFKoDB2gDfVBrpHItq/KefSbAlcsBa6Zd2uNy0VwnsK
 OhDkah8AInI8E7zbs8Ma8euT/HOv7CHWg+inlCXto6CmwxBHn5o5rNrR9/rcxjHihuIL
 gNZw==
X-Gm-Message-State: AOJu0Ywm9p/+F8QtPPx8FPnZ6ZrxqS3BQtr6UhC2QeqXA5EWt44UTwwH
 8SEhUWl/OlXbnqsV3yUaXkvahEHJRA15xyvkJqWKTKbFYBHZnjm3+sxPfGHFRVFCzT2gom3MOgG
 lsjOrnyoCjpmNeEMVlsyPBkwiigK80aw=
X-Gm-Gg: AeBDieuBecRbKJXt2C+kU1rgAlscK2rU2Se07XsVphiC8Fq85ckJjoJUwEawy2ywido
 V2bfb2hPDNis0+THnCtqoCqX3qE1jr2OVu8jaAn7JWDPGni8DAo1OAO+bgE4jaWJKEQlNxwuZ6I
 OSJUSEtkphpcGvrR3fgJaxqZNDi5FoXjuUp1V0pGk5TUYjiLWMoSZ7xv2JTY8R0e90AtqLLOun1
 FPZ2yaG7f4FapWlGnxEY7BWPB8HV0IATOPhSkmQ+4Yk2TGvLBWz4TsC+MIwpXBEzqrUwN3AHKW7
 l/9J5lOeB/V/7W7TFg==
X-Received: by 2002:a05:6830:83b0:b0:7dc:cbaa:d730 with SMTP id
 46e09a7af769-7e17cebd8b9mr1358411a34.8.1777978123639; Tue, 05 May 2026
 03:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-2-alif.zakuan.yuslaimi@altera.com>
 <5ce3b23e-97a7-46b5-a0d6-2ba28d7a2c68@altera.com>
In-Reply-To: <5ce3b23e-97a7-46b5-a0d6-2ba28d7a2c68@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 5 May 2026 18:48:31 +0800
X-Gm-Features: AVHnY4IwmGHc34ABjLeFJxcXsxqaVbN9WN4Fwf0igezughBAg5y3p1JaUp1npgk
Message-ID: <CAN7C2SBzyO3xV=OB8cX_L2rbV5Q+y0fPrxPeDbeD_8bb4PCRsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de
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

Hi Tien Fong,

Disregarding to the code issue:
I am curious that aren't someone do mentioned the:

- Per-version change history must be placed below the '---' separator.
- The required format is 'Changes in vN:'.

???

So suddenly all these high standards immediately disappeared from one
patch to another patch?
Interesting =3D]

Thanks,
Brian

On Tue, May 5, 2026 at 1:03=E2=80=AFPM Chee, Tien Fong
<tien.fong.chee@altera.com> wrote:
>
> Hi Alif,
>
>
> On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
> > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >
> > Relocate the dram_bank_mmu_setup() implementation from misc_arria10.c t=
o
> > the common socfpga misc.c and update the function to correctly handle b=
oth
> > pre-relocation and post-relocation cases for DRAM cache enabling for
> > consistent MMU/dcache setup across Arria10 and CycloneV platforms.
> >
> > These changes help to improve maintainability and consistency of DRAM
> > initialization as well as MMU configuration for Arria10 and CycloneV
> > platforms.
> >
> > New Kconfig is introduced to enable this implementation only on the def=
ault
> > Arria10 and CycloneV boards as this will increase the SPL size which
> > will exceed some Gen5 devices' SPL size limit.
> >
> > Fixes: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before relo=
cation")
> >
> > Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > ---
> >   arch/arm/mach-socfpga/Kconfig        |  1 +
> >   arch/arm/mach-socfpga/misc.c         | 31 +++++++++++++++++++++++++++=
+
> >   arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
> >   3 files changed, 32 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kcon=
fig
> > index fb98b647442..e2fdd6bb30f 100644
> > --- a/arch/arm/mach-socfpga/Kconfig
> > +++ b/arch/arm/mach-socfpga/Kconfig
> > @@ -115,6 +115,7 @@ config ARCH_SOCFPGA_CYCLONE5
> >   config ARCH_SOCFPGA_GEN5
> >       bool
> >       select SPL_ALTERA_SDRAM
> > +     select SPL_CACHE if SPL
>
>
