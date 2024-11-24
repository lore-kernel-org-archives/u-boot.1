Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B690E668BA
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 16:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C225D8955E;
	Sun, 24 Nov 2024 17:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BLpO7Gze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7BA789547; Sun, 24 Nov 2024 15:41:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACAAE88E24
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 15:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732459265; x=1733064065; i=xypron.glpk@gmx.de;
 bh=PixhUjKCt3GZmRA4Ob7bp3gWGY65uPu326uKd32jHpw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BLpO7Gzei9nZ+GRXOzWusGtkC4R3oL2YFNkfoNYdFCzKd8C4ERgsJXAfKH5H+26w
 egc8GHc+E0CIbS+WOnCQlWuJTdFQeAXHDRr8UoKpyIWzT6MLQyJqHlh9cQX9fhvhh
 ft3wkxosxbGceZOHneGVHCo/XHtjOx4phHBECexcGE4QDAVQp/c9mpnW5wOhIbzf/
 WlmsDqiT7M8Br63m1Z1Gl2hfE563WNDWzXCGWVj+ayZVJKL3SMsbtm9bOhRqWwq+n
 i9WPuhp/pVT0sf3mY8cNnAF9+AjVcNPr/hpvhuCMLnpvRrELQ4B1tT5dlvA4eighN
 OjrKFgjc3uHKNbZMZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKHc-1teho438v6-00xuiI; Sun, 24
 Nov 2024 15:41:04 +0100
Message-ID: <62d1cf97-82e0-41e8-a8e8-bb4699057382@gmx.de>
Date: Sun, 24 Nov 2024 15:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Improve UEFI app support
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Hanyuan Zhao <hanyuan-z@qq.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Philip Oberfichtner
 <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Romain Naour
 <romain.naour@smile.fr>, Sam Edwards <CFSworks@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241123195616.305687-1-mjg59@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:537hfapR72Ai7zCk9/1HG4KnOyVk3jW+SGBBaUmkg/RPzQmIBxY
 4eEHA8Mye8Y8FogB5bhHPRAO0kM5jLJQ7aszN3Xs2CH+t8MdFRkRXW/HaF9llAbiM3OWv88
 D/B7A4dqO5bsDytVkU279XaCxXoTmkk0B4eYxSdXmy+XV+wAYD/pl8GVE/uAFjghzRErFe5
 Sro/oNoZ2Fpgn9Hgofuqw==
UI-OutboundReport: notjunk:1;M01:P0:ovirtZ1nZYw=;mPET7j4j29rgM5MlCuI+0tSvInV
 jk1yF+PvEv7XztG74gh8fL6Zm2Mk3R/JJbMFL/vJGJvQSttNNy+NGU5lM1RyAmT6EadHPdgk7
 1dKxectDaufC7GlapWowfJgVLMlGHRUzOL4eZwDup3SlEIPXfgaMn+jGiCXIHyzos0QLQxElu
 oZdnJwgmBJyoFp7s5aEkzuwlGTVoZ/9WuBZ8qvXZd3Il9E57S+5suE7R9i8no5KYS/z2SIq5M
 rVvFH4BsYv9/PXwzv4ZcTGmnzwKprl4PmFhbUQ7QJBslJuGv+vArIddR/PmtkqK0l+PD0o3kV
 E9Nk7MylKEd94CZIPDnCgjuDovDK/HNF9DSYVYLu9xgiikP4JkEmvnoVgVgH5SVBbDYRQfdRq
 bUn2JQWgkW/2iLiwZMvc/dgc2iGs8jvSG2OJK1CXJ30s+pjMGIMN/Q2Hmoe6rGVX/UAHRQmSl
 QEEBNCGfZW0GnViDQbdrBCmdmOjw674j/3gjYeyFWchPdwzS6sz9oiTqRj288uNmWcNvfRbpu
 kNo9U6bCVqsTmavyLszPsk0nw/Mhqho+KjVFhn9l3x7S0P8BNa6jJwXFN8IzszVzPnjgi4vwy
 UFH4KMVzdEmoYFDeZ8e+iytT9I1p21qwsInBT2qdxUKmgVMtu+o8p2sOUxv4zgaihFokzDUyG
 GNy84mZ48ao/kwBBcLHi7U359FSjOWO75VvCy2NFr+etgh5F/YhgJOOsuqi+ccsEhRsccR6+L
 2EEzSunLd7CLL+PD23fCGNQXGNIYGxkaFzDMuxJwqqMXPuepDyrDXiHiETmWF5RMV8qD1q4Is
 fV2H8oXV8/cbPzTZbfjAJ/FZptkpst36LRtZ0uWHSKdKqpqXax9UVJoGJEE4X53nFQ7eJCbwJ
 Mu2U6vhLCcDrkQe5QQ592cUtxki+v4O6DWdZ7jE36eDkHZeioj4CsaTdP
X-Mailman-Approved-At: Sun, 24 Nov 2024 17:05:39 +0100
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

On 11/23/24 20:54, Matthew Garrett wrote:
> We run a mixed environment including traditional embedded Linux and
> UEFI. For consistency it's valuable to use U-Boot in both cases, but on
> UEFI systems we want to run the full Linux kernel UEFI boot stub. This
> patchset adds support for that, along with various other quality-of-life
> improvements such as automatically finding partitions based on their
> GUID, automatic identification of load addresses where the firmware has
> given us constraints, support for EFI variable access in the EFI app,
> drivers for EFI network adapters and TPMs, support for embedding DTBs in
> the EFI app, and a couple of bug fixes.

Hello Matthew,

Unfortunately from what you write I do not understand what you are missing=
.

We already have the bootefi command to execute EFI applications
including the EFI stub.

We have support for FIT images including an EFI kernel and a
device-tree. Initrd support could be added here.

Embedding DTBs into the EFI app is something you should implement in the
EFI stub. The EFI stub should invoke the EFI_DT_FIXUP_PROTOCOL after
choosing the device-tree.

Could you, please, elaborate a bit more on you target.

>
>
> Janis Danisevskis (1):
>    Fix efi_bind_block.
>
> Matthew Garrett (9):
>    Add EFI handover support to bootm

This already exists if you enable CONFIG_BOOTM_EFI.

Best regards

Heinrich

>    Add part_find command
>    Add a command to find a load address
>    Hook up EFI env variable support in the EFI app
>    Add EFI network driver
>    Add UEFI TPM2 driver
>    Support separate DTB files with the UEFI app
>    Use the correct ramdisk address
>    Add command to set an environment variable to an EFI variable
>
>   Makefile                        |   7 +-
>   arch/x86/config.mk              |   2 +-
>   arch/x86/lib/bootm.c            |  60 ++++++++----
>   arch/x86/lib/elf_x86_64_efi.lds |   4 +
>   boot/bootm.c                    |   5 +
>   cmd/Kconfig                     |  23 ++++-
>   cmd/Makefile                    |   3 +
>   cmd/addr_find.c                 |  87 +++++++++++++++++
>   cmd/efigetenv.c                 | 133 ++++++++++++++++++++++++++
>   cmd/part_find.c                 | 156 ++++++++++++++++++++++++++++++
>   drivers/net/Kconfig             |   7 ++
>   drivers/net/Makefile            |   1 +
>   drivers/net/efi_net.c           | 110 +++++++++++++++++++++
>   drivers/tpm/Kconfig             |   7 ++
>   drivers/tpm/Makefile            |   1 +
>   drivers/tpm/tpm2_efi.c          |  97 +++++++++++++++++++
>   include/asm-generic/sections.h  |   1 +
>   include/bootm.h                 |   6 ++
>   include/efi.h                   |  24 +++++
>   include/efi_tcg2.h              |   1 +
>   lib/efi/Makefile                |   2 +-
>   lib/efi/efi.c                   |   1 +
>   lib/efi/efi_app.c               |  41 ++++++++
>   lib/efi/efi_app_init.c          | 163 ++++++++++++++++++++++++++++++--
>   lib/efi/efi_dtb.S               |   6 ++
>   lib/efi/efi_vars.c              |  44 +++++++++
>   lib/fdtdec.c                    |   3 +
>   27 files changed, 967 insertions(+), 28 deletions(-)
>   create mode 100644 cmd/addr_find.c
>   create mode 100644 cmd/efigetenv.c
>   create mode 100644 cmd/part_find.c
>   create mode 100644 drivers/net/efi_net.c
>   create mode 100644 drivers/tpm/tpm2_efi.c
>   create mode 100644 lib/efi/efi_dtb.S
>   create mode 100644 lib/efi/efi_vars.c
>

