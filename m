Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F89CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 07:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6648834D4;
	Thu,  2 Oct 2025 09:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SfCU8RkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CBF83526; Thu,  2 Oct 2025 09:53:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3639C828A2
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 09:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1759391616; x=1759996416; i=xypron.glpk@gmx.de;
 bh=nv8a7ZpMT4ibcs1tHkIuxhOrT/FgaQYsdGlhzG0ZRpo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SfCU8RkMVEIpiPAGtb5xMObYNhuQM3acHMSABk49BFmX//GQXkOL2IqfFw10Eyfc
 MRmjzOZNFA5j0kGbulJ4jIe6/wK3PP91KZ712NBepBfydHnrcGOukVkPWQESuxVfp
 jhh4FfBi5J6CwS2iyp1iE/7ADgfz+dvaMk18V259k/RDUbCbfeHgGOQbtWinqTRb/
 3S4ZSTCHg4U0lJzlstM3obZTYcGQptFW/EPCjZgF0CbqycxdEne6oDGvPAgQT1I47
 el1/01Auo6p/4ddoKW7Ef9LbFZzbwcR51n4ufYoyQIAiVQtmCqsxd18VnUTiEcnDX
 08iB6tlAdbcnK2F99g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1uP80n3qK6-00bEjw; Thu, 02
 Oct 2025 09:53:35 +0200
Message-ID: <032cec91-0663-4084-b58c-44ea3773ee2e@gmx.de>
Date: Thu, 2 Oct 2025 09:53:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] boot: Improve comments related to global
 bootmeths
To: Simon Glass <sjg@chromium.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251001212649.3263574-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZafIg2DZtvsMPwNxIH5fB+yDkC1d9EDjRQdR0KzLYDouGc6TWYj
 bYypyG0XedJEFtXPEdfnqe2lExXabi5PFD3oItA5qSplB1f+MdFClz3PtCdGn+IdVXxzFYY
 j1LMn7Jj1INpOj4US1Au/NJXdp2fCznrygUOgXD/ZRIOjL7nvPIi0OXdV7yL2aP8sSde+/0
 QMkR7OvD412JPyWL7fb0Q==
UI-OutboundReport: notjunk:1;M01:P0:WgwiCUdXFNo=;ZO5dm0g4nYEnfaqiS3v1s0SJsUa
 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
 T0Li12JKC+sEtp8Lg=
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

On 10/1/25 23:26, Simon Glass wrote:
> Add a few comments about global bootmeths and first_glob_method
>=20
> Fix a broken line in bootmeth_setup_iter_order() while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>=20
> (no changes since v1)
>=20
>   boot/bootflow.c        | 3 ++-
>   boot/bootmeth-uclass.c | 4 ++--
>   include/bootflow.h     | 3 ++-
>   test/boot/bootflow.c   | 2 +-
>   4 files changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index d79f303486d..8f38a1ab940 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -147,7 +147,7 @@ static void bootflow_iter_set_dev(struct bootflow_it=
er *iter,
>   			if (dev)
>   				printf("Scanning bootdev '%s':\n", dev->name);
>   			else if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) &&
> -				ucp->flags & BOOTMETHF_GLOBAL)
> +				 ucp->flags & BOOTMETHF_GLOBAL)
>   				printf("Scanning global bootmeth '%s':\n",
>   				iter->method->name);
>   			else
> @@ -344,6 +344,7 @@ static int bootflow_check(struct bootflow_iter *iter=
, struct bootflow *bflow)
>   	struct udevice *dev;
>   	int ret;
>  =20
> +	/* handle global bootmeths if needed */
>   	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global) {
>   		bootflow_iter_set_dev(iter, NULL, 0);
>   		ret =3D bootmeth_get_bootflow(iter->method, bflow);
> diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
> index 188f6ea1895..918d78ec2c9 100644
> --- a/boot/bootmeth-uclass.c
> +++ b/boot/bootmeth-uclass.c
> @@ -156,8 +156,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *=
iter, bool include_global)
>   				}
>  =20
>   				ucp =3D dev_get_uclass_plat(dev);
> -				is_global =3D ucp->flags &
> -					BOOTMETHF_GLOBAL;
> +				is_global =3D ucp->flags & BOOTMETHF_GLOBAL;
>   				if (is_global) {
>   					iter->first_glob_method =3D i;
>   					break;
> @@ -204,6 +203,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *=
iter, bool include_global)
>   		goto err_order;
>   	}
>  =20
> +	/* start with the global bootmeths */
>   	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && include_global &&
>   	    iter->first_glob_method !=3D -1 && iter->first_glob_method !=3D c=
ount) {
>   		iter->cur_method =3D iter->first_glob_method;
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 32422067723..2ef6eb25cf5 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -250,7 +250,8 @@ enum bootflow_meth_flags_t {
>    * @cur_label: Current label being processed
>    * @num_methods: Number of bootmeth devices in @method_order
>    * @cur_method: Current method number, an index into @method_order
> - * @first_glob_method: First global method, if any, else -1
> + * @first_glob_method: Index of first global method within @method_orde=
r[], if
> + * any, else -1
>    * @cur_prio: Current priority being scanned
>    * @method_order: List of bootmeth devices to use, in order. The norma=
l methods
>    *	appear first, then the global ones, if any
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 8de5a310add..7cd83dc7443 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -401,7 +401,7 @@ static int bootflow_system(struct unit_test_state *u=
ts)
>   	ut_assertok(device_probe(dev));
>   	sandbox_set_fake_efi_mgr_dev(dev, true);
>  =20
> -	/* We should get a single 'bootmgr' method right at the end */
> +	/* We should get a single 'bootmgr' method at the start */
>   	bootstd_clear_glob();
>   	ut_assertok(run_command("bootflow scan -lH", 0));
>   	ut_assert_skip_to_line(

