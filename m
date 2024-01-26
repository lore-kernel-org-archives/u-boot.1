Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21205C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 13:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B01687C15;
	Fri, 26 Jan 2024 14:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pwwcUGsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0628387C15; Fri, 26 Jan 2024 14:04:12 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 198C087BAD
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 14:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706274244; x=1706879044; i=xypron.glpk@gmx.de;
 bh=Bh5FXEnpb11UdGSMmEykGVUSKAv7QhChbeZ8f218/4Y=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=pwwcUGsKwpAoDtBBib3S3ERWrOiyiQ74GBkCwClPj4K34ttzOK//wBRYJ/QDLokX
 jGiI87UHZuVWV3D665M/p+O0lWi2KdBcwQ0DaVnpH9PwysD1/zfw/lIqDqkTyVrTy
 wIfkCCiTt0ZAl6eY8AS1dZ56rv5t5M3MhfjCYkKG/rpdM+Q29BZIvoEFFgbJVXYAj
 W/74raou/X20z2VeFOIhgyx23itVH7Xko+Ej22Jia1u6YytHpaOZoKSprnKPfavg6
 AxqOqPdsgYMftTwBKeesVOMbYpwIyjmZJ6kGTYF1m0oFJrECE0jmbFb7VF6yyGPiB
 0MYn/u9ulEMcLVk1iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeMj-1rWylr11Qh-00VjYP; Fri, 26
 Jan 2024 14:04:04 +0100
Message-ID: <b8866cb4-bfc7-44cf-b923-085629ce4b64@gmx.de>
Date: Fri, 26 Jan 2024 14:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] driver: rng: Fix SMCCC TRNG crash
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>
References: <20240125140502.22400-1-o451686892@gmail.com>
 <20240125140502.22400-3-o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240125140502.22400-3-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DTafzTw7umDp9P6lxkO8wlhjtARAr+l0y3M0/f0ORJUpHzaap6L
 6wsX6kNe8+s16QvkEsZz0o0abpBQDPtxDAjCcKC23Ad4pI4Eto9AXo0XUl66T2o7cqFoRmF
 Ne0bbKKubfCgskc/fwzUcJmi524Fs65XonaZc6Roj0mfGZ1GSvgLjoIFOwRmNXqRq8hLUYT
 KIZZWO+KhVEiQDB3YC4sQ==
UI-OutboundReport: notjunk:1;M01:P0:uSBIOHye9Vg=;P6kScymZVEWwXz4sZ40ckhH+tRh
 UUYD4tUAnMVQb+M63ydLV+oVKlDbjf3FwAG4pqh+Bk6PwQTrh0IKa4RNBy5LNc/rNIFKfIYMr
 LY8g9ugi3T/PtHp6cw0BqfG/8LhVPWoYi+RqHqF+/I6G0WGNFbb/7D89k1VpuYQ9mwXUBdvEJ
 kgjI0gCncro7jKnxR3fLIo9Vt8pXnU67BQJ6QtyZoc9A523ERYzgBvc1DSUDXZhN8hlE/GDnV
 u51a0fS4Yx88oFjNIuEQZY9Kp+IQijIvarKkJ0YrDUWe1hkj5Db4LjBYwgncL3XnWH2qPrF7X
 5TtURkFZv7hhul9rldN3ZWoRmHJsMZzIoypdtg207qhmEYrpC4/UbUvDxBz2Vjl4RZIQn9p6m
 7i6JXkaTe+NuC2NeWtKmFBNF2ztjTuKbPh6SLW5QEJ9YnUQFt1bYdhWVMGgabhpoXGk28oguO
 wqOZM7MaB5RjuI13DKNXrQqxs6VVQPmTbuvywpQFkQeBElfvBU9WYbAtDqAXA63dozU3CbU16
 EThtjzn4GaYSB7fhy9y0hSpYpVOV1h2JVe20HOOow5a9KdAhP94IqPXjgk2FmOsI12mW4YAkc
 fpZG0EMplJZBhxUmVS6glng/38G7cSb3skaWXjxg+wLiuPQnPp5PMSexTOsovf/GWGhMO6qIH
 wv6+5lTeBsSnCBAV90PohE7TgGcepsNMcMJYVe+8LKMeH8U4T0Fb06CsMdXj2UKZZHdhUBV/N
 kVH7B7gMNp8T+IWGxI0ZQS2+y1ttYeiQJ7yxgexvE9DFeU/VJ/0JPX9Qw2Ylv4kl4l5w4H8X6
 XRAQDULELLGiKcwpV4KlsjjRm9nCFtXrTRZ/AsNOSqgIVLFoNFLXgpb+DvaPaR5XYpcGYydkS
 qIBSyhC74hKDpwiLXN37Of11o8x2I0+OUCi1ZdIe8jqEu1io18b3RptHoTpnYa6QigDmjZ6B+
 zjPxt7wJRdJ8OTNRGdK6NoMJ8HI=
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

On 25.01.24 15:05, Weizhao Ouyang wrote:
> Fix a SMCCC TRNG null pointer crash due to a failed smccc feature
> binding.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   drivers/rng/smccc_trng.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rng/smccc_trng.c b/drivers/rng/smccc_trng.c
> index 3a4bb33941..3087cb991a 100644
> --- a/drivers/rng/smccc_trng.c
> +++ b/drivers/rng/smccc_trng.c
> @@ -166,7 +166,7 @@ static int smccc_trng_probe(struct udevice *dev)
>   	struct smccc_trng_priv *priv =3D dev_get_priv(dev);
>   	struct arm_smccc_res res;
>
> -	if (!(smccc_trng_is_supported(smccc->invoke_fn)))
> +	if (!smccc || !(smccc_trng_is_supported(smccc->invoke_fn)))
>   		return -ENODEV;
>
>   	/* At least one of 64bit and 32bit interfaces is available */

