Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DA6D591A5
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 16:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93FD6894C0;
	Tue, 19 Nov 2024 17:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nCo9rjKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB030895AD; Tue, 19 Nov 2024 17:47:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A24894C0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 17:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732034847; x=1732639647; i=xypron.glpk@gmx.de;
 bh=6rhmQBsnmHbdZxB2wZfs6nM8kqvm2arbIs35EjLiyPo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nCo9rjKRLuwy8HSYkobEPLm1zvT5xSB4O/seRIIAkhbLAkKh7/5iLID/zHKoWFBt
 N3OmwhU2vU/n7ko7H9lW0MGXRb1aq0bPUxIA62r1Qp8t1np6JKSbDLPAHONVEoPzI
 f8S1kIEoJTJIicrIe2UCXGMYEKTZq7HMs3rHrf/IUMEVnRKVr2JooMd//26vehqWo
 BMaEywL/oAZN7dq05VOOI1KzX1iu3DkluuV6AoGJZpfruNYiAq9wqyl/FqDt0a3/7
 NqyyCvx9hyZLInCAb+1w7Y5FtOrZcnZFx2pZQhJIdtNiHCefLTSyYA7hlQtW56Zbm
 5Qfxg/wavvuuU0stnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLi8m-1tUyGl2k2S-00UiMM; Tue, 19
 Nov 2024 17:47:27 +0100
Message-ID: <07dd3c79-2f06-4d76-bdb5-8c1c6b39ca4e@gmx.de>
Date: Tue, 19 Nov 2024 17:47:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/39] pxe: Support read_all() for extlinux and PXE
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria
 <ion@agorria.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241119131844.4078144-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EHbYs8N+byh5JeCK0cST4TBfLHCoehNvvgoYQYu0ybKTf7zYN/e
 3ocyNjHFcLmaabO6cZhcYDRbFErQroQNwiOc9aLiTt/uNAT5Z53cq/XCpUDbi+fzduu1aaL
 ZmQt9m+0uU4zmgvGNBpHBC0PIu7af/n8yC+XvuovDkDM+8wOoJLf4AkQvd5Atzs0TcbLG/5
 VK4N5iJgg7kS1NUwxGQIw==
UI-OutboundReport: notjunk:1;M01:P0:dH2WPbuHYu0=;o3+3EO+dld8ncVLI241WtB9bzX0
 Q5ptFtNCgJfKt0pk7EfXUX6ScfgnJxp7y2u6c1hAwwGE7iyvlT6MxXBjcRw3/pJKT4DzunFLq
 dsQIkLy7E7Uz3lHU92we8SiKgQqV0st4dvrzx2VSrpssbgghF6M1g3DlDYZrawi6wsKNPBFJc
 pTz8hrGML89P1kNDZXKTiCr93wsG6MdKtt2qd1hrHbFGIfvrGgY7KdPs7T3ZeMqS0egE/h89a
 C8axemcS6J7EbKfMdqAEfYHDR2Tq90URSwM6GrW6MBdaqjbOHxF7Xm8te7LoJubOjYhdiow5z
 tNpD2AhVzt00STKIkl+Lx4xBMcIlilkE5MZRSU475p+Pz0qV6U1/BTbt1INyDDRzf8POznvsy
 3DRr0s5ISzP7jDct6yaACdTEmILcjXhxPhzR0sVDVxM0Dnq4PJHuqBMDx1E82RjHPTEx/y91w
 p4owZgnQGXLJv6RtqHYty/TyRWR1L1FDCi/e6Bnj4aYOtMfUChVrZlrPsZTivOrNGSTZq3XXg
 I8lSbmeCLcXhndAcLplQAQIbZDpaJUkO29dzMPhpby/MC7cpqMzoaPWCgdeT3TVhJMKrFKjq7
 QDTe3iec/Y2up4Bj0nOsUU+hDCVJVbK41O2n3N2oYdy3sf43h9ZHalKfVAH6l5AHdxqkLF4Ua
 W08vtfnqJCpHNx7pAb798mDax2sife4claxP0gNctX/lYlRBGtCUdd3nbYcY4z43c80ZDUawN
 kK0sD07o784VlCILEYy/XQBIxMtTT0zqFEGE/UjNepg0YLfblvRqCOGsLnqhrqbHAa1o2D4kS
 /Vf6E0OAKbiMVRiGhn/mXX/3ewmLB0cjZxW5GUAO2PKaVMfwrFN/6LX5ujU8gBSfFtHRAP56r
 b2SiTnM1bIpR0Dk46TZQqoYMpKXh3jlaUolFGt1S5kty2gD/M2uJUmXMW
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

On 19.11.24 14:18, Simon Glass wrote:
> This series implements read_all() so that it is possible to read all the
> files relating to a bootflow, make adjustments and then boot.
>
> Unfortunately quite a few things stand in the way, so this series
> finishes off several pending items: zboot without CONFIG_CMDLINE,
> required support in pxe_utils and the differing code in the extlinux and
> PXE bootmeths. There is very little new code, but quite a lot of
> refactoring.
>
> The bootm, booti and bootz commands have all been refactored previously,
> so that they can operate without needing CONFIG_CMDLINE to be enabled.
> At the, time, zboot was left alone, since it is x86-specific and a bit
> more trouble.
>
> This series adds a programatic API for zboot and uses the forthcoming
> bootstd 'image list' to collect information from an extlinux file. It is
> therefore possible to parse the file, load the resulting images and then
> examine/adjust the resulting bootflow, before booting.
>
> The addition of options to extlinux resulted in the PXE and extlinux
> bootmeth having slightly different features. This is tidied up in this
> series, with common functions for both. This allows the same features
> (loading images as a separate step) to be provided for PXE.

The biggest problem I see currently with PXE in U-Boot is:

eth_bootdev_hunt() invokes dhcp_run() which may lead to actually
downloading and booting a file (assuming autostart=3Dyes).

We should only check that a network device exists and can be probed.
Maybe check that the medium is attached when probing. But actually
reading a file should be left to one of the different boot methods that
can make use of the boot device (PXE, HTTP-Boot, ...).

But I cannot see a fix for net/eth_bootdev.c in this series.

Best regards

Heinrich

>
>
> Simon Glass (39):
>    x86: Make do_zboot_states() static
>    x86: Rename zboot_run() to zboot_run_args()
>    x86: Drop duplicate definition of zimage_dump()
>    x86: Move x86 zboot state into struct bootm_info
>    x86: Rename state to bmi
>    x86: Move the bootm state for zimage into cmd/
>    bootstd: Correct display of kernel version
>    x86: Drop the unnecessary base_ptr argument to zboot_dump()
>    boot: Split pxe label_boot() into two parts
>    boot: Split pxe label_run_boot() into two parts
>    boot: Pass just the FDT argument to label_process_fdt()
>    bootm: Allow building bootm.c without CONFIG_SYS_BOOTM_LEN
>    boot: pxe: Use bootm_...() functions where possible
>    boot: pxe: Refactor label_run_boot() to avoid cmdline
>    net: Keep the bootstage functions together
>    net: Tidy up the comments to parse_args()
>    net: Simplify parse_args()
>    net: Return the load address from parse_args()
>    net: Return the address and size from parse_addr_size()
>    net: Return the size from parse_args()
>    net: Refactor part of netboot_common() into a function
>    net: Drop #ifdef in parse_args()
>    net: Provide a function to run network operations
>    boot: Avoid using the cmdline in bootmeth_pxe and pxe cmd
>    pxe: Drop the cmdline parameter
>    pxe: Record the bootflow in the PXE context
>    pxe: Allow skipping the boot
>    test: Update bootm test to restore silent_console
>    bootmeth_extlinux: Move extlinux_info into plat
>    bootmeth_extlinux: Move pxe_context into plat
>    bootmeth: Refactor to put options in a common file
>    bootmeth_pxe: Implement the fallback option
>    bootmeth_pxe: Drop the driver-private data
>    bootmeth_extlinux: Move boot code into common file
>    bootstd: Update extlinux and pxe to allow boot interruption
>    pxe: Collect the FDT in the bootflow
>    pxe: Deal with a missing FDT in the bootflow
>    pxe_utils: Refactor to separate reading from booting
>    bootmeth_extlinux: Refactor extlinux to split boot
>
>   arch/x86/include/asm/zimage.h |  57 +---
>   arch/x86/lib/zimage.c         | 102 ++++---
>   boot/Makefile                 |   6 +-
>   boot/bootm.c                  |   8 +-
>   boot/bootmeth_cros.c          |   6 +-
>   boot/bootmeth_extlinux.c      |  97 +------
>   boot/bootmeth_pxe.c           |  48 ++--
>   boot/ext_pxe_common.c         | 134 +++++++++
>   boot/pxe_utils.c              | 507 +++++++++++++++++++++-------------
>   cmd/bootflow.c                |   8 +-
>   cmd/net.c                     |  92 +++---
>   cmd/pxe.c                     |  30 +-
>   cmd/sysboot.c                 |   4 +-
>   cmd/x86/zboot.c               |  33 ++-
>   include/bootm.h               |  63 ++++-
>   include/bootmeth.h            |   8 +-
>   include/extlinux.h            |  52 +++-
>   include/net-common.h          |  30 ++
>   include/pxe_utils.h           |  56 +++-
>   net/net.c                     |  44 +++
>   test/boot/bootflow.c          |  71 +++++
>   test/boot/bootm.c             |   7 +
>   22 files changed, 960 insertions(+), 503 deletions(-)
>   create mode 100644 boot/ext_pxe_common.c
>

