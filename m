Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFF3C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F0B87AE7;
	Wed, 25 Oct 2023 16:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ty46bsJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F214A87ADF; Wed, 25 Oct 2023 16:28:40 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F99F87ADB
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507a5f2193bso1133480e87.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698244114; x=1698848914; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b/t3JByJGSeTQsoqUxYhBRlXJNUAgTiCAESKWGnBAIc=;
 b=Ty46bsJWmZ1fNCUSdHvoN9VnlzzpS+Z1PFZv+BLNkZaNqw5ZZVN20P/8uVvd7csMzS
 UkPrJfuDg1VoCrnaRcTzqN5Q3+84N/ydQJNH8ly01wF3Yjug6TtawsiYiQW3zuQGRZ1o
 HC1OQiUnfVwSLq2CEhLLC/ABG3s0W8hV3QU8G3B2TBD+evVaD1ewfzx4ilAgVZZ3T04r
 OmuC1HgtkTe9wefjgXMOTEO5FjHjeJ4ojvZuq+bU9J9T59KUuVFw0deBEv1p5rmV4UQe
 CN9/3XMV5+ZwegNQNZAf6UMdH+CPVuW6LUKlOpSGrDZ5M/WMwHK2R5mzow+U1lEwd5AX
 XwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698244114; x=1698848914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b/t3JByJGSeTQsoqUxYhBRlXJNUAgTiCAESKWGnBAIc=;
 b=vXPnoN89CcFKSsJzPeOfZuyqeFJt87NMpOmlp3grJsXkAE87OC9rOU8ksjHs7O2Y+T
 gTBSjSD9MKLEmRMmtcSor9kmeYAEStKtCbR56WaNfP0TJo7uEEEaGQuU1fYfRP9GD1ez
 zWlrpElbODm3kA4KxT/gorT4f6iF2dwOjXhFYlrDqX3ROYpaeIrKX47Jrw2H9COZPGUt
 xy/EvLyYrvH8D7cqb6qw3dR7Ez3PQiuFo2Uo2UYIhrWC86UqIiQP3WRmNPl2YH71M9RP
 wlNR8G/MUdefHbLtOz7i+zcVt5izh3qiXYdKa/CJIByhMyh3YNvmPSMnyBc8PMvi0FSU
 4+gg==
X-Gm-Message-State: AOJu0Yy5X/u65lzPRalS8hMveACHXBhlmjnb+jCGlcGuBldLnVMnKrRa
 BQYM/hAVTL+NKxWL59rUSiuJnqtGafntIU8dy28RjQ==
X-Google-Smtp-Source: AGHT+IFFoDy5ZY2cW1DZsqZB+zSsQtibjlx3p/uZ8aniTV2ZRshM3lp1x99EEdTaZfxHR6ChOBkq4p9CRaQkG5w8Eu4=
X-Received: by 2002:a05:6512:1242:b0:4fe:2815:8ba7 with SMTP id
 fb2-20020a056512124200b004fe28158ba7mr7026937lfb.25.1698244114446; Wed, 25
 Oct 2023 07:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231024154354.197524-1-eajames@linux.ibm.com>
 <20231024154354.197524-5-eajames@linux.ibm.com>
 <0459b591-1f22-427d-9b7f-5422dbe789b8@gmx.de>
 <CAC_iWjKMB4rO7tVh9sy7bd=gFEHeZKcwbM7cGkjSb+JkkLi_8Q@mail.gmail.com>
 <efeab54a-7a97-4e90-9b2b-8865a3b11e7f@gmx.de>
In-Reply-To: <efeab54a-7a97-4e90-9b2b-8865a3b11e7f@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Oct 2023 17:27:58 +0300
Message-ID: <CAC_iWj+_E0LSDNBJY0hqkY71z6Mkh_Un8ebHNzsPP3uP6fbrww@mail.gmail.com>
Subject: Re: [PATCH v14 4/8] bootm: Support boot measurement
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Eddie James <eajames@linux.ibm.com>, sjg@chromium.org, u-boot@lists.denx.de
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

[...]

> >>>
> >>> +config MEASURED_BOOT
> >>> +     bool "Measure boot images and configuration to TPM and event log"
> >>> +     depends on HASH && TPM_V2
> >>> +     help
> >>> +       This option enables measurement of the boot process. Measurement
> >>> +       involves creating cryptographic hashes of the binary images that
> >>> +       are booting and storing them in the TPM. In addition, a log of
> >>> +       these hashes is stored in memory for the OS to verify the booted
> >>> +       images and configuration. Enable this if the OS has configured
> >>> +       some memory area for the event log and you intend to use some
> >>> +       attestation tools on your system.
> >>> +
> >>> +if MEASURED_BOOT
> >>> +     config MEASURE_DEVICETREE
> >>> +     bool "Measure the devicetree image"
> >>> +     default y if MEASURED_BOOT
> >>> +     help
> >>> +       On some platforms, the devicetree is not static as it may contain
> >>> +       random MAC addresses or other such data that changes each boot.
> >>> +       Therefore, it should not be measured into the TPM. In that case,
> >>> +       disable the measurement here.
> >>
> >> I guess the device-tree should be measured before fix-ups.
> >>
> >> A main source of randomness is the KASLR seed.
> >>
> >> @Ilias: How are we handling this in the EFI case?
> >
> > We unconditionally strip the KASLR node if EFI_RNG is installed.
> > efi_try_purge_kaslr_seed() has a useful comment on how the kernel's
> > EFI-stub behaves.
> > In any case, we measure selected parts of the DTB, not all of it,
> > efi_tcg2_measure_dtb() has the details and we keep the DTB measurement
> > under a Kconfig node.
>
> efi_tcg2_measure_dtb() measures all nodes but not the blank areas of the
> device-tree.
>
> That seems not to be enough to remove randomness:
>
> * On RISC-V the boot hartid is random (needed in DT for kernel < 5.18).
> * MAC addresses are random on many boards.

Ah thanks, I wasn't aware of the RISC-V hartid.  I was aware of the
mac address randomness.  The problem with measuring the DTB 'early'
might be a bit tricky. Any idea how early we need to do this? Boards
extend the DT maybe even during their init.  So do we have to copy the
original DT on an address and use that?  Things like that is why we
keep the DT measurement under a Kconfig and it's not unconditional.

> For the boot hartid maybe we should simply not provide it in the
> device-tree if measured boot is enabled. We have an EFI protocol that is
> used in newer kernels for this purpose.
>
> Do we really need distinct Kconfig settings
> CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB and MEASURE_DEVICETREE? Isn't one
> enough to rule both cases?

We don't, but this patchset is complicated enough.  I've done enough
testing and I *think* nothing breaks, but in any case, I don't plan on
landing it in -master.  I prefer -next, so do you mind if we fix that
in a follow-up patch?

FWIW
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Regards
/Ilias

>
> Best regards
>
> Heinrich
