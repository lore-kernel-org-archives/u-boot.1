Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A657E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 10:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C055289383;
	Wed,  4 Dec 2024 11:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="t2RFR3/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903D38962C; Wed,  4 Dec 2024 11:11:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7226D891B1
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 11:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733307066; x=1733911866; i=xypron.glpk@gmx.de;
 bh=CGFIcYaqbMVURpPsqxHZc30Q7YDqWmdyvWGU4MrZtnc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=t2RFR3/aKtIy0/R1ut6Q67BL+dphg5fiiPF5/zMSZx6aKc5jkT/6r3PBJ4IUVPQc
 1OO+kBLNKDMzjkL1mrw6JOpNUwMjAi5epZwA5coWUWzdzm7JTpbXDu4ff17wzSxGB
 I6LjkqgCCJWJfOygYLqHbMMsQbBpIZCWOVaJSfBIRtzfEKYcD27LGwbVNKQTeImY+
 qyjSxMx/Am0806hvAQOuHKckW32tCdup9QfcLHF6s270Eze5s+lgGywsyhYEbxO0t
 lfX4pnjQVWpxIINpJ8Ugl7gFG6qXHEerr7cL+ArDU1OolvFio4mZyww9n96macjkx
 uSn+C3bZB6MlrlGwYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1tJsoI2Whg-008opM; Wed, 04
 Dec 2024 11:11:06 +0100
Message-ID: <4492be69-8655-4391-8a44-3b4cb682c3ec@gmx.de>
Date: Wed, 4 Dec 2024 11:11:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: fix pe reloc pointer overrun
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
References: <SA1PR18MB56923B0952E67CC949A90A02992A2@SA1PR18MB5692.namprd18.prod.outlook.com>
Content-Language: en-US
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <SA1PR18MB56923B0952E67CC949A90A02992A2@SA1PR18MB5692.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u3HbbsNXaCQb3u2gntA+auTp+Y7WWfVJJKt7ditIeluxtIb2MCe
 Lut/LZgtt67kvesm56fnlKljWmdsQGXq62JxlIQuWxzF2k9/0BvyR4AfGFu22gYvTjyLDk1
 ocRKD61xlz6MesOZgdlhJfqugjfXcPSgwYJUFAq0N7RhrMFf6flZy1kTcRj3BUlELy6qfcO
 ymNLsSHIIVyWvKuDujljQ==
UI-OutboundReport: notjunk:1;M01:P0:XWllKRlTmzU=;E2AQBXH7y8IaOAGhgveKxnOb4J+
 cU3/cyOz2orcFdjnxWdtThxrKuPMCuWF4SFS6XVMU0xAiPfwK+QDTG6L9EWveurAkr8uNBpRL
 CDfPZxsGE6+zIzrp8mKOxA/rL4GRmarOnabSaMBjjusNe17bS/YHoGk/DnAt+oOGIUP520tlm
 QlGw3iI0CSBd9o3IbYfQuv8L3rCednzw3Z5WVhSNbghHy9Gw3lRBLlQLuEACDG4NRSbEuXOWC
 oW5BqS6WvQcRlxVyYa4psV5gkMmMmUtymC2PxBKDiSuBp9VFNKrlIA73WI9PRcxA36CCnoSKI
 fbJ6oBeuq+U6SBxHYUwy+AMpKyd+XrVGtZxlvSPlvsYISBL1cTbcmaWzX55cnn6uiw50cZprx
 /SgbgzRbWYaN0qrSKtaYwPm489WRZv8vAHayTiSGGpcluAiWFnCw3c+nscEQaWUw0/8sbv7mc
 aN9ReQdpzWmNomhpr+oFyBmuHazcTRvhFXAMhF7NU1X4hJh8t1hRbyGY4ycIxTUHU8QGMx0jM
 cm5E66JldxZh/7fMU5dqABUJTWlwBFFv2D3qMHGHXPa8rv5Ug2UujiIi62Xlx5Snwv5qUMUC4
 58Kr4d0hXlTOLNSsdgWgDdmQ2m68VbSfB4qCeqDPhlQq1MQGlnauYJOiq0tkLD9AJiTOHTZBV
 WWPn1T8iGdybtTRdiJOcjyjfp5IEGpx1rDn5AVFQRViNvrd1xZV341lT2OLTaShBKgux4Qg8k
 +bQvT0JEcEcItjHq0426jlWW8wxxW2nQLmSL/spUQW4qX6eO4tLJiBCJ2CCx+0qh8A0YO25ve
 Yn5kULz0Cs2gPGUtxxe473mW/28QmaoqGBkEkSBVAnwDTvvymnO/AKCn6G1AVUrFQ3d1kNMLH
 QucK4PuzlM8tZKGinTlzbTZo8uXBTpgqJQiLYPSUUJi91ThRHsTvismgaBWRTZJOTRm2gtwg4
 /PsSmvJGdD/B5l+zBpX8dFtvVYWN0eiaIdxeULRclIHRy8TwNnBOVijW4g7580+Zh4gaiguGR
 UYXAKu8rTPdqTql7NcjL6uu0y/FMKDTlYv3rFW8Wm6wtlPlExABWZRS8otOIxH4+2QmLs3vpb
 oKv4mLC7NhnKPuJxvqpTcGPmmDG1Tu
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

On 29.11.24 22:09, Aleksandar Gerasimovski wrote:
> The fix provided by 997fc12ec91 is actually introducing
> a buffer overrun, and the overrun is effective if the
> memory after the reloc section is not zeroed.
> Probably that's why this bug is not always noticeable.
>
> The problem is that 8-bytes 'rel' pointer can be 4-bytes aligned
> according to the PE Format, so the actual relocate function can
> take values after the reloc section.

Sections have to be at least 512 bytes aligned. The file alignment
cannot be smaller the 512 bytes either.

Hence for a valid EFI binary the value of "rel" when entering
efi_loader_relocate() will always be at least 512 aligned.

>
> One example is the following dump from the reloc section:
>    bce26000: 3000 0000 000c 0000 0000 0000 0000 0000
>    bce26010: 7c00 9340 67e0 f900 1c00 0ea1 a400 0f20

Please, provide an example image for download to give the full picture.

>
> This section has two relocations at offset bce26008 and bce2600a,
> however the given size (rel_size) for this relocation is 16-bytes

The value of "rel_size" used to calculate "end" is not the size of a
relocation but the size of the relocation table.

The PE-COFF specification describes:

"SizeOfRawData

The size of the section (for object files) or the size of the
initialized data on disk (for image files). For executable images, this
must be a multiple of FileAlignment from the optional header. If this is
less than VirtualSize, the remainder of the section is zero-filled."

The situation above cannot occur if you follow the specification and
zero fill the raw data up to SizeOfRawData which is a multiple of 512.

> and this is coming form the efi image Misc.VirtualSize, so in this
> case the 'reloc' pointer ends at affset bce2600c and is taken as
> valid and this is where the overflow is.
>
> In our system we see this problem when we are starting the
> Boot Guard efi image.
>
> This patch is fixing the overrun while preserving the fix done
> by 997fc12ec91.

Before 997fc12ec91 we had "rel < end - 1".

With "rel + 1 < end" you are not preserving the change but reverting it.

Best regards

Heinrich

>
> Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.c=
om>
> ---
>   lib/efi_loader/efi_image_loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_imag=
e_loader.c
> index 0ddf69a091..04075d83cb 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -121,7 +121,7 @@ static efi_status_t efi_loader_relocate(const IMAGE_=
BASE_RELOCATION *rel,
>                  return EFI_SUCCESS;
>
>          end =3D (const IMAGE_BASE_RELOCATION *)((const char *)rel + rel=
_size);
> -       while (rel < end && rel->SizeOfBlock) {
> +       while (rel + 1 < end && rel->SizeOfBlock) {
>                  const uint16_t *relocs =3D (const uint16_t *)(rel + 1);
>                  i =3D (rel->SizeOfBlock - sizeof(*rel)) / sizeof(uint16=
_t);
>                  while (i--) {
> --
> 2.34.1
>
> **********************************************************************
> DISCLAIMER:
> Privileged and/or Confidential information may be contained in this mess=
age. If you are not the addressee of this message, you may not copy, use o=
r deliver this message to anyone. In such event, you should destroy the me=
ssage and kindly notify the sender by reply e-mail. It is understood that =
opinions or conclusions that do not relate to the official business of the=
 company are neither given nor endorsed by the company. Thank You.

