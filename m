Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB4BC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112CB88152;
	Mon, 15 Apr 2024 14:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GXjfx+t/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7835B88190; Mon, 15 Apr 2024 14:41:30 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E12387B82
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713184874; x=1713789674; i=xypron.glpk@gmx.de;
 bh=pJt2RekIQk5asnU8f3TkTeKjMBmokubncfbm+czmSoo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GXjfx+t/OaNkIHatLn3UjsGpJMCAhkodghOufhvGdBVHpc1/BZ1apzACTq1wECFR
 Nwv1cr1MTMyg1jdh82l+6sS+Nt7mOt0fgR0AQVCg823zcxIMcyPl7hTsC/sSIbsp3
 hd0lNUZPise6ImGWvOA7TmDiX5nE8zto3SmBN5K93pgRQmib/D+oGDxbwdtDS08Ww
 wsaOeVOQsUy/ApLswUrhqFxQ93gPWpRik/3C6Sq3f6PlW9ueSdDVx+6RCKyOQvtuT
 684m1grtWR9RdvIWWZw0PKHYjijuItZbfBsNxwDtjHbSjJNrAx5xEd20EVIXLqQeF
 CGYITVp5prXbb/Tq4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbFs-1smo8q1qGU-00sguH; Mon, 15
 Apr 2024 14:41:14 +0200
Message-ID: <d311e90a-a9d0-4f45-a440-7d8a0efca199@gmx.de>
Date: Mon, 15 Apr 2024 14:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] Kconfig: Add missing quotes around default string
 value
To: Michal Simek <michal.simek@amd.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, git@xilinx.com
References: <cover.1713180904.git.michal.simek@amd.com>
 <b8bee323b100ef1f5958e2f64e14e9776ff2bc06.1713180904.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <b8bee323b100ef1f5958e2f64e14e9776ff2bc06.1713180904.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TbShJs7LK+kCTtJcTGY5/BicsTLthW9A/tymUO4MD0xFht6qJBZ
 0x4pOnIVlWqDDeiKy8fGF1BlKG0hAssdErBSQq9R/3zkArc7Y7w9OCg6EscsZ0oSgy1JnjJ
 3+vwAhtXUF0RtsnS8eo2AT0bK2cNmNktW+bw2AS+NFJLn/P9LZk1ZE3DWzz0lvaxFqteJo5
 tDfBj1ueCMA8pfFmo7QEA==
UI-OutboundReport: notjunk:1;M01:P0:o7RBCVqzdIs=;Ju2s+Vq5sZO7/we/sdJFE6CyNgV
 jPEq93i+WzuIKUj6EdbxFppoObVknNu3z9d32ehneUFjuGPrdPuG6YnEdyzpJ8i0Sd4rIpP4I
 dnNgZeFMdmeWatPHjfKmeLnRd2ntNFHE90DgHHrXPGRrPbuyrVd/A9y46b0zgfiKirwFKrDSo
 uaHxujuQQFJXOzYGVXureaTQ28x+OHTGRAK7iSeFsW7wbpvLkFYHat66lJPcK54e5bG7Atvij
 QoghGWXAhwdErhhEb5RbTWp6LGBEnurrFk12FfrDRWngBHdAAKcGkXXOoX02DOD5yRzm9S80e
 pr3d54pIntBtoz2ylG6BCxmdJAkyjsMBlcXyZfmxvzNnFi0xx+AF1T1lMqISD4EfkY9O7gIyn
 F5CJHnU56P5V/xMPtOBiUykAgxHRmbsRhVojFnNyyTJPmNgpbcWOaQ9h8KEFBCqeB6f3GcS1v
 Iv41GgNegPyLz2ubdL9265RsTg9QaIexfl1s6AfOcGZzeWKLJ1Q4pSVokGe7BRQRRKRyDXfGU
 qEE2ysPnDhcmyrsuzZSoLIevQxAr2CWbzbqmVxPT/oyHByrmmG//Ud4iKRddytt69/2GSN/hL
 xWfmdKpQkxkcpR2qUmSUpxRz2iXbtg47uT4kPY6A+OrpUmuq6D7GYXYeTulG0OJz1urb20Ntq
 45xRfZ/g+0a9LS9pHzwvW9Wq2XwtqT+M49aHqnW27wU2aSoBUY+J6LvlKj+C9Ei4tuJiqNAkp
 IgT4/5f9QymueK76AnuxY6VDr28G5fzOM1t9zGpkWyILDSMjYmpuzU/s3AocFr3TD6jp+rHF2
 PgATER56AfNEJS4OKuLs4JzhJolXYQNRqKM/9levavISLI0sFqCw25rkMbWCAMgSgA9sdScHS
 8HLDaw4GTGTC2gQ==
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

On 15.04.24 13:35, Michal Simek wrote:
> All errors are generated by ./tools/qconfig.py -b -j8 -i whatever.
> Error look like this:
> warning: style: quotes recommended around default value for string symbo=
l
> EFI_VAR_SEED_FILE (defined at lib/efi_loader/Kconfig:130)
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>   lib/efi_loader/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index e13a6f9f4c3a..a5ab7d1b262f 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -129,7 +129,7 @@ if EFI_VARIABLES_PRESEED
>
>   config EFI_VAR_SEED_FILE
>   	string "File with initial values of non-volatile UEFI variables"
> -	default ubootefi.var
> +	default "ubootefi.var"
>   	help
>   	  File with initial values of non-volatile UEFI variables. The file m=
ust
>   	  be in the same format as the storage in the EFI system partition. T=
he

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
