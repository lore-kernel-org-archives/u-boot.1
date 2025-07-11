Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8F0C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E84981FEE;
	Fri, 11 Jul 2025 16:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A389482AFC; Fri, 11 Jul 2025 16:49:32 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DBF58803DF
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95C5316F8;
 Fri, 11 Jul 2025 07:49:18 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.35.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B37A23F738;
 Fri, 11 Jul 2025 07:49:25 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Adam Johnston <Adam.Johnston@arm.com>
Subject: [PATCH v2 00/25] Introduce Firmware Update Support for Arm PSA
Date: Fri, 11 Jul 2025 15:48:52 +0100
Message-Id: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

This patch series adds Firmware Update (FWU) support for Arm PSA
Certified platforms [1], enabling U-Boot to serve as
the FWU Client, with the Secure World acting as the Update Agent that
manages the firmware store and its metadata.

This implementation adheres to the Platform Security Firmware Update
specification [3] for the A-profile Arm Architecture and leverages the
Trusted Services framework [4] to interact with the Secure World update
agent. By delegating update management to the Secure World, U-Boot
handles only the client-side coordination, invoking a well-defined set
of ABIs over the FF-A interface [5] to deliver update capsules.

Key features include:

- Generic, platform-agnostic design.
- FF-A-based ABI: All interactions between U-Boot and the update agent
    occur over the FF-A interface, ensuring compatibility across
    PSA-compliant systems.
- Multi-payload capsules: Support for capsules containing multiple
    payloads, start/end markers, signed firmware images.
- ESRT support: Capsule payloads may be signed for authenticity, and
    U-Boot can populate the EFI System Resource Table (ESRT) for
     OS-level firmware management.
- On-disk and standard capsule handling.

For implementation details, please refer to the documentation [6].
For a real world example, please see the Arm PSA FWU logs [7] when used
for on-disk capsule update in Corstone-1000 [2].

Changes in v2:

- Remove the NULL check on FF-A ops as per Heinrich's suggestion
- Simplify efi_firmware_raw_set_image() logic (no more "else" branch)
- Clean up CAPSULE_FLAGS_* checks
- Add /** markers for kernel-doc formatting
  (Michal Simek recommendation)
- Address nits in the documentation

Cheers,
Abdellatif

[1]: PSA: https://www.psacertified.org
[2]: Corstone-1000: https://developer.arm.com/Processors/Corstone-1000
[3]: DEN0118 v1.0 A specification: https://developer.arm.com/documentation/den0118/latest 
[4]: Trusted Services documentation: https://trusted-services.readthedocs.io/en/stable
[5]: FF-A interface: doc/arch/arm64.ffa.rst
[6]: Documentation of the FWU for Arm PSA support: doc/develop/uefi/fwu_arm_psa.rst
[7]: Arm PSA FWU logs when used for on-disk capsule update in Corstone-1000

```
CapsuleApp: capsule block/size              0xDD741040/0x25ACE
Found EFI system partition on Boot0001: OnDiskFWU
FS2:;HD0b:;BLK4: 
Succeed to write edk2-corstone1000-fvp-v6.uefi.capsule
resetting ...
NOTICE:  BL2: v2.11.0(debug):v2.11.0-dirty
...
U-Boot 2025.07-rc5 (Jul 10 2025 - 15:23:22 +0000) corstone1000 aarch64 
...
FWU: System booting in Regular State
FWU: ABI version 1.0 detected
FWU: Updating 1 payload(s)
Applying capsule edk2-corstone1000-fvp-v6.uefi.capsule succeeded.
Reboot after firmware update.
NOTICE:  BL2: v2.11.0(debug):v2.11.0-dirty
...
U-Boot 2025.07-rc5 (Jul 10 2025 - 15:23:22 +0000) corstone1000 aarch64 
...
FWU: System booting in Trial State
...
Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0
...
root@corstone1000-fvp:~# reboot
...
U-Boot 2025.07-rc5 (Jul 10 2025 - 15:23:22 +0000) corstone1000 aarch64 
...
FWU: System booting in Regular State
...
Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0

corstone1000-fvp login:

root@corstone1000-fvp:~# cat /sys/firmware/efi/esrt/entries/entry*/*
0x0
f1d883f9-dfeb-5363-98d8-686ee3b69f4f
0
6
0
6
0
0x0
7fad470e-5ec5-5c03-a2c1-4756b495de61
0
0
0
0
0
0x0
f1933675-5a8c-5b6d-9ef4-846739e89bc8
0
0
0
0
0
0x0
f771aff9-c7e9-5f99-9eda-2369dd694f61
0
0
0
0
0
root@corstone1000-fvp:~# 
```

Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Davidson kumaresan <davidson.kumaresan@arm.com>
Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Cc: Adam Johnston <Adam.Johnston@arm.com>

Abdellatif El Khlifi (24):
  arm_ffa: Remove NULL pointer check for ops
  arm_ffa: Add FFA_MEM_SHARE support
  arm_ffa: Add FFA_MEM_RECLAIM support
  arm_ffa: sandbox: Replace the emulator error log with debug log
  arm_ffa: sandbox: Improve the readability of clearing the X registers
  arm_ffa: sandbox: Add FFA_MEM_SHARE emulation
  arm_ffa: sandbox: Add FFA_MEM_SHARE tests
  arm_ffa: sandbox: Add FFA_MEM_RECLAIM emulation
  arm_ffa: sandbox: Add FFA_MEM_RECLAIM tests
  fwu_arm_psa: Initialize the update agent
  fwu_arm_psa: Read the FWU directory through get_image_info()
  fwu_arm_psa: Add staging ABIs
  efi_loader: fwu_arm_psa: Add set_image and get_image_info support
  efi_loader: fwu_arm_psa: Keep the FMP payload header
  efi_loader: fwu: fwu_arm_psa: Skip accepting the payload after
    set_image()
  efi_loader: fwu: fwu_arm_psa: Disable trial state handling
  fwu_arm_psa: Add FWU acceptance mechanism
  fwu_arm_psa: Add ESRT support
  fwu_arm_psa: Add ExitBootService() notification handler
  fwu_arm_psa: corstone1000: Enable FWU support
  fwu_arm_psa: corstone1000: Perform bank logic when reading boot index
  fwu_arm_psa: corstone1000: Notify SE Proxy SP on ExitBootService()
  fwu_arm_psa: corstone1000: Set Boot0001 for on-disk FWU
  fwu_arm_psa: Document FWU support for Arm PSA

Emekcan Aras (1):
  efi_loader: capsule: Add runtime capsule flags checks

 MAINTAINERS                                   |    8 +
 .../include/asm/sandbox_arm_ffa_priv.h        |   21 +-
 board/armltd/corstone1000/corstone1000.c      |  255 ++-
 board/armltd/corstone1000/corstone1000.env    |    8 +
 configs/corstone1000_defconfig                |   13 +-
 doc/arch/arm64.ffa.rst                        |    4 +
 doc/develop/uefi/fwu_arm_psa.rst              |  154 ++
 doc/develop/uefi/index.rst                    |    1 +
 drivers/firmware/arm-ffa/arm-ffa-uclass.c     |  285 +++-
 drivers/firmware/arm-ffa/arm-ffa.c            |    4 +-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  108 +-
 drivers/firmware/arm-ffa/sandbox_ffa.c        |    4 +-
 include/arm_ffa.h                             |  111 +-
 include/arm_ffa_priv.h                        |  143 +-
 include/efi_api.h                             |    8 +
 include/efi_loader.h                          |    8 +
 include/fwu_arm_psa.h                         |  427 +++++
 lib/efi_loader/efi_capsule.c                  |   64 +-
 lib/efi_loader/efi_firmware.c                 |   42 +-
 lib/fwu_updates/Kconfig                       |   26 +
 lib/fwu_updates/Makefile                      |    2 +
 lib/fwu_updates/fwu.c                         |   29 +-
 lib/fwu_updates/fwu_arm_psa.c                 | 1508 +++++++++++++++++
 test/dm/ffa.c                                 |   73 +-
 24 files changed, 3216 insertions(+), 90 deletions(-)
 create mode 100644 doc/develop/uefi/fwu_arm_psa.rst
 create mode 100644 include/fwu_arm_psa.h
 create mode 100644 lib/fwu_updates/fwu_arm_psa.c


base-commit: 59e6462d7c08eeba744afa0f17846c398b8ef9e1
-- 
2.25.1

