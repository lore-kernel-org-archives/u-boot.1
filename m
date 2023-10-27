Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71B2C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 06:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D76D87687;
	Fri, 27 Oct 2023 08:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jzpSgT0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83165876BC; Fri, 27 Oct 2023 08:22:56 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5284187663
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 08:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5082a932bdeso284129e87.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 23:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698387773; x=1698992573; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jbB3YncWHuEKyC4R+4aYZr2eSRAu5LaAwfuArSRUZLo=;
 b=jzpSgT0rsN+vFR5PWkNMb6cIQKN/fJwY7CIPJAK5iS+K/AJ2PXe3oz8sYOQiw6vagP
 slczJznwhhll2ObKYK+qtSNzaLSnAOZ9TqzaH3F6FK+r6NQLtTehGPiBS9VL3Y+AwGtf
 76cXc2niEuKep882blPzX7G0idYeAWybhyDlsSc0RU2aNcV8i6aTxbFujUUPHp0Lb4Pr
 FmIeoLlSNrq2RCxNotsJW4yeIYWDhX3NS3fh0n+ZUtGBPH0ItDZ3tA/vQU+zkSJY2KqV
 DIMd5+1KzS7KHb/H6pZplvQt/6aeP3a+OcO2kAGj4VPj6UG4LmTnOaf55DvmK99iSix8
 0vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698387773; x=1698992573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbB3YncWHuEKyC4R+4aYZr2eSRAu5LaAwfuArSRUZLo=;
 b=iOeRhe7iklit/l5MGok9KWW4yNGMCzOtfDdRRrMbKT8d0GZVdGxCb7q8GjhYHSANrG
 G7wOZpgCjBRTPOCyUcogHtpZ1hLqAkAiwdBOJEbW3MIflPtTYQRhWqvgQBoY+nbt0DX+
 eHC1QoUJyz8Njp2E7kHtLLmLfSkIUEmpVDF8ziyE8t5V8ERcio9ccHGTTyShiOly35TF
 I3FOT7P1EUOBpzHL74zl8hLfVsWG3n/S7FzZvB6yJZb/dhdzHOm49riP7YeEdqkvNxs6
 MndoaR+wopEmtz95CU9ojqUQmyt+FDt4FBFEa++ndKThCyevtI2u0VZAXChz4JmyVSCs
 eOkA==
X-Gm-Message-State: AOJu0YzJiovHntlsL/HxWGkXZ+ShG306jH45b5JaY7xsGrUAk/S0hp0b
 fNr1Iyt5SyLfha4AM9Hz6lg5S+PrXTgpTg2oypFZllF546Gp2gzIazw=
X-Google-Smtp-Source: AGHT+IHSWt3RaPYx2WDJoPyOg1MQtG7nEQLSsJIx3auVDgQHFFQiBcZR3X9VTJtbAJL3lbRwp6J7OzFK2gIuKTwIPg4=
X-Received: by 2002:a05:6512:114b:b0:507:9ae6:6913 with SMTP id
 m11-20020a056512114b00b005079ae66913mr1386577lfg.28.1698387773377; Thu, 26
 Oct 2023 23:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231019162156.80982-1-eajames@linux.ibm.com>
 <20231019162156.80982-7-eajames@linux.ibm.com>
 <ad33807d-815a-401d-a258-ae43d21c6aad@gmx.de>
In-Reply-To: <ad33807d-815a-401d-a258-ae43d21c6aad@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Oct 2023 09:22:17 +0300
Message-ID: <CAC_iWj+=UoJMCG3CV+duRKEb4PJNMufntR6QJ5-WbAy+oEv-yw@mail.gmail.com>
Subject: Re: [PATCH v13 6/8] doc: Add measured boot documentation
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

Hi Heinrich

On Thu, 19 Oct 2023 at 21:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/19/23 18:21, Eddie James wrote:
> > Briefly describe the feature and specify the requirements.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> > Changes since v12:
> >   - Add a bit of detail about OS usage and what pieces are measured
> >
> >   doc/usage/index.rst         |  1 +
> >   doc/usage/measured_boot.rst | 31 +++++++++++++++++++++++++++++++
> >   2 files changed, 32 insertions(+)
> >   create mode 100644 doc/usage/measured_boot.rst
> >
> > diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> > index 98b4719c40..bf53bb6bda 100644
> > --- a/doc/usage/index.rst
> > +++ b/doc/usage/index.rst
> > @@ -14,6 +14,7 @@ Use U-Boot
> >      partitions
> >      cmdline
> >      semihosting
> > +   measured_boot
> >
> >   Shell commands
> >   --------------
> > diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> > new file mode 100644
> > index 0000000000..0aad590859
> > --- /dev/null
> > +++ b/doc/usage/measured_boot.rst
> > @@ -0,0 +1,31 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Measured Boot
> > +=====================
> > +
> > +U-Boot can perform a measured boot, the process of hashing various components
> > +of the boot process, extending the results in the TPM and logging the
> > +component's measurement in memory for the operating system to consume.
> > +
> > +By default, U-Boot will measure the operating system (linux) image, the
>
> The OS image would mean the root file system? I guess you mean the
> loaded EFI binary here. Measured boot is not Linux specific.
>
> We should consider different scenarios:
>
> * U-Boot loading kernel, initrd, device-tree
> * U-Boot loading GRUB (or another boot manager), device-tree,
>    GRUB loading initrd
> * U-Boot loading GRUB and passing a device-tree to GRUB,
>    GRUB loading initrd and a new device-tree
>
> With the documentation the user should be enabled to understand what
> U-Boot measures in each of these cases. Please, observe that upstream
> GRUB uses LoadImage() while distros (e.g. Debian and Ubuntu) tend to
> bypass LoadImage().
>
> Arent't there some other objects measured?
>
> - SMBIOS table
> - ACPI tables (still to be implemented)
> - EFI variables

Eddie's part is trying to describe how 'bootm' would measure binaries.
I'll update it with the EFI part once we merge this.

Regards
/Ilias

>
> Best regards
>
> Heinrich
>
> > +initrd image, and the "bootargs" environment variable. By enabling
> > +CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree image.
> > +
> > +The operating system typically would verify that the hashes found in the
> > +TPM PCRs match the contents of the event log. This can further be checked
> > +against the hash results of previous boots.
> > +
> > +Requirements
> > +---------------------
> > +
> > +* A hardware TPM 2.0 supported by the U-Boot drivers
> > +* CONFIG_TPM=y
> > +* CONFIG_MEASURED_BOOT=y
> > +* Device-tree configuration of the TPM device to specify the memory area
> > +  for event logging. The TPM device node must either contain a phandle to
> > +  a reserved memory region or "linux,sml-base" and "linux,sml-size"
> > +  indicating the address and size of the memory region. An example can be
> > +  found in arch/sandbox/dts/test.dts
> > +* The operating system must also be configured to use the memory regions
> > +  specified in the U-Boot device-tree in order to make use of the event
> > +  log.
>
