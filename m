Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B423C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 12:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F002B801B0;
	Thu, 23 Jan 2025 13:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="G3mRRFjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E29580275; Thu, 23 Jan 2025 13:04:30 +0100 (CET)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F49F80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 13:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737633866; x=1737893066;
 bh=rOapxeM00zVqunIHAyQ4vafgOLg9SUfCAcmcOxdw7tI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=G3mRRFjWow/sgirGlkrfE9vvDqoS4GJn6T7XaNDBHq45yT3yMIAP1ix/+HC09uKyz
 nda2kB9WW4PnH/z3VnFTs7mVhSmRx/0DU/jzWxxZWMkE199BpPaxbhTwdrzWxjsHHs
 lFOUd+IN8wK/aYtrVs5t21sFq+DpQ2jmL+i1g1hP6WstyQ3Pt8bZVhSBJ2luxsF51z
 27sqwGR5C1Yamflq2MNUYD7mVKNQseGe8c16OmdLbItJbvOVaRT79FgtnVnm0J3cns
 N85r7F8+dlNEfr58jhrDqTpN5AAHByKFHmU07A0bV/CPJrZVHTiDuump7cFa1z9nvs
 rrLu0RESvOkhw==
Date: Thu, 23 Jan 2025 12:04:21 +0000
To: Caleb Connolly <caleb.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] mach-snapdragon: support parsing memory info from
 external FDT
Message-ID: <ZgSzoWyj5pgV9OpxPplPkLG-ib65T7ecq7kZHRD36T3f27Xd1rQspwu_rQLjh1U4GWMCSEkRWyszwz7oZnOIKlTNQyWUPXWKIQpYOWNZg9M=@samcday.com>
In-Reply-To: <32349f10-2fe1-4522-8794-cf512b140038@linaro.org>
References: <20250122-qcom-parse-memory-updates-v2-0-98dfcac821d7@samcday.com>
 <20250122-qcom-parse-memory-updates-v2-2-98dfcac821d7@samcday.com>
 <32349f10-2fe1-4522-8794-cf512b140038@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: bd5acc09bf294988eadaf41f9890f73b0e5f1603
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hey Caleb,

On Wednesday, 22 January 2025 at 16:49, Caleb Connolly <caleb.connolly@lina=
ro.org> wrote:
>=20
> Hi Sam,
>=20
> Thanks for re-spinning this, one small issue below but otherwise LGTM.
>=20
> I'm picking up your first patch, so you only need to re-send this one.
>=20
> On 22/01/2025 11:27, Sam Day wrote:
>=20
> > qcom_parse_memory is updated to return a -ENODATA error if the passed
> > FDT does not contain a /memory node, or that node is incomplete (size=
=3D0)
> >=20
> > board_fdt_blob_setup first tries to call qcom_parse_memory with the
> > internal FDT (if present+valid). If that fails, it tries again with the
> > external FDT (again, if present+valid).
> >=20
> > When booting with an internal FDT from upstream, it's likely that this
> > change results in a slight performance hit, since virtually all upstrea=
m
> > qcom DTs lack a fully specified memory node. The impact should be
> > negligible, though.
> >=20
> > qcom_parse_memory was given a detailed docstring adapted from Caleb's
> > original commit message that introduced the function.
> >=20
> > Signed-off-by: Sam Day me@samcday.com
> > ---
> > arch/arm/mach-snapdragon/board.c | 93 +++++++++++++++++++++++++++------=
-------
> > 1 file changed, 63 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdrago=
n/board.c
> > index 2ef936aab757c7045729a2dd91944f4f9bff917e..ad3bc4b1a998049cd10e3d3=
fa032009347d77314 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -88,7 +88,29 @@ int dram_init_banksize(void)
> > return 0;
> > }
> >=20
> > -static void qcom_parse_memory(const void fdt)
> > +/*
> > + * The generic memory parsing code in U-Boot lacks a few things that w=
e
> > + * need on Qualcomm:
> > + *
> > + * 1. It sets gd->ram_size and gd->ram_base to represent a single memo=
ry block
> > + * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size,=
 the end
> > + * of that first memory block.
> > + *
> > + * This results in all memory beyond U-Boot being unusable in Linux wh=
en booting
> > + * with EFI.
> > + *
> > + * Since the ranges in the memory node may be out of order, the only w=
ay for us
> > + * to correctly determine the relocation address for U-Boot is to pars=
e all
> > + * memory regions and find the highest valid address.
> > + *
> > + * We can't use fdtdec_setup_memory_banksize() since it stores the res=
ult in
> > + * gd->bd, which is not yet allocated.
> > + *
> > + * @fdt: FDT blob to parse /memory node from
> > + *
> > + * Return: 0 on success or -ENODATA if /memory node is missing or inco=
mplete
> > + */
> > +static int qcom_parse_memory(const void *fdt)
> > {
> > int offset;
> > const fdt64_t *memory;
> > @@ -97,16 +119,12 @@ static void qcom_parse_memory(const void *fdt)
> > int i, j, banks;
> >=20
> > offset =3D fdt_path_offset(fdt, "/memory");
> > - if (offset < 0) {
> > - log_err("No memory node found in device tree!\n");
> > - return;
> > - }
> > + if (offset < 0)
> > + return -ENODATA;
> >=20
> > memory =3D fdt_getprop(fdt, offset, "reg", &memsize);
> > - if (!memory) {
> > - log_err("No memory configuration was provided by the previous bootloa=
der!\n");
> > - return;
> > - }
> > + if (!memory)
> > + return -ENODATA;
> >=20
> > banks =3D min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS)=
;
> >=20
> > @@ -119,7 +137,6 @@ static void qcom_parse_memory(const void fdt)
> > for (i =3D 0, j =3D 0; i < banks * 2; i +=3D 2, j++) {
> > prevbl_ddr_banks[j].start =3D get_unaligned_be64(&memory[i]);
> > prevbl_ddr_banks[j].size =3D get_unaligned_be64(&memory[i + 1]);
> > - / SM8650 boards sometimes have empty regions! */
> > if (!prevbl_ddr_banks[j].size) {
> > j--;
> > continue;
> > @@ -127,13 +144,16 @@ static void qcom_parse_memory(const void *fdt)
> > ram_end =3D max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j=
].size);
> > }
> >=20
> > + if (!j)
> > + return -ENODATA;
>=20
>=20
> I think this should be
> if (!banks || !prevbl_ddr_banks[0].size)
>=20
> That way it will properly detect the typical case where the source dts
> has a single entry with a 0 size.

Hmm, I did test this on my samsung-a5, booting with an internal FDT with a =
zero
size memory node and it worked okay. If there's only one node, then j gets
incremented in the single run of the previous loop, and then decremented be=
cause
the size =3D=3D 0, thus exiting the loop with j=3D=3D0, which is being chec=
ked here.

Hmm, I did test this on my samsung-a5, booting an internal FDT with a zero
size memory node and it worked okay. If there's only one node, then j gets
incremented in the single run of the previous loop, and then decremented be=
cause
size =3D=3D 0, thus exiting the loop with j=3D=3D0, which is being checked =
here.

But, your suggestion is more readable and semantically correct, as well as =
being
more robust against the inevitable future refactorings of this method ;) I'=
ll
submit v3 with just this patch in a mo'.

Cheers,
-Sam

>=20
> With that change:
>=20
> Reviewed-by: Caleb Connolly caleb.connolly@linaro.org
>=20
>=20
> Kind regards,
>=20
> > +
> > /* Sort our RAM banks -_- */
> > qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cm=
p);
> >=20
> > gd->ram_base =3D prevbl_ddr_banks[0].start;
> > gd->ram_size =3D ram_end - gd->ram_base;
> > - debug("ram_base =3D %#011lx, ram_size =3D %#011llx, ram_end =3D %#011=
llx\n",
> > - gd->ram_base, gd->ram_size, ram_end);
> > +
> > + return 0;
> > }
> >=20
> > static void show_psci_version(void)
> > @@ -153,13 +173,14 @@ static void show_psci_version(void)
> > */
> > int board_fdt_blob_setup(void **fdtp)
> > {
> > - struct fdt_header *fdt;
> > + struct fdt_header *external_fdt, *internal_fdt;
> > bool internal_valid, external_valid;
> > - int ret =3D 0;
> > + int ret =3D -ENODATA;
> >=20
> > - fdt =3D (struct fdt_header *)get_prev_bl_fdt_addr();
> > - external_valid =3D fdt && !fdt_check_header(fdt);
> > - internal_valid =3D !fdt_check_header(*fdtp);
> > + internal_fdt =3D (struct fdt_header *)*fdtp;
> > + external_fdt =3D (struct fdt_header *)get_prev_bl_fdt_addr();
> > + external_valid =3D external_fdt && !fdt_check_header(external_fdt);
> > + internal_valid =3D !fdt_check_header(internal_fdt);
> >=20
> > /*
> > * There is no point returning an error here, U-Boot can't do anything u=
seful in this situation.
> > @@ -167,24 +188,36 @@ int board_fdt_blob_setup(void **fdtp)
> > /
> > if (!internal_valid && !external_valid)
> > panic("Internal FDT is invalid and no external FDT was provided! (fdt=
=3D%#llx)\n",
> > - (phys_addr_t)fdt);
> > + (phys_addr_t)external_fdt);
> > +
> > + / Prefer memory information from internal DT if it's present /
> > + if (internal_valid)
> > + ret =3D qcom_parse_memory(internal_fdt);
> > +
> > + if (ret < 0 && external_valid) {
> > + / No internal FDT or it lacks a proper /memory node.
> > + * The previous bootloader handed us something, let's try that.
> > + */
> > + if (internal_valid)
> > + debug("No memory info in internal FDT, falling back to external\n");
> > +
> > + ret =3D qcom_parse_memory(external_fdt);
> > + }
> > +
> > + if (ret < 0)
> > + panic("No valid memory ranges found!\n");
> > +
> > + debug("ram_base =3D %#011lx, ram_size =3D %#011llx\n",
> > + gd->ram_base, gd->ram_size);
> >=20
> > if (internal_valid) {
> > debug("Using built in FDT\n");
> > - ret =3D -EEXIST;
> > - } else {
> > - debug("Using external FDT\n");
> > - /* So we can use it before returning */
> > - *fdtp =3D fdt;
> > + return -EEXIST;
> > }
> >=20
> > - /*
> > - * Parse the /memory node while we're here,
> > - * this makes it easy to do other things early.
> > - */
> > - qcom_parse_memory(*fdtp);
> > -
> > - return ret;
> > + debug("Using external FDT\n");
> > + *fdtp =3D external_fdt;
> > + return 0;
> > }
> >=20
> > void reset_cpu(void)
>=20
>=20
> --
> // Caleb (they/them)
