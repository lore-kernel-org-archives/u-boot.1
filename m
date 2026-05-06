Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1348DCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 09:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DA2847D9;
	Wed,  6 May 2026 11:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2302847FD; Wed,  6 May 2026 11:42:57 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DBA2846F4
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 11:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id D394768BFE; Wed,  6 May 2026 11:42:52 +0200 (CEST)
Received: from neoN1 (unknown [80.255.5.134])
 by verein.lst.de (Postfix) with ESMTPSA id 4FEFB6732A;
 Wed,  6 May 2026 11:42:31 +0200 (CEST)
Date: Wed, 6 May 2026 11:42:22 +0200
From: Torsten Duwe <duwe@lst.de>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>, Peter Robinson
 <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>, Andrea della
 Porta <andrea.porta@suse.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] nvme: Fix missing inbound DMA offset calculation
Message-ID: <20260506114222.0284d200@neoN1>
In-Reply-To: <0f10ff43-f2d6-4f6d-a1d5-13f7a1206a59@linaro.org>
References: <20260430145412.BC53E68AFE@verein.lst.de>
 <fcdac873-bba4-4a76-853b-23672989d43f@linaro.org>
 <0f10ff43-f2d6-4f6d-a1d5-13f7a1206a59@linaro.org>
Organization: LST e.V.
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; aarch64-suse-linux-gnu)
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

On Wed, 6 May 2026 10:59:55 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 5/6/26 09:52, Neil Armstrong wrote:
> > On 4/30/26 16:54, Torsten Duwe wrote:
[...]
> >> +/*
> >> + * This macro detects the correct inbound DMA offset in both cases:
> >> + *=C2=A0=C2=A0 1) the NVMe is mentioned in the device tree, along wit=
h its parent,
> >> + *=C2=A0=C2=A0=C2=A0 and no intermediate PCIe bus node in between.
> >> + *=C2=A0=C2=A0 2) the NVMe was found dynamically by PCI enumeration w=
hich has created
> >> + *=C2=A0=C2=A0=C2=A0 an intermediate PCIe bus node. That node will be=
 skipped and the offset
> >> + *=C2=A0=C2=A0=C2=A0 looked up in the grandparent.
> >> + */
> >> +#define DEV_ADDR(a)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (dev_ha=
s_ofnode(dev->udev) ? \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_phys_to_bus(dev->udev, (a=
)) : \
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_phys_to_bus(dev->udev->pa=
rent, (a)))
> >=20
> > This looks subspicious, what is the state of the rpi5 here ? with a DT =
node or without ?
> >=20
> > AFAIK NVMes are always dynamically detected, it seems the dma_offset is=
 not correctly
> > copied to the nvme udev when created.

Yes, they are _usually_ detected via PCI enumeration, which dynamically
adds a bus node without a corresponding DT node. But it is not prohibited
to explicitly specify an NVMe disk in the device tree, I think. We've seen
this with the RP1 chip (patches yet to come). With and without.

>=20
> So to check could you try adding something like:
>=20
> ```
> diff --git a/dts/upstream/src/arm64/broadcom/bcm2712-rpi-5-b-base.dtsi b/=
dts/upstream/src/arm64/broadcom/bcm2712-rpi-5-b-base.dtsi
> index 04738bf281e..640c5987077 100644
> --- a/dts/upstream/src/arm64/broadcom/bcm2712-rpi-5-b-base.dtsi
> +++ b/dts/upstream/src/arm64/broadcom/bcm2712-rpi-5-b-base.dtsi
> @@ -247,6 +247,15 @@
>=20
>   &pcie1 {
>          status =3D "okay";
> +
> +       pci@0,0 {
> +               reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +               ranges;
> +               bus-range =3D <0 1>;
> +               device_type =3D "pci";
> +               #address-cells =3D <3>;
> +               #size-cells =3D <2>;
> +       };
>   };
>=20
>   &pcie2 {
> ```

We've had that in a previous version. The downside of this is that it
would have to be done for each platform and each potential m.2 socket.

> or:
>=20
> ```
> --- a/drivers/core/device.c
> +++ b/drivers/core/device.c
> @@ -459,7 +459,19 @@ static int device_get_dma_constraints(struct udevice=
 *dev)
>          u64 size =3D 0;
>          int ret;
>=20
> -       if (!CONFIG_IS_ENABLED(DM_DMA) || !parent || !dev_has_ofnode(pare=
nt))
> +       if (!CONFIG_IS_ENABLED(DM_DMA) || !parent)
> +               return 0;
> +
> +       /* Look for the first node in the parent chain */
> +       while (parent) {
> +               if (dev_has_ofnode(parent))
> +                       break;
> +
> +               parent =3D dev_get_parent(parent);
> +       }
> +
> +       /* No parents have a node, bail out */
> +       if (!parent)
>                  return 0;
>=20
>          /*
> ```
> Which will try to find the node higher in the parent chain.

Now this looks extremely tempting. It should solve the problem for NVMe
and probably a few other PCI(e) scenarios in the future.

I'll give it a spin...
Thanks,

	Torsten
