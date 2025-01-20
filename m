Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6081EC02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 08:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D683800B6;
	Mon, 20 Jan 2025 09:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="C51A1ePZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E4D801CF; Mon, 20 Jan 2025 09:55:37 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14AA780077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 09:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D83B414841FD; Mon, 20 Jan 2025 09:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737363334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=laaI0WAFSUUN/FPLrYLBdJd0XHlhRHXNVeLUm0gjck4=;
 b=C51A1ePZMSGTRHkbg5hjFWk8KS825eZsXSjPn3s8SVOp87+BEzyYY+8IXOyihoUCkPmOtP
 8alPvZScmAt2r5FS0fgKZr9ABr6oAYJD8N/dLl9mGBZdzS74QHQMRbxdw3gqXsmt3WdKA8
 jyQUkmxa3ADfYkzdLMjFoik0qaWpgsD6nMHXlBPBNres3hvBbsanXgv5IdZU5ZGfW0hjLR
 4BNjqqXJXwX+PZba6Du8/fEuxouCBHPjDWu7QQ3TZ0Q55DA/p1XXzP7ppPREvLMT+7gA6N
 MZAr1lMdrDOhnflF2Ea1PqmFXqP/COID3ZLmuw+cLfPQUUOfWrhbcYHR+rOIPA==
Date: Mon, 20 Jan 2025 09:55:28 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
Subject: Re: [U-Boot][PATCH v3 1/4] fpga: fix alignment on fpga cmd usage info
Message-ID: <20250120-shakable-audacity-943d824a4ed8@thorsis.com>
Mail-Followup-To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
References: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
 <20250117112557.3729416-2-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117112557.3729416-2-ibai.erkiaga-elorza@amd.com>
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

Am Fri, Jan 17, 2025 at 11:25:48AM +0000 schrieb Ibai Erkiaga:
> The current implementation generates some alignment issues as well as
> some overlapping when all the fpga command options are enabled. The fix
> is intended to improve readability of the usage info.
> 
> Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
> ---
> 
> Changes in v3:
> - Split 3rd patch into two, resorting commands and Kconfig changes
> 
> Changes in v2:
> - Tabs replaced by spaces
> - fpga command added on each option similar to other commands like sf
> - Dependencies to Xilinx only commands added in Kconfig
> 
>  cmd/fpga.c | 61 +++++++++++++++++++++++++-----------------------------
>  1 file changed, 28 insertions(+), 33 deletions(-)
> 
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index 93f14098ccb..ae85ff201b8 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -408,49 +408,44 @@ U_BOOT_CMD(fpga, 9, 1, do_fpga_wrapper,
>  #else
>  U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
>  #endif
> -	   "loadable FPGA image support",
> -	   "[operation type] [device number] [image address] [image size]\n"
> -	   "fpga operations:\n"
> -	   "  dump\t[dev] [address] [size]\tLoad device to memory buffer\n"
> -	   "  info\t[dev]\t\t\tlist known device information\n"
> -	   "  load\t[dev] [address] [size]\tLoad device from memory buffer\n"
> +	 "loadable FPGA image support",
> +	 "info   [dev]                  List known device information\n"
> +	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
> +	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
>  #if defined(CONFIG_CMD_FPGA_LOADP)
> -	   "  loadp\t[dev] [address] [size]\t"
> -	   "Load device from memory buffer with partial bitstream\n"
> +	 "fpga loadp  <dev> <address> <size> Load device from memory buffer\n"
> +	 "            with partial bitstream\n"
>  #endif
> -	   "  loadb\t[dev] [address] [size]\t"
> -	   "Load device from bitstream buffer (Xilinx only)\n"
> +	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
> +	 "            (Xilinx only)\n"

I would have aligned the second line below "Load", but since that line
is removed in patch 4 anyways:

Acked-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

>  #if defined(CONFIG_CMD_FPGA_LOADBP)
> -	   "  loadbp\t[dev] [address] [size]\t"
> -	   "Load device from bitstream buffer with partial bitstream"
> -	   "(Xilinx only)\n"
> +	 "fpga loadbp <dev> <address> <size> Load device from bitstream buffer\n"
> +	 "             with partial bitstream (Xilinx only)\n"
>  #endif
>  #if defined(CONFIG_CMD_FPGA_LOADFS)
> -	   "Load device from filesystem (FAT by default) (Xilinx only)\n"
> -	   "  loadfs [dev] [address] [image size] [blocksize] <interface>\n"
> -	   "        [<dev[:part]>] <filename>\n"
> +	 "fpga loadfs <dev> <address> <size> <blocksize> <interface> [<dev[:part]>] <filename>\n"
> +	 "            Load device from filesystem (FAT by default) (Xilinx only)\n"
>  #endif
>  #if defined(CONFIG_CMD_FPGA_LOADMK)
> -	   "  loadmk [dev] [address]\tLoad device generated with mkimage"
> +	 "fpga loadmk <dev> <address>        Load device generated with mkimage\n"
>  #if defined(CONFIG_FIT)
> -	   "\n"
> -	   "\tFor loadmk operating on FIT format uImage address must include\n"
> -	   "\tsubimage unit name in the form of addr:<subimg_uname>"
> +	 "            NOTE: loadmk operating on FIT must include subimage unit\n"
> +	 "            name in the form of addr:<subimg_uname>\n"
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
> +	 "fpga loads  <dev> <address> <size> <auth-OCM-0/DDR-1/noauth-2>\n"
> +	 "            <enc-devkey(0)/userkey(1)/nenc(2> [Userkey address]\n"
> +	 "            Loads the secure bistreams(authenticated/encrypted/both\n"
> +	 "            authenticated and encrypted) of [size] from [address]\n"
> +	 "            (Xilinx only)\n"
> +	 "            -The auth-OCM/DDR flag specifies to perform authentication\n"
> +	 "            in OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication\n"
> +	 "            -The enc flag specifies which key to be used for decryption\n"
> +	 "            0-device key, 1-user key, 2-no encryption.\n"
> +	 "            -The optional Userkey address specifies from which address key\n"
> +	 "            has to be used for decryption if user key is selected.\n"
> +	 "            NOTE: the secure bitstream has to be created using Xilinx\n"
> +	 "            bootgen tool only.\n"
>  #endif
>  );
> -- 
> 2.42.0.325.g3a06386e31
> 
