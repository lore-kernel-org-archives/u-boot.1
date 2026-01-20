Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AE4D2ECEF
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 00:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B918389A;
	Tue, 20 Jan 2026 01:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="gttKXMep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B7E2839D5; Tue, 20 Jan 2026 01:47:19 +0100 (CET)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED7AD82A9E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 01:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=vagrant@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
 Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=McHviQLx39ENLh00atTok411tpF6J+MZDc9dJl1wZng=; b=gttKXMepk85tfFppjPOTGFlRAs
 XemhOgFh3/7AHGXd7C0jFV8LVhHrI6XWf65oVd0rWOcJsOKXRl0n4o0Mg2KSXemIep920lFV2zADD
 NIru9DaGfOSCqWz12EVAZZUt6eUYOMKUUOwSH6LjJx56x4yX7Y8sp1RNMqueqok7pHTWCJiwFy/P9
 OhTPHkgzjWj5RjlDnoPiQXCAIk5DplUU9B/Dk05uDvPeX6U95TqRo+MEn+21MNXKAH1YW2Oww0UQt
 BjDVuVK4tm4du+hy7l0X1HcXPRVfFJLjPnSByJEm15assU7huLIfyCreLudXRXKuvyWBHMqx4aLrC
 /SmuXHMw==;
Received: from authenticated user by stravinsky.debian.org with utf8esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <vagrant@debian.org>)
 id 1vhztm-00Ayt1-HQ; Tue, 20 Jan 2026 00:47:11 +0000
From: Vagrant Cascadian <vagrant@debian.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Green Wan <green.wan@sifive.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Peng
 Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] board: unmatched: Workaround failure to find .dtb file.
In-Reply-To: <20260119191841.GE3416603@bill-the-cat>
References: <877bteqx7y.fsf@wireframe>
 <e406ccb2-670c-481a-a128-d25a8973341b@mailbox.org>
 <20260119191841.GE3416603@bill-the-cat>
Date: Mon, 19 Jan 2026 16:46:47 -0800
Message-ID: <87pl75p0ug.fsf@wireframe>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: vagrant
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2026-01-19, Tom Rini wrote:
> On Mon, Jan 19, 2026 at 07:42:59AM +0100, Marek Vasut wrote:
>> On 1/19/26 1:09 AM, Vagrant Cascadian wrote:
>> > The fdtdfile variable contains quotes:
>> >=20
>> >    printenv fdtfile
>> >    fdtfile=3D"sifive/hifive-unmatched-a00.dtb"
>> >=20
>> > But this leads to issues which booting with an extlinux.conf format
>> > file failing to find the .dtb file:
>> >=20
>> >    Retrieving file: /usr/lib/linux-image-6.12.63+deb13-riscv64/"sifive=
/hifive-unmatched-a00.dtb"
>> >    Skipping fdtdir /usr/lib/linux-image-6.12.63+deb13-riscv64/ for fai=
lure retrieving dts
>> >=20
>> > Other platforms (e.g. rockpro64-rk3399) do not contain quotes in the
>> > fdtfile variable, and work properly out of the box.
>> >=20
>> > The workaround suggested by marex is to hard-code the correct .dtb
>> > value, which works for me.
>> >=20
>> > This has been present at least since version 2025.01, also present in
>> > 2026.01. I have not yet tested against git master branch.
>> >=20
>> > This could probably be properly fixed by stripping the quotes in
>> > whatever processes the .env file. There are numerous other boards that
>> > have the same way of setting the fdtfile variable, which might
>> > similarly be effected by this issue.
>> >=20
>> > Signed-off-by: Vagrant Cascadian <vagrant@debian.org>
>> >=20
>> > Not sure who all to CC on this, please feel free to forward
>> > appropriately!
>>=20
>> ./scripts/get_maintainer.pl -f board/sifive/unmatched/
>>=20
>> produces a few names, added
>>=20
>> > ---
>> >   board/sifive/unmatched/unmatched.env | 2 +-
>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> >=20
>> > diff --git a/board/sifive/unmatched/unmatched.env b/board/sifive/unmat=
ched/unmatched.env
>> > index 34425dc9efa..cdba2c8ae0e 100644
>> > --- a/board/sifive/unmatched/unmatched.env
>> > +++ b/board/sifive/unmatched/unmatched.env
>> > @@ -16,4 +16,4 @@ partitions=3D
>> >       name=3Dloader1,start=3D17K,size=3D1M,type=3D${type_guid_gpt_load=
er1};
>> >       name=3Dloader2,size=3D4MB,type=3D${type_guid_gpt_loader2};
>> >       name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_system};=
=20
>> > -fdtfile=3DCONFIG_DEFAULT_FDT_FILE
>> > +fdtfile=3Dsifive/hifive-unmatched-a00.dtb
>>=20
>> Also +CC Peng because iMX is also affected.
>
> I'm setting aside the question of why we have both DEFAULT_FDT_FILE and
> DEFAULT_DEVICE_TREE and pointing to:
> commit d085e692c98d0d7b57cc577ed9befda159cd4a40
> Author: Simon Glass <sjg@chromium.org>
> Date:   Wed Nov 13 08:09:37 2024 -0700
>
>     env: Provide a work-around for unquoting fdtfile
>=20=20=20=20=20
>     Some boards use a CONFIG option to specify the value of this variable.
>     This is normally handled by efi_get_distro_fdt_name() but in the case
>     of sunxi this does not work, since 'soc' is sunxi, but the files are
>     in the allwinner directory.
>=20=20=20=20=20
>     Provide a work-around for this particular case.
>=20=20=20=20=20
>     Signed-off-by: Simon Glass <sjg@chromium.org>
>     Reviewed-by: Tom Rini <trini@konsulko.com>
>
> As how to address this issue as well, unless someone discovers something
> still more clever to deal with quoting.

Thanks for the hint! So a quick and dirty stab at getting this to work:

diff --git a/Makefile b/Makefile
index 50737f93850..2e3280bb87b 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -2137,7 +2137,7 @@ quiet_cmd_gen_envp =3D ENVP    $@
                $(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
                        -D__ASSEMBLY__ \
                        -D__UBOOT_CONFIG__ \
=2D                       -DDEFAULT_DEVICE_TREE=3D$(subst ",,$(CONFIG_DEFAU=
LT_DEVICE_TREE)) \
+                       -DDEFAULT_FDT_FILE=3D$(subst ",,$(CONFIG_DEFAULT_FD=
T_FILE)) \
                        -I . -I include -I $(srctree)/include \
                        -include linux/kconfig.h -include include/config.h \
                        -I$(srctree)/arch/$(ARCH)/include \
diff --git a/board/sifive/unmatched/unmatched.env b/board/sifive/unmatched/=
unmatched.env
index 34425dc9efa..f309229481b 100644
=2D-- a/board/sifive/unmatched/unmatched.env
+++ b/board/sifive/unmatched/unmatched.env
@@ -16,4 +16,4 @@ partitions=3D
     name=3Dloader1,start=3D17K,size=3D1M,type=3D${type_guid_gpt_loader1};
     name=3Dloader2,size=3D4MB,type=3D${type_guid_gpt_loader2};
     name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_system};
=2Dfdtfile=3DCONFIG_DEFAULT_FDT_FILE
+fdtfile=3DDEFAULT_FDT_FILE

Though obviously any boards relying on DEFAULT_DEVICE_TREE would need
adapting with my quick patch above...

I did not successfully just add -DDEFAULT_FDT_FILE without removing
=2DDDEFAULT_DEVICE_TREE ... probably just need to cut-and-paste more lines
in the Makefile... or try to do something even more clever. :)

That would also require the other handfull of boards using
CONFIG_DEFAULT_FDT_FILE to switch to DEFAULT_FDT_FILE, presumably.


I also tried switching the unmatched board to use DEFAULT_DEVICE_TREE
instead, but that does not contain the vendor prefix
(e.g. hifive-unmatched-a00 vs. sifive/hifive-unmatched-a00.dtb) and so
the file was still not found. Should CONFIG_DEFAULT_DEVICE_TREE and
CONFIG_DEFAULT_FDT_FILE both contain the vendor dir?


live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCaW7QdwAKCRDcUY/If5cW
qmeGAP4iMWL/uxNeRr4nzP9iZ+YyO675DWCxlZwtJpsrlGQpvAEAq7jQOIYZuoMy
Q++3rIt3XcsBsFKQCu4roZry0w0U9QA=
=sTqC
-----END PGP SIGNATURE-----
--=-=-=--
