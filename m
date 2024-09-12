Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BAFEED60D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 14:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7BC688F4B;
	Thu, 12 Sep 2024 16:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EkWNH5ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5947288FC4; Thu, 12 Sep 2024 16:45:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6060D88EA3
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 16:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726152331; x=1726757131; i=xypron.glpk@gmx.de;
 bh=Y0BSEicHGCUwSFLQZLzj+aQdclux56WUxscPtj/3WZg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EkWNH5ss5ZDTnxOFy5kNG4/jhJIJI+C0jIchwKR01+uWz6MSxfFcqBVptQnOyLWK
 0V17yT8vG5iZKwHi5mlRon24h625mLhb4dYzgpnrVyWY5rdlmYL8km1cnkcQheM3Q
 VpcLHPXloRNabH67g8Vu0Oer7tHyF8FwK4pNvZ11eWSsmlVcRNKD1J3Jv1ZNnNdcD
 RD0TIS7tJFw9gnTUR4ft8kPRmyW4eD9YA7UX7HVu7A5/PXe4kfL0turPJYcUoIf93
 kK91mcQB/yhtHAyfVhJJEceZtDNOCblextTn+5aPJVlajbVj0UO3GTzf3SctPxKuQ
 f6Um4tvMZzilIJtQoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVHe-1sZHYR2Q80-00Qg2k; Thu, 12
 Sep 2024 16:45:31 +0200
Message-ID: <d421b72a-eb0a-4aa8-be6e-3825c8b08da6@gmx.de>
Date: Thu, 12 Sep 2024 16:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] efi_loader: Disable ANSI output for tests
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-11-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240902011825.746421-11-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tpf98on9rN7GN5U1e6HdFElC0ria4z/S6JmiOWohVZh4yC9wz8Y
 88eAwQ1oXANW7UGWof/HexQSRO1rlUmwH2G36Nfq47J/97NZjjRUBRModx7bWt8A2/Hajn0
 pHVGKJSzt83dQ5y3ov3lLdfBUCkbzwksWXS0SmXOy5ZR+0MyiHOsIALjHPdO5ef26VFgV/r
 kNHNbFbjnG7NYiuP9LXvw==
UI-OutboundReport: notjunk:1;M01:P0:OVGtH2QYIrE=;SI3VUz/+nsZCK5rDUpIhKhrXHYN
 I05CyFHMv9QP8E7JEfYzRZtCD2pZffH8W4adM5n4N71g1nTnlcOXCKcKSnfpprzXfAFxmMgnb
 NsgOX0hVXZCdJhrsd/A4M2Jd+KGzNpP1Fkwax4SuJDxNa/RXHA87cKxfXsRHcTrrDs8aDdSrL
 P5i2EtzGFmuVYN4aYu9s8KwBEOoaaXsMOulXt9IdJwrLRexKcZKWTX73TFzRc7qlETFGrUAS+
 O+TrUx73UJqKSDDklmZV2YzuoylS7YEt45dp+VaH1rtgEkjw81gUtDxh8G1mUT/3BS/R8mF7q
 Fmjup0hf8xqNxqYdXk3VPT0z1iPb3yh8T9nj7CVwDOHNTlG8fu3J41QOYfMh2qbeapUXKmSQ9
 XnHbE3eYC2rzZpqfQ2r0ueVNdhe0NjvS3J31AtUL2wqelQ/ncse6CuYhQk4f1Hr6ByagVnInr
 05j28WsbfQvWeh0qHFHU14oupgBrjXuCe44/MCWMnrHT93NgJSN12yq3+Ckf7Yt4CBtssQ2X7
 KCGbJpPft6YSY2l+z5v5gZj5kWA2jjV+zzEOaX7XJgtRrfys8YCQCUQSGxhovNcVSYfXKxYNQ
 /L3t6lx+mhz8L/xSzwfOtSOSEMacND/nYIefTnCByEHmqsmJj0PKWhtd0kIfEk2Z3sCzA2RLp
 BxZUGBOPsrYAVNQ0rNFSMOWhn+6D5CHfpObvovzxGEjWFwF+H4tjoL+0v7bjOlHIPRMmbTm1O
 HJ6AtsMIc+0SwDEhsMFZN99m//L7a8mgAwDpdocFDkJykiisbOJBwT75OWvny9philF44+696
 paOJBfHkUNYy+qLvs2y+62GQ==
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

On 02.09.24 03:18, Simon Glass wrote:
> We don't want ANSI characters written in tests since it is a pain to
> check the output with ut_assert_nextline() et al.
>
> Provide a way to tests to request that ANSI characters not be sent.
>
> Add a proper function comment while we are here, to encourage others.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>


This patch was already NAKed in the last version.

Please, adjust the test framework if you need filtering.

Best regards

Heinrich

> ---
>
> (no changes since v1)
>
>   include/efi_loader.h         | 21 ++++++++++++++++++++-
>   lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
>   2 files changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index f84852e384f..82b90ee0f1d 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -531,8 +531,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boo=
t_index);
>   efi_status_t efi_bootmgr_run(void *fdt);
>   /* search the boot option index in BootOrder */
>   bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target,=
 u32 *index);
> -/* Set up console modes */
> +
> +/**
> + * efi_setup_console_size() - update the mode table.
> + *
> + * By default the only mode available is 80x25. If the console has at l=
east 50
> + * lines, enable mode 80x50. If we can query the console size and it is=
 neither
> + * 80x25 nor 80x50, set it as an additional mode.
> + */
>   void efi_setup_console_size(void);
> +
> +/**
> + * efi_console_set_ansi() - Set whether ANSI characters should be emitt=
ed
> + *
> + * These characters mess up tests which use ut_assert_nextline(). Call =
this
> + * function to tell efi_loader not to emit these characters when starti=
ng up the
> + * terminal
> + *
> + * @allow_ansi: Allow emitting ANSI characters
> + */
> +void efi_console_set_ansi(bool allow_ansi);
> +
>   /* Set up load options from environment variable */
>   efi_status_t efi_env_set_load_options(efi_handle_t handle, const char =
*env_var,
>   				      u16 **load_options);
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index cea50c748aa..569fc9199bc 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -30,6 +30,17 @@ struct cout_mode {
>
>   __maybe_unused static struct efi_object uart_obj;
>
> +/*
> + * suppress emission of ANSI codes for use by unit tests. Leave it as 0=
 for the
> + * default behaviour
> + */
> +static bool no_ansi;
> +
> +void efi_console_set_ansi(bool allow_ansi)
> +{
> +	no_ansi =3D !allow_ansi;
> +}
> +
>   static struct cout_mode efi_cout_modes[] =3D {
>   	/* EFI Mode 0 is 80x25 and always present */
>   	{
> @@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int *row=
s, int *cols)
>   	return 0;
>   }
>
> -/**
> - * efi_setup_console_size() - update the mode table.
> - *
> - * By default the only mode available is 80x25. If the console has at l=
east 50
> - * lines, enable mode 80x50. If we can query the console size and it is=
 neither
> - * 80x25 nor 80x50, set it as an additional mode.
> - */
>   void efi_setup_console_size(void)
>   {
>   	int rows =3D 25, cols =3D 80;
> @@ -362,8 +366,12 @@ void efi_setup_console_size(void)
>
>   	if (IS_ENABLED(CONFIG_VIDEO))
>   		ret =3D query_vidconsole(&rows, &cols);
> -	if (ret)
> -		ret =3D query_console_serial(&rows, &cols);
> +	if (ret) {
> +		if (no_ansi)
> +			ret =3D 0;
> +		else
> +			ret =3D query_console_serial(&rows, &cols);
> +	}
>   	if (ret)
>   		return;
>

