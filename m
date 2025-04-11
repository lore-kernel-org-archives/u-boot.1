Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358E8C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 06:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E0A83EAC;
	Fri, 11 Apr 2025 08:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="op7vtq+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39A3D83EAC; Fri, 11 Apr 2025 08:31:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE1183EC0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744353088; x=1744957888; i=xypron.glpk@gmx.de;
 bh=5sT/1CX9nq2w/GsxoqI/XNRiYvNfRJIn1MlvfbOYWpM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=op7vtq+L+TUhfhExYMIaJGZZK2D31J6/BYu/otyMqgh1bGbxcS7r4ebTjWgv+wzz
 LZp5fGMXXyJZkhxRx2/Dan8LSDMigZxALi5+v/dRc/SrW4P8vcCQZw6oFVvBFsyf+
 UL1Nl5IkhEsGBnMYzPxmE+Y4OzP+6IDI/Q2b0/WioZAtrMGsDxUpUFMBxk/D2lAUW
 uHT10JE4zjVZlEinoNsBl4FxLqX1ENBpR1YoMPJipzItMKXDGVJjS3DgRX+16X5o5
 F4QD7NsXxaHN406qGWYCZgc+FtxzFDRFFR7EGDzjUO0K6Y5tYBzZqjBHTP4KbAfAN
 AVaJ+ymOWTf8Pyu0Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.163]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC34h-1ttTI50yPl-001i05; Fri, 11
 Apr 2025 08:31:28 +0200
Message-ID: <09f26320-68a0-4ab8-bc22-a6fa20492b06@gmx.de>
Date: Fri, 11 Apr 2025 08:31:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Fix efiboot for payloads loaded from memory
To: =?UTF-8?Q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250323190304.45371-2-christian@kohlschutter.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250323190304.45371-2-christian@kohlschutter.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o0P4ZcWAU7RQBpHtaZHtHcRxaJAT91RT867e//F3vz/OslV+yub
 uLhsTPJzRvF2mlj/hdeQYRDEKZspMfhMAP1zu/VLA7xOVCOfk+6N+lSAFVPwMNZMAz0B8Jr
 tnK6ZUrhaAFMvHiExT7sTwTZZKBlGaFnfzqWrFExNO8skUwHzlxw4BBEjZdLiJZUeGiIoDf
 4yLJQlCStxqDmTe8hXCqg==
UI-OutboundReport: notjunk:1;M01:P0:KlWZK7fpS9I=;Brl9QGtEnR+kG2SmNuGLWZRoc2k
 dYJIAAzf0rBYhC42DsKsi4dThlmm5BxuiF9xsgoyjZ49D3HWcMFpZxOm5PTj9ksjDvkt6lhJM
 6jacW1++XSKaGO/8pJBK8kVBhHDC7Ur75Q5/nQpramNkhZm1WxnBgFNFYN6rqhEjJH70Xnoyt
 CTV6miaRkSc2EJTKFO+wCB2I9W5UpCCHOPbtURIBm/kFRnPbi8MvK5V5rw1usqlHtpiXF3dOc
 6+jCpnD+EszorwreLlqVKwDHcLr9CZVeV5Flv6IS4QNfqbuAu9kvc2WsWTRtvWZcLJmAdkX/q
 7YcmejcMENLxc0EZ37Jmg0GxA3IK/5ZiZbKwHDV4Kh43JtfQg/y7BWTCgHGGloZIPFyp1IWwx
 vAXr4x6SgyS00IBVXeDhXnz+FyBZCc8+BK7bfLlYv16K4Xw/ri3e/pk2t20ssiqK82DT6iCvL
 7z7rH6C/NN5TOp0+bG4JgYrLVZdCofKSY9qw8BojLVp8ZHbwtUkRHmVPU1MCmMtE2bKPMUVV0
 sMxf7Kev3456tjOV/BAS1mf1wui8CPmsfy84so6iAr5/3O6yCdatFlb7MseEGv83b6GZU9yDA
 SknapbmkvVENBkLk6VJA8NLkyNd90IJk1UDv/Mlc01rvqytMULE/w5Cp6ceVcCDddI/k2PMFp
 /792HI10z26+Jfr8n/TObOsrR+wpcj0sLQ0JYEe8muVoZ7DkPcKtp+Io+RHBhhLt9271DHnv3
 myepI1q9vzMs9WQtnpQrC0JfP7qxXRYzLynrkE0nsUTtN7Lf1PX5MLLMQPpon76aUZQHqrCUt
 MC42YfCnCZ1OokADDjfRZfYFl0wdDmqN0EkBeMh3O0eKJhK4x1jWZAWlZ593d59maY6LMOkfl
 qrFAE7PK/ZZAgolcgtZpFm01RjefTOowWl+hVt4qPBDZ0uWbtfWrBTBDGnrAjpezFvEeKVThL
 Lpi7qgEr5UbDRCnaQTQIE4wFM3xsQNvtofRoEqnnm4qRI7eRh1k1hqe1lm+8h5LB4oCGXsVP8
 zwWPxg8NU34KgI13i/9y77gacjP1ruJMjsFZAzRygXL73J/3H7m0Qa5V47lrifpk2AgOxt90m
 /ELpGBap+ZI5IeNkJ1Y6AqfxreV11ybw/XVa1iotSwlv86rdL2opDZFxc1HqEbUXsLtLk0wiJ
 WfLD0Onvfi1yVVPzlOYPzGhLiUbVnLfhgA1JOeHHMjMaelgjlKsAokBOGnrP8QZ+1U9/q60qE
 V9rqJ78IxyMbUwubuaiaPSnmrvnrKGoPKanuilHwry+HTPTdHphnCBvtJhiKSUV3rAIaB5tm1
 yl3f1FcrOYxdn33bi3qrwOi5jnJdh1gxGS8tc2L842Q/uwti9al9sKheOUQ2ByYbrWSWcjvmh
 CXDDZQExocBM886gh4FBCUfh0e3UA8bJXN7dIc9CVjJr99E5NlgBiDh7fPkKp8VzcVovlbYtR
 JSzcu5TLRIvCIEs9RYX1Hd0whg85zb41qN2WzYrLr7OZQrX6NOEMsKcqhbkGcJ5p8Q0a3BH4E
 yslHxpr0kqUw7OmTfqZb4W/76aXJ89P1Q0TdonwuqHYvBy1mJF+SxuS43RuNaH3lsCpHSXqfE
 Kh6bBAQCpaoJ7VVyMfjoP84KAvsZLm2E+4tLaYcGFIZQUrKXdOS7jElqMi2SZySaerVU5mx6w
 aXiR6ngBQ/VsucvcU9LK6lTl4itOweO1L8zgXGG2lOf23Pb/ogYB8+NvcDykg6tGXHIY46l37
 TRM9HO+v29LiUou0zwIxgSrXKHk0etHi9LjK7pxjrj9FJ5HoqdaorxKojn71/0TU6fSOrJZ5L
 cQZxTJUd+YVvM8zNzokm2Tk/1NkA5nEqIGd4ay7fW0b9YWdau5oLsLdD3QWlSDVzy5kLy9ykL
 K8fykLBkXDxsWa0d2vPAscISNY2L80K0s460jW3KKjLRuAXwXakZZX3NFGZZMk40ZNvCKPbmZ
 psYZyViG7mIHXqq6r8YRXWAbICggrn1GnKGG9hV9qgKkmVoyS2NqKtc2zPYCdP11ngYVPpnYr
 gSGiC6PSxTga8EfD0JQXzjFPyLpJ/3AbxaelAtmbY6Qoxx//L3Cbu/Ab2wioPFzExJBULKgxO
 JySeWH+xnJ2+rgOEAFGAe62cb11gEZhJQOrprXSyK5i9coHTSMQlXud48LL7lzotA951o/xPh
 XMTiK+LCdHA4VyKhp5Ac75nD9Ogi96c4qf40rA767tjEhxusI/EsjScZK+pYDsKLRqv4IVTdr
 H9aNCHBjgqE7Sk8FU0ILCEBQajLZMAGsuJ9FhQ+OjNeIlQh4DKAqHGg/+xkOcxcYgRIeXfFQf
 AHPZ1C73MhMDxPhY1R5KW0/qxTpdRuzvVdjggowhNazfLyn/3dvI9rhYvu8Ab2znMs8dvoBH4
 Tnja5aJVCd2YzNcb+t/K0lBOrDzNxO2WGUKYI7Fez/NvVgQbGKTo2CRMOj6gcrPImUcara1K9
 17xDV6BuMWYn67izfD/X8Zybn6UocaPHlHqqno+iNdi4RhN2Qh9rXtTGbP+fVYIcJoja41dWj
 kDcAeCpYnThvPOk6H6I5VbpHDhGX0Buk39iOEzPNGuyRto//xC8UANihNSxyiPAU+ugR92901
 dBJSNu7+ffFvmYSY0Vii3Gvgfoi+Vo1vafAKCwWuOSznlMPgBTHwZiJKnScnBFsk7HlsbGRmT
 t5o2yEZFLR/MIMigS97CrplSEeov78TG9nVmp8k2DS7VtfVKnTMrH2UkRqhBHt90SHkkQLDET
 Q1PjiCbXgz6kR3uFf2zUQpCahm4QFHGqJpFDBEIzG3Nzh6f/vY5tcFFbXDud5HwXt0V98tWg7
 vUrema4EezrJxGSJZgrap6BN3ztD3H6Enl+Ryo+KJYSIbXBhWGth6ov4CUdGPUB/olySbX1OG
 G5scIFogyYinGXM/NSVSVPamk6NExdhOBGsBNOT12ome2kDPw7R7UXqkERe1fNsvVYp5CdvBp
 TXyN4J71PcI2I8rR2DNlfZvKd3WCjM+KoPj3ayUg2/sr4Qij6I+K
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

On 3/23/25 20:03, Christian Kohlschu=CC=88tter wrote:
> Calling bootefi on an address that was loaded from memory (e.g., cramfs
> or SPI flash via "sf read", etc.), currently results in the EFI binary
> not being able to access the EFI image device path.
>
> For example, iPXE would fail with an error "EFI could not get loaded
> image's device path: Error 0x7f39e082 (https://ipxe.org/7f39e082)".
>
> This is due to an incomplete special-case in efi_binary_run, where a new
> device path was created but not used in all required places.
>
> Fix the in-memory special case, set the "bootefi_device_path" to the
> generated "file_path".
>
> iPXE will now boot, and report the device path as
> "/MemoryMapped(0x0,0xSTART,0xLEN)"
>
> Signed-off-by: Christian Kohlschu=CC=88tter <christian@kohlschutter.com>

Hello Christian,

Thank you for the patch.

For future submission, please, use scripts/get_maintainer.pl to identify
mail recipients.

Best regards

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


> ---
>   lib/efi_loader/efi_bootbin.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 10ec5e9ada3..f78cf972228 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -268,6 +268,9 @@ efi_status_t efi_binary_run(void *image, size_t size=
, void *fdt)
>   							       file_path, NULL);
>   		if (ret !=3D EFI_SUCCESS)
>   			goto out;
> +
> +		bootefi_device_path =3D file_path;
> +		bootefi_image_path =3D NULL;
>   	} else {
>   		log_debug("Loaded from disk\n");
>   	}

