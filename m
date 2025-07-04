Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C088C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13388277D;
	Fri,  4 Jul 2025 14:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cH453zmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8481582A76; Fri,  4 Jul 2025 14:02:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA1D6800D7
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751630512; x=1752235312; i=xypron.glpk@gmx.de;
 bh=jMgFdP4p6o72Z1tktgXoxHG+L+k+eEVFqpGXHrehgWk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cH453zmhCuoQqS4SZsfux4o7H4ABzcrDhzJEaTskEr/c4n8QeeARYc4FkHCFU+JW
 GR3J4SBwpBfjFHYRA+fyAf/xxMhOUfFssG3N0HFSc9irUhEj9sq3WZjkBRp4oRO9K
 tInzGG92GX8hik8s2t1YIkIikKxb048rxu6eyBnjo6e9OVs8vESg7dm6oAazDm2i8
 ErkV0Y+q4iU3J+JoWx0lapbrCj9QBoO9UBYyAXmFqHXTqHd0ww/mqxB5MOj/fe2i+
 ETylJsUKNyCuEIFmMUzHRdbA3O4HNMBCsJwbWB8LaVlZp6KxpBCqULcHp3hgzqGWK
 sY78MWZc55N3EVFnPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([46.114.111.81]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU4s-1v5cst3McG-00dJb5; Fri, 04
 Jul 2025 14:01:51 +0200
Message-ID: <de8a07e1-dbf6-4232-b8e3-4b5b1ccf12e0@gmx.de>
Date: Fri, 4 Jul 2025 14:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/25] fwu_arm_psa: Document FWU support for Arm PSA
To: abdellatif.elkhlifi@arm.com
Cc: trini@konsulko.com, Davidson kumaresan <davidson.kumaresan@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
 <20250702152528.1180414-26-abdellatif.elkhlifi@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250702152528.1180414-26-abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/yxVtVqZdDcYuLsaat4WEE2Rotv9XOvD1Q9MSQhFaBV7lPXP1da
 Kssg+U+cUXmNMlmiUOBZHlOoSQNLHEKg7QdVql6vHExGiQAmqvvJAGCd+KeJ9zFPn9P8Q+8
 +ib7ciGg8N4Ib2mAzTUtTB2a+WRH+n3Ff7tJ5cm089bcpZAPvyxw+BJAO38XH8fiITN4QSe
 Ky3Fq7M7bhKO2T1W2vOyQ==
UI-OutboundReport: notjunk:1;M01:P0:nuRXNSbHXxM=;GA8+5y0bEHPM244ePthEph/8rqc
 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
 saYoigI+2sA==
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

On 02.07.25 17:25, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>=20
> Add a README
>=20
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> ---
>   MAINTAINERS                      |   1 +
>   doc/develop/uefi/fwu_arm_psa.rst | 153 +++++++++++++++++++++++++++++++
>   doc/develop/uefi/index.rst       |   1 +
>   3 files changed, 155 insertions(+)
>   create mode 100644 doc/develop/uefi/fwu_arm_psa.rst
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fdf34c74049..a75bc1d2379 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1231,6 +1231,7 @@ FWU ARM PSA
>   M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   M:	Davidson kumaresan <davidson.kumaresan@arm.com>
>   S:	Maintained
> +F:	doc/develop/uefi/fwu_arm_psa.rst
>   F:	include/fwu_arm_psa.h
>   F:	lib/fwu_updates/fwu_arm_psa.c
>  =20
> diff --git a/doc/develop/uefi/fwu_arm_psa.rst b/doc/develop/uefi/fwu_arm=
_psa.rst
> new file mode 100644
> index 00000000000..f91fd85f573
> --- /dev/null
> +++ b/doc/develop/uefi/fwu_arm_psa.rst
> @@ -0,0 +1,153 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright 2025 Arm Limited and/or its affiliates <open-source-office=
@arm.com>
> +
> +Firmware Update (FWU) Support for Arm PSA
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This README provides an overview of the Firmware Update (FWU) support

There  is no README here. How about:

U-Boot implements Firmware Update (FWU) support for Arm `PSA Certified`_=
=20
platforms.

> +implemented in U-Boot for Arm `PSA Certified`_ platforms, such as
> +Corstone-1000. The feature aligns with the Platform Security Firmware U=
pdate
> +specification for the A-profile Arm Architecture
> +(see `DEN0118 v1.0 A specification`_) and leverages the Trusted Service=
s (TS)
> +framework to interact with Secure world update agent.
> +
> +Overview
> +--------
> +
> +The FWU subsystem enables secure  firmware updates by
> +delegating the update management to a Secure world agent. U-Boot acts a=
s the
> +FWU client, coordinating updates via a well-defined set of ABIs over th=
e FF-A
> +interface (see :doc:`Arm FF-A Support <../../arch/arm64.ffa>`).
> +
> +FWU for Arm PSA supports both on-disk and standard capsule updates.
> +
> +Key Features
> +------------
> +
> +1. PSA Firmware Update Initialization
> +-------------------------------------
> +
> +- Initialization of the update agent using the FF-A transport and disco=
very of
> +  the Trusted Services FWU SP.
> +
> +- Discovery of the version of the ABIs using FWU_DISCOVER ABI.
> +
> +- Establishment and sharing of communication buffers between U-Boot
> +  (Normal world) and Secure world.
> +
> +2. ESRT Support
> +---------------
> +
> +Retrieval of ESRT (EFI System Resource Table) data from Secure world us=
ing
> +FWU_READ_STREAM ABI, enabling compliance with UEFI standards
> +(see `UEFI v2.10 specification`_).
> +
> +3. UEFI Capsule Handling
> +------------------------
> +
> +- Runtime checks for capsule flags as per UEFI 2.10 specification:
> +
> +    - CAPSULE_FLAGS_PERSIST_ACROSS_RESET
> +
> +    - CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE
> +
> +    - CAPSULE_FLAGS_INITIATE_RESET
> +
> +- Support for keeping the FMP payload header in Arm PSA mode to preserv=
e
> +  critical metadata required by Secure world.
> +
> +4. Staging and Update Flow
> +--------------------------
> +
> +- Full support for update staging flow as per PSA spec:
> +
> +    - FWU_BEGIN_STAGING
> +
> +    - FWU_END_STAGING
> +
> +    - FWU_CANCEL_STAGING
> +
> +    - FWU_WRITE_STREAM
> +
> +- Capsules can contain multiple payloads (including start/end markers
> +  and the update content).
> +
> +5. Directory Access
> +-------------------
> +
> +- Reading the FWU directory from Secure world using FWU_READ_STREAM ABI=
.
> +
> +6. Image Update Lifecycle
> +-------------------------
> +
> +- Implementation of get_image_info() and set_image() using raw EFI firm=
ware
> +  services provided by the FMP driver for raw images.
> +
> +- FWU_ACCEPT_IMAGE ABI issued on ExitBootServices() to commit successfu=
lly
> +  booted trial images.
> +
> +- Option to disable automatic acceptance on ExitBootServices() via
> +  CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES.
> +
> +Configuration Options
> +---------------------
> +
> +To enable FWU support for Arm PSA, include the following options in you=
r board
> +configuration:
> +
> +CONFIG_FWU_ARM_PSA=3Dy enables the PSA-compliant firmware update client=
 in U-Boot.

Please, use a formatting that lets the config parameters stick out:

CONFIG_FWU_ARM_PSA
     enables the PSA-compliant firmware update client in U-Boot.

CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES
     enables auto-acceptance on ExitBootServices(). Disable this setting
     if auto-acceptance shall be handled at a later boot stage.

> +
> +CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES=3Dy Enables auto-acceptance on
> +ExitBootServices(). This option is enabled by default. It can be disabl=
ed if
> +image acceptance should not be done at ExitBootServices().

Enabled by default implies that it can be disabled.
"if .. should not be done" conveys no new information.

> +
> +Platform Integration: Corstone-1000
> +-----------------------------------
> +
> +- Corstone-1000 is the reference implementation for the FWU Arm PSA fea=
ture.

A link to the board page should be good enough.

What is implemented for a specific board should be described there.

> +
> +- ESP partition detection is automated by setting Boot0001 in the U-Boo=
t bootcmd.

Please, state that you mean the environment variable bootcmd. How about=20
altbootcmd?

What would the variable bootcmd look like?

It is unclear to me which part of the information above is board=20
specific and which is not.

Best regards

Heinrich

> +
> +ABIs Implemented
> +----------------
> +
> +The following ABIs from the PSA FWU specification have been implemented=
:
> +
> +    - FWU_DISCOVER
> +
> +    - FWU_BEGIN_STAGING
> +
> +    - FWU_END_STAGING
> +
> +    - FWU_CANCEL_STAGING
> +
> +    - FWU_OPEN
> +
> +    - FWU_WRITE_STREAM
> +
> +    - FWU_READ_STREAM
> +
> +    - FWU_COMMIT
> +
> +    - FWU_ACCEPT_IMAGE
> +
> +ExitBootServices() Integration
> +------------------------------
> +
> +- The U-Boot FWU client performs several key actions during ExitBootSer=
vices():
> +
> +- Notifies Secure world about successful boot.
> +
> +- Accepts updated images in trial state.
> +
> +- Supports board-level override of fwu_notify_exit_boot_services() for =
custom
> +  behavior.
> +
> +Contributors
> +------------
> +   * Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> +   * Davidson kumaresan <davidson.kumaresan@arm.com>
> +
> +.. _`DEN0118 v1.0 A specification`: https://developer.arm.com/documenta=
tion/den0118/latest/
> +.. _`PSA Certified`: https://www.psacertified.org/
> +.. _`UEFI v2.10 specification`: https://uefi.org/specs/UEFI/2.10/
> diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
> index e26b1fbe05c..573630740a0 100644
> --- a/doc/develop/uefi/index.rst
> +++ b/doc/develop/uefi/index.rst
> @@ -10,6 +10,7 @@ can be run an UEFI payload.
>   .. toctree::
>      :maxdepth: 2
>  =20
> +   fwu_arm_psa.rst
>      uefi.rst
>      u-boot_on_efi.rst
>      iscsi.rst

