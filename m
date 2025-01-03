Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08001E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 20:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 435A38035E;
	Fri,  3 Jan 2025 21:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tiErZWTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23038039B; Fri,  3 Jan 2025 21:21:01 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C8B4802EF
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 21:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735935659; x=1736540459; i=xypron.glpk@gmx.de;
 bh=gzJrI2SFltjYKT+aL9js1VMm6RSWSKcELGBtUcvYzpg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tiErZWTRpi5JDAI1+H1SFCpLN6uf3hOGPjXToGOZDLCkXvLIyjFXoliCmK2iitMF
 nx2eMn6Ej+d8gMFRiIKEFXs8RxTakapzIV3dXL354oSwJLNKZE2ValovKCpkuuw22
 WngZHX3BEnQG+ki37M7Cx03DQU54kSjm+IaINe789T2GiohT8iCVs2QEHDTL4tUYe
 985Ksd1758XLzVKTHgzBaobMInOad1xSSupeZN+Cy0L38JRQXJUDCLtnfRVgqpjzk
 TMAUX8WrhS6BJNdEenr/N9CZ2r/BR/UFyoIQOR8r55S9eQ3385Z0ptRCJfWWCyGnM
 L0CuzYBU57a5qJVx1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma20k-1t05Z03RCu-00Wn8P; Fri, 03
 Jan 2025 21:20:58 +0100
Message-ID: <5b2795ee-9c6e-4b42-8657-841105c0981f@gmx.de>
Date: Fri, 3 Jan 2025 21:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Fix section alignment on EFI binaries
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com
References: <20241210160150.244773-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241210160150.244773-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6mlv+cn4Sxo2o20gVJoRSNfEywEPDxa78ubQG3/CBjhZJwL+wh4
 BTHp8qlW1Z/u3WcyT5RwkWozGb/MFuv3k4VqqcppYgz1rOw06wwpvjIkiSzBx+HkePyw0ST
 gcbHi/z8se078XK1OxRBKJYqaT12Tjg2O+1ap5O21jNEM7KoUV7LlglWmx4RYjqA/liw5H9
 ljBhjAqHpgh7FWli5FaJA==
UI-OutboundReport: notjunk:1;M01:P0:fXetEunIllM=;K7gyhqPhJcuME7VS2GxbhmammcS
 QR6UgbuEROY/jyfUX5Uz03yuqfYKpxq3BaTsrQzevd+E4ZRl7rLIYdD6gaoSxMRwQFGQrQFL4
 rrEzdU3ot7Z+8X69TvCnpDdk0LonsXMkReX48y/KalGNfgZH4J9vh4wkZVUNgpzYVrYsR0UAe
 YxQe4iPcVtooTDHEi76+DiZYGcxl6Hqujwevy9+vkKOyRNQ8CwcSWbu6A5RYpa5jbJnpxlz3F
 znxYCM7MAwMOGdH1FCXZPUXS5d6PlphwHV+/aUzaO9nHYi+F1KP9OknYhiEuVdXrsWj9qgn6i
 yj182p1+GxxackQaYoM2w2xC7ShfB2zOpGO1IoUbN8BdUZSHyYTKFOzoVSl8QLtkZ3YpoKs3u
 ui7ryW7K8noe/63qdOd1PiL0izbUMGBzV0EADPKlxmB1499V7yex25PFGEhhR0uiuVr89tHQe
 F7bV68WJGSwXqf6rLYPCQmluc7mOWKoQDJsEI4dlbEg234n/HKluzj9U0CTFRKPuhD/ex7kUq
 Bh2MNUi9aXSdfMorqtreEMMCENnv4gjNnFu+MgwUeHhyo+lbCIr2psqWkUPNvL+ecbzKjXEGh
 DX0AjyEY02lqutnYKyJT6p7WaE+X1Z//Wq7rbSgERHw5wRUe7j3fp5G2HpL0ZEM7DA1LbgyOl
 Uxd2pJ1Z5O1aUq3a+NptfSy7kJULEYSJ8zGr9MmxpZEWy/JqcKo2zPLsOrslC1VN5NnMCHZeN
 g/9UAC4kQB+VextzCwKu3avx1vtNw8aQkvTq/4KZPHDXsMjhpH3/GuMhMKdwjS3sVN+EuDePd
 RJAZlzwvPbDAnFWsJoiwGJ3d+UoITXcdDPQMFSd3XynN/eoUffJq+hoIvotSDOwEHh4AUaj68
 Tj6FhPGZxbrjH6f44UFQc+Qc89JtR1yTKZoY+caxcZksEZ5EP6nX17yy5C8cxhyp4X4psrMtG
 jyoZSrz3+IrDFroF295vYZhbIcwMUYyPAfgdCiGTjmAJWIWUS2mynE4fpowMaw+cv0mnOmtgj
 5AzmbGWPjJvtZa4YWr+FQqfrHHWqnqS11qtmx0BrM3Mvjv/Tj16VRrJN6Fx4vUHG9sFHUCSQ9
 NoGk4SOGo5IGfAQA9XhZlp3Iu1uU5H
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

On 10.12.24 17:01, Ilias Apalodimas wrote:
> When creating EFI binaries, the alignment of the text section isn't
> correctly factored in. As a result trying to load signed EFI binaries
> throws an error with:
>
> efi_image_region_add() efi_image_region_add: new region already part of =
another
> Image not authenticated

You are reporting here two different problems here:

* We create EFI binaries that sbsign does not want to sign and U-Boot
does not accept for secure boot.
* efi_image_region_add() creates a message that does not match the
situation.

Will you prepare a second patch for the latter?

>
> Running the binary through sbverify has a similar warning
> sbverify ./lib/efi_loader/helloworld.efi
> warning: gap in section table:
>      .text   : 0x00001000 - 0x00001c00,
>      .data   : 0x00002000 - 0x00002200,
> gaps in the section table may result in different checksums
> warning: data remaining[7680 vs 12720]: gaps between PE/COFF sections?
> .....
>
> If we include the alignment in the text section, the signed binary boots
> fine, and the relevant sbverify warning goes away
> sbverify ./lib/efi_loader/helloworld.efi
> warning: data remaining[8704 vs 12720]: gaps between PE/COFF sections?
> .....

Does EDK II complain?

>
> We should look into the remaining warning at some point as well
> regarding the gaps between PE/COFF sections.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   arch/arm/lib/elf_aarch64_efi.lds | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64=
_efi.lds
> index 5dd98091698c..e382254a6cf5 100644
> --- a/arch/arm/lib/elf_aarch64_efi.lds
> +++ b/arch/arm/lib/elf_aarch64_efi.lds
> @@ -32,9 +32,9 @@ SECTIONS
>   	.rela.plt : { *(.rela.plt) }
>   	.rela.got : { *(.rela.got) }
>   	.rela.data : { *(.rela.data) *(.rela.data*) }
> +	. =3D ALIGN(4096);

If we make this change, we should do so for all UEFI architectures!

Only OUTPUT_FORMAT and OUTPUT_ARCH need to be architecture specific in
the linker scripts. Can't we use an INCLUDE statement (cf.
https://sourceware.org/binutils/docs/ld/File-Commands.html)?

Of aarch64, arm, riscv32, riscv64 only the arm script differs heavily
for no good reason. We should get rid of this exception.

Best regards

Heinrich

>   	_etext =3D .;
>   	_text_size =3D . - _text;
> -	. =3D ALIGN(4096);
>   	.data : {
>   		_data =3D .;
>   		*(.sdata)

