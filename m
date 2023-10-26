Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED40C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2AE387B59;
	Thu, 26 Oct 2023 14:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dFDVTPjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 237A087B4E; Thu, 26 Oct 2023 14:27:20 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC67F87A49
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39QCRDPt066674;
 Thu, 26 Oct 2023 07:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698323233;
 bh=x8A03Dtvugr9iqZPqtK/fset6T/wy+eWQJcZB6FSO9s=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=dFDVTPjBFnT7eD1i+vHS6Gv0GBLZSgro/kMTAlz/Wt/qJBXCxaIZ/3GZsri2Gh76P
 g+AJ1zM/2cWl+lRIKJdn5yE1HtH6TMiX8of6DuRf2R8StplEOaq9YKBCUt9EuTkAFC
 7kjYTphHnBXm36RFEPCp4sTrsKJtSBg/5ZN3Dgig=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39QCRD8v062531
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 26 Oct 2023 07:27:13 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Oct 2023 07:27:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Oct 2023 07:27:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39QCRCir111295;
 Thu, 26 Oct 2023 07:27:13 -0500
Date: Thu, 26 Oct 2023 17:57:12 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <a-nandan@ti.com>,
 <n-francis@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [RESEND PATCH] board: ti: common: board_detect: Fix EEPROM
 offset read for 1-byte
Message-ID: <20231026122711.rnskdy33k6ts4yq5@uda0496754>
References: <20231020070128.28320-1-p-mantena@ti.com>
 <64f98f61-4b54-5bd4-f238-d101f0335b7d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64f98f61-4b54-5bd4-f238-d101f0335b7d@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 26 Oct 2023 14:56:48 +0200
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
> > 
> > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> > Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read quirk for 2-byte)
> Please consider Fixes line, first than Signed-off-by
> 
> 
> Please copy Nishanth in patch as well .
> 
Thanks for the review comments Udit.
Will send a v2 addressing them.

Regards,
Prasanth

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
