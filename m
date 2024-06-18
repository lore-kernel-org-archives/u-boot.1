Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDF9C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 506CB8834B;
	Tue, 18 Jun 2024 14:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XCzYNmqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22DEC883AC; Tue, 18 Jun 2024 14:44:05 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D542988365
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b081c675e7so27922976d6.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718714642; x=1719319442; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XIypE/zd+lq6cuIJpFVSvyfbOaRG1dG5JW8fTCgRFdg=;
 b=XCzYNmqzjIFT63otyUBYprhev0595ezlUOY4Gopz6rkq2Lkc9D7Ty17B0exlGRfEpp
 ZBUeAsAZMbivCaC9bfCEwfhgC0SySkcUYm8aV8P2NvBCotIKMxI1Qua7r2oY7qfHnYTH
 HLu3ytZmGZuozQJM0Sx8X4uZ3lJ3zes2UNOBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718714642; x=1719319442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XIypE/zd+lq6cuIJpFVSvyfbOaRG1dG5JW8fTCgRFdg=;
 b=JwhWUn8NA7QfLYr+HiFKEDGJJktu8OxWDVF4PmmVdSMbjCtVq7JEI0SH4W2V/YGHYZ
 DXY/cAimJNLhOh+tnOzYRuU44uZthZpbxoXw9puAVnBv6/9aMg9LGcYE+RXyfHNmHdeZ
 fREqXn2d6/W7GGfUgxHURN+Ao72kWoL2g0mmGH+t3S8cHi9rH+uF4BS1qp8wPgXkzdEi
 GNkg1sH+DJqoPQuov15TfOavinHGA7KmMmY0dw+zaMn5qRYSz0dGlOXY0m8w73Ppx6QY
 ZFz7jodCnjmzjk2B7TIeDS6FR2KsG84+OKU82Vd8ZBMcstASW4VvSd4GDI36wluacUe1
 exAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiVximCWUqRoYbHQQ2xx8vDYB/M5/UHsdtLUN0nY2Y8tCGlGW3TjBLcrp6vhk9xWsGOVCkeGKx0L33jLbwenJUKCD+6Q==
X-Gm-Message-State: AOJu0YwTZ5tY1/4vwqgMRLDj8pMOkMYZDtAVmr7l5AdDkrCNXNrJv54E
 fAS7Z8lqxVGpChHNJBW3Qd3CyuF3yXpSjXr+OshUnpXDyqtzWmzzT4ABFVUttE9PCI+/IM1ibC9
 zdf4M+UzNyJN6ZnaRPsbSQMaOQtoQhY3Aeywn
X-Google-Smtp-Source: AGHT+IH8ADG08lAbJGHJu8Cv3xbouS2L73aB8wYHVmb6p6EIFlskV3aYXpgddMAwRuTqMQZi1cpGh5ZyqcJt6okxULU=
X-Received: by 2002:a0c:f68f:0:b0:6ae:4dea:6c69 with SMTP id
 6a1803df08f44-6b2afd9e213mr137681556d6.63.1718714641695; Tue, 18 Jun 2024
 05:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-3-sjg@chromium.org>
 <CAC_iWj+fSRt2E3ZcHaXrKjC+Gz7LZu_EWgiegWG3F1MJMJrPNQ@mail.gmail.com>
 <14ae7a31-757a-4220-b2a8-20204e3d7aa9@gmx.de>
 <CAC_iWjKAQwLobcO8virDKKD8cQ4j7-OAzn2nriNmdGUtMRKXnw@mail.gmail.com>
 <8b6f5ad8-911f-4954-8b48-333986be0bf8@gmx.de>
 <CAC_iWjL-W604ne_O+U6B3_oGXJtQqZwak4N2qVRSnqdsAz=TbQ@mail.gmail.com>
 <CAFLszTigrcPCH3wwZUZAk75QttVS+cPMoj=hZJ9Ko9DqyN5vVA@mail.gmail.com>
 <20240617171623.GY68077@bill-the-cat>
In-Reply-To: <20240617171623.GY68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Jun 2024 06:43:51 -0600
Message-ID: <CAFLszThO9Hnfv90X4yu49h7LcWCfgMztSGtQdGwrCt9UDH_cGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
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

Hi Tom,

On Mon, 17 Jun 2024 at 11:16, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jun 17, 2024 at 07:53:22AM -0600, Simon Glass wrote:
> > Hi,
> >
> > On Sat, 15 Jun 2024 at 01:03, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Heinrich
> > >
> > > resending the reply, I accidentally sent half of the message...
> > >
> > > On Fri, 14 Jun 2024 at 12:04, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 14.06.24 09:01, Ilias Apalodimas wrote:
> > > > > On Fri, 14 Jun 2024 at 09:59, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >>
> > > > >> On 6/14/24 08:03, Ilias Apalodimas wrote:
> > > > >>> Hi Simon,
> > > > >>>
> > > > >>> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromium.org> wrote:
> > > > >>>>
> > > > >>>> It does not make sense to enable all SHA algorithms unless they are
> > > > >>>> needed. It bloats the code and in this case, causes chromebook_link to
> > > > >>>> fail to build. That board does use the TPM, but not with measured boot,
> > > > >>>> nor EFI.
> > > > >>>>
> > > > >>>> Since EFI_TCG2_PROTOCOL already selects these options, we just need to
> > > > >>>> add them to MEASURED_BOOT as well.
> > > > >>>>
> > > > >>>> Note that the original commit combines refactoring and new features,
> > > > >>>> which makes it hard to see what is going on.
> > > > >>>>
> > > > >>>> Fixes: 97707f12fda tpm: Support boot measurements
> > > > >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >>>> ---
> > > > >>>>
> > > > >>>> Changes in v2:
> > > > >>>> - Put the conditions under EFI_TCG2_PROTOCOL
> > > > >>>> - Consider MEASURED_BOOT too
> > > > >>>>
> > > > >>>>    boot/Kconfig | 4 ++++
> > > > >>>>    lib/Kconfig  | 4 ----
> > > > >>>>    2 files changed, 4 insertions(+), 4 deletions(-)
> > > > >>>>
> > > > >>>> diff --git a/boot/Kconfig b/boot/Kconfig
> > > > >>>> index 6f3096c15a6..b061891e109 100644
> > > > >>>> --- a/boot/Kconfig
> > > > >>>> +++ b/boot/Kconfig
> > > > >>>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> > > > >>>>    config MEASURED_BOOT
> > > > >>>>           bool "Measure boot images and configuration when booting without EFI"
> > > > >>>>           depends on HASH && TPM_V2
> > > > >>>> +       select SHA1
> > > > >>>> +       select SHA256
> > > > >>>> +       select SHA384
> > > > >>>> +       select SHA512
> > > > >>>>           help
> > > > >>>>             This option enables measurement of the boot process when booting
> > > > >>>>             without UEFI . Measurement involves creating cryptographic hashes
> > > > >>>> diff --git a/lib/Kconfig b/lib/Kconfig
> > > > >>>> index 189e6eb31aa..568892fce44 100644
> > > > >>>> --- a/lib/Kconfig
> > > > >>>> +++ b/lib/Kconfig
> > > > >>>> @@ -438,10 +438,6 @@ config TPM
> > > > >>>>           bool "Trusted Platform Module (TPM) Support"
> > > > >>>>           depends on DM
> > > > >>>>           imply DM_RNG
> > > > >>>> -       select SHA1
> > > > >>>> -       select SHA256
> > > > >>>> -       select SHA384
> > > > >>>> -       select SHA512
> > > > >>>
> > > > >>> I am not sure this is the right way to deal with your problem.
> > > > >>> The TPM main functionality is to measure and extend PCRs, so shaXXXX
> > > > >>> is really required. To make things even worse, you don't know the PCR
> > > > >>> banks that are enabled beforehand. This is a runtime config of the
> > > > >>> TPM.
> > > > >>
> > > > >> If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is selected, U-Boot
> > > > >> cannot extend PCRs. So it seems fine to let these two select the
> > > > >> complete set of hashing algorithms. As Simon pointed out for
> > > > >> EFI_TCG2_PROTOCOL this is already done in lib/efi_loader/Kconfig.
> > > > >
> > > > > It can. The cmd we have can extend those pcrs -- e.g tpm2 pcr_extend 8
> > > > > 0xb0000000
> >
> > That's pretty normal for U-Boot though, since we want to avoid lots of
> > growth for things people might want control over. We can enable or
> > disable the SHA for the board, if this functionality is used outside
> > of measured boot and tcg2, but someone is enabling the tpm command.
> >
> > > >
> > > > So this patch should also consider CMD_TPM_V2 and CMD_TPM_V1.
> > > >
> > > > TPM v1 only needs SHA-1.
> > >
> > > I still prefer to imply all algos.
> >
> > 'imply' would be OK in this case as I can disable it for that board. I
> > don't think it is in the spirit of U-Boot though.
> >
> > isn't someone checking the growth in U-Boot? Or do so few boards have
> > TPMs that it didn't register? The size growth was 3.2KB on
> > chromebook_link.
>
> As always, yes, nearly every PR (I don't check the ones that touch just
> a single board for example) gets a world build before/after. In this
> case I likely assumed that it was acceptable growth for enabling
> features. It sounds like some of the chromebook boards need to be
> setting the features to cause link failure if a size is exceeded?

The problem is that some Intel platforms have binary blobs, so the
size isn't known unless you have a real blob.

Regards,
Simon


>
> --
> Tom
