Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFAECFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 13:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A540D888EB;
	Mon,  7 Oct 2024 15:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TkC/3KhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D549B889E1; Mon,  7 Oct 2024 15:03:09 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92679880F4
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 15:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 497D34mH036204;
 Mon, 7 Oct 2024 08:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728306184;
 bh=kYHXqFYw3bXCmPd0LpjpUx/vBS46cpKHUWxXzjAsE9w=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TkC/3KhViIpl4+lKZmUF6RqT1R5aoAJkumGfCb1k/hBHNuiE7JQsAQR7/G2p2aOpN
 VVTNqOTq9NNvdMzBj76tEpztxcc0kL0zhkA7IQaTLZthTq2aBgkcLfzpDddUJjPMIa
 EyKXHcZ20WRFd6VRUxxAkD0uBjZ6tm6xS8IeRyFI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 497D34YJ070723
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Oct 2024 08:03:04 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 08:03:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 08:03:03 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 497D30XX078214;
 Mon, 7 Oct 2024 08:03:00 -0500
Message-ID: <dadefe22-2662-ddd1-cace-15d70f632232@ti.com>
Date: Mon, 7 Oct 2024 18:32:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] rpi: Fix build error when CONFIG_VIDEO is disabled
 for Raspberry Pi
Content-Language: en-US
To: Martin Stolpe <martinstolpe@gmail.com>
CC: "Ivan T. Ivanov" <iivanov@suse.de>, <u-boot@lists.denx.de>, Francois
 Berder <fberder@outlook.fr>, Matthias Brugger <mbrugger@suse.com>, Nikhil M
 Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>, Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>
References: <20240920063204.1049202-1-martin.stolpe@gmail.com>
 <20240920063204.1049202-2-martin.stolpe@gmail.com>
 <20240920081625.z3fwz6n7o2zxd4gf@localhost.localdomain>
 <CAPHZmLbcfMVOydp9jCY0mWKdKPePBp+3rfttMyKbHT-CbB7kjA@mail.gmail.com>
 <e27aef89-8038-9099-58ed-b927cce54579@ti.com>
 <CAPHZmLZopucK5uMwENuF83pRMLYR2A5sC7fes4-1JXE4jX7=rw@mail.gmail.com>
 <08a38499-c36d-4bf7-adcc-d3f547f3afc8@ti.com>
 <CAPHZmLaVVSckGeqU09WMy0s4rGA-w6pQ9ObPuh3SBf8uTBaD9Q@mail.gmail.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAPHZmLaVVSckGeqU09WMy0s4rGA-w6pQ9ObPuh3SBf8uTBaD9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Martin,

On 07/10/24 18:24, Martin Stolpe wrote:
> Hi Devarsh,
> 
> Am Do., 26. Sept. 2024 um 18:45 Uhr schrieb Devarsh Thakkar <devarsht@ti.com
>> :
> 
>>
>> Thanks for taking a look, I have posted them to the list [1], it would
>> be great if you could provide a Reviewed-by or Tested-by too.
>>
> 
> I've tried to compile the project for am64x_evm_a53 with the patches
> applied and I've added the following line to
> am64x_evm_a53_defconfig: CONFIG_OF_BOARD_SETUP=y
> When I then try to compile U-Boot using the following command:
> make am64x_evm_a53_defconfig; make
> 
> I get the following error message:
> aarch64-linux-gnu-ld.bfd: boot/image-fdt.o: in function
> `image_setup_libfdt':
> /home/mstolpe/repositories/build_base_station/build/workspace/sources/u-boot-copy/boot/image-fdt.c:633:(.text.image_setup_libfdt+0x150):
> undefined reference to `ft_board_setup'
> aarch64-linux-gnu-ld.bfd: cmd/fdt.o: in function `do_fdt':
> /home/mstolpe/repositories/build_base_station/build/workspace/sources/u-boot-copy/cmd/fdt.c:687:(.text.do_fdt+0xf98):
> undefined reference to `ft_board_setup'
> Segmentation fault (core dumped)
> make: *** [Makefile:1801: u-boot] Error 139
> make: *** Deleting file 'u-boot'
> 
> I guess this shouldn't happen?

I think this is expected as you are trying to enable CONFIG_OF_BOARD_SETUP but
AM64 platform does not implement ft_board_setup.

Platforms need to implement ft_board_setup for platform specific knobs (for
e.g. simplefb for splash etc) if using CONFIG_OF_BOARD_SETUP as per below
snippet in boot/image-fdt.c :

        if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {

                const char *skip_board_fixup;



                skip_board_fixup = env_get("skip_board_fixup");

                if (skip_board_fixup && ((int)simple_strtol(skip_board_fixup,
NULL, 10) == 1)) {
                        printf("skip board fdt fixup\n");

                } else {

                        fdt_ret = ft_board_setup(blob, gd->bd);

                        if (fdt_ret) {

                                printf("ERROR: board-specific fdt fixup
failed: %s\n",
                                       fdt_strerror(fdt_ret));

                                goto err;

                        }

                }

        }

Regards
Devarsh
> 
> BR
> Martin
> 
