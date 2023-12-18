Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3339BC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 16:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60112871DE;
	Mon, 18 Dec 2023 17:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u+NDkD/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF2E87252; Mon, 18 Dec 2023 17:09:37 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72CF871CE
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 17:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 52D98B80E28;
 Mon, 18 Dec 2023 16:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D102C433CA;
 Mon, 18 Dec 2023 16:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702915774;
 bh=iE+YtfoBjIkRsIGLBg0U424X29lSMkkxoQkGq1dfrx4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=u+NDkD/dzoJRUW6GTXH5MEwRQS1QIScN49MyFcUTYVql1l+dQEufAnuHNW/Aayfh9
 aEYeaoEWizOskVrJ9450Upjl3rO2NRDVPSCFEvWR56BYkjPlOx6KVzXvfWieq0DgmT
 KJpNuMz5h8ZMFUonvAwEnnVMmHPdqZ8S1c7BYHdcMzeSnrykT7dq0fy3ziT7plglPK
 hFOm7kc2uH1PFhXzCcYHppIsL2pWjSqCHi/SDZSPzaqThj7gs4viRbLD0johTDl/x6
 xx7yb5fVKGrMxCtDrdRpVOlmitKM/rYygzYIZl/4yMkPjrYGNuWeYgLnb+p3ti0SnP
 JMzAbfSIUqfuQ==
Date: Mon, 18 Dec 2023 17:09:30 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Marek =?UTF-8?B?TW9qw61r?= <marek.mojik@nic.cz>, rfried.dev@gmail.com
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, tharvey@gateworks.com,
 marex@denx.de
Subject: Re: [PATCH v2] net: mv88e6xxx: fix missing SMI address initialization
Message-ID: <20231218170930.4afe5dbd@dellmb>
In-Reply-To: <62eoapvurxkedw74vpzb55q3nuqgb4cef3bl2laayx57cpjzus@vlpx57cjc4ph>
References: <62eoapvurxkedw74vpzb55q3nuqgb4cef3bl2laayx57cpjzus@vlpx57cjc4ph>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 6 Dec 2023 15:35:56 +0100
Marek Moj=C3=ADk <marek.mojik@nic.cz> wrote:

> The mv88e6xxx driver does not currently initialize the smi_addr field, but
> instead keeps the default zero value. This leads to driver being unusable
> on devices where the switch is not on address zero of the mdio bus. Fix
> this problem by reading the SMI address from device tree.
>=20
> Signed-off-by: Marek Moj=C3=ADk <marek.mojik@nic.cz>
> ---
>  drivers/net/mv88e6xxx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
> index c073f81e72..8fbbc1cacc 100644
> --- a/drivers/net/mv88e6xxx.c
> +++ b/drivers/net/mv88e6xxx.c
> @@ -745,6 +745,7 @@ static int mv88e6xxx_probe(struct udevice *dev)
>  {
>  	struct dsa_pdata *dsa_pdata =3D dev_get_uclass_plat(dev);
>  	struct mv88e6xxx_priv *priv =3D dev_get_priv(dev);
> +	fdt_addr_t smi_addr;
>  	int val, ret;
> =20
>  	if (ofnode_valid(dev_ofnode(dev)) &&
> @@ -753,6 +754,13 @@ static int mv88e6xxx_probe(struct udevice *dev)
>  		return -ENODEV;
>  	}
> =20
> +	smi_addr =3D dev_read_addr(dev);
> +	if (smi_addr =3D=3D FDT_ADDR_T_NONE) {
> +		dev_err(dev, "Missing SMI address\n");
> +		return -EINVAL;
> +	}
> +	priv->smi_addr =3D smi_addr;
> +
>  	/* probe internal mdio bus */
>  	ret =3D mv88e6xxx_probe_mdio(dev);
>  	if (ret)

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
