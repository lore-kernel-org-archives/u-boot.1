Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647C4D1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78AB58901E;
	Mon, 14 Oct 2024 20:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728931329;
	bh=Or7FADtOd7zLtuVj9BN25PwDnEkRvyGi7yPd2lVlFQ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gb/F4Fh9YXLvJcUqnzWZvaWHGlPSmRS8Sd6DZYEMiNvjHA4gnMCGABdSdSMtnSvyT
	 I4ECGKEclDf7Ysl27G5R8v7uZfUJC9CKN42k84wg8019g4KXt3UKw31qBfoozU2XQ/
	 iCwuPO++NveNiQHjebzsTV8PGlsnTKZlY7+96HAmoFrpbfaJMZRTPEE0kVNN+LYK/K
	 fgmtrk1+I1u3gGVenRu239Uk8RDbucq7YwtD99nAs9KYFtaGBder7sukCekYA4exwM
	 hPNF8ZychQxRxmncc+8b7AilXY6gC+gM3/wwu8C1NNWyAZWk6okuO1ICSA0i5x2QNk
	 NR2n5k7ljkBdQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6E8D989003;
 Mon, 14 Oct 2024 20:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728931327;
 bh=Or7FADtOd7zLtuVj9BN25PwDnEkRvyGi7yPd2lVlFQ4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pM+CLjkEDVjqkvlv3iqZNAK2ErXvU+fW0NAvusS+1A66m0OyZMk88hlr2Fpr7Iulg
 POlwOyUXwgY2JZ06iwWGrr94uwoYBdcOzNrQITFmPvjcaLZvzNAyc2iI+6GLacpypv
 qqsf5QdIebUGSWA/R23rG8WghgQGZ1LMei48qkRk7wu6UIg94Iz4L1wQbpxOwbEVH8
 g0adqOYJ8bZeM4eyFTubepYMdWxpnNHW+B+gFZv+bY3/oFSXPz3TEAh0oxxQnIn5XF
 9w9+YDiWRmPiZyZcNVlrg6o/XwqsbujiqdkeGrdUrVjsZ9BfWLic4IR0rU9h3cXOzA
 /IGl2+8MMcmXg==
Message-ID: <1cae8c16-5a69-4209-82b4-0341d9ffdfff@denx.de>
Date: Mon, 14 Oct 2024 19:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] ARM: socfpga: add Mercury+ AA1 boot scripts
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com, sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-7-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241013143232.2090645-7-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/13/24 4:32 PM, Lothar Rubusch wrote:
> Add bootscripts to boot Enclustra SoMs from MicroSD card or QSPI flash.
> MicroSD card as bood device here covers the cases of sdmmc or emmc as
> such boot media.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>   board/enclustra/bootscripts/qspi-aa1.cmd | 12 ++++++++++++
>   board/enclustra/bootscripts/sd-aa1.cmd   |  9 +++++++++
>   2 files changed, 21 insertions(+)
>   create mode 100644 board/enclustra/bootscripts/qspi-aa1.cmd
>   create mode 100644 board/enclustra/bootscripts/sd-aa1.cmd
> 
> diff --git a/board/enclustra/bootscripts/qspi-aa1.cmd b/board/enclustra/bootscripts/qspi-aa1.cmd
> new file mode 100644
> index 0000000000..42d02cfce1
> --- /dev/null
> +++ b/board/enclustra/bootscripts/qspi-aa1.cmd
> @@ -0,0 +1,12 @@
> +# This is an example input file for boot.scr generation.
> +# Generate boot.scr
> +# ./tools/mkimage -A arm -O linux -T script -C none -a 0 -e 0 -d board/enclustra/bootscripts/qspi-aa1.cmd boot.scr
> +#
> +# NB: The needed variables need to be set in the environment.
> +bridge enable
> +sf probe
> +sf read $kernel_addr_r $qspi_offset_addr_kernel $kernel_size
> +sf read $fdt_addr_r $qspi_offset_addr_devicetree $fdt_size
> +sf read $rootfs_addr_r $qspi_offset_addr_rootfs $rootfs_size
> +run fdtload_qspi
> +bootm $kernel_addr_r $rootfs_addr_r $fdt_addr_r
> diff --git a/board/enclustra/bootscripts/sd-aa1.cmd b/board/enclustra/bootscripts/sd-aa1.cmd
> new file mode 100644
> index 0000000000..65bee32767
> --- /dev/null
> +++ b/board/enclustra/bootscripts/sd-aa1.cmd
> @@ -0,0 +1,9 @@
> +# This is an example input file for boot.scr generation.
> +# Generate boot.scr
> +# ./tools/mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "U-boot mmc start script" -d board/enclustra/bootscripts/sd-aa1.cmd boot.scr
> +#
> +# NB: The needed variables need to be set in the environment.
> +bridge enable
> +fatload mmc $devnum:$distro_bootpart $kernel_addr_r zImage
> +fatload mmc $devnum:$distro_bootpart $fdt_addr_r $fdtfile
> +bootz $kernel_addr_r - $fdt_addr_r

Use plain 'load' command with FS_GENERIC
