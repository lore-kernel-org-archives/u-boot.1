Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6E6C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 13:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96222835FD;
	Thu, 10 Jul 2025 15:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C7B68360D; Thu, 10 Jul 2025 15:18:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A4DD4835C9
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8A861EA6;
 Thu, 10 Jul 2025 06:18:02 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.35.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AF503F66E;
 Thu, 10 Jul 2025 06:18:11 -0700 (PDT)
Date: Thu, 10 Jul 2025 14:18:03 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: trini@konsulko.com, Davidson kumaresan <davidson.kumaresan@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 25/25] fwu_arm_psa: Document FWU support for Arm PSA
Message-ID: <20250710131803.GA1610792@e130802.arm.com>
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
 <20250702152528.1180414-26-abdellatif.elkhlifi@arm.com>
 <de8a07e1-dbf6-4232-b8e3-4b5b1ccf12e0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de8a07e1-dbf6-4232-b8e3-4b5b1ccf12e0@gmx.de>
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

> On 02.07.25 17:25, abdellatif.elkhlifi@arm.com wrote:
> > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > 
> > Add a README
> > 
> > Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Michal Simek <michal.simek@amd.com>
> > Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Cc: Casey Connolly <casey.connolly@linaro.org>
> > Cc: Adriano Cordova <adrianox@gmail.com>
> > ---
> >   MAINTAINERS                      |   1 +
> >   doc/develop/uefi/fwu_arm_psa.rst | 153 +++++++++++++++++++++++++++++++
> >   doc/develop/uefi/index.rst       |   1 +
> >   3 files changed, 155 insertions(+)
> >   create mode 100644 doc/develop/uefi/fwu_arm_psa.rst
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fdf34c74049..a75bc1d2379 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1231,6 +1231,7 @@ FWU ARM PSA
> >   M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> >   M:	Davidson kumaresan <davidson.kumaresan@arm.com>
> >   S:	Maintained
> > +F:	doc/develop/uefi/fwu_arm_psa.rst
> >   F:	include/fwu_arm_psa.h
> >   F:	lib/fwu_updates/fwu_arm_psa.c
> > diff --git a/doc/develop/uefi/fwu_arm_psa.rst b/doc/develop/uefi/fwu_arm_psa.rst
> > new file mode 100644
> > index 00000000000..f91fd85f573
> > --- /dev/null
> > +++ b/doc/develop/uefi/fwu_arm_psa.rst
> > @@ -0,0 +1,153 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +.. Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
> > +
> > +Firmware Update (FWU) Support for Arm PSA
> > +==========================================
> > +
> > +This README provides an overview of the Firmware Update (FWU) support
> 
> There  is no README here. How about:
> 
> U-Boot implements Firmware Update (FWU) support for Arm `PSA Certified`_
> platforms.
> 
> > +implemented in U-Boot for Arm `PSA Certified`_ platforms, such as
> > +Corstone-1000. The feature aligns with the Platform Security Firmware Update
> > +specification for the A-profile Arm Architecture
> > +(see `DEN0118 v1.0 A specification`_) and leverages the Trusted Services (TS)
> > +framework to interact with Secure world update agent.
> > +
> > +Overview
> > +--------
> > +
> > +The FWU subsystem enables secure  firmware updates by
> > +delegating the update management to a Secure world agent. U-Boot acts as the
> > +FWU client, coordinating updates via a well-defined set of ABIs over the FF-A
> > +interface (see :doc:`Arm FF-A Support <../../arch/arm64.ffa>`).
> > +
> > +FWU for Arm PSA supports both on-disk and standard capsule updates.
> > +
> > +Key Features
> > +------------
> > +
> > +1. PSA Firmware Update Initialization
> > +-------------------------------------
> > +
> > +- Initialization of the update agent using the FF-A transport and discovery of
> > +  the Trusted Services FWU SP.
> > +
> > +- Discovery of the version of the ABIs using FWU_DISCOVER ABI.
> > +
> > +- Establishment and sharing of communication buffers between U-Boot
> > +  (Normal world) and Secure world.
> > +
> > +2. ESRT Support
> > +---------------
> > +
> > +Retrieval of ESRT (EFI System Resource Table) data from Secure world using
> > +FWU_READ_STREAM ABI, enabling compliance with UEFI standards
> > +(see `UEFI v2.10 specification`_).
> > +
> > +3. UEFI Capsule Handling
> > +------------------------
> > +
> > +- Runtime checks for capsule flags as per UEFI 2.10 specification:
> > +
> > +    - CAPSULE_FLAGS_PERSIST_ACROSS_RESET
> > +
> > +    - CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE
> > +
> > +    - CAPSULE_FLAGS_INITIATE_RESET
> > +
> > +- Support for keeping the FMP payload header in Arm PSA mode to preserve
> > +  critical metadata required by Secure world.
> > +
> > +4. Staging and Update Flow
> > +--------------------------
> > +
> > +- Full support for update staging flow as per PSA spec:
> > +
> > +    - FWU_BEGIN_STAGING
> > +
> > +    - FWU_END_STAGING
> > +
> > +    - FWU_CANCEL_STAGING
> > +
> > +    - FWU_WRITE_STREAM
> > +
> > +- Capsules can contain multiple payloads (including start/end markers
> > +  and the update content).
> > +
> > +5. Directory Access
> > +-------------------
> > +
> > +- Reading the FWU directory from Secure world using FWU_READ_STREAM ABI.
> > +
> > +6. Image Update Lifecycle
> > +-------------------------
> > +
> > +- Implementation of get_image_info() and set_image() using raw EFI firmware
> > +  services provided by the FMP driver for raw images.
> > +
> > +- FWU_ACCEPT_IMAGE ABI issued on ExitBootServices() to commit successfully
> > +  booted trial images.
> > +
> > +- Option to disable automatic acceptance on ExitBootServices() via
> > +  CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES.
> > +
> > +Configuration Options
> > +---------------------
> > +
> > +To enable FWU support for Arm PSA, include the following options in your board
> > +configuration:
> > +
> > +CONFIG_FWU_ARM_PSA=y enables the PSA-compliant firmware update client in U-Boot.
> 
> Please, use a formatting that lets the config parameters stick out:
> 
> CONFIG_FWU_ARM_PSA
>     enables the PSA-compliant firmware update client in U-Boot.
> 
> CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES
>     enables auto-acceptance on ExitBootServices(). Disable this setting
>     if auto-acceptance shall be handled at a later boot stage.
> 
> > +
> > +CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES=y Enables auto-acceptance on
> > +ExitBootServices(). This option is enabled by default. It can be disabled if
> > +image acceptance should not be done at ExitBootServices().
> 
> Enabled by default implies that it can be disabled.
> "if .. should not be done" conveys no new information.
> 
> > +
> > +Platform Integration: Corstone-1000
> > +-----------------------------------
> > +
> > +- Corstone-1000 is the reference implementation for the FWU Arm PSA feature.
> 
> A link to the board page should be good enough.
> 
> What is implemented for a specific board should be described there.
> 
> > +
> > +- ESP partition detection is automated by setting Boot0001 in the U-Boot bootcmd.
> 
> Please, state that you mean the environment variable bootcmd. How about
> altbootcmd?
> 
> What would the variable bootcmd look like?
> 
> It is unclear to me which part of the information above is board specific
> and which is not.

Thank you for your review. I’ve addressed all of your comments and will include
the updates in the upcoming v2 patchset.

Regarding the bootcmd question: Corstone-1000 only supports the standard bootcmd
environment variable, and does not use altbootcmd. I’ll remove the bootcmd
reference from the documentation and instead link to the
Corstone-1000 user guide for further details.

Cheers
Abdellatif

