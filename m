Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91838CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A5D83AB4;
	Tue, 11 Nov 2025 09:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K6JcEJUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAB8D83B2C; Tue, 11 Nov 2025 09:18:56 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB93183A91
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4edacc41dc5so19492161cf.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762849133; x=1763453933; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lyI3gF/xaKrWWr8Zj0/ajtvVzYdfUWvQ3SMHggzMXEU=;
 b=K6JcEJUxO1kUar9xDR4ZDWFQbq4KecuQv8XVfdH66aMe6IkA+yUWbiyEHo79FI3itz
 ul7TcwTjFlOu7wjiI3NXFr1wBgl0mV8iRAfkktEdEnFYK2A60/Y87SpB+eKGEnJQIDaQ
 RTvvh81F0U+QX2QiKb3FhlLzH4r8YK6pSn+qa7aUTTHMrFPVCthNSFEiG9pXHg5o418R
 iPnSJE4qiiJ63LaKu/NNb0Hr6lPH7S731ZQpElHaJFkZyMBpsMB63r315l9cBajtzWax
 bQTeYEJ0SBYsfoUgHvB/nqviQFlhb8uFVqocoMU8c00otV0sdAcaBwiJmJnkOoneK6gm
 mUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762849133; x=1763453933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyI3gF/xaKrWWr8Zj0/ajtvVzYdfUWvQ3SMHggzMXEU=;
 b=wLDmd9Gw6nPV2FMndBkJqoY8PuLbUd/z+LFoPCreiI1qtHjTrNYaaRjkaX3o7LNUAj
 8YjsGmiF5Awl1la20wZ54ycuePnT8tuQqDUkYNlR2o5+xyxEYOZ1M0sHiIZgoFIPLc3h
 KZX4b1ZhXqZSAH9VZb/i4aGPmclHeEuxaH0RQnt4Humz2pW3+71fTFG+Ogn2vcs+uuTm
 d0dEOuPlAO3wipNvWwZ5ywvZ9N++sB/vviNLoVGJIBWcAYay4LqBtcNqTlMYwujPAAmo
 iHtaSr7kiJeqTWWVDEobKfWiycXtzSix54lt2nmrGqVkzCuebu4rtkqUzXktwdDyC8wi
 x8wQ==
X-Gm-Message-State: AOJu0YyW+F+LsNiwqDkc46R2qdqWbGby34iKLuOdmxc5tRSLTA+zvsl6
 YoRfe38UdB5jsPC7HTM7GXHiOcltGHlFDMrxrVPf5a4Lm9mO3Wojvp05BhOxQLQSvcSzuDXFrNi
 KblsgZIo3bm6bjzu2lO1jufvjMkqKmW7ENpGHAr8MHQ==
X-Gm-Gg: ASbGncv4Cf4AERmG+WpRg+f6CHyLx6n4+p6MgNbOWpQJZjTztqPYkvRNtNwv6IK865p
 H9XnAr+TQk2Ve79gO74ewCsj5yofFQcLtvrhVO9+MhGb82G5bvwKtqX4DJQ57pZcHS5dQGbtZUJ
 s8EduaRAAVAan+mQai4f9TrKuOyvPrOwJsv/1PlZl//v7zFPv2soEuTS4IHqYhpanejiXqja0jx
 cuMx3THG69Oi99C8d0vJ5ipLuD81XGAzyxMdI+eRJuW5jUoVNbGppu8o8xJgA==
X-Google-Smtp-Source: AGHT+IGBS1u4MHtcZs0gJTSgFNHQI/IGcuCu+w17Ve+0WbD3k2EIrFPpf4RMCE7WqpHCtp4XUyHNWijKXaL3nFID/iE=
X-Received: by 2002:ac8:5856:0:b0:4e8:baad:9875 with SMTP id
 d75a77b69052e-4eda4e70d87mr134855991cf.4.1762849132463; Tue, 11 Nov 2025
 00:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20250926141351.1755829-1-abdellatif.elkhlifi@arm.com>
In-Reply-To: <20250926141351.1755829-1-abdellatif.elkhlifi@arm.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Nov 2025 13:48:40 +0530
X-Gm-Features: AWmQ_bn2rKXNuktXam_Sh1eRiH8PhqZ3kEqO_-58Sl8Pvli0CMc9H69byWEDORM
Message-ID: <CADg8p96wRz75JzMZ+ce3ZWsUMwPezeh3qp-ohDxgAjCBRhM48g@mail.gmail.com>
Subject: Re: [PATCH v5 00/24] Introduce Firmware Update Support for Arm PSA
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Davidson kumaresan <davidson.kumaresan@arm.com>, 
 Adam Johnston <Adam.Johnston@arm.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Srinivas Kalaga <Srinivas.Kalaga2@arm.com>
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

On Fri, 26 Sept 2025 at 19:44, <abdellatif.elkhlifi@arm.com> wrote:
>
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
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
> For trying the implementation on Corstone-1000 FVP, please follow these steps [8].


As mentioned in our offline conversation, I am not sure why this code
also compiling in the normal-world based FWU implementation in U-Boot.
That portion of code should not be built on platforms which are going
to have U-Boot working as a FWU update client. This includes the FWU
metadata access driver code and the code under lib/fwu_updates/.
Please check how this can be kept separate. Thanks.

-sughosh

>
> Changes in v5:
>
> * As suggested by Ilias:
>     - Make PSA handling simpler for the payload acceptance logic
>     - Use efi_fill_image_desc_array() for PSA
>       instead of changing efi_firmware_get_image_info()
>
> * Add CONFIG_FWU_KEEP_FMP_HEADER to control whether
>   the user wants to keep the FMP header or strip it from the payload
>
> * Address kernel-doc warnings
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
> [8]: Performing Capsule update on Corstone-1000 FVP and MPS3:
>      https://git.yoctoproject.org/meta-arm/tree/meta-arm-bsp/documentation/corstone1000/user-guide.rst#n838
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
>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Davidson kumaresan <davidson.kumaresan@arm.com>
> Cc: Adam Johnston <Adam.Johnston@arm.com>
> Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
> Cc: Srinivas Kalaga <Srinivas.Kalaga2@arm.com>
>
> Abdellatif El Khlifi (23):
>   arm_ffa: Add FFA_MEM_SHARE support
>   arm_ffa: Add FFA_MEM_RECLAIM support
>   arm_ffa: sandbox: Replace the emulator error log with debug log
>   arm_ffa: sandbox: Improve the readability of clearing the X registers
>   arm_ffa: sandbox: Add FFA_MEM_SHARE emulation
>   arm_ffa: sandbox: Add FFA_MEM_SHARE tests
>   arm_ffa: sandbox: Add FFA_MEM_RECLAIM emulation
>   arm_ffa: sandbox: Add FFA_MEM_RECLAIM tests
>   fwu_arm_psa: Initialize the update agent
>   fwu_arm_psa: Read the FWU directory through get_image_info()
>   fwu_arm_psa: Add staging ABIs
>   efi_loader: fwu_arm_psa: Add set_image() support
>   efi_loader: fwu_arm_psa: Allow keeping the FMP payload header
>   efi_loader: fwu: fwu_arm_psa: Skip accepting the payload after
>     set_image()
>   efi_loader: fwu: fwu_arm_psa: Disable trial state handling
>   fwu_arm_psa: Add FWU acceptance mechanism
>   fwu_arm_psa: Add ESRT support
>   fwu_arm_psa: Add ExitBootService() notification handler
>   fwu_arm_psa: corstone1000: Enable FWU support
>   fwu_arm_psa: corstone1000: Perform bank logic when reading boot index
>   fwu_arm_psa: corstone1000: Notify SE Proxy SP on ExitBootService()
>   fwu_arm_psa: corstone1000: Set Boot0001 for on-disk FWU
>   fwu_arm_psa: Document FWU support for Arm PSA
>
> Emekcan Aras (1):
>   efi_loader: capsule: Add runtime capsule flags checks
>
>  MAINTAINERS                                   |    8 +
>  .../include/asm/sandbox_arm_ffa_priv.h        |   21 +-
>  board/armltd/corstone1000/corstone1000.c      |  252 ++-
>  board/armltd/corstone1000/corstone1000.env    |    8 +
>  configs/corstone1000_defconfig                |   13 +-
>  doc/arch/arm64.ffa.rst                        |    4 +
>  doc/develop/uefi/fwu_arm_psa.rst              |  154 ++
>  doc/develop/uefi/index.rst                    |    1 +
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c     |  285 +++-
>  drivers/firmware/arm-ffa/arm-ffa.c            |    4 +-
>  drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  108 +-
>  drivers/firmware/arm-ffa/sandbox_ffa.c        |    4 +-
>  include/arm_ffa.h                             |  128 +-
>  include/arm_ffa_priv.h                        |  153 +-
>  include/efi_api.h                             |    8 +
>  include/efi_loader.h                          |    8 +
>  include/fwu_arm_psa.h                         |  403 +++++
>  lib/efi_loader/efi_capsule.c                  |   46 +-
>  lib/efi_loader/efi_firmware.c                 |   32 +-
>  lib/fwu_updates/Kconfig                       |   34 +
>  lib/fwu_updates/Makefile                      |    2 +
>  lib/fwu_updates/fwu.c                         |   24 +-
>  lib/fwu_updates/fwu_arm_psa.c                 | 1467 +++++++++++++++++
>  test/dm/ffa.c                                 |   73 +-
>  24 files changed, 3154 insertions(+), 86 deletions(-)
>  create mode 100644 doc/develop/uefi/fwu_arm_psa.rst
>  create mode 100644 include/fwu_arm_psa.h
>  create mode 100644 lib/fwu_updates/fwu_arm_psa.c
>
>
> base-commit: 59e6462d7c08eeba744afa0f17846c398b8ef9e1
> --
> 2.43.0
>
