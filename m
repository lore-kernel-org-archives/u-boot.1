Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C930CDB46B
	for <u-boot@archiver.kernel.org>; Sat, 20 Jun 2026 12:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723B184874;
	Sat, 20 Jun 2026 14:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF4E848EB; Sat, 20 Jun 2026 14:50:46 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D849684873
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 14:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 220FF37002F4
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 12:50:41 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id B068EAE0165; Sat, 20 Jun 2026 12:50:39 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 4E576AE0164;
 Sat, 20 Jun 2026 12:50:38 +0000 (UTC)
Date: Sat, 20 Jun 2026 14:50:35 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>
Subject: Re: [PATCH] ARM: fdt: copy TF-A reserved memory into fdt passed to
 Linux
Message-ID: <ajaMm497ytDEu-Nu@collins>
References: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
 <ai6yjsgw-3hnNgNM@collins>
 <b0ff98144d34468c133cd62935afc546135b47ec.camel@gmail.com>
 <bd873f94-32af-43f2-be0a-a807fa1ad263@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UTAXFXrqwe+86pXu"
Content-Disposition: inline
In-Reply-To: <bd873f94-32af-43f2-be0a-a807fa1ad263@arm.com>
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


--UTAXFXrqwe+86pXu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

Le Tue 16 Jun 26, 16:10, Andre Przywara a =C3=A9crit :
> On 6/14/26 20:57, Alexander Sverdlin wrote:
> > ?!
> > We definitely want to load the very device tree coming in the FIT image
> > and pass it to the kernel from this FIT image. Sometimes people would
> > have several DTs to chose from. The thing in U-Boot is basically to
> > get U-Boot up and running. OF_UPSTREAM is rather to reduce the traffic
> > on the U-Boot mailing list and maintainers effort, but in most of the
> > cases we shall expect this DT to be not from the kernel we actually loa=
d.
>=20
> Sorry, buy I completely and strongly disagree here. This concept of "let =
me
> load the DT that shipped with the kernel I am going to load" was ill-fated
> from the very beginning, but back 15 years ago it was just the only
> practical way of handling things, because the bootloaders were not ready.=
 I
> understand that this is how embedded people use to do things ever since, =
but
> I don't think we should continue doing so.
>=20
> By definition firmware (the combination of SPL, TF-A, U-Boot, crust in our
> case) is device specific, so the board DT living in firmware is a good
> match. As you said, U-Boot needs the DT anyway, and since the DT describes
> the hardware, it's the same DT the kernel gets. Following this idea, there
> should be one best (golden) DT for a board at any point in time, probably
> the one from the latest kernel tree. And that's the one that goes into the
> firmware image, and that both U-Boot and the kernel use.

I think this is a vast debate that has no clear consensus. Yes there are
arguments in favor of sticking everything with the boot software, very
much like the ACPI approach of x86. But anyone who worked with ACPI also
knows the pain of having to deal with a hardware description that is not
shipped with the kernel. A large part of it is due to proprietary
bootloaders and the impossibility of modification.

With a default approach that encourages shipping the device-tree with the
bootloader, we can be guaranteed that we will see proprietary bootloaders
that will provide broken device-trees that we can never change in the
future and no way to load a different one. On the other hand if we make it
clear that the device-tree is tied to the kernel then we can safely assume
that bootloaders will provide a way to load a revised device-tree, which
has been the case so far.

It may not affect sunxi where we have a fully free and upstream boot
chain, but it will definitely happen at some point on some platforms and
we can imagine the worst case scenario with a device that has a signed
proprietary bootloader that will only load its non-standard
vendor-customized device-tree for its downstream kernel. This will make
it extremely painful to just support an upstream kernel later on.

And one could also argue that U-Boot does not need to have the same
device-tree as Linux (it could be a subset that works for multiple boards
for instance, or just have less units defined -- something I've seen a few
vendors do). It can also have specific bits that are irrelevant to Linux
(and not necessarily specified in common bindings) added to it
(the -u-boot.dtsi files). So I don't think we can really talk about a
single canonical source for the device-tree. This might also be the case
for other systems (maybe FreeBSD) that might need to tweak the device-tree
a bit at times.

In my opinion the device-tree remains related to the software that
consumes it, even though we have a lot of sharing in place. And in fact
the device-trees are still stored separately by each project and there
is no single unified canonical source that would work for everybody.

And to state the obvious, many (if not most) users still expect to load
the device-tree from the kernel and this is not going to change
overnight, so deciding to avoid this use case for new features like
passing tf-a nodes does not seem very reasonable to me.

And honestly it also makes the development process on the device-tree
side rather painful, having to reflash the bootloader everytime a new
change needs to be tested. I find it much more convenient to have
clearly separated device-trees for each project.

So I definitely strongly support the idea of doing something to pass
the tf-a node changes from device-tree to the other.

> For distro boot this is basically essential, and for UEFI based boot there
> is actually no other choice. And I like to treat the classic embedded boot
> methods more as special cases of the more generic ones.

I think both uses cases are working fine with a separate device-tree.

> I see a point of loading a custom DT during development, to play around w=
ith
> nodes and properties, but I think there are better ways to handle this:
> - Do the DT changes in the U-Boot tree, and load u-boot-sunxi-with-spl.bin
> via FEL. That's what I typically do.
> - Put your changes in DT overlays, and load and apply them in U-Boot:
>  > fdt copy $fdtcontroladdr $fdt_addr_r
>  > load mmc 0 fdtoverlay_addr_r my_ovl.dtbo
>  > fdt apply $fdtoverlay_addr_r
> - Patch your changes in using U-Boot's fdt command:
>  > fdt copy $fdtcontroladdr $fdt_addr_r
>  > fdt set /path/to/node your-property <42>
>=20
> And even if you really want to completely load your custom DT, this is
> probably changed anyway, so you could patch in the things that need
> adjustment, like the reserved memory nodes.

I still find this process rather painful and I'm sure a lot of people
would agree. Completely changing the development workflow of a large
number of people does not feel very reasonable to me either.

And to be fair, we currently support both approaches, so people who
prefer to deal with a single device-tree in u-boot can totally do that.

But I don't think we should force everybody to do this anytime soon.

All the best,

Paul

> Cheers,
> Andre
>=20
> > > But of course I agree that it is very desirable to "forward" the
> > > device-tree modifications to the kernel device-tree so we are not stu=
ck
> > > with whatever device-tree U-Boot was built with.
> > >=20
> > > > Unfortunately seems that the things are not much better on TF-A sid=
e and
> > > > there is no universal way to get the reserved memory region across
> > > > platforms. But there is at least a most common way in TF-A, namely
> > > > reserving=C2=A0 memory range in the FDT, in particular:
> > > > - Allwinner	("tf-a@40000000" node)
> > > > - ARM FPGA	("tf-a@80000000" node)
> > > > - Xilinx	("tf-a" node)
> > >=20
> > > RaspberryPi seems to be using "atf@0". Generally speaking the property
> > > is a free-form argument to fdt_add_reserved_memory in tf-a and I don't
> > > think we can have a common way to match them.
> > >=20
> > > Introducing a Kconfig property for the prefix would be a satisfying
> > > solution in my opinion.
> >=20
> > This was a very conservative patch solving the A133 case, but actually
> > I don't see anything wrong with just copying all the reserved areas from
> > the U-Boot live tree to the device tree we are going to pass to the
> > kernel. Maybe fdtdec_add_reserved_memory() needs to be taught to detect
> > overlapping ranges and extend them properly, or maybe yet another funct=
ion
> > has to be created for this purpose, to avoid duplicated reserved-memory
> > nodes by all means, but would also solve the PSCI cpuidle issue, as well
> > as potentially Raspi case of TF-A side and simplify TI K3 on U-Boot sid=
e.
> >=20
> > > > While this patch aims to improve the situation for Allwinner platfo=
rms,
> > > > it's deliberately adding more generic code to pave the potential wa=
y of
> > > > unification for other platforms.
> > > >=20
> > > > Note that fdtdec_add_reserved_memory() has a check for an already e=
xisting
> > > > carveout with exactly matching boundaries and will not create a dup=
licate
> > > > even if the name doesn't match. It would not however detect an alre=
ady
> > > > existing bigger carveout fully containing the one requested.
> > > >=20
> > > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > > > ---
> > > > The patch has been developed to faciliate Allwinner A133 SoC suppor=
t, where
> > > > most of the work currently happens on TF-A [1] and Linux [2] sides,=
 but
> > > > I wanted to send this patch upfront to get the first feedback and b=
ecause
> > > > already supported H616 SoC would already benefit from the patch.
> > >=20
> > > Thanks for looking at this!
> > >=20
> > > Like I said, I guess the same needs to be done for the cpuidle psci
> > > nodes.
> >=20
> > See above, maybe there is a way to carefully copy all /reserved-memory =
nodes?
> > Maybe this full copy shall be configurable, but with a proper overlappi=
ng-aware
> > implementation maybe even a Kconfig option is not required...
> >=20
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--UTAXFXrqwe+86pXu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmo2jJsACgkQhP3B6o/u
lQz0QQ//YMlxe18sHCaS6yR1KpXz6RhhhQOBbF7L/6J8rZpg+x8aj8tVfHD5EzRN
pPw/w2ZkJi+3/yIU6tiRUqPwDIU9EDzGl1g9BoRztqaUp2ppqn+AYwA5XsuMMmzg
F+OjgGwTNHVRWL7tvEbuVpDUamPfjjhTzVaJB5I8Okz9nuGbmZeG+DyqauyiwTV3
fg36I3mQuXQLKAjlNT7Ob3otoigv/vGERLQ1KmoWsraPoPIl4KFUaOotUX1oP/ad
C8BbZN9vm0WrIo3DDwBpjKQQfzSIzDD6+vOg7PQ51lKV+BlQdB/HfoTSJ9VfK0/P
gQedlrOg3SFD1GArIEctqlUD48JBU9ceKWdoifp5SighucBnXW4rdPN8gUWIHn0g
475WYmOjbOYRYwCx1HMTBQBN0bE/wDJuewAEVMbDbRbs0RLPlBl0PlxkY3SWQhW6
RpJfGxp48KhYSu6tqg3G5fsqMlIci/c3ZmCPcNzCleXrK0T9mWs9KWx8XYb1QZDp
G3KuaEuxCtxO4DapphxDZFn621lYG9WlVLQ/K4Pr1F5bJnsvW4vOQaIGq2VY+DzF
Ta/pBiHFHXCcI6pq44G603AL0hE2gKlS8fqdnSpg13aEqCC+Qw0ekRkdimjH6/E8
0X6amEUh29b9cBZYOjdF+9MtnyjEUfYnm+mkH22v0t7TnQzy/gM=
=61X4
-----END PGP SIGNATURE-----

--UTAXFXrqwe+86pXu--
