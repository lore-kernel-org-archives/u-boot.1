Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB035C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 08:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155A7880E6;
	Sun, 28 Jan 2024 09:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PlvDHHDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D62B488067; Sun, 28 Jan 2024 09:36:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E011E88067
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 09:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706431005; x=1707035805; i=xypron.glpk@gmx.de;
 bh=ADV8ZWoAxZBqjKSovbamQcz2rHFt4I3D7eRt+RWm76Q=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=PlvDHHDndV/xEvOEMwgO8/pDS3bDJGtf6KZBcY3eGjRqM0ceLDT9wlcy+8u0jenF
 ZaOE1R4JnKOWFWORv9/XFUPMoWSCs8ZZcnAdQ+S7L+R0/PCm89SOaOHKSFVaysE2W
 60HKUBvcmYPsBA+Y2Yy0daqpFOpPgCW7PDT7XW8/yHBxi+kMAD7+4fJ8i2G/xkc8/
 gKQUJSHjj53Aj9C7JGyh26s9tc+9EdhTn2+fvBKXJ0nh7Iuuq+Oqdoibog7Aq3gE1
 ApRfavOrSRwID9quGGDia9kMZmAP49hWAZ5REceKIA/8Q6/RQjks5hEW/JwMykHGU
 u/KxgoTGqMkqaSYZPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1ra9Ti3fas-00XeoF; Sun, 28
 Jan 2024 09:36:44 +0100
Message-ID: <dac04f9a-6657-4727-ac9f-c94793b2c07a@gmx.de>
Date: Sun, 28 Jan 2024 09:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] image-host: Fix error value paths and emit error messages
 to stderr.
To: Hugo Cornelis <hugo.cornelis@essensium.com>
References: <20240122233057.GR3652023@bill-the-cat>
 <20240123081556.418900-1-hugo.cornelis@essensium.com>
 <20240123081556.418900-2-hugo.cornelis@essensium.com>
Content-Language: en-US, de-DE
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240123081556.418900-2-hugo.cornelis@essensium.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1VnM/I2eiexgHceJpaNsK20cKeN/lkq1e4+WrQpWvbJDivbvKrw
 qKtsrp7oPQovzGmZApNnj1C9nki0hJ7pCYMoGkqXAh8jvRUTfrysgZghPpcbxr9lITbTdGz
 0utu0AOhwChhb7KHiZRTaxV2Sriwh9Q9FYSFooH81wsG7TAvsrCPfPYO3XKQAXFfx4/UGU3
 toNiOJ6IZzelcXDfOEsTw==
UI-OutboundReport: notjunk:1;M01:P0:nyYgu3JSC2Q=;rgpGzoHcqfXYE6fbojC4CxWCtYP
 gUApxO0s/geSoMiTt0gyOkiq0nCZjDTVWmmXlvckQLXlMxs1W0Ok0fn5yK9mmYxI29RH09vMm
 St0+9Uw5r6dr6TiTCQiOYuL+3G/0dY9UrABURP9Rvp+h7ZR1VWmJdZU13SqnF5VMwrYSj/rXL
 lIMupEa/hIbV0YvZUkHbnyQIVvBUc6cZ+48OhsbqSYI3Fvn0gOnoQcV8+V2q0ygPcfmgAHOFJ
 kIcWS17qh/mIF1Dsd2vlpTs95dRaT/53ocg0unfPRWnPKF07ujfFTP+UQV9s41loLs1JpcpQ/
 eWivfbqy2Y5o81fsDh8WjPT7AMsNiraIQpE1pM8TjJJr+Yd0kMtxQW0nJ26BAYV4nQ5H9vCFR
 79+iGCAQySagEvdIOwBHLS208AbFsp4BFKuD1wEzCiY/19JfxZyyhKl9cymDtcDXwilo8X+TD
 t/rJKbKcx8mICAaVwBY304Pr3oVrAX8LSJNY+KQVyeopNcE4SOQLSLO3m/BsXbBQmZ+6OM0yN
 Zi3WG7KF8bd4OcTMEuAGFzIiFtNWFszSDJvbNetSvmPjtdlkvuHCadBgB5D63BdgP7V/EBAoH
 V5ciSAn2baOiNSgv98khY4L69XG++CqS3zGgs9kNLIYIuASNrf5FbQ9jVh+cI6JKUmI4bu9D+
 /DV0VQee2CLposT/acLpwJR74I05S4XvMz8BL9c7JdvMSOoL9ubvEzC2Irvtf3/dRcBeLPXWG
 9Y+deJBy8l63yKumViOJoBhZvi0U4Lvu/Sv1yWUhkyoJoK9UsofvCsZ5ZbhVo4O6l9xo0guzF
 CI1Xzq/gZZqKwttIz+vKlGYCHVdKTWkwjUICPGeOPQH7ci4Rrk5un33yDRBghUUsptCRNXeTj
 vDSjGWDAIhWw2TFm0Qo1SG4k0zOoMVQHxRaU3CLYSRsTwZvp43AogafWGP89B+V8iZhCiddus
 4VYOvNd3KW/wUHJ3T0vnGKeGjfs=
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

On 1/23/24 09:15, Hugo Cornelis wrote:

Thanks Hugo for addressing the issue. Could you, please, resend the
patch with an appropriate commit message. Please, use
scripts/get_maintainers.pl to determine the list of addressees.

Otherwise the patch looks good to me.

The initial assignment in fit_image_read_key_iv_data()

     int ret =3D -1;

is superfluous. You may want to fix that too

It helps to know which patch introduced the problem. Please, add

Fixes: bc01d9ff93f3 ("image-host: refactor and protect for very long
filenames")

Best regards

Heinrich

> Signed-off-by: Hugo Cornelis <hugo.cornelis@essensium.com>
> ---
>   tools/image-host.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/image-host.c b/tools/image-host.c
> index b2a0f2e6d1..06b05dcacb 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -351,12 +351,12 @@ static int fit_image_read_key_iv_data(const char *=
keydir, const char *key_iv_nam
>   	ret =3D snprintf(filename, sizeof(filename), "%s/%s%s",
>   		       keydir, key_iv_name, ".bin");
>   	if (ret >=3D sizeof(filename)) {
> -		printf("Can't format the key or IV filename when setting up the ciphe=
r: insufficient buffer space\n");
> -		ret =3D -1;
> +		fprintf(stderr, "Can't format the key or IV filename when setting up =
the cipher: insufficient buffer space\n");
> +		return -1;
>   	}
>   	if (ret < 0) {
> -		printf("Can't format the key or IV filename when setting up the ciphe=
r: snprintf error\n");
> -		ret =3D -1;
> +		fprintf(stderr, "Can't format the key or IV filename when setting up =
the cipher: snprintf error\n");
> +		return -1;
>   	}
>
>   	ret =3D fit_image_read_data(filename, key_iv_data, expected_size);

