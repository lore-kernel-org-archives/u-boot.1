Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A742CC4706C
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 22:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1CD7878DA;
	Tue,  9 Jan 2024 23:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SIoyCmOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20E318788A; Tue,  9 Jan 2024 23:18:12 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34518783B
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 23:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-680adbf077dso26499556d6.1
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 14:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704838688; x=1705443488; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BstjnJLy37XGLNpIwMOFmTNgaoG5T/O9PPeWD4ISySI=;
 b=SIoyCmOsn/tNxGrj6aBHZn7Ae+Lvw18BNyE2gutiCbIyQD2tobmkUP2ByHOEGDy9zu
 qUybWUncCknDhtHLmXLOWcfiEsoy7MbbTg8uzyljKiCl3ND3ouSWadro34e0Zp+63d/v
 UywipLzoRkqJDWQ88f0n0LdMHmFokLoeRT344=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704838688; x=1705443488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BstjnJLy37XGLNpIwMOFmTNgaoG5T/O9PPeWD4ISySI=;
 b=AztEqVlppe4Aq550WXCK3j7QRGPJ6jq92/55KRq4Nlo/93IMsG05TSr96iwgwKKRtl
 970VN9Va9Xf3m1RylaetyjcH93vHTq98JD1B5TDZBlFqocrGlRRCQwzW5/rtGFWX3pC0
 1MNLuljjOgme5/nSZTjzx1rZ2f5lf5QTv35c8exakqTCW0QYLe3aopi/XTtEf4fBlUZt
 CAg/rFvtjKQijObV6WIZUo5EJR00uhyCFWCqzgcHGo9OAqHdy+bibdlywGyvzI0zctRR
 Ph9E7XJtOR2xMvH9T7FKK4IPbE9pzDrX60cThT89bpMiP/IwxdHySdyu/5aiQe75uLbY
 RTTg==
X-Gm-Message-State: AOJu0YyePHNb0B68Etg44GzdwbNBnWw/VxmUz1oO6wAwUd8SkclUF0hN
 q3m7u7d8TQt50nuftvYjJWuyL67UcMRcaQ==
X-Google-Smtp-Source: AGHT+IHLoEn2xkt2kQGlqhQR5OYvu18II+dv4Wb7BaGuP94PeQW8CAjT0gX9wzxGlQPuC62iHzWhoA==
X-Received: by 2002:a05:6214:2388:b0:680:c089:3a0a with SMTP id
 fw8-20020a056214238800b00680c0893a0amr150180qvb.129.1704838688457; 
 Tue, 09 Jan 2024 14:18:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 c3-20020a056214004300b00680d2247031sm1227795qvr.81.2024.01.09.14.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 14:18:07 -0800 (PST)
Date: Tue, 9 Jan 2024 17:18:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Francis Laniel <francis.laniel@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20240109221805.GC1610741@bill-the-cat>
References: <20240108174506.GL1610741@bill-the-cat>
 <d873ed4d-25df-5ba0-67b3-c104d9da229d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pqdVanenHtKereSI"
Content-Disposition: inline
In-Reply-To: <d873ed4d-25df-5ba0-67b3-c104d9da229d@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--pqdVanenHtKereSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 12:26:13AM -0500, Sean Anderson wrote:
> Comments on NAND stuff only.
>=20
> On 1/8/24 12:45, Tom Rini wrote:
> > _______________________________________________________________________=
_________________________________
> > *** CID 477216:    (BAD_SHIFT)
> > /drivers/mtd/nand/raw/nand_base.c: 3921 in nand_flash_detect_onfi()
> > 3915
> > 3916            /*
> > 3917             * pages_per_block and blocks_per_lun may not be a
> > power-of-2 size
> > 3918             * (don't ask me who thought of this...). MTD assumes t=
hat these
> > 3919             * dimensions will be power-of-2, so just truncate the
> > remaining area.
> > 3920             */
> > > > >      CID 477216:    (BAD_SHIFT)
> > > > >      In expression "1 << generic_fls((__u32)(__le32)p->pages_per_=
block) - 1", shifting by a negative amount has undefined behavior.  The shi=
ft amount, "generic_fls((__u32)(__le32)p->pages_per_block) - 1", is -1.
> > 3921            mtd->erasesize =3D 1 <<
> > (fls(le32_to_cpu(p->pages_per_block)) - 1);
> > 3922            mtd->erasesize *=3D mtd->writesize;
> > 3923
> > 3924            mtd->oobsize =3D le16_to_cpu(p->spare_bytes_per_page);
> > 3925
> > 3926            /* See erasesize comment */
> > /drivers/mtd/nand/raw/nand_base.c: 3927 in nand_flash_detect_onfi()
> > 3921            mtd->erasesize =3D 1 <<
> > (fls(le32_to_cpu(p->pages_per_block)) - 1);
> > 3922            mtd->erasesize *=3D mtd->writesize;
> > 3923
> > 3924            mtd->oobsize =3D le16_to_cpu(p->spare_bytes_per_page);
> > 3925
> > 3926            /* See erasesize comment */
> > > > >      CID 477216:    (BAD_SHIFT)
> > > > >      In expression "1 << generic_fls((__u32)(__le32)p->blocks_per=
_lun) - 1", shifting by a negative amount has undefined behavior.  The shif=
t amount, "generic_fls((__u32)(__le32)p->blocks_per_lun) - 1", is -1.
> > 3927            chip->chipsize =3D 1 << (fls(le32_to_cpu(p->blocks_per_=
lun)) - 1);
> > 3928            chip->chipsize *=3D (uint64_t)mtd->erasesize * p->lun_c=
ount;
> > 3929            chip->bits_per_cell =3D p->bits_per_cell;
> > 3930
> > 3931            if (onfi_feature(chip) & ONFI_FEATURE_16_BIT_BUS)
> > 3932                    chip->options |=3D NAND_BUSWIDTH_16;
>=20
> Yeah, this looks like a bug.
>=20
> > ** CID 477215:  Control flow issues  (MISSING_BREAK)
> > /drivers/mtd/nand/raw/nand_base.c: 4978 in nand_scan_tail()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 477215:  Control flow issues  (MISSING_BREAK)
> > /drivers/mtd/nand/raw/nand_base.c: 4978 in nand_scan_tail()
> > 4972                            pr_warn("No ECC functions supplied;
> > hardware ECC not possible\n");
> > 4973                            BUG();
> > 4974                    }
> > 4975                    if (!ecc->read_page)
> > 4976                            ecc->read_page =3D nand_read_page_hwecc=
_oob_first;
> > 4977
> > > > >      CID 477215:  Control flow issues  (MISSING_BREAK)
> > > > >      The case for value "NAND_ECC_HW" is not terminated by a "bre=
ak" statement.
> > 4978            case NAND_ECC_HW:
> > 4979                    /* Use standard hwecc read page function? */
> > 4980                    if (!ecc->read_page)
> > 4981                            ecc->read_page =3D nand_read_page_hwecc;
> > 4982                    if (!ecc->write_page)
> > 4983                            ecc->write_page =3D nand_write_page_hwe=
cc;
>=20
> I think we just need a fallthrough comment here.
>=20
> > ** CID 477214:  Integer handling issues  (BAD_SHIFT)
> > /drivers/mtd/nand/raw/nand_base.c: 4397 in nand_detect()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 477214:  Integer handling issues  (BAD_SHIFT)
> > /drivers/mtd/nand/raw/nand_base.c: 4397 in nand_detect()
> > 4391
> > 4392            nand_decode_bbm_options(mtd, chip);
> > 4393
> > 4394            /* Calculate the address shift from the page size */
> > 4395            chip->page_shift =3D ffs(mtd->writesize) - 1;
> > 4396            /* Convert chipsize to number of pages per chip -1 */
> > > > >      CID 477214:  Integer handling issues  (BAD_SHIFT)
> > > > >      In expression "chip->chipsize >> chip->page_shift", shifting=
 by a negative amount has undefined behavior.  The shift amount, "chip->pag=
e_shift", is -1.
> > 4397            chip->pagemask =3D (chip->chipsize >> chip->page_shift)=
 - 1;
> > 4398
> > 4399            chip->bbt_erase_shift =3D chip->phys_erase_shift =3D
> > 4400                    ffs(mtd->erasesize) - 1;
> > 4401            if (chip->chipsize & 0xffffffff)
> > 4402                    chip->chip_shift =3D ffs((unsigned)chip->chipsi=
ze) - 1;
>=20
> Buggy, but only when writesize is 0 (which is a bigger bug in the nand ch=
ip).
>=20
> > ** CID 477213:  Security best practices violations  (DC.WEAK_CRYPTO)
> > /test/dm/nand.c: 67 in dm_test_nand()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 477213:  Security best practices violations  (DC.WEAK_CRYPTO)
> > /test/dm/nand.c: 67 in dm_test_nand()
> > 61      ops.ooblen =3D mtd->oobsize;
> > 62      ut_assertok(mtd_read_oob(mtd, mtd->erasesize, &ops));
> > 63      ut_asserteq(0, oob[mtd_to_nand(mtd)->badblockpos]);
> > 64
> > 65      /* Generate some data and write it */
> > 66      for (i =3D 0; i < size / sizeof(int); i++)
> > > > >      CID 477213:  Security best practices violations  (DC.WEAK_CR=
YPTO)
> > > > >      "rand" should not be used for security-related applications,=
 because linear congruential algorithms are too easy to break.
> > 67              gold[i] =3D rand();
> > 68      ut_assertok(nand_write_skip_bad(mtd, off, &length, NULL, U64_MA=
X,
> > 69                                      (void *)gold, 0));
> > 70      ut_asserteq(size, length);
> > 71
> > 72      /* Verify */
>=20
> Not a bug.
>=20
> > ** CID 477211:  API usage errors  (ALLOC_FREE_MISMATCH)
> > /drivers/mtd/nand/raw/nand_bbt.c: 1133 in nand_scan_bbt()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 477211:  API usage errors  (ALLOC_FREE_MISMATCH)
> > /drivers/mtd/nand/raw/nand_bbt.c: 1133 in nand_scan_bbt()
> > 1127
> > 1128            /* Prevent the bbt regions from erasing / writing */
> > 1129            mark_bbt_region(mtd, td);
> > 1130            if (md)
> > 1131                    mark_bbt_region(mtd, md);
> > 1132
> > > > >      CID 477211:  API usage errors  (ALLOC_FREE_MISMATCH)
> > > > >      Calling "vfree" frees "buf" using "vfree" but it should have=
 been freed using "kfree". [Note: The source code implementation of the fun=
ction has been overridden by a builtin model.]
> > 1133            vfree(buf);
> > 1134            return 0;
> > 1135
> > 1136     err:
> > 1137            kfree(this->bbt);
> > 1138            this->bbt =3D NULL;
>=20
> Not a bug, since these both call free().
>=20
> > ** CID 477210:  Security best practices violations  (DC.WEAK_CRYPTO)
> > /drivers/mtd/nand/raw/sand_nand.c: 199 in sand_nand_read()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 477210:  Security best practices violations  (DC.WEAK_CRYPTO)
> > /drivers/mtd/nand/raw/sand_nand.c: 199 in sand_nand_read()
> > 193             chip->tmp_dirty =3D true;
> > 194             for (i =3D 0; i < chip->err_steps; i++) {
> > 195                     u32 bit_errors =3D chip->err_count;
> > 196                     unsigned int j =3D chip->err_step_bits + chip->=
ecc_bits;
> > 197
> > 198                     while (bit_errors) {
> > > > >      CID 477210:  Security best practices violations  (DC.WEAK_CR=
YPTO)
> > > > >      "rand" should not be used for security-related applications,=
 because linear congruential algorithms are too easy to break.
> > 199                             unsigned int u =3D rand();
> > 200                             float quot =3D 1ULL << 32;
> > 201
> > 202                             do {
> > 203                                     quot *=3D j - bit_errors;
> > 204                                     quot /=3D j;
>=20
> Not a bug.
>=20
> > ** CID 477207:  Control flow issues  (MISSING_BREAK)
> > /drivers/mtd/nand/raw/nand_base.c: 4969 in nand_scan_tail()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 477207:  Control flow issues  (MISSING_BREAK)
> > /drivers/mtd/nand/raw/nand_base.c: 4969 in nand_scan_tail()
> > 4963            /*
> > 4964             * Check ECC mode, default to software if
> > 3byte/512byte hardware ECC is
> > 4965             * selected and we have 256 byte pagesize fallback to
> > software ECC
> > 4966             */
> > 4967
> > 4968            switch (ecc->mode) {
> > > > >      CID 477207:  Control flow issues  (MISSING_BREAK)
> > > > >      The case for value "NAND_ECC_HW_OOB_FIRST" is not terminated=
 by a "break" statement.
> > 4969            case NAND_ECC_HW_OOB_FIRST:
> > 4970                    /* Similar to NAND_ECC_HW, but a separate
> > read_page handle */
> > 4971                    if (!ecc->calculate || !ecc->correct || !ecc->h=
wctl) {
> > 4972                            pr_warn("No ECC functions supplied;
> > hardware ECC not possible\n");
> > 4973                            BUG();
> > 4974                    }
>=20
> need a fallthrough comment
>=20
> > ** CID 477205:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
> > /cmd/mtd.c: 88 in mtd_dump_device_buf()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 477205:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
> > /cmd/mtd.c: 88 in mtd_dump_device_buf()
> > 82                      printf("\nDump %d data bytes from 0x%08llx:\n",
> > 83                             mtd->writesize, start_off + data_off);
> > 84                      mtd_dump_buf(&buf[data_off],
> > 85                                   mtd->writesize, start_off + data_o=
ff);
> > 86
> > 87                      if (woob) {
> > > > >      CID 477205:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
> > > > >      Potentially overflowing expression "page * mtd->oobsize" wit=
h type "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithme=
tic, and then used in a context that expects an expression of type "u64" (6=
4 bits, unsigned).
> > 88                              u64 oob_off =3D page * mtd->oobsize;
> > 89
> > 90                              printf("Dump %d OOB bytes from page at
> > 0x%08llx:\n",
> > 91                                     mtd->oobsize, start_off + data_o=
ff);
> > 92                              mtd_dump_buf(&buf[len + oob_off],
> > 93                                           mtd->oobsize, 0);
>=20
> In the Linux MTD list [1], the largest this can be is 0xe0000000 for MT29=
F512G08CUCAB. That's worryingly
> close to overflow, so I'd say this is a bug.

Thanks, I've updated the not a bug ones in the dashboard.

--=20
Tom

--pqdVanenHtKereSI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWdxhoACgkQFHw5/5Y0
tyzHpgv/Uy/4KriQbDAPEiHEUxHYuaW0S+Hp0fMLYHz5y4l5iWkyWa8LVlLUSOzU
EmUxMPqYyEPo9f6qipDm4VSxpJicIOSXOFEAyvApBhjoAbGe5fUi1bvr5abiVIbR
R9nmexdARGAa9xYk6T+wC5lmGkj9S4OCxNCZg1C8YkmSSTPiWDD5K0Tap7QY8s2V
60h4TTIXAgdH9v21+PiKHQn/9B0TAsRVJdp7cdgGEQghV73k9orRTDaEuyyqv1l1
MuLGOI/1SD0GSvKzX6sh5OryBEbIhIK80ZfSceVFBPVCPKACqMHGGg0FGspsdFyn
HE2FqMZCmCloarEIimDEw63si0mQSmJwod8BfpmHdnyOoKZkkSWn8No1CaIuRPsp
rCj/SI9cXOS/Sy6zBlr3F40dK8+EzNtkznCiVEykB+0GucWvzZATCG4P8djhFxrZ
mzldwq+9aEfDl1maCxHClewpVj7UM9CMaxDqUGXssS+BpX6WMT6zO440F0apXlrZ
py6pVqHo
=NOCe
-----END PGP SIGNATURE-----

--pqdVanenHtKereSI--
