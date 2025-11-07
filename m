Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA607CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 17:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30CCC83DCA;
	Fri,  7 Nov 2025 18:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EMGxcDpb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60EFD83DF2; Fri,  7 Nov 2025 18:24:44 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E0F883D8B
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 18:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bd30=5Q=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1762536280;
 bh=vAT1FhVc3YYA1Km7E0xF+FDEf98b9mrqjjkk08Qo39I=;
 b=EMGxcDpblm6Gem0gPaLTOCbuxmlpxH661JWMX28NjC+9ByvKh05qt3x6ZUgRAbVA5y5wk3r3+
 jkRjKVTgWJlwSRUk7iYDSEKKEar0DgpkI7BgN6tvk9wtKY3+P2dz3f9GoRcPPxhsKZOA91xphAk
 aUZJLEZJ0jXL550YeBRCMzPtTN6d0O+4FzQE0XD+Etf9mOLCdqvtwG/tY+0HcM5ypl/XTs7ddms
 ES0ailbh2IAbg4o0Mts30/UIdKrCfqI4Z1yFYrFbTgxtFUw661+41dTNt43X5EJeeQ48dyWHd4s
 00j9HJ4Hf5XfEFXxyI3Z3JmqE0iFHNUzC6PyoozuuKsg==
X-Forward-Email-ID: 690e2b4d07551ffa40a136b1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.4.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <20e741ac-188c-4a6f-bf24-4555f58303ef@kwiboo.se>
Date: Fri, 7 Nov 2025 18:24:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: mkimage: enhance comments for v1 header
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20251107-rkcommon-hdr-v1-1-6b456bb3dd93@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251107-rkcommon-hdr-v1-1-6b456bb3dd93@cherry.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Quentin,

On 11/7/2025 5:49 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Improve the image header documentation for v1 header:
> 
> - specify this applies to all MMC, not only SD cards,
> - specify the offset for SPI flashes,
> - specify the key used for RC4 encoding,
> - specify what "init" refers to, especially since some configs enable
>   TPL,
> - specify what "init_boot" refers to, especially since some configs
>   enable TPL,
> - specify the size of a block,
> - add documentation for init_size and init_boot_size,
> 
> Note that the offset on the storage medium isn't necessarily 32KiB (64
> blocks) for MMC or 0 for SPI flashes, it's just the first offset the
> BootROM checks. Barebox[1] lists a few options, though those are
> applicable to RK35xx which use the v2 header, so not guaranteed they can
> be shared. On RK3399, the binary can at least be stored at offset 0 and
> 32KiB on SPI flashes.
> 
> [1] https://git.pengutronix.de/cgit/barebox/tree/arch/arm/mach-rockchip/bbu.c#n19
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/rkcommon.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index d191ea72c63..6d1f88bcac1 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -76,13 +76,24 @@ struct header0_info_v2 {
>  /**
>   * struct header0_info - header block for boot ROM
>   *
> - * This is stored at SD card block 64 (where each block is 512 bytes, or at
> - * the start of SPI flash. It is encoded with RC4.
> + * This is stored at MMC block 64 (where each block is 512 bytes), or at
> + * the start of SPI flash. It is encoded with RC4 with the below rc4_key.
> + *
> + * In Rockchip terminology:
> + *
> + * "init" means TPL if there is one, SPL otherwise.

Maybe mention something about SRAM here?

"init" is what BootROM load into SRAM, typically TPL if there is one,
SPL otherwise.

> + *
> + * "init_boot" means the entire software the boot ROM has to load for booting
> + * U-Boot, typically the TPL if any, and the SPL.
> + * Basically, it is the content of "init" plus the SPL if relevant.

The "init_boot" naming is very strange, I would probably try to describe
it as the "boot" or next stage, maybe something like:

"boot" is the next stage that BootROM load into start of DRAM, if "init"
decide to return back to BROM using 0 as return code and init_boot_size
exceeds init_size. Typically SPL if there is one, U-Boot proper
otherwise.

For newer SoCs using the v2 header this basically just continues for up
to 4 images, BootROM loads next stage/image when prior stage return back
to BROM using 0 as return code.

Regards,
Jonas

>   *
>   * @magic:		Magic (must be RK_MAGIC)
>   * @disable_rc4:	0 to use rc4 for boot image,  1 to use plain binary
> - * @init_offset:	Offset in blocks of the SPL code from this header
> - *			block. E.g. 4 means 2KB after the start of this header.
> + * @init_offset:	Offset in 512-byte blocks of the "init" code from the
> + *			start of this header. For instance, 4 means 2KiB.
> + * @init_size:		Size (in blocks) of the "init" code.
> + * @init_boot_size:	Size (in blocks) of the "init_boot" code.
> + *
>   * Other fields are not used by U-Boot
>   */
>  struct header0_info {
> 
> ---
> base-commit: fdf36c2e9ad4f770ee951398a86bd55404d9b7ec
> change-id: 20251107-rkcommon-hdr-99fef99b4b64
> 
> Best regards,

