Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F07E6C5EA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 02:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9917E88FED;
	Tue,  3 Dec 2024 03:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 695EF89471; Tue,  3 Dec 2024 03:40:23 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B0B88FA8
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 03:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip2t1733193587t5398vp
X-QQ-Originating-IP: KCr6Hrr8/nc/ZxDQi0tMBikTgHPkvRCIjxwxznrZaoQ=
Received: from [IPV6:240f:10b:7440:1:f61a:d8:e ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 03 Dec 2024 10:39:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12778069380748835113
Message-ID: <8330654E611213C4+6a97c5b4-7b20-4467-a627-4f16a9899ad4@radxa.com>
Date: Tue, 3 Dec 2024 11:39:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3399: expand space for decompressed kernel
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, chris.obbard@collabora.com,
 pbrobinson@gmail.com, jonas@kwiboo.se, sjg@chromium.org
References: <20241202234018.92120-1-naoki@radxa.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241202234018.92120-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MmpliBmRb3iCOP0zsf8BcvrM90l+vQOaSxV/Cw6O3LaEezxwvFNxY8HU
 v7ZdVZq8PkEpT7LiF79/pp5rxoHcE+CISfC0Tc8/gKb2M40iEgxfcw3xsg4aBDRBxiGANvK
 0K+GFbPSOREpuQ9XWz8V2WBM3C8mvDRN4XqOrwSO51JZNfR6amjzPHY0iVX7f5uTX4pKKG8
 /r2lSjQbFs8uJ3Af6PdWVrWSW7JKYGfLML8uEACRc6Ko2xHQWKoNBIu6rkQwY783mkkV7iZ
 SBitN0ZqqGNG5XgmJ/Elq48eTxWTqwnwxQti1Pp9RkGmrhR5hUDuWdysom9tvloTuF03Rgw
 N6Tle1zGxsEmYa+XrIeTM6AUxU9pillnbfpdqOfFF5dUl3gmoo4EPNa+mh3rEtCbzMBHdVD
 mxVq65OFPRN/4DA3JlhBy+BNDZkuBGwDPageySTEVxPpJnRo5BZ/lcVFG11iULZyOiLNen+
 vxNhKnVBnb7bOGmj41V/vrhmnvtbkgzvnJTim1PITRbbSEQSXc7oNIEQ9rIjiMoh75ZNi5f
 QjO6D3QukFm0Qi3hdSg4Q3UdKiHpmA61bA99Y2osw/4HA04H1rsj+qzltIVQk/QG3tPHAi+
 dKTZuWZ4nfjm10HScqwMvSLT+Vp29KE2C0MwXWLQaUbaoHYLbPaHfu89MJS9D8uSmA272EY
 tmc1Hs7EgLANhZhDk1Ox1dRCxBUNCJ14m8Fin9goGL34lGariBhmx+cYJsH4Eh1xBRRxdkB
 15mp+l71UPO5YtShhDd56i2F5TUbl/IhgBuXsHc005FaqMNue4KwfWIwE1az9F3jV7BOIdf
 IV6KeILB2EGjnMg93GjwSjLj3UGR56Zrw3rpfcKVGtqamhu4MLmRIHu6SZC8lSRqQZAiFy8
 Fk0NDcu+wP6kx5RV8EhVL2yNgWnDhQvGgM2LVHLECoenBGP8h3bLgzo/Va4oz9OPUjqHci4
 rOvyFDE2nTXFEvw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
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

Hi,

I'm thinking to do same (or similar) fix for RK3328 too.

that configuration should work with 512MB RAM device, right?

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 12/3/24 08:40, FUKAUMI Naoki wrote:
> fix following error by using same ENV_MEM_LAYOUT_SETTINGS with rk35xx:
> 
> U-Boot 2025.01-rc3-00001-g1527c7dcdb01 (Dec 02 2024 - 22:57:18 +0000)
>    :
> Retrieving file: /boot/extlinux/../nixos/dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-Image
> Retrieving file: /boot/extlinux/../nixos/6fq8fmmab31yxdwcs7zw44p78fq9fy1s-initrd-linux-6.12.1-initrd
> append: init=/nix/store/yjbxgzf1vkwbw6ab738bf4kxazhyypa1-nixos-system-rock-5b-25.05.20241201.ac35b10/init console=ttyS2,1500000n8 console=ttyAMA0,115200n8 console=tty0 loglevel=7
> Retrieving file: /boot/extlinux/../nixos/dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-dtbs/rockchip/rk3399-rock-4se.dtb
> Moving Image from 0x2080000 to 0x2200000, end=0x60d0000
> ERROR: RD image overlaps OS image (OS=2200000..60d0000)
> Boot failed (err=-14)
> 
> $ ls -lh boot/nixos/
> total 84M
> -r--r--r--  1 root root  24M Jan  1  1970 6fq8fmmab31yxdwcs7zw44p78fq9fy1s-initrd-linux-6.12.1-initrd
> -r--r--r--  1 root root  62M Jan  1  1970 dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-Image
> dr-xr-xr-x 36 root root 4.0K Jan  1  1970 dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-dtbs
> 
> similar problem was fixed for rk35xx by:
> 
> commit 69b73877f02c ("rockchip: rk35xx: expand space for decompressed kernel")
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>   include/configs/rk3399_common.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
> index c5bcd7dc5e8a..76f40e7cd5f8 100644
> --- a/include/configs/rk3399_common.h
> +++ b/include/configs/rk3399_common.h
> @@ -20,16 +20,16 @@
>   #endif
>   
>   #define ENV_MEM_LAYOUT_SETTINGS		\
> -	"scriptaddr=0x00500000\0"	\
> +	"scriptaddr=0x00c00000\0"	\
>   	"script_offset_f=0xffe000\0"	\
>   	"script_size_f=0x2000\0"	\
> -	"pxefile_addr_r=0x00600000\0"	\
> -	"fdt_addr_r=0x01e00000\0"	\
> -	"fdtoverlay_addr_r=0x01f00000\0"	\
> -	"kernel_addr_r=0x02080000\0"	\
> -	"ramdisk_addr_r=0x06000000\0"	\
> -	"kernel_comp_addr_r=0x08000000\0"	\
> -	"kernel_comp_size=0x2000000\0"
> +	"pxefile_addr_r=0x00e00000\0"	\
> +	"kernel_addr_r=0x02000000\0"	\
> +	"kernel_comp_addr_r=0x0a000000\0"	\
> +	"fdt_addr_r=0x12000000\0"	\
> +	"fdtoverlay_addr_r=0x12100000\0"	\
> +	"ramdisk_addr_r=0x12180000\0"	\
> +	"kernel_comp_size=0x8000000\0"
>   
>   #define CFG_EXTRA_ENV_SETTINGS		\
>   	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\


