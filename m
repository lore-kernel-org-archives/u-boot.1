Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E380DC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 05:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7DD1877EC;
	Tue,  9 Jan 2024 06:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVXCVECo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD4B8877F1; Tue,  9 Jan 2024 06:26:18 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20740876FF
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 06:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-783045e88a6so283068485a.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 21:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704777975; x=1705382775; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+EcRHTta+bmfk5CVFVBFRgqqvColORCxn1DFMXh715E=;
 b=dVXCVECoEQCVkjAKvF3I80zYcJm8OTsEi5DH4QSnnDv5/7LLB5Dy8usiAQEwk3vHwW
 unAtE1+BoDoGlXpVScdO7iFGEumMhNzutcjoDyQEly7hnMNGRox6Yp/1RCz6ufS296VF
 pQRjnZA14xnCv/jG2zFIM/iXLX0TVHe41ALuYCdbwSIvV6Qzm9VJ3q2IKpiWkDEdNIR0
 DOhxWuRlo7MO6mVMcXZE/emK1KiO/4oMsCLHbnUugFaAaQGf3dm9P364lAalwvpXYjO7
 0IhXGgr3xumt4vdSmM3DKIVLMyvLnk8PB6SbNIDxF7kz53zFqWOxaewwyXqIAUFnP2Qc
 Vjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704777975; x=1705382775;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+EcRHTta+bmfk5CVFVBFRgqqvColORCxn1DFMXh715E=;
 b=puKWeq6UOYXFc0RLuanD47yW+kezRV23rsknG4xS9i1czwZL0sy229pNRuD4hg+J92
 Z7ApSMezNxakVpvknNWX0bg8790FRlGbI48dtmAf0QEo9Q/dfsLqPSXURdsoKAolqL7K
 XK84tTFN84IhUmxsN+fvhTtbmAUs6UPlIzmAL3AruiInGLwImRSxHIx6xH9vz0azQRdy
 /l0i6uNnuPOBOjwUZqgRg+GIVk3uFJ444G9gcDNmPqr2tqksGhKC9+hk3ZhGiA6TW1W4
 tfwEY+d5euemlwsLXjwQjnIZzNhbnLRaLo7IR2KR6RtDG/3juK+SorMPLHBCaZlxjOnD
 ZJ/A==
X-Gm-Message-State: AOJu0Yzx6NPNPWuAdz7rhTOv1kQyRnunva5gPv54qhNbgzQ7Jq9xJROQ
 olhbs98PH3JjB4lR/9S3FvUxhrl60RzOkA==
X-Google-Smtp-Source: AGHT+IFUzZ3kx21IngL2bmtkJVzf4+TeEVuOc5hJecS9SZrQibpTTb0rhD+Wn9Yvk5ZqrfbSzoAKpg==
X-Received: by 2002:ad4:5bac:0:b0:681:11b9:29c with SMTP id
 12-20020ad45bac000000b0068111b9029cmr1168700qvq.63.1704777974714; 
 Mon, 08 Jan 2024 21:26:14 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 p15-20020a05621421ef00b0067f80dbd535sm602107qvj.8.2024.01.08.21.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 21:26:14 -0800 (PST)
Message-ID: <d873ed4d-25df-5ba0-67b3-c104d9da229d@gmail.com>
Date: Tue, 9 Jan 2024 00:26:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Francis Laniel <francis.laniel@amarulasolutions.com>
References: <20240108174506.GL1610741@bill-the-cat>
From: Sean Anderson <seanga2@gmail.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240108174506.GL1610741@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Comments on NAND stuff only.

On 1/8/24 12:45, Tom Rini wrote:
> ________________________________________________________________________________________________________
> *** CID 477216:    (BAD_SHIFT)
> /drivers/mtd/nand/raw/nand_base.c: 3921 in nand_flash_detect_onfi()
> 3915
> 3916            /*
> 3917             * pages_per_block and blocks_per_lun may not be a
> power-of-2 size
> 3918             * (don't ask me who thought of this...). MTD assumes that these
> 3919             * dimensions will be power-of-2, so just truncate the
> remaining area.
> 3920             */
>>>>      CID 477216:    (BAD_SHIFT)
>>>>      In expression "1 << generic_fls((__u32)(__le32)p->pages_per_block) - 1", shifting by a negative amount has undefined behavior.  The shift amount, "generic_fls((__u32)(__le32)p->pages_per_block) - 1", is -1.
> 3921            mtd->erasesize = 1 <<
> (fls(le32_to_cpu(p->pages_per_block)) - 1);
> 3922            mtd->erasesize *= mtd->writesize;
> 3923
> 3924            mtd->oobsize = le16_to_cpu(p->spare_bytes_per_page);
> 3925
> 3926            /* See erasesize comment */
> /drivers/mtd/nand/raw/nand_base.c: 3927 in nand_flash_detect_onfi()
> 3921            mtd->erasesize = 1 <<
> (fls(le32_to_cpu(p->pages_per_block)) - 1);
> 3922            mtd->erasesize *= mtd->writesize;
> 3923
> 3924            mtd->oobsize = le16_to_cpu(p->spare_bytes_per_page);
> 3925
> 3926            /* See erasesize comment */
>>>>      CID 477216:    (BAD_SHIFT)
>>>>      In expression "1 << generic_fls((__u32)(__le32)p->blocks_per_lun) - 1", shifting by a negative amount has undefined behavior.  The shift amount, "generic_fls((__u32)(__le32)p->blocks_per_lun) - 1", is -1.
> 3927            chip->chipsize = 1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
> 3928            chip->chipsize *= (uint64_t)mtd->erasesize * p->lun_count;
> 3929            chip->bits_per_cell = p->bits_per_cell;
> 3930
> 3931            if (onfi_feature(chip) & ONFI_FEATURE_16_BIT_BUS)
> 3932                    chip->options |= NAND_BUSWIDTH_16;

Yeah, this looks like a bug.

> ** CID 477215:  Control flow issues  (MISSING_BREAK)
> /drivers/mtd/nand/raw/nand_base.c: 4978 in nand_scan_tail()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 477215:  Control flow issues  (MISSING_BREAK)
> /drivers/mtd/nand/raw/nand_base.c: 4978 in nand_scan_tail()
> 4972                            pr_warn("No ECC functions supplied;
> hardware ECC not possible\n");
> 4973                            BUG();
> 4974                    }
> 4975                    if (!ecc->read_page)
> 4976                            ecc->read_page = nand_read_page_hwecc_oob_first;
> 4977
>>>>      CID 477215:  Control flow issues  (MISSING_BREAK)
>>>>      The case for value "NAND_ECC_HW" is not terminated by a "break" statement.
> 4978            case NAND_ECC_HW:
> 4979                    /* Use standard hwecc read page function? */
> 4980                    if (!ecc->read_page)
> 4981                            ecc->read_page = nand_read_page_hwecc;
> 4982                    if (!ecc->write_page)
> 4983                            ecc->write_page = nand_write_page_hwecc;

I think we just need a fallthrough comment here.

> ** CID 477214:  Integer handling issues  (BAD_SHIFT)
> /drivers/mtd/nand/raw/nand_base.c: 4397 in nand_detect()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 477214:  Integer handling issues  (BAD_SHIFT)
> /drivers/mtd/nand/raw/nand_base.c: 4397 in nand_detect()
> 4391
> 4392            nand_decode_bbm_options(mtd, chip);
> 4393
> 4394            /* Calculate the address shift from the page size */
> 4395            chip->page_shift = ffs(mtd->writesize) - 1;
> 4396            /* Convert chipsize to number of pages per chip -1 */
>>>>      CID 477214:  Integer handling issues  (BAD_SHIFT)
>>>>      In expression "chip->chipsize >> chip->page_shift", shifting by a negative amount has undefined behavior.  The shift amount, "chip->page_shift", is -1.
> 4397            chip->pagemask = (chip->chipsize >> chip->page_shift) - 1;
> 4398
> 4399            chip->bbt_erase_shift = chip->phys_erase_shift =
> 4400                    ffs(mtd->erasesize) - 1;
> 4401            if (chip->chipsize & 0xffffffff)
> 4402                    chip->chip_shift = ffs((unsigned)chip->chipsize) - 1;

Buggy, but only when writesize is 0 (which is a bigger bug in the nand chip).

> ** CID 477213:  Security best practices violations  (DC.WEAK_CRYPTO)
> /test/dm/nand.c: 67 in dm_test_nand()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 477213:  Security best practices violations  (DC.WEAK_CRYPTO)
> /test/dm/nand.c: 67 in dm_test_nand()
> 61      ops.ooblen = mtd->oobsize;
> 62      ut_assertok(mtd_read_oob(mtd, mtd->erasesize, &ops));
> 63      ut_asserteq(0, oob[mtd_to_nand(mtd)->badblockpos]);
> 64
> 65      /* Generate some data and write it */
> 66      for (i = 0; i < size / sizeof(int); i++)
>>>>      CID 477213:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>>      "rand" should not be used for security-related applications, because linear congruential algorithms are too easy to break.
> 67              gold[i] = rand();
> 68      ut_assertok(nand_write_skip_bad(mtd, off, &length, NULL, U64_MAX,
> 69                                      (void *)gold, 0));
> 70      ut_asserteq(size, length);
> 71
> 72      /* Verify */

Not a bug.

> ** CID 477211:  API usage errors  (ALLOC_FREE_MISMATCH)
> /drivers/mtd/nand/raw/nand_bbt.c: 1133 in nand_scan_bbt()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 477211:  API usage errors  (ALLOC_FREE_MISMATCH)
> /drivers/mtd/nand/raw/nand_bbt.c: 1133 in nand_scan_bbt()
> 1127
> 1128            /* Prevent the bbt regions from erasing / writing */
> 1129            mark_bbt_region(mtd, td);
> 1130            if (md)
> 1131                    mark_bbt_region(mtd, md);
> 1132
>>>>      CID 477211:  API usage errors  (ALLOC_FREE_MISMATCH)
>>>>      Calling "vfree" frees "buf" using "vfree" but it should have been freed using "kfree". [Note: The source code implementation of the function has been overridden by a builtin model.]
> 1133            vfree(buf);
> 1134            return 0;
> 1135
> 1136     err:
> 1137            kfree(this->bbt);
> 1138            this->bbt = NULL;

Not a bug, since these both call free().

> ** CID 477210:  Security best practices violations  (DC.WEAK_CRYPTO)
> /drivers/mtd/nand/raw/sand_nand.c: 199 in sand_nand_read()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 477210:  Security best practices violations  (DC.WEAK_CRYPTO)
> /drivers/mtd/nand/raw/sand_nand.c: 199 in sand_nand_read()
> 193             chip->tmp_dirty = true;
> 194             for (i = 0; i < chip->err_steps; i++) {
> 195                     u32 bit_errors = chip->err_count;
> 196                     unsigned int j = chip->err_step_bits + chip->ecc_bits;
> 197
> 198                     while (bit_errors) {
>>>>      CID 477210:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>>      "rand" should not be used for security-related applications, because linear congruential algorithms are too easy to break.
> 199                             unsigned int u = rand();
> 200                             float quot = 1ULL << 32;
> 201
> 202                             do {
> 203                                     quot *= j - bit_errors;
> 204                                     quot /= j;

Not a bug.

> ** CID 477207:  Control flow issues  (MISSING_BREAK)
> /drivers/mtd/nand/raw/nand_base.c: 4969 in nand_scan_tail()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 477207:  Control flow issues  (MISSING_BREAK)
> /drivers/mtd/nand/raw/nand_base.c: 4969 in nand_scan_tail()
> 4963            /*
> 4964             * Check ECC mode, default to software if
> 3byte/512byte hardware ECC is
> 4965             * selected and we have 256 byte pagesize fallback to
> software ECC
> 4966             */
> 4967
> 4968            switch (ecc->mode) {
>>>>      CID 477207:  Control flow issues  (MISSING_BREAK)
>>>>      The case for value "NAND_ECC_HW_OOB_FIRST" is not terminated by a "break" statement.
> 4969            case NAND_ECC_HW_OOB_FIRST:
> 4970                    /* Similar to NAND_ECC_HW, but a separate
> read_page handle */
> 4971                    if (!ecc->calculate || !ecc->correct || !ecc->hwctl) {
> 4972                            pr_warn("No ECC functions supplied;
> hardware ECC not possible\n");
> 4973                            BUG();
> 4974                    }

need a fallthrough comment

> ** CID 477205:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
> /cmd/mtd.c: 88 in mtd_dump_device_buf()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 477205:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
> /cmd/mtd.c: 88 in mtd_dump_device_buf()
> 82                      printf("\nDump %d data bytes from 0x%08llx:\n",
> 83                             mtd->writesize, start_off + data_off);
> 84                      mtd_dump_buf(&buf[data_off],
> 85                                   mtd->writesize, start_off + data_off);
> 86
> 87                      if (woob) {
>>>>      CID 477205:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>>      Potentially overflowing expression "page * mtd->oobsize" with type "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "u64" (64 bits, unsigned).
> 88                              u64 oob_off = page * mtd->oobsize;
> 89
> 90                              printf("Dump %d OOB bytes from page at
> 0x%08llx:\n",
> 91                                     mtd->oobsize, start_off + data_off);
> 92                              mtd_dump_buf(&buf[len + oob_off],
> 93                                           mtd->oobsize, 0);

In the Linux MTD list [1], the largest this can be is 0xe0000000 for MT29F512G08CUCAB. That's worryingly
close to overflow, so I'd say this is a bug.

--Sean

[1] http://linux-mtd.infradead.org/nand-data/nanddata.html
