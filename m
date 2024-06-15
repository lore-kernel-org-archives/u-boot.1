Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC75C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 07:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A16A4879AF;
	Sat, 15 Jun 2024 09:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QaTSNs1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7150E87CF1; Sat, 15 Jun 2024 09:02:29 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239648796B
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 09:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f6a837e9a3so19216615ad.1
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718434945; x=1719039745; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qN+QmmQSkNstkrKygkqmNx9awU3GWhtjT6q91bJsgqk=;
 b=QaTSNs1lpG4oKMlIkO+kNG+N/xa/S1OMk54yrXzCoKAimlxR8v6BLMRI1ta4VPmczk
 fi0FVRP3eW1TmkMAKMCHjLbrDGjcxDpoJE986CbIwTtYC2jcxzxIHZHvPEtnqJwLsjqQ
 naIM0D8be7E8ffHxAWGQ5AxmYFlFZFGJqU9Rc2BkVQ0SihjhBTm+19Qsovv6OPRoUa0B
 O04meqGE6Rf8CrvtN1dLBjesZX1jBZa6v7VvHigpgKYtZPB+O5R5AGvOk0nejlBO4Qw5
 16lL1PP5lmRHvx+wNCiHLKqYghZymihA36R7QtgT6qqeV3Xphg6EbJlqeNyDxNRmlu/Y
 3idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718434945; x=1719039745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qN+QmmQSkNstkrKygkqmNx9awU3GWhtjT6q91bJsgqk=;
 b=r+LwJg1sx4/0erGGuC95ZgGuwLgvnRte4jUFG7Q6qUqWmDgxL8PqmIXatUJ0r4x50j
 WNmDT4ehUoMZLqjzHjVj38/nrMOZMJI+pdfxwe5ib2bTVZj4mfwHk/ZtAa2rqtG2izI2
 3Qq1++B4tlQZMaCAlFZ0gzrcHlp+G+Yb/W2+Sgxv1ASXU/DCxCibOLgShBLf/PhcpVzn
 3oDB1fhAI07dZKwlul2DwK1EHMgkiSsBtFsloM6YZf1IZP8HfNFTw4AxRU+OIiUt6S/H
 X0tRfBIxlitnhKPbCK9RKSsw6WbQenx5auM7f1uyUyer4DqNcqW3bi3MkOmXYUwwGcPQ
 n76Q==
X-Gm-Message-State: AOJu0YxNKtr4FqZHJJ0z3gHG4kihcYRsYwYgjVyQLk6kADqiZWzruGYQ
 aaj9WMZ0ElUtQ8uIKQg2o7oOiVsljfgsYM466XinnUOiVM6nk9idj47MDvg3M+qk5GIefmp3GSH
 RlQwEsDq1du9tvSnP8D+Ak7BkFj5WBqnBg9bT4Q==
X-Google-Smtp-Source: AGHT+IGz7JpyjIITnJRJFvN8YEZiGhQXlni4KkEh2hmpz9tARv6dUb1+bp/SFsjhaadWZSZgEWxukxOmWx0Y+9n2lYY=
X-Received: by 2002:a17:902:f691:b0:1f7:c33:aa9d with SMTP id
 d9443c01a7336-1f8627cac4amr51360295ad.34.1718434945387; Sat, 15 Jun 2024
 00:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-3-sjg@chromium.org>
 <CAC_iWj+fSRt2E3ZcHaXrKjC+Gz7LZu_EWgiegWG3F1MJMJrPNQ@mail.gmail.com>
 <14ae7a31-757a-4220-b2a8-20204e3d7aa9@gmx.de>
 <CAC_iWjKAQwLobcO8virDKKD8cQ4j7-OAzn2nriNmdGUtMRKXnw@mail.gmail.com>
 <8b6f5ad8-911f-4954-8b48-333986be0bf8@gmx.de>
In-Reply-To: <8b6f5ad8-911f-4954-8b48-333986be0bf8@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 15 Jun 2024 10:01:48 +0300
Message-ID: <CAC_iWjJsMQqADGuETbYZdaB-+TiSCsjSV4CKFnit3Rjk9JVYBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>
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


On Fri, 14 Jun 2024 at 12:04, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 14.06.24 09:01, Ilias Apalodimas wrote:
> > On Fri, 14 Jun 2024 at 09:59, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 6/14/24 08:03, Ilias Apalodimas wrote:
> >>> Hi Simon,
> >>>
> >>> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromium.org> wrote:
> >>>>
> >>>> It does not make sense to enable all SHA algorithms unless they are
> >>>> needed. It bloats the code and in this case, causes chromebook_link to
> >>>> fail to build. That board does use the TPM, but not with measured boot,
> >>>> nor EFI.
> >>>>
> >>>> Since EFI_TCG2_PROTOCOL already selects these options, we just need to
> >>>> add them to MEASURED_BOOT as well.
> >>>>
> >>>> Note that the original commit combines refactoring and new features,
> >>>> which makes it hard to see what is going on.
> >>>>
> >>>> Fixes: 97707f12fda tpm: Support boot measurements
> >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>> ---
> >>>>
> >>>> Changes in v2:
> >>>> - Put the conditions under EFI_TCG2_PROTOCOL
> >>>> - Consider MEASURED_BOOT too
> >>>>
> >>>>    boot/Kconfig | 4 ++++
> >>>>    lib/Kconfig  | 4 ----
> >>>>    2 files changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/boot/Kconfig b/boot/Kconfig
> >>>> index 6f3096c15a6..b061891e109 100644
> >>>> --- a/boot/Kconfig
> >>>> +++ b/boot/Kconfig
> >>>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> >>>>    config MEASURED_BOOT
> >>>>           bool "Measure boot images and configuration when booting without EFI"
> >>>>           depends on HASH && TPM_V2
> >>>> +       select SHA1
> >>>> +       select SHA256
> >>>> +       select SHA384
> >>>> +       select SHA512
> >>>>           help
> >>>>             This option enables measurement of the boot process when booting
> >>>>             without UEFI . Measurement involves creating cryptographic hashes
> >>>> diff --git a/lib/Kconfig b/lib/Kconfig
> >>>> index 189e6eb31aa..568892fce44 100644
> >>>> --- a/lib/Kconfig
> >>>> +++ b/lib/Kconfig
> >>>> @@ -438,10 +438,6 @@ config TPM
> >>>>           bool "Trusted Platform Module (TPM) Support"
> >>>>           depends on DM
> >>>>           imply DM_RNG
> >>>> -       select SHA1
> >>>> -       select SHA256
> >>>> -       select SHA384
> >>>> -       select SHA512
> >>>
> >>> I am not sure this is the right way to deal with your problem.
> >>> The TPM main functionality is to measure and extend PCRs, so shaXXXX
> >>> is really required. To make things even worse, you don't know the PCR
> >>> banks that are enabled beforehand. This is a runtime config of the
> >>> TPM.
> >>
> >> If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is selected, U-Boot
> >> cannot extend PCRs. So it seems fine to let these two select the
> >> complete set of hashing algorithms. As Simon pointed out for
> >> EFI_TCG2_PROTOCOL this is already done in lib/efi_loader/Kconfig.
> >
> > It can. The cmd we have can extend those pcrs -- e.g tpm2 pcr_extend 8
> > 0xb0000000
>
> So this patch should also consider CMD_TPM_V2 and CMD_TPM_V1.
>
> TPM v1 only needs SHA-1.

I still prefer to leave the TPM in a working state tbh.
>
> In cmd/tpm-v2.c do_tpm2_pcr_extend() and do_tpm_pcr_read() assume
> SHA256. Function tpm_pcr_extend() shows the same limitation. This bug
> should be fixed. But as is CMD_TPM_V2 seems only to require CONFIG_SHA256.
>
> Best regards
>
> Heinrich
>
> >
> > Regards
> > /Ilias
> >>
> >> Even if U-Boot does not support measured boot (EFI or non-EFI) we might
> >> still be using the TPMs RNG.
> >>
> >> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>
> >>>
> >>>    So this would make the TPM pretty useless. Can't you remove something
> >>> that doesn't break functionality?
> >>>
> >>> Thanks
> >>> /Ilias
> >>>>           help
> >>>>             This enables support for TPMs which can be used to provide security
> >>>>             features for your board. The TPM can be connected via LPC or I2C
> >>>> --
> >>>> 2.34.1
> >>>>
> >>
>
