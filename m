Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79CCC77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 12:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF51D82C2F;
	Tue, 24 Jun 2025 14:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RtwWZIzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA0F82C4C; Tue, 24 Jun 2025 14:59:26 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B7882BCD
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 14:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750769949; x=1751374749; i=xypron.glpk@gmx.de;
 bh=DmxAMz9YRSBVoI9LAvIhejXdWXmYFJkJxDBysMBUNXY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RtwWZIzX0wXBPieh+vk3W2r6wuWP1Io/cFGVnolX+usiTC/pIdCiQH7v/QUrhNVk
 IS53tGKdYWj8I2HN4mdG0v2oj9hNvq4OAdLlKzVChRAZBX0tRKvX3p4FniAIME/9g
 i7QSqHb2HZ9tW19BRiwNAdt9ODMNQECgWMN9y7FoGEuJz+S3wkg9tdqylSu+ZjCRF
 EsS/CQeDR5RkiRiD+emlMET7mgyZaizIAorHE7FoV/OxhGMR+zKNdb0SVr8D3KRD3
 uA5CA/yeVuD2eraek+oIet6epJr3MxNBqRerWK/Eu2d9d5tAcmhjuVWzXTn+PiFmg
 TG+Hz+LdC7IPcLhFJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXQ5-1uDLru2Q3r-00LNqM; Tue, 24
 Jun 2025 14:59:09 +0200
Message-ID: <38f5d078-3328-4bdb-9c95-4fb5fe89ddc2@gmx.de>
Date: Tue, 24 Jun 2025 14:58:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [BUG] [PATCH v5 1/3] common/spl: fix potential out of buffer access
 in spl_fit_get_image_name function
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-2-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Edwards <cfsworks@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, E Shattow <lucent@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250610095632.1085431-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vXZqsekNfQnZU4i1URWd95TACOxzKgdwgOwgFO5MXlZBWJH6sPk
 /EeZrJEpV6AlgAupjYUSRm3QeNAF5JhxvWD9rK8w3T8bw8ORThDS4b0UqVBAcc9i2xVmbUe
 aj59Kv7abzngoLO199F0Xs6XyoF2mOO3lPnA0wDrYBKBWQsOi92bP7DntPFnBpqzE4OXkuy
 2IijvghA8A0NGS5p0uP1Q==
UI-OutboundReport: notjunk:1;M01:P0:vVtypUgCOyc=;SaeKZIl04xIKFqXwH9as+agBv6F
 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
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

On 10.06.25 11:56, Mikhail Kshevetskiy wrote:
> The current code have two issues:
> 1) ineffective NULL pointer check
>=20
> 	str =3D strchr(str, '\0') + 1
> 	if (!str || ...
>=20
>     The str here will never be NULL (because we add 1 to result of strch=
r())
>=20
> 2) strchr() may go out of the buffer for the special forms of name varia=
ble.
>     It's better use memchr() function here.
>=20
>     According to the code the property is a sequence of C-string like
>     shown below:
>=20
>       'h', 'e', 'l', 'l', 'o', '\0', 'w', 'o', 'r', 'l', 'd', '\0', '!',=
 '\0'
>=20
>     index is the string number we are interested, so
>=20
>       index =3D 0   =3D>  "hello",
>       index =3D 1   =3D>  "world",
>       index =3D 2   =3D>  "!"
>=20
>     The issue will arrise if last string for some reason have no termina=
ting
>     '\0' character. This can happen for damaged or specially crafted dtb=
.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>   common/spl/spl_fit.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 86506d6905c..ab277bb2baa 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -86,11 +86,12 @@ static int spl_fit_get_image_name(const struct spl_f=
it_info *ctx,
>  =20
>   	str =3D name;
>   	for (i =3D 0; i < index; i++) {
> -		str =3D strchr(str, '\0') + 1;
> -		if (!str || (str - name >=3D len)) {
> +		str =3D memchr(str, '\0', name + len - str);
> +		if (!str) {
>   			found =3D false;
>   			break;
>   		}
> +		str++;
>   	}
>  =20
>   	if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysinfo)) {

Since this patch (commit 3704b888a4cabac8) on the Milk-V Mars board I=20
see a message "cannot find image node ''" and on some builds I have seen=
=20
boot failures.

With your patch and some debug messages:

U-Boot SPL 2025.07-rc4-00017-g3704b888a4ca-dirty (Jun 24 2025 - 14:45:11=
=20
+0200)
DDR version: dc2e84f0.
Trying to boot from MMC2
spl_fit_get_image_name(): index =3D 0, name =3D 'opensbi' len =3D 8
spl_fit_get_image_name(): outname =3D 'opensbi'
spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
spl_fit_get_image_name(): outname =3D 'uboot'
spl_fit_get_image_name(): index =3D 0, name =3D 'fdt-2' len =3D 6
spl_fit_get_image_name(): outname =3D 'fdt-2'
spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
spl_fit_get_image_name(): outname =3D 'uboot'
spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
spl_fit_get_image_name(): outname =3D 'uboot'
spl_fit_get_image_name(): index =3D 1, name =3D 'uboot' len =3D 6
spl_fit_get_image_name(): outname =3D ''
cannot find image node '': -1


Before that patch:

U-Boot SPL 2025.07-rc4-00017-g3704b888a4ca-dirty (Jun 24 2025 - 14:34:50=
=20
+0200)
DDR version: dc2e84f0.
Trying to boot from MMC2
spl_fit_get_image_name(): index =3D 0, name =3D 'opensbi' len =3D 8
spl_fit_get_image_name(): outname =3D 'opensbi'
spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
spl_fit_get_image_name(): outname =3D 'uboot'
spl_fit_get_image_name(): index =3D 0, name =3D 'fdt-2' len =3D 6
spl_fit_get_image_name(): outname =3D 'fdt-2'
spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
spl_fit_get_image_name(): outname =3D 'uboot'
spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
spl_fit_get_image_name(): outname =3D 'uboot'
spl_fit_get_image_name(): index =3D 1, name =3D 'uboot' len =3D 6
no string for index 1


With your patch spl_fit_get_image_name() does not detect that there is=20
no property at index 1 and does not return -E2BIG. Instead it signals=20
the property is an empty string and returns 0 which is not expected.

Best regards

Heinrich


