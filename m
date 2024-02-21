Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7ACC48BEB
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 17:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC0187C0A;
	Wed, 21 Feb 2024 18:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cma6I39O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8088988051; Wed, 21 Feb 2024 18:59:27 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC29D878ED
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 18:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5DB3E614C3;
 Wed, 21 Feb 2024 17:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706B4C433F1;
 Wed, 21 Feb 2024 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708538363;
 bh=7DWALZY2kIYkhUSaMPVx2X/F0tLXCsiCtydNSGAXCYc=;
 h=Date:From:To:Cc:Subject:From;
 b=Cma6I39OKlvU3RHmdVmMIQFWw7ks+wSazI9rVikMHCnFX14ygyzk0mukE/gAMKefV
 vv33xLmZh71//O5kBVOfgCVsWYoJm+eC6wrQIvrUuBmcEOHUwaO86siqnZ2y8yPtoj
 E8Bx2WH7FNc4h1LkZvME3lNaxFhoMvPS9olJr0omO6zUBabuyiZFE8oaBzHU92Low+
 KzJvGPFUWCKt+trKkEhlNoV78AuI5AegfgXWpT7B7F5E21gIzelP4obGPgwLAxrRwo
 VMP32hturqFk1PsJkmBvI4x4ofZEcntnP2NPkZATkwezO4sAGLXVbUmSebEZt2DHew
 WV9KwAZU5Wg1g==
Date: Wed, 21 Feb 2024 17:59:19 +0000
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, conor@kernel.org
Subject: riscv: supports_extension() broken for long isa strings
Message-ID: <20240221-daycare-reliably-8ec86f95fe71@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="enHwj2ZhuY414zan"
Content-Disposition: inline
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


--enHwj2ZhuY414zan
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

I mentioned this last night to Heinrich on IRC, supports_extension() is
broken for ISA strings longer than 32 characters. M-Mode U-Boot doesn't
parse a devicetree, so this doesn't apply there, but for S-mode
supports_extension() looks like:

static inline bool supports_extension(char ext)
{

	struct udevice *dev;
	char desc[32];
	int i;

	uclass_find_first_device(UCLASS_CPU, &dev);
	if (!dev) {
		debug("unable to find the RISC-V cpu device\n");
		return false;
	}
	if (!cpu_get_desc(dev, desc, sizeof(desc))) {
		/*
		 * skip the first 4 characters (rv32|rv64) and
		 * check until underscore
		 */
		for (i =3D 4; i < sizeof(desc); i++) {
			if (desc[i] =3D=3D '_' || desc[i] =3D=3D '\0')
				break;
			if (desc[i] =3D=3D ext)
				return true;
		}
	}

	return false;
}

cpu_get_desc is implemented by riscv_cpu_get_desc():
static int riscv_cpu_get_desc(const struct udevice *dev, char *buf, int siz=
e)
{
	const char *isa;

	isa =3D dev_read_string(dev, "riscv,isa");
	if (size < (strlen(isa) + 1))
		return -ENOSPC;

	strcpy(buf, isa);

	return 0;
}

On most extant systems, riscv,isa is a pretty short string - between 10
and 20 characters. In QEMU's default virt machine however, we get:
riscv,isa =3D "rv64imafdch_zicbom_zicbop_zicboz_zicntr_zicsr_zifencei_zihin=
tntl_zihintpause_zihpm_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu";

Since desc can only contain 32 elements, the size < strlen() test fails
and cpu_get_desc() returns an error and supports_extension() in turn
returns false.=20

Currently, in S-Mode, there's only two extensions that U-Boot ever looks
for and they lie inside the single letter section, so 32 charcters would
be sufficiently sized, if cpu_get_desc() supported undersized buffers.

I came across this while adding support for a different way of detecting
ISA extensions, rather than running into an actual problem because U-Boot
seems not to actually make use of supports_extension() other than enabling
an FPU that there seem to be no users of in U-Boot at present. I also
assume that using U-Boot in QEMU is somewhat of a rare case, given with
virt you can boot an OS kernel directly. That'd make the impact of this
problem pretty low, given I just happened to notice that in my test
environment no extensions were being detected and the operation of
U-Boot seemed unaffected.

I'm mostly just wondering if, given the impact seems to be rather low,
if I should "bother" making a minimal fix for this that would be
applied to master (or backported? not 100% sure of the release process
for U-Boot), or if I can just fix it in passing while making "riscv,isa"
optional?

A minimal fix would look something like the following:

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index 8445c5823e..df508ac4a1 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -39,7 +39,6 @@ static inline bool supports_extension(char ext)
 	return csr_read(CSR_MISA) & (1 << (ext - 'a'));
 #elif CONFIG_CPU
 	struct udevice *dev;
-	char desc[32];
 	int i;
=20
 	uclass_find_first_device(UCLASS_CPU, &dev);
@@ -47,15 +46,16 @@ static inline bool supports_extension(char ext)
 		debug("unable to find the RISC-V cpu device\n");
 		return false;
 	}
-	if (!cpu_get_desc(dev, desc, sizeof(desc))) {
+	const char *isa =3D dev_read_string(dev, "riscv,isa");
+	if (isa) {
 		/*
 		 * skip the first 4 characters (rv32|rv64) and
 		 * check until underscore
 		 */
-		for (i =3D 4; i < sizeof(desc); i++) {
-			if (desc[i] =3D=3D '_' || desc[i] =3D=3D '\0')
+		for (i =3D 4; i < strlen(isa); i++) {
+			if (isa[i] =3D=3D '_' || isa[i] =3D=3D '\0')
 				break;
-			if (desc[i] =3D=3D ext)
+			if (isa[i] =3D=3D ext)
 				return true;
 		}
 	}

Cheers,
Conor.

--enHwj2ZhuY414zan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdY59wAKCRB4tDGHoIJi
0lvWAP4tlifLCzHeQOVTTPGkar0LHDTyf9rggEmVkiypu64YqQD+P7jtocDRjCns
ePxn7l32AQ/6cCjv8x5+RR+IlSo4vgE=
=9OhF
-----END PGP SIGNATURE-----

--enHwj2ZhuY414zan--
