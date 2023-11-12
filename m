Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518D8C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 23:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE9C86D33;
	Mon, 13 Nov 2023 00:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VfNB4tdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF3786D33; Mon, 13 Nov 2023 00:40:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7772B86D62
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 00:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699832444; x=1700437244; i=xypron.glpk@gmx.de;
 bh=p99Te8Mqmcj51p1dX44XTfy7R1w3zmP0sD5Lu0Ta0dA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=VfNB4tdXd9SJ21r3r60DU+6f0oI7EiJDgwWfxY+Cux7vEUF1se5KRHmGQr2TADth
 agdFkyhuYGtkQTB0s8En8PFwhnIGFKp885N6l8UjZxRInd+3EzjjOXOCWpHVg9FBX
 g+aJrdWyGZ9YBAAu8kROXglSu/9rtQ5f1ccLx5ciGdwOu6WPHWxgJh5mzTVrwnfN7
 SUA/NwfefKfePXkYCoAPVt2g5iREH6GWD7C+9itQnouByKJc+8atCA8dgPdyBpDnV
 I7m3dDxJFGZPAm2tlz1yPCkgL5gI96aIOsG4vi8uv3ocT+sxZCAXk1zlT1BSgLtwj
 IcKY/khxYdq0/TsBpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbkp-1qikqG3VnP-00P9eT; Mon, 13
 Nov 2023 00:40:44 +0100
Message-ID: <4e525027-5a4f-47be-ad77-8bcb255fc630@gmx.de>
Date: Mon, 13 Nov 2023 00:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Increase default variable store size to 128K
Content-Language: en-US, de-DE
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: alpernebiyasak@gmail.com, u-boot@lists.denx.de
References: <20231106154754.59374-1-ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231106154754.59374-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eRh4GSjISThf6HLnbQ31hOnTtxhtZ3TLn064EY6+7PBm4py8AY8
 opz24NkUw/HcTypNE6422FmWh5mj0Pvac5OBrjllc3tkrsy/VEclXry/94217MRr8e7jE/A
 ZaLjjzkwrdIlkF3oX5pZdGKg5qttE92xCKDkvLxr26Y4I8SeQzt3Z1orzlrqIcbc6ktXiE4
 +kCAkoO/m/znmFPJBosAA==
UI-OutboundReport: notjunk:1;M01:P0:pw0KblglQ/o=;ulaTKiiEA01hO/QCbPDO6caIsg6
 NB4kpCPmltMuAxoqEjp9U+cfSmnZO0ag7BKjaCD3TETdJY84dYbjTh7g8r4U7ZnXX8XWAozt4
 OhapQfWtESDTBe30qOPODz9N6nxvCCfn5I/1HrkWaKQsYJ0Bx0s18ukuDf0XFNUsurwyYx0fi
 6E0pMhHfSaHUlbL0idFhHfr2Di68T/+YVh22RDJsRLC4fETfd3quLB8iagtMPQFpV22lS3VlK
 sSBIEAkzkoq19zKZ2cvFy8RbYLiFmSQVXag1/kRNzoDhSQIlJwBIN6txjYPUIRH07g321RSVY
 G5D+Mdx1mokj4Ehzuh+KNQgeRZsGMpbvZGfuItjgz5/Zxw6n3MEKDDGCEzXbNIl4gFhklJOWG
 VoFd/WvAghrLhQ2kOd7snyMOWYnwssWwsY7GVFbrIy/sHJQvZ2MdwiILDdAJamb5yNJcn7wq1
 OmdXeJF3Dnh+UD3M6YLGbSenmq9Wio4YwognvpWPx2hXJoZkv7yM5ujbrOl+/JhaHuNbFmhcE
 eI4BIxiatt9TR6Xx5qq7rHwKqyjnmki3BLlmvuabnSO8ipbl3soms5zNS04gyDuveAOTUpMPm
 +0PM9kt+jeu0ZUjqmILHcJHPdJD6VpMRsWllLaDgy3Yf9dzE9FPibiKpVydRlw89dQ44X2Tm3
 RltN+9tKaZ8EbxehgR6kz9jN7IdmfHn5O/iTtxVRItu0gwmQUXr0Xr0BeXiHRbBldaI7d9ClU
 zZBMOVLew4aZeTLlvfMgnskx2XK+dMOYcF1ulZL2ouin2ZHWLetwexFN7cEPSqbP8pcJnl7w/
 eX7+FV7zgLh2e7go+x/5rEP6aiCUgaxjP+tc/J3MLNyjyReyJWO/Ch/cpZs97XGxcq4BEAfMI
 tQ47Xrnp6+V357mipIJ0LWRWsFGRDrRe7Q1rav0xoKbtUKXkTTh/clyG/YwoUNOpHBBElgCzV
 71NM73aeO14nrD0b5+vj/UNldJY=
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

On 11/6/23 16:47, Ilias Apalodimas wrote:
> In commit 9fd3f881c6ed ("efi_loader: Increase default variable store siz=
e to 64KiB")
> Alper has a detailed explanation of why the size needs to be bumped to a=
t
> least 64K.  However enabling Secure boot, writing db, KEK, PK etc keys
> will further increase the size so bump it to 128K.
>
> It's worth noting that when U-Boot stores the EFI variables in an RPMB t=
he
> available storage is defined statically in StandAloneMM at build time.
> The U-Boot code is detecting the available true size on the fly during
> writes. When StandAloneMM is present this size defines the reserved
> memory U-Boot can use to copy any runtime variables, before booting an
> OS.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/Kconfig | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 4ccd26f94a93..0d024911b42e 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -133,18 +133,20 @@ endif
>
>   config EFI_VAR_BUF_SIZE
>   	int "Memory size of the UEFI variable store"
> -	default 16384 if EFI_MM_COMM_TEE
> -	default 65536
> +	default 131072
>   	range 4096 2147483647
>   	help
>   	  This defines the size in bytes of the memory area reserved for keep=
ing
>   	  UEFI variables.
>
> -	  When using StandAloneMM (CONFIG_EFI_MM_COMM_TEE=3Dy) this value shou=
ld
> -	  match the value of PcdFlashNvStorageVariableSize used to compile the
> -	  StandAloneMM module.
> +	  When using StandAloneMM (CONFIG_EFI_MM_COMM_TEE=3Dy) is used the
> +	  available size for storing variables is defined in
> +	  PcdFlashNvStorageVariableSize.
> +	  That value is probed at runtime from U-Boot. In that case,
> +	  EFI_VAR_BUF_SIZE represents the memory U-Boot reserves to present
> +	  runtime variables to the OS.
>
> -	  Minimum 4096, default 65536, or 16384 when using StandAloneMM.
> +	  Minimum 4096, default 131072
>
>   config EFI_GET_TIME
>   	bool "GetTime() runtime service"
> --
> 2.40.1
>

