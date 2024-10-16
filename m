Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4809FD20696
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 03:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447EE88D14;
	Wed, 16 Oct 2024 05:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KC32aoEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 797DD88B9F; Wed, 16 Oct 2024 05:47:34 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A543C82BA7
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 05:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46090640f0cso1954921cf.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 20:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729050450; x=1729655250; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nJPTb3UipqtRnRiSccbYYZEytppHryhyr0pTcTUuO4E=;
 b=KC32aoEFbSdrLE8k6wQiiYSQSkWv2+e36u1IuL95ZuoHpXmr1gnhMVted9hFO3FLzc
 Mg473jGN/4jEr8fTDcyuO1RPAzMLR6HrxZd8Kv6SiktmyPH1rAqBNtDEnxajFRhUnlR5
 +yqrCv7G6yf6XQNvEpn5x8DXbzxN1BHylNhJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729050450; x=1729655250;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJPTb3UipqtRnRiSccbYYZEytppHryhyr0pTcTUuO4E=;
 b=wzvBGrsEagPJZLf++/e98WaZZJR0Mj7TnlAeKZiKeJ/CSzSDZOlHrZiBuldoNj6/HL
 7eYR1TGgqUmKhYFCjBg3XgQkAr0vfrKdk/0uswcQCxEdYiXv0bdA7K/L5Tum3JHZZUof
 bT59erniHUNVbP9M4nHOC0BL57IA6OsD0rdmf3tSxSkHI/Fc7tqFzTos71F8uFwN0QkD
 RnYpvYYbnUNQN2d3EzIOHNaRAblaYse6rIYUV5G5oDTUcGXwGt/eQ+OtaJTAKp58DkAX
 nTj58oyRfSrQlmNpCBp8jUuVYmL/HCBDZhV7sJmtlLuUJCjZ092uVXOZc4lbcEb8wLFw
 wGaQ==
X-Gm-Message-State: AOJu0Yw1KV6M350SnGC0bAnBWxhPVr4PGOMRziG+kEOI1x7pIQaVaaE/
 wqLLADuE2I8UbJISZWlerMv+dxX+5DtjKSCUj7Ew6oLefqoe+ZhCSZMGSbV0NWmfb667XbD5Nuk
 PE2o=
X-Google-Smtp-Source: AGHT+IGURrfYlq0TFs8qHLe+hh/kkDZPCbbC3MubyJIXCq2p6NNb30aAsA26ZSf8jLxXJ54FSZNJtA==
X-Received: by 2002:ac8:7d0e:0:b0:45b:5e8d:981e with SMTP id
 d75a77b69052e-460584f27ebmr251906511cf.54.1729050450410; 
 Tue, 15 Oct 2024 20:47:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607b0e6a38sm12935851cf.37.2024.10.15.20.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 20:47:29 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:47:25 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Joakim Tjernlund <joakim.tjernlund@infinera.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20241016034725.GD6412@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EqTtKazffBUnqLbP"
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


--EqTtKazffBUnqLbP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all, here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Tue, Oct 15, 2024 at 5:06=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

22 new defect(s) introduced to Das U-Boot found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 20 of 22 defect(s)


** CID 510813:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1652 in spi_nor_read()


___________________________________________________________________________=
_____________________________
*** CID 510813:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1652 in spi_nor_read()
1646                            goto read_err;
1647                    }
1648                    if (ret < 0)
1649                            goto read_err;
1650
1651                    if (is_ofst_odd =3D=3D true) {
>>>     CID 510813:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "memmove(buf, buf + 1, len -=
=2E..".
1652                            memmove(buf, (buf + 1), (len - 1));
1653                            *retlen +=3D (ret - 1);
1654                            buf +=3D ret - 1;
1655                            is_ofst_odd =3D false;
1656                    } else {
1657                            *retlen +=3D ret;

** CID 510812:    (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 3573 in spi_nor_select_erase()
/drivers/mtd/spi/spi-nor-core.c: 3584 in spi_nor_select_erase()
/drivers/mtd/spi/spi-nor-core.c: 3610 in spi_nor_select_erase()
/drivers/mtd/spi/spi-nor-core.c: 3597 in spi_nor_select_erase()


___________________________________________________________________________=
_____________________________
*** CID 510812:    (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 3573 in spi_nor_select_erase()
3567                    /*
3568                     * In parallel-memories the erase operation is
3569                     * performed on both the flashes simultaneously
3570                     * so, double the erasesize.
3571                     */
3572                    if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510812:    (DEADCODE)
>>>     Execution cannot reach this statement: "mtd->erasesize =3D 8192U;".
3573                            mtd->erasesize =3D 4096 * 2;
3574                    else
3575                            mtd->erasesize =3D 4096;
3576            } else if (info->flags & SECT_4K_PMC) {
3577                    nor->erase_opcode =3D SPINOR_OP_BE_4K_PMC;
3578                    /*
/drivers/mtd/spi/spi-nor-core.c: 3584 in spi_nor_select_erase()
3578                    /*
3579                     * In parallel-memories the erase operation is
3580                     * performed on both the flashes simultaneously
3581                     * so, double the erasesize.
3582                     */
3583                    if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510812:    (DEADCODE)
>>>     Execution cannot reach this statement: "mtd->erasesize =3D 8192U;".
3584                            mtd->erasesize =3D 4096 * 2;
3585                    else
3586                            mtd->erasesize =3D 4096;
3587            } else
3588     #endif
3589            {
/drivers/mtd/spi/spi-nor-core.c: 3610 in spi_nor_select_erase()
3604                    /*
3605                     * In parallel-memories the erase operation is
3606                     * performed on both the flashes simultaneously
3607                     * so, double the erasesize.
3608                     */
3609                    if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510812:    (DEADCODE)
>>>     Execution cannot reach this statement: "mtd->erasesize =3D 8192U;".
3610                            mtd->erasesize =3D 4096 * 2;
3611                    else
3612                            mtd->erasesize =3D 4096;
3613            }
3614
3615            return 0;
/drivers/mtd/spi/spi-nor-core.c: 3597 in spi_nor_select_erase()
3591                    /*
3592                     * In parallel-memories the erase operation is
3593                     * performed on both the flashes simultaneously
3594                     * so, double the erasesize.
3595                     */
3596                    if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510812:    (DEADCODE)
>>>     Execution cannot reach this statement: "mtd->erasesize =3D info->se=
ct...".
3597                            mtd->erasesize =3D info->sector_size * 2;
3598                    else
3599                            mtd->erasesize =3D info->sector_size;
3600            }
3601
3602            if ((JEDEC_MFR(info) =3D=3D SNOR_MFR_SST) && info->flags &
SECT_4K) {

** CID 510811:    (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1134 in spi_nor_erase()
/drivers/mtd/spi/spi-nor-core.c: 1137 in spi_nor_erase()


___________________________________________________________________________=
_____________________________
*** CID 510811:    (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1134 in spi_nor_erase()
1128                            addr_known =3D false;
1129                            ret =3D -EINTR;
1130                            goto erase_err;
1131                    }
1132                    offset =3D addr;
1133                    if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510811:    (DEADCODE)
>>>     Execution cannot reach this statement: "offset /=3D 2U;".
1134                            offset /=3D 2;
1135
1136                    if (nor->flags & SNOR_F_HAS_STACKED) {
1137                            if (offset >=3D (mtd->size / 2)) {
1138                                    offset =3D offset - (mtd->size / 2);
1139                                    nor->spi->flags |=3D SPI_XFER_U_PAG=
E;
/drivers/mtd/spi/spi-nor-core.c: 1137 in spi_nor_erase()
1131                    }
1132                    offset =3D addr;
1133                    if (nor->flags & SNOR_F_HAS_PARALLEL)
1134                            offset /=3D 2;
1135
1136                    if (nor->flags & SNOR_F_HAS_STACKED) {
>>>     CID 510811:    (DEADCODE)
>>>     Execution cannot reach this statement: "if (offset >=3D mtd->size /=
 2...".
1137                            if (offset >=3D (mtd->size / 2)) {
1138                                    offset =3D offset - (mtd->size / 2);
1139                                    nor->spi->flags |=3D SPI_XFER_U_PAG=
E;
1140                            } else {
1141                                    nor->spi->flags &=3D ~SPI_XFER_U_PA=
GE;
1142                            }

** CID 510810:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1556 in spi_nor_read_id()


___________________________________________________________________________=
_____________________________
*** CID 510810:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1556 in spi_nor_read_id()
1550     {
1551            int                     tmp;
1552            u8                      id[SPI_NOR_MAX_ID_LEN];
1553            const struct flash_info *info;
1554
1555            if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510810:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "nor->spi->flags |=3D 0x100;=
".
1556                    nor->spi->flags |=3D SPI_XFER_LOWER;
1557
1558            tmp =3D nor->read_reg(nor, SPINOR_OP_RDID, id,
SPI_NOR_MAX_ID_LEN);
1559            if (tmp < 0) {
1560                    dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tm=
p);
1561                    return ERR_PTR(tmp);

** CID 510809:  Resource leaks  (RESOURCE_LEAK)
/lib/mbedtls/pkcs7_parser.c: 385 in x509_populate_sinfo()


___________________________________________________________________________=
_____________________________
*** CID 510809:  Resource leaks  (RESOURCE_LEAK)
/lib/mbedtls/pkcs7_parser.c: 385 in x509_populate_sinfo()
379                                   signed_info);
380             if (ret)
381                     goto out_err_sinfo;
382
383     no_authattrs:
384             *sinfo =3D signed_info;
>>>     CID 510809:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "mctx" going out of scope leaks the storage it points to.
385             return 0;
386
387     out_err_sinfo:
388             pkcs7_free_sinfo_mbedtls_ctx(mctx);
389     out_no_mctx:
390             public_key_signature_free(s);

** CID 510808:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 724 in spi_nor_set_4byte_opcodes()


___________________________________________________________________________=
_____________________________
*** CID 510808:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 724 in spi_nor_set_4byte_opcodes()
718     static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
719                                           const struct flash_info *info)
720     {
721             bool shift =3D 0;
722
723             if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510808:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "shift =3D true;".
724                     shift =3D 1;
725
726             /* Do some manufacturer fixups first */
727             switch (JEDEC_MFR(info)) {
728             case SNOR_MFR_SPANSION:
729                     /* No small sector erase for 4-byte command set */

** CID 510807:  Control flow issues  (DEADCODE)
/lib/mbedtls/external/mbedtls/library/x509_crt.c: 2750 in x509_inet_pton_ip=
v6()


___________________________________________________________________________=
_____________________________
*** CID 510807:  Control flow issues  (DEADCODE)
/lib/mbedtls/external/mbedtls/library/x509_crt.c: 2750 in x509_inet_pton_ip=
v6()
2744                 MBEDTLS_PUT_UINT16_BE(group, addr, nonzero_groups);
2745                 nonzero_groups++;
2746                 if (*p =3D=3D '\0') {
2747                     break;
2748                 } else if (*p =3D=3D '.') {
2749                     /* Don't accept IPv4 too early or late */
>>>     CID 510807:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "zero_group_start =3D=3D -1" =
inside this statement: "if ((nonzero_groups =3D=3D 0 &&...".
2750                     if ((nonzero_groups =3D=3D 0 && zero_group_start =
=3D=3D -1) ||
2751                         nonzero_groups >=3D 7) {
2752                         break;
2753                     }
2754
2755                     /* Walk back to prior ':', then parse as IPv4-mapp=
ed */

** CID 510806:  Control flow issues  (DEADCODE)
/lib/mbedtls/pkcs7_parser.c: 209 in authattrs_parse()


___________________________________________________________________________=
_____________________________
*** CID 510806:  Control flow issues  (DEADCODE)
/lib/mbedtls/pkcs7_parser.c: 209 in authattrs_parse()
203                                     return -EINVAL;
204                     }
205
206                     p +=3D seq_len;
207             }
208
>>>     CID 510806:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "ret !=3D -96" inside this st=
atement: "if (ret && ret !=3D -96)
  re...".
209             if (ret && ret !=3D  MBEDTLS_ERR_ASN1_OUT_OF_DATA)
210                     return ret;
211
212             msg->have_authattrs =3D true;
213
214             /*

** CID 510805:  Memory - illegal accesses  (OVERRUN)
/lib/rsa/rsa-keyprop.c: 678 in rsa_gen_key_prop()


___________________________________________________________________________=
_____________________________
*** CID 510805:  Memory - illegal accesses  (OVERRUN)
/lib/rsa/rsa-keyprop.c: 678 in rsa_gen_key_prop()
672             (*prop)->num_bits =3D (rsa_key.n_sz - i) * 8;
673             (*prop)->modulus =3D malloc(rsa_key.n_sz - i);
674             if (!(*prop)->modulus) {
675                     ret =3D -ENOMEM;
676                     goto out;
677             }
>>>     CID 510805:  Memory - illegal accesses  (OVERRUN)
>>>     Overrunning dynamic array "rsa_key.n" at offset corresponding to in=
dex variable "i".
678             memcpy((void *)(*prop)->modulus, &rsa_key.n[i],
rsa_key.n_sz - i);
679
680             n =3D calloc(sizeof(uint32_t), 1 + ((*prop)->num_bits >> 5)=
);
681             rr =3D calloc(sizeof(uint32_t), 1 + (((*prop)->num_bits
* 2) >> 5));
682             rrtmp =3D calloc(sizeof(uint32_t), 2 +
(((*prop)->num_bits * 2) >> 5));
683             if (!n || !rr || !rrtmp) {

** CID 510804:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/drivers/mtd/spi/spi-nor-core.c: 1556 in spi_nor_read_id()


___________________________________________________________________________=
_____________________________
*** CID 510804:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/drivers/mtd/spi/spi-nor-core.c: 1556 in spi_nor_read_id()
1550     {
1551            int                     tmp;
1552            u8                      id[SPI_NOR_MAX_ID_LEN];
1553            const struct flash_info *info;
1554
1555            if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510804:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
>>>     In "nor->spi->flags |=3D 256 /* 1 << 8 */", wider "256 /* 1 << 8 */=
" has high-order bits (0x100) that don't affect the narrower left-hand side.
1556                    nor->spi->flags |=3D SPI_XFER_LOWER;
1557
1558            tmp =3D nor->read_reg(nor, SPINOR_OP_RDID, id,
SPI_NOR_MAX_ID_LEN);
1559            if (tmp < 0) {
1560                    dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tm=
p);
1561                    return ERR_PTR(tmp);

** CID 510803:  Code maintainability issues  (UNUSED_VALUE)
/drivers/mtd/spi/spi-nor-core.c: 1138 in spi_nor_erase()


___________________________________________________________________________=
_____________________________
*** CID 510803:  Code maintainability issues  (UNUSED_VALUE)
/drivers/mtd/spi/spi-nor-core.c: 1138 in spi_nor_erase()
1132                    offset =3D addr;
1133                    if (nor->flags & SNOR_F_HAS_PARALLEL)
1134                            offset /=3D 2;
1135
1136                    if (nor->flags & SNOR_F_HAS_STACKED) {
1137                            if (offset >=3D (mtd->size / 2)) {
>>>     CID 510803:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "offset - mtd->size / 2ULL" to "offset" here, =
but that stored value is overwritten before it can be used.
1138                                    offset =3D offset - (mtd->size / 2);
1139                                    nor->spi->flags |=3D SPI_XFER_U_PAG=
E;
1140                            } else {
1141                                    nor->spi->flags &=3D ~SPI_XFER_U_PA=
GE;
1142                            }
1143                    }

** CID 510802:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 504 in read_sr()


___________________________________________________________________________=
_____________________________
*** CID 510802:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 504 in read_sr()
498              * discard the second byte.
499              */
500             if (spi_nor_protocol_is_dtr(nor->reg_proto))
501                     op.data.nbytes =3D 2;
502
503             if (nor->flags & SNOR_F_HAS_PARALLEL) {
>>>     CID 510802:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "op.data.nbytes =3D 2U;".
504                     op.data.nbytes =3D 2;
505                     ret =3D spi_nor_read_write_reg(nor, &op, &val[0]);
506                     if (ret < 0) {
507                             pr_debug("error %d reading SR\n", (int)ret);
508                             return ret;
509                     }

** CID 510801:  Null pointer dereferences  (FORWARD_NULL)


___________________________________________________________________________=
_____________________________
*** CID 510801:  Null pointer dereferences  (FORWARD_NULL)
/lib/ecdsa/ecdsa-libcrypto.c: 365 in ecdsa_add_verify_data()
359             struct signer ctx;
360             int ret;
361
362             fdt_key_name =3D info->keyname ? info->keyname : "default-k=
ey";
363             ret =3D prepare_ctx(&ctx, info);
364             if (ret >=3D 0) {
>>>     CID 510801:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing "info" to "do_add", which dereferences null "info->keyname".
365                     ret =3D do_add(&ctx, fdt, fdt_key_name, info);
366                     if (ret < 0)
367                             ret =3D ret =3D=3D -FDT_ERR_NOSPACE ? -ENOS=
PC : -EIO;
368             }
369
370             free_ctx(&ctx);
371             return ret;

** CID 510800:    (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1620 in spi_nor_read()
/drivers/mtd/spi/spi-nor-core.c: 1590 in spi_nor_read()
/drivers/mtd/spi/spi-nor-core.c: 1611 in spi_nor_read()
/drivers/mtd/spi/spi-nor-core.c: 1600 in spi_nor_read()


___________________________________________________________________________=
_____________________________
*** CID 510800:    (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1620 in spi_nor_read()
1614                            } else {
1615                                    nor->spi->flags &=3D ~SPI_XFER_U_PA=
GE;
1616                            }
1617                    }
1618
1619                    if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510800:    (DEADCODE)
>>>     Execution cannot reach this statement: "offset /=3D 2LL;".
1620                            offset /=3D 2;
1621
1622                    if (nor->addr_width =3D=3D 3) {
1623     #ifdef CONFIG_SPI_FLASH_BAR
1624                            ret =3D write_bar(nor, offset);
1625                            if (ret < 0)
/drivers/mtd/spi/spi-nor-core.c: 1590 in spi_nor_read()
1584            u32 rem_bank_len =3D 0;
1585            u8 bank;
1586            bool is_ofst_odd =3D false;
1587
1588            dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
1589
>>>     CID 510800:    (DEADCODE)
>>>     Execution cannot reach the expression "offset & 1LL" inside this st=
atement: "if (nor->flags & SNOR_F_HAS...".
1590            if ((nor->flags & SNOR_F_HAS_PARALLEL) && (offset & 1)) {
1591                /* We can hit this case when we use file system
like ubifs */
1592                    from--;
1593                    len++;
1594                    is_ofst_odd =3D true;
1595            }
/drivers/mtd/spi/spi-nor-core.c: 1611 in spi_nor_read()
1605                                    rem_bank_len =3D (SZ_16M * (bank
+ 1)) - from;
1606                            }
1607                    }
1608                    offset =3D from;
1609
1610                    if (nor->flags & SNOR_F_HAS_STACKED) {
>>>     CID 510800:    (DEADCODE)
>>>     Execution cannot reach this statement: "if (offset >=3D mtd->size /=
 2...".
1611                            if (offset >=3D (mtd->size / 2)) {
1612                                    offset =3D offset - (mtd->size / 2);
1613                                    nor->spi->flags |=3D SPI_XFER_U_PAG=
E;
1614                            } else {
1615                                    nor->spi->flags &=3D ~SPI_XFER_U_PA=
GE;
1616                            }
/drivers/mtd/spi/spi-nor-core.c: 1600 in spi_nor_read()
1594                    is_ofst_odd =3D true;
1595            }
1596
1597            while (len) {
1598                    if (nor->addr_width =3D=3D 3) {
1599                            if (nor->flags & SNOR_F_HAS_PARALLEL) {
>>>     CID 510800:    (DEADCODE)
>>>     Execution cannot reach this statement: "bank =3D (u32)from / 335544=
32U;".
1600                                    bank =3D (u32)from / (SZ_16M << 0x0=
1);
1601                                    rem_bank_len =3D ((SZ_16M << 0x01) *
1602                                            (bank + 1)) - from;
1603                            } else {
1604                                    bank =3D (u32)from / SZ_16M;
1605                                    rem_bank_len =3D (SZ_16M * (bank
+ 1)) - from;

** CID 510799:    (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1971 in spi_nor_write()
/drivers/mtd/spi/spi-nor-core.c: 2007 in spi_nor_write()
/drivers/mtd/spi/spi-nor-core.c: 2004 in spi_nor_write()


___________________________________________________________________________=
_____________________________
*** CID 510799:    (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1971 in spi_nor_write()
1965                    return 0;
1966
1967            /*
1968             * Cannot write to odd offset in parallel mode,
1969             * so write 2 bytes first
1970             */
>>>     CID 510799:    (DEADCODE)
>>>     Execution cannot reach the expression "to & 1LL" inside this statem=
ent: "if (nor->flags & SNOR_F_HAS...".
1971            if ((nor->flags & SNOR_F_HAS_PARALLEL) && (to & 1)) {
1972                    u8 two[2] =3D {0xff, buf[0]};
1973                    size_t local_retlen;
1974
1975                    ret =3D spi_nor_write(mtd, to & ~1, 2,
&local_retlen, two);
1976                    if (ret < 0)
/drivers/mtd/spi/spi-nor-core.c: 2007 in spi_nor_write()
2001                    }
2002                    offset =3D (to + i);
2003                    if (nor->flags & SNOR_F_HAS_PARALLEL)
2004                            offset /=3D 2;
2005
2006                    if (nor->flags & SNOR_F_HAS_STACKED) {
>>>     CID 510799:    (DEADCODE)
>>>     Execution cannot reach this statement: "if (offset >=3D mtd->size /=
 2...".
2007                            if (offset >=3D (mtd->size / 2)) {
2008                                    offset =3D offset - (mtd->size / 2);
2009                                    nor->spi->flags |=3D SPI_XFER_U_PAG=
E;
2010                            } else {
2011                                    nor->spi->flags &=3D ~SPI_XFER_U_PA=
GE;
2012                            }
/drivers/mtd/spi/spi-nor-core.c: 2004 in spi_nor_write()
1998                            u64 aux =3D addr;
1999
2000                            page_offset =3D do_div(aux, nor->page_size);
2001                    }
2002                    offset =3D (to + i);
2003                    if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510799:    (DEADCODE)
>>>     Execution cannot reach this statement: "offset /=3D 2U;".
2004                            offset /=3D 2;
2005
2006                    if (nor->flags & SNOR_F_HAS_STACKED) {
2007                            if (offset >=3D (mtd->size / 2)) {
2008                                    offset =3D offset - (mtd->size / 2);
2009                                    nor->spi->flags |=3D SPI_XFER_U_PAG=
E;

** CID 510798:  Resource leaks  (RESOURCE_LEAK)
/lib/mbedtls/x509_cert_parser.c: 220 in x509_populate_signature_params()


___________________________________________________________________________=
_____________________________
*** CID 510798:  Resource leaks  (RESOURCE_LEAK)
/lib/mbedtls/x509_cert_parser.c: 220 in x509_populate_signature_params()
214             }
215
216             ret =3D hash_calculate(s->hash_algo, &region, 1, s->digest);
217             if (!ret)
218                     *sig =3D s;
219
>>>     CID 510798:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "s" going out of scope leaks the storage it points to.
220             return ret;
221
222     error_sig:
223             public_key_signature_free(s);
224             return ret;
225     }

** CID 510797:    (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 4628 in spi_nor_scan()
/drivers/mtd/spi/spi-nor-core.c: 4598 in spi_nor_scan()


___________________________________________________________________________=
_____________________________
*** CID 510797:    (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 4628 in spi_nor_scan()
4622            /* Send all the required SPI flash commands to
initialize device */
4623            ret =3D spi_nor_init(nor);
4624            if (ret)
4625                    return ret;
4626
4627            if (nor->flags & SNOR_F_HAS_STACKED) {
>>>     CID 510797:    (DEADCODE)
>>>     Execution cannot reach this statement: "nor->spi->flags |=3D 0x10UL=
;".
4628                    nor->spi->flags |=3D SPI_XFER_U_PAGE;
4629                    ret =3D spi_nor_init(nor);
4630                    if (ret)
4631                            return ret;
4632                    nor->spi->flags &=3D ~SPI_XFER_U_PAGE;
4633            }
/drivers/mtd/spi/spi-nor-core.c: 4598 in spi_nor_scan()
4592                    nor->addr_width =3D info->addr_width;
4593            } else {
4594                    nor->addr_width =3D 3;
4595            }
4596
4597            if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED))
>>>     CID 510797:    (DEADCODE)
>>>     Execution cannot reach this statement: "shift =3D true;".
4598                    shift =3D 1;
4599            if (nor->addr_width =3D=3D 3 && (mtd->size >> shift) > SZ_1=
6M) {
4600     #ifndef CONFIG_SPI_FLASH_BAR
4601                    /* enable 4-byte addressing if the device
exceeds 16MiB */
4602                    nor->addr_width =3D 4;
4603                    if (JEDEC_MFR(info) =3D=3D SNOR_MFR_SPANSION ||

** CID 510796:  Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
_____________________________
*** CID 510796:  Insecure data handling  (TAINTED_SCALAR)
/lib/mbedtls/external/mbedtls/library/rsa.c: 1316 in rsa_prepare_blinding()
1310             }
1311
1312             MBEDTLS_MPI_CHK(mbedtls_mpi_fill_random(&ctx->Vf,
ctx->len - 1, f_rng, p_rng));
1313
1314             /* Compute Vf^-1 as R * (R Vf)^-1 to avoid leaks from
inv_mod. */
1315             MBEDTLS_MPI_CHK(mbedtls_mpi_fill_random(&R, ctx->len
- 1, f_rng, p_rng));
>>>     CID 510796:  Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "*ctx->Vf.p" to "mbedtls_mpi_mul_mpi", w=
hich uses it as an offset.
1316             MBEDTLS_MPI_CHK(mbedtls_mpi_mul_mpi(&ctx->Vi, &ctx->Vf, &R=
));
1317             MBEDTLS_MPI_CHK(mbedtls_mpi_mod_mpi(&ctx->Vi,
&ctx->Vi, &ctx->N));
1318
1319             /* At this point, Vi is invertible mod N if and only
if both Vf and R
1320              * are invertible mod N. If one of them isn't, we
don't need to know
1321              * which one, we just loop and choose new values for
both of them.

** CID 510795:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 4271 in spi_nor_init()


___________________________________________________________________________=
_____________________________
*** CID 510795:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 4271 in spi_nor_init()
4265
4266     static int spi_nor_init(struct spi_nor *nor)
4267     {
4268            int err;
4269
4270            if (nor->flags & SNOR_F_HAS_PARALLEL)
>>>     CID 510795:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "nor->spi->flags |=3D 3UL;".
4271                    nor->spi->flags |=3D SPI_NOR_ENABLE_MULTI_CS;
4272
4273            err =3D spi_nor_octal_dtr_enable(nor);
4274            if (err) {
4275                    dev_dbg(nor->dev, "Octal DTR mode not supported\n");
4276                    return err;

** CID 510794:  Control flow issues  (NO_EFFECT)
/lib/mbedtls/x509_cert_parser.c: 78 in x509_populate_dn_name_string()


___________________________________________________________________________=
_____________________________
*** CID 510794:  Control flow issues  (NO_EFFECT)
/lib/mbedtls/x509_cert_parser.c: 78 in x509_populate_dn_name_string()
72      do {
73              name_str =3D kzalloc(len, GFP_KERNEL);
74              if (!name_str)
75                      return NULL;
76
77              wb =3D mbedtls_x509_dn_gets(name_str, len, name);
>>>     CID 510794:  Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. =
"wb < 0UL".
78              if (wb < 0) {
79                      pr_err("Get DN string failed, ret:-0x%04x\n",
80                             (unsigned int)-wb);
81                      kfree(name_str);
82                      len =3D len * 2; /* Try with a bigger buffer */
83              }

----- End forwarded message -----

--=20
Tom

--EqTtKazffBUnqLbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcPN00ACgkQFHw5/5Y0
tyx2fAwArqgXOdRrEkZ24i08hA93B+/xO6j70M+5jHx6FMLUKA+5A6MWR11iCSDS
g6pSRHUb2Oblme3S1DdijAKcNODPDwN0yg+RXUG71hVZLfSEo8Pl9P6AC4sSpArw
JYAD0E4GjI/3K4omd0iOsuopD6c/ABYwnvI2zk5oYopjNeZZEt2zyF0Da6NTGk1a
Jv4BIybshq+PqGMJX7j3fLG66gh9I1tG3Yuf8NZcVFGxf689E7xqTyYtko2AEdOr
vWw61tWnnqCqfmOxF1vLicUhKEfWhJ/k5odHgf2yt1CCNOU36DwAinPjOVHK7gh6
Rx4wGverVyV+gWzZ5RGm6O9w2c3Dj+7h9PV6ks65WwaSCSgR4we5M/Rrzcxac9qo
avEkpPZZrL1/dScbLehXWayuPPJxMTtBfwrLqzEvlxtgGbutJ9/qcuZ2FkmxxBGP
17vvNIGvmL+7mLTOXqVWhC4LlebgJxFgyC0oDnkDs6Gc8qkXODI0K7Ra6HjGC3TP
s+dCts/P
=Px2F
-----END PGP SIGNATURE-----

--EqTtKazffBUnqLbP--
