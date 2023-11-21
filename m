Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0785C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22AB1875EB;
	Tue, 21 Nov 2023 18:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jXTM78q9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF40875FB; Tue, 21 Nov 2023 18:17:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE57875B5
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700587037; x=1701191837; i=xypron.glpk@gmx.de;
 bh=uyFoiAjaNvKYZeEWyX34gT6dwi6a2U1UUy2M8LTS1jM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=jXTM78q92P1ADXjbQBgXz5zycC6RB+l5Ih7wHsQaLnXla4yyVAP1mbBQOdg/LQm9
 OQ81FK6uy3qCIsRtRQD2jjBAKwxgr0jIYZcomlIokX6l+6sQ2gpK+lxn8dEvUGmqP
 fDlYkXplgPzXpA684KPr2lcYkqzNPVHWE7gi6jyz0rGNmUw/79IHFW5tLXf978Oh2
 UXyCUB4cFJZLkqCBVGVwdBUamkqecUXHd3y7VqpfgOYqaZezV1WvNClUQAt8HSBGU
 OnvmwuZ0C71SnSis1L4Up9zPjlyf+zONJvdXsGuFY0utowJ7gfsR+wPLlDExeOPav
 Yl/kJTChVD99Cdr95Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9Mta-1rQA1Y400K-015HdN; Tue, 21
 Nov 2023 18:17:17 +0100
Message-ID: <07051882-8b13-4878-8f6f-1fe31fe97467@gmx.de>
Date: Tue, 21 Nov 2023 18:17:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] WIP: efi: Allow helloworld to exit boot services
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-7-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121113557.800353-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vkBnrqwbli43GxMG3Tc+zh5yTd47obH9wVuhuLJ+PZB4v1ZDDnm
 Dtlr5Nrixb16NEJM8m2CENxVJ2Fx8S+m4kJ5j/TL3hYSif9VZT4EAejAfpw/fUt6hU52l4X
 awgM8zim3is8ATGgko9D7U7yM2rh5YvO7imvz67K3uULQ/fNRCiJxWoiV59a7HQtom5GTem
 OVfiQRFqEngSJa9Na6q0A==
UI-OutboundReport: notjunk:1;M01:P0:F7OaW7xXQJ4=;AwFmo4JenWYl/TQ9Q/N7vzHh8cd
 TAgjdzvUga4gGbe9WRVBNP3ZzGlm3XnBZKxMIhFWTHl8+PavKiLnt7zn1j8d9BGC1/oqZq2I3
 73zKnaR5/ZeiPZFMj1N9y6dzl0xb8PnmKL2zMUtwpHAkUtk2rpe+BVRCzWtGfu5BP4CcrOTuh
 NRCcd5DpIHTTRlxvDrKvWqSW593gFT0i8Xgt66IVhwVdt5ArOlvBD9vqV6erHGCSsKMkJzvfq
 VB0PRvfNGDmkxovzoPRciqUmRusQhEJF1cSqFjSSyM9eP6wjmDxxqC0DFbFdUVCmbhrZrlwd1
 KWU5cpk+Tz++IPuEJ73dXancaBF9Zb8KGRe19UlmED+pY7drDAlAKDAlB6hRq/1NDp8Chgkh7
 hY4TAxWs3XBAwHIozvhZdEqTh0XkRlS4IO4AsqtzJJYxBMFuMTWHXer0N96AwUMoGecPJ9naF
 Sv0po9CLUdj5iL7Bg6fTIRdZCOgN/f0FrJ5n05np8cPGwcObDTcLvFPnwRcp+23ol1ZXAlOcn
 7pro4ARwWBQY7XYZAyffvnPQVZmDjlBq1k3IYRgiv6MxZEB23TjIxodE7UYf5rARERB1rjo2m
 2QAMN7OsXbp2sl1kL0ptqa0n8PKjyNoAtWIfICnBOtFTeMSMKBMv4OCEtZn8afkWD1PSoGuLb
 lGSxJeL4GWEd8fpnl8s9hIxt99nX90BMiSMUQvpagrkNf02VOGHjnT3xTWOfUF+qJvzDefNs0
 5W47PU5TgGgqvRYZK36mZU0n6PhHVZnLfH/cS2Vcthq+Mfykz1KmfIF9o02g08lIPi74CbQEh
 XiTDRVQw30lvsaB2LiSvCnC9gHOC4UhaX3Mk1g5yYHCNN5Bm2J51DFN/9TyCRD5PRH3QuISMQ
 VoGi67ZQbJPSS/1IuopiakslWS1soIiWHJIsRDNwTBzatv5R9UtwgLYBgHqIYpsJvBnl7AJ07
 hd5b+g==
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

On 11/21/23 12:35, Simon Glass wrote:
> This allows testing of the exit_boot_services call, providing more
> coverage of the EFI bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

I would prefer to keep helloworld.efi benign.

Please, create a new EFI binary for testing ExitBootServices().

> ---
>
>   lib/efi_loader/helloworld.c | 36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> index 1135d3a3c37e..1fb5fb5a62f2 100644
> --- a/lib/efi_loader/helloworld.c
> +++ b/lib/efi_loader/helloworld.c
> @@ -206,6 +206,26 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>   			(con_out, u"Cannot open loaded image protocol\r\n");
>   		goto out;
>   	}
> +
> +	{
> +		ulong ptr =3D (ulong)loaded_image;
> +		u16 str[80];
> +		int i;
> +
> +		for (i =3D 0; i < 8; i++) {
> +			uint digit =3D (ptr >> ((7 - i) * 4)) & 0xf;
> +
> +			if (digit > 9)
> +				digit =3D 'a' + digit - 10;
> +			else
> +				digit +=3D '0';
> +			str[i] =3D digit;
> +		}
> +		str[i] =3D 0;
> +		con_out->output_string(con_out, str);
> +		con_out->output_string(con_out, u"\n");
> +	}
> +
>   	print_load_options(loaded_image);
>
>   	/* Get the device path to text protocol */
> @@ -243,7 +263,21 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>   		goto out;
>
>   out:
> -	boottime->exit(handle, ret, 0, NULL);
> +	/*
> +	 * TODO: Use vendor string to decide whether to call exit-boot-service=
s
> +	 */
> +	efi_uintn_t map_size =3D 0;
> +	efi_uintn_t map_key;
> +	efi_uintn_t desc_size;
> +	u32 desc_version;
> +
> +	ret =3D boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size=
,
> +				       &desc_version);
> +	con_out->output_string(con_out, u"Exiting boot sevices\n");
> +
> +	boottime->exit_boot_services(handle, map_key);
> +
> +	ret =3D boottime->exit(handle, ret, 0, NULL);

After ExitBootServices() you must not call boot services.

Call runtime->reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL) instead.

Best regards

Heinrich

>
>   	/* We should never arrive here */
>   	return ret;

