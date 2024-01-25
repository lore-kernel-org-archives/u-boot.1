Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7412C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C349387015;
	Thu, 25 Jan 2024 15:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="n0JsU5y2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21AF786FC9; Thu, 25 Jan 2024 15:55:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406AF83CF3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706194529; x=1706799329; i=xypron.glpk@gmx.de;
 bh=SOVzoCC6gFxPwd0zvyQoGvSzjUUPX8wBFYI4kgGxGSo=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=n0JsU5y2zzX9hPSfTCPYov+hvNpBs7L2TrBUwtZNqr36ju4RfZ6BmxKSkWSztK3F
 24Y0kGFSIzHysoVlOFHe/9jqKKHQLEsRVHb81g9U8W3+h6rpk/Hwm9veNvDe3QE4z
 AtOD9uGqGyQnnZxAe4aS4aGera145Wm0GGrgcK6BYVd51icvOFm+ME0mDJAiExp7k
 TKMtgYdg4V0uvyc0dpews5JRngOSzZqq7Krvs0wRQQNuyaI90fFtUkFZ7y5hoIXHt
 dKUpBa+AvXzeuyr+nBkE9SonEJnjXg98mYdE6k/puhAg2t0v6TMrH6U1ddSBHva/n
 EYLOJAdc3QLuzth25w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1rQX6Z3QiZ-007TLH; Thu, 25
 Jan 2024 15:55:28 +0100
Message-ID: <6a9dd930-9bc6-48ad-a8bc-41d975fab44c@gmx.de>
Date: Thu, 25 Jan 2024 15:55:27 +0100
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
X-Provags-ID: V03:K1:lLAngbDF1B1Li6M1LsAts+ybiSB+9EhHrIjbbEnMf2ttKskEw1d
 UoMZ4LRHBQ4mo01ngyixzUhkCGOpThChDuwknkqIpG6ZlOpuZFqR2kHDaZunpQlQJbVd9XT
 L79zcb7HEbH4sbwwuo2mzWe08+rxTKLBy0kSy7VlscmNweWlaiFcz2TZtlqRyc/VJyG8rO0
 5X/yNcyEyI3ISIDZX+/QQ==
UI-OutboundReport: notjunk:1;M01:P0:PwWu1irpQsw=;4w2RVmerbrseK+mFQJTuoVakkr9
 OIthP+UDtnenEn37I2TmE5pEfbGwAaugmUgU/UGXMuRCb7RzFxtYPl+LzssuRbxm77izBqcVr
 LE9qgP9qf6S8C92hgBxKG7fnvqiaQY4TB+J36qySwfhiM03uAjlQJIS9BTLg3eeiCEwa+ZXKG
 5xL5NHCR2zRkW8bxxk5lGbhfczP3FDIr4zqQQJfVFWju/PbgKUDrVSzDCUvwpdBbSKRcadpeZ
 TEqvTGfc4GuKPaowex88mR3ilsqWY3IM+b+O3KRqVDRNmiqPPdl/bJw0CsOReovFKNNelXUpi
 IlQwY3E00LJzNb7oDKj11q7Q87E+uhn854CMEZ6vBSfovdMiqvvBnk3sp8JexM0fJOd2t543/
 rcWuiOEtkIm3KeQfUfAmWnqRlT9gqWiH/DW60K/rzhMgABOS/UGwsWn+TnQ/h4FyDiN6b4q6Q
 LTNxCYsjkKtPizFUoK0RwxUUiLDLYCYmz5HbL0hdhLR9WSEnw14ZOny3AI+O+MQ0QgEjUUw8Y
 RxqkSv9qwvLDL7OD78+DXxTk7Eexn11V2WmNpqyV+XTEl0IL0ATlpLjT/ymb7CdAlkWEiYDh1
 N4ek6avG25LFDfRGpSRcJglrgOYeY/Vr/zLsgzMrjnCpKeA6SfU20kYnYu6C9NJookY/OX7Tk
 fuDCg0vbQzGEDLaNuXrYPErSBS4Zsj0rve0WPAESeJmIQZGNOQE1KyaKzXMMLpjkPnswQVUQJ
 B7IFgRTVNrsNG8kk+dn6MyIUoweYyTm098qmzXAOAXW6aOoQvIp65zGGR1PEPO9nXfN3TRX7W
 t4Gp5oiLQvH7udibfKzKv52kjbNQGrIRl+Y5gMJr4PRC1cDGe4lhaSihF7F3aZFQG9k1PkAhi
 PB07HujwzEogUkFXMxfEoSerMz89+Mym0MgpKyxIyb+8p5Tngqoe9P4tWWHxLIN8tpxHcIGEa
 tnaxEXPaE1uptrpSVv9F/TujEH8=
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

Reviewed-by: Heinrich Schuchardt <xypron.gpk@gmx.de>

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

