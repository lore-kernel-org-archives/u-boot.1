Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AA8D1CA01
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58F2788E50;
	Mon,  4 Nov 2024 23:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BnSOTHHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FC088E77; Mon,  4 Nov 2024 23:02:06 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9050788D4A
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730757722; x=1731362522; i=xypron.glpk@gmx.de;
 bh=TO5e2WtjqOwslIY97KQ0fH61FCZvKjHdi8pyIDHBF3E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BnSOTHHwrxKoTNeYqCWd33LxUBlpndya2yMHTrR5uptMn9QFELYcEJs+RCYulSdF
 kIGUxh8aMlvbbv4PuaNihLnZMKdj04tvqHG95Gxs2CImVjwy8acWnS4gk/MyKj1Zq
 fmMr3BDRQhKALvDVHBI+AB3IUremYI5QzdV0e2xQw/oao64Ks5jcCocsZ962ksPVX
 iQ6j8Ld06aMihl4BZo0p9cC6Kwh+chZoxSEJQ9AKy30yTHWGYZm48ONv+nJ1YHnS2
 J+nliKeKhBHxXbvpbmifjP/FtJrUanlZqpHPLv8WlrGvm4ZNAdKJY7OLHKqAgIPJW
 6caAzCDOwb2eOX3Irw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.108.63]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5eX-1tQQwh0ipx-00Vul4; Mon, 04
 Nov 2024 23:02:02 +0100
Message-ID: <d2822624-f9a0-4bc6-a911-861c7b2ac88e@gmx.de>
Date: Mon, 4 Nov 2024 23:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/19] bootstd: Move bootflow-adding to bootstd
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241104175110.1048449-1-sjg@chromium.org>
 <20241104175110.1048449-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241104175110.1048449-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9zcNhJhWejDh/6fFM1bWmN4HvLTHHbp97UmyqeyJ8f/IxlRoRqJ
 aClz7hwdKWRIhtoUbAffZacTx0x+SqGuK58pSezNa4mlUlTYqD1Ga9GolWZYZ2UyXTDHIvx
 LqUmsIG7POp7DX0kTMX3XTNiTSVXXrFnnBAXbKWjDVaTfC/2HYJTWXAraixZic/ExqiZTHo
 wnxruBB/GQVq5RQbng6EQ==
UI-OutboundReport: notjunk:1;M01:P0:0wtxjIzFniY=;xAwq3wtWn0cxIud1ZRkFm7GYpEZ
 4J56mvSebBNjTIYIilXJ1/beDtyugiNxRc8p9u3F9cCZnICeVo1oEAdCe0Ng1XHICqOgHsz5E
 rH8QfjCMSSC/rsYdLeXEeqR2vjNkRIus37/5am1VSUp9fGkDcicXv9OrjEQSxSLVsEd3sD/aa
 SrlZ0h2atx7juy0Yr/HC/9Dkm20U7PL3eQ1JKecpSWyqiNfg+q+uRZRxVbTKPNVKlOdK731vh
 O96dlsp4IAtCl1EWkRxf1PRwY1V+DySqMRjMiJJCiJEg1kN9+zeUeCUkim6sczrFw5ccGMJz5
 KelK9DFUFkkOLsiXZHEdeTWFHsOIxFPkiCdUMYU2X6RvWJ/3NdKFdPTTdXZ6TwUaDki7yvH58
 HheITNfy1IkJb7wcMhOcWEJRf341Zdj1PNntmvEmW1z6VchQOLw/kbtIvNGWKdIq/u7Rv7CjX
 oWhOXYSy87ME7JEB3JduG6N6Tenr7bhy030V5Zg6ENxTAB/2n09UvjNBUv6q8tanHBDBBMi8U
 cP5O5MzQ3OLMVdfkj2qpCSCo00LYPneYt7l401qqWbQfqxF4QFSJDJipc0qk3aBfDQ0cPCOtA
 mRSVZWCjsHAHF8mYJRJASu7kxblH/J/3afQjzKSztmaMVzTCsWxCSWvw42Q1cTb5Xilt71zgj
 GJQeMo/0DcRuDHTi2bQdw+N9Rl1Ige58iNwAjp3an/DRBEHdMgxv0BuE5hy9TnF1DdKVi+xkE
 GA8+0whyXty8jdNYzktEtp7Q1dm03TnTOwnYU02G6lr8PXiFjnUgCtKEy3AFcoNf9pE0CZ+h+
 jxEnmlScUo1ncG3PdiyfDOGA==
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
> ---
>
> (no changes since v1)
>
>   boot/bootdev-uclass.c | 25 -------------------------
>   boot/bootstd-uclass.c | 25 +++++++++++++++++++++++++
>   cmd/bootflow.c        |  2 +-
>   include/bootdev.h     | 15 ---------------
>   include/bootstd.h     | 17 +++++++++++++++++
>   5 files changed, 43 insertions(+), 41 deletions(-)
>
> diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> index 64ec4fde493..eddbf60600c 100644
> --- a/boot/bootdev-uclass.c
> +++ b/boot/bootdev-uclass.c
> @@ -32,31 +32,6 @@ enum {
>   	BOOT_TARGETS_MAX_LEN	=3D 100,
>   };
>
> -int bootdev_add_bootflow(struct bootflow *bflow)
> -{
> -	struct bootstd_priv *std;
> -	struct bootflow *new;
> -	int ret;
> -
> -	ret =3D bootstd_get_priv(&std);
> -	if (ret)
> -		return ret;
> -
> -	new =3D malloc(sizeof(*bflow));
> -	if (!new)
> -		return log_msg_ret("bflow", -ENOMEM);
> -	memcpy(new, bflow, sizeof(*bflow));
> -
> -	list_add_tail(&new->glob_node, &std->glob_head);
> -	if (bflow->dev) {
> -		struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(bflow->dev);
> -
> -		list_add_tail(&new->bm_node, &ucp->bootflow_head);
> -	}
> -
> -	return 0;
> -}
> -
>   int bootdev_first_bootflow(struct udevice *dev, struct bootflow **bflo=
wp)
>   {
>   	struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(dev);
> diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
> index fdb8d69e320..bf6e49ad97a 100644
> --- a/boot/bootstd-uclass.c
> +++ b/boot/bootstd-uclass.c
> @@ -61,6 +61,31 @@ void bootstd_clear_glob(void)
>   	bootstd_clear_glob_(std);
>   }
>
> +int bootstd_add_bootflow(struct bootflow *bflow)
> +{
> +	struct bootstd_priv *std;
> +	struct bootflow *new;
> +	int ret;
> +
> +	ret =3D bootstd_get_priv(&std);
> +	if (ret)
> +		return ret;
> +
> +	new =3D malloc(sizeof(*bflow));
> +	if (!new)
> +		return log_msg_ret("bflow", -ENOMEM);
> +	memcpy(new, bflow, sizeof(*bflow));
> +
> +	list_add_tail(&new->glob_node, &std->glob_head);
> +	if (bflow->dev) {
> +		struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(bflow->dev);
> +
> +		list_add_tail(&new->bm_node, &ucp->bootflow_head);
> +	}
> +
> +	return 0;
> +}
> +
>   static int bootstd_remove(struct udevice *dev)
>   {
>   	struct bootstd_priv *priv =3D dev_get_priv(dev);
> diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> index f67948d7368..8962464bbf8 100644
> --- a/cmd/bootflow.c
> +++ b/cmd/bootflow.c
> @@ -207,7 +207,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, i=
nt flag, int argc,
>   		bflow.err =3D ret;
>   		if (!ret)
>   			num_valid++;
> -		ret =3D bootdev_add_bootflow(&bflow);
> +		ret =3D bootstd_add_bootflow(&bflow);
>   		if (ret) {
>   			printf("Out of memory\n");
>   			return CMD_RET_FAILURE;
> diff --git a/include/bootdev.h b/include/bootdev.h
> index ad4af0d1310..8db198dd56b 100644
> --- a/include/bootdev.h
> +++ b/include/bootdev.h
> @@ -195,21 +195,6 @@ void bootdev_list(bool probe);
>    */
>   void bootdev_clear_bootflows(struct udevice *dev);
>
> -/**
> - * bootdev_add_bootflow() - Add a bootflow to the bootdev's list
> - *
> - * All fields in @bflow must be set up. Note that @bflow->dev is used t=
o add the
> - * bootflow to that device.
> - *
> - * @dev: Bootdev device to add to
> - * @bflow: Bootflow to add. Note that fields within bflow must be alloc=
ated
> - *	since this function takes over ownership of these. This functions ma=
kes
> - *	a copy of @bflow itself (without allocating its fields again), so th=
e
> - *	caller must dispose of the memory used by the @bflow pointer itself
> - * Return: 0 if OK, -ENOMEM if out of memory
> - */
> -int bootdev_add_bootflow(struct bootflow *bflow);
> -
>   /**
>    * bootdev_first_bootflow() - Get the first bootflow from a bootdev
>    *
> diff --git a/include/bootstd.h b/include/bootstd.h
> index ac756e98d84..3fc93a4ec2e 100644
> --- a/include/bootstd.h
> +++ b/include/bootstd.h
> @@ -105,4 +105,21 @@ void bootstd_clear_glob(void);
>    */
>   int bootstd_prog_boot(void);
>
> +/**
> + * bootstd_add_bootflow() - Add a bootflow to the bootdev's and global =
list
> + *
> + * All fields in @bflow must be set up. Note that @bflow->dev is used t=
o add the
> + * bootflow to that device.
> + *
> + * The bootflow is also added to the global list of all bootflows
> + *
> + * @dev: Bootdev device to add to

This parameter does not exist.

> + * @bflow: Bootflow to add. Note that fields within bflow must be alloc=
ated
> + *	since this function takes over ownership of these. This functions ma=
kes
> + *	a copy of @bflow itself (without allocating its fields again), so th=
e
> + *	caller must dispose of the memory used by the @bflow pointer itself

Please, add the headers to the API documentation and fix the numerous
documentation issues like:

./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_0_NONE' not
described in enum 'bootdev_prio_t'
./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_1_PRE_SCAN' not
described in enum 'bootdev_prio_t'
./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_COUNT' not
described in enum 'bootdev_prio_t'
./include/bootdev.h:57: warning: Excess enum value 'BOOTDEVP_6_PRE_SCAN'
description in 'bootdev_prio_t'
./include/bootdev.h:118: warning: Function parameter or member
'bootflow_head' not described in 'bootdev_uc_plat'
./include/bootdev.h:118: warning: Function parameter or member 'prio'
not described in 'bootdev_uc_plat'
./include/bootdev.h:412: warning: Function parameter or member 'blk' not
described in 'bootdev_setup_for_sibling_blk'
./include/bootdev.h:412: warning: Excess function parameter 'parent'
description in 'bootdev_setup_for_sibling_blk'

Best regards

Heinrich

> + * Return: 0 if OK, -ENOMEM if out of memory
> + */
> +int bootstd_add_bootflow(struct bootflow *bflow);
> +
>   #endif

