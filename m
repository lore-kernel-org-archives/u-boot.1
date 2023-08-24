Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318C8C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09378650E;
	Thu, 24 Aug 2023 02:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OxE849jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD788652A; Thu, 24 Aug 2023 02:12:11 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38CCF86504
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 02:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O0C3cm044961;
 Wed, 23 Aug 2023 19:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692835923;
 bh=CAMboXDraYgBoN8nzRROpOI0iu40PDTQ72XG0+GkMW8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=OxE849jbf+xBWyoblADRkUQ5+1/IH74/hhXZ1v7yMtQKybVZ/ZD+yXkDpiSgh2ySs
 jVuHU8FxcH9vUYUmXgwDt+m5i9cMKAUuk9Prf3AOrV2Gwy8tBGeoSqDbNS9BMylZ+3
 z40zeeivjh5sAAc8BYZg1fCOaZ8K23f6wI1p0x6E=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O0C38S101268
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 19:12:03 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 19:12:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 19:12:02 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O0C2Pr122802;
 Wed, 23 Aug 2023 19:12:02 -0500
Date: Wed, 23 Aug 2023 19:12:02 -0500
From: Nishanth Menon <nm@ti.com>
To: Hari Nagalla <hnagalla@ti.com>
CC: Enric Balletbo i Serra <eballetb@redhat.com>, <trini@konsulko.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <jh80.chung@samsung.com>,
 <afd@ti.com>, <a-nandan@ti.com>, <u-boot@lists.denx.de>,
 "Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH v2 00/10] Introduce initial TI's J784S4 support
Message-ID: <20230824001202.zg3zzrejah5n5qxh@nearest>
References: <20230321141028.24456-1-hnagalla@ti.com>
 <CALE0LRse=69tbj8g8m0L7FHu=D1MVtzL_pBN3Vm-2eOv3_HtKQ@mail.gmail.com>
 <2e7b6227-c608-790f-0842-0fd8dbf7f2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e7b6227-c608-790f-0842-0fd8dbf7f2c9@ti.com>
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

On 17:09-20230823, Hari Nagalla wrote:
> On 8/22/23 03:18, Enric Balletbo i Serra wrote:
> > > * Temperature sensors, user push buttons and LEDs
> > > * 40-pin User Expansion Connector
> > > * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
> > > * x1 15-pin CSI header
> > > * x6 MCAN instances
> > > 
> > > Schematics:https://www.ti.com/lit/zip/sprr458
> > > 
> > > bootlog:https://paste.sr.ht/~hnagalla/f14840abc854519f912923662f1fdc8075d92107
> > > 
> > Many thanks for this patchset.
> > 
> > There is any plan to rebase all this patchset, fix the comments and
> > send it again to upstream? I'd be really interested in help on this
> > patchset.
> > 
> > Thanks,
> >    Enric
> > 
> Hi Enric,
> 
> Yes, we will rebase and send the patch set shortly.
> 
> Sorry for the delay.

Let us ensure we have the proper cleanups done for other platforms,
documentation AND bootstd support as default.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
