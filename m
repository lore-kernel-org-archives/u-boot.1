Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4109E7D0C9
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 05:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0516385E44;
	Fri, 22 Sep 2023 07:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mM36APHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0FB686098; Fri, 22 Sep 2023 07:27:13 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87BBC85894
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 07:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38M5R56K007876;
 Fri, 22 Sep 2023 00:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695360425;
 bh=lCexTBxKGOT1ykK15hnpSnCGg0I3edukp6jtBB+NNSw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mM36APHwenJjSODAmLOylWwEw1deU0Lcv5XtGDSZOQam784KcpfFNo5plGVsJgeT6
 fxw0notosODMTH4q8bJbxCzt1tbUDd0A5PUdF+iebH2T+2SjSoGIJhHaBYiAd8JjCW
 0oXWHdLUo5CjuPJd9OnIxhY9e9BJ39aQlb4sIU04=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38M5R5ms089968
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Sep 2023 00:27:05 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 00:27:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 00:27:05 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38M5R2JR092671;
 Fri, 22 Sep 2023 00:27:03 -0500
Message-ID: <3cd1e2b4-47b9-a3b3-d8c3-9f6c0481f479@ti.com>
Date: Fri, 22 Sep 2023 10:57:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Question] TI's u-boot.img is built twice
To: Masahiro Yamada <masahiroy@kernel.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>, <srk@ti.com>, 
 <s-vadapalli@ti.com>, <m-chawdhry@ti.com>
References: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Masahiro

On 21/09/23 21:06, Masahiro Yamada wrote:
> Hi.
> 
> Since the TI platform migrated to binman,
> u-boot.img is built twice.
> 
> It is created by "mkimage -E",
> then overwritten by binman.
> 
> 
> So, the data are embedded in the FIT structure
> instead of being appended.
> 
> Is this intentional?
> 
> To me, it looks weird.
> 
> 

I haven't added the fit,external-offset property in the binman.dtsi so it was 
not appended as external data and I did not find reason to. Is there any benefit 
in having the data appended than embedded?

> 
> 
> To confirm it, apply the following hack.
> 
> Since u-boot.img is overwritten by binman,
> copy it to u-boot.img.backup.
> 
> 
> 
> 
> diff --git a/Makefile b/Makefile
> index 87f9fc786e..4cffa8a061 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1112,6 +1112,7 @@ endef
>   # Timestamp file to make sure that binman always runs
>   .binman_stamp: $(INPUTS-y) FORCE
>   ifeq ($(CONFIG_BINMAN),y)
> +       cp u-boot.img u-boot.img.backup
>          $(call if_changed,binman)
>   endif
>          @touch $@
> 
> 
> 
> Then, build it for the main core.
> 
> 
> make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
>     am64x_evm_a53_defconfig all
>     TEE=~/ref/OP-TEE/optee_os/out/arm-plat-k3/core/tee-raw.bin
>     BL31=~/ref/trusted-firmware-a/build/k3/lite/release/bl31.bin
>     BINMAN_INDIRS=~/ref/ti-linux-firmware
> 
> 
> 
> 
> Compare the two files.
> Run fdtdump to see what happened to them.
> 
> 
> $ diff -u u-boot.img  u-boot.img.backup
> Binary files u-boot.img and u-boot.img.backup differ
> 
> 
> $ fdtdump u-boot.img
>      => u-boot and dt are embedded.
> 
> $ fdtdump u-boot.img.backup
>      => u-boot and dt are appended after the
>         FIT structure
> 
> 
> 

-- 
Thanking You
Neha Malcom Francis
