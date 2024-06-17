Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FACFC41513
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6171A882DB;
	Mon, 17 Jun 2024 15:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZQ6IuEGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A40882CE; Mon, 17 Jun 2024 15:53:37 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA878811A
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-633629c3471so20760697b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718632413; x=1719237213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S1/TkD0R9igWkDfpnjZu3ZUNF+FATCmtK0eR7zW9d5g=;
 b=ZQ6IuEGTVvYAEN7mkqiGbafuEtXz0pVs7gNl3Hj76z+2Wk4lji3KpKDBlSJk1D4h24
 DATvN3bQTeL3+Vptr4IV8ohtgidjywvNyma6IEnnqXZp/dSvAwgWdvmUIusy9+Lv5xhf
 Fn3+1Ra0S/iYj1Bg0ObwwIpEs5lCtmqAsLFsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718632413; x=1719237213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S1/TkD0R9igWkDfpnjZu3ZUNF+FATCmtK0eR7zW9d5g=;
 b=mombhC3ubyUZzJvrUUjZyG0u6Mv8qoPklIWjAZXCaF6sUXSKW2L+l/NY6YfqF12uCm
 0hEz9pH2CyvQhA2/GFOtIdqBdr7eDFTQnU+xpxKdpVWFGJ7q6RjpkWlIDMnrro1+wkM9
 daZ75O0BWO86DoB7N3CpOsV18jopSyK/6Cdu3hST4KRwixzhB4mkY6b/UGE5jDQBOhGX
 P7vpBZte5EnTbgF1Wy7HQfjG/CdxwK8oYKuEo2k6oNnAtdVmJ4N4DZf09kctDOWYDx/4
 P8Bja4/ndt8t9mrA8WYpROLZJnTRgsbu1gFA1XjVMDjuFYI0AaLozGIVzOIXEdRC5JOZ
 bKJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ9p0uFJeKdeeTRiX/o9Epi+S3b7KBeSHRjrNQVra+nfUqXSeu7qJTyN3M+baXsvw2ZdhMjBXyALx8z3KR79zH7pAd4Q==
X-Gm-Message-State: AOJu0Yz+aTnfknkYWenDI3pEPqd0mo1g/wJh73FpwOfgqzA5k+cetyL2
 u/9hQPeYdf9RZH4u8HhfUMrQd3UfXM17LPK2YtOcAbO7AN8vULdb1j1WYwtBi53nJ+i3rdX/NZU
 So9EyCMLZ6JkuTYMZV0/pFfflKxHplxRgtWeO
X-Google-Smtp-Source: AGHT+IG91zngHG8XjlN5DsmIYiCvIKqCZG9+IyuRGxtp16UQaOSpqcoRW3v2f1ZnixHZbggWmvCZPZQIwL9Ebwr8Dvc=
X-Received: by 2002:a0d:c307:0:b0:62f:438b:b47 with SMTP id
 00721157ae682-6322235bca7mr85636947b3.12.1718632413162; Mon, 17 Jun 2024
 06:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-3-sjg@chromium.org>
 <CAC_iWj+fSRt2E3ZcHaXrKjC+Gz7LZu_EWgiegWG3F1MJMJrPNQ@mail.gmail.com>
 <14ae7a31-757a-4220-b2a8-20204e3d7aa9@gmx.de>
 <CAC_iWjKAQwLobcO8virDKKD8cQ4j7-OAzn2nriNmdGUtMRKXnw@mail.gmail.com>
 <8b6f5ad8-911f-4954-8b48-333986be0bf8@gmx.de>
 <CAC_iWjL-W604ne_O+U6B3_oGXJtQqZwak4N2qVRSnqdsAz=TbQ@mail.gmail.com>
In-Reply-To: <CAC_iWjL-W604ne_O+U6B3_oGXJtQqZwak4N2qVRSnqdsAz=TbQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Jun 2024 07:53:22 -0600
Message-ID: <CAFLszTigrcPCH3wwZUZAk75QttVS+cPMoj=hZJ9Ko9DqyN5vVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
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

Hi,

On Sat, 15 Jun 2024 at 01:03, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich
>
> resending the reply, I accidentally sent half of the message...
>
> On Fri, 14 Jun 2024 at 12:04, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 14.06.24 09:01, Ilias Apalodimas wrote:
> > > On Fri, 14 Jun 2024 at 09:59, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >> On 6/14/24 08:03, Ilias Apalodimas wrote:
> > >>> Hi Simon,
> > >>>
> > >>> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromium.org> wrote:
> > >>>>
> > >>>> It does not make sense to enable all SHA algorithms unless they are
> > >>>> needed. It bloats the code and in this case, causes chromebook_link to
> > >>>> fail to build. That board does use the TPM, but not with measured boot,
> > >>>> nor EFI.
> > >>>>
> > >>>> Since EFI_TCG2_PROTOCOL already selects these options, we just need to
> > >>>> add them to MEASURED_BOOT as well.
> > >>>>
> > >>>> Note that the original commit combines refactoring and new features,
> > >>>> which makes it hard to see what is going on.
> > >>>>
> > >>>> Fixes: 97707f12fda tpm: Support boot measurements
> > >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >>>> ---
> > >>>>
> > >>>> Changes in v2:
> > >>>> - Put the conditions under EFI_TCG2_PROTOCOL
> > >>>> - Consider MEASURED_BOOT too
> > >>>>
> > >>>>    boot/Kconfig | 4 ++++
> > >>>>    lib/Kconfig  | 4 ----
> > >>>>    2 files changed, 4 insertions(+), 4 deletions(-)
> > >>>>
> > >>>> diff --git a/boot/Kconfig b/boot/Kconfig
> > >>>> index 6f3096c15a6..b061891e109 100644
> > >>>> --- a/boot/Kconfig
> > >>>> +++ b/boot/Kconfig
> > >>>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> > >>>>    config MEASURED_BOOT
> > >>>>           bool "Measure boot images and configuration when booting without EFI"
> > >>>>           depends on HASH && TPM_V2
> > >>>> +       select SHA1
> > >>>> +       select SHA256
> > >>>> +       select SHA384
> > >>>> +       select SHA512
> > >>>>           help
> > >>>>             This option enables measurement of the boot process when booting
> > >>>>             without UEFI . Measurement involves creating cryptographic hashes
> > >>>> diff --git a/lib/Kconfig b/lib/Kconfig
> > >>>> index 189e6eb31aa..568892fce44 100644
> > >>>> --- a/lib/Kconfig
> > >>>> +++ b/lib/Kconfig
> > >>>> @@ -438,10 +438,6 @@ config TPM
> > >>>>           bool "Trusted Platform Module (TPM) Support"
> > >>>>           depends on DM
> > >>>>           imply DM_RNG
> > >>>> -       select SHA1
> > >>>> -       select SHA256
> > >>>> -       select SHA384
> > >>>> -       select SHA512
> > >>>
> > >>> I am not sure this is the right way to deal with your problem.
> > >>> The TPM main functionality is to measure and extend PCRs, so shaXXXX
> > >>> is really required. To make things even worse, you don't know the PCR
> > >>> banks that are enabled beforehand. This is a runtime config of the
> > >>> TPM.
> > >>
> > >> If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is selected, U-Boot
> > >> cannot extend PCRs. So it seems fine to let these two select the
> > >> complete set of hashing algorithms. As Simon pointed out for
> > >> EFI_TCG2_PROTOCOL this is already done in lib/efi_loader/Kconfig.
> > >
> > > It can. The cmd we have can extend those pcrs -- e.g tpm2 pcr_extend 8
> > > 0xb0000000

That's pretty normal for U-Boot though, since we want to avoid lots of
growth for things people might want control over. We can enable or
disable the SHA for the board, if this functionality is used outside
of measured boot and tcg2, but someone is enabling the tpm command.

> >
> > So this patch should also consider CMD_TPM_V2 and CMD_TPM_V1.
> >
> > TPM v1 only needs SHA-1.
>
> I still prefer to imply all algos.

'imply' would be OK in this case as I can disable it for that board. I
don't think it is in the spirit of U-Boot though.

isn't someone checking the growth in U-Boot? Or do so few boards have
TPMs that it didn't register? The size growth was 3.2KB on
chromebook_link.

>
> >
> > In cmd/tpm-v2.c do_tpm2_pcr_extend() and do_tpm_pcr_read() assume
> > SHA256. Function tpm_pcr_extend() shows the same limitation. This bug
> > should be fixed. But as is CMD_TPM_V2 seems only to require CONFIG_SHA256.
>
> Isn't [0] fixing this?
>
> [0] https://source.denx.de/u-boot/u-boot/-/commit/89aa8463cdf3919ca4f04fc24ec8b154ff56d97e
> Thanks
> /Ilias
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > Regards
> > > /Ilias
> > >>
> > >> Even if U-Boot does not support measured boot (EFI or non-EFI) we might
> > >> still be using the TPMs RNG.
> > >>
> > >> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >>
> > >>>
> > >>>    So this would make the TPM pretty useless. Can't you remove something
> > >>> that doesn't break functionality?
> > >>>
> > >>> Thanks
> > >>> /Ilias
> > >>>>           help
> > >>>>             This enables support for TPMs which can be used to provide security
> > >>>>             features for your board. The TPM can be connected via LPC or I2C
> > >>>> --
> > >>>> 2.34.1
> > >>>>
> > >>
> >

Regards,
Simon
