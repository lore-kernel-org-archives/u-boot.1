Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C039AD78760
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15396896BB;
	Thu, 21 Nov 2024 15:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AcPgaObv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7EC4896BF; Thu, 21 Nov 2024 15:14:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8156A894B7
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732198466; x=1732803266; i=xypron.glpk@gmx.de;
 bh=Pr7eHdnStKyaltDlb9yArTMvg58O4WjSXtI4y9qZsT4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AcPgaObvbVwoZjsjmKZC6t21As8c/XRkenUAbPCLFh8R2zDLEPGmlECw58vo8FNC
 GzHEBLKuoYfN50gHjYTST0ngBMjNs2YfRCq2St0DCO9o+ljaCrllRFzvkrdZHjbCG
 d47mkRRxwT/rC9qGOJvhbTqholklj6A7DVLfPOLZZRAhed3/95SX/2pMcXN3KDTlp
 NDpnAy21jsNnZE1HUduCoGDnu8t484Y7+ZPb7vUgjJAmFvtAtXIJrF+A+u0Tq7BVe
 nfHX6N9kEfPy/uXAVBgY9lJkejNcF5pYpyAVOPe2sF3nIX/5m7ow0Bnd23zWzoaHW
 1beb4mwFHfTP8PsxJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1tkAyz3EE8-00ixMz; Thu, 21
 Nov 2024 15:14:25 +0100
Message-ID: <294edbe6-4e91-495f-923a-71c196a29514@gmx.de>
Date: Thu, 21 Nov 2024 15:14:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Kconfig: clean up the efi configuration status
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anton.Antonov@arm.com,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 u-boot@lists.denx.de, E Shattow <lucent@gmail.com>
References: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
 <b4bbd3db-c099-44d0-b532-99070865d55c@gmx.de>
 <20241121140155.GI3600562@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241121140155.GI3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pgi6eD9h7P+1ura/BjQXQYfUKgnqD+Pig0/UQMs/Sk2YgmZ9r2t
 ZEjeJCcimdZzpx5zr6ON6uc4XsXQcBgkvNuT69Ru5QZiXEbpdI1lF32CPKN+iRCpmUD93K9
 j4N97GTxAd0mjZIUdr0drXhURcKBW9WfQFi6iU4uip+F5XSjXaBfE2g0klk7olz9u5nAN6/
 lqO0KUosGUPmyawHBg+xw==
UI-OutboundReport: notjunk:1;M01:P0:1aUlggDAUmo=;YMx1356ykRM/tM6LNDntueyNHmK
 HP70W0TW8JHA+UOmHMh9Ekv2PXv1cvmeg0HG7+UruPD1cj6TtTMhJXnNNg2DnADwL10ntLtgL
 VTalvovWDhvnD8qLYSOd0Y4xuxfFuVkHibgHSQacZkqxMBOhHz/xkPIs7agUoRNXjAnDsQ7oM
 gu1K0ljiRXtAhMTLKkFn2qCexbhHvSFn2Wn4EFCgRZi/02Gtb2Fgcd7czRVGotzRwNry0v242
 oAzBZSQ0EMLh0XrPNH9E9wJS70V9HpPXKdp2K6i1x5uPiHWcfTr8UlSUkJXmt5unkP6Ew4JdA
 aGrUg+A7ZralXC1yYck6NyGPwVg6PFWFS3tYBli1tsFW0JhWJMjNaCbpFoHVtIiiSq+XpvT6f
 vYvfuDODdW0ZeAhlQJyoNUDdvTFp0eSMwrThcsuPsra7o/k3SQRKnXoRWwluVAHndp6boC+d9
 RZLyJaAzl4FdsaBJVyFj3EEIFKAes2N1t+WOVqKE5xHSycB3vkeEfqraf+B6YrwvcXcJBwfR8
 Y7rajxW3J8d3518DJkyf9BOjAQ2CK02QSwiPL6J3cgUqGXHaQZTRyzpbj6Q4xDc4koCpPw7Xx
 PFDBUWyOrZuxz1oM+sLxVKlMRFt8ZEE0l8iUgNVU5X0p37h5laXWXoKAbpUr5AeRqBOjxoMai
 eF7BgNGanJ11P3BarPM6AmOUkSczRlcqdKhEXGR6DvPrw1KjLNob/LAkROs0Q71mojxvKP/PR
 VFO8aTSxrMa8SvKqjXGvtwzQ6XQcZniiCPDOFgWPkV8EStqU8axiKTuPvxXtjIuGsR77w1X3G
 D1+SLp6JDRt0fsWon9gwNCkRX/sZ+PcbMfkG9ylaWxJqFPRgLjR7t04g9/FDOLTOevttflCvL
 DDmzW9QvgLjht7Q5BF6ZQRLKBzcA/+0TzcRQeXvypPWITY7AssWlVG+xs
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

On 21.11.24 15:01, Tom Rini wrote:
> On Thu, Nov 21, 2024 at 02:53:53PM +0100, Heinrich Schuchardt wrote:
>> On 30.08.24 13:45, Ilias Apalodimas wrote:
>>> The EFI_LOADER and EFI config options are randomly scattered under lib=
/
>>> making it cumbersome to navigate and enable options, unless you really
>>> know what you are doing. On top of that the existing options are in
>>> random order instead of a logical one.
>>>
>>> So let's move things around a bit and move them under boot/. Present a
>>> generic UEFI entry where people can select Capsules, Protocols,
>>> Services,  and an option to compile U-Boot as an EFI for X86
>>>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> ---
>>> Changes since v1:
>>> - Move the EFI Loader under boot/ instead of having it on the main men=
u
>>> - Fold in the U-Boot as an EFI app option under the new EFI menu
>>>    boot/Kconfig           |   2 +
>>>    lib/Kconfig            |   2 -
>>>    lib/efi/Kconfig        |   5 +
>>>    lib/efi_loader/Kconfig | 204 +++++++++++++++++++++++---------------=
---
>>>    4 files changed, 124 insertions(+), 89 deletions(-)
>>>
>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>> index 940389d4882f..a1477eb8c7e1 100644
>>> --- a/boot/Kconfig
>>> +++ b/boot/Kconfig
>>> @@ -1,5 +1,7 @@
>>>    menu "Boot options"
>>>
>>> +source "lib/efi_loader/Kconfig"
>>> +
>>>    menu "Boot images"
>>>
>>>    config ANDROID_BOOT_IMAGE
>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>> index 2059219a1207..06b4e9a73135 100644
>>> --- a/lib/Kconfig
>>> +++ b/lib/Kconfig
>>> @@ -1081,8 +1081,6 @@ config SMBIOS_PARSER
>>>    	help
>>>    	  A simple parser for SMBIOS data.
>>>
>>> -source "lib/efi/Kconfig"
>>> -source "lib/efi_loader/Kconfig"
>>>    source "lib/optee/Kconfig"
>>>
>>>    config TEST_FDTDEC
>>> diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
>>> index c2b9bb73f718..81ed3e66b34d 100644
>>> --- a/lib/efi/Kconfig
>>> +++ b/lib/efi/Kconfig
>>> @@ -1,3 +1,6 @@
>>> +menu "U-Boot as UEFI application"
>>> +	depends on X86
>>> +
>>>    config EFI
>>>    	bool "Support running U-Boot from EFI"
>>>    	depends on X86
>>> @@ -72,3 +75,5 @@ config EFI_RAM_SIZE
>>>    	  use. U-Boot allocates this from EFI on start-up (along with a fe=
w
>>>    	  other smaller amounts) and it can never be increased after that.
>>>    	  It is used as the RAM size in with U-Boot.
>>> +
>>> +endmenu
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index 6ffefa9103ff..0756be61d688 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -1,3 +1,5 @@
>>> +menu "UEFI Support"
>>> +
>>>    config EFI_LOADER
>>>    	bool "Support running UEFI applications"
>>>    	depends on OF_LIBFDT && ( \
>>> @@ -41,13 +43,58 @@ config EFI_BINARY_EXEC
>>>    	  You may enable CMD_BOOTEFI_BINARY so that you can use bootefi
>>>    	  command to do that.
>>>
>>> -config EFI_BOOTMGR
>>> -	bool "UEFI Boot Manager"
>>> +config EFI_SECURE_BOOT
>>> +	bool "Enable EFI secure boot support"
>>> +	depends on EFI_LOADER && FIT_SIGNATURE
>>> +	select HASH
>>> +	select SHA256
>>> +	select RSA
>>> +	select RSA_VERIFY_WITH_PKEY
>>> +	select IMAGE_SIGN_INFO
>>> +	select ASYMMETRIC_KEY_TYPE
>>> +	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>>> +	select X509_CERTIFICATE_PARSER
>>> +	select PKCS7_MESSAGE_PARSER
>>> +	select PKCS7_VERIFY
>>> +	select MSCODE_PARSER
>>> +	select EFI_SIGNATURE_SUPPORT
>>> +	help
>>> +	  Select this option to enable EFI secure boot support.
>>> +	  Once SecureBoot mode is enforced, any EFI binary can run only if
>>> +	  it is signed with a trusted key. To do that, you need to install,
>>> +	  at least, PK, KEK and db.
>>> +
>>> +config EFI_SIGNATURE_SUPPORT
>>> +	bool
>>> +
>>> +menu "UEFI services"
>>> +
>>> +config EFI_GET_TIME
>>> +	bool "GetTime() runtime service"
>>> +	depends on DM_RTC
>>>    	default y
>>>    	help
>>> -	  Select this option if you want to select the UEFI binary to be boo=
ted
>>> -	  via UEFI variables Boot####, BootOrder, and BootNext. You should a=
lso
>>> -	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is availab=
le.
>>> +	  Provide the GetTime() runtime service at boottime. This service
>>> +	  can be used by an EFI application to read the real time clock.
>>> +
>>> +config EFI_SET_TIME
>>> +	bool "SetTime() runtime service"
>>> +	depends on EFI_GET_TIME
>>> +	default y if ARCH_QEMU || SANDBOX
>>> +	help
>>> +	  Provide the SetTime() runtime service at boottime. This service
>>> +	  can be used by an EFI application to adjust the real time clock.
>>> +
>>> +config EFI_HAVE_RUNTIME_RESET
>>> +	# bool "Reset runtime service is available"
>>> +	bool
>>> +	default y
>>> +	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
>>> +		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
>>> +
>>> +endmenu
>>> +
>>> +menu "UEFI Variables"
>>>
>>>    choice
>>>    	prompt "Store for non-volatile UEFI variables"
>>> @@ -172,30 +219,18 @@ config EFI_VAR_BUF_SIZE
>>>
>>>    	  Minimum 4096, default 131072
>>>
>>> -config EFI_GET_TIME
>>> -	bool "GetTime() runtime service"
>>> -	depends on DM_RTC
>>> -	default y
>>> +config EFI_PLATFORM_LANG_CODES
>>> +	string "Language codes supported by firmware"
>>> +	default "en-US"
>>>    	help
>>> -	  Provide the GetTime() runtime service at boottime. This service
>>> -	  can be used by an EFI application to read the real time clock.
>>> +	  This value is used to initialize the PlatformLangCodes variable. I=
ts
>>> +	  value is a semicolon (;) separated list of language codes in nativ=
e
>>> +	  RFC 4646 format, e.g. "en-US;de-DE". The first language code is us=
ed
>>> +	  to initialize the PlatformLang variable.
>>>
>>> -config EFI_SET_TIME
>>> -	bool "SetTime() runtime service"
>>> -	depends on EFI_GET_TIME
>>> -	default y if ARCH_QEMU || SANDBOX
>>> -	help
>>> -	  Provide the SetTime() runtime service at boottime. This service
>>> -	  can be used by an EFI application to adjust the real time clock.
>>> +endmenu
>>>
>>> -config EFI_SCROLL_ON_CLEAR_SCREEN
>>> -	bool "Avoid overwriting previous output on clear screen"
>>> -	help
>>> -	  Instead of erasing the screen content when the console screen shou=
ld
>>> -	  be cleared, emit blank new lines so that previous output is scroll=
ed
>>> -	  out of sight rather than overwritten. On serial consoles this allo=
ws
>>> -	  to capture complete boot logs (except for interactive menus etc.)
>>> -	  and can ease debugging related issues.
>>> +menu "Capsule support"
>>>
>>>    config EFI_HAVE_CAPSULE_SUPPORT
>>>    	bool
>>> @@ -309,6 +344,10 @@ config EFI_CAPSULE_CRT_FILE
>>>    	  embedded in the platform's device tree and used for capsule
>>>    	  authentication at the time of capsule update.
>>>
>>> +endmenu
>>> +
>>> +menu "UEFI protocol support"
>>> +
>>>    config EFI_DEVICE_PATH_TO_TEXT
>>>    	bool "Device path to text protocol"
>>>    	default y
>>> @@ -362,39 +401,6 @@ config EFI_UNICODE_CAPITALIZATION
>>>
>>>    endif
>>>
>>> -config EFI_LOADER_BOUNCE_BUFFER
>>> -	bool "EFI Applications use bounce buffers for DMA operations"
>>> -	help
>>> -	  Some hardware does not support DMA to full 64bit addresses. For th=
is
>>> -	  hardware we can create a bounce buffer so that payloads don't have=
 to
>>> -	  worry about platform details.
>>> -
>>> -config EFI_PLATFORM_LANG_CODES
>>> -	string "Language codes supported by firmware"
>>> -	default "en-US"
>>> -	help
>>> -	  This value is used to initialize the PlatformLangCodes variable. I=
ts
>>> -	  value is a semicolon (;) separated list of language codes in nativ=
e
>>> -	  RFC 4646 format, e.g. "en-US;de-DE". The first language code is us=
ed
>>> -	  to initialize the PlatformLang variable.
>>> -
>>> -config EFI_HAVE_RUNTIME_RESET
>>> -	# bool "Reset runtime service is available"
>>> -	bool
>>> -	default y
>>> -	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
>>> -		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
>>> -
>>> -config EFI_GRUB_ARM32_WORKAROUND
>>> -	bool "Workaround for GRUB on 32bit ARM"
>>> -	default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
>>> -	default y
>>> -	depends on ARM && !ARM64
>>> -	help
>>> -	  GRUB prior to version 2.04 requires U-Boot to disable caches. This
>>> -	  workaround currently is also needed on systems with caches that
>>> -	  cannot be managed via CP15.
>>> -
>>>    config EFI_RNG_PROTOCOL
>>>    	bool "EFI_RNG_PROTOCOL support"
>>>    	depends on DM_RNG
>>> @@ -447,29 +453,36 @@ config EFI_LOAD_FILE2_INITRD
>>>    	  installed and Linux 5.7+ will ignore any initrd=3D<ramdisk> comm=
and line
>>>    	  argument.
>>>
>>> -config EFI_SECURE_BOOT
>>> -	bool "Enable EFI secure boot support"
>>> -	depends on EFI_LOADER && FIT_SIGNATURE
>>> -	select HASH
>>> -	select SHA256
>>> -	select RSA
>>> -	select RSA_VERIFY_WITH_PKEY
>>> -	select IMAGE_SIGN_INFO
>>> -	select ASYMMETRIC_KEY_TYPE
>>> -	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>>> -	select X509_CERTIFICATE_PARSER
>>> -	select PKCS7_MESSAGE_PARSER
>>> -	select PKCS7_VERIFY
>>> -	select MSCODE_PARSER
>>> -	select EFI_SIGNATURE_SUPPORT
>>> +config EFI_RISCV_BOOT_PROTOCOL
>>> +	bool "RISCV_EFI_BOOT_PROTOCOL support"
>>> +	default y
>>> +	depends on RISCV
>>>    	help
>>> -	  Select this option to enable EFI secure boot support.
>>> -	  Once SecureBoot mode is enforced, any EFI binary can run only if
>>> -	  it is signed with a trusted key. To do that, you need to install,
>>> -	  at least, PK, KEK and db.
>>> +	  The EFI_RISCV_BOOT_PROTOCOL is used to transfer the boot hart ID
>>> +	  to the next boot stage. It should be enabled as it is meant to
>>> +	  replace the transfer via the device-tree. The latter is not
>>> +	  possible on systems using ACPI.
>>>
>>> -config EFI_SIGNATURE_SUPPORT
>>> -	bool
>>> +endmenu
>>> +
>>> +menu "Misc options"
>>> +config EFI_LOADER_BOUNCE_BUFFER
>>> +	bool "EFI Applications use bounce buffers for DMA operations"
>>> +	depends on ARM64
>>
>> Hello Ilias,
>>
>> your merged patch revoked
>>
>> dcd1b63b7072 ("efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all
>> architectures")
>>
>> which we need to fix problems on JH7110 boards with more than 4 GiB.
>>
>> We need to add the revoked patch again.
>>
>
> Can we do that as a "today" solution, and make EFI_LOADER_BOUNCE_BUFFER
> disappear and just be enabled by BOUNCE_BUFFER for v2025.04 please?
>

As discussed with Simon the implementation of a bounce buffer should
only exist in the block device layer and not in the UEFI sub-system. We
should strive to make that change with the April release.

But as off today JH7110 board with more than 4 GiB fail to boot without
this setting.

Best regards

Heinrich
