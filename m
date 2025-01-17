Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572AAC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 19:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E15F380423;
	Fri, 17 Jan 2025 20:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="i/gU007Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A7758069D; Fri, 17 Jan 2025 20:55:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2DC68036F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 20:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737143730; x=1737748530; i=xypron.glpk@gmx.de;
 bh=+VRH3QokdEjk5JE+X03kPQ48CcV/SBcQ4XauYOqRB0Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=i/gU007QFBlIkUzyZeqfs75sQfLW1Ow41rDNXC0PNaEDtvKZlVxOhYOxVQMK4W7B
 kk6HSxhOSA1ovEZAVq18GwmPdrlbQ2TmfR3s+t7OVHwhYwLfudIdsZexSymaCghtQ
 gKOEsSZ6ow/PjtnGBZSS4bYPJnmSDjSZTRd5tmWA1q5obkrB9RnbtaNL+oG2/jfHv
 lrUfWPxYVR5YlcFbKuwH6lC63EI4qeG/eFJwI2G8KFZS+ovNfXgAnQhVZoAQFoIAi
 dosEmemxxN+m1tW2lW5yH9eyfWiIohb0ZEPTzZ3Bn1Z0F9743iZkvpdebUAJ4x1yC
 VNfQKp5aoB5UkHxWQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1tmIYl2Fnd-0059OH; Fri, 17
 Jan 2025 20:55:30 +0100
Message-ID: <cac9da74-eaa2-474e-afb2-923aefa91111@gmx.de>
Date: Fri, 17 Jan 2025 20:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250109150244.141173-1-sjg@chromium.org>
 <20250109150244.141173-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250109150244.141173-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oxCp/IcfUQMWTGhg8pI2IyNCgTUfpnredC8Si89IT39R95FuxcR
 q/0SSAnj1a7sUoRqHPNRaCS0I3UEVqW09irdFglow+zQeqGMauAoOqU/a887BiUehpldgAJ
 CybpKuL7r9g+6mSoAhuK/kGcK706ENRIeadIln5RhDiCN18wilwKhRr4NgInUToZmKHZj/Z
 shcEHlTIWcJCHmkJeIByQ==
UI-OutboundReport: notjunk:1;M01:P0:YU10/ME0FBQ=;hmJ+ldxY58zXmjR+XaZhwa4GTLc
 7q3fu0hdcGUbGBq0zIuiFzXOOwLCSU/R+RdC3qY79Dz1FPbRXTn8qR135VISD4+NuoNyGqQhi
 0iKuDMtUN/h/8wSx9iLO0vaqW3qiM0ldXBQx2FODrc0fOmuG371cRpnMjsuGyvJZS//JedfrI
 oVbX7wBXraZUloJ5R7Rdpyqre6o0mfyvXp+tjJMvmjYNrpGF2YwnwcSPw2WvsRmhB/5BAE7OB
 BhJo+2/BckKZVK8dcfwDOZ/xAOJBZszE20CN4ikWkIRaC83RfF49qp+o0crfTFiUk1FZ9+108
 RqnpS5BGnI5F2z0tE1z6kBbt4iuubuASthSC0WD9xOJS6GsW2WtCbiB33hJOsXruqQdCTK7GW
 sA38q8Rx2aPFOPxMkxIqHtHJMpgoeD558Wfl7kd0myfl7dV5Ftu59lpt4IoW7NawAk/bvCnDG
 N13+5BhceH1vGir74uNDC+mBAgqXX0RVs2wiKZ/LPwUAfL6e89xDT1W1V8fpj4XdV/4YGFWOj
 lG7Zf9Dn7+RKjkAGH/S6D0UFeKGG86PdxH2VDTPZBvjwArl+IKMiPvRZ2vflVV/doGfogRyHA
 c2W0xN+4nbXnv29mJ46pt4mQGGNi9T+Mt1PWNTOdR5nDmFUamCIFeq4W+xx4EBX7kGq1tyBQt
 YFYf0lyCkmplNpdd1sccJPDT9I9KpHSMos9bGfKXaqPCGUjvPk0ciqnHYTkdoGfQCmigwmmfN
 lul384+hQP5WmZOMDR8S90ifXUSUSdlPNEPzO1jmwCiwKXgR+sw+yHQM6wrbB+I9i6+OXk0SP
 Pg9C8fPrtovKTwlElEHeeDjC4MqNVLODWR2+XEHW+LUt7TuGE3H5X+/bS/lF0Mdm+bS49f/fQ
 msA0EXGrLnLY6tGISUWe90LsU+mXDEm96C6cfxWYPAMaHz/9s19Nmo0SFcxdqb53/6QcKd0v2
 jAmZKlCTrixwOosBBfq+HpQrzkoCg7SSs5/D8cZrk/SWudb73iNqrllKyiB2rzz1aUYxOyvYp
 r7wbclQ8jOGVhYhF/hmANuh0EjkkVEdf8Wjmi7IpKI8Fz+EoFbQ0/c2ujvScSYs8yhgeA4jBz
 OlUJqJ39Dbj4W3zU8yD+tf24MDA7HweMJ3dTbJAfe27b2/Xf6e8ZDBVTHrN2moo6DwPgIgN1e
 WzpPItqzANCEQXDFTbIiOL2qJJTqbydNiv4zba9nyXw==
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
> This uses a few global variables at present. With the bootflow we have
> the required parameters, so add a function which accepts these. Update
> the existing function to call the new one with the globals.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Rename efi_binary_run_() to _efi_binary_run()
>
>   lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
>   1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index e3ac27b03fa..6cbc5fa050c 100644
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

Using functions which differ just be an underscore are confusing.
efi_binary_run_dp() might better express that here device_paths are needed=
.

Best regards

Heinrich

> +			     struct efi_device_path *device,
> +			     struct efi_device_path *image)
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

