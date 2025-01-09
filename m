Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E04E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 07:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F34B801FD;
	Thu,  9 Jan 2025 08:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="hiGgg+rt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB8480317; Thu,  9 Jan 2025 08:52:33 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529FB801F5
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 08:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 45BC4148455B; Thu,  9 Jan 2025 08:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1736409150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=biHamKmw6bX9fbjsppNMiproYZSYy313nx357z3whpA=;
 b=hiGgg+rt4RaIfGn2LYYCHKx8AF5xv859TP/O5J8Xv/xqaZbK1i7PUGG1XDZwZDyFTU1ta1
 iAwEApJ140nzvvY231faDuc5wMZkX9QMLQ+VME7gJy7q2h6ttTuhZxKicrGvCbRenVjsAw
 RtnJv13Eg8cip3KTEk0Dt8cfQVsGX8v8Vcv4S9YFVQgQiKD+61TSNYiH+reuiFkApEqYXv
 bRIfjTS06Lppb/zJDQLA+EWM3uVOW/BPS22uCqSUidaS6Xo45lBhfbjY9vsCXOtPlVvS+P
 EFVvfNr69aQ7x7pHbpZV1yS/CIYDRes5cic8WkiQRGeeX+A/tSpUmIzv+Jld4Q==
Date: Thu, 9 Jan 2025 08:52:25 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
Subject: Re: [U-Boot][PATCH 1/2] fpga: fix alignment on fpga cmd usage info
Message-ID: <20250109-auction-blob-00a19a40dbb8@thorsis.com>
Mail-Followup-To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
References: <20250108140357.969380-1-ibai.erkiaga-elorza@amd.com>
 <20250108140357.969380-2-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108140357.969380-2-ibai.erkiaga-elorza@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

Am Wed, Jan 08, 2025 at 02:03:50PM +0000 schrieb Ibai Erkiaga:
> The current implementation generates some alignment issues as well as
> some overlapping when all the fpga command options are enabled. The fix
> is intended to improve readability of the usage info.

Alignment could indeed improved.  One question: the \t is dependent on
the terminal, right?  Would it be better to use spaces instead?  That
would also make the code more readable.

Greets
Alex

> 
> Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
> 
> ---
> 
> The current output looks like this:
>   loadbp        [dev] [address] [size]  Load device from bitstream buffer with partial bitstream(Xilinx only)
> Load device from filesystem (FAT by default) (Xilinx only)
>   loadfs [dev] [address] [image size] [blocksize] <interface>
>         [<dev[:part]>] <filename>
>   loadmk [dev] [address]        Load device generated with mkimage
>         For loadmk operating on FIT format uImage address must include
>         subimage unit name in the form of addr:<subimg_uname>Load encrypted bitstream (Xilinx only)
>   loads [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]
>         [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]
> Loads the secure bistreams(authenticated/encrypted/both
> 
> The new output lools like this:
> loadb  [dev] [address] [size]  Load device from bitstream buffer (Xilinx only)
>  loadbp [dev] [address] [size]  Load device from bitstream buffer with partial bitstream (Xilinx only)
>  loadfs [dev] [address] [size] [blocksize] <interface> [<dev[:part]>] <filename>
>         Load device from filesystem (FAT by default) (Xilinx only)
>  loadmk [dev] [address]         Load device generated with mkimage
>         NOTE: loadmk operating on FIT format uImage address must include
>         subimage unit name in the form of addr:<subimg_uname>
>  loads  [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]
>         [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]
>         Loads the secure bistreams(authenticated/encrypted/both
> 
> ---
>  cmd/fpga.c | 51 ++++++++++++++++++++++++---------------------------
>  1 file changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index 93f14098ccb..cba38662958 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -411,46 +411,43 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
>  	   "loadable FPGA image support",
>  	   "[operation type] [device number] [image address] [image size]\n"
>  	   "fpga operations:\n"
> -	   "  dump\t[dev] [address] [size]\tLoad device to memory buffer\n"
> -	   "  info\t[dev]\t\t\tlist known device information\n"
> -	   "  load\t[dev] [address] [size]\tLoad device from memory buffer\n"
> +	   " dump\t[dev] [address] [size]\tLoad device to memory buffer\n"
> +	   " info\t[dev]\t\t\tList known device information\n"
> +	   " load\t[dev] [address] [size]\tLoad device from memory buffer\n"
>  #if defined(CONFIG_CMD_FPGA_LOADP)
> -	   "  loadp\t[dev] [address] [size]\t"
> +	   " loadp\t[dev] [address] [size]\t"
>  	   "Load device from memory buffer with partial bitstream\n"
>  #endif
> -	   "  loadb\t[dev] [address] [size]\t"
> +	   " loadb\t[dev] [address] [size]\t"
>  	   "Load device from bitstream buffer (Xilinx only)\n"
>  #if defined(CONFIG_CMD_FPGA_LOADBP)
> -	   "  loadbp\t[dev] [address] [size]\t"
> -	   "Load device from bitstream buffer with partial bitstream"
> +	   " loadbp\t[dev] [address] [size]\t"
> +	   "Load device from bitstream buffer with partial bitstream "
>  	   "(Xilinx only)\n"
>  #endif
>  #if defined(CONFIG_CMD_FPGA_LOADFS)
> -	   "Load device from filesystem (FAT by default) (Xilinx only)\n"
> -	   "  loadfs [dev] [address] [image size] [blocksize] <interface>\n"
> -	   "        [<dev[:part]>] <filename>\n"
> +	   " loadfs\t[dev] [address] [size] [blocksize] <interface> [<dev[:part]>] <filename>\n"
> +	   "\tLoad device from filesystem (FAT by default) (Xilinx only)\n"
>  #endif
>  #if defined(CONFIG_CMD_FPGA_LOADMK)
> -	   "  loadmk [dev] [address]\tLoad device generated with mkimage"
> +	   " loadmk\t[dev] [address]\t\tLoad device generated with mkimage\n"
>  #if defined(CONFIG_FIT)
> -	   "\n"
> -	   "\tFor loadmk operating on FIT format uImage address must include\n"
> -	   "\tsubimage unit name in the form of addr:<subimg_uname>"
> +	   "\tNOTE: loadmk operating on FIT format uImage address must include\n"
> +	   "\tsubimage unit name in the form of addr:<subimg_uname>\n"
>  #endif
>  #endif
>  #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
> -	   "Load encrypted bitstream (Xilinx only)\n"
> -	   "  loads [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]\n"
> -	   "        [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]\n"
> -	   "Loads the secure bistreams(authenticated/encrypted/both\n"
> -	   "authenticated and encrypted) of [size] from [address].\n"
> -	   "The auth-OCM/DDR flag specifies to perform authentication\n"
> -	   "in OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication.\n"
> -	   "The enc flag specifies which key to be used for decryption\n"
> -	   "0-device key, 1-user key, 2-no encryption.\n"
> -	   "The optional Userkey address specifies from which address key\n"
> -	   "has to be used for decryption if user key is selected.\n"
> -	   "NOTE: the secure bitstream has to be created using Xilinx\n"
> -	   "bootgen tool only.\n"
> +	   " loads\t[dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]\n"
> +	   "\t[enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]\n"
> +	   "\tLoads the secure bistreams(authenticated/encrypted/both\n"
> +	   "\tauthenticated and encrypted) of [size] from [address] (Xilinx only)\n"
> +	   "\t -The auth-OCM/DDR flag specifies to perform authentication\n"
> +	   "\tin OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication.\n"
> +	   "\t -The enc flag specifies which key to be used for decryption\n"
> +	   "\t0-device key, 1-user key, 2-no encryption.\n"
> +	   "\t -The optional Userkey address specifies from which address key\n"
> +	   "\thas to be used for decryption if user key is selected.\n"
> +	   "\tNOTE: the secure bitstream has to be created using Xilinx\n"
> +	   "\tbootgen tool only.\n"
>  #endif
>  );
> -- 
> 2.42.0.325.g3a06386e31
> 
