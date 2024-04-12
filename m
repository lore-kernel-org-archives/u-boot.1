Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9223BC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 09:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB5986DEE;
	Fri, 12 Apr 2024 11:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bBTin6HK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337C288005; Fri, 12 Apr 2024 11:41:09 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F036886DEE
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-479e57ff63bso242699137.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712914866; x=1713519666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HlFTUA9EpcA9vXnK2b5nJaFUTDU5dAQl2jWV3PlCgbo=;
 b=bBTin6HKmFO2VCbCy2djZxURe/L9dbp77keTgukUUSAk8M4gwa2Za20o1AEuZZoNct
 3K/gql6NauEZUcqodrpK86jJv1b7Jb2dsW4pKiF/wR2nsBeFvZT9czI2HW/p5s32wOgb
 rQBuPq70qoN2erkD18hosft4O04dkw3Tjs0j/+RRG7L36Agd/+aD4aSUGJYzHenlmDUQ
 cN3ozRaJWTIPo2ThtNERu96XEkX7iC1i+dmhtqO/bEjwKDZ4fjf+ZHn2LsA9hPOdJS1q
 VktRpu6lQxhn85+vLjaM7eg9fNpl0gBLMtBJH0DoaX3T3K4ss8YNoHC1fhe6c5qLStQM
 +Igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712914866; x=1713519666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HlFTUA9EpcA9vXnK2b5nJaFUTDU5dAQl2jWV3PlCgbo=;
 b=Qa8iFea0aqrYJj9z6ZEoFIWg87i5qhnkjJcjQSKlVBcibxEoFTyfY5V7k+udmy+sz7
 tJZizJS5crCc5i38UDX2HS3B10lhM/eduMeA38+S5fKd8a7m12ikExwXHTCQuEp0gCTz
 lBgd4mysNCQ1MQaT+XG25+4npMDfUuWsXyyhZ6flAoA+FgBgoySULlG8T/bIcufSfkSo
 NpRTB/YZ8KIZ5bFGK1TgrUYggD2wG+BRyGW+qo2lOEC8Q3lEbnlFrKG7lLZ9ae9zk8rO
 OV9evjp7EcnwYFE2isqfldTTmO8Zy1VLG0pJ0KZSlljVeBDhgToylvDWTbiGIy88s1nr
 +5/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuATFeLxH5nxtdWBQMKRlPU4nWRSlbr4LN1Saa5aV1gdKlcPg1cl0nJLllDr3qUYyYr1Q/GbEdIqSugmF8xw2du+vgqQ==
X-Gm-Message-State: AOJu0YzPkgAJrJDzba+bVIXiPhpJM/zW4kHG22lnzOftX9k9aYVSGrMl
 Mff3qdO1Ik5d3XnEELZFE9BzX2f/LHWaQETqjfXrTBpr44BUGQF2EmPX1SYCqBwtJpfv2xVpfx7
 bl06jPHtf9Joty/BJqHp+qUJrvEGgugeDqU7PUg==
X-Google-Smtp-Source: AGHT+IHveJlKbxKGvmPGzZ0uFQ+0jTcf3VViGNIy5TUJaMo/3wF3VcilfKujAc8fI7qxGAV12s471PRumJXm4iI7560=
X-Received: by 2002:a05:6102:38cd:b0:47a:72f:981a with SMTP id
 k13-20020a05610238cd00b0047a072f981amr2540753vst.26.1712914864244; Fri, 12
 Apr 2024 02:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
 <20240409-b4-qcom-mmc-fixes-v1-1-5039164ecbf7@linaro.org>
 <CAFA6WYO+3VroUdFUVH390taViQX8pMQrOQDTSn0yU6BD5YY53A@mail.gmail.com>
 <e98e2da6-ddd4-488c-8244-b868bcf3164d@linaro.org>
In-Reply-To: <e98e2da6-ddd4-488c-8244-b868bcf3164d@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 12 Apr 2024 15:10:53 +0530
Message-ID: <CAFA6WYOXH_0G+AYxX6YKs_6QJ_MJEXP7VJ5yHuAHKvg6FvjqSQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] mmc: msm_sdhci: correct vendor_spec_cap0 register for
 v5
To: neil.armstrong@linaro.org, Caleb Connolly <caleb.connolly@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de
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

On Fri, 12 Apr 2024 at 14:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 11/04/2024 15:59, Sumit Garg wrote:
> > On Tue, 9 Apr 2024 at 23:33, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> The V4 and V5 controllers have quite varied register layouts. Inherit
> >> the register offsets and naming from the Linux driver. More version
> >> specific offsets can be inherited from Linux as needed.
> >>
> >> Fixes: 364c22a ("mmc: msm_sdhci: Add SDCC version 5.0.0 support")
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>   drivers/mmc/msm_sdhci.c | 11 +++++++----
> >>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >
> > This patch broke booting on the HMIBSC board, have you tested it on
> > db410c? It's very likely that this has caused regression there too.
> >
> > Error observed:
> >
> > sdhci_send_command: Timeout for status update: 00000000 00000001
>
> Indeed swapping the core_vendor_spec_capabilities0 between msm_sdhc_v5_var & msm_sdhc_mci_var
> fixes this and I'm now able to enable SDCard on the SM8550-HDK

Yeah this fixed the problem for me too. I am unsure how it worked for
Caleb on db845c.

Caleb,

Can you fix up this patch which is already in your tree already?

-Sumit

>
> Neil
>
> >
> > -Sumit
> >
> >> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> >> index 059cb3da77c5..f23d425144ef 100644
> >> --- a/drivers/mmc/msm_sdhci.c
> >> +++ b/drivers/mmc/msm_sdhci.c
> >> @@ -32,11 +32,8 @@
> >>   #define SDCC_MCI_STATUS2 0x6C
> >>   #define SDCC_MCI_STATUS2_MCI_ACT 0x1
> >>   #define SDCC_MCI_HC_MODE 0x78
> >>
> >> -/* Non standard (?) SDHCI register */
> >> -#define SDHCI_VENDOR_SPEC_CAPABILITIES0  0x11c
> >> -
> >>   struct msm_sdhc_plat {
> >>          struct mmc_config cfg;
> >>          struct mmc mmc;
> >>   };
> >> @@ -48,8 +45,10 @@ struct msm_sdhc {
> >>   };
> >>
> >>   struct msm_sdhc_variant_info {
> >>          bool mci_removed;
> >> +
> >> +       u32 core_vendor_spec_capabilities0;
> >>   };
> >>
> >>   DECLARE_GLOBAL_DATA_PTR;
> >>
> >> @@ -180,9 +179,9 @@ static int msm_sdc_probe(struct udevice *dev)
> >>           */
> >>          if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
> >>                  caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
> >>                  caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
> >> -               writel(caps, host->ioaddr + SDHCI_VENDOR_SPEC_CAPABILITIES0);
> >> +               writel(caps, host->ioaddr + var_info->core_vendor_spec_capabilities0);
> >>          }
> >>
> >>          ret = mmc_of_parse(dev, &plat->cfg);
> >>          if (ret)
> >> @@ -243,12 +242,16 @@ static int msm_sdc_bind(struct udevice *dev)
> >>   }
> >>
> >>   static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
> >>          .mci_removed = false,
> >> +
> >> +       .core_vendor_spec_capabilities0 = 0x21c,
> >>   };
> >>
> >>   static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
> >>          .mci_removed = true,
> >> +
> >> +       .core_vendor_spec_capabilities0 = 0x11c,
> >>   };
> >>
> >>   static const struct udevice_id msm_mmc_ids[] = {
> >>          { .compatible = "qcom,sdhci-msm-v4", .data = (ulong)&msm_sdhc_mci_var },
> >>
> >> --
> >> 2.44.0
> >>
>
