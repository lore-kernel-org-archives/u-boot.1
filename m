Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615D6E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 12:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CCC80562;
	Sun, 22 Dec 2024 13:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dWpdC9BD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B53A80562; Sun, 22 Dec 2024 13:45:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECB5180435
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 13:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734871511; x=1735476311; i=xypron.glpk@gmx.de;
 bh=YyaoNlCazZ1jvRAdC0WMdLvSRyquWJvbXrMzKT90qww=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dWpdC9BDqhjYeoRMyU2ab/+dHFpt8abnNTzIoChJ7+jj0lrVFv8p4Tm7+i+PdWoa
 e/ebuhH3YstliK3/r08Xk4DEMxSwRirNK5QesIoxTdXrD5+fB6hWDVc1gfougFdB8
 8fes+qTEnDH4kXVt6pyt54DObzD2wmZbEuExd5SKI/ifULUr2nz23LX2TwldC7uK8
 40b0QyHkA6e8YCsTr46uOjE47c12gp7SpsONAyS+XxEMiaWNhFlva0SHu6eOBstD5
 KbEymiCVGYW4Gc/QZE3/g02b3PJvIpZyQgFOIYRQ1Zvfc+j5tN8HIf4/kSiEbJ3aX
 Kh0kMp7gxOkUNQqNNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1u2GRn3f8X-00ePvl; Sun, 22
 Dec 2024 13:45:10 +0100
Message-ID: <4a0a3ab8-d828-426f-93b8-364e0eeb9f74@gmx.de>
Date: Sun, 22 Dec 2024 13:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Moritz Fischer <moritzf@google.com>
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241219023832.1098689-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aireRWQb5joXnGYgfQUKocNP+7hEjcioyO77Y3B56gb910pk755
 vQLp+IMUZWq/Zok3gcNDb6K9TVk+yQlchjda+DBZAD947YOBFuik+338DjXAsxNW6B/JDoU
 E0OOx6uW/kVaKg8IhoGwx0m4Lb+tf6h4TJiIAOAD/dotXo5uMCTM4LAsZfmrefzbEC1hpUh
 BtyD21cMRjFzP3jmyRlYw==
UI-OutboundReport: notjunk:1;M01:P0:9YWoZ1axX0w=;PVNkTGfUh+93P9DC8sh4uKKK/bK
 10HnqsCvC/KNEWu4QGCuUrUTGnFeADxtyFGIHsn7aiglK1YD5G+Zi57MFClmtQH2L//2oJge/
 XRNcLjSgs+Zbx5AVZxbIrmpySuW2XRsOn3YzfYNMEbbmZz2u5TkEoI9upKIg8WORuJkQ/r/L+
 PohJlaotMcWixmpc5/UngCJwhPQKpMxQS2Aa3zrvjb/T4LtSa+fDBZbhz+1hZBfH/DokeeJro
 pxSQi7EKBDZl1widHB1jS0rqkbPRdJUcvjScMFfmjAtNlNB/MaoynzlkF8LEw7uRHJL9qp+HQ
 yh6T77cUiejI6KNqxxtlhwYxBBIhh684olvP3ZyeAQ3aTaDGDhhtweHPrBrWVX4hMdvA7ZREr
 mRUqguaO1zq6246SclWpbxTfyotHEB13L/PCHBzRprCtDrbQCTj5kwt1DS7vIH8Pjmlztgoel
 axE5dFesrFaUH+Ii9VPjNlgcSZLimtuDWLdaTsszy0Y03xSzSF0yBrNsPEFWMBoyYGhUx6VB1
 14S2vHqfItzz2+GNS11onXLvHaFsws62vKzQkFlfm4SqVIPjjzwNedS0FUMuQSw/L9X66xeJ2
 kEzV+x42Ygb1qvb6wxypHpsEoh4hO+oRx0MfvV5do/ZL/w8j3UL80vH39iysGFf08dnrsqgj8
 N9gFFAYp0ptZJJXSjt1XT9YIhsYuBpCMYCxh8cNp1wDHVFXpXlXW8CO8uBp4vmsjm7WhRqtRz
 qLjSWybqA/YIgW8cT2Y79WDa5omprtOzBxV6un2gYWD23ObMOz1XWSEFvO2zz8sg6bio2SaQM
 yBbbhIwIuFvzFmBC5zCXoDFhofYCYHQ0kN4ip1lvDT35YLwM2wjiGsb/2ht9T1i0jJDunZnph
 igfDO/q/r97Hh67n3bazt/XOtcKHTYEE4z39IrOwkrLoTFlp1tOGqxbxGDj/U+Vj3AvJEaCSs
 cWWjJ/Hvsskjk4YPvnLAtp3DHNa9axirQWpLTmPHf/igO3Mta4L4NbPUu0ubVAWWosRf2IV4p
 GbLxg6n5ALS2VPiK7RkxhA7jkbBPQ7A1IKqv8qyIMpDnaJLge/9/bEuJzYKzFT43MzvHaovRd
 VMSo0+Zhegj06cmAS8tVX9m4g2STcX
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
> This uses a few global variables at present. With the bootflow we have
> the required parameters, so add a function which accepts these. Update
> the existing function to call the new one with the globals.
>
> - Rename efi_binary_run_() to _efi_binary_run()
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
>   1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index b42ff3cb4e0..f7aedeaab8a 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -228,18 +228,22 @@ out:
>   }
>
>   /**
> - * efi_binary_run() - run loaded UEFI image
> + * efi_binary_run_() - run loaded UEFI image
>    *
>    * @image_ptr:	memory address of the UEFI image
>    * @size:	size of the UEFI image
>    * @fdt:	device-tree
> + * @device:	EFI device-path
> + * @image:	EFI image-path
>    *
>    * Execute an EFI binary image loaded at @image.
>    * @size may be zero if the binary is loaded with U-Boot load command.
>    *
>    * Return:	status code
>    */
> -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> +efi_status_t _efi_binary_run(void *image_ptr, size_t size, void *fdt,
> +			     struct efi_device_path *device,
> +			     struct efi_device_path *image)

A non-static function starting with underscore? Please, avoid this.

Best regards

Heinrich

>   {
>   	efi_status_t ret;
>
> @@ -255,6 +259,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t=
 size, void *fdt)
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>
> -	return efi_run_image(image_ptr, size, bootefi_device_path,
> -			     bootefi_image_path);
> +	return efi_run_image(image_ptr, size, device, image);
> +}
> +
> +/**
> + * efi_binary_run() - run loaded UEFI image
> + *
> + * @image:	memory address of the UEFI image
> + * @size:	size of the UEFI image
> + * @fdt:	device-tree
> + *
> + * Execute an EFI binary image loaded at @image.
> + * @size may be zero if the binary is loaded with U-Boot load command.
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> +{
> +	return _efi_binary_run(image, size, fdt, bootefi_device_path,
> +			       bootefi_image_path);
>   }

