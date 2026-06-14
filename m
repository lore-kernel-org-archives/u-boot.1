Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3626ACD8CA8
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 21:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBF3846A4;
	Sun, 14 Jun 2026 23:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF7884704; Sun, 14 Jun 2026 23:06:35 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF1283FEE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 23:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 5F28537002F3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 21:06:31 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 229C0B45788; Sun, 14 Jun 2026 21:06:30 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id B263FB45780;
 Sun, 14 Jun 2026 21:06:28 +0000 (UTC)
Date: Sun, 14 Jun 2026 23:06:26 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>
Subject: Re: [PATCH] ARM: fdt: copy TF-A reserved memory into fdt passed to
 Linux
Message-ID: <ai8X0ovb5V1zTJR9@collins>
References: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
 <ai6yjsgw-3hnNgNM@collins>
 <b0ff98144d34468c133cd62935afc546135b47ec.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="imIvaI+ef3TYTii3"
Content-Disposition: inline
In-Reply-To: <b0ff98144d34468c133cd62935afc546135b47ec.camel@gmail.com>
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


--imIvaI+ef3TYTii3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

Le Sun 14 Jun 26, 20:57, Alexander Sverdlin a =C3=A9crit :
> Hi Paul,
>=20
> On Sun, 2026-06-14 at 15:54 +0200, Paul Kocialkowski wrote:
> > > Currently some ARM-based platforms reserve TF-A memory in their own w=
ays:
> > > - Mediatek gets BL31 region via SMC call in ft_system_setup()
> > > - K3 uses CONFIG_K3_ATF_LOAD_ADDR, effectively in ft_system_setup()
> > >=20
> > > And others like Allwinner simply forget to do it, which results in Li=
nux
> > > overwriting TF-A and crashing.
> >=20
> > To be fair we've been adding the reserved memory regions statically in
> > the Linux device-trees to mitigate the issue.
>=20
> once for H616, but it could be the only SoC among ARM64 platforms doing
> this and discouraged for A133:
> https://lore.kernel.org/all/b428d57ba5464f1226daf099877f4c25fa4fc191.came=
l@gmail.com/

Yes of course it would be better to have a proper solution for this.
I was only mentioning this for context.

> > But another thing we do overwrite current is the cpu idle states, which
> > are added by fdt_add_cpu_idle_states in tf-a. These are only set when t=
he
> > SCP firmware is available (which is checked at run-time) and they are
> > never propagated to the final device-tree. Including the definitions
> > statically would result in cpu idle calls done even without the SCP
> > firmware, which would probably fail (although maybe some states can
> > still be supported).
>=20
> Do you refer to some unmerged code? Didn't find it in the current TF-A
> sources...

fdt_add_cpu_idle_states is in common/fdt_fixup.c and it is called by the
common allwinner code in plat/allwinner/common/sunxi_prepare_dtb.c based
on the sunxi_psci_is_scpi check (which currently always returns false
for A133).

> > Also note that the usual way to deal with this is to not load any
> > device-tree when booting the kernel, which will implicitly let U-Boot
> > use its current device-tree for Linux (with the modifications brought by
> > tf-a).
>=20
> ?!
> We definitely want to load the very device tree coming in the FIT image
> and pass it to the kernel from this FIT image. Sometimes people would
> have several DTs to chose from. The thing in U-Boot is basically to
> get U-Boot up and running. OF_UPSTREAM is rather to reduce the traffic
> on the U-Boot mailing list and maintainers effort, but in most of the
> cases we shall expect this DT to be not from the kernel we actually load.

Yes maybe "usual way" was not the best way to put it. "Current workaround"
would maybe have been better wording. Anyway we agree that this is not a
satisfying situation.

> > But of course I agree that it is very desirable to "forward" the
> > device-tree modifications to the kernel device-tree so we are not stuck
> > with whatever device-tree U-Boot was built with.
> >=20
> > > Unfortunately seems that the things are not much better on TF-A side =
and
> > > there is no universal way to get the reserved memory region across
> > > platforms. But there is at least a most common way in TF-A, namely
> > > reserving=C2=A0 memory range in the FDT, in particular:
> > > - Allwinner	("tf-a@40000000" node)
> > > - ARM FPGA	("tf-a@80000000" node)
> > > - Xilinx	("tf-a" node)
> >=20
> > RaspberryPi seems to be using "atf@0". Generally speaking the property
> > is a free-form argument to fdt_add_reserved_memory in tf-a and I don't
> > think we can have a common way to match them.
> >=20
> > Introducing a Kconfig property for the prefix would be a satisfying
> > solution in my opinion.
>=20
> This was a very conservative patch solving the A133 case, but actually
> I don't see anything wrong with just copying all the reserved areas from
> the U-Boot live tree to the device tree we are going to pass to the
> kernel. Maybe fdtdec_add_reserved_memory() needs to be taught to detect
> overlapping ranges and extend them properly, or maybe yet another function
> has to be created for this purpose, to avoid duplicated reserved-memory
> nodes by all means,

Yes maybe a more generic approach that goes over each reserved memory
node and decides whether it needs to be copied or not would be best.
I would still be satisfied with a Kconfig prefix though.

> but would also solve the PSCI cpuidle issue, as well
> as potentially Raspi case of TF-A side and simplify TI K3 on U-Boot side.

Well the idle-state node is not in reserved-memory, it is part of the
cpus node, but it would be fairly easy to copy it over if no such node
already exists.

> > > While this patch aims to improve the situation for Allwinner platform=
s,
> > > it's deliberately adding more generic code to pave the potential way =
of
> > > unification for other platforms.
> > >=20
> > > Note that fdtdec_add_reserved_memory() has a check for an already exi=
sting
> > > carveout with exactly matching boundaries and will not create a dupli=
cate
> > > even if the name doesn't match. It would not however detect an already
> > > existing bigger carveout fully containing the one requested.
> > >=20
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > > ---
> > > The patch has been developed to faciliate Allwinner A133 SoC support,=
 where
> > > most of the work currently happens on TF-A [1] and Linux [2] sides, b=
ut
> > > I wanted to send this patch upfront to get the first feedback and bec=
ause
> > > already supported H616 SoC would already benefit from the patch.
> >=20
> > Thanks for looking at this!
> >=20
> > Like I said, I guess the same needs to be done for the cpuidle psci
> > nodes.
>=20
> See above, maybe there is a way to carefully copy all /reserved-memory no=
des?
> Maybe this full copy shall be configurable, but with a proper overlapping=
-aware
> implementation maybe even a Kconfig option is not required...

It is separate from reserved-memory.

All the best,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--imIvaI+ef3TYTii3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmovF9IACgkQhP3B6o/u
lQxhbw//dxorFleC95AwVkSCokdLo6ncAoY6F1H1oA3cwmQt6BgbFnUYIdLmn3+2
PcGg26Z32r9t223vcwoD7PGCV4LBWuOAlXcg5ODBAvMv71FJGW1yebyH6zpfJd8Z
3MsfgAg8LRZKLm2UzTOPd/EVueyA0BL51nwXVX5L2vUUXiqlcUnFiPBJxwE3GB44
BF5kNNE8UWLlv8mBtCKPf0avmudoERh2jKk0ML/1odSuhh7FMMpgql6boxOFElMa
xDmHJs8HPO19EKph8vGdHG/p02u+UwfIZ62viDsNgZ9XosCgBAeIz7to2CEG/ni+
y+MrYrp5/ylKX5VFguHT6vAdZeVY+PTbxA4PJxHrg3X65/I395ZoceyD6XVSPyoZ
XpSeMg74/EUsrQtpSs3HiDZhZhHdD0Jm23RccBebtNywZ+wxsK2W9/4khUaU0CwA
YfVEVIjldRaCOEGEGteyOmaEoxM5Qr7/z8RdbfTBWj41cR21kxaV+WYDGQOIHW2q
qJe6MtPzQ2gpm7kQN37fuc6LKpChanK3i/r3f5MAZIdAUpc7VqElEYvL7wstGvpY
HQnq9Ae/5fsH7SDow5CJ6IyRrW7tBSykeB9LKF5eSofQoKm2IQcJ0uCnaePq0czt
IhLfQTrzUjUgjz1eMTDM46UiQu73WU8IObQL6nXSj2MNIR+2xxM=
=+HFG
-----END PGP SIGNATURE-----

--imIvaI+ef3TYTii3--
