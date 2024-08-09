Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85155C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 17:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB46488A2F;
	Fri,  9 Aug 2024 19:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QUzlrzu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E5C88A6B; Fri,  9 Aug 2024 19:27:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D814B885F5
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 19:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723224425; x=1723829225; i=xypron.glpk@gmx.de;
 bh=DWE+MHKpkf/cyO94R/o/vLUpPoR5CIvJtZW2hPtXXdI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QUzlrzu8yfNJEHprQePtNfF+Gd3IQJ/WWCt5+hxpuVYW5Kd2dKlzZFMzicqJwJGI
 uZ3nbM7p+ZPAbazlOz9njoc1G6k8tBZ5+N/N3mcm5q69C7ZhK26ONyPmmLMvoHvKG
 K5uNbjCVAOm67lvhfgXDWomvsdsPtH+YX6KoxcP081fkXCJgFZXMT0d/yfSU+mRML
 kiOZtRqO7xVdhJMI0ouG2qP4VrV7r6fTL008aLn7j6vaM9kaUGeLX4nZcaoFnj5Em
 laFtcUZ1fssDOLYTxiE1S5PLZ+87ygLkr05LirL7RC9aPTMmwAlvR/rXNcujIRgkO
 oF7yGZ4xF9lF4d9p8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp9i-1shvwz0wu4-00YMHZ; Fri, 09
 Aug 2024 19:27:05 +0200
Message-ID: <4594d522-bb63-45ee-b660-0130ae55d341@gmx.de>
Date: Fri, 9 Aug 2024 19:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] efi: Show the location of the bounce buffer
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240801173637.1071068-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fptGBro5svAKQBWf7p7je1nZpH51jThK5Qf7Hy6rhJZNcBoUXJU
 em6NB4xhxIig7NJ1yl926q3M4qRFRQzeXVkyJlnHOSpgATx7nyc1U/QwdK0D1fSh1+ltQZG
 TQfbnonTFhdgXRhaagAyCLjcyGRic2pL5TPVmsqvXY43RAxfjM2YjYcsa9bskzb+rzHx9xA
 vtSGGRhAMkjXJaVpJjcDw==
UI-OutboundReport: notjunk:1;M01:P0:kIQv2uO5L7Q=;ZlUUYT+ldf3Y8YnqPFl5rGj4ymp
 K8KDVbT02Bq7qcbEQI8h1JO3CrW7dBD87MttCeW4rjCSh+iQ5UxWrOR6nNag4xzTt5+2FRrUG
 7MH2rkoWqyWn47DCotGBgsCd1dbPI8sYr4SKsy96v6EScHFvnRbt6Y18aHX2KMtrSDU9g90Lj
 76LajuBo3VRrQc2ex2sNZxpMOcuIF88k2uLf3KnKAJwl7pSset5PYlavL6bXS9pCUvnaHaMiv
 pC9lUhaegMagHcD1oxT9TIh0RQZlOkyfeQoTPkvuRVrwd7gKDB4r1w8TWcRvBkHGRjQy4/vPn
 N1sRDwGd5WhTe3Fy9JLcB54FslWVQHIwmERtamgAJ5wFIkjtL8p85Lp6pBRqLLyClTOjcKwOd
 cZeiAE0F0bxnJzNexbSvj7Z/7scwuiGcXvvNAErtFofB1uhHbnYigvROoKdGPNYbfu4hJwWG5
 wIU13SG4lZSkcr6Cl/aRKMgNmmDbr1LWLkAEDUb6qb3IZ/JB5BoiRFBz2GfI/BnnYviZ3dKWa
 6EdBfhx/n1V0ChXnstZ0q2MOJGcMxDhWjCzJr70otp8Vcu3rvk/Mp1Kr2IwSvBE4t1zk76//h
 Da41qYt9uJr2JRbbDfctbvep3bg9qHrCiZxmMvwtUSk2edbdOVSik3K+EtwfwQ6rkUmMXWA+M
 AFE2Ex6DDFq/o+O5D8GMWGVmlOlo5xL7o2jexVzqD4d3vH2ySgm7hgtbdkjatQ1bmTmWi1MfC
 6aF+RJblhl/KK+oDuwESAv6g66CKfksQEeMjcZNB42IyrkqmzHvwVXfNQb2v6syN4rbkXssWr
 /6YvMSF0r2TFADFnXnbq+5NQ==
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

On 01.08.24 19:36, Simon Glass wrote:
> The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is not
> clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
> lx2162aqds_tfa_SECURE_BOOT and the like) use it.
>
> This feature uses EFI page allocation to create a 64MB buffer 'in space'
> without any knowledge of where boards intend to load their images. This
> may result in image corruption or other problems.
>
> For example, if the feature is enabled on qemu_arm64 it puts the EFI
> bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> 1088MB. The kernel is probably smaller than 27MB but the buffer does
> overlap the ramdisk.
>
> The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> version being dropped. For now, show the address of the EFI bounce
> buffer so people have a better chance to detect the problem.
>
> Note: I avoided converting this #ifdef to use IS_ENABLED() since I hope
> that the feature may be removed.

EFI_BLOCK_IO_PROTOCOL.ReadBlocks() and
EFI_BLOCK_IO_PROTOCOL.WriteBlocks() are expected to block until all
bytes are transferred.

The complete file transfer is chunked according to the size of the EFI
bounce buffer.

Taking care of alignment issues would best handled by the block uclass.

When CONFIG_BOUNCE_BUFFER=3Dy, bounce_buffer_start_extalign() uses
memalign() which limits the bounce buffer to available malloc() memory
(typically < 2 MiB).

I cannot see how blk_read() with CONFIG_BOUNCE_BUFFER=3Dy will work if
blkcnt * desc->blksz is greater than the available malloc memory.

Shouldn't the block uclass support chunking?

Best regards

Heinrich

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Drop patch 'Show more information in efi index'
> - Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
> - Add the word 'warning', use log_warning() and show the end address
> - Reorder patches a little
>
>   lib/efi_loader/efi_bootbin.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 5bb0fdcf75d..9779dc09b5e 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -211,6 +211,15 @@ efi_status_t efi_binary_run(void *image, size_t siz=
e, void *fdt)
>   		return -1;
>   	}
>
> +#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> +	/*
> +	 * Add a warning about this buffer, since it may conflict with other
> +	 * things
> +	 */
> +	log_warning("Warning: EFI bounce buffer %p-%p\n", efi_bounce_buffer,
> +		    efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> +#endif
> +
>   	ret =3D efi_install_fdt(fdt);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;

