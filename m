Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E493CF9C69
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 09:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8270788AE8;
	Sun, 22 Sep 2024 11:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cqXWXqzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B459588B58; Sun, 22 Sep 2024 11:02:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98833887FA
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 11:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726995768; x=1727600568; i=xypron.glpk@gmx.de;
 bh=lyrcP1Zi/k7CJOq8be2HHpc9wPCwezrE/qXxNT+Mux0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cqXWXqzm8aWNEpTv/z6UkaWPoa7ZxU3IW8onftT0NS8zw4fe/3OkOnoGdjfuCaRL
 o8Wi4Rqi0KRYHWDW8tSk42I8sfrPtooAwEIir0dGagBMHq3Z/2jnpkU1JDHYKVh1q
 6a+qobu8lRjgLMENgr6ssHQo1r6hDzGPGEV6KQaL6Xw9PQ23f69sTD16IYHF2DlG7
 qprfDxm275BSdU1uMwUVFJlfhv/Y8/MuOpCa4OkDL1BjNawc4xNUpVJ8Muen04SRi
 k2PNUOkOipgYIkOz14mnMDx2070cyi/ZpZNtf+AODcsnV/oGkyJEZ/WHis9fZbIHj
 iCxl7/OLHjHVahoFcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.108.39]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1snde50EOf-00DbrQ; Sun, 22
 Sep 2024 11:02:48 +0200
Message-ID: <7969171f-e3e2-4492-8eda-b2cba7376dcb@gmx.de>
Date: Sun, 22 Sep 2024 11:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Move the generic memory-documentation to doc/
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>,
 Heiko Schocher <hs@denx.de>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240919151424.57663-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240919151424.57663-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bKoMyr8lYMLPj7xYjJUXOLH/zeV1VDKwdAB1nMIfUraitUjjAqN
 9mimXYHlZkZ4zpOoMRZHBEZb889OK7a+YnBvu3dh07UdKOht753yZ9RBsdYAWHGvjukxp7W
 VqH/GT40dLKauFcdJb+INiBf+LU0l2UknpjBTT8thAN4I7WW5VfUOMbZ35hXWegV/twbzEO
 sbGPl8abpoTz+yLbLmPPA==
UI-OutboundReport: notjunk:1;M01:P0:BGiDUM/oJwU=;FNtN6xCYfdCln+BpvwFkrt5akXP
 wpli8z0wxMg0cscBqCdYXBu3Y7K5T2HuA6FkdJgUcEKnFqTAZ76qFfe3KE/qcrEaMSNpiIjz9
 JD/OXJgAPtIbF8iCPgYMwEnzXPPzTKYAk52QvTPQO0UX7JmIpshxaR52gLzit1PMGMozUPujJ
 g7PlxG15cx2+MxKVKI+wmE/w7oQKDchCx0ZxENbYnCaHhtJkoFBDa/3whPgDFaa52hYwz2X5o
 VNHws5zZMox2UhtrjS8TTPmBYIrP5lFVtQpIy7Kd3fQ2AtEa3+NLtn+j/NS2KJbBwZQVuwvEt
 u2t3mFO488/y98uyPN69x1ypDSfFNUCSweOXyNjEFwhGYrqjMqQxthn1j1ajjM7dYHNNQkrPP
 xF9UEeQBTFBLQnfQNLI4B+H9ywqpx400gtq7j+UxnW8Pyp/IshrZIoqddHrqebvn2jHyOA7VD
 1RBu8K3iCm8f/WdtDGh789aZovEQjqQ/tkQw7ccf1DMQ1tsZLDyU7NS1a9AAj27DiNtXhQrON
 JP9mnO8vJBNw/S473Kz2sC2oPPZ9dYFiGE/1YPPsNICDCKxFN3rTaIhAObI6InRtQBbFvTg27
 WDVRYpPhKwozq3+p2p4/V8t2gSvMXACXsKcCu4U07IC4F8NMQd7bPfTUhpEihID07g/jvPFPp
 yO6bm/Y10jVsTFaEvc089tK8NEqXvOKR2alUuxsjLXtnRx47s+rv5mXGAlAUA9WsbrVGTY/gl
 ngWYFyi2mP+HMZ7HEYMKVaqFgIuBdWfbfaMe68su5zzBf029SZrCNMHJeNWmZhQVm6bMSKbR8
 AGwc2JomfcdW0yswfUCTzngQ==
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

On 9/19/24 17:14, Simon Glass wrote:
> Move this section of the README into doc/ with some minor updates to
> mention SPL and user lower-case hex.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   README                 | 45 ------------------------------------------
>   doc/develop/index.rst  |  1 +
>   doc/develop/memory.rst | 45 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 46 insertions(+), 45 deletions(-)
>   create mode 100644 doc/develop/memory.rst
>
> diff --git a/README b/README
> index 4be1e8c22a0..d73042406b6 100644
> --- a/README
> +++ b/README
> @@ -2516,51 +2516,6 @@ On RISC-V, the following registers are used:
>
>       =3D=3D> U-Boot will use gp to hold a pointer to the global data
>
> -Memory Management:
> -------------------
> -
> -U-Boot runs in system state and uses physical addresses, i.e. the
> -MMU is not used either for address mapping nor for memory protection.
> -
> -The available memory is mapped to fixed addresses using the memory
> -controller. In this process, a contiguous block is formed for each
> -memory type (Flash, SDRAM, SRAM), even when it consists of several
> -physical memory banks.
> -
> -U-Boot is installed in the first 128 kB of the first Flash bank (on
> -TQM8xxL modules this is the range 0x40000000 ... 0x4001FFFF). After
> -booting and sizing and initializing DRAM, the code relocates itself
> -to the upper end of DRAM. Immediately below the U-Boot code some
> -memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN
> -configuration setting]. Below that, a structure with global Board
> -Info data is placed, followed by the stack (growing downward).
> -
> -Additionally, some exception handler code is copied to the low 8 kB
> -of DRAM (0x00000000 ... 0x00001FFF).
> -
> -So a typical memory configuration with 16 MB of DRAM could look like
> -this:
> -
> -	0x0000 0000	Exception Vector code
> -	      :
> -	0x0000 1FFF
> -	0x0000 2000	Free for Application Use
> -	      :
> -	      :
> -
> -	      :
> -	      :
> -	0x00FB FF20	Monitor Stack (Growing downward)
> -	0x00FB FFAC	Board Info Data and permanent copy of global data
> -	0x00FC 0000	Malloc Arena
> -	      :
> -	0x00FD FFFF
> -	0x00FE 0000	RAM Copy of Monitor Code
> -	...		eventually: LCD or video framebuffer
> -	...		eventually: pRAM (Protected RAM - unchanged by reset)
> -	0x00FF FFFF	[End of RAM]
> -
> -
>   System Initialization:
>   ----------------------
>
> diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> index 0d0e60ab56c..cbea38d4323 100644
> --- a/doc/develop/index.rst
> +++ b/doc/develop/index.rst
> @@ -13,6 +13,7 @@ General
>      codingstyle
>      designprinciples
>      docstyle
> +   memory
>      patman
>      process
>      release_cycle
> diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
> new file mode 100644
> index 00000000000..fa1ae5e97ed
> --- /dev/null
> +++ b/doc/develop/memory.rst
> @@ -0,0 +1,45 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +Memory Management
> +-----------------
> +
> +U-Boot runs in system state and uses physical addresses, i.e. the
> +MMU is not used either for address mapping nor for memory protection.

Hello Simon,

Thanks for getting the description moved.

The text that you are copying dates back to 2004 when U-Boot was
focusing on the Power architecture. It needs some rework.

On RISC-V there is a physical memory protection (PMP) which is typically
set up to guard against overwriting OpenSBI sitting at the lower end of RA=
M.

There is some ongoing work to implement NX protection via the MMU for ARM.

> +
> +The available memory is mapped to fixed addresses using the
> +memory-controller. In this process, a contiguous block is formed for ea=
ch
> +memory type (Flash, SDRAM, SRAM), even when it consists of several
> +physical-memory banks.

Can we simply say DRAM instead of SDRAM. We always refer to DRAM below.
Whether the RAM frequency is synchronous or not is irrelevant here.

> +
> +U-Boot is installed in XIP flash memory, or may be loaded into a lower =
region of
> +RAM by a secondary program loader (SPL). After

This does not describe U-Boot SPL as being a part of U-Boot.

> +booting and sizing and initialising DRAM, the code relocates itself

Initialization of DRAM can be done in code running before U-Boot.

> +to the upper end of DRAM. Immediately below the U-Boot code some
 > +memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN>
+configuration setting]. Below that, a structure with global Board-Info
> +data is placed, followed by the stack (growing downward).
> +
> +Additionally, some exception handler code may be copied to the low 8 kB
> +of DRAM (0x00000000 ... 0x00001fff).

The exception handler code for RISC-V and ARMv8 is typically not located
at 0x0.

On RISC-V stvec, the Supervisor Trap Vector Base Address Register,
defines where the exception vectors are located in S-Mode.

On ARMv8 VBAR_EL2, the Vector Base Address Register (EL2), sets the
location of the EL2 vector base.

> +
> +So a typical memory configuration with 16 MB of DRAM could look like

%s/MB/MiB/

> +this::
> +
> +	0x0000 0000	Exception Vector code

On RISC-V the lowest memory addresses in RAM are typically used by
OpenSBI. On ARM you may have TF-A sitting there.

> +	      :
> +	0x0000 1fff
> +	0x0000 2000	Free for Application Use
> +	      :
> +	      :
> +
> +	      :
> +	      :
> +	0x00fb ff20	Monitor Stack (Growing downward)
> +	0x00fb ffac	Board Info Data and permanent copy of global data
> +	0x00fc 0000	Malloc Arena
> +	      :
> +	0x00fd ffff
> +	0x00fe 0000	RAM Copy of Monitor Code
> +	...		eventually: LCD or video framebuffer
> +	...		eventually: pRAM (Protected RAM - unchanged by reset)
> +	0x00ff ffff	[End of RAM]

A description of the LMB and EFI should be added in a future patch.

Best regards

Heinrich
