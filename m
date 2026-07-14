Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3BAC44501
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 12:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6880E84D2C;
	Tue, 14 Jul 2026 14:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="IApgBfJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A40F84CFE; Tue, 14 Jul 2026 13:33:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BFF9C84CEB
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 13:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B82497;
 Tue, 14 Jul 2026 04:33:00 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.28.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3357D3F93E;
 Tue, 14 Jul 2026 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784028784; bh=axmXW1vry7GeEFZz1AI568PfI49b8txa+QVG4WkZsB0=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=IApgBfJoeIuPzwdmONPBmKV2Z9A+cqC1mJ4PVCObzD5bH6UVth/ojqKjv56MZowcB
 7AZ/dGoUHdWiHGu/pLdK2fRHMUTrUncBVmc8c66I2uJeudYNse/YlONTFgdDn5P23x
 5e1Unwlz+mAZTN5ETGHrScjEwachU6N/YYdaUYpU=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 02/10] arm-ffa: add FF-A bus runtime support
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>, 
 u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjK_qvhpQh0opx_Wzw_3BYxGWupF8w7OMQGyxCCcU-3p-A@mail.gmail.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-3-harsimransingh.tungal@arm.com>
 <CAC_iWjK_qvhpQh0opx_Wzw_3BYxGWupF8w7OMQGyxCCcU-3p-A@mail.gmail.com>
Date: Tue, 14 Jul 2026 12:32:57 +0100
Message-Id: <178402877760.3079243.10832252267768848305.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 14 Jul 2026 14:51:05 +0200
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

On 2026-07-01 15:59 +0300, Ilias Apalodimas wrote:
> Hi Harsimran,
> 
> On Sat, 27 Jun 2026 at 17:44, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> >
> > Add the FF-A runtime infrastructure needed after ExitBootServices() so
> > EFI runtime services can continue to use the FF-A transport layer.
> > Introduce drivers/firmware/arm-ffa/arm-ffa-runtime.c and
> > include/arm_ffa_runtime.h with runtime-resident FF-A helpers for
> > direct messaging, SMC invocation, and error translation. Add the
> > sandbox runtime SMC wrapper, the ARM_FFA_RT_MODE Kconfig option, and
> > the ExitBootServices hook that copies the required FF-A runtime data
> > into resident storage before enabling the runtime context.
> >
> > Tag the runtime code and data with __efi_runtime and
> > __efi_runtime_data so they remain available after
> > ExitBootServices().
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> 
> Having the FFA driver in  drivers/firmware/arm-ffa/ in fine. I am not
> so sure about the parts that touch the efi_loader though. I would
> prefer having this there. Is there a reason you are defined this in
> the ffa driver?
> 
> [...]
> 
> Thanks
> /Ilias
> 

Hi Ilias,
Thanks, I think I understand the concern.

The reason I placed this in the FF-A driver is that the runtime state
being captured is FF-A driver i.e. the endpoint ID and
framework version discovered during probe. The ExitBootServices
callback only copies that already-discovered FF-A state into
runtime-resident storage and enables the runtime context, so I kept the
ownership close to the driver that owns the data.

The EFI variable TEE code then consumes the runtime FF-A transport
through ffa_sync_send_receive_runtime(), without needing to know how the
FF-A driver prepares or stores its runtime state.

I agree the ExitBootServices hook is EFI-specific.

What do you prefer here?
Should I move the EFI event registration into efi_loader code?

Regards
Harsimran Singh Tungal

