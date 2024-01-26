Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E2BC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 07:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294E087B58;
	Fri, 26 Jan 2024 08:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bb9Xntv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE00987B58; Fri, 26 Jan 2024 08:20:49 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD4787A80
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 08:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706253646; x=1706858446; i=xypron.glpk@gmx.de;
 bh=vqCaSnPjZZ7t1ghl6XeGs9Izw311qFz1OTYER+KiGKg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=bb9Xntv8VxS7TeTAwtsaNp/k0UkBbhlL1QNufb8en99WXprshvHhajSpqisd4GmL
 uPKwekcdeQ7yNxDBZZ8rCB/90WLjKyFWuisuvriL0gulgGjFvLnv9SUoWffbq3KKW
 7PF26AwUYaVH6ppGmfqQaraB6h1M5Nb10zDtg6u26Mu0hyZ1XEg8iJHptpHiIW0Ld
 JwmDKR8AW39XQVqoIHC4sByOC6LLEq1/i/kaMvcX8dAcOQXwQhlPCw7/jXk21pZJe
 gVJRdUK0WcJxWfXPVZeOkDupzB8ZdtB78L/Gyb3+/2BJPEiVXC8EdgfoD2CqHZbI6
 zcCC1rRLbqpW8B7wqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiPl-1rf2bz3G5F-00U4ZO; Fri, 26
 Jan 2024 08:20:46 +0100
Message-ID: <5da90978-3d5d-4458-b2c9-476a7e390406@gmx.de>
Date: Fri, 26 Jan 2024 08:20:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: check efi_get_variable_int return value
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20240122072617.1104227-1-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240122072617.1104227-1-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:85Icj8xcHn4ImclL4SqClNQS0n44RD2R8zLIO+95sCv2P4NWkNc
 G7H/vaQBTPoiHGXXwRX1/2nTHRanCSKG9XIIrrfTaWqCALEaEYJ17K9cLNZpCuuyEcHO2xF
 /fV63uXwRs0GacIaEgbx9G15LhQfxexuEjGGS726IVDMidkBOmJjYg+GW7dzausvRlw1sRn
 9cw3zYeFokdWPhY9/FIfA==
UI-OutboundReport: notjunk:1;M01:P0:F2FHd+6TfzU=;chod0K/864pK33DkCdFB3GCaRhR
 OK3qCek1SEQYAn3FXbp27IpjT6/miiUxOGGb8I3ykjFWZGq2durhsQBjDoVib2c8iladaFOyw
 aLe/zViQb8v5WIucGeDaLg+iR6lt27L49uNldttWIsHVqAwNLb+I54BheWniyULYI2iuEJTyu
 TRiV7qYP9BaV8HoQKVAHdG6d8wxFgUDsQo0O1B2ABs4mcSv10GygrjlRHhk/2mJVwUdZVMjgj
 4F/StQyV7aSO6MQIIrLJbfAhhFZ0oQAHejnm6MzmYaz+vcUWlBXb8J+YIrSRceTY1VVxMwTdh
 098XNTV8ezv7HTT40xL7j7GI+3Tl9qjEFBTBoSp9I9o1hAgUFbl6X4qiIvqvpIaEUK1HWCnso
 xGtEFdI76Jd4HDWvI3dkyaW/gp7cwNci7hUxId5F1XNl84PeMDWNUM77HI0ocxxPGZWQRQWYA
 kS1F3pEMuI/2L7NfBZAVOe5ZY7FvJr4zvGMINzUG3RMqmKzt/qLe76vTkSOp4fQtVv6ilScaP
 /zcNWgvYO42HbZcZBiSSqDywGFQSRfR2C5as66QLQ3Pe2ki/od7TzU/wCvTgfL50EdvHMuB5V
 BM3bKAm+/YYtQBcrLT4+p+Qgx35PTCuRgkEodVjd9PZ0pQrroywFG51mC6hxcaNCDfG1968/K
 20TOZRVHWp9LqREKgrFwN48D7Y6sRRau7/RKMs8qk/5yMgo6Jxp8Yt/tOcpFSNOJqnq6+E8x+
 /N8TCjzzo1EZYwkq3MpqAhnIYXY9Ubgo5GAoie5aoURn9Ln8Wj5ddHWoocxywSW+ZJ/do0ich
 NTPRxrYu2cqAGjKJHhjioeelcXthoPeikDFmB7Rxkko9RNx5nHKRGhBnL/CQuD7WmXpvCff/u
 S2VfmBVuotJuFGZmXZ3YOnffRBXtwzabOaRijIvwT6x8gGpE626Fu+j4PrdiZx9caZIxc0YAm
 EX93Nytf5ae/cXWi8TYXjh8b2Zo=
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

On 1/22/24 08:26, Masahisa Kojima wrote:
> efi_get_variable_int() may fail, the buffer should be
> cleared before using it.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Addresses-Coverity-ID: 478333 ("Error handling issues")
> ---
>   lib/efi_loader/efi_firmware.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware=
.c
> index 9fd13297a6..fb83fa8113 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -407,11 +407,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct=
 fmp_state *state, u8 image_in
>   	/*
>   	 * GetVariable may fail, EFI_NOT_FOUND is returned if FmpState
>   	 * variable has not been set yet.
> -	 * Ignore the error here since the correct FmpState variable
> -	 * is set later.
>   	 */
> -	efi_get_variable_int(varname, image_type_id, NULL, &size, var_state,
> -			     NULL);
> +	ret =3D efi_get_variable_int(varname, image_type_id, NULL, &size,
> +				   var_state, NULL);
> +	if (ret !=3D EFI_SUCCESS)
> +		memset(var_state, 0, num_banks * sizeof(*var_state));

Hello Masahisa,

We allocate var_state with calloc(). So it is cleared before we call
GetVariable(). Do we have an implementation of GetVariable() that would
fill it with data before returning an error code?

Best regards

Heinrich

>
>   	/*
>   	 * Only the fw_version is set here.

