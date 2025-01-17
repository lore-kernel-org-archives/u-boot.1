Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD5AC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 20:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A11C80423;
	Fri, 17 Jan 2025 21:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GAdpD3cu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996CD8069D; Fri, 17 Jan 2025 21:19:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 835468036F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 21:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737145160; x=1737749960; i=xypron.glpk@gmx.de;
 bh=EyV5GRX+BDAPmSkR54KPTCOBand8TRO7lskRrVS/4sU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GAdpD3cuvT9Djl4DKRdgYrAlEoNLRRafPJa+CkAnNYQbUqHpYzCw1XgixN7EX8j4
 9NhV4cwCIvqQCYMYshBp0PHFRjGdigQQAyyYCeX/iNlXTIYHweoKYeKi5qBqZ7RfN
 V2xmscQOEmBzhBit8YpY/ERwEUY4zTco3P8Aol0gg3iQ3NHtuUSk/GfeuWpDKiBtC
 tR/0nZkm9nq9B9IMHm+qu/HS535H70SB7NpRftRSsiJueSM5zCV5BGdvr5yOC41Hf
 CD6+khQaEvo9cJXnWGKQqjRY7aOoIvSPom5Y/5OYaGait6e8qn1rDB3RTqseJ+9yf
 FLVJOuM70N3cWxELdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwXr-1tfiJS44kL-007bLI; Fri, 17
 Jan 2025 21:19:20 +0100
Message-ID: <0354a6d7-160e-4bd5-a173-a4d3483cb97e@gmx.de>
Date: Fri, 17 Jan 2025 21:19:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] efi_loader: Update efi_run_image() to accept image
 and device path
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Moritz Fischer <moritzf@google.com>
References: <20250109150244.141173-1-sjg@chromium.org>
 <20250109150244.141173-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250109150244.141173-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AnhLSeNLKTBc8qV50dzb2PCXHpzqBI6h7NGx/JB3f90LO51/P6G
 a8dkXxf8DIKWzQnOKDXfV3H1AyEXwuVf05++ct0HMB0ksY3w4JnZCngvUlcFweCUcPZYDi8
 bbeOaic/krtOUUdNfutcKbtyB1kepIaCvHNmBaWWuPXbopph2TbpoftCVIzOkLLJFpwdXG4
 vo+NqLEFnptaufBDc3hDw==
UI-OutboundReport: notjunk:1;M01:P0:gcmOUBtBdJY=;s2rSf4I86IowUEQALEgPm9OPSNy
 l9/r61D7WTTRVh+3gTLHj1DOVfd2xikaq85ckxGIMHlvsL/zlluICrroBA7psnCcqHwrbYQB0
 AwQ3OJzj+hskfJuEYs9+zWKwo9GIm9mfqxkG5sWpJcPHnH+kA8W9OXQup6a8Z3QLneCsAsuUn
 KBJ1nGS0cR3bpLEt6eGLb9obuFdg64gi/Z11nK4nJMf1ykqqyQ4eNAnxuBxY0QyQhRkxpaXfl
 6lOD+84UlTgRCIsoiU34xnjneHxpodYI6wT6draMIa0ij9CnSBL1WvkkmsIsoBRtt3A3yb6vy
 tBL8O7pt85hih4fVVWPIivQ1XtAkdIriCzySi7vsbyCf1LPKzdY0P3ibER5CGV8pshB5hdQ7x
 qXXz/oYKK1TFZOoDm8LpWbOA64o9sqfxuoa2FJ89RXujAum/pz0DIJNjW4arJOgKlg1fxCfro
 SesQ5u0ww0iQ1+xjXy2LnvJnrstS0Dy28kjIk2P39l2hUKbyA58g14EE4QN80OnNg6WS3e6pn
 UpbycTe7CiQ0TaXka15+avzarHmy09oqfjzjOCtXCuBy2zJu1+z1RLtqvxkxP/mVMl17IlOnT
 JdE0ErPdzJ/O0cyFND2Q6zbZuAzVsW0QsuLHySY+x+1OMaGCTVKM9pkpY1pshlzeT+DZ/v19z
 CHcqtr8l7XzzRnL71DAU3ldSKFerpy5GrINujRVfn5+FadUll1l8aDxrOkficVj/Tw3I/iAcW
 Q0ON18ZEOVIfWXRNIRs1DoCX2LHlIwm9qUhHlal+t930BIKgKj4+Tx68G7+bjoJwBRNYLBDMm
 kEvRiEr4h0uu6uxiv/118dCUcPtKgYl5gcAzBCA+O+TDTyc66x6Y/NE0tbEhNpCraEGzu2QCb
 8/C7SJ04x98MXZaIO66g+Q06f21nbUbT9B9rqKw7ObCH/v+2oE/YnDDWH02vRhuCcQJ4SnOYH
 7ujCpDevkAMki7KfpZ+5ydUgEayyPKPljSsUx0vrWQnJMYDsPapd/hmYcKtxoOHzOgPa0tlh5
 5VKigrMy3MD+cEsx4rVle2Q7rFUlzq03y5gmS6C/9gqblNZnkyUbTdN58EKqnAkGZRiRSN+Hj
 N/4thTWMB2mtd5cSjAPLqJjyi1kWp70fBxxIKkahWuZ7jEUjOLDa3voQAiB7uqKmKiMNK5Gjk
 8FPgrFWyyidXgcUmPOsHtv94PubAHlAKEdYORevYnSw==
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

On 1/9/25 16:02, Simon Glass wrote:
> Provide these globals as parameters to this function, on the way to
> making it possible to start an image without relying on the globals.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Adjust argument ordering for efi_run_image()
>
>   lib/efi_loader/efi_bootbin.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 428991df88f..e3ac27b03fa 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -157,9 +157,13 @@ void efi_set_bootdev(const char *dev, const char *d=
evnr, const char *path,
>    *
>    * @source_buffer:	memory address of the UEFI image
>    * @source_size:	size of the UEFI image
> + * @device:		EFI device-path
> + * @image:		EFI image-path
>    * Return:		status code
>    */
> -static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t sour=
ce_size)
> +static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t sour=
ce_size,
> +				  struct efi_device_path *device,
> +				  struct efi_device_path *image)

Please, use parameter names that make it clear that we are dealing with
device paths, e.g. dp_dev and dp_img.

>   {
>   	efi_handle_t mem_handle =3D NULL, handle;
>   	struct efi_device_path *file_path =3D NULL;
> @@ -167,7 +171,7 @@ static efi_status_t efi_run_image(void *source_buffe=
r, efi_uintn_t source_size)
>   	efi_status_t ret;
>   	u16 *load_options;
>
> -	if (!bootefi_device_path || !bootefi_image_path) {
> +	if (!device || !image) {
>   		log_debug("Not loaded from disk\n");
>   		/*
>   		 * Special case for efi payload not loaded from disk,
> @@ -188,9 +192,8 @@ static efi_status_t efi_run_image(void *source_buffe=
r, efi_uintn_t source_size)
>   			goto out;
>   		msg_path =3D file_path;
>   	} else {
> -		file_path =3D efi_dp_concat(bootefi_device_path,
> -					  bootefi_image_path, 0);
> -		msg_path =3D bootefi_image_path;
> +		file_path =3D efi_dp_concat(device, image, 0);
> +		msg_path =3D image;
>   		log_debug("Loaded from disk\n");
>   	}
>
> @@ -227,7 +230,7 @@ out:
>   /**
>    * efi_binary_run() - run loaded UEFI image
>    *
> - * @image:	memory address of the UEFI image
> + * @image_ptr:	memory address of the UEFI image
>    * @size:	size of the UEFI image
>    * @fdt:	device-tree
>    *
> @@ -236,7 +239,7 @@ out:
>    *
>    * Return:	status code
>    */
> -efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> +efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)

This is an unrelated change.
What is the point of adding a _ptr suffix here?
We are only dealing with pointers in the EFI sub-system and keep sandbox
virtual addresses out.

Best regards

Heinrich

>   {
>   	efi_status_t ret;
>
> @@ -252,5 +255,6 @@ efi_status_t efi_binary_run(void *image, size_t size=
, void *fdt)
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>
> -	return efi_run_image(image, size);
> +	return efi_run_image(image_ptr, size, bootefi_device_path,
> +			     bootefi_image_path);
>   }

