Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CE8C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2578819D;
	Tue, 18 Jun 2024 17:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T8pnA7dN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1188788365; Tue, 18 Jun 2024 17:51:58 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882DC8332E
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-60585faa69fso4029354a12.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718725914; x=1719330714; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=64G2ZYQNqiVJU9AVZKAUOwdyGwCq/BVoWH3OQ9xowNE=;
 b=T8pnA7dNqDgzD7BKL4DY+kH8adR6ZzRbuJBGjxhsg/66SUZfqUlJmwZc/d/M3jAodb
 IdB6bJAVNSFK9nEndDfTHdpsEPkURRnrKOCJcoLR4Nc4jVQ8OY7ELLIjNvfkGtRWTLo5
 JA2A4Rf0svRb1Q8zzsRhN12mifEmZA1vJ7r1VvmqIq+I4YJTVZx3qhRFLyBXGd4+mhr8
 +q5G5FBUOc9Odoc3bVL+dXllU1+0W8pXyol2Bgl9yv7oORHBIrYdGW4scqaSpB4rxsqn
 /kPXmWwNZD1esKWE3vM+CcvOw9DdcH8r06tx01AMcYiyQb1WSdiRyYuVMNZUQIp+z8j5
 cBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718725914; x=1719330714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=64G2ZYQNqiVJU9AVZKAUOwdyGwCq/BVoWH3OQ9xowNE=;
 b=TG5dTvWe4Ylz62P/+zopnzJ7wWPLwVcxiYEePDPfs3he+S5nX7+ldt550d73mACjgs
 JJmhQ8tQUQz+/FKExe31SU6aiEwXCMSJQRPGcgMxdw831f35S2g8wH6Vk/deflZMWe66
 2ZYqULYABTRMTRtQrg1f7uMRDCC3Y4I+i/7WDlvDmBX1dil/k+yVy2Werh+8RsX5AiW6
 Y0pGT/kCrbd/GLxHugb4eAcCtqY4XAZtrp8zhh3O037E4rHqv97OxDU7CyM5jOdqVRoq
 jnci+mgcNy+mLydrOSY5czNjxmfeggn5tSjm/lAAfRdy7l8F2T8FmoFggaoFYQYFndKP
 IYCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE03VTDTjMYUqMi3etpJoGfCLr7/8+cpk0kXzxWS8t0QdT6TDkY6eHSOEHTPx9zW0vcGpeRNeVRyZRX6QNsfI4dQSWqA==
X-Gm-Message-State: AOJu0YxMLa3OWhHWFz4WAexbzuXHoB90fFLupoQ1gSJCX7RxKuoEtD4+
 hIprd+kCmzsfKi8f1ilevwmDSTR41fDAMywpYc7iTrZu6R082mLE4CKx4nORKnZTITOGsztbI3x
 mtmfUI2IdCj5J4a4vWncdjaw5x/W3ADVu9rlF/y66A0Hv6uSBTNU=
X-Google-Smtp-Source: AGHT+IHQn+s20emV/KaswdYehie+YaO3KRsnhPJ655aFhKMDMTtXlvecLq+afCQC26SyQIFK88WaGCUsGI5uSbETj/E=
X-Received: by 2002:a17:90b:46c5:b0:2c7:a9b0:e563 with SMTP id
 98e67ed59e1d1-2c7a9b0e88cmr1431978a91.10.1718725913854; Tue, 18 Jun 2024
 08:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240618152314.10140-1-ilias.apalodimas@linaro.org>
 <c1c66103-9d68-48ca-a542-1d0abbfdb634@gmx.de>
In-Reply-To: <c1c66103-9d68-48ca-a542-1d0abbfdb634@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Jun 2024 18:51:17 +0300
Message-ID: <CAC_iWjKpixwVVi8beMV3HNZAN+t0ExdJFf1VBcJMwv3at_JGpg@mail.gmail.com>
Subject: Re: [PATCH v3] doc: describe UEFI measured boot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de
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

On Tue, 18 Jun 2024 at 18:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 18.06.24 17:23, Ilias Apalodimas wrote:
> > We currently only describe the process to enable measured boot using
> > bootm. Describe the UEFI requirements as well which predate bootm.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Please, rebase on 00cac7456125 ("doc: describe UEFI measured boot")

No need. That commit already contains the v3 changes. You can ignore this one

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> > ---
> > Changes since v2:
> > - add all bootX commands in the description instead of just bootm
> > - Remove and extra _ from the header
> > Changes since v1:
> > - fixed remarks from Heinrich on titling and DTB measured PCR
> >   doc/usage/measured_boot.rst | 31 +++++++++++++++++++++++++++----
> >   1 file changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> > index 9691904a9d8a..d31cb05226cd 100644
> > --- a/doc/usage/measured_boot.rst
> > +++ b/doc/usage/measured_boot.rst
> > @@ -7,19 +7,42 @@ U-Boot can perform a measured boot, the process of hashing various components
> >   of the boot process, extending the results in the TPM and logging the
> >   component's measurement in memory for the operating system to consume.
> >
> > +The functionality is available when booting via the EFI subsystem or 'bootm'
> > +command.
> > +
> > +UEFI measured boot
> > +------------------
> > +The EFI subsystem implements the `EFI TCG protocol
> > +<https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specification/>`_
> > +and the `TCG PC Client Specific Platform Firmware Profile Specification
> > +<https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/>`_
> > +which defines the binaries to be measured and the corresponding PCRs to be used.
> > +
> > +Requirements
> > +~~~~~~~~~~~~
> > +* A hardware TPM 2.0 supported by an enabled U-Boot driver
> > +* CONFIG_EFI_TCG2_PROTOCOL=y
> > +* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=y
> > +* optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=y will measure the loaded DTB in PCR 1
> > +
> > +Measured legacy boot with bootX command
> > +---------------------------------------
> > +The commands booti, bootm, and bootz can be used for measured boot
> > +using the legacy entry point of the Linux kernel.
> > +
> >   By default, U-Boot will measure the operating system (linux) image, the
> >   initrd image, and the "bootargs" environment variable. By enabling
> > -CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree image.
> > +CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree image in PCR1.
> >
> >   The operating system typically would verify that the hashes found in the
> >   TPM PCRs match the contents of the event log. This can further be checked
> >   against the hash results of previous boots.
> >
> >   Requirements
> > -------------
> > +~~~~~~~~~~~~
> >
> > -* A hardware TPM 2.0 supported by the U-Boot drivers
> > -* CONFIG_TPM=y
> > +* A hardware TPM 2.0 supported by an enabled U-Boot driver
> > +* CONFIG_TPMv2=y
> >   * CONFIG_MEASURED_BOOT=y
> >   * Device-tree configuration of the TPM device to specify the memory area
> >     for event logging. The TPM device node must either contain a phandle to
> > --
> > 2.45.2
> >
>
