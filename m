Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91938CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 06:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9816587224;
	Fri, 20 Oct 2023 08:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A5087224; Fri, 20 Oct 2023 08:57:20 +0200 (CEST)
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de
 [80.67.18.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7FA8704D
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 08:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay03.ispgateway.de with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.1)
 (envelope-from <LW@KARO-electronics.de>) id 1qtjRb-0000An-1k;
 Fri, 20 Oct 2023 08:57:15 +0200
Date: Fri, 20 Oct 2023 08:57:14 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] net: eth-uclass: Improve error message when MAC is not
 found
Message-ID: <20231020085714.486b8924@karo-electronics.de>
In-Reply-To: <20231019215720.1839630-1-festevam@gmail.com>
References: <20231019215720.1839630-1-festevam@gmail.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
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

Hi,

On Thu, 19 Oct 2023 18:57:20 -0300 Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> While bringinp up a new board without the MAC fuses programmed,
> the following error message was observed:
>=20
> Error: ethernet@30bf0000 address not set.
>=20
> Improve the error message to make it clearer the reason of
> the failure.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  net/eth-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> index 4311f3fe6e89..1f0985ec52ca 100644
> --- a/net/eth-uclass.c
> +++ b/net/eth-uclass.c
> @@ -594,7 +594,7 @@ static int eth_post_probe(struct udevice *dev)
>  		eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
>  					      pdata->enetaddr);
>  #else
> -		printf("\nError: %s address not set.\n",
> +		printf("\nError: %s a valid MAC address was not found.\n",
>
printf("\nError: %s No valid MAC address found.\n",


Lothar Wa=C3=9Fmann
