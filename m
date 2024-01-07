Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C252C47074
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 17:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39CD8781C;
	Sun,  7 Jan 2024 18:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BLGl7Gv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D8F87831; Sun,  7 Jan 2024 18:35:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE11D877FC
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 18:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=248a=IS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: Subject: From: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1704648918;
 bh=0Hkcqu1s3GcCWuPHrZ5YzjIYzlyYugYEraZNrb0BsnE=;
 b=BLGl7Gv3zNYoZbe4t8rjaIp0M73qYAQIGbW7EWXGVvJ4nTOAPVtFLI58ZH77Dug/rtgA9hzYB
 LgJwQcOMRSH254W9K5zBpuzTQZsdyNryerA4rHhTQDr+jrZ9CazY/YIP1kuaTE4OpZikN1lUaic
 YSF633EgYH1yZoHEmlx+JsZn0vjDvi5LT5f4yKBhgdWu9lP33MIxF+qa2XDSq1HHIC4EcAvyLRF
 HdkdHQaB5wqaAMJ8qBGiHecDQ93+CQdcHVtUx3nPiNYMnSCYd7uLHgUCqeiXjng0ozMDTfI5Y0J
 YPuc4OP2R1ZYPXKjMiIYbfcM/BD8GeAu1/li054VYqWQ==
Message-ID: <c52fb0c8-411f-4f97-8998-913e4da79d2b@kwiboo.se>
Date: Sun, 7 Jan 2024 18:35:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2] rockchip: rk35xx: expand space for decompressed kernel
To: "Hugh Cole-Baker" <sigmaris@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20231226164330.63725-1-sigmaris@gmail.com>
Content-Language: en-US
In-Reply-To: <20231226164330.63725-1-sigmaris@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 659ae0d56bac4da560885a30
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

Hi Hugh,

On 2023-12-26 17:43, Hugh Cole-Baker wrote:
> An uncompressed 6.7.0-rc1 Linux kernel Image built with the arm64
> defconfig is about 40MB. This does not fit in to the space between
> kernel_comp_addr_r and fdt_addr_r, so when uncompressing an Image.gz
> to this size, the FDT will be overwritten. Rearrange addresses to have
> 128MiB for the kernel and its decompression buffer, then devicetree,
> overlay and ramdisk at the end.
> 
> Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
> ---
> Changes from v1:
> Reorder things to have to have 128MiB for kernel and decompression space,
> then devicetree, overlays and ramdisk.
> Update kernel_comp_size to 128MiB.
> 
>  include/configs/rk3568_common.h | 12 ++++++------
>  include/configs/rk3588_common.h | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
> index 1b7d3437b1..48f93083de 100644
> --- a/include/configs/rk3568_common.h
> +++ b/include/configs/rk3568_common.h
> @@ -20,12 +20,12 @@
>  	"script_offset_f=0xffe000\0"	\
>  	"script_size_f=0x2000\0"	\
>  	"pxefile_addr_r=0x00e00000\0"	\
> -	"fdt_addr_r=0x0a100000\0"	\
> -	"fdtoverlay_addr_r=0x02000000\0"	\
> -	"kernel_addr_r=0x02080000\0"	\
> -	"ramdisk_addr_r=0x0a200000\0"	\
> -	"kernel_comp_addr_r=0x08000000\0"	\
> -	"kernel_comp_size=0x2000000\0"
> +	"kernel_addr_r=0x02000000\0"	\
> +	"kernel_comp_addr_r=0x0a000000\0"	\
> +	"fdt_addr_r=0x12000000\0"	\
> +	"fdtoverlay_addr_r=0x12100000\0"	\
> +	"ramdisk_addr_r=0x12180000\0"	\
> +	"kernel_comp_size=0x8000000\0"

This (and the prior) memory layout extend over the possible memory
region that OPTEE may use, 32 MiB at 132 MiB offset.

The following regions is typically reserved for TF-A and OPTEE:

0x00000000 - 0x00200000 - reserved for TF-A, pstore, shmem, etc (0-2 MiB)
0x08400000 - 0x0a400000 - reserved for OPTEE (132-164 MiB)

Following offsets are used by U-Boot on rockchip rk35xx:

@0       - U-Boot SPL
@40000   - TF-A (@256 KiB)
@a00000  - U-Boot proper (@10 MiB)
@c00000  - scriptaddr (@12 MiB)
@c00800  - loadaddr (@12 MiB + 2 KiB)
@e00000  - pxefile_addr_r (@14 MiB)
@8400000 - optional OPTEE (@132 MiB)

May I suggest a memory layout similar to the following be used:

@1800000  - fdtoverlay_addr_r (@24 MiB)
@1c00000  - fdt_addr_r (@28 MiB)
@2000000  - kernel_addr_r (@32 MiB)
@a800000  - kernel_comp_addr_r (@168 MiB) // could also be a400000 (@164 MiB)
@12c00000 - ramdisk_addr_r (@300 MiB) // kernel_comp_addr_r + kernel_comp_size
and kernel_comp_size = 0x8000000 (128 MiB)

With that it should allow for a 100-136 MiB kernel starting at @32 MiB,
depending on if memory is reserved for OPTEE or not. It also leave 4 MiB
for FDT and FDT overlay in memory just before the kernel. And finally do
not overlap kernel_comp_addr_r with possible OPTEE memory.

If we need more space then 2 MiB for U-Boot proper we should also
revise the offsets used for loadaddr, scriptaddr and pxefile_addr_r.

Regards,
Jonas

>  
>  #define CFG_EXTRA_ENV_SETTINGS		\
>  	ENV_MEM_LAYOUT_SETTINGS			\
> diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
> index 46389d087d..70430612ef 100644
> --- a/include/configs/rk3588_common.h
> +++ b/include/configs/rk3588_common.h
> @@ -19,12 +19,12 @@
>  	"script_offset_f=0xffe000\0"	\
>  	"script_size_f=0x2000\0"	\
>  	"pxefile_addr_r=0x00e00000\0"	\
> -	"fdt_addr_r=0x0a100000\0"	\
> -	"fdtoverlay_addr_r=0x02000000\0"	\
> -	"kernel_addr_r=0x02080000\0"	\
> -	"ramdisk_addr_r=0x0a200000\0"	\
> -	"kernel_comp_addr_r=0x08000000\0"	\
> -	"kernel_comp_size=0x2000000\0"
> +	"kernel_addr_r=0x02000000\0"	\
> +	"kernel_comp_addr_r=0x0a000000\0"	\
> +	"fdt_addr_r=0x12000000\0"	\
> +	"fdtoverlay_addr_r=0x12100000\0"	\
> +	"ramdisk_addr_r=0x12180000\0"	\
> +	"kernel_comp_size=0x8000000\0"
>  
>  #define CFG_EXTRA_ENV_SETTINGS \
>  	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \


