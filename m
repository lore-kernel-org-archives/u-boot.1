Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4A9C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F35B801DE;
	Fri,  7 Feb 2025 19:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SxfpRFyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D870580207; Fri,  7 Feb 2025 19:39:50 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F46801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:39:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 07F813FE71
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738953585;
 bh=Fo+e/FgWKaiakoDyE1n4PItRhSdbilMxmu2WeCeveGs=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=SxfpRFyRKz4Z5XiWP9zhe4J5NFhbxx5fo0dIISnouQOR+HnE/vMPxwHILiwnQdGtx
 nHL5ssUFZ0a82UmlekR5TCnS2Zq8+7YrJio9WiZTxb+HJwuVRZ4sgwhPQ47z8rYm3m
 804MczsgUyZcAiIa6wXUpMlJ7zMM5rAVBIDBz9MVtu268X3HnWeJz2PProaUqS0dC5
 vM2q6A+bCVmnYE+NEeHXlJeRNmRXBZl5TMVguvMFlc5Tk3sMbeSgL0ef2dd+sdAR/S
 6i3/XE7mqs0v05fsFnNAikZu0zRiQEVDl0Au94XuXuqWsiuBPVPUYjxcrU1VxQTM2X
 qVnTFQDLXTzCg==
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2f9eb31238aso7775154a91.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953578; x=1739558378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fo+e/FgWKaiakoDyE1n4PItRhSdbilMxmu2WeCeveGs=;
 b=UxKojKEALIg9RG6S2r73DZksmuiXxutjGDhLyrrr8xy7xk/ytveduMjmLm7Jd9Hx/P
 3wamrZVV6vDr7wXBwH4yUK7YAL6Y28rGNOziPZ1YhTXp5YqhuyLr06AcwmZQZxxWUZJc
 9ia/ag7iNtPhpKVL6zY8LzvTpMVRlu+ocGanLx3VywV8FmZwpO51kWGfevuv+WVagr/5
 8sy3c3SarwUJVTromhfc4r85OzJTSN196IlRK6kqfQ0h6Kf9KOM74bVkx0hB9SZnt1Xn
 6miGhtHjhA510SVVRGy8IS6cPns6wiCLrjFHAyIcQHdSgK2cVqAj9fBU+laYEzFJj4AQ
 5YAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQJfjkZ1E4sioFjGBCwzIbgJQ/5ocV1g9eIVsM3ZsCCzzigDMM1hjCBWIq+ef1nDV+BpmqQeg=@lists.denx.de
X-Gm-Message-State: AOJu0YwhG81NyRpou1ZSOkQj9OZB7ztuoU/z6fHXkxP717oOBmPP5UsJ
 iDVjhr1XRzbrkeoDa4wzLtp9xCofQ7qrkY3c7d58vAMo40JNd7mr0/EKjkv135J2Q0KMC0AIhVy
 KyW3KobCuQ8pyeL8YkAj9PhQMJsGrv21fP8D01ZwQOWcHCvwaGbe12IU4IobShYh0oFD5ZOi8sQ
 /BQJLwCRr99epv1PYvXkdXwFOEBeTrGX1l9VuKVHVXZg==
X-Gm-Gg: ASbGncuxmM5cn+Qo9M2jfIFbTx8rOuOmaHvD3a9jOrvUZMvrvUfUOJBwdi0R0RtKHfU
 WgU9iGtLNE4u+azxA71tvY4NsqYxKKAXmw8JjQo/0Yie2PyeSIORo8JgV/0Wc+QKtIW89/aWp/U
 4OUjii/GQWUsMRlXQzOc4=
X-Received: by 2002:a17:90b:1b44:b0:2ee:fa0c:cebc with SMTP id
 98e67ed59e1d1-2fa2417c124mr6654350a91.20.1738953577796; 
 Fri, 07 Feb 2025 10:39:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMDy1KC/VJZQElaeoMEbXFTciIh9I02cw882wRYmLqLCon4TrUG2KZLXJiYBWaMLHrFeYzu+K8BAF5qL7eJ6U=
X-Received: by 2002:a17:90b:1b44:b0:2ee:fa0c:cebc with SMTP id
 98e67ed59e1d1-2fa2417c124mr6654315a91.20.1738953577352; Fri, 07 Feb 2025
 10:39:37 -0800 (PST)
MIME-Version: 1.0
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-7-heinrich.schuchardt@canonical.com>
 <CANV2PTNvw7B_TFcssCUSpNjTSzaLauMxuX9c8az9i_s4fmUiKQ@mail.gmail.com>
In-Reply-To: <CANV2PTNvw7B_TFcssCUSpNjTSzaLauMxuX9c8az9i_s4fmUiKQ@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Fri, 7 Feb 2025 19:39:25 +0100
X-Gm-Features: AWEUYZkwdalBYgyfbYFlYAtXGOTlLvh8094vHuQFQYbyXoxsRFxI73rdtZxx2mU
Message-ID: <CAM=mAOn9QsMhZStn=eOuUAGdSF3ok8r=EsF4irODKCC9+6Aang@mail.gmail.com>
Subject: Re: [PATCH 6/6] doc: add DeepComputing FML13V01 documentation
To: E Shattow <lucent@gmail.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>, 
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, 
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 Nam Cao <namcao@linutronix.de>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

E Shattow <lucent@gmail.com> schrieb am Fr., 7. Feb. 2025, 19:10:

> Can we reduce the visionfive2 multi-target docs down to one document for
> the target and not each individual board? Essentially the differences are
> the mmc ordering and what boot mode GPIO selection is possible. Much is
> copy-paste anyhow. -E
>

A user will start searching for the specific board at hand.

There is board specific information for the board:

- how to access UART0
- open case detection
- the labelling of the boot device switch

Maybe we could introduce an include for the common parts as has been done
for other SoCs.

Best regards

Heinrich



> On Fri, Feb 7, 2025, 09:22 Heinrich Schuchardt <
> heinrich.schuchardt@canonical.com> wrote:
>
>> Describe building U-Boot for the board and booting.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>  doc/board/starfive/deepcomputing_fml13v01.rst | 143 ++++++++++++++++++
>>  doc/board/starfive/index.rst                  |   1 +
>>  2 files changed, 144 insertions(+)
>>  create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
>>
>> diff --git a/doc/board/starfive/deepcomputing_fml13v01.rst
>> b/doc/board/starfive/deepcomputing_fml13v01.rst
>> new file mode 100644
>> index 00000000000..0d0295555b6
>> --- /dev/null
>> +++ b/doc/board/starfive/deepcomputing_fml13v01.rst
>> @@ -0,0 +1,143 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +DeepComputing Framework Motherboard (FLM13V01)
>> +==============================================
>> +
>> +The DeepComputing Framework motherboard (FLM13V01) can be combined with a
>> +13 inch Framework laptop chassis to provide a complete laptop.
>> +
>> +U-Boot for the board uses the same binaries as the VisionFive 2 board.
>> +Currently only serial console output is supported by mainline U-Boot.
>> +
>> +Building
>> +--------
>> +
>> +Setup the cross compilation environment variable:
>> +
>> +.. code-block:: bash
>> +
>> +   export CROSS_COMPILE=riscv64-linux-gnu-
>> +
>> +The M-mode software OpenSBI provides the supervisor binary interface
>> (SBI) and
>> +is responsible for the switch to S-Mode. It is a prerequisite for
>> building
>> +U-Boot. Support for the JH7110 was introduced in OpenSBI 1.2. It is
>> recommended
>> +to use a current release.
>> +
>> +.. code-block:: bash
>> +
>> +    git clone https://github.com/riscv/opensbi.git
>> +    cd opensbi
>> +    make PLATFORM=generic FW_TEXT_START=0x40000000 FW_OPTIONS=0
>> +    export
>> OPENSBI="$(pwd)/build/platform/generic/firmware/fw_dynamic.bin"
>> +
>> +Now build U-Boot SPL and main U-Boot.
>> +
>> +.. code-block:: bash
>> +
>> +    cd <U-Boot-dir>
>> +    make starfive_visionfive2_defconfig
>> +    make
>> +
>> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out)
>> as well
>> +as the FIT image (u-boot.itb) with OpenSBI, U-Boot, and device-trees.
>> +
>> +Device-tree selection
>> +---------------------
>> +
>> +The product ID stored in the board EEPROM is used by U-Boot SPL to
>> select the
>> +right configuration and device-tree from the u-boot.itb FIT image.
>> +
>> +Furthermore if variable $fdtfile has not been saved in the environment
>> it is
>> +set based on the product ID to
>> *starfive/jh7110-deepcomputing-fml13v01.dtb*.
>> +
>> +To overrule this default the variable can be set manually and saved in
>> the
>> +environment
>> +
>> +.. code-block:: console
>> +
>> +    setenv fdtfile my_device-tree.dtb
>> +    env save
>> +
>> +Power switch
>> +------------
>> +
>> +A tiny power switch is located in right upper corner of the board.
>> +
>> +Open case detection
>> +-------------------
>> +
>> +The board has an open case detection switch. Red lights will flash and
>> the
>> +board will not boot if the switch is not held down.
>> +
>> +UART
>> +----
>> +
>> +UART 0 is exposed via the side channel contacts SBU1 and SBU2 of the
>> lower,
>> +right USB C connector. A USB C cable and a breakout board are needed for
>> +physical access. It depends on the cable orientation on which of SBU1
>> and SBU2
>> +you will find RX and TX. The signal voltage is 3.3 V. The baud rate is
>> 115200.
>> +
>> +Boot source selection
>> +---------------------
>> +
>> +The board provides DIP switches to select the device for loading the boot
>> +firmware.
>> +
>> +=========== === ===
>> +Boot source SW1 SW2
>> +=========== === ===
>> +UART        OFF OFF
>> +SD-card     ON  OFF
>> +eMMC        OFF ON
>> +SPI flash   ON  ON
>> +=========== === ===
>> +
>> +Flashing a new U-Boot version
>> +-----------------------------
>> +
>> +U-Boot SPL is provided as file spl/u-boot-spl.bin.normal.out. Main
>> U-Boot is
>> +in file u-boot.itb.
>> +
>> +Assuming your new U-Boot version is on partition 1 of an SD-card you
>> could
>> +install it to the SPI flash with:
>> +
>> +.. code-block:: console
>> +
>> +    sf probe
>> +    load mmc 1:1 $kernel_addr_r u-boot-spl.bin.normal.out
>> +    sf update $kernel_addr_r 0 $filesize
>> +    load mmc 1:1 $kernel_addr_r u-boot.itb
>> +    sf update $kernel_addr_r 0x100000 $filesize
>> +
>> +For loading the files from a TFTP server refer to the dhcp and tftpboot
>> +commands.
>> +
>> +After updating U-Boot you may want to erase a saved environment and
>> reboot.
>> +
>> +.. code-block:: console
>> +
>> +    env erase
>> +    reset
>> +
>> +Booting from SD-Card or eMMC
>> +----------------------------
>> +
>> +The device boot ROM loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
>> +partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are
>> free
>> +to choose any partition number.
>> +
>> +With the default configuration U-Boot SPL loads the U-Boot FIT image
>> +(u-boot.itb) from partition 2
>> (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>> +When formatting it is recommended to use GUID
>> +BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>> +
>> +Booting from UART
>> +-----------------
>> +
>> +The boot ROM supports the X-modem protocol to upload
>> +spl/u-boot-spl.bin.normal.out. U-Boot SPL support loading the FIT image
>> +u-boot.itb via the Y-modem protocol.
>> +
>> +Due to restrictions of the boot ROM not all X-modem implementations are
>> +compatible. The package tio (https://github.com/tio/tio) has been found
>> to be
>> +usable.
>> diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
>> index 72ab6ddfbf6..ce0ee4a0a2f 100644
>> --- a/doc/board/starfive/index.rst
>> +++ b/doc/board/starfive/index.rst
>> @@ -6,6 +6,7 @@ StarFive
>>  .. toctree::
>>     :maxdepth: 1
>>
>> +   deepcomputing_fml13v01
>>     milk-v_mars
>>     milk-v_mars_cm
>>     pine64_star64
>> --
>> 2.47.1
>>
>>
