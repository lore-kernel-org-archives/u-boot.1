Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9636EC47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD41C87A9A;
	Mon,  8 Jan 2024 18:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rwb0/hNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D6EA87A9A; Mon,  8 Jan 2024 18:45:14 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9AA787A8B
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4298e866cd6so11130381cf.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 09:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704735909; x=1705340709; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nz3KQ0tWJcKltSr+G2Uce1rap139WQa2nXkuAp9utfY=;
 b=rwb0/hNb974MzaO10q9K4jCO3vbl43yo++F+rrNuZ7TKDefRa922sRGE75oA1ONcse
 dsGX66FYbMgTFd8BoEFhfezGyi3NH+pGT14pNmCC7wq+mFWD54WwJYqf7EZ2Kzlhvcy8
 Nxks51wgl91KmfYrlbjheJH2HR656PEhj8oro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704735909; x=1705340709;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nz3KQ0tWJcKltSr+G2Uce1rap139WQa2nXkuAp9utfY=;
 b=uZKWmP6cY7DuqCRPRR2HlFEdF1eAoS65e1mLHB+HKJxoGLS0XkS2WMtTUGaE1zZvpF
 I26cPvvSJF44xEC0VRow64EJyTQTmuwNJ+8lj7z3VLMDq9VNDHACKLeVfK9urTTE7NyH
 H9XXpvW4KHD8bPkun1+xdqGY5MaRxvzR7Gkl8VeyDlLttvZ+QjBtcJ2g5bMUAMc2j0A2
 FfbIR0OmqFz1rtp1PJDpq/q+q1B3ugT9C5HfNeS6srSmDYhB9c4L5JQRo0+25R5Cs/5H
 b67Y47yqU1jeHWAVesbwyb9RxIZuS2fDY93c5bleFTl4Y4vKKvNeDcgPliLqx8Q06hL5
 +r5w==
X-Gm-Message-State: AOJu0YwnRvAmoYkXjqlAJr58eoTd8dt6N+zdwTRWIBs2S5a9WZ7znJ6c
 4RvdkaccOHUVvqzeZGL1Ds0HprcvG9v/4omafwRJU9vegdQ=
X-Google-Smtp-Source: AGHT+IGTaYI9X1u1JFux3FYUoykQXkXG4CseFxVQN02b4Q4WaA/d6Cgje1tcnASF+Di+PgW+TgmAPg==
X-Received: by 2002:a05:622a:4c9:b0:429:75ba:1cf9 with SMTP id
 q9-20020a05622a04c900b0042975ba1cf9mr5138583qtx.130.1704735909030; 
 Mon, 08 Jan 2024 09:45:09 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 ha11-20020a05622a2b0b00b00428031ba343sm78697qtb.37.2024.01.08.09.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 09:45:08 -0800 (PST)
Date: Mon, 8 Jan 2024 12:45:06 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francis Laniel <francis.laniel@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20240108174506.GL1610741@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MGg6rIm29ORZe3Eo"
Content-Disposition: inline
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


--MGg6rIm29ORZe3Eo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Now that I've merged next I've re-run Coverity to get a start on issues
that've been added since last run. The report isn't complete because of
the number of issues, sadly, but if someone is interested in a specific
area contact me off-list and I can provide access to the dashboard.

For the hush related issues, this would be a good chance to work with
upstream and then backport the changes I suspect.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Jan 8, 2024 at 12:24=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

41 new defect(s) introduced to Das U-Boot found with Coverity Scan.
4 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 41 defect(s)


** CID 477217:  Memory - illegal accesses  (NEGATIVE_RETURNS)
/common/cli_hush_upstream.c: 5518 in parse_dollar()


___________________________________________________________________________=
_____________________________
*** CID 477217:  Memory - illegal accesses  (NEGATIVE_RETURNS)
/common/cli_hush_upstream.c: 5518 in parse_dollar()
5512                                            break;
5513                                    if (--cnt =3D=3D 0)
5514                                            goto bad_dollar_syntax;
5515                                    if (len_single_ch !=3D '#' &&
strchr(VAR_SUBST_OPS, ch))
5516                                            /* ${NN<op>...} is valid */
5517                                            goto eat_until_closing;
>>>     CID 477217:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>>>     Using variable "ch" as an index to array "_ctype".
5518                                    if (!isdigit(ch))
5519                                            goto bad_dollar_syntax;
5520                            }
5521                    } else
5522                    while (1) {
5523                            unsigned pos;

** CID 477216:    (BAD_SHIFT)
/drivers/mtd/nand/raw/nand_base.c: 3921 in nand_flash_detect_onfi()
/drivers/mtd/nand/raw/nand_base.c: 3927 in nand_flash_detect_onfi()


___________________________________________________________________________=
_____________________________
*** CID 477216:    (BAD_SHIFT)
/drivers/mtd/nand/raw/nand_base.c: 3921 in nand_flash_detect_onfi()
3915
3916            /*
3917             * pages_per_block and blocks_per_lun may not be a
power-of-2 size
3918             * (don't ask me who thought of this...). MTD assumes that =
these
3919             * dimensions will be power-of-2, so just truncate the
remaining area.
3920             */
>>>     CID 477216:    (BAD_SHIFT)
>>>     In expression "1 << generic_fls((__u32)(__le32)p->pages_per_block) =
- 1", shifting by a negative amount has undefined behavior.  The shift amou=
nt, "generic_fls((__u32)(__le32)p->pages_per_block) - 1", is -1.
3921            mtd->erasesize =3D 1 <<
(fls(le32_to_cpu(p->pages_per_block)) - 1);
3922            mtd->erasesize *=3D mtd->writesize;
3923
3924            mtd->oobsize =3D le16_to_cpu(p->spare_bytes_per_page);
3925
3926            /* See erasesize comment */
/drivers/mtd/nand/raw/nand_base.c: 3927 in nand_flash_detect_onfi()
3921            mtd->erasesize =3D 1 <<
(fls(le32_to_cpu(p->pages_per_block)) - 1);
3922            mtd->erasesize *=3D mtd->writesize;
3923
3924            mtd->oobsize =3D le16_to_cpu(p->spare_bytes_per_page);
3925
3926            /* See erasesize comment */
>>>     CID 477216:    (BAD_SHIFT)
>>>     In expression "1 << generic_fls((__u32)(__le32)p->blocks_per_lun) -=
 1", shifting by a negative amount has undefined behavior.  The shift amoun=
t, "generic_fls((__u32)(__le32)p->blocks_per_lun) - 1", is -1.
3927            chip->chipsize =3D 1 << (fls(le32_to_cpu(p->blocks_per_lun)=
) - 1);
3928            chip->chipsize *=3D (uint64_t)mtd->erasesize * p->lun_count;
3929            chip->bits_per_cell =3D p->bits_per_cell;
3930
3931            if (onfi_feature(chip) & ONFI_FEATURE_16_BIT_BUS)
3932                    chip->options |=3D NAND_BUSWIDTH_16;

** CID 477215:  Control flow issues  (MISSING_BREAK)
/drivers/mtd/nand/raw/nand_base.c: 4978 in nand_scan_tail()


___________________________________________________________________________=
_____________________________
*** CID 477215:  Control flow issues  (MISSING_BREAK)
/drivers/mtd/nand/raw/nand_base.c: 4978 in nand_scan_tail()
4972                            pr_warn("No ECC functions supplied;
hardware ECC not possible\n");
4973                            BUG();
4974                    }
4975                    if (!ecc->read_page)
4976                            ecc->read_page =3D nand_read_page_hwecc_oob=
_first;
4977
>>>     CID 477215:  Control flow issues  (MISSING_BREAK)
>>>     The case for value "NAND_ECC_HW" is not terminated by a "break" sta=
tement.
4978            case NAND_ECC_HW:
4979                    /* Use standard hwecc read page function? */
4980                    if (!ecc->read_page)
4981                            ecc->read_page =3D nand_read_page_hwecc;
4982                    if (!ecc->write_page)
4983                            ecc->write_page =3D nand_write_page_hwecc;

** CID 477214:  Integer handling issues  (BAD_SHIFT)
/drivers/mtd/nand/raw/nand_base.c: 4397 in nand_detect()


___________________________________________________________________________=
_____________________________
*** CID 477214:  Integer handling issues  (BAD_SHIFT)
/drivers/mtd/nand/raw/nand_base.c: 4397 in nand_detect()
4391
4392            nand_decode_bbm_options(mtd, chip);
4393
4394            /* Calculate the address shift from the page size */
4395            chip->page_shift =3D ffs(mtd->writesize) - 1;
4396            /* Convert chipsize to number of pages per chip -1 */
>>>     CID 477214:  Integer handling issues  (BAD_SHIFT)
>>>     In expression "chip->chipsize >> chip->page_shift", shifting by a n=
egative amount has undefined behavior.  The shift amount, "chip->page_shift=
", is -1.
4397            chip->pagemask =3D (chip->chipsize >> chip->page_shift) - 1;
4398
4399            chip->bbt_erase_shift =3D chip->phys_erase_shift =3D
4400                    ffs(mtd->erasesize) - 1;
4401            if (chip->chipsize & 0xffffffff)
4402                    chip->chip_shift =3D ffs((unsigned)chip->chipsize) =
- 1;

** CID 477213:  Security best practices violations  (DC.WEAK_CRYPTO)
/test/dm/nand.c: 67 in dm_test_nand()


___________________________________________________________________________=
_____________________________
*** CID 477213:  Security best practices violations  (DC.WEAK_CRYPTO)
/test/dm/nand.c: 67 in dm_test_nand()
61      ops.ooblen =3D mtd->oobsize;
62      ut_assertok(mtd_read_oob(mtd, mtd->erasesize, &ops));
63      ut_asserteq(0, oob[mtd_to_nand(mtd)->badblockpos]);
64
65      /* Generate some data and write it */
66      for (i =3D 0; i < size / sizeof(int); i++)
>>>     CID 477213:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, becaus=
e linear congruential algorithms are too easy to break.
67              gold[i] =3D rand();
68      ut_assertok(nand_write_skip_bad(mtd, off, &length, NULL, U64_MAX,
69                                      (void *)gold, 0));
70      ut_asserteq(size, length);
71
72      /* Verify */

** CID 477212:  Incorrect expression  (SIZEOF_MISMATCH)
/lib/smbios.c: 595 in write_smbios_table()


___________________________________________________________________________=
_____________________________
*** CID 477212:  Incorrect expression  (SIZEOF_MISMATCH)
/lib/smbios.c: 595 in write_smbios_table()
589              * sandbox's DRAM buffer.
590              */
591             table_addr =3D (ulong)map_sysmem(tables, 0);
592
593             /* now go back and write the SMBIOS3 header */
594             se =3D map_sysmem(start_addr, sizeof(struct smbios_entry));
>>>     CID 477212:  Incorrect expression  (SIZEOF_MISMATCH)
>>>     Passing argument "se" of type "struct smbios3_entry *" and argument=
 "31UL" ("sizeof (struct smbios_entry)") to function "memset" is suspicious=
 because a multiple of "sizeof (struct smbios3_entry) /*24*/" is expected.
595             memset(se, '\0', sizeof(struct smbios_entry));
596             memcpy(se->anchor, "_SM3_", 5);
597             se->length =3D sizeof(struct smbios3_entry);
598             se->major_ver =3D SMBIOS_MAJOR_VER;
599             se->minor_ver =3D SMBIOS_MINOR_VER;
600             se->doc_rev =3D 0;

** CID 477211:  API usage errors  (ALLOC_FREE_MISMATCH)
/drivers/mtd/nand/raw/nand_bbt.c: 1133 in nand_scan_bbt()


___________________________________________________________________________=
_____________________________
*** CID 477211:  API usage errors  (ALLOC_FREE_MISMATCH)
/drivers/mtd/nand/raw/nand_bbt.c: 1133 in nand_scan_bbt()
1127
1128            /* Prevent the bbt regions from erasing / writing */
1129            mark_bbt_region(mtd, td);
1130            if (md)
1131                    mark_bbt_region(mtd, md);
1132
>>>     CID 477211:  API usage errors  (ALLOC_FREE_MISMATCH)
>>>     Calling "vfree" frees "buf" using "vfree" but it should have been f=
reed using "kfree". [Note: The source code implementation of the function h=
as been overridden by a builtin model.]
1133            vfree(buf);
1134            return 0;
1135
1136     err:
1137            kfree(this->bbt);
1138            this->bbt =3D NULL;

** CID 477210:  Security best practices violations  (DC.WEAK_CRYPTO)
/drivers/mtd/nand/raw/sand_nand.c: 199 in sand_nand_read()


___________________________________________________________________________=
_____________________________
*** CID 477210:  Security best practices violations  (DC.WEAK_CRYPTO)
/drivers/mtd/nand/raw/sand_nand.c: 199 in sand_nand_read()
193             chip->tmp_dirty =3D true;
194             for (i =3D 0; i < chip->err_steps; i++) {
195                     u32 bit_errors =3D chip->err_count;
196                     unsigned int j =3D chip->err_step_bits + chip->ecc_=
bits;
197
198                     while (bit_errors) {
>>>     CID 477210:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, becaus=
e linear congruential algorithms are too easy to break.
199                             unsigned int u =3D rand();
200                             float quot =3D 1ULL << 32;
201
202                             do {
203                                     quot *=3D j - bit_errors;
204                                     quot /=3D j;

** CID 477209:  Memory - illegal accesses  (STRING_NULL)


___________________________________________________________________________=
_____________________________
*** CID 477209:  Memory - illegal accesses  (STRING_NULL)
/common/cli_hush_upstream.c: 4434 in reserved_word()
4428                            str =3D old->as_string.data + len;
4429                            if (str > old->as_string.data)
4430                                    str--; /* skip whitespace
after keyword */
4431                            while (str > old->as_string.data &&
isalpha(str[-1]))
4432                                    str--;
4433                            /* Ugh, we're done with this horrid hack */
>>>     CID 477209:  Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "str" to "sandbox_strdup", which expect=
s a null-terminated string.
4434                            old->command->group_as_string =3D xstrdup(s=
tr);
4435                            debug_printf_parse("pop, remembering as:'%s=
'\n",
4436                                            old->command->group_as_stri=
ng);
4437                    }
4438     # endif
4439                    *ctx =3D *old;   /* physical copy */

** CID 477208:  Memory - illegal accesses  (STRING_NULL)


___________________________________________________________________________=
_____________________________
*** CID 477208:  Memory - illegal accesses  (STRING_NULL)
/common/cli_hush_upstream.c: 7660 in expand_variables()
7654            output.o_expflags =3D expflags;
7655
7656            n =3D 0;
7657            for (;;) {
7658                    /* go to next list[n] */
7659                    output.ended_in_ifs =3D 0;
>>>     CID 477208:  Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "output.data" to "o_save_ptr", which ex=
pects a null-terminated string.
7660                    n =3D o_save_ptr(&output, n);
7661
7662                    if (!*argv)
7663                            break;
7664
7665                    /* expand argv[i] */

** CID 477207:  Control flow issues  (MISSING_BREAK)
/drivers/mtd/nand/raw/nand_base.c: 4969 in nand_scan_tail()


___________________________________________________________________________=
_____________________________
*** CID 477207:  Control flow issues  (MISSING_BREAK)
/drivers/mtd/nand/raw/nand_base.c: 4969 in nand_scan_tail()
4963            /*
4964             * Check ECC mode, default to software if
3byte/512byte hardware ECC is
4965             * selected and we have 256 byte pagesize fallback to
software ECC
4966             */
4967
4968            switch (ecc->mode) {
>>>     CID 477207:  Control flow issues  (MISSING_BREAK)
>>>     The case for value "NAND_ECC_HW_OOB_FIRST" is not terminated by a "=
break" statement.
4969            case NAND_ECC_HW_OOB_FIRST:
4970                    /* Similar to NAND_ECC_HW, but a separate
read_page handle */
4971                    if (!ecc->calculate || !ecc->correct || !ecc->hwctl=
) {
4972                            pr_warn("No ECC functions supplied;
hardware ECC not possible\n");
4973                            BUG();
4974                    }

** CID 477206:  Memory - illegal accesses  (NEGATIVE_RETURNS)
/common/cli_hush_upstream.c: 5544 in parse_dollar()


___________________________________________________________________________=
_____________________________
*** CID 477206:  Memory - illegal accesses  (NEGATIVE_RETURNS)
/common/cli_hush_upstream.c: 5544 in parse_dollar()
5538                             * So, we need to authorize # to appear ins=
ide
5539                             * variable name and then expand this varia=
ble.
5540                             * NOTE Having # in variable name is
not permitted in
5541                             * upstream hush but expansion will be
done (even though
5542                             * the result will be empty).
5543                             */
>>>     CID 477206:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>>>     Using variable "ch" as an index to array "_ctype".
5544                            if (!isalnum(ch) && ch !=3D '_' && ch !=3D =
'#') {
5545     #endif /* __U_BOOT__ */
5546                                    unsigned end_ch;
5547     #ifndef __U_BOOT__
5548                                    unsigned char last_ch;
5549     #endif /* !__U_BOOT__ */

** CID 477205:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/cmd/mtd.c: 88 in mtd_dump_device_buf()


___________________________________________________________________________=
_____________________________
*** CID 477205:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/cmd/mtd.c: 88 in mtd_dump_device_buf()
82                      printf("\nDump %d data bytes from 0x%08llx:\n",
83                             mtd->writesize, start_off + data_off);
84                      mtd_dump_buf(&buf[data_off],
85                                   mtd->writesize, start_off + data_off);
86
87                      if (woob) {
>>>     CID 477205:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "page * mtd->oobsize" with type =
"unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic, an=
d then used in a context that expects an expression of type "u64" (64 bits,=
 unsigned).
88                              u64 oob_off =3D page * mtd->oobsize;
89
90                              printf("Dump %d OOB bytes from page at
0x%08llx:\n",
91                                     mtd->oobsize, start_off + data_off);
92                              mtd_dump_buf(&buf[len + oob_off],
93                                           mtd->oobsize, 0);

** CID 477204:  Memory - illegal accesses  (STRING_NULL)
/common/cli_hush_upstream.c: 10553 in run_list()


___________________________________________________________________________=
_____________________________
*** CID 477204:  Memory - illegal accesses  (STRING_NULL)
/common/cli_hush_upstream.c: 10553 in run_list()
10547                           /* We cannot use xasprintf, so we emulate i=
t. */
10548                           char *full_var;
10549                           char *var =3D pi->cmds[0].argv[0];
10550                           char *val =3D *for_lcur++;
10551
10552                           /* + 1 to take into account =3D. */
>>>     CID 477204:  Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "val" to "strlen", which expects a null=
-terminated string. [Note: The source code implementation of the function h=
as been overridden by a builtin model.]
10553                           full_var =3D xmalloc(strlen(var) +
strlen(val) + 1);
10554                           sprintf(full_var, "%s=3D%s", var, val);
10555
10556                           set_local_var_modern(full_var, /*flag:*/ 0);
10557     #endif /* __U_BOOT__ */
10558                           continue;

** CID 477203:    (UNINIT)
/boot/bootm.c: 705 in bootm_load_os()
/boot/bootm.c: 713 in bootm_load_os()


___________________________________________________________________________=
_____________________________
*** CID 477203:    (UNINIT)
/boot/bootm.c: 705 in bootm_load_os()
699                             printf("Failed to prep arm64 kernel
(err=3D%d)\n", ret);
700                             return BOOTM_ERR_RESET;
701                     }
702
703                     /* Handle BOOTM_STATE_LOADOS */
704                     if (relocated_addr !=3D load) {
>>>     CID 477203:    (UNINIT)
>>>     Using uninitialized value "image_size".
705                             printf("Moving Image from 0x%lx to
0x%lx, end=3D%lx\n",
706                                    load, relocated_addr,
707                                    relocated_addr + image_size);
708                             memmove((void *)relocated_addr,
load_buf, image_size);
709                     }
710
/boot/bootm.c: 713 in bootm_load_os()
707                                    relocated_addr + image_size);
708                             memmove((void *)relocated_addr,
load_buf, image_size);
709                     }
710
711                     images->ep =3D relocated_addr;
712                     images->os.start =3D relocated_addr;
>>>     CID 477203:    (UNINIT)
>>>     Using uninitialized value "image_size".
713                     images->os.end =3D relocated_addr + image_size;
714             }
715
716             lmb_reserve(&images->lmb, images->os.load, (load_end -
717                                                         images->os.load=
));
718             return 0;

** CID 477202:  Null pointer dereferences  (FORWARD_NULL)


___________________________________________________________________________=
_____________________________
*** CID 477202:  Null pointer dereferences  (FORWARD_NULL)
/common/cli_hush_upstream.c: 4425 in reserved_word()
4419                     * with "if " remaining in old->as_string!
4420                     */
4421                    {
4422                            char *str;
4423                            int len =3D old->as_string.length;
4424                            /* Concatenate halves */
>>>     CID 477202:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "ctx->as_string.data" to "o_addstr", which der=
eferences it.
4425                            o_addstr(&old->as_string, ctx->as_string.da=
ta);
4426                            o_free(&ctx->as_string);
4427                            /* Find where leading keyword starts
in first half */
4428                            str =3D old->as_string.data + len;
4429                            if (str > old->as_string.data)
4430                                    str--; /* skip whitespace
after keyword */

** CID 477201:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/cmd/mtd.c: 80 in mtd_dump_device_buf()


___________________________________________________________________________=
_____________________________
*** CID 477201:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/cmd/mtd.c: 80 in mtd_dump_device_buf()
74              mtd->type =3D=3D MTD_MLCNANDFLASH;
75      int npages =3D mtd_len_to_pages(mtd, len);
76      uint page;
77
78      if (has_pages) {
79              for (page =3D 0; page < npages; page++) {
>>>     CID 477201:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "page * mtd->writesize" with typ=
e "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic, =
and then used in a context that expects an expression of type "u64" (64 bit=
s, unsigned).
80                      u64 data_off =3D page * mtd->writesize;
81
82                      printf("\nDump %d data bytes from 0x%08llx:\n",
83                             mtd->writesize, start_off + data_off);
84                      mtd_dump_buf(&buf[data_off],
85                                   mtd->writesize, start_off + data_off);

** CID 477200:  Security best practices violations  (STRING_OVERFLOW)
/boot/bootm.c: 499 in bootm_find_images()


___________________________________________________________________________=
_____________________________
*** CID 477200:  Security best practices violations  (STRING_OVERFLOW)
/boot/bootm.c: 499 in bootm_find_images()
493             int ret;
494
495             if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE)) {
496                     /* Look for an Android boot image */
497                     buf =3D map_sysmem(images.os.start, 0);
498                     if (buf && genimg_get_format(buf) =3D=3D
IMAGE_FORMAT_ANDROID) {
>>>     CID 477200:  Security best practices violations  (STRING_OVERFLOW)
>>>     You might overrun the 17-character fixed-size string "addr_str" by =
copying the return value of "simple_xtoa" without checking the length.
499                             strcpy(addr_str, simple_xtoa(img_addr));
500                             select =3D addr_str;
501                     }
502             }
503
504             if (conf_ramdisk)

** CID 477199:    (STRING_NULL)


___________________________________________________________________________=
_____________________________
*** CID 477199:    (STRING_NULL)
/common/cli_hush_upstream.c: 10315 in run_pipe()
10309                   if (cmd_no < pi->num_cmds)
10310                           close(pipefds.wr);
10311                   /* Pass read (output) pipe end to next iteration */
10312                   next_infd =3D pipefds.rd;
10313     #else /* __U_BOOT__ */
10314                   /* Process the command */
>>>     CID 477199:    (STRING_NULL)
>>>     Passing unterminated string "*command->argv" to "cmd_process", whic=
h expects a null-terminated string.
10315                   rcode =3D cmd_process(G.do_repeat ? CMD_FLAG_REPEAT=
 : 0,
10316                                       command->argc, command->argv,
10317                                       &(G.flag_repeat), NULL);
10318
10319                   if (argv_expanded) {
10320                           /*
/common/cli_hush_upstream.c: 9984 in run_pipe()
9978                                    }
9979     #endif
9980                                    debug_printf_env("set shell
var:'%s'->'%s'\n", *argv, p);
9981     #ifndef __U_BOOT__
9982                                    if (set_local_var0(p)) {
9983     #else /* __U_BOOT__ */
>>>     CID 477199:    (STRING_NULL)
>>>     Passing unterminated string "p" to "set_local_var_modern", which ex=
pects a null-terminated string.
9984                                    if (set_local_var_modern(p,
/*flag:*/ 0)) {
9985     #endif
9986                                            /* assignment to
readonly var / putenv error? */
9987                                            rcode =3D 1;
9988                                    }
9989                                    i++;

** CID 477198:  Control flow issues  (DEADCODE)
/cmd/bootflow.c: 547 in do_bootflow_cmdline()


___________________________________________________________________________=
_____________________________
*** CID 477198:  Control flow issues  (DEADCODE)
/cmd/bootflow.c: 547 in do_bootflow_cmdline()
541             }
542
543             op =3D argv[1];
544             arg =3D argv[2];
545             if (*op =3D=3D 's') {
546                     if (argc < 3)
>>>     CID 477198:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return CMD_RET_USAGE;".
547                             return CMD_RET_USAGE;
548                     val =3D argv[3] ?: (const char *)BOOTFLOWCL_EMPTY;
549             }
550
551             switch (*op) {
552             case 'c':       /* clear */


--=20
Tom

--MGg6rIm29ORZe3Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWcNKIACgkQFHw5/5Y0
tyy3qQwAgjBfTyMvAIWOTyK61I8sMYmkAUu2Bdr9GLnKbZoDFPoESPAeH56YCaRM
g9LB1DE6MCRn7hTCn/wUCRReMRrsOrVAmt4HL74XYaL73Z/LKJ6w2WTcvv7TKNGD
ph89LQsaBSJqq9DD4Kn70LAhMNdiQBMurImKYnO4hOzvT/GzumVpGdDIumYv+qz2
OMKweYmX4mITVYWDVyxteHVUgWRTHwLam3gyoXKnxWnakGFgDYHPfKAYRNxsXX26
s9gXEql/lFlEafqFZbsb22IWb6GaDPapRc0JQ5AzgdEQEmFrtURvEHm5GnBScy9r
ZX1RNfIiclSSDsRKkcvWy7Bxj4y5CRQs6ZKQzAGzsABiHYroXEtD6YP9Zc85FVnW
7EeTAUTmL6OAGU1tXcL35UdxE52BmPy/SHyjHukac2xtrmUAv6j6aYXodA8/HPPN
qrOjBmZ45OI6UdWwgBjj9M6lB6kWlm5wPoqpKDPJ2Od/82j8pGMgamNJHmgyg9db
L2zraSi6
=CNib
-----END PGP SIGNATURE-----

--MGg6rIm29ORZe3Eo--
