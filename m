Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0106AC46CD2
	for <u-boot@archiver.kernel.org>; Sun, 24 Dec 2023 19:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23A43876D3;
	Sun, 24 Dec 2023 20:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KqhTS3by";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39B7E8772E; Sun, 24 Dec 2023 20:37:58 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17C828747A
 for <u-boot@lists.denx.de>; Sun, 24 Dec 2023 20:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703446673; x=1704051473; i=xypron.glpk@gmx.de;
 bh=swJouydNGflt6ze5QUhHslFKein4cix8MpM0MMlL/Bg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=KqhTS3byoEBak2TUzaSO3//gJCPuJVAUnXCdihSlaW1QiZahE694OSoifpThPX47
 tvNsiNn6RFlxKkFmyzeqlbWysPW8nSJzSGQrJMUskKKgX4V3D88HxX7PekfVdXzt8
 aR0JApUeWWvXC1VN/JFJJZHUYtIeP0rZVWzE96vZD5KREzu1V8Eh66TACaogSuuUH
 5/LCsq9tE1T5uc7toPGJYHX4Rpni7FT0Tt2nxYjllz3Nea1BiVhtildLg44WaE2oR
 tXGdkRew8+AxgFyWGFAE6FT1sqxhEt96Mi9oB0v9ceIZ30jes5Mup0QXUjF/0APok
 HdZ9uWDKSbw5M1lLjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.83] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpnm-1qtkKp1kni-00pL5N; Sun, 24
 Dec 2023 20:37:53 +0100
Message-ID: <7a95fe4c-1155-4c47-9dfd-9efe8b2365c2@gmx.de>
Date: Sun, 24 Dec 2023 20:37:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: apple: Disable SMBIOS again
Content-Language: en-US
To: Mark Kettenis <kettenis@openbsd.org>
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com,
 u-boot@lists.denx.de
References: <20231224181255.4954-1-kettenis@openbsd.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231224181255.4954-1-kettenis@openbsd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qgUsgY8lr/7pgj7zcAMKTov80RTKXmPkH0hw/NKCLP0KHY/4jil
 AjBOvU8IXFvbe13aAT4pOLZzGI/rPP1NXC7YCAGry1txWEZ0zk+6DHq0TfTmL1Z2e4x470S
 JZet+Tlqcx8xPDPNS83Tgmk69ECiqdO79h5BmUfz5d+KVgKVziK7WEFFIWnXIfpNlTr+ydL
 I8RAI7X+NsUfv2ELNOUYQ==
UI-OutboundReport: notjunk:1;M01:P0:QeD4RrDVUxM=;W0SR1IjQU6wAPU22i2ePMxfKKMt
 h8iMt2rUN7xGkhpTa4JOCC7EiW65z+uFybjtswWkW8DI8BsLI3KRlfX48zGc6vzxCvzKJ8y3L
 zydkj1ORqlUngQk371nefL26BZrVaBynjo1VEdBAVDBpjZQ0LMMsrFaddAvuPKZ5Awj3rHed1
 /AKI7jbyRmjhCQembT/lZeEzTeZtzL0111UuxJOKlPSDwPMxvCJPtaEgpIfKsIasoQ0E6ZACE
 p8UWEsWyi9K/dyWyyJIUF8cYsTQrA0rOkKysvi4cZ0AZ8t2XzcqGzfwPC5XyEDCJta+pvzJmZ
 Ph44SY6I5c6t50Yl6RF6ypVCZNLlSkHTS8yKpMigs/kC6GrlXe2UAuZ7BbvSvvYD/+Bj8rqjj
 dewUK57+hsuc8phKy3yRAVw1aZ/Kqw4EV8mp3fAIWo0t2y9MFbB5z5kkd8GWO/ewjObx7sa6W
 GNZcMfh9uhsJWTkaHMcbK1ndiDCUcEIrmCUp9lGsRVGy50gbGc0NCJM6K2QP30v10agcS2n4y
 4cELtFD3mhaE5rV36LYOewwH8npSZNt+iiBAEKoGotr8ElLOCNEOys2HVrubyaRF9lAWXHy0D
 Wen61Yvo307wqtifJ8SZbKJvoAG5Xn1AxM5bz/e5tnFnN4DN6PudiNw8EGmujvSlIuJVl+vtE
 uH3+7ZNy3+ajffNWX0AZrPz16Mzyi/9SUFfVWEN+EoYPqjgaSVx3Moab8XzahGfk8R+IrOk0R
 B5OKwriMLOtp3ooSVVv9GtF/e1OdekidMhRp5tmvPJMmGJ6dOSl54UXkOVi4oOp5aWSYplLF3
 H4plI0WPYGffiNVm48ogN7yTkC/e1EOmKgjf1u64c5sIXYWBCg0j6k6FFM2SyPh7WGt72cOjD
 jq0o2py6qHc6Oq5ciot9CySD9No4qy4lGq4ofPrR+ikYXTJOeLdIsUip7j5cfiKH5P/tAsdzs
 Uy909VI/s9wS++BtThoXb9yvPJ4=
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

On 12/24/23 19:12, Mark Kettenis wrote:
> Apple machines do not have memory below 4G.  Since U-Boot does
> not support the SMBIOS 3 header structures this means we can't
> support SMBIOS on these machines.  Unfortunately the refactoring
> of the SMBIOS code this cycle accidentally enabled it again.
>
> Fixes: 53fab13a7b1 ("efi: Use the installed SMBIOS tables")
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>

My understanding this is for origin/master. For next we have pending
patches from Simon to move to SMBIOS 3.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   configs/apple_m1_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> index d58a9030db..b868d0e319 100644
> --- a/configs/apple_m1_defconfig
> +++ b/configs/apple_m1_defconfig
> @@ -21,5 +21,5 @@ CONFIG_USB_KEYBOARD=3Dy
>   CONFIG_SYS_WHITE_ON_BLACK=3Dy
>   CONFIG_NO_FB_CLEAR=3Dy
>   CONFIG_VIDEO_SIMPLE=3Dy
> -# CONFIG_GENERATE_SMBIOS_TABLE is not set
> +# CONFIG_SMBIOS is not set
>   CONFIG_LMB_MAX_REGIONS=3D64

