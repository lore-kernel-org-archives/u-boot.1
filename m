Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751D2C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53ED82CED;
	Mon, 26 May 2025 11:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="S/0rySxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B35782CF8; Mon, 26 May 2025 11:08:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3234982C57
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748250511; x=1748855311; i=xypron.glpk@gmx.de;
 bh=LAfvxcrdfcKFolojlJkwkUKbEnO3LsrBq08s5CZKBqE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=S/0rySxo3Tp9qcjzA/Ko17Lc9be7BrPZtFu0BMjmJcbwgX7zFvT1TqbowjASMSec
 gc1Wr3qE3yEy8PGx7dWLww9kLD94Qc4WJulIIKC33DQkhcDT1VIDWpUuogk7Oo8Sc
 K0I0LqEiFy20MSETkTnS1wzUv65QVma9D0rVGsVHsCrX5nCUBznsnca9Vd23E8slh
 dvDsOOqpdtxka0ccGsiZy2S2zf1WEAu4XVV8TE60G4SnDbtBR0Au7L3d6Xim17hw9
 h/M0CE5Z3p6W8ILEX4PXsABoO5hUf1/Dl3tsojvwmxpUmVr3AtbWcEDGM0U9wtInE
 SwvLkAacKyeXde4CsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1ueUhu3eLM-00oCGh; Mon, 26
 May 2025 11:08:30 +0200
Message-ID: <468eb328-7cdd-4445-a7f7-c5b22396e909@gmx.de>
Date: Mon, 26 May 2025 11:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] net/eth-uclass: Add eth_get_ethaddr_from_dev
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
 <20250516081839.28587-7-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250516081839.28587-7-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oPtLeLRMIs/18lyyV/1SMTVxh02ML/xep5yQUebkNwFe0PYGTxV
 aAdlKLUaqWCH1zAcvHh9tnF9Rcz+Z+ZsXbFcK8aFu+O7vCHaP6SrH+u5t4rVYeSz7gveKj1
 l4fqMIEVC/Cb8jVhBd9ivFQU6pkUmIkg97G8XKvC3Hw0veSiBADIf3ryMyqEV2RbJg9VOwa
 PZXxBdy+km5fMUhWXjvvA==
UI-OutboundReport: notjunk:1;M01:P0:/wwpQTQNn3I=;ZiN+s0lYd7Gnf6DZasK2P68SI3V
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

On 16.05.25 10:18, Adriano Cordova wrote:
> Add eth_get_ethaddr_from_dev() to retrieve the MAC address
> of a specific eth udevice. The function eth_get_ethaddr()
> preserves its behavior of returning the MAC address of the
> current eth udevice.
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   include/net-common.h |  1 +
>   net/eth-uclass.c     | 11 ++++++++---
>   2 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/net-common.h b/include/net-common.h
> index e536968a92b..c429d77d7c3 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -292,6 +292,7 @@ struct eth_ops {
>  =20
>   struct udevice *eth_get_dev(void); /* get the current device */
>   void eth_set_dev(struct udevice *dev); /* set a device */
> +unsigned char *eth_get_ethaddr_from_dev(struct udevice *dev); /* get a =
device's MAC */
>   unsigned char *eth_get_ethaddr(void); /* get the current device MAC */
>   int eth_rx(void);                      /* Check for received packets *=
/
>   void eth_halt(void);			/* stop SCC */
> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> index 5555f82f23e..984d888e2fc 100644
> --- a/net/eth-uclass.c
> +++ b/net/eth-uclass.c
> @@ -175,18 +175,23 @@ struct udevice *eth_get_dev_by_name(const char *de=
vname)
>   	return NULL;
>   }
>  =20
> -unsigned char *eth_get_ethaddr(void)
> +unsigned char *eth_get_ethaddr_from_dev(struct udevice *dev)
>   {
>   	struct eth_pdata *pdata;
>  =20
> -	if (eth_get_dev()) {
> -		pdata =3D dev_get_plat(eth_get_dev());
> +	if (dev) {
> +		pdata =3D dev_get_plat(dev);
>   		return pdata->enetaddr;
>   	}
>  =20
>   	return NULL;
>   }
>  =20
> +unsigned char *eth_get_ethaddr(void)
> +{
> +	return eth_get_ethaddr_from_dev(eth_get_dev());
> +}
> +
>   /* Set active state without calling start on the driver */
>   int eth_init_state_only(void)
>   {

