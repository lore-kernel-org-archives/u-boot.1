Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A29ACF9C6D
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 21:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728F088CD0;
	Sun, 22 Sep 2024 23:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727041317;
	bh=5U0gOCK3WqWHYzw0Znc3bCqoYJb+j+xAVZ7J7ynzgVo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wv8+Pq7Iy4DgykXCT6MEFb0EOGHtNlw4eTSnZrfK0wD3DYG7I9GVL1zq++tt5ar3V
	 VavJcDwcuDVDmvRDDfO4I+O5/tQt3vrtxQHaBBkJhVkP9qxjZOAI/OmCIAsEGbDhIG
	 juzfp2KxzgnwCANLm3aGCpzCfbOTuESka3wc0XDThKA2hBUlTgyKLBaJBF8iAur8L+
	 C4Ke8uAdQVxL7zAmGFyPM2Hhn1e4l4ZRPL5QIYqtgABG1qbnIJO3OllW85Qb9/3n83
	 U33UNIN5AsIlIThzDG89tkxRd4lmEK5bKccAEeCujlBTLPm/f0uy5Km+nUQCjncjRi
	 g/crEn7poTnnw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AC1CC88C86;
 Sun, 22 Sep 2024 23:41:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727041315;
 bh=5U0gOCK3WqWHYzw0Znc3bCqoYJb+j+xAVZ7J7ynzgVo=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=nkuomiQ29XTCljykUVnvJV1uprGtbIu34EuS/B2hrGhVDt5QMYkprwI36LlQEUKS3
 hbRvslTOhMXdmQKZqmEZL09NoDwF5byYQbpO+tfd8i1Qz6G3WL4gFPB1FxUWPKWKYf
 VIbNlQKGLvKlsh8uP6K0SZpV/dgCzikUMYhoOk5XNiafabWFym7AJl2FPmUmK9f+RE
 5Ep5TnR6aHPtLU+0N4DfOV25WuPdsytd5m+NkquQd/0Rp243SrasyPE2cuFsQcNCCs
 YKS3TeWo5M3I6VbxwMOEmKSSx+qfeP2zssDmEfRKA0HQWnS7g+WTylWDgRFJ2bRfni
 4E9cEkGjDRU5A==
Message-ID: <ef808720-da95-491b-92f3-5b459b69d926@denx.de>
Date: Sun, 22 Sep 2024 23:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] ARM: socfpga: add Enclustra AA1 extra env settings
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240917062157.3181-1-l.rubusch@gmail.com>
 <20240917062157.3181-5-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240917062157.3181-5-l.rubusch@gmail.com>
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

On 9/17/24 8:21 AM, Lothar Rubusch wrote:
> Add command files for boot scripts and initial boot environment.
> 
> Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>   include/configs/socfpga_mercury_aa1.h | 35 +++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/include/configs/socfpga_mercury_aa1.h b/include/configs/socfpga_mercury_aa1.h
> index a5b63336e8..4b047e11a7 100644
> --- a/include/configs/socfpga_mercury_aa1.h
> +++ b/include/configs/socfpga_mercury_aa1.h
> @@ -21,6 +21,41 @@
>    */
>   #define CFG_SYS_BAUDRATE_TABLE {4800, 9600, 19200, 38400, 57600, 115200}
>   
> +/* U-Boot environment */
> +#define CFG_EXTRA_ENV_SETTINGS						\
> +	"bitstream_size=0xD00000\0"					\
> +	"bootargs=earlycon console=ttyS0,115200 rw rootwait root=/dev/mmcblk0p3\0" \
> +	"bootargs_qspi=earlycon console=ttyS0,115200 rw root=/dev/ram0\0" \
> +	"bootm_size=0x0a000000\0"					\
> +	"env_size=0x80000\0"						\
> +	"fdt_addr_r=0x10000000\0"					\
> +	"fdtfile=system.dtb\0"						\
> +	"fdtload=load ${devtype} ${devnum}:${distro_bootpart} ${fdt_addr_r} ${bootdir}/${fdtfile}; load ${devtype} ${devnum}:${distro_bootpart} ${fdto_addr_r} ${bootdir}/${fdtofile}; fdt addr $fdt_addr_r; fdt resize 8192; fdt apply $fdto_addr_r\0" \
> +	"fdtload_qspi=sf probe; sf read ${fdt_addr_r} ${qspi_offset_addr_devicetree} ${fdt_size}; sf read ${fdto_addr_r} ${qspi_offset_addr_dtoverlay} ${fdto_size}; fdt addr ${fdt_addr_r}; fdt resize 8192; fdt apply ${fdto_addr_r}\0" \

Use && instead of ; to bail from the script right after failing command 
instead of running through the whole script after failing command.

> +	"fdto_addr_r=0x100c0000\0"					\
> +	"fdtofile=socfpga_enclustra_mercury_XXX_overlay.dtbo\0"		\
> +	"fdto_size=0x40000\0"						\
> +	"fdt_size=0x40000\0"						\
> +	"kernel_addr_r=0x11000000\0"					\
> +	"kernel_size=0x1000000\0"					\
> +	"qspiboot=source ${scriptaddr}\0"				\
> +	"qspiload=setenv bootargs ${bootargs_qspi}; sf probe; sf read ${scriptaddr} ${qspi_offset_addr_boot_script} ${scriptsize}\0" \
> +	"qspi_offset_addr_bitstream=0x300000\0"				\
> +	"qspi_offset_addr_boot_script=0x200000\0"			\
> +	"qspi_offset_addr_devicetree=0x280000\0"			\
> +	"qspi_offset_addr_dtoverlay=0x2c0000\0"				\
> +	"qspi_offset_addr_kernel=0x1000000\0"				\
> +	"qspi_offset_addr_rootfs=0x2000000\0"				\
> +	"qspi_offset_addr_spl=0x0\0"					\
> +	"qspi_offset_addr_uboot=0x100000\0"				\
> +	"qspi_offset_addr_uboot_env=0x180000\0"				\
> +	"rootfs_addr_r=0x12000000\0"					\
> +	"rootfs_size=0x2000000\0"					\
> +	"scriptaddr=0x10800000\0"					\
> +	"scriptsize=0x80000\0"						\
> +	"spl_size=0x100000\0"						\
> +	"uboot_size=0x80000\0"
Squash this into 3/7 already .
