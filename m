Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9491BCFA74F
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CB380433;
	Fri, 21 Nov 2025 09:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hEDYiKdM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD4B98051F; Fri, 21 Nov 2025 09:41:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34C9801CF
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763714484; x=1764319284; i=xypron.glpk@gmx.de;
 bh=174zxRM6AudNPYQZd10gWvaxxmPU+r3PVu346uBi348=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hEDYiKdMniHIXurCCUV7JR/D4jLzMYxoRiiYQarp1vE22JuKKk9YvFv5qtCDo0Iw
 pERTiAk9UPK4SZ9ed/4D6c1UgZojs5vObPoEh86fhEdmRvYd2UA6PvBZ9ikUCn6qP
 uENPXQRe9g5QjyxLfOk0nUxP8K9AHsjcqJArxyIwDaDuMlDs+AeGr+xMtfpGQLc4r
 li1yGKHQpCS+ay5wVNFRIrxrNXxZ4/XeSLeiY3ujja4NwVdVKFdy5PBHkvgfeMFUd
 64/5whopv90WdV+NXr1SrtR7hMEOKzERx5f6wYwMjoBGR2I9iHaTlPzHfJnnLoxaf
 Uw5N98c7hKUDguRICg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.119] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6UZl-1vTGST2edN-002wUe; Fri, 21
 Nov 2025 09:41:24 +0100
Message-ID: <b60d74a5-8085-4c6a-ad90-bf59dc41e37f@gmx.de>
Date: Fri, 21 Nov 2025 09:41:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootm: fix boot failure from compressed image for
 IH_OS_EFI
To: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masashi Morimoto <morimoto.masashi@socionext.com>, u-boot@lists.denx.de
References: <20251120233851.2726487-1-kojima.masahisa@socionext.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251120233851.2726487-1-kojima.masahisa@socionext.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LigrHntcxHdV8ac5RjNZIRyU7i8UxSiMqbcizX3eWq7vZkZSj85
 S4waZW65E9mfKpHpj3JPdaj7E9KSFRRv/wg6onZK7z2QpFCgdZyqO+PZoX0X5dA4T/FuZWa
 kYz/KoKpHiHgK1gnU/z0/cadEs+5YZxwQeKKgK5SNxqbD0x9KJkZ+T5ULUOltw5f1oTEKHD
 wfboiFxMPFA26V1UUMUiw==
UI-OutboundReport: notjunk:1;M01:P0:xxQ6FitGEGg=;3Wy3hmiaxHinWCR39CkpU/nD39t
 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
 XrkOQDMivF2rZ26kq3oWwqtsbDDaz
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

On 11/21/25 00:38, Masahisa Kojima wrote:
> The bootm command can handle the compressed image, but current
> code fails to boot from it.
>=20
>      ## Loading kernel (any) from FIT Image at a8000000 ...
>      <snip>
>           Compression:  gzip compressed
>           Data Start:   0xa80000d4
>           Data Size:    10114520 Bytes =3D 9.6 MiB
>           Architecture: AArch64
>           OS:           EFI Firmware
>           Load Address: 0x90000000
>=20
>      <snip>
>         Uncompressing Kernel Image to 90000000
>      ## Transferring control to EFI (at address a80000d4) ...
>      Booting <NULL>
>      Not a PE-COFF file
>      Loading image failed
>=20
> To take care of the compressed image, the load address needs
> to be passed instead of the original compressed image address.
>=20
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>

Hello Masahisa,

Thank you for diving into this problem.

In test/py/tests/test_efi_fit.py we are testing on the sandbox with and=20
without compression. Why would the problem not show up in the test?

539         # Run tests
540         # - fdt OFF, initrd OFF, gzip OFF
541         launch_efi(False, False, False)
542         # - fdt ON, initrd OFF, gzip OFF
543         launch_efi(True, False, False)
544         # - fdt OFF, initrd ON, gzip OFF
545         launch_efi(False, True, False)
546
547         if is_sandbox:
548             # - fdt OFF, initrd OFF, gzip ON
549             launch_efi(False, False, True)
550             # - fdt ON, initrd OFF, gzip ON
551             launch_efi(True, False, True)
552             # - fdt OFF, initrd ON, gzip ON
553             launch_efi(False, True, True)

The test should be corrected to show you issue.

Best regards

Heinrich

> ---
>   boot/bootm_os.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index 88f7c183867..ae20b555f5c 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -509,11 +509,11 @@ static int do_bootm_efi(int flag, struct bootm_inf=
o *bmi)
>   	/* We expect to return */
>   	images->os.type =3D IH_TYPE_STANDALONE;
>  =20
> -	image_buf =3D map_sysmem(images->os.image_start, images->os.image_len)=
;
> +	image_buf =3D map_sysmem(images->os.load, images->os.image_len);
>  =20
>   	/* Run EFI image */
>   	printf("## Transferring control to EFI (at address %08lx) ...\n",
> -	       images->os.image_start);
> +	       images->os.load);
>   	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
>  =20
>   	ret =3D efi_binary_run(image_buf, images->os.image_len,

