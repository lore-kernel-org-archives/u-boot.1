Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78718E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 12:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D4580562;
	Sun, 22 Dec 2024 13:35:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PkYFons5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59FBE8056A; Sun, 22 Dec 2024 13:35:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3591780435
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 13:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734870947; x=1735475747; i=xypron.glpk@gmx.de;
 bh=h3m7haXMH6NUbe3CsHlpVEQpFOWpp6aE2IR8FfEd03k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PkYFons5kejdc7NjT88jXfUa2F/6uOLL08qQItzE2lBtDQCVNqRxoC/3RUgI9yvW
 JoChbedT0S5m/xiRMTdHjR4DZesywGIHJp6kmNqSXYG6HbB5DGP02L3VVQFD7axXP
 fobuYtje5bHJ3jQbO1fe3losRRQ+kKBVeW65627sUT+5KEoDmM0SXzczFyaKaQVd5
 UPWrvleCjHqfgrWEWn3eSTRFZiwKkpSb5g1nMXx+Fz6fujSxAs7t6KqCSc1+i5NBc
 4jVcUStn89QqguVqSGD7j2TgClepLethNQBlbSB4cxXPZGr/HnVNlykPEADCyeVSM
 vzfs2DGnmmDFBu3BZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1t2umT35xu-00XtPf; Sun, 22
 Dec 2024 13:35:47 +0100
Message-ID: <d8931ed1-92d6-4843-9e9d-7aa1751bb116@gmx.de>
Date: Sun, 22 Dec 2024 13:35:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] efi_loader: Refactor device and image paths into a
 function
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241219023832.1098689-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vIxCVP0juOV5cq71IKQOKC2anylI5rQwGlgermcELUpxcHvRwmR
 vrF1ilLcxs3l782nDbYd5FDMnCL1Op+hdSMiH8AH2EhHMMYMWL7vIqvl/Gq1GV/aMT4tMOE
 zLgjSTGP92nyC6DCz8oAqMREZnDaLxluhlZhQqqh0LirOo6S2vHYFwegbun0nyLc4mr7FP/
 jN6bRpmqbva1aJgrStF6Q==
UI-OutboundReport: notjunk:1;M01:P0:/Z8JIRG0mb8=;2Xo+I1Isnn3HapekyGqmt+N3WUl
 7klk5m0U8NYMceH2322z10jJxgjeldH+n8/Xi7m88b0iFHgVZmi+9OVOT1kl3NWQPmPbwFD2R
 kjHx6zRTywXTsPYKdjr73tU7i2p7rueQ7HoOsnDIBYamJwctDUnk7XbKiRcnXp0lIXPQPigtq
 dVPqdeM5uChWXuXPXhBU1p2dzNuPEkiMlGbG6qTMNOhuPZrBKj+vUl2YgL2z0oLCNOp+MvVwo
 LPmZAby/tbWnOK1Z0r3bHdNyi9sCTC5cBDi9nwuqeOQtFfZZaA5OEYAT+SRRf0ApQ6P8OcL5q
 ZLzDSnZqHHC5be/+CgjaDDVhDxH42p+wKFkjeq08KcLO0FMXocqP57fF+kDBj8EGyLJ4DobBn
 1P0o649XWBYq3nQml8cS8Y39rHmIBJw4+6gLCnce/F0Z5EDXiRsVDuQetXsuSbPIyuIWVmvrp
 jrqmY8nRCDo4wEiAq5ia/Pbdl3JdIHw6GqUOPbBwHVO8ghiVyjjTGXSoatdsaSjQXXAUJHaFd
 0Wfag+KYJyOriZz5/kEwwrdckxQ/T9xeDQt8zv9giidOo1nzLRK1bdD8i0o1QTUghm0EJK6/s
 fhnQsQJnvDgNI0vOylDUuBnSBjoHG1DxMeUuEyioAd7bkmF9BAVnsb4YT+1c8EFqhGqWuxtK5
 ZCI5xgX3ADAnqBjgkWO7TjP0Mp3I/N5TqQH3OWCILwBaOXjZxF1imRUNYozxCs40XcZn/uKzB
 y9HOkU5s24zbxd41pG6lm5D1kboCsWl6LP5dH3db6KJfp0v74wI64jOD26dglcmPtTjIDVWkS
 N7p95p2mszmN/QWdRqY7J3G/JBL5FUprxgHgwnoevPhsorOGIkKoJshDbpjE+sEsR05D2GRFm
 8s6jZQJ+YvZAsPe8jztq+71QI+JXfAIvOZOpjgiIhItW9DGBFaS3pGA0SWkkwAXxz6cEgC9lN
 lchcb22BzLCu1nrs28N75m9BiZ8F5vqPHaFvUWt2mv0PNxqQgrX6Ptvfk4zzcz/oPTorFMtuc
 UXt+1srz+M95oPa02Qb21ANuVhoqetTMrBtCyZ688mEG9CtE+l7J1ST4qk5DC1Z9l5ALurZmS
 sc2GKXORp9X/8PhVmJ8AL+ku9YlRjn
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

On 12/19/24 03:38, Simon Glass wrote:
> Move this code into a function so it can be called from elsewhere.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Make calculate_paths() static and add a comment
>
>   lib/efi_loader/efi_bootbin.c | 85 ++++++++++++++++++++++++------------
>   1 file changed, 57 insertions(+), 28 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index b677bbc3124..5016ba7e225 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -44,12 +44,64 @@ void efi_clear_bootdev(void)
>   	image_size =3D 0;
>   }
>
> +/**
> + * calculate_paths() - Calculate the device and image patch given a dev=
ice

%s/patch/path/

The description makes no sense. You cannot derive an image device path
from a device.

> + *
> + * @dev:		device, e.g. "MMC"
> + * @devnr:		number of the device, e.g. "1:2"
> + * @path:		path to file loaded
> + * @device_pathp:	returns EFI device path
> + * @image_pathp:	returns EFI image path
> + * Return EFI_SUCCESS on success, else error code

This would not work with Sphinx

%s/Return/Return:/

> + */
> +static efi_status_t calculate_paths(const char *dev, const char *devnr,
> +				    const char *path,
> +				    struct efi_device_path **device_pathp,
> +				    struct efi_device_path **image_pathp)
> +{
> +	struct efi_device_path *image, *device;
> +	efi_status_t ret;
> +
> +#if IS_ENABLED(CONFIG_NETDEVICES)

Please, avoid #if. The include needs to be fixed.

> +	if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
> +		ret =3D efi_net_set_dp(dev, devnr);
> +		if (ret !=3D EFI_SUCCESS)
> +			return ret;
> +	}

This does not fit to the function description. It has nothing to do with
calculating device-paths.

> +#endif
> +
> +	ret =3D efi_dp_from_name(dev, devnr, path, &device, &image);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
> +	*device_pathp =3D device;
> +	if (image) {
> +		/* FIXME: image should not contain device */

We could change efi_dp_from_name() but then we would have to concatenate
paths in create_lo_dp_part().

This does not deserve a FIXME label.

Best regards

Heinrich

> +		struct efi_device_path *image_tmp =3D image;
> +
> +		efi_dp_split_file_path(image, &device, &image);
> +		efi_free_pool(image_tmp);
> +	}
> +	*image_pathp =3D image;
> +	log_debug("- boot device %pD\n", device);
> +	if (image)
> +		log_debug("- image %pD\n", image);
> +
> +	return EFI_SUCCESS;
> +}
> +
>   /**
>    * efi_set_bootdev() - set boot device
>    *
>    * This function is called when a file is loaded, e.g. via the 'load' =
command.
>    * We use the path to this file to inform the UEFI binary about the bo=
ot device.
>    *
> + * For a valid image, it sets:
> + *    - image_addr to the provided buffer
> + *    - image_size to the provided buffer_size
> + *    - bootefi_device_path to the EFI device-path
> + *    - bootefi_image_path to the EFI image-path
> + *
>    * @dev:		device, e.g. "MMC"
>    * @devnr:		number of the device, e.g. "1:2"
>    * @path:		path to file loaded
> @@ -59,7 +111,6 @@ void efi_clear_bootdev(void)
>   void efi_set_bootdev(const char *dev, const char *devnr, const char *p=
ath,
>   		     void *buffer, size_t buffer_size)
>   {
> -	struct efi_device_path *device, *image;
>   	efi_status_t ret;
>
>   	log_debug("dev=3D%s, devnr=3D%s, path=3D%s, buffer=3D%p, size=3D%zx\n=
", dev,
> @@ -93,34 +144,12 @@ void efi_set_bootdev(const char *dev, const char *d=
evnr, const char *path,
>   	image_addr =3D buffer;
>   	image_size =3D buffer_size;
>
> -#if IS_ENABLED(CONFIG_NETDEVICES)
> -	if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
> -		ret =3D efi_net_set_dp(dev, devnr);
> -		if (ret !=3D EFI_SUCCESS)
> -			goto error;
> -	}
> -#endif
> -
> -	ret =3D efi_dp_from_name(dev, devnr, path, &device, &image);
> -	if (ret !=3D EFI_SUCCESS)
> -		goto error;
> -
> -	bootefi_device_path =3D device;
> -	if (image) {
> -		/* FIXME: image should not contain device */
> -		struct efi_device_path *image_tmp =3D image;
> -
> -		efi_dp_split_file_path(image, &device, &image);
> -		efi_free_pool(image_tmp);
> +	ret =3D calculate_paths(dev, devnr, path, &bootefi_device_path,
> +			      &bootefi_image_path);
> +	if (ret) {
> +		log_debug("- efi_dp_from_name() failed, err=3D%lx\n", ret);
> +		efi_clear_bootdev();
>   	}
> -	bootefi_image_path =3D image;
> -	log_debug("- boot device %pD\n", device);
> -	if (image)
> -		log_debug("- image %pD\n", image);
> -	return;
> -error:
> -	log_debug("- efi_dp_from_name() failed, err=3D%lx\n", ret);
> -	efi_clear_bootdev();
>   }
>
>   /**

