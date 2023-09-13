Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F26EE020A
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 19:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C653D8692B;
	Wed, 13 Sep 2023 21:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XGGp1uCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E3178691E; Wed, 13 Sep 2023 21:57:11 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20CD38692B
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 21:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so307263e87.0
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694635025; x=1695239825; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79RukufjoUteZm6tFfbiGS37+6n10wGELeAraxy+Gpk=;
 b=XGGp1uCiflERF6UKH9c8khPN4Lw0JbFsCrHHrRSl7EP6xsUwX8OH2QMajeKJWPyDW9
 v95SIsdEgLnWK0fVyUWuQ1Usoy35a+GJPEW9X6Xw+Uc14TV+S0b6w7X2ZKutTTaP/lro
 CnWmjShzYS0OcfmFjo4SufKfiaXapqWSn9fmcU2EBP/TsMu/ohW+1hSZKTvdWEtuBnvu
 9cW8JHSk98wj7FZ6/xQPEoqtloHAjIoZHnTKQEMOXiBC/IgGKAA5/+W7rTV8PkfxuZOm
 n6Fhaii9vKTKqC6qKOg/XoXouC0aX9AtVYkLIziMsmqDVAlFBv5zUpcpP8QqkLLm6qXn
 qTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694635025; x=1695239825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79RukufjoUteZm6tFfbiGS37+6n10wGELeAraxy+Gpk=;
 b=qptVMBIzojzCUpructedxLRDLPU/bB57rfjv5Um4O2R+L/lZjQCCDCNvSkGtINKOR2
 MCkjafQy6xFgp/U5gYy4XLMBwpsW1R+IQZ43evERlv8e0dLs6CLvRY2/mRjcg0NHWvuZ
 /F9F1GGWt1yQfgA8IxXedV9JH2P9ANHTct8Am79NkY7uAyxFG4wtqkz6YGei14ZnXvJU
 kECYlTLqeE4xoUcYXbJWLMqTTfD8k/9meQkPfk64+tpfxAjpy+RDuDIcdJ6A8f+fh5t2
 SGEDTSgvZCDiGH4hQnvpGycrky8fpAL3I5h1UVxBBOtFI4pMzH1hdD+BF2vbPulfsz9z
 Blow==
X-Gm-Message-State: AOJu0YyufGll0x3FwbfJINpfGrQcSTunCQ6rQN0rkSFHkcJFQbW3zw3X
 8fMUYL0sscis6dBSaZs0LJ/EV7/R0zx0KEIA73w=
X-Google-Smtp-Source: AGHT+IEPB9nd3bT7B6Q6dGQ8b1w6CNx77/+rZN+jf8wcbCR97fLhhxCplbIR0OJDLbsF35jlwQ6mWFMQZdSRaMBY/kg=
X-Received: by 2002:a05:6512:21c3:b0:4fb:89cd:9616 with SMTP id
 d3-20020a05651221c300b004fb89cd9616mr2713849lft.0.1694635024928; Wed, 13 Sep
 2023 12:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
 <20230913162217.GN305624@bill-the-cat>
In-Reply-To: <20230913162217.GN305624@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 13 Sep 2023 12:56:53 -0700
Message-ID: <CAJaLiFw9btZtcro_qqtYqTJziZwLuUJ=0QAuu+E5=Ooux4-WkA@mail.gmail.com>
Subject: Re: bootstd: CACHE Misaligned operation errors (Marvell Armada 385)
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>
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

Hi Tom,

On Wed, Sep 13, 2023 at 9:22=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Sep 12, 2023 at 12:38:00PM -0700, Tony Dinh wrote:
>
> > I've been testing the boostd for a few Marvell boards and seeing this
> > error on the Thecus N2350 (Marvell Armada 385, dual-core CPU). The
> > "bootflow scan scsi" command triggered the "CACHE: Misaligned
> > operation at range" error. However, this error did not affect the
> > result of the scan, i.e. the bootflow for scsi partition was created
> > correctly, and u-boot is running normally.
> >
> > Enabling CONFIG_SYS_DCACHE_OFF got rid of the errors altogether.
> > Perhaps this is a case where the DCACHE is not required and should be
> > turned off?
> >
> > Please see the log after the break below.
>
> Can you please try -next ?  There's at least one SCSI related cache
> alignment fix there that's not in master, thanks.

Unfortunately I got the same errors. This time the ranges are
different, of course.

master:

N2350 > bootflow scan scsi
CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3fb99f=
88
ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb9a38=
8

next:

N2350 > bootflow scan scsi
CACHE: Misaligned operation at range [3fb80388, 3fb80788]
CACHE: Misaligned operation at range [3fb80388, 3fb80788]
CACHE: Misaligned operation at range [3fb80388, 3fb80788]
ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3fb803=
88
ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb8078=
8

Thanks,
Tony

>
> --
> Tom
