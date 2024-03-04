Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749B1C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6BE887FC8;
	Mon,  4 Mar 2024 15:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DZagQb4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F24E87FCB; Mon,  4 Mar 2024 15:48:23 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 177F187FC7
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id F2C9BCE12DD;
 Mon,  4 Mar 2024 14:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBABC433F1;
 Mon,  4 Mar 2024 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709563698;
 bh=RqbUDH0ISJyj4A2QFtevie4hKUuH628UCbgirF3il5o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DZagQb4Bdxq76N46i2q4KBPjOL25OnhRtjE0gKryll2yx9m9WwYNjH50F+FgEsyK9
 MlJufx9a+mZ9yacCVrjm1ZyacVWy2r8zsEg2qW2HFDyc2vXZlWzSylpDe/2m41X7T9
 PsyLkL1EYpX5ytBfpdirTde6flZ7+/zh5MzzwlhTZlAhm2LUu+wJqv3fbxc5zffLXU
 KcWgXvOF7PPn8WwOdcDaJvVhyBfual2T4QOHdvGw7fV3G2fIYlWWhVe1dsRO6wrHlU
 321NszWtHl0iX2l69d38enNRH0Y9QZlXJ6LqeR2qKp1GoJgGis7vnlp1ErCqF36hfV
 ITmWl+7DeAsUg==
Date: Mon, 4 Mar 2024 15:48:12 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: Marek =?UTF-8?B?TW9qw61r?= <marek.mojik@nic.cz>, rfried.dev@gmail.com,
 u-boot@lists.denx.de, joe.hershberger@ni.com, tharvey@gateworks.com,
 marex@denx.de
Subject: Re: [PATCH v2] net: mv88e6xxx: fix missing SMI address initialization
Message-ID: <20240304154812.48850405@dellmb>
In-Reply-To: <45ffb9f2-8986-4d85-868e-eca618ff16ab@denx.de>
References: <62eoapvurxkedw74vpzb55q3nuqgb4cef3bl2laayx57cpjzus@vlpx57cjc4ph>
 <20231218170930.4afe5dbd@dellmb>
 <c620d56f-29b6-4819-a51f-dca962a2ec64@denx.de>
 <45ffb9f2-8986-4d85-868e-eca618ff16ab@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
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

Hi Stefan,

On Wed, 14 Feb 2024 08:50:16 +0100
Stefan Roese <sr@denx.de> wrote:

> Hi Ramon,
>=20
> On 1/9/24 10:37, Stefan Roese wrote:
> > On 12/18/23 17:09, Marek Beh=C3=BAn wrote: =20
> >> On Wed, 6 Dec 2023 15:35:56 +0100
> >> Marek Moj=C3=ADk <marek.mojik@nic.cz> wrote:
> >> =20
> >>> The mv88e6xxx driver does not currently initialize the smi_addr=20
> >>> field, but
> >>> instead keeps the default zero value. This leads to driver being=20
> >>> unusable
> >>> on devices where the switch is not on address zero of the mdio bus. F=
ix
> >>> this problem by reading the SMI address from device tree.
> >>>
> >>> Signed-off-by: Marek Moj=C3=ADk <marek.mojik@nic.cz>
> >>> ---
> >>> =C2=A0 drivers/net/mv88e6xxx.c | 8 ++++++++
> >>> =C2=A0 1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
> >>> index c073f81e72..8fbbc1cacc 100644
> >>> --- a/drivers/net/mv88e6xxx.c
> >>> +++ b/drivers/net/mv88e6xxx.c
> >>> @@ -745,6 +745,7 @@ static int mv88e6xxx_probe(struct udevice *dev)
> >>> =C2=A0 {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dsa_pdata *dsa_pdata =3D dev_ge=
t_uclass_plat(dev);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mv88e6xxx_priv *priv =3D dev_ge=
t_priv(dev);
> >>> +=C2=A0=C2=A0=C2=A0 fdt_addr_t smi_addr;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, ret;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ofnode_valid(dev_ofnode(dev)) &&
> >>> @@ -753,6 +754,13 @@ static int mv88e6xxx_probe(struct udevice *dev)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> +=C2=A0=C2=A0=C2=A0 smi_addr =3D dev_read_addr(dev);
> >>> +=C2=A0=C2=A0=C2=A0 if (smi_addr =3D=3D FDT_ADDR_T_NONE) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Missing SMI=
 address\n");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +=C2=A0=C2=A0=C2=A0 priv->smi_addr =3D smi_addr;
> >>> +
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* probe internal mdio bus */
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D mv88e6xxx_probe_mdio(dev);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
> >>
> >> Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org> =20
> >=20
> > Reviewed-by: Stefan Roese <sr@denx.de>
> >=20
> > Ramon, this patch was assigned to me as an Marvell MVEBU patch
> > depends on it. I've assigned it to you now. Or if it's okay that
> > I pull it with the Marvell tree, just let me know. =20
>=20
> Any updates on this?
>=20
> Thanks,
> Stefan

Stefan, it seems that Ramon is unavailable for this.
Can we take this? We've been using it on Omnia and it works correctly.

Marek
