Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1051EC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 16:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5448587876;
	Thu, 25 Jul 2024 18:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EIWpxnfJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F16879AF; Thu, 25 Jul 2024 18:38:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872338692C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 18:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721925496; x=1722530296; i=xypron.glpk@gmx.de;
 bh=jpdiS6BFRA9C4Tzpk2L5eXrWNGHPkO991YoyVNhSoqk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EIWpxnfJFulLKnDfcl0byZIc3eydoSUaGcB2J/RBmfz3V+PNSb2NvCM8/QeDnQ4X
 way9lS5iGtN/GFgj5edfYwaaFPM2Lo2oMjUlNZhFvIgl+3f8gAPAB74/1rqGNtnfy
 7S51PmriMb8kXqwX41In66DTA8Z2iA/pToAS5slE8/UKdqPtl8COQc05xlt61/Z3B
 rBMPKqSzZ5adLlKuZ7TOtWNf62jLCFfq3o7mo2xEj9FvNbllfWAtZG6u1xIW7Zpw3
 NlFd3awEb1f/CTL5HfCks1+9DA7GswODINOEUTVZc5Ob0XQZxdvSjnGw/jKC+y2au
 Dt02QjUYCjdkfBu1wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1sZUK63lYf-00As6J; Thu, 25
 Jul 2024 18:38:15 +0200
Message-ID: <c8b706c9-43d2-4f9a-872a-b2a2089d8b59@gmx.de>
Date: Thu, 25 Jul 2024 18:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] efi: Avoid pool allocation in
 efi_get_memory_map_alloc()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240725135629.3505072-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bYl8u5VKOWIUf2PERMj28nP+VAGCfN6JpH/A83kI039pqaqSStI
 AMKA7y690IqM6obfV4F2tKci+quHHWAfONSu5JanXyXbp2C0zMrlR+CAt9rSwVdvcrCStGY
 V7RFX4f3Vb8nit2OtvNa13n136nu09NLGpWCqdnHFDfo6uz70UMogjF7hvJD5gzISiH196L
 +rLr4UPrC3V43qqEdoRZA==
UI-OutboundReport: notjunk:1;M01:P0:jI4yDy1CaS0=;HNQC/jRwbf3kybG+06A5+6hCwVr
 uuZW7i3iDXVVED5lZrxSD0KUMUVVcw1Gc15e+Or8n5RJ0drf5jHvbSsixSZj5mqFEwW/vxLYK
 biNxJZ3TKxxN/H2jCUdm4Kosy0GbMkP3Mc4HXaSUaxdhINlG855w9aCMlNQPFBRgdJLet0cOD
 RR1vX36oXTHVqkwrls6C527ydTTXYVYWUaG2IUTmKutpSCYG1xXvfHnggudC22LsCsaOPLMlK
 4p+9vovibXgPrJt4Fu03TinX5TNB2wwLM41ibGQMNe2ENK5l9rO27EmfQG5AsSUBUDE5Ocuwk
 wwlonmRqco6eS21F4P8z1QbbeNd761IgxD41n/vt/8MwLf66LdWurRjlsHESak3IzV+3kbXrO
 X5saqZ5VcFWpZxKfJy42QdTxjwGsI0urPTg96lLzUluPWg3Mc6L1MI7Nr3g/TTYNFhhfW9Dwp
 RgpulYACjtVEftYUpXUV1wLYtfh3xuy5dLz6z4b2oujKc0AYOXLCsjfvhFzxfmjghmRvslx+5
 6W6VRDkMXF/ngWMLOJ6GoTsIiB/28SmzvY38nuRYKV6Vwhg8H4G8nyuVbNOk1XRmBdxRSYNq9
 AHsQf5Cf84RylncaPYYmN400Tnk3JhktpE6OTVCMACH0P7G8ZKNqJcYbadGrpowIDWuGPstjq
 hm+j3wTXFoiUoKI2+knesc9eQDwHjcF8xeF+ZpQbAzKWlPvGISfNn0gsgN71uWm9WKVeSvqk+
 EOE6kcvlEHbR/8j98jUqUq2p/uY6eujBuXUPiW8ci0oZD237hksswCUbx+qgNtV0CA57VvCBL
 v7Yn3FZ0jVV8+5oA0Pi74f0w==
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

On 25.07.24 15:56, Simon Glass wrote:
> This function returns the memory map, allocating memory for it. But it
> can just use malloc() directly, rather than calling the pool allocator.
> Update it.

The size of the memory map may exceed CONFIG_SYS_MALLOC_LEN which tends
to be astonishingly small: 1 MiB or less on many boards.

Best regards

Heinrich

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/efi_loader/efi_memory.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 087f4c88cdf..2945f5648c7 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -850,14 +850,13 @@ efi_status_t efi_get_memory_map_alloc(efi_uintn_t =
*map_size,
>   	ret =3D efi_get_memory_map(map_size, *memory_map, NULL, NULL, NULL);
>   	if (ret =3D=3D EFI_BUFFER_TOO_SMALL) {
>   		*map_size +=3D sizeof(struct efi_mem_desc); /* for the map */
> -		ret =3D efi_allocate_pool(EFI_BOOT_SERVICES_DATA, *map_size,
> -					(void **)memory_map);
> -		if (ret !=3D EFI_SUCCESS)
> -			return ret;
> +		*memory_map =3D malloc(*map_size);
> +		if (!*memory_map)
> +			return EFI_OUT_OF_RESOURCES;
>   		ret =3D efi_get_memory_map(map_size, *memory_map,
>   					 NULL, NULL, NULL);
>   		if (ret !=3D EFI_SUCCESS) {
> -			efi_free_pool(*memory_map);
> +			free(*memory_map);
>   			*memory_map =3D NULL;
>   		}
>   	}

