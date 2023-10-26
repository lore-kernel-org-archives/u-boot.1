Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4960C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 11:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F03738760E;
	Thu, 26 Oct 2023 13:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jwKkOEBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2276386E02; Thu, 26 Oct 2023 11:10:55 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717FB86BA4
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39Q9An7p021838;
 Thu, 26 Oct 2023 04:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698311449;
 bh=eSD9MsUrIYbt1gv4qy+RzvBXvD2eEwurVLnJdZntIkU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jwKkOEBovyB20N2ErdKOH/l/2+4p8dGZM90t2VlSHyIIwcTFHvdZmo019xWD8Iifo
 sWScV+YArWu0859ULqyDXreYHqLw3KC3X7NqsyMnkjN0Yo5+XaehCSpnzVE8AMj4lU
 cJRv0wRP8Tr+IbOhavpgv1TO8uQdro84CF1n272I=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39Q9AnkP098488
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 26 Oct 2023 04:10:49 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Oct 2023 04:10:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Oct 2023 04:10:48 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39Q9AmFc066501;
 Thu, 26 Oct 2023 04:10:48 -0500
Date: Thu, 26 Oct 2023 14:40:47 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <sjg@chromium.org>, 
 <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <a-nandan@ti.com>, <n-francis@ti.com>
Subject: Re: [RESEND PATCH] board: ti: common: board_detect: Fix EEPROM
 offset read for 1-byte
Message-ID: <20231026091046.ycoomr7qppgmopzi@uda0496754>
References: <20231020070128.28320-1-p-mantena@ti.com>
 <64f98f61-4b54-5bd4-f238-d101f0335b7d@ti.com>
 <20231020180545.hkum2onmfgufubvy@parade>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231020180545.hkum2onmfgufubvy@parade>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 26 Oct 2023 13:57:35 +0200
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

On 13:05-20231020, Nishanth Menon wrote:
> On 20:52-20231020, Kumar, Udit wrote:
> > Thanks Prasanth
> > 
> > On 10/20/2023 12:31 PM, Prasanth Babu Mantena wrote:
> > > EEPROM detection logic in ti_i2c_eeprom_get() involves reading the total
> > > size followed by reading 1-byte size with an offset 1. This commit fixes
> > > the header matching issue in commit 9f393a2d7af8 ("board: ti: common:
> > > board_detect: Fix EEPROM read quirk for 2-byte").
> > You can fixes below as well. I think you can avoid this in commit message
> > > 
> > > In the previous commit, the value with one offset is being read into
> > > offset_test, but the pointer used to match was still ep. After reading
> > > with an offset 1, the second byte of the header is compared with the 1-byte
> > > data read from EEPROM. This is taken care by comparing proper first byte
> > > value from the header.
> > Nice catch
> 
> Yes indeed.. here is a possible improvement of  commit message:
> 
> EEPROM detection logic in ti_i2c_eeprom_get() involves reading the
> total size and the 1-byte size with an offset 1.
> 
> The value with one offset is read into "offset_test," but the pointer
> used to match was still "ep". This results in comparing results
> against the previously read data while the intent is to ensure the
> detection of the bad 2-byte addressing eeproms that get stuck after
> responding initially to 1- byte accesses. This behavior was detected
> on BeagleBone-AI64.
> 
> > > 
> > > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> > > Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read quirk for 2-byte)
> > Please consider Fixes line, first than Signed-off-by
> 
> Yup, fixes and SoB (checkpatch typically warns)
> > 
> > 
> > Please copy Nishanth in patch as well .
> > 
> > > ---
> > > Resending due to incorrect patch tag last time.
> > > 
> > >   board/ti/common/board_detect.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
> > > index 9a53884c98..17fe8f8069 100644
> > > --- a/board/ti/common/board_detect.c
> > > +++ b/board/ti/common/board_detect.c
> > > @@ -128,7 +128,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
> > >   	rc = dm_i2c_read(dev, 0x1, &offset_test, sizeof(offset_test));
> > > -	if (*((u32 *)ep) != (header & 0xFF))
> > > +	if (offset_test != ((header >> 8) & 0xFF))
> > >   		one_byte_addressing = false;
> > >   	/* Corrupted data??? */
> 
> 
> You missed the else CONFIG_IS_ENABLED(DM_I2C)  case with the same
> bug?
> 
> Also please CC Matwey V. Kornilov <matwey.kornilov@gmail.com> ,  Jason
> Kridner <jkridner@beagleboard.org> and Robert Nelson <robertcnelson@gmail.com>
> 
> So that we don't have regressions on their boards.
> 
> https://lore.kernel.org/all/CAJs94Ebdd4foOjhGFu9Bop0v=B1US9neDLxfhgcY23ukgLzFOQ@mail.gmail.com/

Thanks for the comments Nishanth.
Will send a v2 addressing them.

Regards,
Prasanth

> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
