Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6C6D1CA03
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F53288A0A;
	Mon,  4 Nov 2024 23:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OMVkA/tB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3133B88D7E; Mon,  4 Nov 2024 23:04:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA818862E
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730757873; x=1731362673; i=xypron.glpk@gmx.de;
 bh=08KFyElI2P4rRil9go0VfNLsoYkVgUoSVybMs9vlDnw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OMVkA/tBUeTJdLQx+kUt/42EMeSZqsyFss1EoEakrRVwCSvHouSskh95OwC38EPG
 7uBLMymCqHM4Y43yCvdmPq9VkgfmLSg2dntrXC0A3Yk8xEmW/AZZXYofRgiF49uwi
 ARy7Gs01r4/hjZ2CBRtQY8To8auagE6j/pksvislIV8686/i4kdzaXFXrhvm9IJXY
 NBKNyD7M+WBa3ggK+lSEx5G1bgjNzyiPHSeZXOgDTahs5tL5QPfBCYkKdsv5deIQs
 fw+GsyNLzUqwS4RC4GL9eRBVDevtCLCpLMBjo+jHpB8k52VVOQjackF6Zi2cPGGKd
 48TE7spNI+Nu3DD9KA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.108.63]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMuX-1tTktl3Ibh-00QP1X; Mon, 04
 Nov 2024 23:04:32 +0100
Message-ID: <111d4060-9e0a-4609-8a8a-2c61e076fe28@gmx.de>
Date: Mon, 4 Nov 2024 23:04:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] bootstd: Move bootflow-clearing to bootstd
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241104175110.1048449-1-sjg@chromium.org>
 <20241104175110.1048449-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241104175110.1048449-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w3x20wJp+nWCck0oovG4luXags1UEUy5aHiStFX8v6QtSTtUxPd
 2EiahGGqdpFTY+xBq33+wldZUxhRBHdm5FYrxDP/JVIehrVE7/WVAUtdFLg3mk437dzHv9h
 7jBmH5XBiF5I9DhgOdce9Cj7QxeOmD/uwy9i7dbhs0xLnAPUgc4bKv/vfFbJVQlxeRqQo4z
 2yhDrYRjRpNJQnpVP607Q==
UI-OutboundReport: notjunk:1;M01:P0:gub9INhqH50=;zRXmphy0oRMKrAdOZSND8EQMrJr
 Rf2vaOasE/4mueZyOypDI8o2oBcSXaNkD9Hl9X1THsiRfSnb9wi6Ue8XJ9eG6oxYiFZ52yAvL
 fXiITR6m+HqGjRCkdGAHh6H/C711EqRo1IgAp5LbLzLUVqVPQybxaZF25YBKgbN0o8RwX6U1I
 7i7xnrP/AMEdCBOHPJ0J1DrlhGjmrGlkzs+BO2YwUOeerX59UrwIXCvQvwblZSaRklZRRdLFX
 tPUsyyp/Z+9RDKX/XBtIs5xFRdaTsFwhXEJ05+rSpaKW8QtP2LJ3YR6Kri+FQ08FKvhSRlIyx
 6OiqFyQQB2xM+f4qyGVYeJ4S7hV/kOvqLuy9uIi47l5JAeDr3e8caXMAQ3RGvJxa71fjGZqyS
 7EhZPD28x+EjUXrIoAAnMxOS33uYEWy13CbTn8KJSG8VAEEVofEElDdiJLpbeWK5KqMu4jYH5
 ldk5gCjb6Pbt46EDb1BeN7cdeRnnjPZkhclk1TtEYSQRcLDL+Y87ljWEDDjs3KMFpg+2rqFBb
 i/GMBOgcQ0LF7OqZCBtPNP8f08eDHN8gPM57qV4qMN0QDwCzZm9MXvUWYLr62F9B5u/z7Zwff
 bAmEQW64xv3wszY0IOPRa+eAM0VNGOu5+Z6QxvLp1PsaLrA2PlmCPeGmLYRlPLslzMiqsO86u
 C3lDrcqZfvKg/ri/bVFFrYOp/9wxv2I9xI5OJDgvkN3hdfd1BOVI1LUhvR2kxrL8j+Z6dIX/o
 WVGHqjtpkeT7lxSlsEVfUW6Aukx1sAi3E8W9KysdehiK5HJBE/ZLKKLZ7izj4ep7o5X3SUb9N
 BKL7lRU177uFX+tYJwA4NZPw==
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

On 11/4/24 18:50, Simon Glass wrote:
> This relates to more than just the bootdev, since there is a global list
> of bootflows. Move the function to the bootstd file and rename it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> (no changes since v1)
>
>   boot/bootdev-uclass.c | 19 +++++--------------
>   boot/bootstd-uclass.c | 15 +++++++++++++++
>   cmd/bootflow.c        |  2 +-
>   include/bootdev.h     | 10 ----------
>   include/bootstd.h     | 10 ++++++++++
>   5 files changed, 31 insertions(+), 25 deletions(-)
>
> diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> index eddbf60600c..26b003427ec 100644
> --- a/boot/bootdev-uclass.c
> +++ b/boot/bootdev-uclass.c
> @@ -557,19 +557,6 @@ int bootdev_get_bootflow(struct udevice *dev, struc=
t bootflow_iter *iter,
>   	return ops->get_bootflow(dev, iter, bflow);
>   }
>
> -void bootdev_clear_bootflows(struct udevice *dev)
> -{
> -	struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(dev);
> -
> -	while (!list_empty(&ucp->bootflow_head)) {
> -		struct bootflow *bflow;
> -
> -		bflow =3D list_first_entry(&ucp->bootflow_head, struct bootflow,
> -					 bm_node);
> -		bootflow_remove(bflow);
> -	}
> -}
> -
>   int bootdev_next_label(struct bootflow_iter *iter, struct udevice **de=
vp,
>   		       int *method_flagsp)
>   {
> @@ -935,7 +922,11 @@ static int bootdev_post_bind(struct udevice *dev)
>
>   static int bootdev_pre_unbind(struct udevice *dev)
>   {
> -	bootdev_clear_bootflows(dev);
> +	int ret;
> +
> +	ret =3D bootstd_clear_bootflows_for_bootdev(dev);
> +	if (ret)
> +		return log_msg_ret("bun", ret);
>
>   	return 0;
>   }
> diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
> index bf6e49ad97a..596d3e5e41d 100644
> --- a/boot/bootstd-uclass.c
> +++ b/boot/bootstd-uclass.c
> @@ -86,6 +86,21 @@ int bootstd_add_bootflow(struct bootflow *bflow)
>   	return 0;
>   }
>
> +int bootstd_clear_bootflows_for_bootdev(struct udevice *dev)
> +{
> +	struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(dev);
> +
> +	while (!list_empty(&ucp->bootflow_head)) {
> +		struct bootflow *bflow;
> +
> +		bflow =3D list_first_entry(&ucp->bootflow_head, struct bootflow,
> +					 bm_node);
> +		bootflow_remove(bflow);
> +	}
> +
> +	return 0;
> +}
> +
>   static int bootstd_remove(struct udevice *dev)
>   {
>   	struct bootstd_priv *priv =3D dev_get_priv(dev);
> diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> index 8962464bbf8..1c1146ce11e 100644
> --- a/cmd/bootflow.c
> +++ b/cmd/bootflow.c
> @@ -197,7 +197,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, i=
nt flag, int argc,
>   		show_header();
>   	}
>   	if (dev)
> -		bootdev_clear_bootflows(dev);
> +		bootstd_clear_bootflows_for_bootdev(dev);
>   	else
>   		bootstd_clear_glob();
>   	for (i =3D 0,
> diff --git a/include/bootdev.h b/include/bootdev.h
> index 8db198dd56b..f9cae2fd1fd 100644
> --- a/include/bootdev.h
> +++ b/include/bootdev.h
> @@ -185,16 +185,6 @@ int bootdev_find_in_blk(struct udevice *dev, struct=
 udevice *blk,
>    */
>   void bootdev_list(bool probe);
>
> -/**
> - * bootdev_clear_bootflows() - Clear bootflows from a bootdev
> - *
> - * Each bootdev maintains a list of discovered bootflows. This provides=
 a
> - * way to clear it. These bootflows are removed from the global list to=
o.
> - *
> - * @dev: bootdev device to update
> - */
> -void bootdev_clear_bootflows(struct udevice *dev);
> -
>   /**
>    * bootdev_first_bootflow() - Get the first bootflow from a bootdev
>    *
> diff --git a/include/bootstd.h b/include/bootstd.h
> index 3fc93a4ec2e..4220ece785d 100644
> --- a/include/bootstd.h
> +++ b/include/bootstd.h
> @@ -122,4 +122,14 @@ int bootstd_prog_boot(void);
>    */
>   int bootstd_add_bootflow(struct bootflow *bflow);
>
> +/**
> + * bootstd_clear_bootflows_for_bootdev() - Clear bootflows from a bootd=
ev
> + *
> + * Each bootdev maintains a list of discovered bootflows. This provides=
 a
> + * way to clear it. These bootflows are removed from the global list to=
o.
> + *
> + * @dev: bootdev device to update
> + */
> +int bootstd_clear_bootflows_for_bootdev(struct udevice *dev);
> +
>   #endif

