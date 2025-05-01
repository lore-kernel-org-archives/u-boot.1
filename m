Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A7BC3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 05:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32DE28070C;
	Thu,  1 May 2025 07:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="K4CQMl8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F78D8081A; Thu,  1 May 2025 07:32:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D63D8059D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 07:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746077570; x=1746682370; i=xypron.glpk@gmx.de;
 bh=+gh/dW4FDKaDy5DY6YMjk54TFdVs+9OsLTdONBtISRM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=K4CQMl8B8qYLMpFeNwzWEICje03iJzExOJH1nkYifXQrLe3G1FcGRI9PHrc/hPyi
 mBE4LpbzKIfyolODSiuRX3bpnzI8U8yIlPs3V9eVommXqD8kSQlYnGCDoIluJ5D1k
 bD3/oT+iRGXWdtAPpR/U3jZ2qunbopyAjOkJ/q++ab3gCBiPMSKVbQK4cfB8EsIGX
 TUW5l35YKVukfPzIU488T0kbNw0y4DdklvcpoNRHa14OXF6mvHJHnzMOpWOEVFDbX
 CfG9LnKBBpPAznF7ZITjF1XySrtJtwvqAXNPZJ6K4UKp3zpv3n4zfWgoo2JY9EMO8
 penOH8/xpFxiwbHWbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.107.6]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1ua2Iz1CPj-00Sq2Z; Thu, 01
 May 2025 07:32:50 +0200
Message-ID: <cec7bd05-f42f-403f-a666-7006b5e182b7@gmx.de>
Date: Thu, 1 May 2025 07:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efi_loader: fix typo initd_sz to initrd_sz
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250501011514.2209452-1-adriano.cordova@canonical.com>
 <20250501011514.2209452-3-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250501011514.2209452-3-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7BLLbG28VhoE72z6tVZ5dOtIgs9hmAls1pqVlunH2AfIID6IRr1
 gCKIE46wsKlCtNTWGYj1X+tBxfvZxDU3Lfw9jDrFCUcA7ZvJvcZ/e36ByUtMxov/WO2aYCq
 YWpZMrIwFCxBFqpFYDmr4ntTz0mS0RNXSUjM/CKMSLkLoYQuhJcgs5D8ODbT9SwGaR+dwE/
 gZGVj/FXaOxeBUFs5rBTg==
UI-OutboundReport: notjunk:1;M01:P0:rWBW+O7OXec=;9UqQmGlQSh+L1q2GERRcm28oeWG
 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
 uAvrEO7h2yteisD2iGRJZk=
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

On 5/1/25 03:15, Adriano Cordova wrote:
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

This is just the same patch as already reviewed by Ilias and me in your=20
v3 series.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_bootbin.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 637f2c0d195..db4478ee0bf 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -215,7 +215,7 @@ out:
>    * Return:	status code
>    */
>   static efi_status_t efi_binary_run_dp(void *image, size_t size, void *=
fdt,
> -				      void *initrd, size_t initd_sz,
> +				      void *initrd, size_t initrd_sz,
>   				      struct efi_device_path *dp_dev,
>   				      struct efi_device_path *dp_img)
>   {
> @@ -235,7 +235,7 @@ static efi_status_t efi_binary_run_dp(void *image, s=
ize_t size, void *fdt,
>  =20
>   	/* Set initrd if provided */
>   	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> -		ret =3D efi_initrd_set_from_mem(initrd, initd_sz);
> +		ret =3D efi_initrd_set_from_mem(initrd, initrd_sz);
>   		if (ret !=3D EFI_SUCCESS)
>   			return ret;
>   	}

