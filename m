Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1D8CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F2F86C33;
	Tue, 19 Sep 2023 20:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695148035;
	bh=n3BUQ6pLng9JMv8C7hSfThsiAGb5M5Rp38KAhCitz5M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EG+0HCmlJFYKnNcEWfuqtF4Bz3jaKJ+7QJ1KvoiiR2QJx5y1AF8UFgTCt37/NWAvp
	 mm6rgtyPnphe/LRTJ4G0s0582KkmS9oC8DwTAUsojVETqta/uSIO0PIrJT3TygPsok
	 YfPWQrhmOHSmvRDOElSWsOIdR+KFiIERKOZZXR7VL6PqyXzN7vd5xUPUUZoF75P3fW
	 1zelN9G1KJrnYuKUkjh6681uDdL5TvHgwE21luAIZ/YEsd1LD3JrDX+HgdxakBxkd1
	 olP8uit+DbzrAzUQmHs8amJxyn3c0dSaKxRMFr7ReYO8QYiwClrM7Wwv6V628p5kAn
	 zw1jEt21PXP2Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AE7F386C13;
 Tue, 19 Sep 2023 20:27:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695148034;
 bh=n3BUQ6pLng9JMv8C7hSfThsiAGb5M5Rp38KAhCitz5M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uxfaRBg0nhxdAtPjQkeMIVHjV/K9eQoPqI7a2yj6pTAeHIRCvgPBKnmfNfDPx6PkL
 k7l/bl36fT4nJqFRo4QcS4V2X7/EfQoLirjg8ru+daB1mip9rx75v+MalBg2xC4Jb6
 b1y1cjFTqB2JWd9l3gOMICxfs85bBJjeXQyMac558vTd7x3ZF0pNf/eUf3Y7DG58Aj
 1KGzJORaxIxyyJZ+TzNPsUUYCi36R0eHXxDj11rRhU8WLWNlUG2/G0E3XPCqtP9r0q
 dcGVvMD3B4JmUjL+38wE0+nmWajRjRoOBpmCfnXmW3i8Fl4sXm0yahmJ2FD9WQRmOP
 znVumF6BGtfJg==
Message-ID: <ccce016d-3756-fae1-e074-70d94a9f8f6e@denx.de>
Date: Tue, 19 Sep 2023 20:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mx8m: csf.sh: pad csf blob for u-boot.itb to CSF_SIZE
 minus IVT header
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 uboot-imx@nxp.com
References: <20230919100017.43523-1-rasmus.villemoes@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230919100017.43523-1-rasmus.villemoes@prevas.dk>
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

On 9/19/23 12:00, Rasmus Villemoes wrote:
> When built with CONFIG_IMX_HAB, the full FIT image, including stuff
> tacked on beyond the end of the fdt structure, is expected to be (fdt
> size rounded up to 0x1000 boundary)+CONFIG_CSF_SIZE.
> 
> Now, when the FIT image is loaded from a storage device, it doesn't
> really matter that the flash.bin that gets written to target isn't
> quite that big - we will just load some garbage bytes that are never
> read or used for anything. But when flash.bin is uploaded via uuu,
> it's important that we actually serve at least as many bytes as the
> target expects, or we will hang in rom_api_download_image().
> 
> Extend the logic in the csf.sh script so that the csf blob is padded
> to CONFIG_CSF_SIZE minus the size of the IVT header.

On which SoC do you trigger this stuff ?
(or rather, which bootrom version, v1 or v2? they each use SDP or SDPS 
respectively)

> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   doc/imx/habv4/csf_examples/mx8m/csf.sh | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/doc/imx/habv4/csf_examples/mx8m/csf.sh b/doc/imx/habv4/csf_examples/mx8m/csf.sh
> index 65c143073c..80edc94aeb 100644
> --- a/doc/imx/habv4/csf_examples/mx8m/csf.sh
> +++ b/doc/imx/habv4/csf_examples/mx8m/csf.sh
> @@ -75,5 +75,13 @@ dd if=ivt.bin of=flash.bin bs=1 seek=${ivt_block_offset} conv=notrunc
>   
>   # Generate CSF blob
>   cst -i csf_fit.tmp -o csf_fit.bin
> +
> +# When loading flash.bin via USB, we must ensure that the file being
> +# served is as large as the target expects (see
> +# board_spl_fit_size_align()), otherwise the target will hang in
> +# rom_api_download_image() waiting for the remaining bytes.
> +CSF_SIZE=$(sed -n "/CONFIG_CSF_SIZE=/ s@.*=@@p" .config)
> +truncate -s $((CSF_SIZE - 0x20)) csf_fit.bin

Can you use dd(1) instead ? I think dd(1) is more portable than 
truncate(1) , at least I cannot find truncate(1) in opengroup specs.
