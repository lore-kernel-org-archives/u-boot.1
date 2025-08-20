Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F205CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 12:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A888211F;
	Wed, 20 Aug 2025 14:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA2E382B07; Wed, 20 Aug 2025 14:33:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 270C3801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 14:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49B2A150C;
 Wed, 20 Aug 2025 05:33:35 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.37.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6B453F63F;
 Wed, 20 Aug 2025 05:33:39 -0700 (PDT)
Date: Wed, 20 Aug 2025 13:33:31 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Adam Johnston <Adam.Johnston@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 00/24] Introduce Firmware Update Support for Arm PSA
Message-ID: <aKXAm3utM25aZ3pO@e130802.arm.com>
References: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
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

Hi Heinrich, Michal,

> This patch series adds Firmware Update (FWU) support for Arm PSA
> Certified platforms [1], enabling U-Boot to serve as
> the FWU Client, with the Secure World acting as the Update Agent that
> manages the firmware store and its metadata.
> 
> This implementation adheres to the Platform Security Firmware Update
> specification [3] for the A-profile Arm Architecture and leverages the
> Trusted Services framework [4] to interact with the Secure World update
> agent. By delegating update management to the Secure World, U-Boot
> handles only the client-side coordination, invoking a well-defined set
> of ABIs over the FF-A interface [5] to deliver update capsules.
> 
> Key features include:
> 
> - Generic, platform-agnostic design.
> - FF-A-based ABI: All interactions between U-Boot and the update agent
>     occur over the FF-A interface, ensuring compatibility across
>     PSA-compliant systems.
> - Multi-payload capsules: Support for capsules containing multiple
>     payloads, start/end markers, signed firmware images.
> - ESRT support: Capsule payloads may be signed for authenticity, and
>     U-Boot can populate the EFI System Resource Table (ESRT) for
>      OS-level firmware management.
> - On-disk and standard capsule handling.
> 
> For implementation details, please refer to the documentation [6].
> For a real world example, please see the Arm PSA FWU logs [7] when used
> for on-disk capsule update in Corstone-1000 [2].
> 
> Changes in v4:
> 
> - Update the function headers in fwu_arm_psa.c to pass kernel-doc tests
> 
> Cheers,
> Abdellatif
> 
> [1]: PSA: https://www.psacertified.org
> [2]: Corstone-1000: https://developer.arm.com/Processors/Corstone-1000
> [3]: DEN0118 v1.0 A specification: https://developer.arm.com/documentation/den0118/latest 
> [4]: Trusted Services documentation: https://trusted-services.readthedocs.io/en/stable
> [5]: FF-A interface: doc/arch/arm64.ffa.rst
> [6]: Documentation of the FWU for Arm PSA support: doc/develop/uefi/fwu_arm_psa.rst
> [7]: Arm PSA FWU logs when used for on-disk capsule update in Corstone-1000
> 
> ```
> CapsuleApp: capsule block/size              0xDD741040/0x25ACE
> Found EFI system partition on Boot0001: OnDiskFWU
> FS2:;HD0b:;BLK4: 
> Succeed to write edk2-corstone1000-fvp-v6.uefi.capsule
> resetting ...
> NOTICE:  BL2: v2.11.0(debug):v2.11.0-dirty
> ...
> U-Boot 2025.07-rc5 (Jul 10 2025 - 15:23:22 +0000) corstone1000 aarch64 
> ...
> FWU: System booting in Regular State
> FWU: ABI version 1.0 detected
> FWU: Updating 1 payload(s)
> Applying capsule edk2-corstone1000-fvp-v6.uefi.capsule succeeded.
> Reboot after firmware update.
> NOTICE:  BL2: v2.11.0(debug):v2.11.0-dirty
> ...
> U-Boot 2025.07-rc5 (Jul 10 2025 - 15:23:22 +0000) corstone1000 aarch64 
> ...
> FWU: System booting in Trial State
> ...
> Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0
> ...
> root@corstone1000-fvp:~# reboot
> ...
> U-Boot 2025.07-rc5 (Jul 10 2025 - 15:23:22 +0000) corstone1000 aarch64 
> ...
> FWU: System booting in Regular State
> ...
> Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0
> 
> corstone1000-fvp login:
> 
> root@corstone1000-fvp:~# cat /sys/firmware/efi/esrt/entries/entry*/*
> 0x0
> f1d883f9-dfeb-5363-98d8-686ee3b69f4f
> 0
> 6
> 0
> 6
> 0
> 0x0
> 7fad470e-5ec5-5c03-a2c1-4756b495de61
> 0
> 0
> 0
> 0
> 0
> 0x0
> f1933675-5a8c-5b6d-9ef4-846739e89bc8
> 0
> 0
> 0
> 0
> 0
> 0x0
> f771aff9-c7e9-5f99-9eda-2369dd694f61
> 0
> 0
> 0
> 0
> 0
> root@corstone1000-fvp:~# 
> ```

This is a gentle reminder regarding the review of my patchset.
All review comments have been addressed in the latest version.

For your convenience, here are the test instructions for evaluating the Arm PSA
Firmware Update (FWU) on the Fixed Virtual Platform (FVP):

1) Building the Software Stack on Corstone-1000:

    Please refer to the Corstone-1000 User Guide [1] for detailed build and
    configuration steps.

2) Generating Capsules and Testing on FVP:

    Instructions for creating firmware update capsules and running the tests on
    the FVP can be found here [2].

Your review and feedback would be greatly appreciated.

Cheers
Abdellatif

[1]: https://git.yoctoproject.org/meta-arm/tree/meta-arm-bsp/documentation/corstone1000/user-guide.rst
[2]: https://git.yoctoproject.org/meta-arm/tree/meta-arm-bsp/documentation/corstone1000/user-guide.rst#n838
