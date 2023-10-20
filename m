Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ED9CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 18:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59316874DC;
	Fri, 20 Oct 2023 20:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TQhgyFIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4405E874DD; Fri, 20 Oct 2023 20:05:53 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2919874DB
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 20:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39KI5jKd001714;
 Fri, 20 Oct 2023 13:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697825145;
 bh=rMW8XW6Z8xZ3NasZzSsfsU1Lt1giq0D1MuxknHxke5Q=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TQhgyFIquRSMdfUQXLOwvbucbafX4wT6MTzWgiv3lXKU0JQFpsDtfLpNIjpYqldUz
 9yQcQJ5YocnlKgohGDzjbam7P16fKuK2Ee3jxSf1avJIlUcY9vWzheknSdw2/ReiTv
 vRi6lS4zHruBrVkGEl1PnWK/9zRqHv0Y6wDvI1Yk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39KI5jow125340
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Oct 2023 13:05:45 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Oct 2023 13:05:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Oct 2023 13:05:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39KI5jPk073462;
 Fri, 20 Oct 2023 13:05:45 -0500
Date: Fri, 20 Oct 2023 13:05:45 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <a-nandan@ti.com>, <n-francis@ti.com>
Subject: Re: [RESEND PATCH] board: ti: common: board_detect: Fix EEPROM
 offset read for 1-byte
Message-ID: <20231020180545.hkum2onmfgufubvy@parade>
References: <20231020070128.28320-1-p-mantena@ti.com>
 <64f98f61-4b54-5bd4-f238-d101f0335b7d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64f98f61-4b54-5bd4-f238-d101f0335b7d@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 20:52-20231020, Kumar, Udit wrote:
> Thanks Prasanth
> 
> On 10/20/2023 12:31 PM, Prasanth Babu Mantena wrote:
> > EEPROM detection logic in ti_i2c_eeprom_get() involves reading the total
> > size followed by reading 1-byte size with an offset 1. This commit fixes
> > the header matching issue in commit 9f393a2d7af8 ("board: ti: common:
> > board_detect: Fix EEPROM read quirk for 2-byte").
> You can fixes below as well. I think you can avoid this in commit message
> > 
> > In the previous commit, the value with one offset is being read into
> > offset_test, but the pointer used to match was still ep. After reading
> > with an offset 1, the second byte of the header is compared with the 1-byte
> > data read from EEPROM. This is taken care by comparing proper first byte
> > value from the header.
> Nice catch

Yes indeed.. here is a possible improvement of  commit message:

EEPROM detection logic in ti_i2c_eeprom_get() involves reading the
total size and the 1-byte size with an offset 1.

The value with one offset is read into "offset_test," but the pointer
used to match was still "ep". This results in comparing results
against the previously read data while the intent is to ensure the
detection of the bad 2-byte addressing eeproms that get stuck after
responding initially to 1- byte accesses. This behavior was detected
on BeagleBone-AI64.

> > 
> > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> > Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read quirk for 2-byte)
> Please consider Fixes line, first than Signed-off-by

Yup, fixes and SoB (checkpatch typically warns)
> 
> 
> Please copy Nishanth in patch as well .
> 
> > ---
> > Resending due to incorrect patch tag last time.
> > 
> >   board/ti/common/board_detect.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
> > index 9a53884c98..17fe8f8069 100644
> > --- a/board/ti/common/board_detect.c
> > +++ b/board/ti/common/board_detect.c
> > @@ -128,7 +128,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
> >   	rc = dm_i2c_read(dev, 0x1, &offset_test, sizeof(offset_test));
> > -	if (*((u32 *)ep) != (header & 0xFF))
> > +	if (offset_test != ((header >> 8) & 0xFF))
> >   		one_byte_addressing = false;
> >   	/* Corrupted data??? */


You missed the else CONFIG_IS_ENABLED(DM_I2C)  case with the same
bug?

Also please CC Matwey V. Kornilov <matwey.kornilov@gmail.com> ,  Jason
Kridner <jkridner@beagleboard.org> and Robert Nelson <robertcnelson@gmail.com>

So that we don't have regressions on their boards.

https://lore.kernel.org/all/CAJs94Ebdd4foOjhGFu9Bop0v=B1US9neDLxfhgcY23ukgLzFOQ@mail.gmail.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
