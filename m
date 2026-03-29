Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538F7F3D614
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 17:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01618394E;
	Sun, 29 Mar 2026 19:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="VPfdQJJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C64983B48; Sun, 29 Mar 2026 19:14:08 +0200 (CEST)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05EEE80325
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 19:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fkLZb70v4z49PxH;
 Sun, 29 Mar 2026 20:13:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1774804440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adCBWyyW5hw8egpRlYoWV+l9ClkLUQKFXTXlBJ6d9LA=;
 b=VPfdQJJeh+JxYBMbVBwRUbVQ+z/ubjYMNk+2xfCNMsnnMgNaX2K3YJZpEtv2Qlj0IOaZGe
 Yq2uQ+cmiNzuTQJaJmXz+hCmXSQmLTDsTMW6tKWXrMZwljbKilNZsoxLS1bVk11WAJwYZ5
 xqkXWNct1W9SOUdkl8nIT+kR8FxZBd0gv+omnKB8u4jEqLWDH/nIBuwD0zdnYYIKUWT4Dy
 GQ7vbjarAYLnBxvdOJrpJ2r1ViVHjrPc7nipY7d+2/FEQucsgZXakR1NF9iDigeBHwCoCL
 hn7Rjmqc3iAT19UD5VBUPuAmzMqCxDNkiUH71JYZ7mi4IX89srtIhN42juD2JA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1774804440;
 b=aU9cLKrusE4qrh028b/3i3ZEK49iJI3BqQiEy0ilUzwWm4M5hA9tYRpnB1/pCXhDugzVZ8
 gtg5DQ9k9p9fAstghTI0JrZIMyrFQmwHqOYi7Kn4t0w4ibKdiOx2cAWTslPhena5wx5Bzg
 v/Aq+3thaULSFkn3VPkVdnrQNDlDTh6Ve7yfZaEJa/AU4HdFAMuk7yPdPjnVp3+12L/qSh
 tl3nFZFeFxozfV6e4hfH4lVdyyvH3wY3PPzKasljIY65gDIDLZiWD14ALm58e5yrJutLj5
 FAaSRqZK+4R2p9KatBpQmA58h/AN+hUKJcEWlui9Ehij2R1j1Sgco4k7uoRgKQ==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1774804440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adCBWyyW5hw8egpRlYoWV+l9ClkLUQKFXTXlBJ6d9LA=;
 b=gzLTPDDJsAk5tuFZ0GFaUZOUYeQZDR2Bga8ujL7r1H0KurU7IF2r8qZpoooo8FSpz4LLhQ
 h9VsmgYr3y/xcLVcTqNFlf1OXTIj+bACAJ9NCg3UQNcFJVSOzCIVSsVzbFhka2r+bbyl4f
 aVQeoYIIbEHIgXMa5N3QseOH9LlrLPs842iMlhmFyHL+mX2kAmI8GYjR1N6RrLYUFRD1Xp
 WQJewHp/0NEaM7xw6BpR4Ud0FbnyQ/2I4q8ByWzQ/oHeAGg3Z/zpx7ZJec+hpKhI1J5eey
 4I0x1ySDedV3hQrL6usPiRPBa5MmXpQe0aXWYaHuXTWU+B4IJ2IxBIDdZYmxuQ==
Date: Sun, 29 Mar 2026 20:13:57 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>,
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com,
 trini@konsulko.com, afd@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
Message-ID: <acld1cniWiqp9dxB@kehys.lan>
References: <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com>
 <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com> <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan> <aceOvTK4JGQvET11@kehys.lan>
 <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
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

Hi Robert,

Sat, Mar 28, 2026 at 11:39:00AM -0500, Robert Nelson wrote:
>Side note, here's my ci builder for u-boot.. :
>https://github.com/beagleboard/u-boot-pocketbeagle2

Thank you. I see that the build_u-boot.sh is fetching trusted-firmware-a 
from a different source than I am (see below).

>For debug, if you have access to them, grab the Raspberry PI debug 
>cable: 
>https://www.digikey.com/en/products/detail/raspberry-pi/SC0889/17877576 
>and they are available globally..

Yesterday, a friend gave me an adapter cable that allows me to use an 
existing 3.3V compatible USB UART adapter.

When using the pristine PocketBeagle 2 MicroSD card image, I will get 
some messages from U-boot, followed by the console output from the Linux 
kernel and finally from the Debian user space.

With any of my self-built images, the SPL is unable to start the 64-bit 
U-boot:

U-Boot SPL 2026.01 (Mar 29 2026 - 15:56:33 +0000)
SYSFW ABI: 4.0 (firmware rev 0x000c '12.0.2--v12.00.02 (Clever Cat)')
Changed A53 CPU frequency to 1400000000Hz (T grade) in DT
SPL initial stack usage: 13416 bytes
Trying to boot from MMC2
Authentication passed
Authentication passed
Authentication passed
Authentication passed
Authentication passed
Starting ATF on ARM64 core...

I had a working build script for the phyBOARD Lyra, which I have 
slightly modified for this experiment. I have a build container that was 
set up some months ago, as follows:

FROM debian:latest

RUN apt update&&apt install -y build-essential bc flex bison libssl-dev kmod \
binutils-multiarch gcc-aarch64-linux-gnu gcc-arm-linux-gnueabihf \
python3 python3-setuptools python3-dev python3-cryptography \
python3-pyelftools python3-yaml yamllint python3-jsonschema swig gnutls-dev

I set up source directories like this:

[ -d u-boot ] ||
     git clone --depth=1 -b master https://source.denx.de/u-boot/u-boot.git \
         u-boot
[ -d trusted-firmware-a ] ||
     git clone --depth=1 -b master \
         https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/ \
         trusted-firmware-a
[ -d optee_os ] ||
     git clone --depth=1 -b master https://github.com/OP-TEE/optee_os.git \
         optee_os
[ -d ti-linux-firmware ] ||
     git clone --depth=1 -b ti-linux-firmware \
         https://git.ti.com/git/processor-firmware/ti-linux-firmware.git \
         ti-linux-firmware

Initially, I used some older checkouts of the other components.  
Updating them to the latest did not make any difference: the SPL was 
able to start up also with the older snapshots.

Here are the git revisions that I used of the above directories:

u-boot: your ef03e35488377a32cdd4f76d1a03ef7f60c798ef
trusted-firmware-a: 8dae0862c502e08568a61a1050091fa9357f1240 (Mar 23)
optee_os: 1c0c7c06563e9be0ebc55b47cdb71422b02906a6 (Mar 23)
ti-linux-firmware: 12.00.00.07 (Mar 20)

For podman run, I am bind-mounting the source directory tree using the 
:O (overlay) option. So, even though I appear to run "in-source" build, 
the original source directories outside the container will remain 
unchanged. The files tiboot3.bin, tispl.bin, and u-boot.img are 
generated by running the following commands inside the container:

make -j$(nproc) -C trusted-firmware-a CROSS_COMPILE=aarch64-linux-gnu- \
ARCH=aarch64 PLAT=k3 SPD=opteed TARGET_BOARD=lite

make -j$(nproc) -C optee_os CROSS_COMPILE=arm-linux-gnueabihf- \
CROSS_COMPILE64=aarch64-linux-gnu- CFG_ARM64_core=y CFG_WITH_SOFTWARE_PRNG=y \
PLATFORM=k3-am62x

cd u-boot
make am62_pocketbeagle2_r5_defconfig &&
make -j$(nproc) CROSS_COMPILE=arm-linux-gnueabihf- \
BINMAN_INDIRS=$(pwd)/../ti-linux-firmware &&

make am62_pocketbeagle2_a53_defconfig &&
make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu- \
BINMAN_INDIRS=$(pwd)/../ti-linux-firmware \
BL31=$(pwd)/../trusted-firmware-a/build/k3/lite/release/bl31.bin \
TEE=$(pwd)/../optee_os/out/arm-plat-k3/core/tee-raw.bin

Based on reviewing your build script, I revised the above by adding 
TFA_EXTRA_ARGS=K3_USART_0x6 to trusted-firmware-a and 
CFG_CONSOLE_UART=0x6 to optee_os, but they made no difference.  
Furthermore, I replaced tee-raw.bin with tee-pager_v2.bin: no change.

What am I doing wrong here?

With best regards,

	Marko
